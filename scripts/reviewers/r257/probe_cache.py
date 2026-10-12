"""r257 probe: what the multiplicity test actually reads out of n5_adapted.pkl."""
import pickle
from fractions import Fraction as F

RAW = pickle.load(open("scripts/runs/n5_adapted.pkl", "rb"))
lam0 = next(iter(RAW))
v0 = RAW[lam0][0][0]
k0 = next(iter(v0))
print("block key type:", type(lam0), lam0)
print("stored value type:", type(v0[k0]), repr(v0[k0]))
print("component types:", [type(c).__name__ for c in v0[k0]])

# does any stored coefficient have a nonzero imaginary part?
nz_im = 0; tot = 0
for lam, cs in RAW.items():
    for copy in cs:
        for vec in copy:
            for k, val in vec.items():
                tot += 1
                if val[1] != 0: nz_im += 1
print(f"coefficients: {tot} total, {nz_im} with nonzero imaginary part")

MULTI = sorted(((l, len(c)) for l, c in RAW.items() if len(c) > 1), key=lambda t: -t[1])
print("multiplicity blocks:", MULTI)

# the coercion the test applies
def coerce(x):
    return F(x.r if hasattr(x, 'r') else x) if not isinstance(x, tuple) else F(x[0])
print("coerce((3,5)) =", coerce((F(3), F(5))), " <-- imaginary part dropped")

# structure of position 0: is the m x m submatrix at some monomial set the identity?
for lam, m in MULTI:
    cps = RAW[lam]
    keys = sorted({k for i in range(m) for k in cps[i][0]})
    cols = {}
    for k in keys:
        col = tuple(cps[i][0].get(k, (F(0), F(0))) for i in range(m))
        cols[k] = col
    unit = []
    for i in range(m):
        want = tuple((F(1), F(0)) if j == i else (F(0), F(0)) for j in range(m))
        hit = [k for k, c in cols.items() if c == want]
        unit.append(hit[0] if hit else None)
    print(f"  lambda={lam} m={m}: unit rows at monomials {unit} -> "
          f"{'IDENTITY SUBMATRIX PRESENT' if all(u is not None for u in unit) else 'absent'}")
