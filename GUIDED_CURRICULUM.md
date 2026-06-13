# Guided "Start here" — Curriculum Spec

The syllabus for the Daily Speaking **guided on-ramp** (`assets/daily_speaking/guided/guided.json`,
model: `lib/model/daily_speaking/guided_lesson.dart`). 60 units across 3 levels.

This is the **frozen plan** (step 1 of: *lock syllabus → hand-author a slice → AI-batch the rest*).
Titles / objectives / IDs / grammar focus here are the contract; full bilingual lesson content
(model paragraph, template, slots, sentences with `text_en`/`text_mm`/`explanation_mm`, vocab,
target phrases, warmups) is authored against it.

## Design rules

1. **Every unit hands the learner reusable language.** A unit is only "done" when its vocab +
   target phrases give the learner something concrete to reuse in *Just Talk* / *Own Topic*.
   The guided path exists to make the freer modes feel possible.
2. **Levels progress, they don't just accumulate.** Each level has a distinct grammar/function
   job (below). A topic lives at the level whose grammar it naturally needs.
3. **The script fades by level** (record page: L1 full script / L2 keywords / L3 hidden), so a
   topic's level must match how much support a learner needs to *say it from memory*.
4. **Burmese is the bottleneck, not the JSON.** Every `*_mm` line needs native review before a
   unit ships. Plan editorial capacity around that, not around typing JSON.

## Levels

| Level | Theme | Grammar / function it builds | After this level a learner can… |
|---|---|---|---|
| **L1** | About me, here & now | present simple, personal facts, concrete nouns, sequencing | describe themselves & their immediate world |
| **L2** | Describing & comparing | rich description, comparatives, simple past, reasons ("because") | describe/compare people, places, things — with reasons |
| **L3** | Stories, opinions & the future | narrative past, opinion + justification, future/conditional, abstract | tell a complete story, argue a view, talk about plans |

**Status legend:** ✅ authored · ✍️ author in first slice · ⬜ AI-batch later

---

## Level 1 — About me, here & now

| # | id | Title | Objective (by the end, you can…) | Grammar focus | Status |
|---|---|---|---|---|---|
| 1 | `guided_self_intro` | Introduce yourself | say your name, origin, job, and what you like (~30s) | present simple, "I'm / I work as" | ✅ |
| 2 | `guided_daily_routine` | My daily routine | sequence a normal day | present simple + time markers (usually, after that) | ✅ |
| 3 | `guided_my_family` | My family | describe who's in your family | "there are … in my family", family nouns | ✅ |
| 4 | `guided_best_friend` | My best friend | describe someone you're close to | personality adjectives | ✅ |
| 5 | `guided_my_home` | My home | describe where you live | there is/are + rooms/furniture | ✅ |
| 6 | `guided_what_i_do` | What I do | explain your job or studies | present simple, workplace nouns | ⬜ |
| 7 | `guided_favorite_food` | My favorite food | describe a dish you love | "I love …ing", like/prefer | ⬜ |
| 8 | `guided_my_hobbies` | My hobbies | talk about free-time activities | "I enjoy / like + Ving" | ⬜ |
| 9 | `guided_my_weekend` | My weekend | say what you do on weekends | present simple + frequency (often, sometimes) | ⬜ |
| 10 | `guided_weather_today` | The weather today | describe today's weather | "It's + adjective", weather vocab | ⬜ |
| 11 | `guided_favorite_place_town` | My favorite place in town | name & describe a local spot | location prepositions, there is | ⬜ |
| 12 | `guided_how_i_get_around` | How I get around | explain how you travel | "I go by …", "it takes … minutes" | ⬜ |
| 13 | `guided_what_i_eat` | What I eat in a day | run through your meals | present simple + meal/time markers | ⬜ |
| 14 | `guided_a_pet` | A pet or animal I like | describe an animal | adjectives + "it can …" | ⬜ |
| 15 | `guided_favorite_season` | My favorite season | say your preferred time of year | "my favorite … is … because" | ⬜ |
| 16 | `guided_favorite_show` | My favorite show or movie | say what you watch & why | opinion adjectives | ⬜ |
| 17 | `guided_phone_apps` | My phone and apps | name apps you use daily | "I use … to …" (purpose) | ⬜ |
| 18 | `guided_my_morning` | My morning | describe your first hour | sequencing (first, then, after) | ⬜ |
| 19 | `guided_my_room` | What's in my room | describe your space | there is/are + prepositions of place | ⬜ |
| 20 | `guided_typical_day` | A typical day | summarize an ordinary day (ties L1 together) | present simple recap | ⬜ |

