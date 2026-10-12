"""Claim 4, r186: tr(M^k) = 2^k tr(A^k), and how much of the 14 it covers.

Three separate questions, kept apart:
  (i)   is the trace identity true, and could the check have failed?
  (ii)  what is the DIMENSION of the operator-trace subalgebra at degree 6?
  (iii) is a non-operator-trace sextic 'scaled' or 'wrong' under the mix-up?
"""
from fractions import Fraction as F
from itertools import combinations, product
import importlib.util, sys, os, random
import numpy as np

d = os.path.dirname(os.path.abspath(__file__))
spec = importlib.util.spec_from_file_location(
    "wm", os.path.join(d, "..", "..", "runs", "run_n5_weyl_module.py"))
wm = importlib.util.module_from_spec(spec)
out = sys.stdout; sys.stdout = open(os.devnull, "w")
spec.loader.exec_module(wm); sys.stdout = out
N, NP, PAIRS = wm.N, wm.NP, wm.PAIRS

def tensor_of(coeffs):
    """an exact rational point of Weyl_5 as a 5x5x5x5 nested list."""
    v = {}
    for c, b in zip(coeffs, wm.BASIS):
        for k, x in enumerate(b):
            if x: v[wm.SPAIRS[k]] = v.get(wm.SPAIRS[k], F(0)) + c*x
    R = wm.sym2_to_R(v)
    return [[[[R[i][j][k][l] for l in range(N)] for k in range(N)]
             for j in range(N)] for i in range(N)]

def A_of(W):
    return [[W[i][j][k][l] for (k, l) in PAIRS] for (i, j) in PAIRS]

def M_of(W):
    """the FLAT 25x25 reshape M_{(ab),(cd)} = W_abcd, ordered pairs."""
    return [[W[a][b][c][d] for c in range(N) for d in range(N)]
            for a in range(N) for b in range(N)]

def trpow(X, k):
    n = len(X)
    Y = [r[:] for r in X]
    for _ in range(k-1):
        Y = [[sum(Y[i][t]*X[t][j] for t in range(n) if Y[i][t]) for j in range(n)]
             for i in range(n)]
    return sum(Y[i][i] for i in range(n))

rnd = random.Random(186)
PTS = [tensor_of([F(rnd.randint(-4, 4)) for _ in range(35)]) for _ in range(6)]

print("=== (i) tr(M^k) = 2^k tr(A^k), exactly over Q, at 6 random Weyl_5 points ===")
allok = True
for idx, W in enumerate(PTS):
    A, M = A_of(W), M_of(W)
    line = []
    for k in range(1, 7):
        tA, tM = trpow(A, k), trpow(M, k)
        ok = (tM == 2**k * tA)
        allok &= ok
        line.append(f"k={k}:{'ok' if ok else 'FAIL'}")
    print(f"  point {idx}: " + " ".join(line) + f"   tr(A^2)={trpow(A,2)}")
print(f"  identity holds for k = 1..6 at every point: {allok}")

print("\n  teeth -- the same check on tensors that break one hypothesis:")
# (a) drop antisymmetry in the last two slots
W = PTS[0]
Wbad = [[[[W[i][j][k][l] + (F(1) if (i,j,k,l)==(0,1,2,3) else F(0))
           for l in range(N)] for k in range(N)] for j in range(N)] for i in range(N)]
A, M = A_of(Wbad), M_of(Wbad)
print(f"   pair-antisymmetry broken in one entry: "
      + " ".join(f"k={k}:{'ok' if trpow(M,k)==2**k*trpow(A,k) else 'FAIL'}" for k in range(2,5)))
# (b) a nonzero SELF-PAIR entry W_00cd, added symmetrically so that pair symmetry
#     survives and A is untouched -- this is the hypothesis 'the diagonal vanishes'
import copy
Wdiag = copy.deepcopy(W)
Wdiag[0][0][1][2] = F(1);  Wdiag[1][2][0][0] = F(1)
Wdiag[0][0][2][1] = F(-1); Wdiag[2][1][0][0] = F(-1)
A, M = A_of(Wdiag), M_of(Wdiag)
print(f"   A is unchanged by it: {A == A_of(W)}")
print(f"   nonzero W_00cd (self-pair) entry:      "
      + " ".join(f"k={k}:{'ok' if trpow(M,k)==2**k*trpow(A,k) else 'FAIL'}" for k in range(2,5)))

print("\n=== (ii) the operator-trace subalgebra at degree 6 ===")
# block-respecting matchings glue whole pair-slots, so they are products of
# tr(A^{k_i}) with sum k_i = 6.  tr(A) = 0 on Weyl (traceless), so the only
# surviving partitions of 6 into parts >= 2 are 6, 4+2, 3+3, 2+2+2.
mons = [("tr(A^2)^3", lambda A: trpow(A,2)**3),
        ("tr(A^2)tr(A^4)", lambda A: trpow(A,2)*trpow(A,4)),
        ("tr(A^3)^2", lambda A: trpow(A,3)**2),
        ("tr(A^6)", lambda A: trpow(A,6))]
