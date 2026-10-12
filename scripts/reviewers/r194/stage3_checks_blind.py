"""Claim 4: what run_n5_assemble.py's three self-declared checks actually test.

Setting.  B^lambda_ij(W) = conj(c^i)^T Q c^j, one Hermitian block per
isotypic component lambda of Sym^3(Weyl_5); one equation per sample point,
sum_{lambda,i,j} G_ij B_ij(W) = F_5(W); coefficient matrix rows = samples,
columns = the real unknowns of the Hermitian block-diagonal G.

Result 1 (analytic).  B is Hermitian  <=>  Q is Hermitian, for ANY vectors
c^i whatsoever.  Proof: conj(B_ij) = sum_pq c^i_p conj(Q_pq) conj(c^j_q) and
B_ji = sum_pq conj(c^j_q) Q_qp c^i_p, so the two agree termwise iff
conj(Q_pq) = Q_qp.  The check is therefore one bit about ONE matrix; the
adapted basis, the coordinate solve and W itself do not enter.

Result 2 (analytic).  All THREE checks are exactly invariant under the
Hadamard reparametrisation B_ij -> h_ij B_ij that both stage-2 and stage-3
docstrings identify as the thing that "moves the SDP's feasible set":
  * Hermitian: (h.B)_ji = h_ji B_ji = conj(h_ij) conj(B_ij) = conj((h.B)_ij);
  * trivial block: the trivial multiplicity at n=5 is 1, so h_11 > 0 is a
    scalar and h_11 B_11 is still proportional to tr(W^3)^2;
  * rank: h.B rescales each COLUMN by a nonzero constant, so the rank is
    unchanged exactly -- not merely still <= 14.
So the single disputed error passes all three; no compensating pair is needed.

Everything below exhibits these on explicit matrices.
"""
import itertools, random
from fractions import Fraction as F

random.seed(194)
def rnd(): return complex(random.randint(-5, 5), random.randint(-5, 5))

# ---------------------------------------------------------------- Result 1
print("=" * 74)
print("RESULT 1  B Hermitian <=> Q Hermitian, for arbitrary c")
print("=" * 74)
D, M = 6, 4                      # dim V(lambda) = 6, multiplicity m = 4
def herm(D):
    A = [[rnd() for _ in range(D)] for _ in range(D)]
    return [[A[p][q] + A[q][p].conjugate() for q in range(D)] for p in range(D)]
def build_B(Q, C):
    m = len(C)
    return [[sum(C[i][p].conjugate() * Q[p][q] * C[j][q]
                 for p in range(len(Q)) for q in range(len(Q)))
             for j in range(m)] for i in range(m)]
def herm_defect(B):
    return max(abs(B[i][j] - B[j][i].conjugate())
               for i in range(len(B)) for j in range(len(B)))

Q = herm(D)
for label, C in [("c from a 'correct' solve (any vectors)",
                  [[rnd() for _ in range(D)] for _ in range(M)]),
                 ("c = pure garbage, unrelated to any W",
                  [[rnd() for _ in range(D)] for _ in range(M)]),
                 ("c all equal (degenerate)",
                  [[complex(1, 2)] * D for _ in range(M)]),
                 ("c all zero", [[0j] * D for _ in range(M)])]:
    print(f"  Q Hermitian, {label:<42} |B - B^*| = {herm_defect(build_B(Q, C)):.1e}")
Qbad = [[rnd() for _ in range(D)] for _ in range(D)]      # not Hermitian
C = [[rnd() for _ in range(D)] for _ in range(M)]
print(f"  Q NOT Hermitian, honest c                          "
      f"        |B - B^*| = {herm_defect(build_B(Qbad, C)):.1e}   <- the only failure mode")
print("  => the check is a one-bit test of Q's construction.  Nothing about")
print("     phi_j phi_i^{-1}, the per-weight solve, W^3, or invariance.")

# ---------------------------------------------------------------- Result 2
print()
print("=" * 74)
print("RESULT 2  the Hadamard factor h_ij passes all three checks")
print("=" * 74)
def hadamard(B, h):
    return [[B[i][j] * h[i][j] for j in range(len(B))] for i in range(len(B))]
# h is a Gram of the m copies: Hermitian PSD with positive diagonal
Araw = [[rnd() for _ in range(M)] for _ in range(M)]
h = [[sum(Araw[p][i].conjugate() * Araw[p][j] for p in range(M)) for j in range(M)]
     for i in range(M)]
B = build_B(Q, C)
Bh = hadamard(B, h)
print(f"  check 1  Hermitian:  |B - B^*| = {herm_defect(B):.1e}   "
      f"|h.B - (h.B)^*| = {herm_defect(Bh):.1e}   BOTH PASS")

print()
print("  check 2  trivial block.  n=5 has dim (Sym^3 Weyl_5)^O(5) = 1")
print("           (run_n5_constraint_count.py; the Lovelock collapse"
      " <W#,W> = 2 tr W^3),")
print("           so the trivial block is 1x1 and h_11 = ||copy 1||^2 > 0.")
print(f"           h_11 = {h[0][0].real:.0f} (real, positive: {h[0][0].real > 0})")
print("           B_11 -> h_11 B_11 is still proportional to tr(W^3)^2.  PASSES")

print()
print("  check 3  rank.  the coefficient matrix, 30 sample points x the real")
print("           unknowns of one Hermitian 4x4 block, before and after h.")
import numpy as np
NS = 30
rows, rowsh = [], []
for _ in range(NS):
    Cs = [[rnd() for _ in range(D)] for _ in range(M)]
    Bs = build_B(Q, Cs); Bsh = hadamard(Bs, h)
    def flat(X):
        r = [X[i][i].real for i in range(M)]
        r += [X[i][j].real for i in range(M) for j in range(i+1, M)]
        r += [X[i][j].imag for i in range(M) for j in range(i+1, M)]
        return r
    rows.append(flat(Bs)); rowsh.append(flat(Bsh))
A, Ah = np.array(rows), np.array(rowsh)
print(f"           rank(A) = {np.linalg.matrix_rank(A)}    "
      f"rank(h.A) = {np.linalg.matrix_rank(Ah)}   -- identical, as a column")
print(f"           rescaling must be.  (These c are random, not covariants,")
print(f"           so the rank is the full {A.shape[1]}; the point is the equality.)")

# ------------------------------------------------- falsifiability precondition
print()
print("=" * 74)
print("RESULT 3  when 'rank at most 14' can bind at all")
print("=" * 74)
print("  block table (findings/sym3-blocks.md): multiplicities 4,4,3,")
print("  2x9, 1x12; sum m = 41, sum m^2 = 89, sum m(m+1)/2 = 65.")
mults = [4, 4, 3] + [2]*9 + [1]*12
print(f"  blocks {len(mults)}   sum m = {sum(mults)}   sum m^2 = {sum(m*m for m in mults)}"
      f"   sum m(m+1)/2 = {sum(m*(m+1)//2 for m in mults)}")
print("  Hermitian G has sum m^2 = 89 REAL unknowns, and the real columns")
print("  {B_ii} u {Re B_ij, Im B_ij}_{i<j} also number 89.")
print("  rank <= min(#samples, 89, 14).  So the check is VACUOUS below 15")
print("  sample points and only bites from the 15th onward.")
print()
print("  and 89 unknowns against at most 14 constraints leaves a kernel of")
print("  dimension >= 75 -- the SOS problem is under-determined by that much.")
