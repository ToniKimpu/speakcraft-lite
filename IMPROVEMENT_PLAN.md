# PMP English Mobile — Step-by-Step Improvement Plan

> Based on `CODE_REVIEW.md` — 2026-03-05
> Ordered strictly by dependency and risk. Do not skip phases.
> Each step has: **what**, **why**, **exactly how**, and **done criteria**.

---

## How to Use This Document

- Work top-to-bottom. Steps within a phase can be done in parallel by different people, but phases must be sequential.
- Each step has a checkbox. Check it only when the **Done When** criteria is fully met.
- Estimated effort is per developer, assuming familiarity with Flutter/Dart.

---

## Phase 1 — Stop the Bleeding
### Goal: Fix security holes and correctness bugs before any new feature work.
### Duration: 1–2 weeks
### Risk: Zero — all changes are isolated, no architecture needed.

---

### Step 1.1 — Rotate the Exposed API Key

**Why:** An OpenAI API key is visible in `README.md` lines 49–51. Anyone with git access can read it. It is also in git history even after you delete it from the file.

**How:**

1. Go to [platform.openai.com/api-keys](https://platform.openai.com/api-keys) and **revoke** the key immediately.
2. Generate a new key. Store it in your password manager, not in any file.
3. Open `README.md` and delete lines 49–51 entirely.
4. Purge the key from git history:
   ```bash
   git filter-branch --force --index-filter \
     "git rm --cached --ignore-unmatch README.md" \
     --prune-empty --tag-name-filter cat -- --all
   git push origin --force --all
   ```
   > Or use [BFG Repo Cleaner](https://rtyley.github.io/bfg-repo-cleaner/) which is faster.
5. Notify all collaborators to re-clone — their local history still contains the key.

**Done When:** Key is revoked. `README.md` contains no credentials. `git log -S "sk-proj"` returns zero results.

---

### Step 1.2 — Remove `.env` Files from Git Tracking

**Why:** `.envs/.env.dev` and `.envs/.env.prod` contain `SUPABASE_ANON_KEY`, `BUNNY_*` API keys, and the privacy policy URL. These must never be committed.

**How:**

1. Add to `.gitignore`:
   ```
   # Environment files
   .envs/
   *.env
   .env.*
   symbols/
   ```

2. Remove from git tracking without deleting the files:
   ```bash
   git rm -r --cached .envs/
   git commit -m "remove env files from tracking"
   ```

3. Create `.envs/.env.example` with placeholder values and commit that:
   ```
   SUPABASE_URL=https://your-project.supabase.co
   SUPABASE_ANON_KEY=your-anon-key-here
   BUNNY_SPOKEN_PATTERN_API_KEY=https://your-bunny-cdn-url/
   BUNNY_LISTENING_API_KEY=https://your-bunny-cdn-url/
   PRIVACY_POLICY=https://your-privacy-policy-url
   ```

4. Update `README.md` (or `CLAUDE.md`) to say:
   > Copy `.envs/.env.example` to `.envs/.env.dev` and `.envs/.env.prod` and fill in values before running.

**Done When:** `git status` shows no `.env` files tracked. New developer can follow instructions to set up env files locally.

---

### Step 1.3 — Install `gitleaks` Pre-Commit Hook

**Why:** Prevent secrets from ever being committed again. This runs before every `git commit`.

**How:**

1. Install gitleaks:
   ```bash
   # Windows (via winget)
   winget install gitleaks
   # Or download binary from https://github.com/gitleaks/gitleaks/releases
   ```

2. Create `.pre-commit-config.yaml` in project root:
   ```yaml
   repos:
     - repo: https://github.com/gitleaks/gitleaks
       rev: v8.18.4
       hooks:
         - id: gitleaks
   ```

3. Install pre-commit:
   ```bash
   pip install pre-commit
   pre-commit install
   ```

4. Test it works:
   ```bash
   # This should be blocked:
   echo "sk-proj-abc123" >> test.txt
   git add test.txt
   git commit -m "test"
   # Expected: commit blocked with "gitleaks: secrets detected"
   git checkout -- test.txt && git rm test.txt
   ```

**Done When:** Committing a file containing a key pattern is blocked automatically.

---

### Step 1.4 — Fix `AudioPlayerBloc.stop()` Bug

**Why:** `stop()` emits `onPause` instead of `onStop`. Every screen that listens for `onStop` to reset UI (e.g., reset play button icon) receives the wrong signal.

**File:** `lib/bloc/audio_player/audio_player_bloc.dart`

**How:**

Before:
```dart
stop: () {
  emit(const AudioPlayerState.loading());
  emit(const AudioPlayerState.onPause()); // WRONG
},
```

After:
```dart
stop: () {
  emit(const AudioPlayerState.onStop());
},
```

Also remove the redundant `loading` emission from all non-network events in this BLoC:
```dart
play: () => emit(const AudioPlayerState.onPlay()),
pause: () => emit(const AudioPlayerState.onPause()),
stop: () => emit(const AudioPlayerState.onStop()),
setCurrentPosition: (position) =>
    emit(AudioPlayerState.onCurrentPosition(position)),
setTotalDuration: (duration) =>
    emit(AudioPlayerState.onTotalDuration(duration)),
updatePlayerState: (playerState) =>
    emit(AudioPlayerState.onUpdatePlayerState(playerState)),
```

**Done When:** Play, pause, and stop each emit exactly one state. No intermediate `loading` emitted for non-network events. Audio UI behaves correctly.

---

### Step 1.5 — Fix Dangling Filter in `SpokenPatternBloc`

**Why:** `_mapLoadPatterns` applies a `.eq()` filter on `pattern_user_comments.user_id` but `pattern_user_comments` is not in the `select()`. This is an undefined query that may silently return wrong data.

**File:** `lib/bloc/spoken_pattern/spoken_pattern_bloc.dart`

**How:**

Find this block:
```dart
var query = supabase
    .from('patterns')
    .select('*,subject_verb_agreements(*)')
    .eq('pattern_user_comments.user_id', GlobalAppState().currentUser.id!)
    .eq('self_practicable', true)
    .eq('is_deleted', false);
```

Decide which is correct:

**Option A** — if you need user comments in the result, add the join:
```dart
var query = supabase
    .from('patterns')
    .select('*,subject_verb_agreements(*),pattern_user_comments(*)')
    .eq('pattern_user_comments.user_id', GlobalAppState().currentUser.id!)
    .eq('self_practicable', true)
    .eq('is_deleted', false);
```

**Option B** — if you don't need to filter by user comments here, remove the filter:
```dart
var query = supabase
    .from('patterns')
    .select('*,subject_verb_agreements(*)')
    .eq('self_practicable', true)
    .eq('is_deleted', false);
```

**Done When:** Query is deterministic. Test by loading the spoken pattern self-practice list and verifying correct patterns appear.

---

### Step 1.6 — Add `Env.validate()` at Startup

**Why:** Missing `.env` keys crash the app with an unhelpful `Null check operator` error at startup.

**File:** `lib/config/env.dart`

**How:**

Replace the current `Env` class:
```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
      throw StateError(
        'Missing required environment variables: $missing\n'
        'Copy .envs/.env.example to .envs/.env.dev and fill in values.',
      );
    }
  }

  static String get supabaseURL => dotenv.env['SUPABASE_URL']!;
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY']!;
  static String get bunnySpokenPatternAPIKey =>
      dotenv.env['BUNNY_SPOKEN_PATTERN_API_KEY']!;
  static String get bunnyListeningAPIKey =>
      dotenv.env['BUNNY_LISTENING_API_KEY']!;
  static String get privacyPolicyUrl => dotenv.env['PRIVACY_POLICY']!;
}
```

Then in `lib/main.dart`, call it immediately after loading the dotenv file:
```dart
await dotenv.load(fileName: '.envs/.env.$env');
Env.validate(); // add this line
```

**Done When:** Running with a missing env key shows a clear error message naming the missing key. Running with all keys present proceeds normally.

---

### Step 1.7 — Add Firebase Crashlytics

**Why:** You are currently blind to production crashes. Zero visibility.

**How:**

1. Add dependency to `pubspec.yaml`:
   ```yaml
   dependencies:
     firebase_crashlytics: ^4.1.0
   ```

2. Run `flutter pub get`.

3. Update `lib/main.dart`:
   ```dart
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

       const env = String.fromEnvironment('flavor', defaultValue: 'dev');
       await dotenv.load(fileName: '.envs/.env.$env');
       Env.validate();

       // Disable Crashlytics in dev
       await FirebaseCrashlytics.instance
           .setCrashlyticsCollectionEnabled(env == 'prod');

       // ... rest of init unchanged
       runApp(const PmpEnglishApp());
     }, (error, stack) {
       FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
     });
   }
   ```

**Done When:** In prod flavor, a forced test crash (`FirebaseCrashlytics.instance.crash()`) appears in the Firebase Crashlytics dashboard within 5 minutes.

---

### Step 1.8 — Enable Release Obfuscation

**Why:** Release APKs without obfuscation expose full class names, method names, and app logic to reverse engineers. Premium content protection depends on this.

**How:**

Update your Fastlane release command and any manual build commands:
```bash
flutter build apk \
  --release \
  --flavor prod \
  -t lib/main.dart \
  --dart-define flavor=prod \
  --obfuscate \
  --split-debug-info=build/symbols/ \
  --build-name 1.0.0 \
  --build-number 1
```

Add `build/symbols/` to `.gitignore`. Upload the `symbols/` directory to Firebase Crashlytics after each release so stack traces remain readable:
```bash
firebase crashlytics:symbols:upload --app=YOUR_APP_ID build/symbols/
```

Update your Fastlane `Fastfile` to run this upload step automatically after each build.

**Done When:** Release APK is built with `--obfuscate`. `build/symbols/` directory is generated. Stack traces in Crashlytics dashboard are human-readable (not obfuscated).

---

### Step 1.9 — Delete Dead Code Files

**Why:** Dead code creates confusion, inflates codebase size, and misleads future developers.

**Files to delete:**

```bash
# Delete these files
git rm lib/fake_data_repository.dart
git rm lib/screens/main/new_path_screen.dart
git rm lib/screens/days/spoken_pattern/spoken_pattern_widget_temp.dart
git commit -m "remove dead code files"
```

Also remove the commented-out `newPathScreen` route from `lib/config/pmp_routes.dart`:
```dart
// Delete these lines:
// static const newPathScreen = '/new_path_screen';
// case newPathScreen:
//   return _getRoute(const NewPathScreen(), settings);
```

**Done When:** All three files deleted. No import references remain. Project compiles cleanly.

---

### Step 1.10 — Fix Typos in Filenames and State Names

**Why:** Typos in public API names propagate into tests, analytics events, and logs. Fix them before they become entrenched.

**Files to rename:**
```bash
git mv lib/screens/practice_with_ai/widgets/ai_reponse_card.dart \
       lib/screens/practice_with_ai/widgets/ai_response_card.dart

git mv lib/screens/practice_with_ai/pages/ai_reponse_list.dart \
       lib/screens/practice_with_ai/pages/ai_response_list.dart
```

**State names to fix** in `lib/bloc/listening/listening_bloc.dart`:
```dart
// Before:
const factory ListeningState.onToggelBurmeseSub(bool value) = _OnToggelBurmeseSub;

// After:
const factory ListeningState.onToggleBurmeseSubtitle(bool value) = _OnToggleBurmeseSubtitle;
```

Update all references in screens that use `.onToggelBurmeseSub`. Run `dart run build_runner build --delete-conflicting-outputs` after.

**Done When:** Project compiles. No typos in any public API name. Search for `Toggel` and `reponse` returns zero results.

---

## Phase 2 — Introduce Testability
### Goal: Make BLoCs independently testable without a live Supabase connection.
### Duration: 2–4 weeks
### Risk: Medium — structural refactor, but done feature-by-feature.

---

### Step 2.1 — Wire Up `get_it` as the Service Locator

**Why:** `get_it` is already in `pubspec.yaml` but never configured. It is the bridge between repositories and BLoCs.

**How:**

Create `lib/core/di/service_locator.dart`:
```dart
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Repositories (registered first — BLoCs depend on these)
  sl.registerLazySingleton<AuthRepository>(
    () => SupabaseAuthRepository(),
  );
  sl.registerLazySingleton<DayRepository>(
    () => SupabaseDayRepository(),
  );
  sl.registerLazySingleton<ListeningRepository>(
    () => SupabaseListeningRepository(),
  );
  sl.registerLazySingleton<SpokenPatternRepository>(
    () => SupabaseSpokenPatternRepository(),
  );
}
```

Call it in `main()` before `runApp`:
```dart
await setupServiceLocator();
runApp(const PmpEnglishApp());
```

**Done When:** `sl<DayRepository>()` resolves without error. `flutter run` works.

---

### Step 2.2 — Create Repository Interfaces

**Why:** BLoCs must depend on abstractions, not Supabase concretely, so they can be tested with mocks.

**How:**

Create one file per feature:

`lib/repositories/day/day_repository.dart`:
```dart
import '../../model/day/day.dart';

abstract class DayRepository {
  Future<List<Day>> loadDays();
}
```

`lib/repositories/auth/auth_repository.dart`:
```dart
import '../../model/app_user/app_user.dart';

abstract class AuthRepository {
  Future<AppUser?> getCurrentUser();
  Future<AppUser> loginWithEmail(String email, String password);
  Future<AppUser> signUpWithEmail(String email, String password, String name, String? profilePath);
  Future<void> logout();
  Future<Map<String, dynamic>?> getLatestAppVersion();
}
```

`lib/repositories/listening/listening_repository.dart`:
```dart
import '../../model/listening/listening.dart';
import '../../model/pattern_vocabulary/pattern_vocabulary.dart';

abstract class ListeningRepository {
  Future<List<Listening>> loadListenings();
  Future<List<PatternVocabulary>> loadVocabulariesByListening(int listeningId);
}
```

`lib/repositories/spoken_pattern/spoken_pattern_repository.dart`:
```dart
import '../../model/spoken_pattern/spoken_pattern.dart';
import '../../model/pattern_example/pattern_example.dart';
import '../../model/pattern_vocabulary/pattern_vocabulary.dart';

abstract class SpokenPatternRepository {
  Future<List<SpokenPattern>> loadPatternsByLesson(int lessonId);
  Future<List<PatternExample>> loadPracticeExamplesByPattern(int patternId);
  Future<List<PatternVocabulary>> loadVocabulariesByPattern(int patternId);
}
```

**Done When:** All interface files compile. No implementations yet — that is Step 2.3.

---

### Step 2.3 — Implement Supabase Repositories

**Why:** Move all Supabase SDK calls out of BLoCs into the repository implementations.

**How:**

Create `lib/repositories/day/supabase_day_repository.dart`:
```dart
class SupabaseDayRepository implements DayRepository {
  @override
  Future<List<Day>> loadDays() async {
    final userId = GlobalAppState().currentUser.id!;

    final dayData = await supabase
        .from('days')
        .select('*,days_users_relation(*)')
        .eq('days_users_relation.user_id', userId)
        .eq('is_deleted', false)
        .order('order_number', ascending: true);

    if (dayData.isEmpty) return [];

    final days = dayData.map((e) => Day.fromJson1(e)).toList();

    // Batch load lessons and exercises
    final ids = days.map((d) => d.id).toList();

    final lessonData = await supabase
        .from('lessons')
        .select('*')
        .eq('is_deleted', false)
        .inFilter('day_id', ids)
        .order('created_at', ascending: true);

    final exerciseData = await supabase
        .from('exercises')
        .select('*,exercises_users_relation(*)')
        .eq('is_deleted', false)
        .inFilter('day_id', ids)
        .order('created_at', ascending: true);

    final lessons = Lesson.fromJsonList(lessonData);
    final exercises = Exercise.fromJsonList1(exerciseData);

    return days.map((day) => day.copyWith(
      lessons: lessons.where((l) => l.dayId == day.id).toList(),
      exercises: exercises.where((e) => e.dayId == day.id).toList(),
    )).toList();
  }
}
```

Create the equivalent implementations for `Auth`, `Listening`, and `SpokenPattern` by moving the Supabase logic from the existing BLoCs verbatim. The BLoC logic itself does not change — only the Supabase calls move out.

**Done When:** Supabase implementations compile and pass manual testing. All BLoC logic is still identical.

---

### Step 2.4 — Inject Repositories into BLoCs

**Why:** Once BLoCs receive a repository through their constructor, they can be tested with mock repositories.

**How:**

Update `DayBloc`:
```dart
class DayBloc extends Bloc<DayEvent, DayState> {
  final DayRepository _repository; // injected

  DayBloc({DayRepository? repository})
      : _repository = repository ?? sl<DayRepository>(), // default to DI
        super(const DayState.initial()) {
    on<DayEvent>((event, emit) async {
      await event.when(
        loadDays: () => _mapLoadDaysToState(emit),
      );
    });
  }

  Future<void> _mapLoadDaysToState(Emitter<DayState> emit) async {
    emit(const DayState.loading());
    try {
      final days = await _repository.loadDays(); // no Supabase here
      emit(DayState.loaded(null, days));
    } on SocketException {
      emit(const DayState.socketError('Please check your connection.'));
    } catch (e, stack) {
      AppLogger.instance.error('DayBloc.loadDays', error: e, stackTrace: stack);
      emit(DayState.error(e.toString()));
    }
  }
}
```

Apply the same pattern to `AuthBloc`, `ListeningBloc`, and `SpokenPatternBloc`.

**Done When:** All BLoCs accept a repository parameter in their constructor. The app compiles and runs normally when no repository is passed (falls back to `sl<>()`).

---

### Step 2.5 — Write BLoC Unit Tests

**Why:** Validate that every event produces the correct state sequence without a network connection.

**How:**

Add to `pubspec.yaml`:
```yaml
dev_dependencies:
  bloc_test: ^9.1.7
  mocktail: ^1.0.4
```

Create `test/bloc/day_bloc_test.dart`:
```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockDayRepository extends Mock implements DayRepository {}

void main() {
  late MockDayRepository mockRepo;
  late DayBloc bloc;

  setUp(() {
    mockRepo = MockDayRepository();
    bloc = DayBloc(repository: mockRepo);
  });

  tearDown(() => bloc.close());

  group('DayBloc.loadDays', () {
    final fakeDays = [
      Day(id: 1, orderNumber: 1, createdAt: DateTime.now(),
          lessons: [], exercises: [], isComplete: false),
    ];

    blocTest<DayBloc, DayState>(
      'emits [loading, loaded] on success',
      build: () => bloc,
      setUp: () => when(() => mockRepo.loadDays())
          .thenAnswer((_) async => fakeDays),
      act: (b) => b.add(const DayEvent.loadDays()),
      expect: () => [
        const DayState.loading(),
        DayState.loaded(null, fakeDays),
      ],
    );

    blocTest<DayBloc, DayState>(
      'emits [loading, socketError] on SocketException',
      build: () => bloc,
      setUp: () => when(() => mockRepo.loadDays())
          .thenThrow(const SocketException('no connection')),
      act: (b) => b.add(const DayEvent.loadDays()),
      expect: () => [
        const DayState.loading(),
        isA<DayState>().having(
          (s) => s, 'socketError', isA<_SocketError>(),
        ),
      ],
    );

    blocTest<DayBloc, DayState>(
      'emits [loading, loaded with empty list] when no days returned',
      build: () => bloc,
      setUp: () => when(() => mockRepo.loadDays())
          .thenAnswer((_) async => []),
      act: (b) => b.add(const DayEvent.loadDays()),
      expect: () => [
        const DayState.loading(),
        const DayState.loaded(null, []),
      ],
    );
  });
}
```

Write equivalent tests for `AuthBloc`, `ListeningBloc`, `SpokenPatternBloc`.

**Run tests:**
```bash
flutter test test/bloc/
```

**Done When:** `flutter test` passes with zero failures. All BLoC events have at least a success case and a failure case covered.

---

### Step 2.6 — Write Model JSON Round-Trip Tests

**Why:** Models are the data contract with Supabase. Regressions in `fromJson`/`toJson` silently break the entire app.

**How:**

Create `test/models/day_model_test.dart`:
```dart
void main() {
  group('Day.fromJson', () {
    test('parses valid json correctly', () {
      final json = {
        'id': 1,
        'order_number': 3,
        'created_at': '2024-01-01T00:00:00.000Z',
        'lessons': [],
        'exercises': [],
        'is_complete': false,
      };
      final day = Day.fromJson(json);
      expect(day.id, 1);
      expect(day.orderNumber, 3);
    });

    test('toJson round-trip produces equivalent object', () {
      final day = Day(
        id: 1,
        orderNumber: 1,
        createdAt: DateTime(2024),
        lessons: [],
        exercises: [],
        isComplete: false,
      );
      final day2 = Day.fromJson(day.toJson());
      expect(day2, day);
    });
  });
}
```

Write for every model in `lib/model/`.

**Done When:** All model round-trip tests pass. `flutter test test/models/` green.

---

### Step 2.7 — Add `AppLogger` Abstraction

**Why:** Replace 50+ `debugPrint` calls with a structured logger that reports errors to Crashlytics in production and does nothing in release for debug-level messages.

**How:**

Create `lib/core/logger/app_logger.dart`:
```dart
abstract class AppLogger {
  static AppLogger? _instance;
  static AppLogger get instance => _instance!;
  static void init(AppLogger logger) => _instance = logger;

  void debug(String message, {String? tag});
  void info(String message, {String? tag});
  void warning(String message, {String? tag});
  void error(String message, {Object? error, StackTrace? stackTrace, String? tag});
}
```

Create `lib/core/logger/dev_logger.dart`:
```dart
import 'package:flutter/foundation.dart';

class DevLogger extends AppLogger {
  @override
  void debug(String message, {String? tag}) =>
      debugPrint('[DEBUG][${tag ?? ''}] $message');

  @override
  void info(String message, {String? tag}) =>
      debugPrint('[INFO][${tag ?? ''}] $message');

  @override
  void warning(String message, {String? tag}) =>
      debugPrint('[WARN][${tag ?? ''}] $message');

  @override
  void error(String message, {Object? error, StackTrace? stackTrace, String? tag}) =>
      debugPrint('[ERROR][${tag ?? ''}] $message — $error\n$stackTrace');
}
```

Create `lib/core/logger/crashlytics_logger.dart`:
```dart
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashlyticsLogger extends AppLogger {
  @override
  void debug(String message, {String? tag}) {} // no-op in prod

  @override
  void info(String message, {String? tag}) {}

  @override
  void warning(String message, {String? tag}) {
    FirebaseCrashlytics.instance.log('[WARN][${tag ?? ''}] $message');
  }

  @override
  void error(String message, {Object? error, StackTrace? stackTrace, String? tag}) {
    FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      reason: '[${tag ?? ''}] $message',
      fatal: false,
    );
  }
}
```

In `main()`:
```dart
const env = String.fromEnvironment('flavor', defaultValue: 'dev');
AppLogger.init(env == 'prod' ? CrashlyticsLogger() : DevLogger());
```

Then do a project-wide replacement of all `debugPrint(...)` → `AppLogger.instance.debug(...)`.

**Done When:** Zero `debugPrint` calls remain in `lib/`. All error catches use `AppLogger.instance.error(...)`. Build compiles.

---

## Phase 3 — Architecture Cleanup
### Goal: Remove the structural anti-patterns that cause bugs and limit scalability.
### Duration: 2–4 weeks
### Risk: Medium-High — touches many files, do one item at a time with testing between.

---

### Step 3.1 — Replace `GlobalAppState` with `get_it`

**Why:** `GlobalAppState` is an invisible dependency. BLoCs that use it cannot be tested. State changes in it do not notify BLoCs automatically.

**How:**

1. Register `AppUser` as a mutable singleton in `get_it`:
   ```dart
   // In service_locator.dart
   sl.registerLazySingleton<ValueNotifier<AppUser>>(
     () => ValueNotifier<AppUser>(AppUser.empty()),
   );
   ```

2. In `AuthBloc`, after successful login/authCheck, update via `sl`:
   ```dart
   sl<ValueNotifier<AppUser>>().value = appUser;
   ```

3. Replace all `GlobalAppState().currentUser` accesses with `sl<ValueNotifier<AppUser>>().value`.

4. Remove `GlobalAppState` class entirely once all references are migrated.

5. Keep `deviceID` as a separate `sl.registerLazySingleton<String?>(() => null)` with a setter, or pass it directly to `AuthRepository`.

**Done When:** `GlobalAppState` is deleted. Project compiles. Login flow works. All BLoC tests still pass.

---

### Step 3.2 — Remove Local BLoC Instantiation from Screens

**Why:** BLoCs created inside widget `State` classes are inaccessible to child widgets and break the BLoC tree contract.

**File:** `lib/screens/days/spoken_pattern/spoken_pattern_screen.dart`

**How:**

Before (wrong):
```dart
class _SpokenPatternScreenState extends State<SpokenPatternScreen> {
  final _spokenPatternBloc = SpokenPatternBloc();
  final _audioPositionTrackerBloc = AudioPlayerBloc();
  final _audioPlayerStateTrackerBloc = AudioPlayerBloc();
```

After (correct):
```dart
// In SpokenPatternScreen.build(), wrap with BlocProviders:
return BlocProvider<SpokenPatternBloc>(
  create: (_) => SpokenPatternBloc(repository: sl<SpokenPatternRepository>())
    ..add(SpokenPatternEvent.loadPatternsByLesson(widget.lesson.id)),
  child: BlocProvider<AudioPlayerBloc>(
    create: (_) => AudioPlayerBloc(),
    child: _SpokenPatternBody(lesson: widget.lesson, audioPlayer: _audioPlayer),
  ),
);
```

All child widgets can now access both BLoCs via `context.read<SpokenPatternBloc>()`.

Apply the same fix to any other screen that instantiates BLoCs in `State`.

**Done When:** No BLoC instance is created inside a widget `State` class. All BLoCs accessed via `context.read<>()` or `sl<>()`.

---

### Step 3.3 — Cache `SharedPreferences` Instance

**Why:** Calling `SharedPreferences.getInstance()` on every read/write is an unnecessary async operation.

**File:** `lib/services/share_preference_utils.dart`

**How:**

```dart
class SharedPreferenceUtils {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get _instance {
    assert(_prefs != null, 'SharedPreferenceUtils.init() must be called before use.');
    return _prefs!;
  }

  static Future<void> saveString(String key, String value) async {
    await _instance.setString(key, value);
  }

  static String? getString(String key) => _instance.getString(key);

  static Future<void> saveInt(String key, int value) async {
    await _instance.setInt(key, value);
  }

  static int? getInt(String key) => _instance.getInt(key);

  static Future<void> saveBool(String key, bool value) async {
    await _instance.setBool(key, value);
  }

  static bool? getBool(String key) => _instance.getBool(key);

  static Future<void> remove(String key) async => _instance.remove(key);

  static Future<void> clear() async => _instance.clear();
}
```

Call `SharedPreferenceUtils.init()` in `main()`:
```dart
await SharedPreferenceUtils.init();
```

Note: The getters are now synchronous because `SharedPreferences` caches values in memory after loading.

**Done When:** All `SharedPreferenceUtils` methods are synchronous where possible. `init()` called in `main()`. All existing callers compile.

---

### Step 3.4 — Fix N+1 DB Queries for Examples

**Why:** Loading 20 examples fires 20 separate SQLite queries. A single batch query is both faster and cleaner.

**File:** `lib/bloc/spoken_pattern/spoken_pattern_bloc.dart` (or the repository once Step 2.3 is done)

**How:**

Before:
```dart
final updatedExamples = await Future.wait(
  examples.map((example) async {
    final data = await (AppDatabase.instance().userExampleAnswerTable.select()
          ..where((tbl) => tbl.exampleId.equals(example.id)))
        .getSingleOrNull();
    return example.copyWith(userAnswer: data?.userAnswer);
  }),
);
```

After:
```dart
final ids = examples.map((e) => e.id).toList();
final answers = await (AppDatabase.instance().userExampleAnswerTable.select()
      ..where((tbl) => tbl.exampleId.isIn(ids)))
    .get();

final answerMap = {for (final a in answers) a.exampleId: a.userAnswer};
final updatedExamples = examples
    .map((e) => e.copyWith(userAnswer: answerMap[e.id]))
    .toList();
```

**Done When:** Loading 20 examples triggers exactly 2 DB operations (1 for Supabase remote examples, 1 for local answers). Verify with a `debugPrint` count before and after.

---

### Step 3.5 — Replace `IndexedStack` with `PageView.builder`

**Why:** `IndexedStack` renders all children simultaneously and holds them all in memory. With 30+ spoken patterns, this is significant memory waste.

**File:** `lib/screens/days/spoken_pattern/spoken_pattern_screen.dart`

**How:**

Add a `PageController`:
```dart
final _pageController = PageController();
```

Replace the `IndexedStack`:
```dart
// Before:
IndexedStack(
  index: _currentPage,
  children: List.generate(
    spokenPatterns.length,
    (index) => SpokenPatternWidget(spokenPattern: spokenPatterns[index]),
  ),
)

// After:
PageView.builder(
  controller: _pageController,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: spokenPatterns.length,
  itemBuilder: (context, index) => SpokenPatternWidget(
    spokenPattern: spokenPatterns[index],
  ),
)
```

Update `onPageChanged` in `FooterWidget`:
```dart
onPageChanged: (newPage) {
  _audioPlayer.stop();
  _pageController.jumpToPage(newPage);
  setState(() => _currentPage = newPage);
},
```

Dispose the controller:
```dart
@override
void dispose() {
  _pageController.dispose();
  // ...
}
```

Apply the same change to `DayListScreen`.

**Done When:** Navigating between patterns builds one widget at a time. Memory profiler shows only current + adjacent pages in memory.

---

### Step 3.6 — Eliminate `Day.fromJson1`

**Why:** Two parsing methods on the same model is one source of truth too many.

**How:**

After Step 2.3, the repository handles the Supabase join shape. The `fromJson1` factory is only called in the repository. Move its logic into `SupabaseDayRepository` and use the standard `fromJson` everywhere:

In `SupabaseDayRepository.loadDays()`:
```dart
// Parse the raw Supabase response inline in the repository
final days = dayData.map((json) => Day(
  id: json['id'] as int,
  orderNumber: json['order_number'] as int,
  createdAt: DateTime.parse(json['created_at'] as String),
  isComplete: (json['days_users_relation'] as List).isNotEmpty,
  lessons: [],    // populated below
  exercises: [],
)).toList();
```

Then delete `Day.fromJson1` from `lib/model/day/day.dart`. Run `dart run build_runner build`.

**Done When:** `fromJson1` does not exist. `git grep "fromJson1"` returns zero results. `flutter test` passes.

---

### Step 3.7 — Fix `Listening` Model Nullable Paths

**Why:** If Supabase returns `null` for any path field (content not yet uploaded), `fromJson` throws and crashes the listening list screen.

**File:** `lib/model/listening/listening.dart`

**How:**
```dart
@freezed
class Listening with _$Listening {
  const factory Listening({
    required int id,
    required String title,
    required String thumbnail,
    required int start,
    required int end,
    @JsonKey(name: 'mm_subtitle') required bool hasMMSubtitle,
    @JsonKey(name: 'has_vocabularies') required bool hasVocabularies,
    @JsonKey(name: 'youtube_id') required String youtubeId,
    @JsonKey(name: 'subtitle_path') @Default('') String subtitlePath,
    @JsonKey(name: 'multiple_choice_path') @Default('') String multipleChoicePath,
    @JsonKey(name: 'shadowing_path') @Default('') String shadowingPath,
    @JsonKey(name: 'record_subtitle_path') @Default('') String recordSubtitlePath,
    @JsonKey(name: 'sentence_explanation_path') @Default('') String sentenceExplanationPath,
    @JsonKey(name: 'listening_category_id') int? listeningCategoryId,
  }) = _Listening;
  // ...
}
```

Run `dart run build_runner build --delete-conflicting-outputs`.

Then update `_normalizePath` in `ListeningBloc` to return `null` for empty paths:
```dart
String? _normalizePath(String path) {
  if (path.isEmpty) return null;
  return Env.bunnyListeningAPIKey + path.replaceFirst('bunny/', '');
}
```

Update `Listening` path fields to `String?` in callers.

**Done When:** Loading a listening item where `subtitle_path` is null does not throw. The feature gracefully hides subtitle-dependent UI.

---

### Step 3.8 — Fix `AppUIBloc` Event Bus

**Why:** `AppUIBloc` couples AI practice reloads and listening reloads in one BLoC. As features grow, this becomes unmanageable.

**How:**

Delete `AppUIBloc` after confirming usage:
```bash
git grep "AppUIBloc"
```

For each screen that listens for `onReloadListeningPracticeList`:
- Add a dedicated method `refresh()` in `ListeningBloc` instead
- Call `context.read<ListeningBloc>().add(const ListeningEvent.loadListenings())` directly

For AI practice reloads, add a similar event to `AiSentencePracticeBloc`.

Remove `AppUIBloc` from `main_providers.dart` and delete the file.

**Done When:** `AppUIBloc` file is deleted. All reload functionality works through feature-scoped BLoCs.

---

## Phase 4 — Performance & Scale
### Goal: Prepare the app for 100,000 users with efficient data loading and CDN security.
### Duration: Ongoing — implement one item per sprint.

---

### Step 4.1 — Add Pagination to Day List

**Why:** Loading all days in one query will be slow as content grows. Supabase supports range-based pagination natively.

**How:**

Update `DayRepository`:
```dart
abstract class DayRepository {
  Future<List<Day>> loadDays({int from = 0, int to = 19});
}
```

Update `SupabaseDayRepository`:
```dart
@override
Future<List<Day>> loadDays({int from = 0, int to = 19}) async {
  final dayData = await supabase
      .from('days')
      .select('*,days_users_relation(*)')
      .eq('is_deleted', false)
      .order('order_number', ascending: true)
      .range(from, to); // paginate
  // ... rest unchanged
}
```

In `DayBloc`, add a `loadMoreDays` event and track `_currentPage`. In `DayListScreen`, use `ScrollController` to detect end-of-list and trigger `loadMoreDays`.

**Done When:** First 20 days load immediately. Scrolling to the bottom loads the next 20. No full reload on screen open.

---

### Step 4.2 — Add Offline-First Drift Caching for Days

**Why:** Currently every cold start makes a full Supabase network round-trip to load days. With offline caching, users see content instantly and can use the app without internet.

**How:**

Add a Drift table for days:
```dart
// lib/tables/day_cache_table.dart
class DayCacheTable extends Table {
  IntColumn get id => integer()();
  TextColumn get jsonData => text()(); // store full JSON blob
  DateTimeColumn get cachedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}
```

Update `SupabaseDayRepository`:
```dart
@override
Future<List<Day>> loadDays({int from = 0, int to = 19}) async {
  // 1. Try cache first
  final cached = await AppDatabase.instance().dayCacheTable
      .select().get();
  if (cached.isNotEmpty) {
    _refreshInBackground(); // fetch fresh data without blocking UI
    return cached.map((row) => Day.fromJson(jsonDecode(row.jsonData))).toList();
  }
  // 2. No cache — fetch from network
  return _fetchAndCache(from: from, to: to);
}
```

**Done When:** Opening the day list screen with no internet shows previously cached content. A network indicator shows when fresh data is loading in background.

---

### Step 4.3 — Add Firebase Analytics

**Why:** You have no visibility into which features users actually use, how far they progress, or where they drop off.

**How:**

Add dependency:
```yaml
dependencies:
  firebase_analytics: ^11.3.0
```

Create `lib/core/analytics/app_analytics.dart`:
```dart
import 'package:firebase_analytics/firebase_analytics.dart';

class AppAnalytics {
  static final _analytics = FirebaseAnalytics.instance;

  static Future<void> lessonStarted({
    required int lessonId,
    required int dayId,
  }) => _analytics.logEvent(
    name: 'lesson_started',
    parameters: {'lesson_id': lessonId, 'day_id': dayId},
  );

  static Future<void> lessonCompleted({
    required int lessonId,
    required int patternCount,
  }) => _analytics.logEvent(
    name: 'lesson_completed',
    parameters: {'lesson_id': lessonId, 'pattern_count': patternCount},
  );

  static Future<void> exercisePassed({
    required int exerciseId,
    required int dayId,
  }) => _analytics.logEvent(
    name: 'exercise_passed',
    parameters: {'exercise_id': exerciseId, 'day_id': dayId},
  );

  static Future<void> exerciseFailed({
    required int exerciseId,
    required int dayId,
  }) => _analytics.logEvent(
    name: 'exercise_failed',
    parameters: {'exercise_id': exerciseId, 'day_id': dayId},
  );

  static Future<void> listeningSessionStarted({
    required int listeningId,
    required String type, // 'vocabulary', 'sentence_practice', 'shadowing'
  }) => _analytics.logEvent(
    name: 'listening_session_started',
    parameters: {'listening_id': listeningId, 'type': type},
  );

  static Future<void> speechRecorded({required int listeningId}) =>
      _analytics.logEvent(
        name: 'speech_recorded',
        parameters: {'listening_id': listeningId},
      );

  static Future<void> loginSuccess() =>
      _analytics.logLogin(loginMethod: 'email');

  static Future<void> loginFailed({required String reason}) =>
      _analytics.logEvent(
        name: 'login_failed',
        parameters: {'reason': reason},
      );
}
```

Call these methods from the appropriate screens/BLoCs.

**Done When:** Firebase Analytics dashboard shows events within 24 hours of production deployment. All 9 key events from the event table are tracked.

---

### Step 4.4 — Implement Firebase Remote Config for Business Constants

**Why:** `maxTotalTokens = 500000` is hardcoded. Changing it requires a new release. Remote Config lets you change it instantly without a build.

**How:**

Add dependency:
```yaml
dependencies:
  firebase_remote_config: ^5.1.0
```

Create `lib/core/remote_config/app_remote_config.dart`:
```dart
import 'package:firebase_remote_config/firebase_remote_config.dart';

class AppRemoteConfig {
  static final _rc = FirebaseRemoteConfig.instance;

  static Future<void> init() async {
    await _rc.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await _rc.setDefaults({'max_total_tokens': 500000});
    await _rc.fetchAndActivate();
  }

  static int get maxTotalTokens => _rc.getInt('max_total_tokens');
}
```

In `main()`:
```dart
await AppRemoteConfig.init();
```

Replace `GlobalAppState.maxTotalTokens` with `AppRemoteConfig.maxTotalTokens`.

**Done When:** Changing `max_total_tokens` in Firebase console takes effect in the app within 1 hour without a new build.

---

### Step 4.5 — Set Up CI/CD with GitHub Actions

**Why:** Manual releases are slow and error-prone. Automated pipelines catch regressions on every pull request.

**How:**

Create `.github/workflows/ci.yml`:
```yaml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
          cache: true
      - name: Install dependencies
        run: flutter pub get
      - name: Run analysis
        run: flutter analyze
      - name: Run tests
        run: flutter test --coverage
      - name: Upload coverage
        uses: codecov/codecov-action@v4

  build-dev:
    runs-on: ubuntu-latest
    needs: test
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
      - name: Build dev APK
        env:
          SUPABASE_URL: ${{ secrets.SUPABASE_URL_DEV }}
          SUPABASE_ANON_KEY: ${{ secrets.SUPABASE_ANON_KEY_DEV }}
        run: |
          echo "SUPABASE_URL=$SUPABASE_URL" > .envs/.env.dev
          echo "SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY" >> .envs/.env.dev
          flutter build apk --flavor dev --dart-define flavor=dev
```

Store all secrets in **GitHub → Settings → Secrets and Variables → Actions**, not in any file.

**Done When:** Every PR runs `flutter analyze` and `flutter test` automatically. A failing test blocks merge.

---

### Step 4.6 — Sign Bunny CDN URLs

**Why:** Current CDN URLs are permanent and publicly accessible. Any user who extracts the URL can share premium audio forever without a subscription.

**How:**

This is a backend change. In your Supabase Edge Functions or backend:

1. Enable token authentication in the Bunny CDN dashboard for your storage zones.
2. Create a Supabase Edge Function `sign-cdn-url` that generates a time-limited token:
   ```typescript
   // supabase/functions/sign-cdn-url/index.ts
   const expiresAt = Math.floor(Date.now() / 1000) + 3600; // 1 hour
   const path = req.json().path;
   const token = createHmac('sha256', BUNNY_SECRET_KEY)
     .update(`${BUNNY_SECURITY_KEY}${path}${expiresAt}`)
     .digest('hex');
   return `${BASE_URL}${path}?token=${token}&expires=${expiresAt}`;
   ```
3. In the Flutter app, call this Edge Function to get a signed URL before playing any audio.
4. Cache signed URLs in memory for their valid duration to avoid repeated signing calls.

**Done When:** CDN URLs expire after 1 hour. Sharing an extracted URL after it expires returns `403 Forbidden`.

---

## Progress Tracker

| Phase | Step | Status | Owner |
|-------|------|--------|-------|
| 1 | 1.1 Rotate API key | ⬜ Todo | |
| 1 | 1.2 Remove `.env` from git | ⬜ Todo | |
| 1 | 1.3 Install gitleaks | ⬜ Todo | |
| 1 | 1.4 Fix AudioPlayerBloc.stop() | ✅ Done | |
| 1 | 1.5 Fix dangling Supabase filter | ✅ Done | |
| 1 | 1.6 Add Env.validate() | ✅ Done | |
| 1 | 1.7 Add Firebase Crashlytics | ✅ Done | |
| 1 | 1.8 Enable release obfuscation | ✅ Done | |
| 1 | 1.9 Delete dead code files | ✅ Done | |
| 1 | 1.10 Fix typos | ✅ Done | |
| 2 | 2.1 Wire up get_it | ⬜ Todo | |
| 2 | 2.2 Create repository interfaces | ⬜ Todo | |
| 2 | 2.3 Implement Supabase repositories | ⬜ Todo | |
| 2 | 2.4 Inject repositories into BLoCs | ⬜ Todo | |
| 2 | 2.5 Write BLoC unit tests | ⬜ Todo | |
| 2 | 2.6 Write model JSON tests | ⬜ Todo | |
| 2 | 2.7 Add AppLogger abstraction | ⬜ Todo | |
| 3 | 3.1 Replace GlobalAppState | ⬜ Todo | |
| 3 | 3.2 Remove local BLoC instantiation | ⬜ Todo | |
| 3 | 3.3 Cache SharedPreferences | ⬜ Todo | |
| 3 | 3.4 Fix N+1 DB queries | ⬜ Todo | |
| 3 | 3.5 Replace IndexedStack | ⬜ Todo | |
| 3 | 3.6 Eliminate Day.fromJson1 | ⬜ Todo | |
| 3 | 3.7 Fix Listening nullable paths | ⬜ Todo | |
| 3 | 3.8 Fix AppUIBloc event bus | ⬜ Todo | |
| 4 | 4.1 Paginate day list | ⬜ Todo | |
| 4 | 4.2 Offline Drift caching | ⬜ Todo | |
| 4 | 4.3 Firebase Analytics | ⬜ Todo | |
| 4 | 4.4 Firebase Remote Config | ⬜ Todo | |
| 4 | 4.5 CI/CD GitHub Actions | ⬜ Todo | |
| 4 | 4.6 Sign CDN URLs | ⬜ Todo | |

---

*This document should be updated as steps are completed. Reference `CODE_REVIEW.md` for the analysis behind each decision.*
