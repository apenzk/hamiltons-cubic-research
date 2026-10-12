"""Verify n5_certificate.json from the file alone.  Nothing is imported from the
producer, and nothing numerical is consulted.

This exists because the first version of the acceptance test -- an LDL written
inline -- returned True on an indefinite matrix, and a Sylvester check caught it.
That is the same defect reviewers 181 and 182 found in run_n5_sdp.py's ldl_psd,
reintroduced by the same author who had recorded it.  A false certificate is the
one error in this programme that would not announce itself, so the point is
checked here by a route with no shared code: eigenvalues of the CHARACTERISTIC
POLYNOMIAL, via Sturm sequences over Q, rather than by any elimination.
"""
import json, os, sys
from fractions import Fraction as F

d = os.path.dirname(os.path.abspath(__file__))
C = json.load(open(os.path.join(d, "n5_certificate.json")))
pt = [F(int(a), int(b)) for a, b in C["point"]]
SHAPE = C["shape"]
# THE DENOMINATOR FIELD NAMES THE ROUNDING, NOT THE POINT -- reviewer 213.  It
# is the denominator imposed on the 34 kernel coefficients; 13 of the 47
# coordinates come out with larger denominators, up to 5e16, because the exact
# particular solution and the exact kernel basis carry their own.
_dens = sorted({x.denominator for x in pt})
print(f"certificate: {len(pt)} coordinates, rounding denominator "
      f"{C['denominator']}")
print(f"  actual coordinate denominators: {len(_dens)} distinct, "
      f"largest {max(_dens)}")

# AND THE MATRIX BUILT BELOW IS NOT THE HERMITIAN FORM ITSELF -- reviewer 214.
# herm_row packs the off-diagonals with no factor of two, so the form the
# certificate represents has off-diagonals HALF of what blocks() assembles:
# C = (M + diag M) / 2.  The direction is safe, since M positive definite implies
# C positive definite, and 214 verified both exactly over Q.  Both are checked
# here rather than relying on the implication.
print(f"shape {SHAPE}, sum of squares {sum(k*k for k in SHAPE)}")
assert sum(k*k for k in SHAPE) == len(pt), "the shape does not match the point"

def blocks():
    out, k0 = [], 0
    for k in SHAPE:
        M = [[None]*k for _ in range(k)]
        for i in range(k):
            M[i][i] = (pt[k0], F(0)); k0 += 1
            for j in range(i+1, k):
                re, im = pt[k0], pt[k0+1]; k0 += 2
                M[i][j] = (re, im); M[j][i] = (re, -im)
        out.append(M)
    assert k0 == len(pt)
    return out

def charpoly(M):
    """coefficients of det(xI - M) over Q, by Faddeev-LeVerrier.

    M is Hermitian so the characteristic polynomial has REAL coefficients; the
    imaginary parts are computed and asserted to vanish, which is a check on the
    Hermitian structure rather than an assumption about it.
    """
    k = len(M)
    def mul(A, B):
        return [[tuple(sum(x for x in (
                    A[i][t][0]*B[t][j][0] - A[i][t][1]*B[t][j][1],))
                 for _ in (0,)) + () for j in range(k)] for i in range(k)]
    # explicit complex matrix multiply
    def cm(A, B):
        R = [[(F(0), F(0))]*k for _ in range(k)]
        for i in range(k):
            for j in range(k):
                re = im = F(0)
                for t in range(k):
                    a, b = A[i][t]; c, e = B[t][j]
                    re += a*c - b*e; im += a*e + b*c
                R[i][j] = (re, im)
        return R
    I = [[(F(1), F(0)) if i == j else (F(0), F(0)) for j in range(k)]
         for i in range(k)]
    Mk = [row[:] for row in I]
    cs = [F(1)]
    for m in range(1, k+1):
        Mk = cm(M, Mk)
        tr_re = sum(Mk[i][i][0] for i in range(k))
        tr_im = sum(Mk[i][i][1] for i in range(k))
        assert tr_im == 0, "a trace is not real, so the block is not Hermitian"
        c = -tr_re / m
        cs.append(c)
        for i in range(k): Mk[i][i] = (Mk[i][i][0] + c, Mk[i][i][1])
    return cs                      # x^k + cs[1] x^{k-1} + ... + cs[k]

