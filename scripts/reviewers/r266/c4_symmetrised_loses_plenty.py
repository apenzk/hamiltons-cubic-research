"""CLAIM 4 (and the second half of CLAIM 1) -- "Independence must be asked of the
SYMMETRISED functionals, and on those restriction loses nothing."  (plan.md, d46cda0)

WHAT THAT SENTENCE ASSERTS.  Symmetrise each gamma_D over the S_3 that permutes the
three four-leg blocks.  The claim is that RESTRICTION to the degree-3 Weyl diagonal
is injective on the span of the symmetrised functionals.

THE DIMENSION IT WOULD FORCE.  The restriction has rank 2 (r260, reconfirmed in
c1_split_the_kernel.py at n = 6 and 7 with 200 samples).  So "loses nothing" is the
statement dim span{symmetrised gamma_D} = 2.

THAT DIMENSION IS EXACTLY COUNTABLE, with no tensor arithmetic at all.
Lehrer-Zhang 3.4 makes {gamma_D} a BASIS of Inv((V^{tensor 12})^*) for n >= 6, and
a leg permutation sends gamma_D to gamma_{sigma.D} -- a PERMUTATION of that basis,
with no signs.  For a group permuting a basis, the invariant subspace has dimension
equal to the NUMBER OF ORBITS.  So

    dim span{symmetrised gamma_D} = # of S_3-orbits on the 10,395 matchings,

computed here both by direct canonicalisation and by Burnside, which agree.
"""
from itertools import permutations
from math import prod


def matchings(pts):
    if not pts:
        yield frozenset()
        return
    a, rest = pts[0], pts[1:]
    for i, b in enumerate(rest):
        for m in matchings(rest[:i] + rest[i + 1:]):
            yield m | {frozenset((a, b))}


BLOCKS = [tuple(range(0, 4)), tuple(range(4, 8)), tuple(range(8, 12))]

def block_perm(sigma):
    """the permutation of the 12 legs induced by sigma acting on the three blocks."""
    p = [0] * 12
    for src, dst in enumerate(sigma):
        for k in range(4):
            p[BLOCKS[src][k]] = BLOCKS[dst][k]
    return p


def act(p, D):
    return frozenset(frozenset((p[i], p[j])) for i, j in (tuple(e) for e in D))


ALL = list(matchings(tuple(range(12))))
print(f"  perfect matchings on 12 legs: {len(ALL)}   (11!! = {prod(range(1,12,2))})")

SIG = [block_perm(s) for s in permutations(range(3))]

# --- orbit count by canonicalisation
seen, orbits = set(), 0
for D in ALL:
    if D in seen:
        continue
    orbits += 1
    for p in SIG:
        seen.add(act(p, D))

# --- orbit count by Burnside, as a cross-check
fixed = [sum(1 for D in ALL if act(p, D) == D) for p in SIG]
burnside = sum(fixed) // len(SIG)
assert sum(fixed) % len(SIG) == 0
print(f"  fixed matchings per element of S_3 (id, then the five others): {fixed}")
print(f"  orbits by canonicalisation: {orbits}")
print(f"  orbits by Burnside:         {burnside}")
assert orbits == burnside, "the two counts must agree"

print(f"""
  So dim span{{symmetrised gamma_D}} = {orbits}.

  RESTRICTION TO THE WEYL DIAGONAL TAKES THOSE {orbits} TO RANK 2.
  Evaluation at W (x) W (x) W is already S_3-symmetric, so symmetrising the
  functionals cannot change a single value on the diagonal: the rank there is the
  same 2 that r260 measured and c1 reconfirmed.

  THE KERNEL ON THE SYMMETRISED FUNCTIONALS IS THEREFORE {orbits} - 2 = {orbits - 2}.

  "on those restriction loses nothing" is false by {orbits - 2} dimensions.
  Symmetrisation removes {len(ALL)} - {orbits} = {len(ALL) - orbits} dimensions of the
  10,393 kernel and leaves {orbits - 2}.  What it removes is the part Remark I.2.2
  describes; what remains is the part that is killed by RESTRICTION TO THE SUBSPACE
  Weyl (x) Weyl (x) Weyl inside V^{{tensor 12}}, which no polarization statement
  touches -- and c1 measures that part directly, at 10,393 of 10,393.
""")

print("""  RECONCILING THE TWO COUNTS.  c1 finds the invariant multilinear forms on
  THREE INDEPENDENT Weyl slots already have dimension 2, so nothing non-symmetric
  survives restriction to the subspace, and the whole 10,393 is subspace loss.
  This file finds symmetrisation upstairs, on twelve FREE legs, removes only
  %d of it.  Both are consistent and both refute the record: the operation the
  record needs is restriction to the subspace, and symmetrising the gamma_D
  first is a different operation that does not commute with the question.""" % (len(ALL) - orbits))
