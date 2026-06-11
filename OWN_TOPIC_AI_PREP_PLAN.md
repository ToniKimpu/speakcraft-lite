# Own-Topic AI Prep — Implementation Guide

> **For the implementing agent:** Read this top-to-bottom before touching code. Then read
> `lib/screens/daily_speaking/CLAUDE.md` (module guide) and the root `CLAUDE.md` (toolchain).
> This feature upgrades the **own-topic** on-ramp of the Daily Speaking module from a bare
> text label into an **AI-scaffolded prep** that reuses the existing suggested-topic prep UI.
> **No edge function / no Gemini key yet — build everything behind a stub** (module convention).

## Toolchain (do not skip)

This repo is pinned to **Flutter 3.35.6 via FVM**. **Never run global `flutter`/`dart`.**
Use the FVM binary. Per the project's own note, prefer the **direct binary**, not the `fvm`
wrapper (the wrapper has broken pub resolution here):

```
.fvm/flutter_sdk/bin/flutter pub get
.fvm/flutter_sdk/bin/dart run build_runner build --delete-conflicting-outputs
.fvm/flutter_sdk/bin/flutter analyze
```

After editing any `@freezed` / `@JsonSerializable` model or Drift table → **regenerate** with
build_runner. Never hand-edit `*.freezed.dart` / `*.g.dart`.

---

## What we're building (the flow)

```
own_topic_prep_page  (EXISTING — type topic OR tap a starter chip)
        │
        ├─ "Record now"  ───────────────────────────┐   (skip prep; existing behavior)
        │                                            │
        └─ "Help me prepare"  (NEW primary button)   │
                │ fires expandTopic AI call           │
                ▼                                     │
   own_topic_scaffold_page  (NEW — ~90% reuse of SuggestedTopicPrepPage)
   ┌────────────────────────────────────────────┐    │
   │ Prompt card (the user's topic)             │    │
   │ Words you might use        [vocab chips]   │    │ targetPhrases flow through
   │ Try to use these phrases   [phrase cards]  │    │ as the suggested on-ramp's do
   │ Things you can mention     [• bullets]     │    │
   │ ── follow-up asks (chips) ──               │    │
   │ [More vocab][How to start][Useful phrases] │    │
   │ [Harder words]                             │    │
   │ "Start recording" ─────────────────────────┼────┤
   └────────────────────────────────────────────┘    │
                                                      ▼
                                      own_topic_record_page  (EXISTING)
                                      now also receives the scaffolded topic
                                      (with vocab/phrases filled in)
                                                      │
                                                      ▼
                              choose feedback → AI review → feedback_result_page
                              + target-phrase checklist (✅used / ⬜missed)  ← NEW for own-topic
```

**Key reuse insight:** `DailySpeakingTopic` (`lib/model/daily_speaking/daily_speaking_topic.dart`)
**already has** `vocabulary`, `targetPhrases`, `warmupQuestions`, `durationTargetSeconds`. Today
own-topic builds a synthetic topic with those empty (`id: 'own'`). The AI "expand" call simply
**fills those fields**. So `SuggestedTopicPrepPage` can render an own topic almost unchanged, and
because the topic now carries `targetPhrases`, the existing suggested-path checklist plumbing
gives own-topic the ✅/⬜ checklist for free.

---

## Confirmed product decisions (do not re-litigate)

1. **Interaction = scaffold + canned asks** (NOT a free-form chatbot). One-shot scaffold first,
   then a small set of constrained follow-up chips. Each chip is a *typed* request, not free text.
2. **Unify the checklist:** scaffold `targetPhrases` become the feedback checklist, same as suggested.
3. **Everyone gets it** — no premium gating on prep. (Free recording cap already drives conversion.)
4. **Level-agnostic for MVP** — do NOT pass a CEFR/level param to the expand call yet.
5. **Stub-first** — `useStubResponse` switch, no edge function in this branch.
6. **Optional** — "Record now" must still let users skip prep entirely.

## Budget rules (must be honored in the contract, enforced server-side later)

- Prep is **text-only** (~2k tokens ≈ $0.0005), ~8× cheaper than an audio practice (~12–13k).
- The **practices quota (5 premium / 1 free) is decremented ONLY by the audio feedback call.**
  Prep does **NOT** consume a practice.
- Prep gated only by a loose anti-abuse ceiling (server-side, later): premium ~15 prep-gen/day,
  free ~3/day; **max 3 follow-up asks per topic** either tier.
