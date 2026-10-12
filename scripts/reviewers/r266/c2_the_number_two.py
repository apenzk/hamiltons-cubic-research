"""CLAIM 2 -- is r260's rank 2 the same 2 as dim (Sym^3 Weyl_n)^{O(n)}, and is
"r250's I_1, I_2 with I_2 = I_1/2" the right attribution for it?

THREE SEPARATE QUESTIONS.

(a) What is dim of the degree-3 O(n)-invariants of a Weyl tensor at n = 4,5,6,7,12?
    Measured here as the rank of the two classical cubic contractions, which the
    record calls I_1 = tr M^3 (M = W as an operator on pairs) and
    I_2 = tr B^3 (B = W with the middle legs crossed) -- r250's own objects.

(b) Is r250's relation I_2 = I_1/2 a statement about the cells r260 measured?

(c) The script's assert, rank(R_d) == dim Sym^d(V*), applied to V = Weyl_n.
    What number does it demand, and what is the measured rank?
"""
import numpy as np
from math import comb
from itertools import product

rng = np.random.default_rng(2662)


def rand_weyl(n):
    T = rng.standard_normal((n, n, n, n))
    R = T - T.transpose(1, 0, 2, 3) - T.transpose(0, 1, 3, 2) + T.transpose(1, 0, 3, 2)
    R = R + R.transpose(2, 3, 0, 1)
    B = (R + R.transpose(0, 2, 3, 1) + R.transpose(0, 3, 1, 2)) / 3.0
    R = R - B
    g = np.eye(n)
    Ric = np.einsum('abad->bd', R)
    Sc = np.trace(Ric)
    kn = (np.einsum('ac,bd->abcd', g, Ric) - np.einsum('ad,bc->abcd', g, Ric)
          - np.einsum('bc,ad->abcd', g, Ric) + np.einsum('bd,ac->abcd', g, Ric))
    gg = np.einsum('ac,bd->abcd', g, g) - np.einsum('ad,bc->abcd', g, g)
    return R - kn / (n - 2) + Sc * gg / ((n - 1) * (n - 2))


def weyl_dim(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12


def I1(W, n):
    M = W.reshape(n * n, n * n)
    return float(np.trace(M @ M @ M))


def I2(W, n):
    Bm = W.transpose(0, 2, 1, 3).reshape(n * n, n * n)
    return float(np.trace(Bm @ Bm @ Bm))


print("=" * 78)
print("(a) and (b)  THE TWO CUBIC CONTRACTIONS, rank and ratio, by dimension\n")
print(f"  {'n':>3} {'dim Weyl_n':>11} {'rank(I1,I2)':>12} {'I2/I1 spread over 30 samples':>34}")
for n in (4, 5, 6, 7, 8, 12):
    rows = []
    for _ in range(30):
        W = rand_weyl(n)
        rows.append([I1(W, n), I2(W, n)])
    A = np.array(rows).T                       # 2 x 30
    rk = np.linalg.matrix_rank(A, tol=1e-9 * max(1.0, abs(A).max()))
    ratios = A[1] / A[0]
    print(f"  {n:>3} {weyl_dim(n):>11} {rk:>12}   min {ratios.min():+.9f}  max {ratios.max():+.9f}")
print("""
  READING.
    n = 4, 5 : rank 1, and I2/I1 is pinned at exactly 1/2 -- r250's relation.
               The degree-3 invariant dimension there is ONE.
    n >= 6   : rank 2, and the ratio moves freely -- the two are INDEPENDENT.
               The degree-3 invariant dimension there is TWO.

  So `I_2 = I_1/2` is the n <= 5 regime, where the count is 1.  r260 measured
  n = 6 and n = 7, where the count is 2 BECAUSE the relation has failed.  The
  record's sentence names the relation as the reason for the number it destroys.""")

print("\n" + "=" * 78)
print("(c)  THE SCRIPT'S ASSERT APPLIED TO V = Weyl_n\n")
print("  run_restitution_kernel.py asserts  rank(R_d) == dim Sym^d(V*)  where R_d")
print("  runs over ALL multilinear functionals.  With V = Weyl_n, d = 3:\n")
print(f"  {'n':>3} {'dim V':>7} {'dim (V*)^{x3}':>16} {'dim Sym^3(V*)':>15} "
      f"{'measured rank':>14}")
meas = {6: 2, 7: 2}
for n in (6, 7, 12):
    dv = weyl_dim(n)
    print(f"  {n:>3} {dv:>7} {dv**3:>16,} {comb(dv + 2, 3):>15,} "
          f"{str(meas.get(n, 'see r239/r177/r237: 2')):>14}")
print("""
  The record has only the O(n)-INVARIANT functionals -- 10,395 of the dv^3 -- so
  the script's assert is not the statement in play.  The correct equivariant form,
  which Remark I.2.4 does license, is

      rank(R_d restricted to invariant multilinear forms) = dim (Sym^d V*)^{O(n)}

  and that IS what holds: 2 = 2 at n = 6, 7.  The script tests the non-equivariant
  version on toy V = R^2, R^3, R^4, where the two versions coincide only because
  the group is absent.""")
