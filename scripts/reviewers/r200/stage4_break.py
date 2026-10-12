"""Reviewer 200, claim 4: stage 4 was committed unrun.  Run the parts of it that
exist, verbatim, against the inputs the docstring names, and show what breaks.

solve_weight is copied CHARACTER FOR CHARACTER out of run_n5_assemble.py
(lines 368-391).  The only change is that PRIME/IDX/MONS/to_p are supplied here,
so nothing under review is edited or executed.
"""
import importlib.util, sys, os, pickle, itertools, collections, random
from fractions import Fraction as Fr
RUNS = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                    "..", "..", "runs"))
def load(name):
    sp = importlib.util.spec_from_file_location(name[:-3], os.path.join(RUNS, name))
    m = importlib.util.module_from_spec(sp)
    o = sys.stdout; sys.stdout = open(os.devnull, "w")
    sp.loader.exec_module(m); sys.stdout = o
    return m
ev = load("run_n5_evaluate.py"); wm2 = load("run_n5_weyl_module.py")
MONO, WT = ev.MONO, ev.WT
RAW = pickle.load(open(os.path.join(RUNS, "n5_adapted.pkl"), "rb"))
PRIME = 1000033
IMOD = next(x for x in range(2, PRIME) if pow(x, 2, PRIME) == PRIME-1)
def to_p(x):
    if hasattr(x, "r"): a, b = x.r, x.i
    else: (a, b) = x
    assert a.denominator % PRIME and b.denominator % PRIME
    return (a.numerator*pow(a.denominator % PRIME, PRIME-2, PRIME)
            + b.numerator*pow(b.denominator % PRIME, PRIME-2, PRIME)*IMOD) % PRIME
def mwt(idx):
    a, b, c = MONO[idx]
    return (WT[a][0]+WT[b][0]+WT[c][0], WT[a][1]+WT[b][1]+WT[c][1])
MONS = {}
for idx in range(len(MONO)): MONS.setdefault(mwt(idx), []).append(idx)
IDX = {}
for lam, copies in RAW.items():
    for i, c in enumerate(copies):
        for t, v in enumerate(c):
            if v: IDX.setdefault(mwt(max(v)), []).append((lam, i, t, v))

# ---- verbatim from run_n5_assemble.py, lines 368-391 ----
def solve_weight(w, target):
    ent = IDX[w]; mons = MONS[w]
    mi = {m: k for k, m in enumerate(mons)}
    n = len(ent)
    A = [[0]*(n+1) for _ in range(len(mons))]
    for j, (_, _, _, v) in enumerate(ent):
        for k, cv in v.items(): A[mi[k]][j] = to_p(cv)
    for k, cv in target.items():
        if k in mi: A[mi[k]][n] = cv % PRIME
    r = 0; piv = []
    for c in range(n):
        p_ = next((t for t in range(r, len(A)) if A[t][c] % PRIME), None)
        if p_ is None: continue
        A[r], A[p_] = A[p_], A[r]
        inv = pow(A[r][c], PRIME-2, PRIME)
        A[r] = [x*inv % PRIME for x in A[r]]
        for t in range(len(A)):
            if t != r and A[t][c] % PRIME:
                f = A[t][c]; A[t] = [(x - f*y) % PRIME for x, y in zip(A[t], A[r])]
        piv.append(c); r += 1
    x = [0]*n
    for t, c in enumerate(piv): x[c] = A[t][n]
    return ent, x
# ---- end verbatim ----

# ---- verbatim from run_n5_assemble.py, lines 350-359 ----
import random as _r2
_r2.seed(17)
def sample_weyl():
    v = [Fr(_r2.randint(-3, 3)) for _ in range(35)]
    full = [sum(v[j]*wm2.BASIS[j][c] for j in range(35) if v[j])
            for c in range(len(wm2.SPAIRS))]
    return wm2.sym2_to_R({wm2.SPAIRS[c]: full[c]
                          for c in range(len(full)) if full[c]})
# ---- end verbatim ----

W = sample_weyl()
print(f"sample_weyl returns {type(W).__name__} of shape "
      f"{len(W)}x{len(W[0])}x{len(W[0][0])}x{len(W[0][0][0])}")