- **Cache the scaffold per topic** so re-opening prep / "Polish & retry" costs zero new tokens.
- **No prep counter in the UI.** Only surface a gentle message if the ceiling is ever hit.
- The future edge function must branch on **call kind** (practice vs prep) and decrement the right
  counter. For THIS branch (stub only), just leave a clear TODO + the request shape ready.

---

## Files — create / modify

### NEW

| File | Purpose |
|---|---|
| `lib/bloc/daily_speaking/daily_speaking_prep_bloc.dart` | Owns the `expandTopic` call + loading/result/error state + follow-up-ask appends. `@freezed` events/states, `part` file regenerated. |
| `lib/screens/daily_speaking/own_topic/own_topic_scaffold_page.dart` | The new prep/scaffold screen. Mirror `suggested/suggested_topic_prep_page.dart`; add follow-up ask chips + loading + error/retry. |
| `assets/daily_speaking/prep/` stub data (optional) | If you prefer the stub to read canned JSON instead of inline Dart. Inline Dart constant is simpler — match the feedback stub style. |

### MODIFY

| File | Change |
|---|---|
| `lib/services/daily_speaking/daily_speaking_service.dart` | Add `Future<DailySpeakingTopic> expandTopic({required String topicText})`. Same `useStubResponse` switch: stub returns a canned filled topic; real `else` posts to a `daily-speaking-prep` edge fn (leave as TODO, shape below). |
| `lib/services/daily_speaking/daily_speaking_service_stubs.dart` | Add a canned expanded `DailySpeakingTopic` (and 1–2 small "ask" deltas). Keep it deletable like the feedback stubs. |
| `lib/screens/daily_speaking/own_topic/own_topic_prep_page.dart` | Replace the single "Record this" CTA with two buttons: **Help me prepare** (primary → scaffold page) and **Record now** (secondary → existing record route). Keep the text field + starter chips. |
| `lib/config/pmp_routes.dart` | Add `dailySpeakingOwnTopicScaffold = '/daily_speaking/own_topic/scaffold'` and a `case` in `generateRoutes` that reads `topic` (the bare typed topic) from args and builds `OwnTopicScaffoldPage`. |
| `lib/main_providers.dart` | Provide `DailySpeakingPrepBloc`. Prefer **page-scoped** (like `DailySpeakingTopicBloc`) via a `BlocProvider` wrapping the scaffold page rather than a global, since prep only matters inside this flow. |
| `lib/l10n/intl_en.arb` | Add all new `txtDs*` strings (see Localization). Then regenerate l10n. |
| `lib/screens/daily_speaking/CLAUDE.md` | Update the on-ramp table + flow doc: own-topic now scaffolds via AI and DOES carry `targetPhraseResults`. |

> Note the existing route names: `dailySpeakingOwnTopicPrep` (`.../own_topic/prep`) and
> `dailySpeakingOwnTopicRecord` (`.../own_topic/record`) already exist. The record page already
> accepts `topic`, `topicAttemptId`, `revisionNumber` — pass the **scaffolded** topic into it.

---

## The prep BLoC (sketch)

Mirror the freezed event/state idiom used across `lib/bloc/daily_speaking/`:

```dart
@freezed
class DailySpeakingPrepEvent with _$DailySpeakingPrepEvent {
  const factory DailySpeakingPrepEvent.expand(String topicText) = _Expand;
  const factory DailySpeakingPrepEvent.askMore(PrepAskKind kind) = _AskMore;
  const factory DailySpeakingPrepEvent.reset() = _Reset;
}

@freezed
class DailySpeakingPrepState with _$DailySpeakingPrepState {
  const factory DailySpeakingPrepState.initial() = _Initial;
  const factory DailySpeakingPrepState.loading() = _Loading;       // first expand
  const factory DailySpeakingPrepState.loaded(
    DailySpeakingTopic topic, {
    @Default(false) bool asking,    // follow-up ask in flight (keep showing scaffold)
    @Default(0) int asksUsed,       // cap at 3
  }) = _Loaded;
  const factory DailySpeakingPrepState.error(String message) = _Error;
}
```

`PrepAskKind` enum: `moreVocab`, `usefulPhrases`, `howToStart`, `harderWords`. Each ask returns a
small delta the bloc merges into the current `topic` (append vocab / append phrases / append warmup
questions). Enforce the **3-asks cap** client-side as a UX guard (server enforces for real later).

