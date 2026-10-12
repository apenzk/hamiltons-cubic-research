"""r247 claim 1: the reduction's <= direction, refuted by an explicit witness.

THE CLAIMED IFF (2cdff7b, run_n12_diagram_independence.py):

    the covariants are independent as functions at n
      <=>  the Gram  M_n[c][b] = <J_c, J_b>_n  is nonsingular,

justified by "a linear relation among the functions is exactly a null vector of
the Gram".

WHAT THAT STEP ACTUALLY NEEDS.  For a symmetric bilinear form B on a real space
V and vectors v_1..v_k, the Gram G_ij = B(v_i,v_j):

  (a) v dependent  ==>  G singular.        ALWAYS true, no hypothesis.
  (b) G singular   ==>  v dependent.       NEEDS  B  ANISOTROPIC (definite) on
                                           span(v).  NONDEGENERACY OF B IS NOT
                                           ENOUGH -- see c4_screen_planted.py.

Both directions are FREE OF HYPOTHESIS -- *provided* B is a bilinear form on
the space where the v_i live.  (a) gives "G nonsingular ==> independent", which
is what the reduction consumes; (b) needs anisotropy and gives the converse.
The reduction's real exposure is upstream of both: IS THE PAIRING A FORM ON THE
SPACE THE COVARIANTS LIVE IN?  The projector-free Brauer gluing, whose value is
n^L, is a form on the AMBIENT tensor space (R^n)^(x 4k), and the map from there
to functions on Weyl_n has a kernel.  Over that kernel even (a) fails.

THE WITNESS.  Two reduced degree-2 contraction diagrams on rank-4 tensors:

    A(R) = R_abcd R_abcd            C(R) = R_abcd R_acbd

Neither carries a bare metric, so both are REDUCED in reviewer 241's sense and
the reducedness debt does not touch this.  Then:

  * as functions on Weyl_n they are DEPENDENT at every n:  C = A/2, a
    consequence of the first Bianchi identity alone;
  * their projector-free diagram Gram is [[n^4, n^3],[n^3, n^4]], determinant
    n^6(n^2-1), NONSINGULAR at every n >= 2 and in particular at every n >= 12.

So "nonsingular diagram Gram" and "independent as functions" come apart, at
every n in the range, on reduced diagrams.  The gap is not the metric cycles of
r241; it is the FIRST BIANCHI IDENTITY, which the pairing graph never sees.
"""
from fractions import Fraction as F
import itertools, random

def kulkarni(A, B, n):
    T = [[[[F(0)]*n for _ in range(n)] for _ in range(n)] for _ in range(n)]
    for a in range(n):
        for b in range(n):
            for c in range(n):
                for d in range(n):
                    T[a][b][c][d] = (A[a][c]*B[b][d] + A[b][d]*B[a][c]
                                     - A[a][d]*B[b][c] - A[b][c]*B[a][d])
    return T

def rand_sym(n, rng):
    M = [[F(0)]*n for _ in range(n)]
    for i in range(n):
        for j in range(i, n):
            v = F(rng.randint(-4, 4))
            M[i][j] = v; M[j][i] = v
    return M

def weyl_from_act(R, n):
    """Trace-free part of an algebraic curvature tensor: the Weyl projection."""
    g = [[F(1) if i == j else F(0) for j in range(n)] for i in range(n)]
    Ric = [[sum(R[a][c][b][c] for c in range(n)) for b in range(n)] for a in range(n)]
    scal = sum(Ric[a][a] for a in range(n))
    P = [[ (Ric[a][b] - F(scal, 2*(n-1)) * g[a][b]) / F(n-2) for b in range(n)] for a in range(n)]
    PoG = kulkarni(P, g, n)
    W = [[[[R[a][b][c][d] - PoG[a][b][c][d] for d in range(n)] for c in range(n)]
          for b in range(n)] for a in range(n)]
    return W

def A_val(W, n):
    return sum(W[a][b][c][d]*W[a][b][c][d]
               for a in range(n) for b in range(n) for c in range(n) for d in range(n))