def sign_changes_at_zero(cs):
    """Descartes on p(-x): a Hermitian matrix is positive definite iff its
    characteristic polynomial has no non-positive real root, and for a real
    polynomial with all-real roots that is exactly alternating signs."""
    k = len(cs) - 1
    alt = [cs[m] * (-1)**m for m in range(k+1)]
    return all(x > 0 for x in alt)

def halve_offdiag(M):
    k = len(M)
    return [[M[i][j] if i == j else (M[i][j][0]/2, M[i][j][1]/2)
             for j in range(k)] for i in range(k)]

print()
allpd = True
for bi, (M, k) in enumerate(zip(blocks(), SHAPE)):
    cs = charpoly(M)
    pd = sign_changes_at_zero(cs)
    allpd &= pd
    if k > 1:
        print(f"  block {bi} ({k}x{k}): charpoly coefficients "
              f"{[f'{float(c):+.6g}' for c in cs]}  -> positive definite {pd}")
print()
print(f"EVERY BLOCK POSITIVE DEFINITE (as packed): {allpd}")

allpd2 = True
for M, k in zip(blocks(), SHAPE):
    allpd2 &= sign_changes_at_zero(charpoly(halve_offdiag(M)))
print(f"EVERY BLOCK POSITIVE DEFINITE (off-diagonals halved, the form the")
print(f"  certificate actually represents): {allpd2}")
assert allpd2, "the halved form is not positive definite"
assert allpd, ("the certificate is NOT positive definite.  It was accepted by a "
               "different test, so one of the two is wrong and neither may be "
               "trusted until that is resolved.")
print()
print("The eigenvalues are the roots of these polynomials; all coefficients")
print("alternate in sign, so every root is strictly positive.  Exact over Q,")
print("with no elimination and no floating point anywhere in this file.")
print()
print("WHY 40 EQUATIONS GIVE AN IDENTITY, which is the step that turns this")
print("point into a certificate:")
print()
print("  The point satisfies the sextic map's equations at 40 SAMPLE POINTS.")
print("  That is agreement of two polynomials at 40 places, not equality --")
print("  unless evaluation at those points is injective on the space both")
print("  polynomials live in.")
print()
print("  THE ARGUMENT THIS FILE FIRST GAVE WAS CIRCULAR, and reviewer 214 said")
print("  so.  It compared rank(ev . mu) with rank(mu) and called both measured;")
print("  only the first is.  Sampling's inequality runs rank(ev . mu) <=")
print("  rank(mu), so equality cannot be inferred from the sampled side alone.")
print()
print("  REVIEWER 213'S ARGUMENT NEEDS NO STATEMENT ABOUT mu AT ALL, and it is")
print("  the one that belongs here.  Every row entry is an O(5)-invariant")
print("  sextic, and so is F_5, so both sides live in (Sym^6 Weyl_5)^O(5),")
print("  which is 14-dimensional -- computed by Weyl integration, by Kostant,")
print("  and by Sage plethysm.  Building 120 explicit invariant sextics as")
print("  complete contractions of six copies of W and evaluating them at the 40")
print("  points gives rank 14 against a cap of 14, with a 14-decade singular")
print("  value gap.  So evaluation at these points is injective on EVERY")
print("  invariant sextic, and agreement there is identity outright.")
print()
print("  Independent of the argument, reviewer 213 ran the pipeline at 80 points")
print("  with the first 40 reproducing the published dump byte for byte, and")
print("  checked row(W).x == F_5(W) at all 80: 0 mismatches, including 0 of the")
print("  40 HELD OUT from the solve.  Reviewer 214 did the same at 12 fresh")
print("  points from an unused seed, 12 of 12.")
print()
print("  Therefore the sextic of this Gram equals F_5 identically, and being")
print("  positive definite it exhibits F_5 as a sum of squares of cubics from K.")
