"""How many unknowns an SOS certificate for F_5 actually carries: 65, not 89.

The assemble pipeline builds its multiplicity Gram over Q(i) and offers a
HERMITIAN block-diagonal ansatz, which has sum m^2 = 89 real parameters on the
measured multiplicities (twelve blocks with m=1, nine with m=2, one with m=3,
two with m=4; 24 blocks, 41 copies).  The record carries 65.  Both numbers are
correct about different objects and the gap is exactly the antisymmetric part.

An SOS Gram is an invariant QUADRATIC FORM on Sym^3(Weyl_5), so the space of
unknowns is Sym^2(Sym^3 Weyl_5)^{O(5)} -- a dimension, not a basis convention.
Weyl integration settles it, touching none of the certificate machinery: no
adapted basis, no cache, no prime, no highest-weight vectors.

    dim Sym^2(Sym^3 Weyl_5)^{O(5)}    = 65 = sum m(m+1)/2
    dim Lambda^2(Sym^3 Weyl_5)^{O(5)} = 24 = sum m(m-1)/2
    sum                               = 89 = sum m^2

So the 24 extra Hermitian directions are genuine O(5)-invariants -- of Lambda^2.
An antisymmetric form contributes nothing to a quadratic, hence nothing to the
sextic, so they lie in the kernel of the Gram-to-sextic map and are gauge.

WHY THEY APPEAR AT ALL.  Every one of the 24 lambda is an INTEGRAL weight of
B_2 = so(5), hence of real type: the quaternionic representations of so(5) ~
sp(4) are the half-integral spin ones, and none occur.  So each multiplicity
space M_lambda carries a real structure and the invariant form is real symmetric
in a real basis.  The highest-weight vectors were built over Q(i) and are not
that basis, which is precisely why h is measured Hermitian with nonzero
imaginary off-diagonals -- reviewer 192's h = [[1, 55i/37], [-55i/37, 5075/1628]]
on lambda = (2,0), reproduced exactly by reviewers 201 and 202.

AND THE RANK IS A THEOREM.  The map carrying a Gram to its sextic is
multiplication mu : Sym^2(Sym^3 W*) -> Sym^6 W*, surjective and O(5)-equivariant.
O(5) is reductive and we are in characteristic zero, so taking invariants is an
exact functor, and an exact functor carries a surjection to a surjection.  Hence

    rank(A) = dim (Sym^6 Weyl_5)^{O(5)} = 14   exactly,   nullity 65 - 14 = 51.

No sample points are needed for it, and the affine family is 51-dimensional
rather than the 89 - 14 = 75 the task list carried.
"""
import importlib.util, os, sys
from fractions import Fraction as F

_d = os.path.dirname(os.path.abspath(__file__))
_spec = importlib.util.spec_from_file_location(
    "n5cc", os.path.join(_d, "run_n5_constraint_count.py"))
cc = importlib.util.module_from_spec(_spec)
_devnull = open(os.devnull, "w"); _real = sys.stdout
sys.stdout = _devnull; _spec.loader.exec_module(cc); sys.stdout = _real

# The measured multiplicities, from the 24-block table.
MULTS = [1]*12 + [2]*9 + [3] + [4, 4]
assert len(MULTS) == 24 and sum(MULTS) == 41

CHI3 = cc.sym_powers(cc.CHI, 3)[3]
assert sum(CHI3.values()) == 7770, "Sym^3(Weyl_5) must have dimension 7770"

SYM2 = cc.sym_powers(CHI3, 2)[2]
assert sum(SYM2.values()) == 7770*7771//2

p1, p2 = CHI3, cc.subst(CHI3, 2)                       # Lambda^2 = (p1^2 - p2)/2
LAM2 = cc.scal(F(1, 2), cc.add(cc.mul(p1, p1), cc.scal(-1, p2)))
assert sum(LAM2.values()) == 7770*7769//2

def _dim(P):
    """Weyl integration returns a Fraction (the 1/|W|); a dimension must be a
    whole number, and a non-integral value would mean the alternant division or
    the root product is wrong rather than that the dimension is fractional."""
    v = cc.invariants(P)
    assert F(v).denominator == 1, f"non-integral invariant count {v}"
    return int(v)

ds, dl = _dim(SYM2), _dim(LAM2)
sym, anti, herm = (sum(m*(m+1)//2 for m in MULTS),
                   sum(m*(m-1)//2 for m in MULTS),
                   sum(m*m for m in MULTS))

print("=== the unknown count for an SOS certificate at n=5 ===\n")
print(f"  dim Sym^2(Sym^3 Weyl_5)^O(5)     = {ds:3d}   sum m(m+1)/2 = {sym}")
print(f"  dim Lambda^2(Sym^3 Weyl_5)^O(5)  = {dl:3d}   sum m(m-1)/2 = {anti}")
print(f"  sum                              = {ds+dl:3d}   sum m^2      = {herm}")
assert (ds, dl, ds+dl) == (sym, anti, herm) == (65, 24, 89)

d6 = _dim(cc.sym_powers(cc.CHI, 6)[6])
print(f"\n  dim (Sym^6 Weyl_5)^O(5)          = {d6:3d}   = rank(A), by exactness")
assert d6 == 14
print(f"  affine family                    = {ds - d6:3d}   = 65 - 14")
assert ds - d6 == 51

print("\n  UNKNOWNS ARE 65.  The 24 Hermitian directions beyond them are")
print("  invariants of Lambda^2, contribute nothing to a sextic, and are gauge.")
