# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Flutter toolchain (IMPORTANT)

This project is pinned to **Flutter 3.35.6** via FVM (see [.fvmrc](.fvmrc) and [.fvm/flutter_sdk](.fvm/flutter_sdk)). The machine's global `flutter` on PATH may be a different version (e.g. 3.32.4), which will produce an incompatible `pubspec.lock` and break the build (symptoms: `vector_math` downgraded to 2.1.4, `SemanticsRole.searchBox` / `elevation` errors in framework files).

**Never run the global `flutter` or `dart` commands.** Always use the FVM-pinned toolchain:

- Preferred: `fvm flutter ...` / `fvm dart ...`
- Fallback (if fvm is not on PATH): `.fvm/flutter_sdk/bin/flutter ...` / `.fvm/flutter_sdk/bin/dart ...`

This applies to **every** invocation — `run`, `build`, `test`, `analyze`, `pub get`, `pub upgrade`, `format`, and code generation via `dart run build_runner ...`. Running the wrong Flutter version even once (especially anything that triggers an implicit `pub get`, like `flutter analyze`) will rewrite `pubspec.lock` with versions incompatible with the pinned SDK.

If `pubspec.lock` has been clobbered, recover with:
```bash
git checkout pubspec.lock
fvm flutter pub get   # or: .fvm/flutter_sdk/bin/flutter pub get
```

## Build & Run Commands

```bash
# Run with dev flavor (default)
fvm flutter run --dart-define flavor=dev -t lib/main.dart

# Run with prod flavor
fvm flutter run --flavor prod --dart-define flavor=prod -t lib/main.dart

# Build APK (release, prod flavor)
fvm flutter build apk \
  --release \
  --flavor prod \
  -t lib/main.dart \
  --dart-define flavor=prod \
  --obfuscate \
  --split-debug-info=build/symbols/ \
  --build-name 1.0.0 \
  --build-number 1
# After building, upload symbols to Crashlytics:
# firebase crashlytics:symbols:upload --app=YOUR_APP_ID build/symbols/

# Run tests
fvm flutter test

# Run a single test file
fvm flutter test test/path/to/test_file.dart

# Lint
fvm flutter analyze

# Regenerate code (freezed, json_serializable, drift)
fvm dart run build_runner build --delete-conflicting-outputs

# Watch for changes (during development)
fvm dart run build_runner watch --delete-conflicting-outputs
```

## Release (Fastlane)

```bash
fastlane android release env:dev c:1 n:0.0.1
fastlane android release env:prod c:1 n:1.0.0
```

## Architecture Overview

**Flutter + BLoC** app targeting Android (and iOS). Two build flavors: `dev` and `prod`.

### Entry Point & App Initialization (`lib/main.dart`)
- Reads `flavor` dart-define to select environment
- Loads env file from `.envs/.env.<flavor>`
- Initializes Supabase (backend), Firebase (notifications), and device info
- Runs `SpeakCraftApp`

### State Management: flutter_bloc + Freezed
All BLoCs live in `lib/bloc/`. Events and states use `@freezed` annotations (generated `.freezed.dart` files). The pattern is:
- Define `@freezed` event/state classes with `part '<name>.freezed.dart'`
- BLoC handles events via `event.when(...)` pattern
- Global BLoCs (auth, day, spokenPattern, exercise, appUI, internetChecker) are provided at the root via `mainBlocProviders()` in `lib/main_providers.dart`

### Backend: Supabase
- Singleton client via `lib/services/supabase_service.dart`: `final supabase = Supabase.instance.client`
- Auth is Supabase email/password. Premium check (`isPremiumUser`) and device-lock logic run on every auth check.
- Storage buckets accessed via `SupabaseBucketFolders` enum (spoken-patterns, listening-and-shadowing)

### Global Singleton State
`GlobalAppState` (`lib/global_app_state.dart`) is a singleton that holds:
- `currentUser` — a `ValueNotifier<AppUser>` for reactive UI updates
- `deviceID` — used for single-device enforcement
- `isOnline` — set by internet connection checker
- `maxTotalTokens` (500,000) — token limit for AI features

### Routing
All routes are defined as string constants in `lib/config/pmp_routes.dart` with a `generateRoutes` switch. Arguments are passed as `Map<String, dynamic>` via `settings.arguments`.

### Data Models
All models live in `lib/model/<name>/`. Each model file has:
- `<name>.dart` — the `@freezed` class with `fromJson`/`toJson`
- `<name>.freezed.dart` — generated (do not edit)
- `<name>.g.dart` — generated JSON serializer (do not edit)

Key models: `Day`, `Lesson`, `Exercise`, `SpokenPattern`, `Listening`, `Subtitle`, `SentenceExplanation`, `AppUser`, `AiSentencePractice`

### Local Database: Drift
Table definitions are in `lib/tables/`. Drift is used for local storage of user answers and AI practice results (e.g., `AiSentencePracticeTable`, `ListeningPracticeAnswerTable`).

### App Modules (Home Screen)
The app has two main learning modules:
1. **Useful Spoken Patterns** (`/day_list`) — Day-based spoken pattern lessons with exercises
2. **Listening & Shadowing** (`/listening`) — Audio/video listening with subtitle synchronization, shadowing, and speech practice

### Screens Structure
```
lib/screens/
  auth/           — Login, SignUp
  days/           — Day list, spoken pattern pages, exercises
  listening_and_shadowing/ — Listening list, shadowing, sentence practice, speech sessions
  main/           — Home, Profile, version/free-user gates
  practice_with_ai/ — AI sentence practice (currently commented out in home)
  onboarding/     — Splash screen
```

### Design System
- `lib/config/pmp_colors.dart` — All color constants (`PmpColors`)
- `lib/config/pmp_text_styles.dart` — Text style constants (`PmpTextStyles`)
- `lib/config/pmp_themes.dart` — Dark theme only (`PmpThemes.darkTheme`), uses Material 3 with Google Fonts Inter
- `lib/shared_widgets/` — Reusable widgets (MainScaffold, dialogs, etc.)

### Environment
Flavor is passed as a dart-define (`--dart-define flavor=dev`). `lib/config/env.dart` reads from `flutter_dotenv`. Firebase options are split into `lib/firebase_options.dart` (prod) and `lib/firebase_options_dev.dart` (dev).

### Localization
Generated to `lib/l10n/generated/` via `flutter_intl`. Main locale is `en`. Class name is `AppLocalizations`.

## Code Generation
After modifying any `@freezed` model/bloc or `@JsonSerializable` class or Drift table, always regenerate:
```bash
dart run build_runner build --delete-conflicting-outputs
```
Never manually edit `*.freezed.dart` or `*.g.dart` files.
