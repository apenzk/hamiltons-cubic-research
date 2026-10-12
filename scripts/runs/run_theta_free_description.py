"""Why the dimension-free route does not reach this programme, twice over.

TWO INDEPENDENT OBSTRUCTIONS, and the second is fatal on its own.

=== 1. LEVIN-CHANDRASEKARAN DOES NOT APPLY TO O(n) AT ALL (reviewer 227) ===

Their Section 1.3: "we apply this notion only when H has finite index in G."
Definition 2.6 builds algebraically free modules only from that induction, and
Definition 2.7 defines the PRESENTATION DEGREE only through such a free module.
For G_n = O_n their own Example 2.8 gives H_{n,d} = O(n-d), so the relevant
subgroup is O(d) x O(n-d), whose coset space is the Grassmannian Gr(d,n) --
INFINITE index.

  So no nonzero module over {O_n} has a finite presentation degree k, and both
  Theorem 3.4 and Theorem 3.5 open "fix n_0 >= k".  THE ROUTE FAILS AT
  DEFINITION 2.7, not at any arithmetic threshold.

The authors say so themselves twice: Section 7 lists extending the presentation
-degree calculus to Lie groups such as O_n as OPEN, and their own O_n example in
Section 6 states the theory "does not guarantee the existence of an O_n-invariant
extension", falling back to B_n.

  AND THE ESTIMATE "n >= d+k lands near 24" IS STRUCK, NOT REFINED.  It has no
  referent: d+k is Theorem 5.1's gate for the FINITE Weyl groups, Theorem 3.5
  asks only n_0 >= k, and the chain 4 -> 12 -> 24 used Theorem 2.11's Sym clause,
  which is prefaced "If G_n = B_n, D_n, or S_n" and which Remark 2.13 says fails
  otherwise.  What survives for O(n) is the GENERATION degree alone: {Weyl_n} is
  generated in degree exactly 4, and {Sym^3(Weyl_n)} in degree at least 6.
  Nothing forces anything near 12.

=== 2. EVEN GRANTING THE MACHINERY, THE SHARP TARGET IS NOT FREELY DESCRIBED ===

Free description is RESTRICTION COMPATIBILITY -- their Definition 1.4, with
phi_n^* the orthogonal projection -- and the pinning is Proposition 2.9's
projection isomorphism for n >= k.  (An earlier version of this file said
"pinned by equivariance", which names the wrong mechanism and hides the
hypothesis n_0 >= k that obstruction 1 shows is unsatisfiable.)

With A = |W|^6, B = <Q(W),W>^2, C = |W|^2|Q(W)|^2, the target is
Theta_n^2 A - B + mu(C - B) and the only n-dependence is that scalar, so the
restriction-compatible extension from n_0 carries Theta_{n_0}^2 unchanged.
Theta_n^2 = 2(n-1)(n-2)/n^2 is strictly increasing, so the extension asserts
theta <= Theta_{n_0}.

  THE STEP THAT WAS MISSING (reviewer 226): concluding "false" from that skips
  the multiplier mu(C - B) >= 0, which could a priori compensate.  IT CANNOT,
  and the reason is exact: C - B vanishes precisely at the witness.  At the
  balanced sphere product Q(W) = theta W, so |W|^2|Q(W)|^2 = <Q(W),W>^2 there.
  The extension is therefore negative at that point FOR EVERY mu -- so the
  description set at n > n_0 is not merely wrong, it is EMPTY, mu being the free
  variable of ConicSeq.

A, B and C are genuinely freely described -- padded W stays trace-free and all
three reproduce -- BUT ONLY for the unprojected Q = W^2 + W^#.  With the
Weyl-projected Q, C moves under padding and B does not.  The convention is
load-bearing and must be stated wherever these are called freely described.

Padding-invariance is no rescue: it is what makes A, B, C freely described in the
first place, and the witness is the unpadded n-dimensional sphere product, which
no data at n_0 can see.

  SCOPE.  2 - Theta_n^2 > 0 for every n, so the NON-SHARP target
  2A - B + mu(C - B) IS freely described.  This obstruction bites the SHARP
  constant only.

=== THE delta^a_a REPAIR IS EMPTY, THOUGH NOT FOR THE REASON FIRST GIVEN ===

The first reason offered was that Theta_n^2 has n^2 in a denominator and division
is not a ring operation.  THAT IS WRONG (reviewer 226): SOS-ness survives
multiplication by n^2 > 0, and n^2 G = 2(n-1)(n-2)A - n^2 B + mu n^2 (C - B) has
every coefficient polynomial in n.

The repair dies on the TRACE instead, which is the stronger reason.  I_n is
freely described, P(I_{n+1}) = I_n, but its trace is not: tr(I_{n+1}) = n+1 while
tr(P(I_{n+1})) = n.  So delta^a_a is not a freely-described scalar and writing n
as a contraction changes notation, not the sequence.  The denominator argument
would have left "clear it and retry" open -- and that move algebraically succeeds;
the trace argument kills every n-dependent coefficient at once, polynomial or
rational.  Rescaling W or the inner product is closed off by degree-0 homogeneity
and by Definition 1.3(b)'s isometry requirement.

=== WHAT IS LEFT ===

Run Theorem 3.5 over {B_n} contained in O(n), as the authors do -- every degree is
then computable -- and ask whether the unique B_n-invariant extension is
O(n)-invariant.  That is a smaller gap than the one this route otherwise faces,
and it is a concrete argument rather than an absence.
"""
from fractions import Fraction as F