- Inject `DailySpeakingService` like `DailySpeakingBloc` does (`service ?? DailySpeakingService()`).
- Error handling: copy the `_handleError` pattern from `daily_speaking_bloc.dart`
  (`SocketException` → socket error; `FunctionException` → "server busy"; else generic).
- **Caching:** keep the loaded `topic` in the bloc for the page's lifetime so navigating back from
  the recorder and returning doesn't refetch. (Cross-session Drift caching is out of scope for MVP —
  a TODO is fine; the practical win is in-session + the version loop reusing the already-built topic.)

### Service method (stub-first)

```dart
// in DailySpeakingService
Future<DailySpeakingTopic> expandTopic({required String topicText}) async {
  if (useStubResponse) {
    await Future<void>.delayed(const Duration(seconds: 2)); // match feedback stub feel
    return DailySpeakingServiceStubs.expandedTopic(topicText); // fills vocab/phrases/warmups
  }
  // TODO(real): supabase.functions.invoke('daily-speaking-prep', body: {
  //   'topic_text': topicText,
  //   // NO level param for MVP (level-agnostic).
  // }); parse into DailySpeakingTopic.fromJson(...). Must return id:'own', bilingual fields.
  throw UnimplementedError('daily-speaking-prep edge function not deployed');
}
```

The stub-built topic MUST keep `id: 'own'` (the sentinel the result/history screens use to tell
own-topic apart). Fill `title`/`promptEn` from `topicText`, and populate `vocabulary`
(`TopicVocabItem`: term + `definition_mm` + `example_en`), `targetPhrases` (`TopicTargetPhrase`:
`phrase_en` + `translation_mm`), and `warmupQuestions` with realistic Burmese-bilingual sample data
so the whole flow is demoable. (Burmese strings here are **data**, not localized UI — same as the
suggested topics JSON.)

---

## The scaffold page

Start from `lib/screens/daily_speaking/suggested/suggested_topic_prep_page.dart` — it already
renders prompt card + vocab chips (tap → bottom sheet) + target-phrase cards + warmup bullets with
the right section headers and theme. Differences for own-topic:

1. **Driven by BLoC state**, not a const topic. Wrap in `BlocBuilder<DailySpeakingPrepBloc, …>`:
   - `loading` → centered spinner + "Building your prep…" (`txtDs…`).
   - `error` → message + Retry button (re-dispatch `expand`) + a "Record without prep" escape.
   - `loaded` → the scaffold (reuse the suggested sections) + follow-up ask chips.
2. **Follow-up ask chips** (the "C" part) below the sections. Disable them once `asksUsed >= 3` or
   while `asking` is true. Each chip dispatches `DailySpeakingPrepEvent.askMore(kind)`.
3. **"Start recording"** CTA → `Navigator.pushReplacementNamed(dailySpeakingOwnTopicRecord, {
   'topic': <scaffolded topic from state> })`. Use `pushReplacement` so back doesn't return to a
   stale scaffold mid-record (suggested prep does the same).
4. You can extract the shared section widgets (`_PromptCard`, `_VocabChip`, `_TargetPhraseCard`,
   `_SectionHeader`) into a small shared widget file under `widgets/` and have BOTH prep pages use
   them — nice de-dup, but optional. If short on time, copy is acceptable; note it for cleanup.

The record page (`own_topic_record_page.dart`) needs **no change** — it already pins the topic
banner and forwards `topic` into choose-feedback. Because the topic now has `targetPhrases`, confirm
the choose-feedback → bloc → feedback path surfaces the checklist for own-topic the same way it does
for suggested (the checklist renders when `feedback.targetPhraseResults.isNotEmpty`; the stub already
keeps target-phrase results when `input.topic != null`). Just verify it lights up.

---

## Theme & design system — USE THESE, no raw literals

This app is **dark-theme, Material 3, Google Fonts Inter** (`PmpThemes.darkTheme`). Match the
surrounding daily-speaking screens exactly:

- **Colors:** pull from `Theme.of(context).colorScheme` (`primary`, `secondary`, `onSurface`,
  `onSurfaceVariant`, `surfaceContainerHighest`, `outlineVariant`). For semantic accents use
  `PmpColors` (`PmpColors.info500`, `PmpColors.warning500`, etc.) — see how
  `suggested_topic_prep_page.dart` colors its section headers. Do not hardcode `Color(0x…)`.
