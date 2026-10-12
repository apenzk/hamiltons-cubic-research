"""r184, claim 2: a RATIONAL placement of F_5 in the 14 diagrams, with exact
coordinates -- not a mod-p solution.

Step 1 reproduces the record's 14 matchings bit-for-bit (same seeds, same
generator calls as run_n5_sextic_basis.py).
Step 2 re-evaluates those 14 diagrams and F_5 at INTEGER Weyl tensors, with
Python-int arithmetic throughout, and solves the 14 unknowns over Q by exact
Gaussian elimination on Fractions.
Step 3 checks the exact solution against fresh integer points never used in the
fit -- the only thing that separates a placement from a curve fit.
"""
import sys, os, random
import numpy as np
from fractions import Fraction as F
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "r179"))
import weyl_invariants as WI

N, K, P = 5, 6, 10007

# ---------- step 1: the record's 14 matchings ----------
rng = np.random.default_rng(7); pyrng = random.Random(7)
PTS = [WI.random_weyl(N, P, rng) for _ in range(40)]
def col(m): return [WI.eval_diagram(W, m, K, P) % P for W in PTS]
basis, rows, tries, stall = [], [], 0, 0
while len(basis) < 14 and stall < 4000:
    m = WI.random_matching(K, pyrng); tries += 1
    c = col(m)
    if WI.rank_modp([r[:] for r in rows + [c]], P) > len(rows):
        rows.append(c); basis.append(m); stall = 0
    else:
        stall += 1
print(f"reproduced the record's selection: {len(basis)} diagrams from {tries} matchings")

# ---------- step 2: exact integer Weyl tensors ----------
def kn_o(h, k):
    return (np.einsum('ac,bd->abcd', h, k) + np.einsum('bd,ac->abcd', h, k)
            - np.einsum('ad,bc->abcd', h, k) - np.einsum('bc,ad->abcd', h, k))

def integer_weyl(n, r):
    """24*W for a Weyl tensor W over Q; degree-6 homogeneity makes the factor
    irrelevant to the coordinates, so this stays in Z."""
    T = np.array([[[[r.randint(-4, 4) for _ in range(n)] for _ in range(n)]
                   for _ in range(n)] for _ in range(n)], dtype=object)
    A = T - T.transpose(1,0,2,3) - T.transpose(0,1,3,2) + T.transpose(1,0,3,2)
    A = A + A.transpose(2,3,0,1)
    R = 3*A - (A + A.transpose(0,2,3,1) + A.transpose(0,3,1,2))
    g = np.array(np.eye(n, dtype=int), dtype=object)
    Ric = np.einsum('abad->bd', R)
    s = sum(Ric[i][i] for i in range(n))
    # W = R - kn(Ric,g)/(n-2) + s*kn(g,g)/(2(n-1)(n-2));  x24 with n=5: 24R - 8kn(Ric,g) + s kn(g,g)
    Wi = 24*R - 8*kn_o(Ric, g) + s*kn_o(g, g)
    assert not np.any(Wi + Wi.transpose(1,0,2,3))
    assert not np.any(Wi - Wi.transpose(2,3,0,1))
    assert not np.any(Wi + Wi.transpose(0,2,3,1) + Wi.transpose(0,3,1,2))
    assert not np.any(np.einsum('abad->bd', Wi))
    return Wi

def eval_exact(W, matching, k):
    legs = {}
    for a, b in matching: legs[a] = b; legs[b] = a
    tensors = [(W, [4*v+j for j in range(4)]) for v in range(k)]
    while True:
        best = None
        for i in range(len(tensors)):
            for j in range(i+1, len(tensors)):
                li, lj = tensors[i][1], tensors[j][1]
                sh = [(a, legs[a]) for a in li if legs.get(a) in lj]
                if not sh: continue
                out = len(li) + len(lj) - 2*len(sh)
                if best is None or out < best[0]: best = (out, i, j, sh)
        if best is None: break
        out, i, j, sh = best
        Ti, li = tensors[i]; Tj, lj = tensors[j]
        ax0 = [li.index(a) for a, b in sh]; ax1 = [lj.index(b) for a, b in sh]
        Tn = np.tensordot(Ti, Tj, axes=(ax0, ax1))
        ln = [l for x, l in enumerate(li) if x not in ax0] + \
             [l for x, l in enumerate(lj) if x not in ax1]
        for a, b in sh: legs.pop(a, None); legs.pop(b, None)
        tensors = [t for x, t in enumerate(tensors) if x not in (i, j)] + [(Tn, ln)]
    val = 1
    for T, l in tensors:
        assert T.ndim == 0
        val = val * _sc(T)
    return val

