#!/usr/bin/env python3
"""Improve the Burmese (mm) text of a writing unit with the Gemini API.

DEV TOOL only. It rewrites *only* the Burmese-language string fields of a unit
(``*_mm`` keys + the ``mm`` key inside examples) into the warm, spoken-teacher
register the user established by hand in L1 sections 1.1 and 1.2. Everything
else — English text, options, answers, tags, structure, ``{v}{/v}``/``{t}{/t}``
markup — is left byte-for-byte identical, because we splice the rewritten
strings back in by JSON path rather than letting the model regenerate the file.

Usage
-----
    python tools/writing_editor/improve_unit.py l1_past_was_were
    python tools/writing_editor/improve_unit.py l1_past_was_were l1_past_regular
    python tools/writing_editor/improve_unit.py --dry-run l1_past_was_were
    python tools/writing_editor/improve_unit.py --model gemini-3-pro-preview l1_past_regular

The key is read from .envs/.env.dev (GEMINI_API_KEY). With --dry-run nothing is
written; a unified diff of the mm fields is printed instead.
"""

from __future__ import annotations

import argparse
import difflib
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

# 2.5-pro throws frequent 503 "high demand" — retry generously before giving up.
MAX_ATTEMPTS = 7
BACKOFF = [5, 10, 20, 30, 45, 60]  # seconds between attempts


class GeminiError(RuntimeError):
    """A call that failed after exhausting retries (caller may skip the unit)."""

# Keys whose value is Burmese prose we want to rewrite. We match key == "mm"
# (examples / time_word_examples) or any key ending in "_mm" EXCEPT the two
# below, which are English/metadata and must not be touched.
SKIP_MM_KEYS = {"common_mm_errors", "subtitle_mm"}


def strip_markup(value):
    """Remove {v}/{t} highlight tags from Burmese text (keep the inner words).

    The tags belong to the English sentences only; the model sometimes adds
    them inside mm prose despite the prompt rule. This is the hard guarantee.
    """
    def _one(s):
        for tag in ("{v}", "{/v}", "{t}", "{/t}"):
            s = s.replace(tag, "")
        return s
    if isinstance(value, str):
        return _one(value)
    if isinstance(value, list):
        return [_one(x) if isinstance(x, str) else x for x in value]
    return value


def is_mm_key(key: str) -> bool:
    if not isinstance(key, str):
        return False
    if key in SKIP_MM_KEYS:
        return False
    return key == "mm" or key.endswith("_mm")


# --- style spec: what "improve" means, distilled from the 1.1 / 1.2 diffs -----
STYLE_RULES = """\
You are polishing the Burmese (Myanmar) micro-copy of an English-grammar lesson
for Burmese learners. Rewrite each Burmese string into a WARM, FRIENDLY,
SPOKEN-TEACHER register — the way a kind teacher explains to a beginner.

Hard rules:
1. Output Burmese only where the input is Burmese. Keep the SAME meaning.
2. Keep every English grammar term IN ENGLISH exactly as written: Subject, Verb,
   Object, Base form, Present simple, Past simple, Singular, plural, negative,
   etc. Never translate these to Burmese.
3. Keep any {v}...{/v} and {t}...{/t} markup and any English example words,
   symbols (✗ ✓ → ·), and quoted English EXACTLY as they appear. But do NOT
   ADD any new {v}/{t} markup that was not already in the input string. Inside
   Burmese prose, refer to English words in plain text or with ‘ ’ quotes
   (e.g. ‘was’, not {v}was{/v}). Highlight markup belongs to the English
   sentences only.
4. For a literal-translation field (a learner-facing prompt that translates an
   English sentence) keep it a faithful translation of that sentence — do NOT
   turn it into an instruction like "choose the correct answer".
5. Prefer the softer helper-verb register: use "ထည့်ပေးရပါမယ်" / "သုံးပေးရပါမယ်"
   / "ထားပေးပါ" instead of stiff "ထည့်ရမည် / ထားရမည်". End explanatory
   sentences with "...ပါတယ်" / "...ပါမယ်" rather than literary "...သည် / ...မည်".
6. You MAY enrich an explanation with a little helpful grammar context
   (e.g. add "(Singular / အနည်းကိန်း)", or list which endings take -es:
   "-ch, -sh, -s, -x, -z, -o"), but keep it concise and natural — do not pad.
7. Do not add new sentences of unrelated content; do not remove information.
8. If a value is an array of strings, return an array of strings. You MAY split
   one crowded line into a few short lines (e.g. put each ✗ / ✓ example on its
   own line) — return the new array. Otherwise keep the array length.

Tone reference — BEFORE -> AFTER (study the register, do not copy verbatim):
- "He / She / It နှင့်ဆိုလျှင် = Verb နောက်တွင် -s / -es ထည့်ရမည်"
  -> "Subjectက He / She / It နှင့်ဆိုရင် Verb နောက်မှာ -s / -es ထည့်ပေးရပါမယ်။"
- "Subject က 'They' ဖြစ်လို့ base form → work (-s မထည့်)။"
  -> "Subject က 'They' (plural / အများကိန်း) ဖြစ်တဲ့အတွက် Verb ရဲ့ မူရင်းပုံစံ Base form (work) ကိုပဲ သုံးရပြီး -s /-es ထည့်စရာ မလိုပါဘူး။"
- "ဟိုငှက်တွေ လှတယ်။"  ->  "ဟိုငှက်လေးတွေ လှတယ်။"
"""

