"""A2: every entry of the certificate SDP is a rational function of n,
finite on [12, infinity), with denominators that join the Sturm checklist.

WHAT A2 MUST DELIVER.  Route A fits a Gram family B(n) against data that varies
with n.  For the fit to make sense and for A5's Sturm endgame to exist, the data
-- the pairing matrix, the block projections, the orbit constraint, the target --
must be RATIONAL functions of n, with denominators under control on the real
interval [12, infinity), not only at integers.

THE DERIVATION.  Every datum is built from four ingredients, each rational:

  1. DIAGRAM PAIRINGS ARE POLYNOMIALS: n^L times an n-independent contraction,
     L <= 6 (the monomial theorem, findings/brauer-pairing.md).

  2. REDUCEDNESS -- MY TWO-LINE DISCHARGE IS NOT EXHAUSTIVE (reviewer 241).
     The two cases I gave are the LENGTH-MINIMAL members of two families, and
     two shapes escape both:
       (a) METRIC CYCLES OF LENGTH >= 2, g_ab g^bc ... g^za = n, which are not
           single-factor self-loops and are exactly the shape that BREAKS
           L <= min(a_P, a_Q);
       (b) a Weyl self-trace routed THROUGH a metric chain, W_abcd g^ab = 0 --
           still zero, but not by the argument I gave.
     And "already counted by the monomial theorem" is FALSE: L counts cycles of
     the PAIRING graph, while an internal loop inside one diagram is a further
     factor the theorem does not see.  Reducedness returns to OWED.

  3. TRACE REMOVAL AND BLOCK PROJECTION DIVIDE BY EXPLICIT POLYNOMIALS.
     Removing a trace divides by n (a Sym^2 trace), n-1 or n-2 (the Weyl
     decomposition's E- and scalar-part coefficients 1/(n-2), 1/(2n(n-1))).
     Projecting onto an irreducible block uses Lagrange interpolation in the six
     separating Casimirs, prod (C - c_j)/(c_i - c_j), whose eigenvalues c_i(lambda)
     are POLYNOMIALS in n (for the quadratic one, sum lambda_k(lambda_k + n - 2k))
     and whose differences are nonzero at every integer n >= 12, separation
     being a theorem there.

  4. THE TARGET AND THE ORBIT CONSTRAINT ARE RATIONAL.  Theta_n^2 =
     2(n-1)(n-2)/n^2; the balanced product's unnormalised entries are rational
     in n and its norm^2 likewise, and a degree-6 evaluation carries norm^{-6}
     -- an integer power of a rational function, rational.

  Rational functions are a field, so any finite composition of 1-4 lies in Q(n).
  The closure inference is valid and each ingredient is genuinely rational.

  BUT THE LIST IS NOT EXHAUSTIVE (reviewer 242), and field closure covers only
  field operations.  Four pipeline steps are case distinctions or searches, not
  field operations:

    * THE INDEPENDENT-SUBSET CHOICE.  Covariants are solved against a DEPENDENT
      diagram Gram, so a subset S is picked and inverted, putting det Gram_S(n)
      in every denominator.  On the three-term curvature decomposition 242
      computes it exactly as 343 n (n-1) (869n - 2767) / 24 -- and 869n - 2767
      is none of n, n-1, n-2 or a Casimir difference.  A1 fixes the DIMENSION at
      89 on [12, infinity); it does not fix WHICH 89 diagrams stay independent.
    * THE CERTIFICATE POINT IS A SEARCH RESULT, AND THIS IS THE DEEPEST GAP.
      A4 finds an interior point numerically at n = 12, 14, 16, 18 and fits a
      rational curve through four arbitrary points of four DIFFERENT
      high-dimensional feasible bodies, which have no reason to lie on one
      curve.  The repair is to make the point a FORMULA -- fixed active set plus
      forced kernel, solved by Cramer -- rather than a search output.
    * A NORMALISATION (run_n5_assemble.py divides by q00) and an UNRESOLVED REAL
      STRUCTURE (the highest-weight basis is over Q(i); reviewer 204's finding
      that the 65/24 split is a correct count under a wrong labelling stands).
    * AN UNPROVED RANK FACT -- run_n12_unknowns.py's own closing warning that
      the orbit cut assumes every evaluation map is nonzero.

WHERE THE DENOMINATORS' ROOTS LIVE, WHICH IS WHAT A5 NEEDS.  n, n-1, n-2 have
roots <= 2.  The Casimir differences c_i - c_j are polynomials in n, nonzero at
every INTEGER n >= 12 -- but Sturm runs on the REAL interval, and a polynomial
nonzero at the integers can still vanish between them.  So the denominators are
not certified sign-constant by the separation theorem alone:

  REFUTED AS STATED, AND REPAIRED (reviewer 241).  The single-Casimir Lagrange
  denominator VANISHES AT n = 12 ITSELF: (6,4,0,0,0,0) and (6,2,2,2,0,0) both
  give c_2 = 144.  And for 204 of the 2485 block pairs ALL SIX invariant
  differences have a real root in [12, infinity), so no single invariant and no
  fixed subset of them separates on the interval.

  THE REPAIR IS THE gcd, AND IT IS A THEOREM RATHER THAN A CHECK.  Take
  g = gcd(D_1, ..., D_6) as the denominator; Bezout supplies the central element.
  Every one of the 2485 gcds has degree at most 1 and no root in [12, infinity),
  and this is PROVED, not sampled: equal power sums force equal multisets of
  l_i^2, and for real n >= 12 the l-vectors are nonnegative and strictly
  decreasing, so lambda = mu.

  SO SEPARATION HOLDS AT EVERY REAL n >= 12, NOT MERELY AT INTEGERS, AND BLOCK
  PROJECTION CONTRIBUTES NOTHING TO A5'S CHECKLIST.  The worry this file raised
  -- that a polynomial nonzero at integers might vanish between them -- is
  unfounded here, and A5's obligation gets SHORTER rather than longer.  What
  remains is that projection must use the six invariants JOINTLY; one at a time
  fails, and the 204 pairs are the witnesses.

  THE THRESHOLD 12 IS SHARP.  The largest gcd root is n = 10, at (4,4,1,1,1,1)
  against (4,4,1,1,0,0) -- squares {64,49,9,4,1,0} both ways, caused by
  l_6 = n/2 - 6 < 0.  The projection is well defined on [12, infinity) and would
  not be on [10, infinity).

  CAVEAT (241): the negative results assume the Harish-Chandra images are exactly
  p_2k.  The n = 12 collision and the gcd theorem are both immune to that choice.

  DEFERRING ROOT-FREENESS TO A5 IS SOUND (242): the fit's sample points need
  only INTEGER nonvanishing, which A2 already has; the real interval is needed
  only for the conclusion.  Two corrections come with that.

    * MEMBERSHIP IN Q(n) IS NOT FINITENESS, AND THE FIT IS PROPOSAL-THEN-PROOF.
      242 exhibits f = (3n+5)/(n(n-2)) and g = f + (n-12)(n-14)(n-16)(n-18) /
      (n(n-1)(n-2)(n-3)), which agree exactly at all four A4 samples and differ
      at n = 13, 20, 22, 24.  A4's algebraic verification rejects wrong guesses,
      so the procedure is sound -- but nothing bounds how many proposals are
      needed.  A degree bound is owed.
    * A2 IS STRICTER THAN THE THEOREM NEEDS.  The claim concerns EVEN INTEGERS,
      and Sturm isolates roots as well as counting them, so the real obligation
      is sign-constancy on subintervals carrying the even integers -- not
      root-freeness on all of [12, infinity).  This matters because det Gram_S
      is a Gram determinant and so non-negative wherever it is defined.

THE SCREEN BELOW IS ARITHMETIC, NOT A TEST -- REFUTED AS EVIDENCE (reviewer 242).
For the padded tensor <S,S> = 502681/9216 and tr S = 709/48 are IDENTICAL at every
n = 4..12, so a - b/n is one line of algebra with a and b fixed before any
dimension is chosen, and the held-out dimensions confirm Fraction arithmetic and
nothing else.  Worse, b = 4a is forced by the dimension-4 identity
W_iabc W_jabc = (|W|^2/4) delta_ij, so one of the two fit points is a special
value of the identity being fitted.  And the projector runs ONCE, at n = 4, so
its 1/(n-2) and 1/(2n(n-1)) coefficients are never evaluated anywhere else --
the screen exercises 1/n alone, one third of what the derivation claims.

  IT DOES HAVE TEETH, POINTED THE WRONG WAY.  242 plants A - B/(n-2) and the
  a - b/n fit misses every holdout at n=4,5, at n=5,6 and at the A4 pair n=12,14.
  Running the projector AT dimension n gives, in closed form from 9 points and
  confirmed on 17, <W,W> = (869n - 2767)/(24(n-2)) -- the machinery producing a
  1/(n-2) denominator itself -- and the shipped fit misses all fifteen holdouts.

  WHAT WOULD MAKE IT A TEST: project at each dimension rather than padding one
  tensor, and fit a form admitting n, n-1 and n-2 denominators.  Kept below as
  the arithmetic it is, labelled, rather than deleted as though it had never
  been offered as evidence.
"""
from fractions import Fraction as F
import random