def C_val(W, n):
    return sum(W[a][b][c][d]*W[a][c][b][d]
               for a in range(n) for b in range(n) for c in range(n) for d in range(n))

def traces(W, n):
    return max(abs(sum(W[a][c][b][c] for c in range(n)))
               for a in range(n) for b in range(n))

def bianchi(W, n):
    return max(abs(W[a][b][c][d] + W[a][c][d][b] + W[a][d][b][c])
               for a in range(n) for b in range(n) for c in range(n) for d in range(n))

print(__doc__)
print("=" * 72)
print("STEP 1.  C = A/2 on Weyl_n, exactly, at several n.")
rng = random.Random(247)
for n in (5, 6, 7):
    for trial in range(3):
        h1, h2 = rand_sym(n, rng), rand_sym(n, rng)
        R = kulkarni(h1, h2, n)
        # symmetrise the Kulkarni-Nomizu product's pair symmetry is automatic;
        # first Bianchi holds for any A o B with A, B symmetric.
        W = weyl_from_act(R, n)
        a, c = A_val(W, n), C_val(W, n)
        ok_tr, ok_b = traces(W, n), bianchi(W, n)
        assert ok_tr == 0, f"the constructed W is not trace-free at n={n}: {ok_tr}"
        assert ok_b == 0, f"the constructed W fails first Bianchi at n={n}: {ok_b}"
        assert a != 0, "degenerate sample: |W|^2 = 0, the test is vacuous"
        assert 2*c == a, f"n={n}: 2*C = {2*c} but A = {a} -- the identity FAILED"
    print(f"  n={n}: 3 random Weyl tensors, trace-free and Bianchi verified,"
          f"  and  2*C(W) == A(W)  exactly in every one.")

print()
print("STEP 2.  the projector-free diagram Gram of {A, C}.")
print("  A's coefficient tensor  Q_A[a b c d | e f g h] = d_ae d_bf d_cg d_dh")
print("  C's coefficient tensor  Q_C[a b c d | e f g h] = d_ae d_bg d_cf d_dh")
print("  (both already symmetric under swapping the two tensor slots)")

def frob(m1, m2, n):
    """<Q_1, Q_2> for two matchings given as index-permutation dicts."""
    tot = F(0)
    for idx in itertools.product(range(n), repeat=4):
        for jdx in itertools.product(range(n), repeat=4):
            v1 = 1
            for (p, q) in m1:
                v1 *= 1 if (idx + jdx)[p] == (idx + jdx)[q] else 0
            if not v1:
                continue
            v2 = 1
            for (p, q) in m2:
                v2 *= 1 if (idx + jdx)[p] == (idx + jdx)[q] else 0
            tot += v1 * v2
    return tot

MA = [(0,4),(1,5),(2,6),(3,7)]
MC = [(0,4),(1,6),(2,5),(3,7)]
for n in (2, 3, 4, 5):
    gaa = frob(MA, MA, n); gac = frob(MA, MC, n); gcc = frob(MC, MC, n)
    det = gaa*gcc - gac*gac
    pred = (F(n)**4, F(n)**3, F(n)**4, F(n)**6*(F(n)**2 - 1))
    assert (gaa, gac, gcc, det) == pred, (
        f"n={n}: measured Gram {(gaa,gac,gcc)} det {det}, predicted {pred}")
    print(f"  n={n}: Gram = [[{gaa}, {gac}], [{gac}, {gcc}]],  det = {det}"
          f"  (= n^6(n^2-1))")

print()
print("  det = n^6 (n^2 - 1) != 0 for every n >= 2, hence for every n >= 12.")
print()
print("VERDICT.  Two REDUCED diagrams, projector-free Gram NONSINGULAR at every")
print("n >= 12, yet C - A/2 = 0 as functions on Weyl_n at every n.  The claimed")
print("equivalence fails in the direction 'nonsingular Gram => independent as")
print("functions'.  The relation is the first Bianchi identity, which lives in")
print("ker(projection onto Weyl) and is invisible to the pairing graph.")