## Level 2 — Describing & comparing

| # | id | Title | Objective | Grammar focus | Status |
|---|---|---|---|---|---|
| 1 | `guided_my_hometown` | My hometown | describe where it is, what it's like, one thing you love | location + "surrounded by" + "the thing I love most" | ✅ |
| 2 | `guided_person_i_admire` | A person I admire | describe someone and why | personality adjectives + "because" | ✅ |
| 3 | `guided_favorite_festival` | My favorite festival | describe a celebration & what happens | present simple + sequence, cultural nouns | ✅ |
| 4 | `guided_best_trip` | The best trip I've taken | tell about a memorable trip | simple past (went, saw, stayed) | ✅ |
| 5 | `guided_favorite_restaurant` | My favorite restaurant | describe a place to eat and why | description + reasons | ✅ |
| 6 | `guided_city_vs_country` | City life vs country life | compare two ways of living | comparatives (-er than, more/less) | ⬜ |
| 7 | `guided_skill_learning` | A skill I'm learning | talk about something you're improving | present continuous, "I'm learning to …" | ⬜ |
| 8 | `guided_childhood_memory` | A childhood memory | recall a moment from when you were young | simple past + "when I was …" | ⬜ |
| 9 | `guided_music_i_like` | The music I like | describe your taste and why | preference + reasons | ⬜ |
| 10 | `guided_book_or_film` | A book or film that stayed with me | describe one that affected you | simple past + opinion | ⬜ |
| 11 | `guided_ideal_weekend` | My ideal weekend | describe your perfect weekend | "would like to" + activities | ⬜ |
| 12 | `guided_online_vs_store` | Online vs in-store shopping | compare two ways to shop | comparatives + advantages | ⬜ |
| 13 | `guided_place_for_tourists` | A place tourists should visit | recommend a spot | "should" + reasons + description | ⬜ |
| 14 | `guided_learning_english` | Learning English: my experience | describe your journey with English | simple past + present perfect intro | ⬜ |
| 15 | `guided_unforgettable_gift` | A gift I'll never forget | describe a meaningful present | simple past + feelings | ⬜ |
| 16 | `guided_habit_to_change` | A habit I want to change | describe something you'd like to fix | "want to / should" + reasons | ⬜ |
| 17 | `guided_two_cities` | Two cities I know | compare two places | comparatives + "whereas" | ⬜ |
| 18 | `guided_memorable_meal` | A memorable meal | describe a special meal & occasion | simple past + description | ⬜ |
| 19 | `guided_favorite_weather` | My favorite weather (and why) | describe preferred conditions | preference + reasons | ⬜ |
| 20 | `guided_day_off` | The perfect day off | describe how you'd spend a free day | "would" + sequence | ⬜ |

## Level 3 — Stories, opinions & the future