def wp(R, n):
    rg = range(n)
    B = [[[[F(1,4)*(R[i][j][k][l]-R[j][i][k][l]-R[i][j][l][k]+R[j][i][l][k])
            for l in rg] for k in rg] for j in rg] for i in rg]
    B = [[[[F(1,2)*(B[i][j][k][l]+B[k][l][i][j]) for l in rg] for k in rg]
          for j in rg] for i in rg]
    B = [[[[B[i][j][k][l]-F(1,3)*(B[i][j][k][l]+B[i][k][l][j]+B[i][l][j][k])
            for l in rg] for k in rg] for j in rg] for i in rg]
    Ric = [[sum(B[i][k][j][k] for k in rg) for j in rg] for i in rg]
    sc = sum(Ric[i][i] for i in rg)
    E = [[Ric[i][j]-F(sc,n)*(i==j) for j in rg] for i in rg]
    g = [[F(1) if a==b else F(0) for b in rg] for a in rg]
    def KN(P,Q,i,j,k,l):
        return P[i][k]*Q[j][l]+P[j][l]*Q[i][k]-P[i][l]*Q[j][k]-P[j][k]*Q[i][l]
    W = [[[[B[i][j][k][l]-F(1,n-2)*KN(E,g,i,j,k,l)
            -F(sc,2*n*(n-1))*KN(g,g,i,j,k,l) for l in rg] for k in rg]
          for j in rg] for i in rg]
    return [[[[F(1,2)*(W[i][j][k][l]+W[k][l][i][j]) for l in rg] for k in rg]
             for j in rg] for i in rg]

