"""r184, claim 3: settle so(5)-invariance of the rank-4 Gram OUTRIGHT, as the
matrix identity A^T G + G A = 0, and pin the factor against the Lambda^2 norm."""
from fractions import Fraction as F
import importlib.util, sys, os
d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
def load(name):
    spec = importlib.util.spec_from_file_location(name[:-3], os.path.join(d, name))
    m = importlib.util.module_from_spec(spec)
    o = sys.stdout; sys.stdout = open(os.devnull, "w"); spec.loader.exec_module(m); sys.stdout = o
    return m
wm = load("run_n5_weyl_module.py")
N, SPAIRS, BASIS, GENS, NP, PAIRS = wm.N, wm.SPAIRS, wm.BASIS, wm.GENS, wm.NP, wm.PAIRS

TEN = [wm.sym2_to_R({SPAIRS[k]: c for k, c in enumerate(bb) if c}) for bb in BASIS]
def tdot(A, B):
    return sum(A[i][j][k][l]*B[i][j][k][l] for i in range(N) for j in range(N)
               for k in range(N) for l in range(N))
G = [[F(0)]*35 for _ in range(35)]
for i in range(35):
    for j in range(i, 35): G[i][j] = G[j][i] = tdot(TEN[i], TEN[j])
print(f"Gram built.  symmetric: {all(G[i][j]==G[j][i] for i in range(35) for j in range(35))}")

# --- invariance as an exact matrix identity, all 35*35 entries per generator ---
worst = []
for gi, A in enumerate(GENS):
    M = [[sum(A[k][i]*G[k][j] for k in range(35) if A[k][i])
          + sum(G[i][k]*A[k][j] for k in range(35) if A[k][j]) for j in range(35)]
         for i in range(35)]
    nz = sum(1 for i in range(35) for j in range(35) if M[i][j])
    worst.append(nz)
print(f"A^T G + G A = 0 for all {len(GENS)} generators, all 1225 entries each: "
      f"{max(worst) == 0}   (nonzero entries per generator: {set(worst)})")

# --- the factor against the Lambda^2 operator norm ---
def lam2(bb):
    v = {SPAIRS[k]: c for k, c in enumerate(bb) if c}
    R = wm.sym2_to_R(v)
    return [[R[i][j][k][l] for (k, l) in PAIRS] for (i, j) in PAIRS]
L = [lam2(bb) for bb in BASIS]
GL = [[sum(L[i][a][b]*L[j][a][b] for a in range(NP) for b in range(NP))
       for j in range(35)] for i in range(35)]
ratios = {F(G[i][j], GL[i][j]) for i in range(35) for j in range(35) if GL[i][j]}
mismatch = [(i, j) for i in range(35) for j in range(35) if GL[i][j] == 0 and G[i][j] != 0]
print(f"\nrank-4 Gram / Lambda^2 Frobenius Gram: {ratios}   (single value: {len(ratios)==1})")
print(f"entries where the Lambda^2 form vanishes but the rank-4 one does not: {len(mismatch)}")

# --- positive definiteness, exact LDL^T, independent of the record's verifier ---
Awk = [row[:] for row in G]; piv = []; ok = True
for k in range(35):
    if Awk[k][k] <= 0: ok = False; break
    piv.append(Awk[k][k])
    for i in range(k+1, 35):
        f = Awk[i][k]/Awk[k][k]
        if f:
            for j in range(k, 35): Awk[i][j] -= f*Awk[k][j]
print(f"\nall 35 leading pivots strictly positive (exact Cholesky): {ok}")
print(f"  pivot set: {sorted(set(piv))}")