| # | id | Title | Objective | Grammar focus | Status |
|---|---|---|---|---|---|
| 1 | `guided_memorable_day` | A day I'll never forget | tell a longer personal story (~2 min) | narrative past + feelings | ✅ |
| 2 | `guided_five_year_goals` | My goals for the next 5 years | talk about plans & ambitions | future ("I plan to / hope to / will") | ✅ |
| 3 | `guided_hard_decision` | A hard decision I made | tell about a tough choice & outcome | narrative past + "I had to" | ✅ |
| 4 | `guided_students_jobs` | Should students have part-time jobs? | argue a position | opinion language + pros/cons | ✅ |
| 5 | `guided_tech_changed_life` | How technology changed my life | reflect on change | present perfect + "used to" contrast | ✅ |
| 6 | `guided_time_i_failed` | A time I failed (and learned) | tell about a setback & lesson | narrative past + reflection | ⬜ |
| 7 | `guided_live_anywhere` | If I could live anywhere | describe a hypothetical | second conditional ("if I could …, I would …") | ⬜ |
| 8 | `guided_life_lesson` | The most important lesson life taught me | share an abstract reflection | present perfect + "taught me to" | ⬜ |
| 9 | `guided_city_problem_fix` | A problem in my city & a fix | identify a problem & propose a fix | "should/could" + problem-solution | ⬜ |
| 10 | `guided_social_media_view` | My take on social media | give a balanced opinion | opinion + concession (although) | ⬜ |
| 11 | `guided_person_who_influenced` | Someone who influenced me | describe a formative person | narrative past + impact | ⬜ |
| 12 | `guided_work_or_study_abroad` | Work abroad or study abroad? | weigh two options | comparison + opinion | ⬜ |
| 13 | `guided_dream_job` | My dream job | describe an aspiration & why | future + reasons | ⬜ |
| 14 | `guided_challenge_overcame` | A challenge I overcame | tell about a struggle & triumph | narrative past + result | ⬜ |
| 15 | `guided_future_of_work` | The future of work | speculate about change | future + "might / could / will probably" | ⬜ |
| 16 | `guided_proud_achievement` | An achievement I'm proud of | tell a success story | present perfect + narrative past | ⬜ |
| 17 | `guided_money_vs_passion` | Money vs passion | argue what matters more | opinion + justification | ⬜ |
| 18 | `guided_a_risk_i_took` | A risk I took | tell about a bold choice & result | narrative past + reflection | ⬜ |
| 19 | `guided_advice_younger_self` | Advice to my younger self | give hypothetical advice | "I would tell myself to …" | ⬜ |
| 20 | `guided_change_my_past` | What I'd change about my past | describe a regret / hypothetical | "I wish I had …" / would have | ⬜ |

---

## Storage layout

One JSON file per lesson, grouped into per-level folders:

```
assets/daily_speaking/guided/
  level-01/  01-self-intro.json  02-daily-routine.json  03-my-family.json  04-best-friend.json  05-my-home.json
  level-02/  01-my-hometown.json
  level-03/  01-memorable-day.json
```

The loader (`GuidedLessonBloc._loadFromAssets`) enumerates every `*.json` under
`assets/daily_speaking/guided/` via `AssetManifest`, so **adding a lesson = dropping a file**
(no code change). Each file is a single lesson object. Folders are registered in `pubspec.yaml`
(`level-01/` … `level-03/`). File naming `NN-slug.json` is for humans/ordering only — runtime
order comes from `level` then `sort_order`.

## Progress (first slice)

Goal: 5 units per level (15) to validate UX + translation quality before AI-batching the rest.

**First slice DONE — 15/15 authored (5 per level).**

- **L1 (5/5):** self_intro, daily_routine, my_family, best_friend, my_home
- **L2 (5/5):** my_hometown, person_i_admire, favorite_festival, best_trip, favorite_restaurant
- **L3 (5/5):** memorable_day, five_year_goals, hard_decision, students_jobs, tech_changed_life

All ✅ Burmese is my draft — **pending native review** before production. The remaining 45 units
(⬜) are the AI-batch phase.

**All 15 enriched (2026-06-13):** every authored lesson now has (a) **full line-by-line coverage**
— breakdown sentences reconstruct the model paragraph exactly; (b) a **rich vocab bank** (5–14
grouped entries with `related`/`opposite`); (c) **tappable highlights** in each sentence — swap-words
(linked to a build slot, solid underline) + content words (dotted), opening the shared vocab sheet.
The AI-batch schema for the remaining 45 must include `sentences[].highlights` and the rich
`GuidedVocab` shape (id/group/related/opposite/slot), not just the flat term/definition.

## Open follow-ups

- **Native review:** every `*_mm` line in the authored units needs a native pass.
- **AI-batch:** remaining ⬜ units generated into this exact schema (Gemini `expand_topic`
  pipeline), one file per lesson, then native review before flipping status to ✅.
- **Supabase swap:** asset → `daily_speaking_guided` table (network-first → cache → asset
  fallback), per the on-ramp memory + suggested-topics plan.

> Resolved: `memorable_day` relabeled L1→L3; `sort_order` switched to per-level; content
> split from the monolithic `guided.json` into per-lesson files.
