"""Covariant independence -- the test, its VACUOUS validation, and the direct
route that makes the whole construction unnecessary.

THE ITEM.  Three section-1 items rest on this: A2'' takes it as its hypothesis,
A2 needs it through det Gram_S, and A3 cannot start without it.  What is needed
is that the covariants are linearly independent AS FUNCTIONS at n = 12; padding
then gives every n >= 12 (r247, confirmed r250).

=== WHAT REVIEWER 253 FOUND, AND IT REMOVES THE FILE'S REASON FOR EXISTING ===

THE MOTIVATION WAS A STRAW COMPARISON.  This file avoided the Weyl projector
because its dense 8-index form at n = 12 is 3.20 GB.  But the test never needs P
as a dense operator -- only P APPLIED TO n^4 TENSORS, which costs 0.4 ms at
n = 12 and which this file ALREADY DOES, in weyl_random.  The direct route
computes the same rank in about 12 seconds with NO test tensors and NO epsilon.
252's projector-moving identity is correct and was not needed.

THE VALIDATION WAS VACUOUS.  The three degree-2 carriers are POINTWISE
PROPORTIONAL, ratios (1, 1/2, 1), on any Riemann-symmetric tensor: c3 = c1 by
pair symmetry and c2 = c1/2 by the first Bianchi identity.  Rank 1 therefore
holds with traces intact, and at n = 4 where Weyl_n is NOT O(n)-irreducible.
IRREDUCIBILITY IS NEVER MEASURED -- the thing the docstring claimed to be testing
plays no part.

  AND A DELIBERATELY WRONG SCHEME PASSES BOTH ASSERTS.  Take
  S(D)(W) := ||W||^(2 deg D) -- read off the degree and throw the diagram away.
  It gives rank 1 on the three carriers and rank 2 on the quadratic-versus-
  quartic control.  S would report the 184 degree-3 covariants as spanning ONE
  dimension.  The control fails because it varies the DEGREE, while the n = 12
  question varies the DIAGRAM AT FIXED DEGREE.

  THE FIX, AND IT IS 253'S: control with two SAME-DEGREE independent invariants,
  which give rank 2 under the true scheme and rank 1 under S.  That is what
  distinguishes a scheme that reads diagrams from one that reads only degrees.

TWO MORE CORRECTIONS TO THE STATED ARGUMENT.

  * The projector step is sound for the ORTHOGONAL projector, self-adjoint to
    2e-16 at n = 12 -- but the file gave IDEMPOTENCE as the reason, and that is
    not enough: an equivariant idempotent Q = P + PB(I-P) with the same image,
    acting as the identity on the target, breaks the identity by a relative 0.62.
    The (2,2) block has multiplicity 2, so such Q genuinely exist.
  * APPROXIMATE U FAILS TOWARD THE DESIRED CONCLUSION, which is the dangerous
    direction: contamination only RAISES the measured rank, so a misaligned test
    tensor reports INDEPENDENCE -- exactly what the programme wants to hear.
    Measured threshold eps > 3.1e-10; with F_3 = F_1 exactly, rank 2 with an
    exact U and rank 3 at eps = 1e-6.

AND THE REAL COST IS THE TEST TENSOR, NOT THE COUNT OF THEM (reviewer 254).
The 184 split into 71 blocks, 34 of multiplicity one, with the widest value
matrix only NINE columns -- about 184 evaluations in all.  What costs is that
each U must lie EXACTLY in V_lambda, and 40 of the 71 blocks (60 of the 184)
have |lambda| >= 10, where a dense U is 461 GiB or 64.87 TiB.  This also bounds
r253's repair: "P applied to n^4 tensors at 0.4 ms" is a DEGREE-2 statement,
and at degree 3 the tensors are n^10 and n^12.  The headline 3.20 GiB was
itself the four-index projector, i.e. the degree-2 setting.

THE TEST IS ONE-SIDED, AND THE VALIDATION USES THE UNCERTIFIABLE SIDE (254).
rank = N is a proof from a single draw; rank < N is only ever evidence.  The
n = 12 item asserts an INDEPENDENCE, which is the certifiable side -- but the
validation below asserts rank 1, a DEPENDENCE, which is not.  It is kept because
its dependence is proved separately, by pair symmetry and first Bianchi.

WHAT THIS FILE NOW IS.  The value-matrix test, with 253's same-degree control in
place of the degree-varying one, and the direct-projector route recorded as the
one to use at n = 12.  The scalar carriers below exercise no U, no projector and
no pairing -- so the validated case is precisely the one dimension in which the
projector-moving machinery CANNOT be validated, which is why the machinery is
recorded here rather than relied upon.
"""
import numpy as np

