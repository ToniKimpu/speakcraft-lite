#!/usr/bin/env python3
"""Generate per-unit pager step headings (`when` + `pattern`) with Gemini.

DEV TOOL only. For each unit it writes a short Burmese heading for Step 1
("when to use") and Step 2 ("the pattern") that fits *that* unit's topic, into
``teach.step_titles_mm`` — so the pager stops showing the generic, verb-biased
defaults (e.g. "Subject & Verb" on a nouns unit). Everything else in the unit
file is left untouched.

Usage
-----
    python tools/writing_editor/gen_step_titles.py                  # all units
    python tools/writing_editor/gen_step_titles.py l1_plural_nouns  # some units
    python tools/writing_editor/gen_step_titles.py --dry-run l1_a_an

The key is read from .envs/.env.dev (GEMINI_API_KEY).
"""

from __future__ import annotations

import argparse
import json
import os
import sys
import time
import urllib.error
import urllib.request

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", ".."))
UNITS_DIR = os.path.join(ROOT, "assets", "writing", "units")
INDEX_PATH = os.path.join(UNITS_DIR, "index.json")
ENV_PATH = os.path.join(ROOT, ".envs", ".env.dev")

DEFAULT_MODEL = "gemini-2.5-pro"
MAX_ATTEMPTS = 7
BACKOFF = [5, 10, 20, 30, 45, 60]


class GeminiError(RuntimeError):
    pass


PROMPT = """\
You write short Burmese (Myanmar) section headings for an English-grammar lesson
aimed at Burmese learners. For ONE grammar unit you produce two headings:

- "when":    Step 1 heading — answers "in what situation / for what do we use
             this?" for THIS topic. ~3-7 Burmese words, ending like a gentle
             question (…သုံးမလဲ / …သုံးသလဲ).
- "pattern": Step 2 heading — names what the FORM/PATTERN of THIS unit teaches.
             For verb units that is Subject–Verb agreement; for nouns it is how
             the noun changes (singular↔plural); for articles it is which word to
             pick (a / an / the); for prepositions which one to choose; etc.
             ~3-8 words, naturally phrased as a small question (…ဘယ်လို…မလဲ /
             …ဘယ်ဟာ ရွေးမလဲ).

Rules:
- Keep English grammar terms IN ENGLISH (Subject, Verb, noun, plural, article,
  preposition, a, an, the, in/on/at, etc.). Do not translate them.
- Warm, spoken-teacher tone. No final period. No {v}/{t} markup. Burmese only
  apart from those English terms.
- Headings must fit the TOPIC of this specific unit, not grammar in general.

Reference examples (topic -> when | pattern):
- Present simple (verb)      -> ဘယ်အချိန်မှာ သုံးမလဲ | Subject နှင့် Verb ဘယ်လို တွဲမလဲ
- Singular & plural nouns     -> ဘယ်အခါ အများကိန်း သုံးမလဲ | နာမ်ကို အများကိန်း ဘယ်လို ပြောင်းမလဲ
- a / an                      -> �’a / an’ ဘယ်အခါ သုံးမလဲ | a နဲ့ an — ဘယ်ဟာ ရွေးမလဲ
- Prepositions of time        -> အချိန်ပြောရင် ဘယ်လို သုံးမလဲ | in / on / at — ဘယ်ဟာ ရွေးမလဲ

This unit:
- title (English): <<TITLE>>
- Burmese subtitle: <<SUBTITLE>>
- what it's for (use_mm): <<USE_MM>>
- form rows (subjects): <<SUBJECTS>>

Return ONLY a JSON object: {"when": "...", "pattern": "..."}
"""


def load_key():
    key = os.environ.get("GEMINI_API_KEY")
    if key:
        return key.strip()
    if os.path.exists(ENV_PATH):
        for line in open(ENV_PATH, encoding="utf-8"):
            if line.strip().startswith("GEMINI_API_KEY="):
                return line.split("=", 1)[1].strip()
    sys.exit("GEMINI_API_KEY not found.")


