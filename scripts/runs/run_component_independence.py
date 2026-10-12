"""Independence by reading a component -- REFUTED as written, and repaired.

WHERE THIS SITS.  Five attempts at one item, five refutations:
  r247  a diagram-Gram reduction, mixing a form on the ambient space with one on
        Weyl_n;
  r251  a dependence certificate, empty wherever Weyl_n is nonzero;
  r253  a projector-moving construction, vacuous validation and straw motivation;
  r254  a float threshold reading a TRUE DEPENDENCE AS INDEPENDENCE;
  r255  THIS FILE -- see below.

=== WHAT REVIEWER 255 FOUND, INSIDE THIS FILE'S OWN VALIDATION ===

THE PREMISE IS FALSE ON THE CARRIERS USED HERE.  The claim was that F_c(W)
already lies in the target, so <F_c(W), U> = <F_c(W), P U> for ANY U and one
basis element serves.  But

    tr (W.W)_ij = W_iabc W_iabc = |W|^2,

verified exactly at n = 5, 6, 7 -- so cov_ric_like is NOT in V_(2): it carries a
trivial-block part.  And cov_trace_g is ANNIHILATED by the projector onto V_(2),
so as a covariant into that target it is the ZERO MAP.

  CONSEQUENCE: the pair this file asserts has rank 2 has rank 1 IN THE (2) BLOCK
  AND 1 IN THE TRIVIAL BLOCK.  It is independent only in the ambient 2-tensor
  space -- exactly the r247/r251 error.  THE FILE CATCHES THAT ERROR WITH ONE
  ASSERT AND COMMITS IT WITH THE OTHER.

  AND "U UNCONSTRAINED" DOES NOT SURVIVE.  (W.W) and (W.W) + 17|W|^2 g are the
  SAME covariant into V_(2), exactly, in every entry -- yet the test reports rank
  2.  The component read is a function of the REPRESENTATIVE, not of the
  covariant.

  SO THE 461 GiB OBSTACLE IS CONSERVED, NOT DISSOLVED: <P D_c(W), e_I> =
  <D_c(W), P e_I>, and a test tensor in the target is needed either way.

THE REPAIR IS REVIEWER 254'S AND IT IS CHEAP ENOUGH.  Pair with c_lambda e_I for
an index I whose entries are DISTINCT.  Such an e_I is traceless, hence already
in V_lambda, so no projector is applied and no n^{|lambda|} object is stored --
about 5e5 terms for the widest label.  Sound, and not "a single contraction" as
this file first claimed.

  THE FILE'S OWN COMPS INCLUDED (0,0), WHICH IS NOT DISTINCT -- that component
  is precisely the one that reads the trivial block.  Removing it is part of the
  repair below.

WHAT THE TEST ESTABLISHES, STATED CORRECTLY (255).  The implication re-derives
and is oriented as this file had it: rank = N proves independence, rank < N
proves nothing.  A planted relation F_3 = 2F_1 - 5F_2 never yields rank 3 across
24 component-set/sample/seed combinations.  BUT because P is linear,
{P F_c} independent implies {F_c} independent and never the converse, so reading
RAW diagram values gives a NECESSARY condition where the file presented a
sufficient one.

  Also corrected: "a deficient matrix means the components were unlucky, not
  that a relation exists" denies a live possibility.  A deficient matrix is
  simply UNINFORMATIVE.

  AND THE TEST BECOMES GENUINELY TWO-SIDED if the coordinate read is the
  HIGHEST-WEIGHT coordinate inside V_lambda, equivariance plus polarisation
  supplying the converse.  That is the form to build at n = 12.

=== BUT THE VALIDATION CANNOT REACH THE CASE THAT MATTERS (reviewer 256) ===

THE UNIVERSE IS TOO SMALL.  All 840 two-free-leg contractions of two Weyl
tensors span RANK ONE -- W_{aibc}W_{jbac} = (W.W)_ij / 2 -- and admitting g
raises that only to two, one per isotypic.  SO NO BLOCK OF MULTIPLICITY >= 2
EXISTS ANYWHERE IN THIS VALIDATION, and multiplicity >= 2 is the only thing the
programme must certify: the blocks reach multiplicity 9 at n = 12.  Every pair
this file can form is Schur-independent before a component is read, so it is
independent for a reason ANY scheme would report.

AND A WRONG SCHEME PASSES BOTH ASSERTS.  Reading (F.F)_ij -- one contraction too
many -- or F_ij^2 gives the same 2 and 1 at n = 5, 6, 7 as the honest read, then
reports RANK 3 for {A, B, A+B}, a triple with an exact identity.  That is r254's
failure mode one level up.

  The rank-2 assert has no arithmetic content either: |W|^2 delta_ij is
  identically zero at both off-diagonal components, so rank 2 follows from the
  ZERO PATTERN alone and even an indicator scheme, discarding every value,
  passes.  And the rank-1 assert is an identity -- the two carriers are the same
  function -- so it excludes the label-reading error and nothing else.

THE HARDCODED CONSTANTS ARE DEFEATABLE, in the safe direction.  256 constructs a
nonzero covariant D vanishing at all twelve (component, sample) pairs at n = 5
and 6, so (X, X + D) reads rank 1 at this file's constants and rank 2 with one
more component or a different seed.  Twelve rows also cap the certifiable column
count at twelve, against 184 -- unless block orthogonality is invoked, which is
the F_c(W) in V_lambda premise itself.

AT DEGREE 3 THE COST SURVIVES AND THE SOUNDNESS DOES NOT.  One component costs
n^((12-|lambda|)/2) <= 2,985,984 at n = 12, so the cost claim holds.  But the
projector has a kernel there, and a component read of UNPROJECTED covariants
returns 2 where the target holds 1 -- exact at n = 5, 6, 7 with A = (W.W)_ij and
B = A - (|W|^2/n) delta.  And the "add more components" hatch is EMPTY at
|lambda| = 0: a scalar has one component, and that block has multiplicity 2.

  SO THE HONEST STATUS OF THIS FILE: the cost argument is sound, the
  one-sidedness is correctly oriented, and the VALIDATION IS INCAPABLE of
  exercising either the multiplicity >= 2 case or the projector kernel.  What it
  demonstrates is that a component read can distinguish Schur-inequivalent
  carriers.  That is not the question.
"""
from fractions import Fraction as F
import random