PTS2 = PTS + [tensor_of([F(rnd.randint(-6, 6)) for _ in range(35)]) for _ in range(6)]
Amats = [A_of(W) for W in PTS2]
print(f"  tr(A) at the 12 points: {sorted({trpow(A,1) for A in Amats})} (Weyl is trace-free)")
Vals = [[f(A) for name, f in mons] for A in Amats]
def rank_Q(rows):
    M = [r[:] for r in rows]; r = 0; nc = len(rows[0])
    for c in range(nc):
        p = next((k for k in range(r, len(M)) if M[k][c]), None)
        if p is None: continue
        M[r], M[p] = M[p], M[r]
        inv = F(1)/M[r][c]; M[r] = [x*inv for x in M[r]]
        for k in range(len(M)):
            if k != r and M[k][c]:
                f2 = M[k][c]; M[k] = [x - f2*y for x, y in zip(M[k], M[r])]
        r += 1
    return r
print(f"  rank of the 12x4 evaluation matrix of the four monomials over Q: {rank_Q(Vals)}")
print(f"  => the operator-trace sextics span exactly 4 dimensions, of the 14")

# F_5 sits inside it
f5 = [F(3,2)*trpow(A,2)**3 - 9*trpow(A,3)**2 for A in Amats]
aug = [row + [v] for row, v in zip(Vals, f5)]
print(f"  rank with F_5 adjoined: {rank_Q(aug)} (unchanged: F_5 IS an operator-trace sextic)")

print("\n=== (iii) is a NON-operator-trace sextic outside that span? ===")
sys.path.insert(0, os.path.join(d, "..", "r179"))
import weyl_invariants as WI
P = 10007
rng = np.random.default_rng(186)
pyrng = random.Random(1861)
MPTS = [WI.random_weyl(N, P, rng) for _ in range(40)]
def trpow_np(X, k):
    Y = np.eye(len(X), dtype=object)
    for _ in range(k): Y = (Y @ X) % P
    return int(np.trace(Y)) % P
def Amod(W):
    return np.array([[int(W[i][j][k][l]) % P for (k,l) in PAIRS] for (i,j) in PAIRS],
                    dtype=object)
mon_cols = []
for name, _ in mons:
    pass
cols = []
for W in MPTS:
    A = Amod(W)
    t2, t3, t4, t6 = (trpow_np(A,2), trpow_np(A,3), trpow_np(A,4), trpow_np(A,6))
    cols.append([t2**3 % P, t2*t4 % P, t3**2 % P, t6 % P])
rows_mon = [[cols[i][j] for j in range(4)] for i in range(len(MPTS))]
print(f"  rank mod {P} of the four monomials at 40 points: "
      f"{WI.rank_modp([r[:] for r in rows_mon], P)}")
# adjoin random matchings until the rank stops growing, capped at 14
rows = [r[:] for r in rows_mon]
found, tries, stall = 0, 0, 0
while stall < 3000 and len(rows[0]) < 14:
    m = WI.random_matching(6, pyrng); tries += 1
    c = [WI.eval_diagram(W, m, 6, P) % P for W in MPTS]
    trial = [r + [c[i]] for i, r in enumerate(rows)]
    if WI.rank_modp([r[:] for r in trial], P) > WI.rank_modp([r[:] for r in rows], P):
        rows = trial; found += 1; stall = 0
    else:
        stall += 1
print(f"  adjoining random diagram functionals raised the rank {found} times, "
      f"to {WI.rank_modp([r[:] for r in rows], P)} of 14")
print(f"  => {found} independent sextics lie OUTSIDE the operator-trace span "
      f"(the grading says nothing about them)")

print("\n=== (iii') the retracted note's own examples, tested ===")
# 'q^2 times a quadratic' and 'q times tr' -- are they scaled or wrong?
for W in PTS[:3]:
    A, M = A_of(W), M_of(W)
    qA, qM = trpow(A,2), trpow(M,2)
    tA, tM = trpow(A,3), trpow(M,3)
    ex1A, ex1M = qA**2 * qA, qM**2 * qM              # q^2 * a quadratic, degree 6
    ex2A, ex2M = qA * tA, qM * tM                    # q * tr, degree 5
    ex3A, ex3M = trpow(A,2)*trpow(A,4), trpow(M,2)*trpow(M,4)
    print(f"  q^2*q: ratio {F(ex1M, ex1A)} (64?)   q*tr: ratio {F(ex2M, ex2A)} (32?)   "
          f"tr2*tr4: ratio {F(ex3M, ex3A)} (64?)")
