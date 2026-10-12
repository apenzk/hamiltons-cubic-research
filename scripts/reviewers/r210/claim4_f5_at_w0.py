"""r210, claim 4: F_5(W_0) = 0 EXACTLY over Q, in the pipeline's own convention.

The chain "F_5 _|_ ANN" rests on <F, A(W_0^6)> proportional to F(W_0) together
with F_5(W_0) = 0.  The second factor is arithmetic and is checked here in exact
rational arithmetic, using run_n5_certificate.py's OWN definition of F_5

    F_5(W) = 3/2 * (W_abcd W_abcd)^3 - 9 * tr(M^3)^2,   M = W reshaped 25 x 25,

evaluated on the rank-4 tensor of W_0 that run_n5_assemble.py itself feeds to the
sampler.  The convention matters: the same W_0 has |W|^2 = 1 and tr(W^3) = 1/sqrt6
in the Lambda^2-operator normalisation of run_n5_order2.py, and the two agree only
because both terms rescale by the same factor.
"""
import importlib.util, os, sys
from fractions import Fraction as F

RUNS = "scripts/runs"
def load(n):
    sp = importlib.util.spec_from_file_location(n[:-3], os.path.join(RUNS, n))
    m = importlib.util.module_from_spec(sp)
    o = sys.stdout; sys.stdout = open(os.devnull, "w")
    sp.loader.exec_module(m); sys.stdout = o
    return m

wm = load("run_n5_weyl_module.py")
ex = load("run_n5_extremiser.py")
S, NP, N = ex.S, wm.NP, wm.N

# --- the Lambda^2-operator invariants, exactly ---
tr2 = sum(S[i][j]*S[j][i] for i in range(NP) for j in range(NP))
tr3 = sum(S[i][j]*S[j][k]*S[k][i] for i in range(NP) for j in range(NP)
          for k in range(NP))
print("=== S = sqrt6 * W_0, as an operator on Lambda^2 R^5 ===")
print(f"  tr(S^2) = {tr2}    so |W_0|^2      = {F(tr2, 6)}")
print(f"  tr(S^3) = {tr3}    so tr(W_0^3)^2  = {F(tr3*tr3, 216)}")
assert tr2 == 6 and tr3 == 6
print(f"  3/2 |W_0|^6 - 9 tr(W_0^3)^2 = "
      f"{F(3,2)*F(tr2,6)**3 - 9*F(tr3*tr3, 216)}   (Lambda^2 normalisation)")

# --- the pipeline's own F_5, on the pipeline's own tensor ---
W0T = wm.sym2_to_R({(a, b): S[a][b] for a in range(NP) for b in range(a, NP)
                    if S[a][b]})
q = sum(W0T[a][b][c][d]*W0T[a][b][c][d]
        for a in range(N) for b in range(N) for c in range(N) for d in range(N))
# tr(M^3) with M_{(ab),(cd)} = W_abcd, exactly as run_n5_certificate.py's
# W.reshape(25,25) then trace(M @ M @ M)
M = [[W0T[a][b][c][d] for c in range(N) for d in range(N)]
     for a in range(N) for b in range(N)]
n = N*N
M2 = [[sum(M[i][k]*M[k][j] for k in range(n)) for j in range(n)] for i in range(n)]
t3 = sum(M2[i][k]*M[k][i] for i in range(n) for k in range(n))
print("\n=== run_n5_certificate.py's F_5, on run_n5_assemble.py's W_0 tensor ===")
print(f"  q  = W_abcd W_abcd = {q}      (= 4 tr(S^2) = {4*tr2})")
print(f"  t3 = tr(M^3)       = {t3}      (= 8 tr(S^3) = {8*tr3})")
f5 = F(3, 2)*F(q)**3 - 9*F(t3)**2
print(f"  F_5(sqrt6 W_0) = 3/2 q^3 - 9 t3^2 = {f5}")
assert q == 4*tr2 and t3 == 8*tr3
assert f5 == 0, "F_5 does NOT vanish at W_0 in the certificate's convention"
print("\n  F_5(W_0) = 0 EXACTLY over Q -- degree 6 homogeneity carries the")
print("  sqrt6, and both conventions agree because 96 t2^3 = 576 t3^2 when")
print(f"  t2 = t3 = {tr2}: {96*tr2**3} = {576*tr3**2}.")

# --- and the pairing is genuinely nonzero, so orthogonality is not vacuous ---
# <F, A(W_0^6)> proportional to F(W_0); the invariant |W|^6 has value 1 at W_0,
# so the functional F |-> F(W_0) is NONZERO on the 14 and A(W_0^6) =/= 0.
print(f"\n  |W_0|^6 = {F(tr2,6)**3} != 0, so evaluation at W_0 is a nonzero")
print("  functional on the 14 -- A(W_0^6) is a nonzero element of ANN, and")
print("  'dim ANN = 1' therefore does force ANN = span{A(W_0^6)}.")