PROMPT_TEMPLATE = """\
{rules}

Rewrite the Burmese in each item below. Return ONLY a JSON array of objects
with the same "i" values and in the same order, each like {{"i": <int>,
"text": <string or array of strings, matching the input shape>}}. No prose,
no markdown — just the JSON array.

ITEMS:
{items}
"""


def load_key() -> str:
    key = os.environ.get("GEMINI_API_KEY")
    if key:
        return key.strip()
    if os.path.exists(ENV_PATH):
        with open(ENV_PATH, encoding="utf-8") as fh:
            for line in fh:
                line = line.strip()
                if line.startswith("GEMINI_API_KEY="):
                    return line.split("=", 1)[1].strip()
    sys.exit("GEMINI_API_KEY not found (env or .envs/.env.dev).")


def unit_path(uid: str) -> str:
    index = json.load(open(INDEX_PATH, encoding="utf-8"))
    for entry in index:
        if entry.get("id") == uid:
            return os.path.abspath(os.path.join(ROOT, entry["asset"]))
    sys.exit(f"unit id not found in index.json: {uid}")


def collect(node, path, out):
    """Walk the unit, recording (path, value) for every Burmese field."""
    if isinstance(node, dict):
        for k, v in node.items():
            child = path + [k]
            if is_mm_key(k):
                if isinstance(v, str) and v.strip():
                    out.append((child, v))
                elif isinstance(v, list) and v and all(isinstance(x, str) for x in v):
                    out.append((child, v))
                else:
                    collect(v, child, out)
            else:
                collect(v, child, out)
    elif isinstance(node, list):
        for i, v in enumerate(node):
            collect(v, path + [i], out)


def set_at(root, path, value):
    node = root
    for key in path[:-1]:
        node = node[key]
    node[path[-1]] = value


def call_gemini(key: str, model: str, items: list) -> list:
    payload = {
        "contents": [{
            "parts": [{"text": PROMPT_TEMPLATE.format(
                rules=STYLE_RULES,
                items=json.dumps(items, ensure_ascii=False, indent=2),
            )}],
        }],
        "generationConfig": {
            "temperature": 0.4,
            "responseMimeType": "application/json",
        },
    }
    url = (f"https://generativelanguage.googleapis.com/v1beta/models/"
           f"{model}:generateContent?key={key}")
    body = json.dumps(payload).encode("utf-8")
    data = None
    for attempt in range(MAX_ATTEMPTS):
        req = urllib.request.Request(
            url, data=body,
            headers={"Content-Type": "application/json"}, method="POST")
        try:
            with urllib.request.urlopen(req, timeout=180) as resp:
                data = json.load(resp)
            break
        except urllib.error.HTTPError as exc:
            # 429 (rate) and 5xx (overload) are transient — back off and retry.
            if exc.code in (429, 500, 502, 503, 504) and attempt < MAX_ATTEMPTS - 1:
                wait = BACKOFF[min(attempt, len(BACKOFF) - 1)]
                print(f"  Gemini HTTP {exc.code} — retry in {wait}s "
                      f"({attempt + 1}/{MAX_ATTEMPTS - 1}) ...", flush=True)
                time.sleep(wait)
                continue
            raise GeminiError(f"HTTP {exc.code}: "
                              f"{exc.read().decode('utf-8', 'replace')[:300]}")
        except (urllib.error.URLError, TimeoutError) as exc:
            if attempt < MAX_ATTEMPTS - 1:
                wait = BACKOFF[min(attempt, len(BACKOFF) - 1)]
                print(f"  network error ({exc}) — retry in {wait}s ...", flush=True)
                time.sleep(wait)
                continue
            raise GeminiError(str(exc))
    try:
        text = data["candidates"][0]["content"]["parts"][0]["text"]
    except (KeyError, IndexError):
        raise GeminiError(f"unexpected response: {json.dumps(data)[:300]}")
    return json.loads(text)