w = ev.coords(W)
cu = ev.cube(w)
print(f"coords(W): {len(w)} weight-basis coordinates")
print(f"cube(w): {len(cu)} nonzero Sym^3 coefficients")
kt = next(iter(cu))
print(f"  a key of cube(w): {kt!r}  type {type(kt).__name__}")
kv = next(iter(RAW[(6, 6)][0][0]))
print(f"  a key of an adapted vector: {kv!r}  type {type(kv).__name__}")
print(f"  MONS keys are monomial INDICES: {MONS[(0,0)][:3]}")
print(f"  keys of cube(w) that are in MONS' index space: "
      f"{sum(1 for k in cu if isinstance(k, int))} of {len(cu)}")

# the shipped solve, on a small weight
for wt in sorted(MONS, key=lambda z: len(MONS[z]))[:3]:
    ent, x = solve_weight(wt, cu)
    print(f"\nweight {wt}: {len(MONS[wt])} monomials, {len(IDX[wt])} adapted "
          f"vectors, solve_weight -> x = {x}")
    print(f"   nonzero coordinates: {sum(1 for z in x if z)}")
    # what the true restriction is
    tru = {i: cu[MONO[i]] for i in MONS[wt] if MONO[i] in cu}
    print(f"   the true W^3 restricted to this weight has "
          f"{len(tru)} nonzero monomials -> the solve should NOT be zero")

# what happens if the key space is repaired
print("\n=== with the key space repaired (tuple -> index) ===")
TIDX = {t: i for i, t in enumerate(MONO)}
cu_i = {TIDX[t]: v for t, v in cu.items()}
try:
    ent, x = solve_weight(sorted(MONS, key=lambda z: len(MONS[z]))[0], cu_i)
    print(f"   x = {x}")
except Exception as e:
    print(f"   raises {type(e).__name__}: {e}")

print("\n=== and with to_p applied to the target as well ===")
cu_p = {TIDX[t]: to_p(v) for t, v in cu.items()}
wt = sorted(MONS, key=lambda z: len(MONS[z]))[0]
ent, x = solve_weight(wt, cu_p)
print(f"   weight {wt}: x = {x}")
# verify the expansion reproduces the target
chk = collections.defaultdict(int)
for j, (_, _, _, v) in enumerate(ent):
    if not x[j]: continue
    for k, cv in v.items(): chk[k] = (chk[k] + x[j]*to_p(cv)) % PRIME
tgt = {i: cu_p.get(i, 0) for i in MONS[wt]}
bad = sum(1 for i in MONS[wt] if chk.get(i, 0) % PRIME != tgt[i] % PRIME)
print(f"   residual monomials where the expansion misses the target: {bad} "
      f"of {len(MONS[wt])}")

# rank deficiency: is the per-weight matrix invertible mod p for every weight?
print("\n=== is every per-weight basis matrix nonsingular mod p? ===")
def rank_p(w):
    ent = IDX[w]; mons = MONS[w]; mi = {m: k for k, m in enumerate(mons)}
    n = len(ent)
    A = [[0]*n for _ in range(len(mons))]
    for j, (_, _, _, v) in enumerate(ent):
        for k, cv in v.items(): A[mi[k]][j] = to_p(cv)
    r = 0
    for c in range(n):
        p_ = next((t for t in range(r, len(A)) if A[t][c] % PRIME), None)
        if p_ is None: continue
        A[r], A[p_] = A[p_], A[r]
        inv = pow(A[r][c], PRIME-2, PRIME)
        A[r] = [z*inv % PRIME for z in A[r]]
        for t in range(len(A)):
            if t != r and A[t][c] % PRIME:
                f = A[t][c]; A[t] = [(z - f*y) % PRIME for z, y in zip(A[t], A[r])]
        r += 1
    return r, n
defic = []
import time
t0 = time.time()
for wt in sorted(MONS, key=lambda z: len(MONS[z])):
    r, n = rank_p(wt)
    if r != n: defic.append((wt, r, n))
print(f"   weights checked {len(MONS)}, rank-deficient mod p: {len(defic)} "
      f"{defic[:5]}   [{time.time()-t0:.0f}s]")
