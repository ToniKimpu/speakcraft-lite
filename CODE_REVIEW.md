# PMP English Mobile — Production Code Review

> Reviewed as a senior staff engineer. Assumes target scale: **100,000 users**.
> Date: 2026-03-05

---

## Table of Contents

1. [🔎 Project Level Assessment](#-project-level-assessment)
2. [🏗 Architecture Review](#-architecture-review)
3. [🚨 Critical Issues](#-critical-issues)
4. [⚠️ Medium Issues](#️-medium-issues)
5. [🧹 Code Smells / Cleanup Suggestions](#-code-smells--cleanup-suggestions)
6. [🚀 Performance & Scaling Plan](#-performance--scaling-plan)
7. [🔐 Security Plan](#-security-plan)
8. [📈 Logging & Monitoring Plan](#-logging--monitoring-plan)
9. [🧪 Testing Plan](#-testing-plan)
10. [🛠 Refactoring Priority Roadmap](#-refactoring-priority-roadmap)

---

## 🔎 Project Level Assessment

**Level: Intermediate (Early Stage)**

The project demonstrates solid knowledge of Flutter fundamentals and BLoC pattern usage with Freezed. However, it lacks the architectural discipline, testability, and operational readiness expected for a production app at scale. The codebase shows organic growth — features added incrementally without a consistent structural contract. Several decisions that work fine at 1,000 users will cause measurable pain at 100,000.

| Dimension | Rating | Notes |
|-----------|--------|-------|
| Flutter/Dart knowledge | ✅ Good | Freezed, BLoC, Supabase used correctly |
| Architecture | ⚠️ Weak | No repository layer, no DI wiring |
| Testability | ❌ None | Zero tests, untestable BLoC structure |
| Security | ❌ Critical gaps | API key exposed, no obfuscation |
| Performance | ⚠️ Weak | N+1 queries, eager IndexedStack |
| Observability | ❌ None | No crash reporting, no analytics |
| DevOps | ⚠️ Partial | Fastlane exists, no CI/CD |

---

## 🏗 Architecture Review

### What Works

- BLoC + Freezed is a reasonable, scalable choice for state management
- Two build flavors (`dev` / `prod`) with separate Firebase options — correctly set up
- `SupabaseBucketFolders` enum centralizes storage paths cleanly
- `AudioUrlService` correctly abstracts CDN URL resolution behind a strategy pattern
- Fastlane pipeline exists for release automation

### What Is Structurally Broken

#### No Repository Layer

Every BLoC calls Supabase directly. This means:
- You cannot mock data for tests
- You cannot swap or layer the backend (e.g., add caching, switch from Supabase)
- Business logic is entangled with network calls in the same class

**Current (wrong):**
```
Screen → BLoC → Supabase SDK
```

**Required:**
```
Screen → BLoC → Repository (interface) → Supabase implementation
                             ↘ Mock implementation (for tests)
```

#### `get_it` Imported but Never Wired

Dependency injection is declared as a dependency in `pubspec.yaml` but never configured or used. Instead, singletons and locally-created BLoC instances proliferate.

#### BLoCs Created Inside Widget `State` Classes

`SpokenPatternScreen` does this:

```dart
final _spokenPatternBloc = SpokenPatternBloc();
final _audioPositionTrackerBloc = AudioPlayerBloc();
final _audioPlayerStateTrackerBloc = AudioPlayerBloc();
```

This defeats the purpose of BLoC. These instances are not accessible via `context.read()`, not shared with child widgets, and not covered by the root `MultiBlocProvider`. Any child widget attempting `context.read<AudioPlayerBloc>()` will throw.

#### `GlobalAppState` Is a Hidden Dependency

Every BLoC silently depends on `GlobalAppState().currentUser` without it being injected or declared. This creates invisible coupling and makes unit testing impossible — any test calling a BLoC method must somehow pre-populate a global singleton before running.

---

## 🚨 Critical Issues

### 1. API Key Committed to Repository

`README.md` lines 49–51 contain a plaintext OpenAI API key. The `.envs/` directory also appears to be tracked by git.

**Actions:**
- Rotate the OpenAI key immediately via the OpenAI dashboard
- Audit git history: `git log --all --full-history -- README.md`
- Add to `.gitignore`:
  ```
  .envs/
  *.env
  ```
- Add a pre-commit hook using `gitleaks` or `git-secrets` to prevent recurrence
- Commit only `.env.example` files with placeholder values

---

### 2. No Crash Reporting

There is no Firebase Crashlytics, Sentry, or equivalent. At 100k users, silent crashes are invisible. You have no way to know the app is crashing in production unless a user reports it manually.

**Fix:** Add `firebase_crashlytics` and wrap `runApp`:

```dart
void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    // ... rest of init
    runApp(const PmpEnglishApp());
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
}
```

---

### 3. `AudioPlayerBloc.stop()` Emits Wrong State

```dart
// lib/bloc/audio_player/audio_player_bloc.dart
stop: () {
  emit(const AudioPlayerState.loading());
  emit(const AudioPlayerState.onPause()); // BUG: should be onStop
},
```

Any UI element listening for `onStop` to reset playback state will never receive it. This is a silent correctness bug affecting every screen that uses audio.

**Fix:**
```dart
stop: () {
  emit(const AudioPlayerState.onStop()); // remove loading, emit correct state
},
```

---

### 4. Dangling Filter in `_mapLoadPatterns`

```dart
// lib/bloc/spoken_pattern/spoken_pattern_bloc.dart
var query = supabase
    .from('patterns')
    .select('*,subject_verb_agreements(*)')
    .eq('pattern_user_comments.user_id', GlobalAppState().currentUser.id!) // BUG
```

`pattern_user_comments` is never joined in the `select()` call. This filter is applied against a non-existent joined table. The behavior is undefined — it may silently return wrong or empty data.

**Fix:** Either add `pattern_user_comments(*)` to the select, or remove the filter entirely if it is not needed.

---

### 5. `Env` Class Crashes on Missing Keys

```dart
// lib/config/env.dart
static String supabaseURL = dotenv.env['SUPABASE_URL']!; // runtime crash if missing
```

If any key is missing from the `.env` file (wrong filename, deployment error, typo), the app throws a `Null check operator used on a null value` at startup with no useful diagnostic message.

**Fix:**
```dart
class Env {
  static void validate() {
    const required = [
      'SUPABASE_URL',
      'SUPABASE_ANON_KEY',
      'BUNNY_SPOKEN_PATTERN_API_KEY',
      'BUNNY_LISTENING_API_KEY',
      'PRIVACY_POLICY',
    ];
    final missing = required.where((k) => dotenv.env[k] == null).toList();
    if (missing.isNotEmpty) {
      throw StateError('Missing required environment keys: $missing');
    }
  }

  static String get supabaseURL => dotenv.env['SUPABASE_URL']!;
  // ... rest of getters
}
```

Call `Env.validate()` in `main()` before any other initialization.

---

### 6. Device-ID Security Lock Is Bypassable

The "one device" enforcement compares `appUser.deviceId` against `GlobalAppState().deviceID`, which is populated from `DeviceInfoPlugin`. On Android, `androidDeviceInfo.id` is a software-generated ID that resets on factory reset and can be spoofed on rooted devices or emulators. This is a business logic risk, not a security guarantee.

**Mitigation:** Accept this limitation and document it, or supplement with server-side session invalidation (revoke all other sessions when a new login occurs from a new device ID).

---

### 7. N+1 Queries in `_mapLoadPracticeExamplesToState`

```dart
// lib/bloc/spoken_pattern/spoken_pattern_bloc.dart
final updatedExamples = await Future.wait(
  examples.map((example) async {
    final data = await (AppDatabase.instance().userExampleAnswerTable.select()
          ..where((tbl) => tbl.exampleId.equals(example.id))) // 1 query per example
        .getSingleOrNull();
    return example.copyWith(userAnswer: data?.userAnswer);
  }),
);
```

For 20 examples, this fires 20 separate local DB queries in parallel. This will degrade as example counts grow.

**Fix:**
```dart
// Single query with IN clause
final ids = examples.map((e) => e.id).toList();
final answers = await (AppDatabase.instance().userExampleAnswerTable.select()
      ..where((tbl) => tbl.exampleId.isIn(ids)))
    .get();

final answerMap = {for (final a in answers) a.exampleId: a.userAnswer};
final updatedExamples = examples.map((e) =>
    e.copyWith(userAnswer: answerMap[e.id])).toList();
```

---

## ⚠️ Medium Issues

### 1. `SharedPreferences.getInstance()` Called on Every Operation

```dart
// lib/services/share_preference_utils.dart
static Future<void> saveString(String key, String value) async {
  final prefs = await SharedPreferences.getInstance(); // async I/O every call
  await prefs.setString(key, value);
}
```

`getInstance()` is an async call on every read/write. Cache it after first initialization.

**Fix:**
```dart
class SharedPreferenceUtils {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> _instance() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  static Future<void> saveString(String key, String value) async {
    final prefs = await _instance();
    await prefs.setString(key, value);
  }
  // ...
}
```

---

### 2. `IndexedStack` Pre-Builds All Children Eagerly

Both `DayListScreen` and `SpokenPatternScreen` use `IndexedStack`. All children are built and kept in memory simultaneously — even when not visible. For `SpokenPatternScreen`, this means every pattern widget (potentially 30+) is rendered and held in the widget tree at once.

**Fix:** Replace with `PageView.builder` for lazy loading:
```dart
PageView.builder(
  controller: _pageController,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: spokenPatterns.length,
  itemBuilder: (context, index) => SpokenPatternWidget(
    spokenPattern: spokenPatterns[index],
  ),
)
```

---

### 3. Two Parsing Methods on `Day`: `fromJson` vs `fromJson1`

```dart
// lib/model/day/day.dart
factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json); // generated
factory Day.fromJson1(Map<String, dynamic> json) { ... }               // hand-written
```

Two sources of truth for the same model. `fromJson1` also silently accepts `null` for `lessons` and `exercises` and passes them directly to `Lesson.fromJsonList` — if absent from JSON, behavior is undefined.

**Fix:** Eliminate `fromJson1` by handling the Supabase join shape in the repository layer, not the model.

---

### 4. `AudioPlayerBloc` Emits `loading` Before Every State Transition

```dart
play: () {
  emit(const AudioPlayerState.loading()); // triggers a rebuild
  emit(const AudioPlayerState.onPlay()); // triggers another rebuild
},
```

Every interaction causes two widget rebuilds. Remove the intermediate `loading` emission from non-network events (play, pause, stop, position updates).

---

### 5. Local BLoC Instance Not Provided to Tree

In `SpokenPatternScreen`, `_audioPlayerStateTrackerBloc` is created but never added to `MultiBlocProvider`:

```dart
providers: [
  BlocProvider<SpokenPatternBloc>(create: (_) => _spokenPatternBloc),
  BlocProvider<AudioPlayerBloc>(create: (_) => _audioPositionTrackerBloc),
  // _audioPlayerStateTrackerBloc is missing from the tree
],
```

Child widgets cannot access it via context. It is passed explicitly, defeating the BLoC pattern entirely.

---

### 6. `Listening` Model Has Non-Nullable Required Paths

```dart
// lib/model/listening/listening.dart
@JsonKey(name: 'subtitle_path') required String subtitlePath,
@JsonKey(name: 'shadowing_path') required String shadowingPath,
// ... all required, non-nullable
```

If Supabase returns `null` for any of these fields (e.g., content not yet uploaded), `fromJson` throws at runtime. Make these `String?` or provide empty string defaults.

---

### 7. `_normalizePath` Silently Returns Empty String

```dart
// lib/bloc/listening/listening_bloc.dart
String _normalizePath(String path) {
  if (path.isEmpty) return ""; // silent swallow — callers get "" as a URL
  return Env.bunnyListeningAPIKey + path.replaceFirst('bunny/', '');
}
```

Callers receive an empty string and attempt to use it as a CDN URL, causing opaque network failures. Return `null` and make the callers handle the nullable case explicitly.

---

### 8. `AppUIBloc` Is an Untyped Event Bus

`AppUIBloc` signals two completely unrelated concerns: AI practice list reloads and listening practice list reloads. As features grow, this becomes an unmaintainable global event bus.

**Fix:** Use feature-scoped BLoCs or dedicated streams for cross-screen refresh signals.

---

## 🧹 Code Smells / Cleanup Suggestions

### Delete Immediately

| File | Reason |
|------|--------|
| `lib/fake_data_repository.dart` | Seed/fake data has no place in `lib/`. Move to `test/fixtures/` or delete |
| `lib/screens/main/new_path_screen.dart` | 100% commented-out code, 85 lines of dead weight |
| `lib/screens/days/spoken_pattern/spoken_pattern_widget_temp.dart` | Temp file committed to production |

### Rename for Correctness (Typos)

| Current | Should Be |
|---------|-----------|
| `ai_reponse_card.dart` | `ai_response_card.dart` |
| `ai_reponse_list.dart` | `ai_response_list.dart` |
| `onToggelBurmeseSub` | `onToggleBurmeseSubtitle` |
| `_OnToggelBurmeseSub` | `_OnToggleBurmeseSubtitle` |

### Remove All `debugPrint` from Production Code

There are 50+ `debugPrint` calls scattered across BLoCs and screens. These output nothing in release builds and provide no structured context. Replace with a proper `AppLogger` abstraction (see Logging section).

### Consolidate Duplicate Query Logic

`_mapLoadExamplesByPattern` and `_mapLoadPracticeExamplesByPattern` in `SpokenPatternBloc` are nearly identical — one fetches vocabularies, the other fetches user answers. Merge into a single method with parameters, or extract to a repository.

### `Env` — Remove Hardcoded Business Config from Singleton

```dart
// lib/global_app_state.dart
static const int maxTotalTokens = 500000; // hardcoded business rule
```

This belongs in remote config (Firebase Remote Config) so it can be changed without a release.

### Validate Route Arguments at Compile Time

Currently all route arguments are `Map<String, dynamic>` with manual casting:
```dart
final exercise = args['exercise'] as Exercise; // crashes if key missing
```

Consider typed route wrappers or `go_router` with typed routes to catch argument errors at compile time.

---

## 🚀 Performance & Scaling Plan

### Query Optimization

| Issue | Location | Fix |
|-------|----------|-----|
| N+1 local DB queries | `SpokenPatternBloc._mapLoadPracticeExamplesToState` | Single `WHERE IN` query |
| `SELECT *` on all tables | All BLoCs | Select only required columns |
| All days loaded at once | `DayBloc` | Cursor-based pagination (`.range(from, to)`) |
| All listenings loaded at once | `ListeningBloc` | Paginate or cache |
| Separate lessons + exercises queries after days query | `DayBloc` | Combine with Supabase nested select |

### UI Performance

| Issue | Location | Fix |
|-------|----------|-----|
| `IndexedStack` builds all children | `SpokenPatternScreen`, `DayListScreen` | `PageView.builder` for lazy loading |
| `SharedPreferences.getInstance()` every call | `SharedPreferenceUtils` | Cache instance after first load |
| Double rebuilds on every audio event | `AudioPlayerBloc` | Remove intermediate `loading` states |
| Multiple `AudioPlayer` instances | Per-screen creation | Singleton `AudioService` with lifecycle management |

### For 100k Users Specifically

- **Supabase RLS policies** must be reviewed for every table. Verify users can never read other users' `days_users_relation` or `exercises_users_relation` rows
- **Bunny CDN URLs** are permanent and unprotected — any user who extracts a URL can share premium audio freely. Implement signed/time-limited tokens
- **Offline-first caching** for `days`, `lessons`, and `exercises` using Drift — currently every cold start makes full network round-trips
- **HTTP response caching** — configure `cached_network_image` with explicit cache duration and size limits

---

## 🔐 Security Plan

| Priority | Issue | Action |
|----------|-------|--------|
| 🔴 Critical | OpenAI API key in `README.md` | Rotate immediately, add `gitleaks` pre-commit hook |
| 🔴 Critical | `.env` files tracked by git | Add to `.gitignore`, audit `git log` for history |
| 🔴 Critical | No crash reporting | Add Firebase Crashlytics (blind in production) |
| 🟠 High | Bunny CDN URLs are permanent and unsigned | Implement signed/time-limited CDN URLs |
| 🟠 High | No release obfuscation | Add `--obfuscate --split-debug-info=symbols/` to build command |
| 🟠 High | Device lock uses spoofable Android ID | Document limitation; supplement with server-side session tracking |
| 🟡 Medium | `supabase.rpc('get_user')` result cast with manual typing | Use strongly-typed `.withConverter()` on all RPC calls |
| 🟡 Medium | No input sanitization on user-entered text | Sanitize before all Supabase inserts |
| 🟡 Medium | `debugPrint` may log user data | Replace with logger that strips DEBUG in release |
| 🟢 Low | No certificate pinning | Add TLS pinning via `http` package interceptor |

### Obfuscated Release Build Command

```bash
flutter build apk \
  --release \
  --flavor prod \
  -t lib/main.dart \
  --dart-define flavor=prod \
  --obfuscate \
  --split-debug-info=symbols/ \
  --build-name 1.0.0 \
  --build-number 1
```

Upload the `symbols/` directory to Firebase Crashlytics for de-obfuscated stack traces.

---

## 📈 Logging & Monitoring Plan

Currently there is **zero** structured logging or monitoring. `debugPrint` outputs nothing in release builds. In production you are flying blind.

### Step 1 — Create `AppLogger` Abstraction

```dart
// lib/core/logger/app_logger.dart
abstract class AppLogger {
  void debug(String message, {String? tag});
  void info(String message, {String? tag});
  void warning(String message, {String? tag});
  void error(String message, {Object? error, StackTrace? stackTrace, String? tag});
}
```

```dart
// lib/core/logger/crashlytics_logger.dart
class CrashlyticsLogger implements AppLogger {
  @override
  void error(String message, {Object? error, StackTrace? stackTrace, String? tag}) {
    FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      reason: message,
      fatal: false,
    );
  }
  // debug/info/warning → no-op in release
}
```

Replace all `debugPrint` calls with `AppLogger.instance.debug(...)`.

### Step 2 — Crashlytics Setup

```dart
// lib/main.dart
void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (details) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
    // ... rest of init
    runApp(const PmpEnglishApp());
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
}
```

### Step 3 — Firebase Analytics Events

Track these key business events:

| Event Name | Trigger | Parameters |
|-----------|---------|------------|
| `lesson_started` | User opens a spoken pattern lesson | `lesson_id`, `day_id` |
| `lesson_completed` | User reaches last pattern in lesson | `lesson_id`, `pattern_count` |
| `exercise_passed` | Exercise marked as pass | `exercise_id`, `day_id` |
| `exercise_failed` | Exercise marked as fail | `exercise_id`, `day_id` |
| `listening_session_started` | User opens a listening content | `listening_id`, `type` |
| `shadowing_session_started` | User starts shadowing mode | `listening_id` |
| `speech_recorded` | User saves a recording | `listening_id` |
| `login_success` | Auth success | — |
| `login_failed` | Auth failure | `reason` |

### Step 4 — BLoC Error Tracking

Update all BLoC catch blocks:

```dart
} catch (e, stackTrace) {
  AppLogger.instance.error(
    'DayBloc.loadDays failed',
    error: e,
    stackTrace: stackTrace,
    tag: 'DayBloc',
  );
  if (e is SocketException || e is TimeoutException) {
    emit(const DayState.socketError("Please check your connection."));
  } else {
    emit(DayState.error(e.toString()));
  }
}
```

---

## 🧪 Testing Plan

Currently there are **zero tests**. This is the single largest risk to scaling the project.

### Why Nothing Is Testable Right Now

BLoCs call Supabase directly. Supabase is a live network dependency. You cannot run a unit test without a live Supabase connection. This must be fixed first via the repository pattern.

### Phase 1 — Make It Testable

Introduce repository interfaces. BLoCs depend on the interface, not the implementation.

```
lib/
  repositories/
    day/
      day_repository.dart             # abstract interface
      supabase_day_repository.dart    # production implementation
    listening/
      listening_repository.dart
      supabase_listening_repository.dart
    auth/
      auth_repository.dart
      supabase_auth_repository.dart
test/
  mocks/
    mock_day_repository.dart          # mockito or manual mock
  bloc/
    day_bloc_test.dart
    auth_bloc_test.dart
    listening_bloc_test.dart
```

### Phase 2 — BLoC Unit Tests

```dart
// test/bloc/day_bloc_test.dart
blocTest<DayBloc, DayState>(
  'emits [loading, loaded] when days fetch succeeds',
  build: () => DayBloc(repository: MockDayRepository()),
  setUp: () {
    when(mockDayRepository.loadDays()).thenAnswer((_) async => fakeDays);
  },
  act: (bloc) => bloc.add(const DayEvent.loadDays()),
  expect: () => [
    const DayState.loading(),
    isA<DayState>().having((s) => s, 'loaded state', isA<_Loaded>()),
  ],
);

blocTest<DayBloc, DayState>(
  'emits socketError on SocketException',
  build: () => DayBloc(repository: MockDayRepository()),
  setUp: () {
    when(mockDayRepository.loadDays()).thenThrow(const SocketException(''));
  },
  act: (bloc) => bloc.add(const DayEvent.loadDays()),
  expect: () => [
    const DayState.loading(),
    isA<DayState>().having((s) => s, 'socket error', isA<_SocketError>()),
  ],
);
```

### Phase 3 — Widget Smoke Tests

```dart
// test/screens/splash_screen_test.dart
testWidgets('routes to home when authenticated', (tester) async {
  await tester.pumpWidget(
    BlocProvider<AuthBloc>(
      create: (_) => MockAuthBloc()..stubState(const AuthState.authenticated()),
      child: const MaterialApp(home: SplashScreen()),
    ),
  );
  await tester.pumpAndSettle();
  expect(find.byType(HomePage), findsOneWidget);
});
```

### Phase 4 — Integration & E2E

Use the `patrol` package for end-to-end flows:
1. Login → view day list → open lesson → complete exercise → verify completion persisted
2. Login → open listening → complete sentence practice → view results
3. Login → shadowing → record audio → playback recording

### Coverage Targets

| Layer | Target |
|-------|--------|
| Model `fromJson`/`toJson` round-trips | 90% |
| BLoC event/state transitions | 80% |
| Repository method contracts | 70% |
| Widget smoke tests (critical screens) | 50% |
| E2E critical user journeys | 5 flows |

### Recommended Packages

```yaml
dev_dependencies:
  bloc_test: ^9.1.0
  mocktail: ^1.0.0
  patrol: ^3.0.0
```

---

## 🛠 Refactoring Priority Roadmap

Work in this exact order. Each phase unblocks the next.

---

### Phase 1 — Stop the Bleeding *(1–2 weeks)*

These are zero-risk, high-urgency fixes.

- [ ] Rotate the exposed OpenAI API key
- [ ] Add `.envs/` and `*.env` to `.gitignore`, verify not in git history
- [ ] Add `gitleaks` pre-commit hook
- [ ] Delete `lib/fake_data_repository.dart`
- [ ] Delete `lib/screens/main/new_path_screen.dart`
- [ ] Delete `lib/screens/days/spoken_pattern/spoken_pattern_widget_temp.dart`
- [ ] Fix `AudioPlayerBloc.stop()` to emit `onStop` not `onPause`
- [ ] Fix dangling filter in `SpokenPatternBloc._mapLoadPatterns`
- [ ] Add `Env.validate()` called at startup
- [ ] Add `--obfuscate --split-debug-info=symbols/` to release build command
- [ ] Add Firebase Crashlytics with `runZonedGuarded`
- [ ] Fix typos in filenames and state names

---

### Phase 2 — Introduce Testability *(2–4 weeks)*

These changes make the codebase professionally maintainable.

- [ ] Wire up `get_it` as the service locator
- [ ] Create repository interfaces: `DayRepository`, `ListeningRepository`, `SpokenPatternRepository`, `AuthRepository`
- [ ] Implement Supabase repositories, moving all Supabase calls out of BLoCs
- [ ] Inject repositories into BLoCs via constructor (not from global singleton)
- [ ] Write unit tests for all BLoC transitions using mock repositories
- [ ] Write model `fromJson`/`toJson` round-trip tests
- [ ] Add `AppLogger` abstraction with Crashlytics backend

---

### Phase 3 — Architecture Cleanup *(2–4 weeks)*

- [ ] Remove `GlobalAppState` singleton; expose `AppUser` via `get_it` or `AuthBloc`
- [ ] Remove local BLoC instantiation from widget `State` classes — provide via `get_it` or root `BlocProvider`
- [ ] Cache `SharedPreferences` instance after first load
- [ ] Fix N+1 DB queries in `_mapLoadPracticeExamplesToState` using single `WHERE IN` query
- [ ] Replace `IndexedStack` with `PageView.builder` in `SpokenPatternScreen` and `DayListScreen`
- [ ] Eliminate `Day.fromJson1` — handle join shape in repository layer
- [ ] Remove intermediate `loading` state from `AppUIBloc` and `AudioPlayerBloc` non-network events
- [ ] Merge duplicate example-fetching methods in `SpokenPatternBloc`
- [ ] Make `Listening` path fields nullable (`String?`)
- [ ] Return `null` from `_normalizePath` instead of empty string

---

### Phase 4 — Performance & Scale *(Ongoing)*

- [ ] Add cursor-based pagination to day list and listening list
- [ ] Add offline-first Drift caching for days, lessons, exercises
- [ ] Sign Bunny CDN URLs server-side (time-limited tokens)
- [ ] Add Firebase Analytics event tracking for all key user actions
- [ ] Replace all `debugPrint` with structured `AppLogger` calls
- [ ] Implement singleton `AudioService` shared across screens
- [ ] Configure `cached_network_image` with explicit cache limits
- [ ] Add `gitleaks` to CI pipeline
- [ ] Add Firebase Remote Config for `maxTotalTokens` and other business constants
- [ ] Set up CI/CD (GitHub Actions or Codemagic) for automated build + test on PR

---

*End of review.*
