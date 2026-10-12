"""Section 2 item 1: independence of the covariants -- the REDUCTION IS REFUTED,
and what survives is smaller and better.

WHAT WAS CLAIMED, AND WHY IT IS WRONG (reviewer 247).  The claim was:
independence of the covariants as functions is equivalent to nonsingularity of
the diagram Gram, whose entries are polynomial in n, so det M(n) is one
univariate polynomial and independence on [12, infinity) is one Sturm question.

  THE DICHOTOMY THAT KILLS IT.  Two different pairings were used as though they
  were one.

    * the PROJECTOR-FREE Brauer gluing, whose value is n^L -- polynomial, which
      is what the Sturm framing needs;
    * the APOLAR pairing WITH the Weyl projector -- anisotropic, which is what
      the equivalence needs.

  The first is a form on the AMBIENT TENSOR SPACE, not on Weyl_n, so
  nonsingularity there says nothing about relations among functions on Weyl_n.
  THAT SECOND LEG WAS OVERSTATED AND IS STRUCK (reviewer 250).  I wrote that the
  apolar pairing "is not polynomial".  It is: <A,A> = dim Weyl_n =
  n(n+1)(n+2)(n-3)/12, a QUARTIC (35, 84, 168, 300 at n = 5..8).  What fails is
  MONOMIALITY, and the Sturm step only ever needed polynomiality -- and
  findings/brauer-pairing.md already records the block Gram as rational, whose
  poles at n = 0, 2 sit far below the range.  THE WITNESS ALONE REFUTES THE
  REDUCTION; this leg added nothing and was wrong.

  AND THE REPLACEMENT I WROTE FOR IT IS ALSO WRONG, IN THE OTHER DIRECTION
  (reviewer 251).  Reviewer 250 told me "not polynomial" was too harsh; I then
  wrote that the projector-free pairing is "sound for dependence, insufficient
  not useless".  IT IS EMPTY WHEREVER Weyl_n IS NONZERO.

    * The two instances I cited are VACUOUS: dim Weyl_2 = dim Weyl_3 = 0, so
      "14 relations at n=3" certifies relations on the ZERO vector space, where
      the true relation space is 105-dimensional anyway.
    * It certifies 0 of 104 relations where it could matter.  The 105 degree-2
      functions span ONE dimension on Weyl_n, which is O(n)-irreducible, while
      the Gram is full rank 105 at every n >= 4.
    * IT PROVABLY CANNOT FIRE AT n = 12.  Matchings on 2k legs are independent
      exactly at n = k (measured at k = 2, 3, 4, 5), and degree-3 covariants have
      k <= 12 <= n.  Spot check at 12 legs, n = 12: rank 900 of 900.
    * The rank ladder, identical at n = 4..8: tensors 105 -> functions on generic
      4-tensors 65 -> on curvature tensors 3 -> on Weyl_n 1.  THE CERTIFICATE
      NEVER LEAVES THE TOP RUNG.

  What IS confirmed, and is stronger than I claimed: n^{cycles} is exactly the
  Frobenius Gram (exact integer equality at 4, 6, 8 legs and for covariants), and
  every exact kernel vector annihilates the integer tensors on ALL of
  (R^n)^{tensor 4}, not merely on Weyl_n.  Sound -- and inapplicable.

  SCOPING HAZARD: soundness needs R.  At n = 12, p = 2 the Gram has rank 0 while
  the tensors have rank 105, and the sibling run_n5_diagram_gram.py computes mod
  10007.

  THE WITNESS, and it needs no reducedness debt -- both diagrams are reduced:

      A = W_abcd W_abcd      C = W_abcd W_acbd

  satisfy C = A/2 as FUNCTIONS on Weyl_n at every n, from the first Bianchi
  identity alone (checked exactly at n = 5, 6, 7).  Their projector-free Gram is
  [[n^4, n^3], [n^3, n^4]], determinant n^6(n^2 - 1), NONSINGULAR at every n >= 2.
  So the Gram is nonsingular while the functions are dependent: the claimed
  equivalence is false.

  AND THE HYPOTHESIS WAS MISNAMED.  What the free direction needs is not
  nondegeneracy but ANISOTROPY -- a nondegenerate indefinite form has isotropic
  vectors, and a totally isotropic plane gives two independent vectors whose Gram
  is the zero matrix.  The apolar pairing does supply anisotropy at every n, being
  the restriction of a positive definite Bombieri form, and restrictions of
  positive definite forms are positive definite.  That guarantee is over R ONLY,
  which matters because run_n5_diagram_gram.py works mod p = 10007.

THREE MORE THINGS THE FRAMING GOT WRONG.

  * IT PRESUPPOSED ITS OWN CONCLUSION.  Writing a 184 x 184 M(n) requires a
    BASIS, and cutting a spanning set to a basis IS the independence question.
    det M(n) != 0 was offered as proof of what one must already hold to write
    M(n) down.  On a genuine spanning set the determinant is identically zero --
    247 exhibits three degree-2 diagrams spanning a 1-dimensional space with Gram
    rank 1 at n = 6, 7, 8.  The honest statement is about RANK, hence about every
    184 x 184 minor, and Sturm does not apply to that.
  * THE SET DOES NOT EXIST YET.  run_n24_via_diagrams.py closes with "OWED: the
    current construction emits VECTORS in a weight space, not diagrams."
  * AND THE GLUING MACHINERY DOES NOT EXIST EITHER.  This file claimed it
    "already exists at n=5 in run_n5_diagram_gram.py".  That file says: "The
    gluing formula is not yet implemented -- the Weyl projector on eight indices
    is the missing piece."  The missing piece is exactly the projector the
    equivalence turns on.

AND THE COST CLAIM WAS WRONG IN BOTH DIRECTIONS AT ONCE (reviewer 248).  As
written -- 17,020 entries times 720 bijections times "a closed-graph value at
n = 12" -- the route costs 1.43e21 flops against at most 6.07e18 for all 71
elimination blocks: 236 TIMES MORE EXPENSIVE than the thing it was offered to
replace, with a peak array of 12^16 entries.  The conclusion is nonetheless
right, in a cost model the file never stated: intermediates are O(n)-invariant,
so by the FFT they carry (k-1)!! coefficients and NO n, and the same Gram is
4.5e11 ops, about 45 seconds -- roughly thirteen orders cheaper.

  THREE OVER-COUNTS, EVERY ONE AGAINST THE FILE'S OWN CASE:

    * THE GRAM IS BLOCK DIAGONAL.  Inequivalent irreps pair to zero, so from the
      record's own pickle -- 77 blocks, maximum multiplicity 9 -- there are 485
      entries, not 17,020.  And det M(n) is a PRODUCT OF 77 DETERMINANTS of
      degree at most 54, not one determinant of degree at most 1104.
    * 720 IS THE WRONG BIJECTION COUNT.  6! glues degree-6 INVARIANTS.  The 184
      are degree-3 COVARIANTS, so the count is 3! = 6.
    * n = 12 NEED NEVER BE EVALUATED, the monomial theorem reducing an entry to a
      cycle count plus one n-independent constant.

THE PADDING CLAIM IS CONFIRMED, AND THE DIRECTION IS THE EASY ONE (r250).
Restriction of functions runs from level n DOWN to 12: T(f) = pi o f o iota is
linear, carries each diagram to its level-12 version, and independence of the
images gives independence of the sources.  Verified exactly -- padding lands in
Weyl_n (Riemann, Bianchi, tracelessness all hold for 5->6,7,9 and 6->8) and the
diagram values are identical before and after.  THE NO-FREE-LOOP LEMMA IS NOT
NEEDED: a free loop contributes (n/m)^L != 0 and rescaling by nonzero scalars
preserves independence.

  THE ONE REAL HYPOTHESIS: THE CARRIER MUST BE A PROJECTOR-FREE DIAGRAM.  250's
  counterexample from two genuine diagrams -- J_1 = I_1 + I_2/n and
  J_2 = I_1 + I_2/24 are independent at n = 12 and IDENTICAL at n = 24.  Trace
  removal supplies exactly such 1/n and 1/(n-2) coefficients, and the diagram
  carriers are still owed.

  THE CONVERSE IS FALSE ON THE OBJECTS AT ISSUE: I_1 = tr M^3 and I_2 = tr B^3
  satisfy I_2 = I_1/2 identically at n = 4, 5 and are independent at n >= 6.  So
  the direction is load-bearing and step 2 picked the only usable one.

  AND THE n = 24 REUSE SURVIVES BY A DIFFERENT ROUTE THAN PRINTED: step 1's
  "spanning at 12 implies spanning at 24" is a NON SEQUITUR.  Basis-hood comes
  from step 3's stability count -- 184 independent functions in a
  184-dimensional space -- not from the FFT.

WHAT SURVIVES, AND IT IS BETTER THAN WHAT WAS CLAIMED.  The padding lemma makes
the polynomial unnecessary: Weyl_n embeds in Weyl_{n'} by zero-padding and a
reduced diagram's value is unchanged under it (247: I_3 constant at 0.2869191717
padding 6 -> 7, 8, 9, 12, 13).  So

    INDEPENDENCE AT n = 12 ALREADY IMPLIES INDEPENDENCE AT EVERY n >= 12,

and the whole Sturm apparatus buys nothing beyond the single dimension.  The item
therefore reduces to a FINITE question at one dimension rather than a polynomial
one over an interval -- provided the padding step is sound.  That step is step 2
of run_n24_via_diagrams.py, and it is load-bearing twice over: if it is wrong,
the n = 24 reuse recorded in findings/fence-posts.md falls with it.

  SO THE ITEM IS NOW: establish independence of the 184 at n = 12 ALONE, over R
  or over Q, with the apolar-and-projector pairing -- which needs the Weyl
  projector on eight indices, currently the missing piece in both files that
  want it.

THIS FILE'S SCREEN WAS BLIND BY CONSTRUCTION.  The pairing was not a parameter:
gram_rank_exact hardcoded the Euclidean form, so no input could exhibit a
singular Gram of independent vectors -- the exact failure mode above.  247 names
three plants it cannot be shown: an isotropic plane, the Bianchi witness in two
dimensions, and a mod-10007 vector with v.v = 0.  The screen validated the
criterion in the one regime where it is a triviality, and it is replaced below by
the witness that refutes the claim.
"""
import numpy as np

