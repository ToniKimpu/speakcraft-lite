#!/usr/bin/env python3
"""Generate guided-lesson audio with edge-tts (Microsoft Edge neural voices).

Offline authoring step — NOT run in the app. Reads guided lesson JSON(s) and
writes one MP3 per:
  - model paragraph -> {lessonId}/paragraph.mp3
  - each sentence   -> {lessonId}/s{index}.mp3
  - each vocab term -> {lessonId}/v_{vocabId}.mp3

Output goes under assets/daily_speaking/guided/audio/{lessonId}/.

Usage:
  python tools/guided_tts.py                                   # all lessons
  python tools/guided_tts.py assets/.../level-01/01-self-intro.json   # specific
  python tools/guided_tts.py --voice en-US-GuyNeural --rate "-25%" ...

edge-tts is free and needs no key. The same voice NAMES also work with Azure
TTS, so a later switch to a licensed pipeline keeps the audio identical.
For production the output is meant to be pushed to Bunny (mirror bunny_push.py);
bundling under assets/ is only for local review.
"""
import argparse
import asyncio
import glob
import json
import os
import sys

import edge_tts

ASSET_ROOT = "assets/daily_speaking/guided"
AUDIO_ROOT = os.path.join(ASSET_ROOT, "audio")
DEFAULT_VOICE = "en-US-JennyNeural"


async def _say(text, voice, rate, out_path):
    if not text or not text.strip():
        return False
    await edge_tts.Communicate(text, voice, rate=rate).save(out_path)
    return True


async def _process(path, voice, rate):
    with open(path, encoding="utf-8") as f:
        lesson = json.load(f)
    lid = lesson["id"]
    out_dir = os.path.join(AUDIO_ROOT, lid)
    os.makedirs(out_dir, exist_ok=True)

    jobs = [(lesson.get("model_paragraph_en", ""),
             os.path.join(out_dir, "paragraph.mp3"))]
    for i, s in enumerate(lesson.get("sentences", [])):
        jobs.append((s.get("text_en", ""), os.path.join(out_dir, f"s{i}.mp3")))
    for v in lesson.get("vocabulary", []):
        vid = v.get("id") or v.get("term")
        jobs.append((v.get("term", ""), os.path.join(out_dir, f"v_{vid}.mp3")))

    made = 0
    for text, out in jobs:
        if await _say(text, voice, rate, out):
            made += 1
    print(f"[{lid}] {made} clips -> {out_dir}  (voice={voice}, rate={rate})")


async def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("files", nargs="*", help="lesson JSON files (default: all)")
    ap.add_argument("--voice", default=DEFAULT_VOICE)
    ap.add_argument("--rate", default="+0%", help='e.g. "-25%" for slower')
    args = ap.parse_args()

    files = args.files or sorted(
        glob.glob(os.path.join(ASSET_ROOT, "level-*", "*.json")))
    if not files:
        print("no lesson JSON files found", file=sys.stderr)
        sys.exit(1)
    for path in files:
        await _process(path, args.voice, args.rate)


if __name__ == "__main__":
    asyncio.run(main())