def weyl_exact(n, rnd):
    """a Weyl tensor with exact rational entries."""
    from fractions import Fraction as F
    rg = range(n)
    R = [[[[F(rnd.randint(-3, 3)) for _ in rg] for _ in rg] for _ in rg] for _ in rg]
    B = [[[[F(1,4)*(R[a][b][c][d]-R[b][a][c][d]-R[a][b][d][c]+R[b][a][d][c])
            for d in rg] for c in rg] for b in rg] for a in rg]
    B = [[[[F(1,2)*(B[a][b][c][d]+B[c][d][a][b]) for d in rg] for c in rg]
          for b in rg] for a in rg]
    B = [[[[B[a][b][c][d]-F(1,3)*(B[a][b][c][d]+B[a][c][d][b]+B[a][d][b][c])
            for d in rg] for c in rg] for b in rg] for a in rg]
    Ric = [[sum(B[a][k][b][k] for k in rg) for b in rg] for a in rg]
    sc = sum(Ric[a][a] for a in rg)
    E = [[Ric[a][b] - F(sc, n)*(a == b) for b in rg] for a in rg]
    g = [[F(1) if a == b else F(0) for b in rg] for a in rg]
    def KN(P, Q, a, b, c, d):
        return (P[a][c]*Q[b][d] + P[b][d]*Q[a][c]
                - P[a][d]*Q[b][c] - P[b][c]*Q[a][d])
    W = [[[[B[a][b][c][d] - F(1,n-2)*KN(E,g,a,b,c,d)
            - F(sc,2*n*(n-1))*KN(g,g,a,b,c,d) for d in rg] for c in rg]
          for b in rg] for a in rg]
    return [[[[F(1,2)*(W[a][b][c][d]+W[c][d][a][b]) for d in rg] for c in rg]
             for b in rg] for a in rg]

def _con2(W, n, perm):
    """exact sum W[abcd] * W[perm(abcd)]."""
    from fractions import Fraction as F
    rg = range(n); tot = F(0)
    for a in rg:
        for b in rg:
            for c in rg:
                for d in rg:
                    x = W[a][b][c][d]
                    if x:
                        i2 = (a,b,c,d)
                        p = [i2[k] for k in perm]
                        tot += x * W[p[0]][p[1]][p[2]][p[3]]
    return tot