- **Text styles:** `PmpTextStyles` only — `h2`, `body1Regular`, `body1Semi`, `body2Regular`,
  `body2Semi`, `labelSemi`, `sub`. Screen titles in the module use
  `.copyWith(fontFamily: 'ArchivoBlack Regular')`; Burmese data text uses
  `fontFamily: 'Noto Sans Myanmar'` with taller `height` (see the vocab bottom sheet + prompt card).
- **Shapes/spacing:** rounded cards (`BorderRadius.circular(12–14)`), tinted container
  backgrounds via `colorScheme.primary.withValues(alpha: 0.06)` + matching border — copy the
  `_PromptCard` / `_TopicBanner` recipe. Chips = `ActionChip`. Primary CTA = `FilledButton.icon`
  with the mic/`Icons.auto_awesome` icon and `Padding(vertical: 12)` label, matching existing CTAs.
- Use `Icons.auto_awesome` (✨) for the "Help me prepare" button to signal AI, consistent with the
  ✨ native-version affordance noted in the module guide.

## Localization (mandatory — app is going Burmese)

**Every UI string** goes through `AppLocalizations.of(context).txtDs…` backed by
`lib/l10n/intl_en.arb`. **No hardcoded literals.** New keys to add (names are suggestions — follow
the `txtDs` prefix + existing style):

- `txtDsHelpMePrepare` — "Help me prepare"
- `txtDsRecordNow` — "Record now"
- `txtDsBuildingPrep` — "Building your prep…"
- `txtDsPrepFailed` — "Couldn't build prep. Try again."
- `txtDsRecordWithoutPrep` — "Record without prep"
- `txtDsAskMoreVocab` — "More vocabulary"
- `txtDsAskUsefulPhrases` — "Useful phrases"
- `txtDsAskHowToStart` — "How do I start?"
- `txtDsAskHarderWords` — "Harder words"
- `txtDsAsksUsedUp` — "That's all the prep help for this topic."

Reuse existing keys where they already exist (`txtDsStartRecording`, `txtDsWordsYouMightUse`,
`txtDsTryUseThesePhrases`, `txtDsThingsYouCanMention`, `txtDsYourPrompt`, `txtDsApproxMin`,
`txtDsExample`). After editing the ARB, regenerate l10n (build_runner / flutter_intl) and confirm
`lib/l10n/generated/l10n.dart` picked up the new getters. AI-returned Burmese stays as data.

---

## Definition of done

- [ ] Own-topic prep page shows **Help me prepare** + **Record now**; "Record now" still works as before.
- [ ] "Help me prepare" → spinner → scaffold page with vocab / phrases / mentions populated (stub).
- [ ] Follow-up ask chips append content; capped at 3; disabled while a request is in flight / after cap.
- [ ] "Start recording" carries the **scaffolded** topic into the recorder → choose-feedback → result.
- [ ] Feedback result shows the **target-phrase checklist** for an own-topic session (verify ✅/⬜).
- [ ] All new strings are `txtDs*` ARB keys; `flutter analyze` clean; build_runner regenerated.
- [ ] No raw color/text literals; matches `suggested_topic_prep_page.dart` look.
- [ ] `useStubResponse` still `true`; real edge-function path left as a clearly-marked TODO with the
      documented request body (`topic_text`, no level param) and the budget branch note.
- [ ] Module `CLAUDE.md` on-ramp table updated (own-topic now AI-scaffolded + carries checklist).

## Reference files (read, don't blindly copy)

- `lib/screens/daily_speaking/suggested/suggested_topic_prep_page.dart` — the UI to mirror.
- `lib/screens/daily_speaking/own_topic/own_topic_prep_page.dart` — the page you're modifying.
- `lib/screens/daily_speaking/own_topic/own_topic_record_page.dart` — downstream consumer (unchanged).
- `lib/bloc/daily_speaking/daily_speaking_topic_bloc.dart` — freezed BLoC idiom + page-scoped pattern.
- `lib/bloc/daily_speaking/daily_speaking_bloc.dart` — error-handling pattern to copy (`_handleError`).
- `lib/services/daily_speaking/daily_speaking_service.dart` + `_stubs.dart` — stub/real switch to extend.
- `lib/model/daily_speaking/daily_speaking_topic.dart` — the model you're filling (already has the fields).
- `lib/config/pmp_colors.dart`, `pmp_text_styles.dart`, `pmp_themes.dart` — design tokens.
- `lib/screens/daily_speaking/CLAUDE.md` — module rules (speaking-only, version loop, on-ramps).
```
