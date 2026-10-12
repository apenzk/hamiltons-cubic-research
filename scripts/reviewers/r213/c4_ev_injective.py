"""r213: is evaluation at the 40 sample points injective on the invariant sextics?

If it is, the load-bearing "40 equations give an identity" step needs no rank
argument at all: the certificate's sextic and F_5 are both O(5)-invariant sextics
on Weyl_5, that space has dimension 14 (Weyl integration, run_n5_constraint_count),
they agree at the 40 points, and an injective evaluation forces them equal.

Injectivity is established here from OUTSIDE the pipeline: build many explicit
invariant sextics as complete contractions of six copies of W, evaluate them at
the 40 sample points, and read the rank of the resulting 40 x (many) matrix.
The rank cannot exceed 14; if it reaches 14, evaluation is injective on the whole
space and nothing else is needed.
"""
import os, sys, importlib.util, random, itertools
import numpy as np
from fractions import Fraction as F

HERE = os.path.dirname(os.path.abspath(__file__))
RUNS = os.path.join(HERE, "..", "..", "runs")
sp = importlib.util.spec_from_file_location("wm", os.path.join(RUNS, "run_n5_weyl_module.py"))
wm = importlib.util.module_from_spec(sp)
_o = sys.stdout; sys.stdout = open(os.devnull, "w")
try: sp.loader.exec_module(wm)
finally: sys.stdout = _o

random.seed(20260829)
TS = []
for k in range(41):
    v = [F(random.randint(-4, 4)) for _ in range(35)]
    if k == 0: continue
    full = [sum(v[j]*wm.BASIS[j][c] for j in range(35) if v[j])
            for c in range(len(wm.SPAIRS))]
    R = wm.sym2_to_R({wm.SPAIRS[c]: full[c] for c in range(len(full)) if full[c]})
    TS.append(np.array([[[[float(R[a][b][c][d]) for d in range(5)]
                          for c in range(5)] for b in range(5)] for a in range(5)]))
print(f"{len(TS)} sample Weyl tensors, the same 40 the pipeline used")
sc = np.array([np.abs(t).max() for t in TS])
TSn = [t/s for t, s in zip(TS, sc)]         # scale each point; invariants are
                                            # homogeneous, so rank is unchanged

LET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWX"
def subscripts(match):
    lab = [None]*24
    for r, (i, j) in enumerate(match):
        lab[i] = lab[j] = LET[r]
    return ",".join("".join(lab[4*t:4*t+4]) for t in range(6))

rng = random.Random(213213)
def rand_match():
    s = list(range(24)); rng.shuffle(s)
    return [(s[2*k], s[2*k+1]) for k in range(12)]

COLS, seen = [], set()
while len(COLS) < 120:
    m = rand_match()
    ss = subscripts(m)
    if ss in seen: continue
    seen.add(ss)
    col = np.array([float(np.einsum(ss, *([t]*6), optimize=True)) for t in TSn])
    if np.abs(col).max() < 1e-12: continue
    COLS.append(col/np.abs(col).max())
M = np.array(COLS).T                        # 40 x 120
sv = np.linalg.svd(M, compute_uv=False)
rk = int((sv > sv[0]*1e-10).sum())
print(f"\n{M.shape[1]} complete contractions of six W's, evaluated at the 40 points")
print(f"singular values 10..18: {np.array2string(sv[9:18], precision=4)}")
print(f"numerical rank of the 40 x {M.shape[1]} evaluation matrix: {rk}")
print(f"dim (Sym^6 Weyl_5)^{{O(5)}} = 14 caps it, so rank {rk} means")
if rk == 14:
    print("  EVALUATION AT THE 40 POINTS IS INJECTIVE ON EVERY INVARIANT SEXTIC.")
    print("  Two invariant sextics agreeing at those points are therefore equal,")
    print("  and the identity step needs no statement about rank(mu) at all.")
else:
    print(f"  the span reached is only {rk}-dimensional -- inconclusive here.")
