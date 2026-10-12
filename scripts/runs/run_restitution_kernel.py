"""RESTITUTION -- what it settles, and what this file first wrongly claimed it did.

WHAT IS TRUE, and is checked below.  Restitution R_d -- evaluation of a multilinear
form on the diagonal -- has rank exactly dim Sym^d(V*), and its kernel is exactly
the non-symmetric complement.  Darondeau-Florence-Kolev (arXiv:2606.24023) Remark
I.2.2, restating Weyl: P_d(R_d(F)) agrees with F IF AND ONLY IF F IS ALREADY
SYMMETRIC, so P_d o R_d is a projection onto the symmetric multilinear forms;
Remark I.2.4 makes all three commute with the group action.

WHAT THIS FILE FIRST CLAIMED, AND WHICH IS REFUTED.  It concluded that r260's
measurement -- restriction along the degree-3 diagonal taking the 10,395 Brauer
functionals to RANK 2 -- was explained by the above, so that the kernel of 10,393
"was never the difficulty".  r265 and r266 refute this independently.

  THE MEASURED MAP IS A COMPOSITE:

      V^{tensor 12}  --restrict domain-->  Weyl_n^{tensor 3}  --R_3-->  functions of W

  and Remark I.2.2 governs only the SECOND arrow.  On three INDEPENDENT Weyl slots
  the invariant multilinear forms already have dimension 2 at n = 6 and n = 7, the
  same 2 as on the diagonal, so the non-symmetric complement is 0-DIMENSIONAL and
  Remark I.2.2 accounts for 0 of the 10,393.

  THE WHOLE COLLAPSE IS THE FIRST ARROW -- the passage from V^{tensor 4} to the
  Weyl subspace, with its antisymmetries, pair symmetry, first Bianchi identity and
  tracelessness.  A WEYL TENSOR IS NOT A GENERIC ELEMENT OF V^{tensor 4}, and no
  polarization statement crosses that gap.

  The error was applying a theorem about Sym^d(V) -- cubes of VECTORS -- to cubes
  of STRUCTURED TENSORS without checking the step.

SO THE DIFFICULTY r260 NAMED SURVIVES UNTOUCHED, and the record's other files,
which were never edited to match the retracted claim, were right as they stood.

WHAT REMAINS CHECKED HERE is the mechanism on Sym^d(V) itself, which is correct
and which nothing above disturbs.
"""
import numpy as np
from itertools import product
from math import comb

def restitution_rank(V, d):
    """rank of {F |-> F(v,...,v)} over ALL multilinear functionals on V^{tensor d}.

    A multilinear functional is a vector of coefficients indexed by (i_1..i_d).
    Its restitution is the degree-d polynomial whose value at v is sum over the
    index tuple of coeff times v_{i_1}..v_{i_d}.  Evaluating at enough points
    turns the whole family into a matrix whose rank is what we want.
    """
    idx = list(product(range(V), repeat=d))
    pts = np.random.default_rng(0).standard_normal((4 * comb(V + d - 1, d) + 20, V))
    M = np.array([[np.prod(p[list(t)]) for t in idx] for p in pts])
    return np.linalg.matrix_rank(M, tol=1e-8), len(idx)

def sym_dim(V, d):
    return comb(V + d - 1, d)

print(f"  {'dim V':>6} {'d':>2} {'multilinear':>12} {'rank of R_d':>12} {'dim Sym^d':>10}"
      f" {'ker R_d':>8} {'complement':>11}")
for V in (2, 3, 4):
    for d in (2, 3, 4):
        r, total = restitution_rank(V, d)
        sd = sym_dim(V, d)
        print(f"  {V:>6} {d:>2} {total:>12} {r:>12} {sd:>10} {total-r:>8} {total-sd:>11}")
        assert r == sd, (
            f"restitution on all multilinear functionals of V^{d}, dim V = {V}, has "
            f"rank {r} but dim Sym^{d}(V*) = {sd}; Theorem I.2.1 says every degree-d "
            "polynomial is the restitution of a symmetric form and Remark I.2.2 says "
            "nothing symmetric is lost, so these two must agree")
        assert total - r == total - sd, "the kernel is not the non-symmetric complement"

print("\n  So rank(R_d) = dim Sym^d(V*) exactly, and ker(R_d) is exactly the")
print("  non-symmetric complement -- the collapse is a projection, not a loss.\n")

print("  THE PROGRAMME'S OWN NUMBERS DO NOT FOLLOW FROM THIS -- and this file")
print("  first claimed they did.  r265 and r266 refute it independently.")
print("    The measured map is a COMPOSITE: restrict V^{tensor 12} -> Weyl^{tensor 3},")
print("    THEN restitute.  Remark I.2.2 governs only the second arrow.")
print("    On THREE INDEPENDENT Weyl slots the invariant multilinear forms already")
print("    have dimension 2 at n = 6 and 7 -- the same 2 as on the diagonal -- so the")
print("    non-symmetric complement is 0-dimensional and Remark I.2.2 accounts for")
print("    0 of the 10,393.")
print("    The whole collapse is the FIRST arrow, the passage from V^{tensor 4} to")
print("    the Weyl subspace.  A WEYL TENSOR IS NOT A GENERIC ELEMENT OF V^{tensor 4},")
print("    and no polarization statement crosses that gap.")
print("  What survives above is the mechanism on Sym^d(V) itself, which is correct")
print("  and which this file still checks.")
