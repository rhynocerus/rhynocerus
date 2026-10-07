#!/usr/bin/env python3
"""Count failed SSH authentication events in a supplied text log."""

from collections import Counter
from pathlib import Path
import re
import sys

FAILED = re.compile(r"Failed password for (?:invalid user )?\S+ from (\S+)")


def main() -> int:
    if len(sys.argv) != 2:
        print(f"Usage: {Path(sys.argv[0]).name} PATH_TO_AUTH_LOG", file=sys.stderr)
        return 2
    path = Path(sys.argv[1])
    try:
        lines = path.read_text(encoding="utf-8", errors="replace").splitlines()
    except OSError as exc:
        print(f"Could not read input file: {exc}", file=sys.stderr)
        return 1
    counts = Counter(match.group(1) for line in lines if (match := FAILED.search(line)))
    print("Failed SSH authentication attempts by source:")
    for address, count in sorted(counts.items()):
        print(f"{address}: {count}")
    print(f"Total failed attempts: {sum(counts.values())}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