print()
print("=" * 72)
print("STEP 3.  the SAME pair under the pairing that DOES descend to Weyl_n --")
print("         apolarity with the Weyl projector inserted, which is the gluing")
print("         run_n5_diagram_gram.py actually describes.")
print()
print("  Under that pairing the entries are traces against the Weyl projector P:")
print("     <A,A> = tr(P),          <A,C> = tr(P.s),   s = the (b c) transposition")
print("  so <A,A> is dim Weyl_n = n(n+1)(n+2)(n-3)/12 -- a QUARTIC POLYNOMIAL,")
print("  NOT a monomial c*n^L.  The projector-free value was n^4 = dim of the")
print("  AMBIENT (R^n)^(x4).  The monomial theorem is measuring the ambient.")
print()

import numpy as np

def weyl_basis(n):
    """orthonormal basis of Weyl_n inside (R^n)^{x4}, by projecting random ACTs."""
    d = n * (n + 1) * (n + 2) * (n - 3) // 12
    rng = np.random.default_rng(247)
    g = np.eye(n)
    cols = []
    while len(cols) < d:
        h1 = rng.standard_normal((n, n)); h1 = h1 + h1.T
        h2 = rng.standard_normal((n, n)); h2 = h2 + h2.T
        R = (np.einsum('ac,bd->abcd', h1, h2) + np.einsum('bd,ac->abcd', h1, h2)
             - np.einsum('ad,bc->abcd', h1, h2) - np.einsum('bc,ad->abcd', h1, h2))
        Ric = np.einsum('acbc->ab', R); scal = np.trace(Ric)
        P = (Ric - scal / (2 * (n - 1)) * g) / (n - 2)
        PoG = (np.einsum('ac,bd->abcd', P, g) + np.einsum('bd,ac->abcd', P, g)
               - np.einsum('ad,bc->abcd', P, g) - np.einsum('bc,ad->abcd', P, g))
        v = (R - PoG).reshape(-1)
        for u in cols:
            v = v - (u @ v) * u
        nv = np.linalg.norm(v)
        if nv > 1e-8:
            cols.append(v / nv)
    return np.array(cols), d

for n in (5, 6, 7, 8):
    B, d = weyl_basis(n)
    trP = float(B.shape[0])
    sw = B.reshape((-1,) + (n,) * 4).transpose(0, 1, 3, 2, 4).reshape(B.shape[0], -1)
    trPs = float(np.einsum('ij,ij->', B, sw))
    dimW = n * (n + 1) * (n + 2) * (n - 3) // 12
    assert d == dimW
    assert abs(trPs - trP / 2) < 1e-8, (
        f"n={n}: tr(P.s) = {trPs}, expected dim/2 = {trP/2}")
    print(f"  n={n}:  <A,A> = tr(P) = {trP:.0f} = dim Weyl_n,"
          f"   <A,C> = tr(P.s) = {trPs:.6f} = dim/2,"
          f"   det = {trP*trP/4 - trPs*trPs:.2e}")

print()
print("  dim Weyl_n at n = 5,6,7,8 is 35, 84, 168, 300 -- ratios 2.40, 2.00,")
print("  1.79, which no monomial c*n^L can produce.  And the 2x2 projected Gram")
print("  is SINGULAR, exactly as the dependence of the functions requires.")
print()
print("THE DICHOTOMY.  Only one pairing can be meant, and neither serves:")
print("   projector-free gluing:  entries are monomials n^L (claim 2 survives)")
print("                           but nonsingularity does NOT give independence")
print("                           of the covariants (claim 1 refuted above).")
print("   apolar-with-projector:  nonsingular <=> independent, correctly (claim 1")
print("                           survives) but the entries are not monomials --")
print("                           findings/brauer-pairing.md's own 'two things")
print("                           owed' says the block Gram is RATIONAL, with")
print("                           1/n and 1/(n-2) from trace removal.")
