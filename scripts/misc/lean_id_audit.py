#!/usr/bin/env python3
"""What the Lean layer already carries for a result id, before you write a new file for it.

The failure this exists for: a cycle reads the RECORD for an id, finds the route on file,
concludes the formalisation is owed, and writes a new Lean file -- while the layer already
carries the theorem, sometimes proving a strict superset, sorry-free, for months.

Classification against `findings/` does not catch it. The evidence is in `lean/`: in the
directory listing, and in the theorem names of the file the index row already links. Both
are cheaper than any record search, and both get skipped because the record search feels
like the diligent move.

Usage:
  python3 scripts/misc/lean_id_audit.py L72     # every file and theorem touching L72
  python3 scripts/misc/lean_id_audit.py I77
"""
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parents[2] / "lean" / "HamiltonsCubic"


def main():
    if len(sys.argv) != 2:
        print(__doc__)
        return 2
    ident = sys.argv[1]
    pat = re.compile(rf"\b{re.escape(ident)}\b", re.IGNORECASE)

    # Match the id as a whole token at the START of the stem, so `L16` does not
    # catch `L163Statement`. A first version used a substring test and reported
    # twelve files for `L16`, which is the over-reporting direction: harmless to
    # read past, but it buries the two files that matter.
    idpat = re.compile(rf"^{re.escape(ident)}(?![0-9])", re.IGNORECASE)
    named = sorted(f for f in ROOT.rglob("*.lean") if idpat.match(f.stem))
    if named:
        print(f"FILES ALREADY NAMED FOR {ident}: {len(named)}")
        for f in named:
            src = f.read_text(encoding="utf-8")
            thms = re.findall(r"^(?:theorem|lemma) (\S+)", src, re.M)
            sorries = len(re.findall(r"^\s*sorry\s*$", src, re.M))
            print(f"  {f.relative_to(ROOT.parent)}  ({len(thms)} theorems, {sorries} sorry)")
            for t in thms:
                print(f"      {t}")
    else:
        print(f"no file is named for {ident}")

    others = []
    for f in sorted(ROOT.rglob("*.lean")):
        if f in named:
            continue
        if pat.search(f.read_text(encoding="utf-8")):
            others.append(f)
    print(f"\nOTHER FILES MENTIONING {ident}: {len(others)}")
    for f in others:
        print(f"  {f.relative_to(ROOT.parent)}")
    print("\nRead the theorem names above before writing a new file. A superset may already be proved.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