def all_unit_ids():
    return [e["id"] for e in json.load(open(INDEX_PATH, encoding="utf-8"))]


def unit_path(uid):
    for e in json.load(open(INDEX_PATH, encoding="utf-8")):
        if e.get("id") == uid:
            return os.path.abspath(os.path.join(ROOT, e["asset"]))
    raise GeminiError(f"unknown unit id: {uid}")


def call_gemini(key, model, prompt):
    payload = {
        "contents": [{"parts": [{"text": prompt}]}],
        "generationConfig": {"temperature": 0.5,
                             "responseMimeType": "application/json"},
    }
    body = json.dumps(payload).encode("utf-8")
    url = (f"https://generativelanguage.googleapis.com/v1beta/models/"
           f"{model}:generateContent?key={key}")
    data = None
    for attempt in range(MAX_ATTEMPTS):
        req = urllib.request.Request(
            url, data=body, headers={"Content-Type": "application/json"},
            method="POST")
        try:
            with urllib.request.urlopen(req, timeout=120) as resp:
                data = json.load(resp)
            break
        except urllib.error.HTTPError as exc:
            if exc.code in (429, 500, 502, 503, 504) and attempt < MAX_ATTEMPTS - 1:
                wait = BACKOFF[min(attempt, len(BACKOFF) - 1)]
                print(f"  HTTP {exc.code} — retry in {wait}s "
                      f"({attempt + 1}/{MAX_ATTEMPTS - 1}) ...", flush=True)
                time.sleep(wait)
                continue
            raise GeminiError(f"HTTP {exc.code}: "
                              f"{exc.read().decode('utf-8', 'replace')[:200]}")
    try:
        text = data["candidates"][0]["content"]["parts"][0]["text"]
    except (KeyError, IndexError, TypeError):
        raise GeminiError(f"bad response: {json.dumps(data)[:200]}")
    return json.loads(text)


def clean(s):
    for tag in ("{v}", "{/v}", "{t}", "{/t}"):
        s = s.replace(tag, "")
    return s.strip().rstrip("。.")


def gen(uid, key, model, dry_run):
    path = unit_path(uid)
    unit = json.load(open(path, encoding="utf-8"))
    teach = unit.get("teach", {})
    subjects = " / ".join(
        r.get("subject", "") for r in teach.get("form", []) if r.get("subject"))
    prompt = (PROMPT
              .replace("<<TITLE>>", unit.get("title", ""))
              .replace("<<SUBTITLE>>", unit.get("subtitle_mm", ""))
              .replace("<<USE_MM>>", (teach.get("use_mm", "") or "")[:300])
              .replace("<<SUBJECTS>>", subjects or "(none)"))
    res = call_gemini(key, model, prompt)
    when, pattern = clean(res.get("when", "")), clean(res.get("pattern", ""))
    if not when or not pattern:
        raise GeminiError(f"empty heading(s): {res}")

    titles = dict(teach.get("step_titles_mm", {}))
    titles["when"], titles["pattern"] = when, pattern
    teach["step_titles_mm"] = titles
    unit["teach"] = teach

    print(f"[{uid}]\n    when    = {when}\n    pattern = {pattern}", flush=True)
    if dry_run:
        return
    with open(path, "w", encoding="utf-8", newline="\n") as fh:
        fh.write(json.dumps(unit, ensure_ascii=False, indent=2) + "\n")


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("ids", nargs="*", help="unit ids (default: all)")
    ap.add_argument("--model", default=DEFAULT_MODEL)
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()

    key = load_key()
    ids = args.ids or all_unit_ids()
    failed = []
    for uid in ids:
        try:
            gen(uid, key, args.model, args.dry_run)
        except GeminiError as exc:
            print(f"[{uid}] FAILED — {exc}", flush=True)
            failed.append(uid)
    if failed:
        print(f"\n{len(failed)} failed. Re-run: python "
              f"tools/writing_editor/gen_step_titles.py " + " ".join(failed))
    else:
        print(f"\nAll {len(ids)} unit(s) done.")


if __name__ == "__main__":
    main()