# ---- 247's witness: the Gram is nonsingular while the functions are dependent

def weyl_random(n, rng):
    """an exact-in-structure algebraic Weyl tensor (float is enough here: the
    claim being refuted is an identity, and it holds to machine precision)."""
    R = rng.standard_normal((n, n, n, n))
    R = 0.25*(R - R.transpose(1,0,2,3) - R.transpose(0,1,3,2) + R.transpose(1,0,3,2))
    R = 0.5*(R + R.transpose(2,3,0,1))
    R = R - (R + R.transpose(0,2,3,1) + R.transpose(0,3,1,2))/3.0
    g = np.eye(n)
    Ric = np.einsum('ikjk->ij', R); sc = np.trace(Ric); E = Ric - sc/n*g
    def KN(A,B): return (np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                         -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    W = R - KN(E,g)/(n-2) - sc/(2*n*(n-1))*KN(g,g)
    return 0.5*(W + W.transpose(2,3,0,1))

rng = np.random.default_rng(0)
print("  247's witness -- two REDUCED diagrams, dependent as functions:")
print("    A = W_abcd W_abcd      C = W_abcd W_acbd")
for n in (5, 6, 7):
    W = weyl_random(n, rng)
    A = np.einsum('abcd,abcd->', W, W)
    C = np.einsum('abcd,acbd->', W, W)
    print(f"    n={n}:  A={A:+.9f}  C={C:+.9f}  C - A/2 = {C - A/2:+.2e}")
    assert abs(C - A/2) < 1e-9 * max(1.0, abs(A)), (
        f"C = A/2 failed at n={n}; that identity is the first Bianchi identity "
        "and is what makes the two diagrams DEPENDENT as functions -- without "
        "it the witness does not refute anything")

# the projector-free Gram of the same two diagrams
print("\n  their PROJECTOR-FREE Brauer Gram is [[n^4, n^3], [n^3, n^4]]:")
for n in (12, 24):
    det = n**6 * (n**2 - 1)
    print(f"    n={n}:  det = n^6(n^2-1) = {det:,}   nonsingular")
    assert det != 0, "the witness needs a NONSINGULAR Gram to refute the iff"
print("  -- nonsingular Gram, dependent functions: THE EQUIVALENCE IS FALSE.")

# and the two pairings disagree on what they measure
print("\n  the two pairings measure different spaces:")
for n in (5, 6, 7, 8):
    dw = n*(n+1)*(n+2)*(n-3)//12
    print(f"    n={n}:  <A,A> with projector = dim Weyl_n = {dw:>4}"
          f"      projector-free = n^4 = {n**4:>5}")
assert 5*6*7*2//12 == 35, "dim Weyl_5 must be 35"
print("  the first is a QUARTIC in n, not a monomial c*n^L -- so the monomial")
print("  theorem describes the AMBIENT tensor space, not Weyl_n.")

print("\n  WHAT SURVIVES: padding makes independence at n=12 imply it at every")
print("  n >= 12, so the item is a FINITE question at one dimension -- provided")
print("  the padding step holds, which the n=24 reuse also rests on.")