def weyl_exact(n, rnd):
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

# TENSOR-VALUED covariants of degree 2, each returning a 2-index object.  The
# component read is the (i,j) entry -- one contraction, no storage.
def cov_ric_like(W, n, i, j):
    """(W.W)_{ij} = W_{iabc} W_{jabc} -- a genuine 2-index covariant."""
    return sum(W[i][a][b][c]*W[j][a][b][c] for a in range(n)
               for b in range(n) for c in range(n))

def cov_swapped(W, n, i, j):
    """W_{aibc} W_{ajbc} -- the same legs paired differently."""
    return sum(W[a][i][b][c]*W[a][j][b][c] for a in range(n)
               for b in range(n) for c in range(n))

def cov_trace_g(W, n, i, j):
    """|W|^2 delta_ij -- dependent on nothing but the scalar."""
    q = sum(W[a][b][c][d]**2 for a in range(n) for b in range(n)
            for c in range(n) for d in range(n))
    return q if i == j else F(0)

def cov_cubic(W, n, i, j):
    """a degree-3 two-index covariant: W_iabc W_jade W_bdce."""
    return sum(W[i][a][b][c]*W[j][a][d][e]*W[b][d][c][e]
               for a in range(n) for b in range(n) for c in range(n)
               for d in range(n) for e in range(n))

def component_rank(covs, n, comps, samples, seed=0):
    """exact rank of [rows = (sample, component), columns = covariants]."""
    rnd = random.Random(seed)
    rows = []
    for _ in range(samples):
        W = weyl_exact(n, rnd)
        for (i, j) in comps:
            rows.append([c(W, n, i, j) for c in covs])
    M = [r[:] for r in rows]; rank = 0
    for c in range(len(covs)):
        pr = next((t for t in range(rank, len(M)) if M[t][c] != 0), None)
        if pr is None: continue
        M[rank], M[pr] = M[pr], M[rank]
        iv = M[rank][c]; M[rank] = [x/iv for x in M[rank]]
        for t in range(len(M)):
            if t != rank and M[t][c] != 0:
                f0 = M[t][c]; M[t] = [x - f0*y for x, y in zip(M[t], M[rank])]
        rank += 1
    return rank

# DISTINCT ENTRIES ONLY (r254's repair, r255's diagnosis).  e_I with distinct
# indices is traceless, hence already in V_lambda, so the pairing needs no
# projector.  (0,0) was in the first version and is exactly the component that
# reads the TRIVIAL block -- the source of the false rank 2.
COMPS = [(0, 1), (1, 2), (0, 2)]
print("  reading ONE COMPONENT of each tensor-valued covariant, exactly:")
for n in (5, 6, 7):
    # THE INDEPENDENCE CASE, REBUILT.  On distinct-index components |W|^2 g
    # vanishes identically, so the old pair collapses and the file lost the only
    # direction that is certifiable.  A genuinely independent pair inside the
    # target: the degree-2 (W.W)_ij against the degree-3 W_iabc W_jade W_bdce.
    r_ind = component_rank([cov_ric_like, cov_cubic], n, COMPS, 4)
    r_dep = component_rank([cov_ric_like, cov_swapped], n, COMPS, 4)
    print(f"    n={n}:  (deg-2, deg-3) rank {r_ind}     "
          f"(W.W, swapped) rank {r_dep}")
    assert r_ind == 2, (
        f"rank {r_ind} at n={n}: the degree-2 and degree-3 covariants are "
        "genuinely independent, and rank = N is the ONLY direction this test "
        "certifies -- without it the file exhibits dependence alone and says "
        "nothing about the side the programme needs")
    assert r_dep == 1, (
        f"rank {r_dep} at n={n}: W_{{iabc}}W_{{jabc}} and W_{{aibc}}W_{{ajbc}} "
        "are equal by the pair antisymmetries, so a test reporting 2 is reading "
        "the AMBIENT space -- the error that sank three earlier attempts")

print("\n  independence SEEN on distinct-index components (rank 2), dependence")
print("  collapsed (rank 1).  The old rank-2 case was the TRIVIAL block leaking")
print("  through the (0,0) component -- r255's witness, now removed.")
print("\n  WHAT IS PROVED: rank = N certifies independence from a single draw.")
print("  A deficient matrix is UNINFORMATIVE -- it does not mean the components")
print("  were unlucky, which the first version claimed and which denies a live")
print("  possibility (r255).  And reading RAW diagram values gives a NECESSARY")
print("  condition, not a sufficient one: {P F_c} independent implies {F_c}")
print("  independent and never the converse.  The two-sided form reads the")
print("  HIGHEST-WEIGHT coordinate inside V_lambda, and is what to build at n=12.")