def _sc(x):
    return x.item() if hasattr(x, 'item') else x

def F5_built(W):
    """exactly what run_n5_sextic_basis.py builds: full-einsum |W|^2 and the
    25x25 flattening's cube trace."""
    q = _sc(np.einsum('abcd,abcd->', W, W))
    M = W.reshape(N*N, N*N)
    t = _sc(np.trace(M @ M @ M))
    return F(3, 2)*q**3 - 9*t**2

def F5_record(W):
    """the record's F_5: |W| and tr(W^3) as the Lambda^2 operator (10x10)."""
    pr = [(a, b) for a in range(N) for b in range(a+1, N)]
    W10 = np.array([[W[i][j][k][l] for (k, l) in pr] for (i, j) in pr], dtype=object)
    q = sum(W10[a][b]**2 for a in range(10) for b in range(10))
    M3 = W10 @ W10 @ W10
    t = sum(M3[a][a] for a in range(10))
    return F(3, 2)*q**3 - 9*t**2

r = random.Random(184)
NFIT, NTEST = 18, 12
PTS_Z = [integer_weyl(N, r) for _ in range(NFIT + NTEST)]
print(f"{len(PTS_Z)} integer Weyl tensors, all four symmetries and Ric=0 asserted exactly")

ratios = [F(F5_built(W), F5_record(W)) for W in PTS_Z if F5_record(W)]
print(f"built F_5 / record F_5 is the constant {set(ratios)}  "
      f"(one value: {len(set(ratios)) == 1})")

A = [[F(eval_exact(W, m, K)) for m in basis] for W in PTS_Z]
b = [F(F5_record(W)) for W in PTS_Z]
print("evaluation matrix built exactly over Z")

def solve_Q(A, b, nfit):
    n = len(A[0])
    M = [A[i][:] + [b[i]] for i in range(nfit)]
    piv, rr = [], 0
    for c in range(n):
        s = next((k for k in range(rr, len(M)) if M[k][c]), None)
        if s is None: continue
        M[rr], M[s] = M[s], M[rr]
        inv = F(1)/M[rr][c]; M[rr] = [x*inv for x in M[rr]]
        for k in range(len(M)):
            if k != rr and M[k][c]:
                f = M[k][c]; M[k] = [x - f*y for x, y in zip(M[k], M[rr])]
        piv.append(c); rr += 1
    for k in range(rr, len(M)):
        if M[k][n] and not any(M[k][c] for c in range(n)): return None, rr
    x = [F(0)]*n
    for i, c in enumerate(piv): x[c] = M[i][n]
    return x, rr

x, rk = solve_Q(A, b, NFIT)
print(f"\nrank of the 14 diagrams on the {NFIT} fitting points: {rk}")
if x is None:
    print("NO RATIONAL SOLUTION -- the mod-p placement does not lift")
else:
    print("exact rational coordinates of F_5 (record normalisation):")
    for j, v in enumerate(x): print(f"   c{j:2d} = {v}")
    held = all(sum(A[i][j]*x[j] for j in range(14)) == b[i]
               for i in range(NFIT, NFIT + NTEST))
    print(f"\nreproduces F_5 exactly at the {NTEST} HELD-OUT points: {held}")
    # and against the record's own mod-p coordinates
    print(f"coordinates reduced mod {P}: "
          f"{[int(v.numerator % P) * pow(int(v.denominator % P), P-2, P) % P for v in x]}")