def theta2(n):
    return F(2*(n-1)*(n-2), n*n)

print("Theta_n^2 = 2(n-1)(n-2)/n^2, rational in n -- the target carries the SQUARE")
for n in (12, 14, 16, 24, 100):
    print(f"  n={n:3d}   Theta_n^2 = {str(theta2(n)):>9}   Theta_n = {float(theta2(n))**0.5:.6f}")

print("\nstrictly increasing, so freely extending from n_0 UNDERSHOOTS the target:")
for n0 in (12, 24):
    for n in (n0+2, n0+4):
        gap = theta2(n) - theta2(n0)
        print(f"  n_0={n0}, n={n}: target - free_ext = {gap} * |W|^6, "
              f"positive = {gap > 0}")
        assert gap > 0, (
            f"Theta^2 failed to increase from n={n0} to n={n}; the whole "
            "obstruction rests on this monotonicity, and without it the free "
            "extension would be the WEAKER statement and would carry through")

print("\n  so the extension asserts theta <= Theta_{n_0}, and the description set")
print("  at n > n_0 is EMPTY rather than merely wrong -- C - B vanishes at the")
print("  witness, so no choice of the free multiplier mu can compensate:")
for n0, n in ((12, 24),):
    print(f"    at n={n} the sphere product attains Theta_{n} = "
          f"{float(theta2(n))**0.5:.6f} > Theta_{n0} = {float(theta2(n0))**0.5:.6f}")
    assert theta2(n) > theta2(n0)

# MONOTONICITY, CHECKED ON THE PARITY-CORRECT SEQUENCE.  An earlier version
# closed with `assert 3*n - 4 > 0`, which is a tautology about integers and
# checks nothing (reviewer 226).  It also printed only the even branch, while
# Theta_n^2 is parity-dependent.  The real claim is that the sequence actually
# used increases, so that is what is asserted, against its own predecessor.
prev = None
for n in range(4, 401):
    cur = theta2(n)
    if prev is not None:
        assert cur > prev, (
            f"Theta^2 failed to increase at n={n}: {prev} -> {cur}.  The whole "
            "obstruction rests on this monotonicity -- were it decreasing, the "
            "restriction-compatible extension would be the WEAKER statement and "
            "would carry through unharmed")
    prev = cur
print(f"\n  strictly increasing on every n in [4, 400], checked against the")
print(f"  predecessor rather than by a sign identity that cannot fail")
