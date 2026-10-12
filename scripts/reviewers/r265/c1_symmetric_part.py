"""r265 claim 1 -- how big is the SYMMETRIC part that the record says survives?

The record: ker(R_3) is exactly the non-symmetric complement, so restitution is
injective on the symmetric part and "nothing a symmetric functional could have seen
is lost".  Applied to r260's measurement that makes rank 2 a dimension count.

The symmetric part here is concrete.  The 10,395 gamma_D are a basis of the
O(n)-invariant functionals on V^{tensor 12} for n >= 12 (Lehrer-Zhang 3.4), S_3
permutes the three FOUR-LEG BLOCKS and therefore permutes that basis, so the
S_3-invariant subspace is spanned by orbit sums and its dimension is the NUMBER OF
ORBITS.  Burnside gives it exactly.

If restitution were injective on the symmetric part -- as the record says -- the rank
after restriction would be that orbit count.  It is 2.
"""
from itertools import combinations
from functools import lru_cache


def matchings(points):
    pts = tuple(sorted(points))
    if not pts:
        return [frozenset()]
    a = pts[0]
    out = []
    for b in pts[1:]:
        rest = tuple(p for p in pts[1:] if p != b)
        for m in matchings(rest):
            out.append(m | {frozenset((a, b))})
    return out


def orbit_count(nlegs, blocksize):
    """orbits of the block-permuting S_3 (or S_k) on perfect matchings of nlegs."""
    from itertools import permutations
    nb = nlegs // blocksize
    ms = matchings(range(nlegs))
    perms = []
    for sigma in permutations(range(nb)):
        p = {}
        for b in range(nb):
            for j in range(blocksize):
                p[b * blocksize + j] = sigma[b] * blocksize + j
        perms.append(p)
    fixed = []
    for p in perms:
        f = 0
        for m in ms:
            im = frozenset(frozenset((p[x], p[y])) for (x, y) in (tuple(e) for e in m))
            if im == m:
                f += 1
        fixed.append(f)
    orbits = sum(fixed) // len(perms)
    return len(ms), fixed, orbits


for nlegs, bs in ((6, 2), (12, 4)):
    total, fixed, orb = orbit_count(nlegs, bs)
    print(f"  {nlegs} legs in {nlegs//bs} blocks of {bs}:")
    print(f"    perfect matchings (dim of the invariants for n >= {nlegs//2}): {total}")
    print(f"    Burnside fixed-point counts over S_3: {fixed}")
    print(f"    ORBITS = dim of the S_3-SYMMETRIC part = {orb}")
    print()
