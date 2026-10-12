"""Reviewer 183.  Claim 2: is F_5's placement in the 14 diagrams valid over Q?

The record solved the coordinate system at p = 10007.  Here the SAME 14 diagrams
(reproduced from the same seeds) are evaluated in EXACT INTEGER arithmetic at
exact points of Weyl_5, and the coordinate system is solved over Q with
Fractions.  No prime anywhere in the solve.
"""
from fractions import Fraction as F
import numpy as np, random, importlib.util, sys, os, itertools

here = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(here, "..", "r179"))
import weyl_invariants as WI

runs = os.path.join(here, "..", "..", "runs")
def load(name):
    spec = importlib.util.spec_from_file_location(name[:-3], os.path.join(runs, name))
    m = importlib.util.module_from_spec(spec)
    o = sys.stdout; sys.stdout = open(os.devnull, "w")
    spec.loader.exec_module(m); sys.stdout = o
    return m
wm = load("run_n5_weyl_module.py")
N, SPAIRS, BASIS = wm.N, wm.SPAIRS, wm.BASIS
TEN = [wm.sym2_to_R({SPAIRS[k]: c for k, c in enumerate(b) if c}) for b in BASIS]

# ---- step 1: reproduce the record's 14 diagrams, same seeds, same loop ----
P = 10007
rng = np.random.default_rng(7); pyrng = random.Random(7)
PTS = [WI.random_weyl(N, P, rng) for _ in range(40)]
basis, rows, stall = [], [], 0
while len(basis) < 14 and stall < 4000:
    m = WI.random_matching(6, pyrng)
    c = [WI.eval_diagram(W, m, 6, P) % P for W in PTS]
    if WI.rank_modp([r[:] for r in rows] + [c], P) > len(rows):
        rows.append(c); basis.append(m); stall = 0
    else:
        stall += 1
print(f"reproduced {len(basis)} diagrams from the record's seeds "
      f"(rank {WI.rank_modp([r[:] for r in rows], P)})")

# ---- step 2: exact integer evaluation at exact points of Weyl_5 ----
def eval_exact(Wobj, matching):
    mr, trees = WI.best_tree(6, matching)
    legs = {}
    for a, b in matching: legs[a] = b; legs[b] = a
    base = {1 << v: (Wobj, [4*v+j for j in range(4)]) for v in range(6)}
    def go(t):
        if isinstance(t, int): return base[t]
        Ti, li = go(t[0]); Tj, lj = go(t[1])
        sh = [(a, legs[a]) for a in li if legs.get(a) in lj]
        ax0 = [li.index(a) for a, b in sh]; ax1 = [lj.index(b) for a, b in sh]
        Tn = np.tensordot(Ti, Tj, axes=(ax0, ax1))
        ln = [l for x, l in enumerate(li) if x not in ax0] + \
             [l for x, l in enumerate(lj) if x not in ax1]
        return Tn, ln
    val = 1
    for t in trees:
        T, l = go(t); assert T.ndim == 0
        val = val * int(T)
    return val

rnd = random.Random(1830)
NPTS = 20
QPTS = []
for _ in range(NPTS):
    cs = [rnd.randint(-3, 3) for _ in range(35)]
    A = np.zeros((N,N,N,N), dtype=object)
    for c, T in zip(cs, TEN):
        if not c: continue
        for i in range(N):
            for j in range(N):
                for k in range(N):
                    for l in range(N):
                        if T[i][j][k][l]: A[i,j,k,l] += c*int(T[i][j][k][l])
    QPTS.append(A)
# sanity: they really are Weyl tensors over Z
for A in QPTS:
    assert not np.any(A + A.transpose(1,0,2,3))
    assert not np.any(A - A.transpose(2,3,0,1))
    assert not np.any(A + A.transpose(0,2,3,1) + A.transpose(0,3,1,2))
    assert not np.any(np.einsum('abad->bd', A))
print(f"  {NPTS} exact integer Weyl tensors, all four symmetries verified over Z")

M = [[eval_exact(A, m) for m in basis] for A in QPTS]
def q(A):    return int(np.einsum('abcd,abcd->', A, A))
def trM3(A):
    Mm = A.reshape(N*N, N*N); return int(np.trace(Mm @ Mm @ Mm))
rhs = [F(3,2)*q(A)**3 - 9*trM3(A)**2 for A in QPTS]
print(f"  F_5 evaluated exactly; sample value {rhs[0]}")

# ---- step 3: solve over Q ----
def solveQ(A, b):
    m, n = len(A), len(A[0])
    Mx = [[F(x) for x in A[i]] + [F(b[i])] for i in range(m)]
    piv, r = [], 0
    for c in range(n):
        s = next((k for k in range(r, m) if Mx[k][c]), None)
        if s is None: continue
        Mx[r], Mx[s] = Mx[s], Mx[r]
        inv = F(1)/Mx[r][c]; Mx[r] = [x*inv for x in Mx[r]]
        for k in range(m):
            if k != r and Mx[k][c]:
                f = Mx[k][c]; Mx[k] = [x - f*y for x, y in zip(Mx[k], Mx[r])]
        piv.append(c); r += 1
    for k in range(r, m):
        if Mx[k][n] and not any(Mx[k][c] for c in range(n)): return None, r
    x = [F(0)]*n
    for i, c in enumerate(piv): x[c] = Mx[i][n]
    return x, r

rkA = solveQ(M, [0]*NPTS)[1]
print(f"  rank over Q of the 14 diagram columns at these {NPTS} points: {rkA}")
x, r = solveQ(M, rhs)
print(f"\n  F_5 lies in the Q-span of the 14 diagrams: {x is not None}")
if x is not None:
    ok = all(sum(M[i][b]*x[b] for b in range(14)) == rhs[i] for i in range(NPTS))
    print(f"  reproduces F_5 at all {NPTS} exact points: {ok}")
    print(f"  RATIONAL coordinates (of the built F_5 = 64 * the record's F_5):")
    for b, v in enumerate(x): print(f"    c[{b:2d}] = {v}")
    print(f"  coordinates of the record's F_5 = (3/2)tr(A^2)^3 - 9 tr(A^3)^2:")
    print(f"    {[str(v/64) for v in x]}")