def improve(uid: str, key: str, model: str, dry_run: bool) -> None:
    path = unit_path(uid)
    unit = json.load(open(path, encoding="utf-8"))

    fields = []
    collect(unit, [], fields)
    items = [{"i": i, "text": val} for i, (_, val) in enumerate(fields)]
    print(f"[{uid}] {len(items)} Burmese fields -> {model} ...", flush=True)

    result = call_gemini(key, model, items)
    by_i = {obj["i"]: obj["text"] for obj in result if "i" in obj}

    changed = 0
    new_unit = json.loads(json.dumps(unit))  # deep copy
    for i, (fpath, old) in enumerate(fields):
        if i not in by_i:
            print(f"  ! field {i} missing in response — left unchanged")
            continue
        new = by_i[i]
        # shape guard: a string field must stay a string. The model sometimes
        # returns the rewrite split into lines — join them back (matches the
        # newline style already used in trap_mm). A list field must stay a list.
        if isinstance(old, str) and isinstance(new, list):
            if all(isinstance(x, str) for x in new):
                new = "\n".join(new)
            else:
                print(f"  ! field {i} shape mismatch (str) — skipped")
                continue
        if isinstance(old, str) and not isinstance(new, str):
            print(f"  ! field {i} shape mismatch (str) — skipped")
            continue
        if isinstance(old, list) and not isinstance(new, list):
            print(f"  ! field {i} shape mismatch (list) — skipped")
            continue
        new = strip_markup(new)  # mm fields never carry {v}/{t} highlight tags
        if new != old:
            set_at(new_unit, fpath, new)
            changed += 1

    if dry_run:
        review_dir = os.path.join(HERE, "_review")
        os.makedirs(review_dir, exist_ok=True)
        out_path = os.path.join(review_dir, f"{uid}.improved.json")
        with open(out_path, "w", encoding="utf-8", newline="\n") as fh:
            fh.write(json.dumps(new_unit, ensure_ascii=False, indent=2) + "\n")
        print(f"[{uid}] DRY RUN — {changed} fields changed. Review file written:",
              flush=True)
        print(f"    {os.path.relpath(out_path, ROOT)}", flush=True)
        print(f"    (real asset NOT touched — compare against "
              f"{os.path.relpath(path, ROOT)})", flush=True)
        return

    text = json.dumps(new_unit, ensure_ascii=False, indent=2) + "\n"
    with open(path, "w", encoding="utf-8", newline="\n") as fh:
        fh.write(text)
    print(f"[{uid}] wrote {changed} improved fields -> "
          f"{os.path.relpath(path, ROOT)}", flush=True)


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("ids", nargs="+", help="unit id(s), e.g. l1_past_was_were")
    ap.add_argument("--model", default=DEFAULT_MODEL)
    ap.add_argument("--dry-run", action="store_true",
                    help="print a diff, write nothing")
    args = ap.parse_args()

    key = load_key()
    failed = []
    for uid in args.ids:
        try:
            improve(uid, key, args.model, args.dry_run)
        except GeminiError as exc:
            print(f"[{uid}] FAILED — {exc} (skipped, will continue)", flush=True)
            failed.append(uid)

    if failed:
        print(f"\n{len(failed)}/{len(args.ids)} unit(s) failed. Re-run with:",
              flush=True)
        print("  python tools/writing_editor/improve_unit.py "
              + " ".join(failed), flush=True)
    else:
        print(f"\nAll {len(args.ids)} unit(s) done.", flush=True)


if __name__ == "__main__":
    main()
