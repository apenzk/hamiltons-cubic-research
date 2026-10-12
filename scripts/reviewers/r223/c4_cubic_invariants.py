"""CLAIM 4.  The first-fundamental-theorem escape for the trivial block.

7479d70 records: "the trivial block has a second route that skips elimination --
its multiplicity space is the cubic O(12)-invariants, spanned by contraction
diagrams via the first fundamental theorem".  The multiplicity is 2.

This settles the dimension by EXHAUSTIVE enumeration rather than sampling.  For
k=3 the FFT spanning set is finite and small: every perfect matching of the 12
index slots of W (x) W (x) W, dropping the ones that pair two slots of the same
vertex (Weyl is traceless and pair-antisymmetric, so those vanish).  There are
11!! = 10,395 perfect matchings in all.  Evaluate every survivor on a fixed
batch of random Weyl tensors over F_p at n = 12 and take the rank of the
evaluation matrix: that rank is a LOWER bound on the dimension of the cubic
O(12)-invariants, and the FFT makes the diagrams a spanning set so the rank is
also an upper bound once enough points are used.

Reuses reviewer 179's evaluator verbatim, which is what the record points at.
"""
import os, sys, time, itertools
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "r179"))
import numpy as np
from weyl_invariants import random_weyl, eval_diagram, rank_modp

N, K, PP = 12, 3, 10007
NPTS = int(sys.argv[1]) if len(sys.argv) > 1 else 8
SEED = int(sys.argv[2]) if len(sys.argv) > 2 else 1

def matchings(slots):
    if not slots: yield []; return
    a = slots[0]
    for i in range(1, len(slots)):
        b = slots[i]
        rest = slots[1:i] + slots[i+1:]
        for m in matchings(rest): yield [(a, b)] + m

t0 = time.time()
rng = np.random.default_rng(SEED)
pts = [random_weyl(N, PP, rng) for _ in range(NPTS)]
print(f"{NPTS} random Weyl tensors at n={N} over F_{PP}, all four symmetries asserted "
      f"[{time.time()-t0:.1f}s]", flush=True)

allm = list(matchings(list(range(4*K))))
good = [m for m in allm if all(a//4 != b//4 for a, b in m)]
print(f"perfect matchings of {4*K} slots: {len(allm):,} in all, "
      f"{len(good):,} with no self-pairing at a vertex", flush=True)

t1 = time.time()
rows, labels = [], []
r = 0; firsts = []
for m in good:
    vals = [eval_diagram(Wp, m, K, PP) for Wp in pts]
    rows.append(vals); labels.append(m)
    nr = rank_modp(rows, PP)
    if nr > r:
        r = nr; firsts.append((len(rows)-1, m, vals))
    if len(rows) % 2000 == 0:
        print(f"  {len(rows):,}/{len(good):,} diagrams, rank {r}, {time.time()-t1:.0f}s", flush=True)
el = time.time()-t1
print(f"\nEXHAUSTIVE: {len(good):,} diagrams, rank {r}, {el:.1f}s "
      f"({el/len(good)*1000:.1f} ms per diagram at {NPTS} points)")
print(f"total wall time including the Weyl tensors: {time.time()-t0:.1f}s")
print("\ndiagrams at which the rank first rose (a basis of the invariant space):")
for i, m, vals in firsts:
    print(f"  #{i:<6} matching {m}")
    print(f"          values {vals}")

# how many of the 10,395 are nonzero at all, and are the survivors all proportional
# to the two?  Report the profile so the span is visible rather than asserted.
nz = sum(1 for v in rows if any(x % PP for x in v))
print(f"\n{nz:,} of {len(good):,} diagrams evaluate nonzero somewhere; "
      f"they span a space of dimension {r}")
