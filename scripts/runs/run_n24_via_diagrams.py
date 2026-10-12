"""The n=24 covariants cost nothing beyond the n=12 ones.  A reduction.

THE PROBLEM.  Reviewer 232's k_B >= 24 moves the transfer certificate's base
dimension from 12 to 24, and the naive reading of that is fatal:

    n     dim Weyl_n      dim Sym^3(Weyl_n)
    12         1,638            733,813,080
    24        27,300      3,391,442,154,100        4,622x

The highest-weight elimination that is taking hours at n=12 is hopeless at 24.

THE ESCAPE, AND IT FOLLOWS FROM THE TRANSFER THEOREM'S OWN STEP (1).  The
covariants need not be built at 24 at all, because a CONTRACTION DIAGRAM is an
n-independent combinatorial object and only its EVALUATION depends on n.

  1. SPANNING NEEDS NO STABILITY.  By the first fundamental theorem, contraction
     diagrams span the equivariant maps at every dimension -- reviewer 232
     confirmed this is universal, with only INDEPENDENCE requiring a stable
     range.  So a diagram list spanning at n=12 spans at n=24.

  2. INDEPENDENCE TRANSFERS UPWARD, NOT DOWNWARD.  Padding gives a linear
     restriction map from level 24 to level 12 under which each diagram goes to
     itself (the no-free-loop lemma).  A set whose restrictions are independent
     is independent, so 184 diagrams independent at n=12 stay independent at
     n=24.  The usual direction of a stability argument is the other way, and it
     is the easy direction that is needed here.

  3. THE COUNT IS THE SAME AT BOTH.  The stability theorem gives 71 blocks and
     184 multiplicities at every n >= 12, so 184 independent diagrams at n=12
     are a full basis at n=24 -- not merely an independent set inside a bigger
     space.

  SO THE TAIL RUN'S OUTPUT IS REUSABLE.  What must be produced at n=12 is not
  184 tensors but 184 DIAGRAMS, and the n=24 certificate is assembled by
  evaluating those same diagrams there.  Evaluating a fixed diagram is a
  contraction whose cost is polynomial in n, not in dim Sym^3.

WHAT THIS DOES NOT DO.  It says the BASIS transfers.  The Gram entries -- the
pairings the SDP consumes -- must still be evaluated at n=24, and each is a
closed Brauer diagram whose value is a polynomial in n.  That is the
Blekherman-Riener shape the record already names as the remaining core, and this
reduction is what makes it reachable: a fixed 184 x 184 matrix of polynomials in
n, rather than a new elimination at every dimension.

  OWED: the current construction emits VECTORS in a weight space, not diagrams.
  Recovering the diagram behind each covariant, or re-running the construction
  diagrammatically, is the concrete next task and is not done here.
"""
from math import comb

def dim_weyl(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12

print(f"  {'n':>4} {'dim Weyl_n':>12} {'dim Sym^3':>22}")
for n in (12, 16, 24):
    d = dim_weyl(n)
    print(f"  {n:>4} {d:>12,} {comb(d + 2, 3):>22,}")

assert dim_weyl(12) == 1638, f"dim Weyl_12 = {dim_weyl(12)}, not 1638"
assert dim_weyl(24) == 27300, f"dim Weyl_24 = {dim_weyl(24)}, not 27300"

_r = comb(dim_weyl(24) + 2, 3) / comb(dim_weyl(12) + 2, 3)
print(f"\n  Sym^3 grows by {_r:,.0f}x from n=12 to n=24, which is why the")
print("  construction must NOT be repeated there.")
assert _r > 1000, (
    f"the growth factor came out {_r:.1f}; if Sym^3 barely grew, rebuilding at "
    "n=24 would be the simpler route and this whole reduction would be "
    "unnecessary rather than load-bearing")

# The reduction's arithmetic claim: the same 184 serve at both dimensions.
BLOCKS, MULTS = 71, 184
print(f"\n  the stability theorem gives {BLOCKS} blocks and {MULTS} multiplicities")
print("  at EVERY n >= 12, so a basis found at 12 is a basis at 24 --")
print("  independence transfers upward under restriction, which is the easy")
print("  direction, and spanning needs no stable range at all.")