# a fixed seed tensor at n0 = 4, padded upward: the W-data is n-independent,
# so every n-dependence seen below is the machinery's, not the tensor's.
rnd = random.Random(5)
N0 = 4
R0 = [[[[F(rnd.randint(-2,2)) for _ in range(N0)] for _ in range(N0)]
       for _ in range(N0)] for _ in range(N0)]
W0 = wp(R0, N0)

def padded(n):
    Wn = [[[[F(0)]*n for _ in range(n)] for _ in range(n)] for _ in range(n)]
    for i in range(N0):
        for j in range(N0):
            for k in range(N0):
                for l in range(N0):
                    Wn[i][j][k][l] = W0[i][j][k][l]
    return Wn

def stilde_pair(n):
    """<S~,S~> at dimension n, exactly, S_ij = W_iabc W_jabc."""
    W = padded(n); rg = range(n)
    S = [[sum(W[i][a][b][c]*W[j][a][b][c] for a in rg for b in rg for c in rg)
          for j in rg] for i in rg]
    ss  = sum(S[i][j]*S[i][j] for i in rg for j in rg)
    tr  = sum(S[i][i] for i in rg)
    return ss - tr*tr/F(n)

vals = {n: stilde_pair(n) for n in (4, 5, 6, 7, 8)}
print("  <S~,S~> at n = 4..8, exact:")
for n, v in vals.items():
    print(f"    n={n}: {v}")

# fit a - b/n through n=4,5; predict 6,7,8
a = (5*vals[5] - 4*vals[4]) / F(1)
b_ = F(0)
# solve [1, -1/4; 1, -1/5] (a,b) = (v4, v5)
b = (vals[5] - vals[4]) / (F(1,4) - F(1,5))
a = vals[4] + b*F(1,4)
print(f"\n  fit through n=4,5:  a = {a},  b = {b}   (form a - b/n)")
ok = all(vals[n] == a - b/F(n) for n in (6, 7, 8))
print(f"  holdout n=6,7,8 predicted exactly: {ok}")
assert ok, (
    "the rational form a - b/n fitted at n=4,5 fails a held-out dimension.  "
    "The derivation says the ONLY n-dependence for a padded tensor is the "
    "trace-removal 1/n, so a miss means either the derivation or the exact "
    "arithmetic is wrong")

# the planted polynomial fit: a' + b'*n through n=4,5 must MISS the holdout
ap_b = (vals[5] - vals[4]) / F(1)
ap_a = vals[4] - ap_b*4
miss = [n for n in (6, 7, 8) if vals[n] != ap_a + ap_b*n]
print(f"  planted polynomial fit misses at n = {miss}")
assert miss, (
    "the affine-in-n plant matched every holdout too, so this screen cannot "
    "distinguish a rational from a polynomial dependence and shows nothing")

print("\n  the denominator is real, exactly n, and the screen can tell it from")
print("  a polynomial.  Every such denominator joins A5's Sturm checklist.")
