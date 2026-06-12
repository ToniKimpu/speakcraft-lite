#!/usr/bin/env python3
"""Recursively download a folder from a Bunny.net Storage Zone.

Bunny Storage (unlike the CDN pull zone) exposes a directory-listing API, so we
can mirror an entire tree locally — handy for pulling every lesson's JSON to run
count_lesson.py on. Read-only: it only lists and GETs.

Config (via environment variables — keep the key OUT of the repo):
    BUNNY_STORAGE_ZONE   storage zone NAME (e.g. "speakcraft"), not the numeric id
    BUNNY_ACCESS_KEY     storage zone password / read-only password (secret)
    BUNNY_STORAGE_HOST   storage endpoint hostname for the zone's region
                         (default: storage.bunnycdn.com; others: ny./la./sg./
                         syd./uk./se./br./jh.storage.bunnycdn.com)

Usage:
    BUNNY_STORAGE_ZONE=myzone BUNNY_ACCESS_KEY=xxxx \
        python bunny_pull.py listenings ./bunny_download

    # PowerShell:
    #   $env:BUNNY_STORAGE_ZONE="myzone"; $env:BUNNY_ACCESS_KEY="xxxx"
    #   python bunny_pull.py listenings ./bunny_download

Args:
    remote_path   folder inside the zone to mirror (default: listenings)
    out_dir       local destination (default: ./bunny_download)
"""

import json
import os
import sys
import urllib.error
import urllib.request
from pathlib import Path

ZONE = os.environ.get("BUNNY_STORAGE_ZONE", "").strip()
ACCESS_KEY = os.environ.get("BUNNY_ACCESS_KEY", "").strip()
HOST = os.environ.get("BUNNY_STORAGE_HOST", "storage.bunnycdn.com").strip()


def _request(url: str) -> bytes:
    req = urllib.request.Request(url, headers={"AccessKey": ACCESS_KEY})
    with urllib.request.urlopen(req, timeout=60) as resp:
        return resp.read()


def list_dir(remote_path: str) -> list:
    """List one directory. Bunny wants a trailing slash on directory listings."""
    url = f"https://{HOST}/{ZONE}/{remote_path.strip('/')}/"
    raw = _request(url)
    return json.loads(raw.decode("utf-8"))


def download_file(remote_path: str, dest: Path) -> int:
    url = f"https://{HOST}/{ZONE}/{remote_path.strip('/')}"
    data = _request(url)
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.write_bytes(data)
    return len(data)


def mirror(remote_path: str, out_dir: Path) -> tuple[int, int]:
    """Recursively mirror remote_path into out_dir. Returns (files, bytes)."""
    files = 0
    total = 0
    for entry in list_dir(remote_path):
        name = entry["ObjectName"]
        child_remote = f"{remote_path.strip('/')}/{name}"
        child_local = out_dir / name
        if entry.get("IsDirectory"):
            print(f"  dir   {child_remote}/")
            f, b = mirror(child_remote, child_local)
            files += f
            total += b
        else:
            size = download_file(child_remote, child_local)
            files += 1
            total += size
            print(f"  file  {child_remote}  ({size:,} B)")
    return files, total


def main() -> None:
    if not ZONE or not ACCESS_KEY:
        sys.exit(
            "error: set BUNNY_STORAGE_ZONE and BUNNY_ACCESS_KEY env vars first."
        )

    remote_path = sys.argv[1] if len(sys.argv) > 1 else "listenings"
    out_dir = Path(sys.argv[2] if len(sys.argv) > 2 else "bunny_download")

    print(f"Mirroring  {ZONE}/{remote_path}  ->  {out_dir}  (host {HOST})")
    try:
        files, total = mirror(remote_path, out_dir / Path(remote_path).name)
    except urllib.error.HTTPError as e:
        body = e.read().decode("utf-8", "replace")[:300]
        sys.exit(f"HTTP {e.code} for {e.url}\n{body}")
    except urllib.error.URLError as e:
        sys.exit(f"network error: {e.reason} (check BUNNY_STORAGE_HOST region)")

    print(f"\nDone. {files} files, {total:,} bytes -> {out_dir}")


if __name__ == "__main__":
    main()
