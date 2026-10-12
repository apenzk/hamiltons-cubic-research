"""Reviewer 197: the two NameErrors, reproduced from the file's own text.

Both are read out of git rather than retyped, so what runs is what shipped.
442373b is the commit the brief points at; 18c15f3 repaired the first.
"""
import subprocess, sys

def source(rev, path):
    return subprocess.run(["git", "show", f"{rev}:{path}"], capture_output=True,
                          text=True, check=True).stdout.split("\n")

P = "scripts/runs/run_n5_assemble.py"

# --- 1. det_p used before it is defined (442373b, repaired by 18c15f3) ---
src = source("442373b", P)
line = next(l for l in src if l.strip().startswith("print(f\"  lambda={lam}  m={m}  det h"))
print("shipped at 442373b:", line.strip())
ns = {"lam": (2, 0), "m": 2, "row": [[1, 0], [0, 1]], "print": print}
try:
    exec(line.strip(), ns); print("  RESULT: ran")
except NameError as e:
    print(f"  RESULT: NameError: {e}   <- reached on the first block with m > 1")

# --- 2. the bare name l in the control (442373b, repaired by 04e93f2) ---
i = next(k for k, l in enumerate(src) if l.startswith("_ctl = "))
stmt = "\n".join(src[i:i+1])
print("\nshipped at 442373b:", stmt)
ns = {"HMAT": {(2, 0): [[1, 1], [1, 1]]}}
try:
    exec(stmt, ns); print("  RESULT: ran, _ctl =", ns["_ctl"])
except NameError as e:
    print(f"  RESULT: NameError: {e}   <- l lives only in the comprehension")
    print("  the three asserts after it -- the control, the multi-probe check and")
    print("  weight-homogeneity -- were unreachable")

# --- 3. what the shipped control actually was ---
print("\nthe control's value, for any data at all:")
for h00 in (1,):
    ctl = [[h00 for _ in range(2)] for _ in range(2)]
    print(f"  HMAT[l][0][0] = {h00} (it is q00/q00 in every block) -> _ctl = {ctl}, rank 1 by construction")
