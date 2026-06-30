"""Speak Your Mind — AUDIO PILOT (local only, no upload).

Generates EdgeTTS clips for ONE topic into scratchpad/audio_out/<topic>/ so we
can listen and confirm voice/rate before the full Bunny batch. Filenames match
the planned Bunny layout: m{move}-i{item}.mp3 + guide-model.mp3.

Run:  python scratchpad/sym_audio_pilot.py my_family
"""

import asyncio
import json
import sys
from pathlib import Path

import edge_tts

sys.stdout.reconfigure(encoding="utf-8")  # Burmese / arrows in topic titles

VOICE = "en-GB-SoniaNeural"   # examples/sentences voice (matches Vocabulary)
RATE = "-8%"                  # a touch slower — clearer for learners

ROOT = Path(__file__).resolve().parent.parent
topic_id = sys.argv[1] if len(sys.argv) > 1 else "my_family"
topic = json.loads((ROOT / f"assets/speak_your_mind/{topic_id}.json").read_text("utf-8"))
out_dir = ROOT / "scratchpad/audio_out" / topic_id
out_dir.mkdir(parents=True, exist_ok=True)


async def tts(text: str, path: Path):
    await edge_tts.Communicate(text, VOICE, rate=RATE).save(str(path))


async def main():
    jobs = []  # (label, text, filename)
    for mi, move in enumerate(topic["toolbox"], start=1):
        for ii, c in enumerate(move["items"], start=1):
            jobs.append((f"m{mi}-i{ii}", c["text_en"], f"m{mi}-i{ii}.mp3"))
    g = topic.get("guide")
    if g and g.get("model_en"):
        jobs.append(("guide-model", g["model_en"], "guide-model.mp3"))

    print(f"{topic['title_en']}: {len(jobs)} clips -> {out_dir}")
    sem = asyncio.Semaphore(8)

    async def run(label, text, fname):
        async with sem:
            try:
                await tts(text, out_dir / fname)
                print(f"  ok  {fname}")
            except Exception as e:
                print(f"  ERR {fname}: {e}")

    await asyncio.gather(*(run(*j) for j in jobs))
    print(f"\nDone. Listen in: {out_dir}")
    print(f"Sample: {out_dir / 'm1-i1.mp3'}  ('{topic['toolbox'][0]['items'][0]['text_en']}')")


asyncio.run(main())
