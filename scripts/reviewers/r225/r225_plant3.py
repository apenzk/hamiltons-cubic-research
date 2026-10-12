"""Planted violation for claim 3: move one entry of the stable table and confirm the
SO comparison fires.  Guards against a comparison that cannot fail."""
import json, subprocess, sys, os, shutil
n = sys.argv[1]
SRC = 'scripts/reviewers/r225/r225_stable_table.json'
bak = SRC + '.bak'
shutil.copy(SRC, bak)
try:
    for desc, mut in [
        ("control (unmodified table)", lambda d: d),
        ("one multiplicity bumped 8 -> 9 at [2, 2]", lambda d: {**d, "[2, 2]": d["[2, 2]"] + 1}),
        ("the extremal block [2,2,2,2,2,2] deleted",
         lambda d: {k: v for k, v in d.items() if k != "[2, 2, 2, 2, 2, 2]"}),
        ("a spurious 7-row block added", lambda d: {**d, "[2, 2, 2, 2, 2, 1, 1]": 1}),
    ]:
        d = json.load(open(bak))
        json.dump(mut(d), open(SRC, 'w'))
        r = subprocess.run([sys.executable, 'scripts/reviewers/r225/r225_compare.py', n],
                           capture_output=True, text=True)
        out = r.stdout + r.stderr
        verdict = ("MATCH -> check did NOT fire" if "EXACT MATCH          : True" in out
                   else ("FIRED (%s)" % ("assertion" if r.returncode else "mismatch reported")))
        print("%-45s %s" % (desc, verdict))
finally:
    shutil.move(bak, SRC)