def weyl_random(n, rng):
    R = rng.standard_normal((n, n, n, n))
    R = 0.25*(R - R.transpose(1,0,2,3) - R.transpose(0,1,3,2) + R.transpose(1,0,3,2))
    R = 0.5*(R + R.transpose(2,3,0,1))
    R = R - (R + R.transpose(0,2,3,1) + R.transpose(0,3,1,2))/3.0
    g = np.eye(n)
    Ric = np.einsum('ikjk->ij', R); sc = np.trace(Ric); E = Ric - sc/n*g
    def KN(A,B): return (np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                         -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    W = R - KN(E,g)/(n-2) - sc/(2*n*(n-1))*KN(g,g)
    W = 0.5*(W + W.transpose(2,3,0,1))
    assert np.abs(np.einsum('ikjk->ij', W)).max() < 1e-9, "not Ricci-flat"
    return W

# three degree-2 carriers, all projector-free, all looking different
CARRIERS = [
    lambda W: _con2(W, len(W), (0,1,2,3)),   # A = W_abcd W_abcd
    lambda W: _con2(W, len(W), (0,2,1,3)),   # C = W_abcd W_acbd
    lambda W: _con2(W, len(W), (2,3,0,1)),   # D = W_abcd W_cdab
]

def independence_rank(carriers, n, samples=None, seed=0):
    """EXACT rational rank of the value matrix.  No threshold anywhere.

    THE FLOAT SVD WITH A 1e-10 CUT FAILED IN THE UNSAFE DIRECTION (r254).  The
    cut buys a coefficient ratio of only 1e-10/eps ~ 1.3e5, and the record's own
    Bianchi relation supplies the witness: h_M = A + M(A - 2C) IS A for every M,
    since A - 2C vanishes identically -- yet it is reported INDEPENDENT from
    M = 1e6, and 12^6 = 3.0e6 clears that on its own.  Reviewer 250's
    J_1 = I_1 + I_2/n is exactly such a scaled combination.  A TRUE DEPENDENCE
    READ AS INDEPENDENCE is the direction that would let the programme certify
    its hypothesis wrongly.

    Rounding was NOT the threat -- 254 refuted that hypothesis by measurement,
    kappa_eff being O(1..10) with a floor near 1e-15.  The threshold was.  An
    exact rational rank at these sizes costs about a millisecond, so there is no
    reason to carry one.

    SAMPLES.  r <= N samples suffice almost surely: rank is at most the column
    count, the witnessing minor is a nonzero polynomial, and its zero set is
    null.  The "+1" of the usual phrasing does no work -- genericity is a
    hypothesis on the LAW, not on the count.  Default now tracks the carriers
    instead of being the constant 12 it was.
    """
    from fractions import Fraction as F
    # EXACT ARITHMETIC ON INEXACT DATA IS WORSE THAN A TOLERANCE.  A first
    # version took float values and called limit_denominator on them: the
    # identities C = A/2 and D = A hold to 1e-16 in float, and turning those
    # residues into rationals made three genuinely different numbers -- exact
    # rank 3 where the truth is 1.  Exactness must go all the way down, so the
    # TENSORS are rational and every contraction is over Fraction.
    if samples is None:
        samples = len(carriers) + 2
    import random as _rand
    rnd = _rand.Random(seed)
    rows = []
    for _ in range(samples):
        W = weyl_exact(n, rnd)
        rows.append([c(W) for c in carriers])
    M = [r[:] for r in rows]
    rank = 0
    for c in range(len(carriers)):
        pr = next((t for t in range(rank, len(M)) if M[t][c] != 0), None)
        if pr is None:
            continue
        M[rank], M[pr] = M[pr], M[rank]
        iv = M[rank][c]
        M[rank] = [x / iv for x in M[rank]]
        for t in range(len(M)):
            if t != rank and M[t][c] != 0:
                f0 = M[t][c]
                M[t] = [x - f0 * y for x, y in zip(M[t], M[rank])]
        rank += 1
    return rank, None

print("  degree-2 carriers on Weyl_n -- the invariant space is ONE-dimensional")
print("  (Weyl_n is O(n)-irreducible), so the rank must be 1 at every n:")
for n in (5, 6, 7, 8, 12):
    # THE MIRROR OF THE RECORDED BUG (r254): the file held seed = 0 fixed where
    # the direction it asserts needs it varied.  Three seeds, all of which must
    # agree.
    rs = {independence_rank(CARRIERS, n, seed=sd)[0] for sd in (0, 1, 2)}
    r = rs.pop() if len(rs) == 1 else -1
    print(f"    n={n:>3}:  rank {r}   (exact, three seeds agree: {not rs})")
    assert r == 1, (
        f"rank {r} at n={n}, not 1.  Weyl_n is O(n)-irreducible so its degree-2 "
        "invariants are one-dimensional; a test reporting more is measuring the "
        "AMBIENT space, which is exactly the error that made the projector-free "
        "Gram empty (r251)")

# THE CONTROL, REPLACED (r253).  The old one paired a quadratic against a
# quartic, so it varied the DEGREE -- while the n=12 question varies the DIAGRAM
# AT FIXED DEGREE.  A scheme that reads only the degree passes it: 253's
# S(D)(W) := ||W||^(2 deg D) gives rank 1 on the three carriers and rank 2 on the
# degree-varying control, so BOTH old asserts passed while S would report the 184
# degree-3 covariants as spanning one dimension.
#
# The replacement uses two SAME-DEGREE independent invariants, which the true
# scheme separates and S cannot.
SAME_DEG = [
    lambda W: np.einsum('abcd,abef,cdef->', W, W, W),
    lambda W: np.einsum('abcd,aecf,bedf->', W, W, W),
]

def wrong_scheme_rank(carriers, degs, n, samples=12, seed=0):
    """253's S: read the degree, discard the diagram."""
    rng = np.random.default_rng(seed)
    rows = []
    for _ in range(samples):
        W = weyl_random(n, rng)
        nrm = np.einsum('abcd,abcd->', W, W)
        rows.append([nrm ** d for d in degs])
    sv = np.linalg.svd(np.array(rows), compute_uv=False)
    return int((sv > sv[0] * 1e-10).sum())

r_true, _ = independence_rank(SAME_DEG, 6)
r_wrong = wrong_scheme_rank(SAME_DEG, [3, 3], 6)
print(f"\n  control, two SAME-DEGREE cubic invariants:")
print(f"    true scheme  rank {r_true}")
print(f"    253's degree-only scheme S  rank {r_wrong}")
assert r_true == 2, (
    f"the two same-degree cubics came out rank {r_true}, not 2; if they are not "
    "independent the control cannot separate a diagram-reading scheme from a "
    "degree-reading one")
assert r_wrong == 1, (
    f"253's degree-only scheme S gave rank {r_wrong}, not 1 -- then it is not "
    "the counterexample it is meant to be and this control does not distinguish "
    "the schemes")
print("  -- the true scheme separates them, S collapses them.  THIS is the")
print("     control the old degree-varying one failed to be.")

# THE HARD-CODED "CONTRAST" GRAM IS DELETED (r253: three of its entries were
# wrong).  It was a matrix of literals no code produced -- the same defect this
# record has hit repeatedly -- and reviewer 251 already established the point it
# was illustrating, that the projector-free Gram measures the AMBIENT space and
# so cannot see a collapse on Weyl_n.  A number its own file cannot reproduce is
# not a number, so it is removed rather than corrected.


print("\n  NOTE: the rank-1 results above are POINTWISE PROPORTIONALITY -- ratios")
print("  (1, 1/2, 1) from pair symmetry and first Bianchi -- and NOT the")
print("  irreducibility of Weyl_n, which this file never measures (r253).")
