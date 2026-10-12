"""CLAIM 3 -- run_restitution_kernel.py, reproduced EXACTLY, and what its asserts test.

The script measures rank(R_d) by FLOATING rank of an evaluation matrix at
4*comb(V+d-1,d)+20 random points, tol=1e-8.  Here the same table is produced with
no floating point and no evaluation points at all, from the definition of R_d.

R_d sends the basis functional e_{i_1}* (x) ... (x) e_{i_d}*  of (V^{tensor d})^*
to the MONOMIAL x_{i_1} ... x_{i_d}.  So in the monomial basis of R[V]_d the matrix
of R_d is the 0/1 incidence matrix "index tuple -> its multiset", which has exactly
one 1 per row.  Its rank is the number of DISTINCT multisets reached, = comb(V+d-1,d),
and the kernel is spanned by the differences of tuples with equal multiset.

That is an exact statement of both asserts, over Z, at any (V,d).
"""
from itertools import product
from math import comb
from fractions import Fraction

def exact(V, d):
    idx = list(product(range(V), repeat=d))
    # image of each tuple = its sorted multiset
    monos = {}
    for t in idx:
        monos.setdefault(tuple(sorted(t)), []).append(t)
    rank = len(monos)                     # distinct monomials hit, each hit exactly once
    ker = len(idx) - rank                 # sum over monomials of (multiplicity - 1)
    ker_check = sum(len(v) - 1 for v in monos.values())
    assert ker == ker_check
    # the kernel IS ker(symmetrisation): F is killed iff sum over each S_d-orbit is 0
    return len(idx), rank, ker

print("EXACT reproduction (no floats, no sample points):\n")
print(f"  {'dim V':>6} {'d':>2} {'multilinear':>12} {'rank R_d':>10} {'dim Sym^d':>10} {'ker':>8} {'V^d - Sym':>10}")
ok = True
for V in (2, 3, 4):
    for d in (2, 3, 4):
        total, r, k = exact(V, d)
        sd = comb(V + d - 1, d)
        print(f"  {V:>6} {d:>2} {total:>12} {r:>10} {sd:>10} {k:>8} {total-sd:>10}")
        ok &= (r == sd)
print(f"\n  rank == dim Sym^d at every cell: {ok}")

print("""
WHAT THE TWO ASSERTS TEST.
  assert 1:  r == sd
  assert 2:  total - r == total - sd
Assert 2 is assert 1 with `total -` applied to both sides.  Subtracting the same
integer from both sides of an equality that the line above already asserted cannot
fail unless assert 1 has already fired.  It is an algebraic restatement, not a
second test.  Proof: for any ints a,b,t,  a == b  <->  t-a == t-b.

WHAT ASSERT 1 TESTS.  rank(R_d) on ALL multilinear functionals equals
dim Sym^d(V*).  This is Theorem I.2.1 (surjectivity: every degree-d polynomial IS a
restitution) plus linear independence of monomials.  It is a fact about the FULL
space (V^{tensor d})^*, and it is true for every finite-dimensional V and every d.
It says nothing about a SUBSPACE of functionals, which is what the record's 10,395
gamma_D are.
""")

# Is the evaluation-point count enough to CERTIFY the rank rather than lower-bound it?
print("EVALUATION-POINT COUNT.  The script builds a matrix with")
for V in (2, 3, 4):
    for d in (2, 3, 4):
        npts = 4 * comb(V + d - 1, d) + 20
        print(f"    V={V} d={d}:  {npts} points x {V**d} columns; "
              f"rank <= min = {min(npts, V**d)}, needed = {comb(V+d-1,d)}")
print("""  rank(sampled) <= rank(true) always, so the count only ever LOWER-bounds.
  It happens to suffice here because rank(true) = dim Sym^d(V*) <= number of points
  by construction (4x + 20), so a full-rank sample is possible -- but the script
  never checks the sampled rank against an upper bound it derived independently.
  The certificate is: monomials of degree d in V variables are linearly independent,
  which is exact and needs no points.
""")

# ---------------------------------------------------------------------------
# IS A BARE tol=1e-8 ADEQUATE?  It is an ABSOLUTE tolerance in numpy, so the
# verdict moves with the SCALE of the sample points.  The reviewed script draws
# standard normals; rescaling them by c multiplies every entry by c^d and every
# singular value with it.
import numpy as np
from itertools import product as _prod
print("SCALE SENSITIVITY OF `np.linalg.matrix_rank(M, tol=1e-8)` (absolute tol):\n")
print(f"  {'dim V':>6} {'d':>2} {'scale c':>9} {'rank':>6} {'needed':>7}")
for V, d in ((3, 3), (4, 4)):
    idx = list(_prod(range(V), repeat=d))
    for c in (1.0, 1e-2, 1e-3):
        pts = c * np.random.default_rng(0).standard_normal((4*comb(V+d-1,d)+20, V))
        M = np.array([[np.prod(p[list(t)]) for t in idx] for p in pts])
        r = np.linalg.matrix_rank(M, tol=1e-8)
        print(f"  {V:>6} {d:>2} {c:>9.0e} {r:>6} {comb(V+d-1,d):>7}"
              + ("   <-- assert would FIRE on identical mathematics" if r != comb(V+d-1,d) else ""))
print("""
  The mathematics is scale-invariant; the test is not.  r260's own script scales
  the tolerance (`tol=1e-8 * max(1.0, abs(M).max())`); run_restitution_kernel.py
  does not.  With standard normals the margin happens to be comfortable, so the
  published table is right -- but the check is calibrated to the sampler rather
  than to the claim.
""")
