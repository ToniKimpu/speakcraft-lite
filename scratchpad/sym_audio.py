"""Speak Your Mind — full audio pipeline: EdgeTTS -> Bunny Storage -> paths in JSON.

For each topic, synthesises every toolbox chunk + the guide's model paragraph
(en-GB-SoniaNeural, natural pace), uploads to the Bunny STORAGE zone under
  speak_your_mind/level{N}/<topic>/m{move}-i{item}.mp3   (+ guide-model.mp3)
and writes the stored path back into the JSON:
  chunk.audio        = bunny/speak_your_mind/level{N}/<topic>/m{m}-i{i}.mp3
  guide.model_audio  = bunny/speak_your_mind/level{N}/<topic>/guide-model.mp3

Idempotent: skips a clip whose JSON path is already set (use --force to redo).
Creds come from .bunny.env (write key — never bundled). NOT committed.

Run:  python scratchpad/sym_audio.py [topic_id]  [--force]
      (no topic_id -> every topic under assets/speak_your_mind/)
"""

import asyncio
import json
import re
import sys
import urllib.request
from pathlib import Path

import edge_tts

sys.stdout.reconfigure(encoding="utf-8")

VOICE = "en-GB-SoniaNeural"
RATE = "+0%"
ROOT = Path(__file__).resolve().parent.parent
ASSETS = ROOT / "assets/speak_your_mind"

# ── Bunny storage creds (.bunny.env) ─────────────────────────────────────────
env = {}
for line in (ROOT / ".bunny.env").read_text("utf-8").splitlines():
    line = line.strip()
    if line and not line.startswith("#") and "=" in line:
        k, v = line.split("=", 1)
        # Drop inline " # comment" and trailing whitespace.
        env[k.strip()] = re.sub(r"\s+#.*$", "", v).strip()
ZONE = env["BUNNY_STORAGE_ZONE"]
KEY = env["BUNNY_ACCESS_KEY"]
HOST = env["BUNNY_STORAGE_HOST"]
# HOST may be a full base URL (scheme://host/zone) or just a hostname.
BASE = HOST.rstrip("/") if HOST.startswith("http") else f"https://{HOST}/{ZONE}"

args = [a for a in sys.argv[1:] if not a.startswith("--")]
FORCE = "--force" in sys.argv
topic_ids = args or sorted(p.stem for p in ASSETS.glob("*.json"))


async def synth(text: str) -> bytes:
    buf = bytearray()
    async for ch in edge_tts.Communicate(text, VOICE, rate=RATE).stream():
        if ch["type"] == "audio":
            buf += ch["data"]
    return bytes(buf)


def upload(storage_path: str, data: bytes):
    url = f"{BASE}/{storage_path}"
    req = urllib.request.Request(
        url, data=data, method="PUT",
        headers={"AccessKey": KEY, "Content-Type": "application/octet-stream"},
    )
    with urllib.request.urlopen(req) as r:
        if r.status not in (200, 201):
            raise RuntimeError(f"HTTP {r.status}")


async def do_clip(sem, storage_path, text):
    async with sem:
        data = await synth(text)
        await asyncio.to_thread(upload, storage_path, data)


async def process(topic_id: str):
    path = ASSETS / f"{topic_id}.json"
    topic = json.loads(path.read_text("utf-8"))
    level = topic.get("level", 1)
    base_storage = f"speak_your_mind/level{level}/{topic_id}"
    base_json = f"bunny/{base_storage}"

    # Build the work list (label, text, storage_path, setter) honouring --force.
    jobs = []
    for mi, move in enumerate(topic["toolbox"], start=1):
        for ii, c in enumerate(move["items"], start=1):
            fname = f"m{mi}-i{ii}.mp3"
            if c.get("audio") and not FORCE:
                continue
            jobs.append((c["text_en"], f"{base_storage}/{fname}", c, f"{base_json}/{fname}"))
    g = topic.get("guide")
    if g and g.get("model_en") and (FORCE or not g.get("model_audio")):
        jobs.append((g["model_en"], f"{base_storage}/guide-model.mp3", g,
                     f"{base_json}/guide-model.mp3"))

    if not jobs:
        print(f"  {topic_id}: already done (skip)")
        return

    sem = asyncio.Semaphore(8)
    done = 0

    async def run(text, storage_path, obj, json_path):
        nonlocal done
        try:
            await do_clip(sem, storage_path, text)
            obj["audio" if "text_en" in obj else "model_audio"] = json_path
            done += 1
        except Exception as e:
            print(f"    ERR {storage_path}: {e}")

    await asyncio.gather(*(run(*j) for j in jobs))
    path.write_text(json.dumps(topic, ensure_ascii=False, indent=2) + "\n", "utf-8")
    print(f"  {topic_id}: {done}/{len(jobs)} uploaded -> {base_storage}/")


async def main():
    print(f"Voice={VOICE} rate={RATE}  topics={len(topic_ids)}  force={FORCE}")
    for tid in topic_ids:
        await process(tid)
    print("Done.")


asyncio.run(main())
