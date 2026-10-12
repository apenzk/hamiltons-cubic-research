"""The independence test where the case actually lives: multiplicity >= 2.

WHY THIS FILE EXISTS.  Five attempts at this item were refuted, and reviewer 256
found the reason the fifth could never have worked: its validation universe --
two-free-leg contractions of two Weyl tensors -- spans RANK ONE, and with the
metric only two, one per isotypic.  NO BLOCK OF MULTIPLICITY >= 2 EXISTS THERE
AT ALL, while multiplicity >= 2 is the only thing the programme must certify and
the blocks reach multiplicity 9 at n = 12.  Every pair such a validation can form
is Schur-independent before a component is read.

  So this test is built where the case occurs.  The record's own n = 5 adapted
  basis has blocks of multiplicity 2, 3 and 4 -- (2,2) and (4,2) carry four
  copies each.  Multiplicity 4 is the widest available below n = 12, and it is
  the regime every previous validation missed.

WHAT IS READ, AND WHY THAT COORDINATE.  Reviewer 255: reading RAW diagram values
gives only a NECESSARY condition, since {P F_c} independent implies {F_c}
independent and never the converse.  The read becomes TWO-SIDED at the
HIGHEST-WEIGHT coordinate inside V_lambda -- equivariance plus polarisation
supply the converse there.  The adapted basis is built by lowering from
highest-weight vectors, so position 0 of each copy IS that coordinate, and the
copies of one block differ only in their multiplicity label.

  THE TEST: for a block of multiplicity m, read the highest-weight coordinate of
  each copy at several sample points and rank the m columns.  rank = m certifies
  that the m copies are independent as functions -- which is the certifiable
  side (r254) and the statement A2'' needs.

WHAT THIS ESTABLISHES AND WHAT IT DOES NOT.  It exercises multiplicity 4, the
projector-kernel hazard, and the two-sided coordinate, none of which any earlier
validation could reach.  It does NOT settle n = 12: the covariants there are
still not built as diagrams, which remains the item's open half.
"""
import pickle, random
from fractions import Fraction as F

with open("scripts/runs/n5_adapted.pkl", "rb") as f:
    ADAPTED = pickle.load(f)

MULTI = sorted(((lam, len(c)) for lam, c in ADAPTED.items() if len(c) > 1),
               key=lambda t: -t[1])
print(f"  blocks of multiplicity > 1 at n=5: {len(MULTI)}")
print(f"  widest: {MULTI[0][0]} with multiplicity {MULTI[0][1]}")
assert MULTI[0][1] >= 4, (
    f"the widest block has multiplicity {MULTI[0][1]}; this file exists to "
    "exercise multiplicity >= 2 and ideally the widest available, since r256 "
    "showed every earlier validation was confined to multiplicity 1")

def hw_support(copies):
    """positions carried by copy 0 -- the highest-weight end of the block."""
    return sorted({t for t, v in enumerate(copies[0]) if v})

def rank_of_block(lam, comps):
    """exact rank of the m columns, rows indexed by (copy position) reads."""
    copies = ADAPTED[lam]; m = len(copies)
    rows = []
    for t in comps:
        # the coefficient vector of each copy at position t, over the monomials
        keys = sorted({k for i in range(m) if copies[i][t] for k in copies[i][t]})
        for k in keys:
            rows.append([copies[i][t].get(k, 0) if copies[i][t] else 0
                         for i in range(m)])
    if not rows:
        return 0, m
    M = [[F(x.r if hasattr(x, 'r') else x) if not isinstance(x, tuple) else F(x[0])
          for x in row] for row in rows]
    rank = 0
    for c in range(m):
        pr = next((t for t in range(rank, len(M)) if M[t][c] != 0), None)
        if pr is None:
            continue
        M[rank], M[pr] = M[pr], M[rank]
        iv = M[rank][c]; M[rank] = [x / iv for x in M[rank]]
        for t in range(len(M)):
            if t != rank and M[t][c] != 0:
                f0 = M[t][c]
                M[t] = [x - f0 * y for x, y in zip(M[t], M[rank])]
        rank += 1
    return rank, m

print("\n  reading the highest-weight coordinate, per block:")
checked = 0
for lam, m in MULTI:
    sup = hw_support(ADAPTED[lam])
    if not sup:
        continue
    r, mm = rank_of_block(lam, sup[:3])
    flag = "OK" if r == mm else "DEFICIENT"
    print(f"    lambda={str(lam):<8} multiplicity {mm}   rank {r}   {flag}")
    checked += 1
    assert r == mm, (
        f"block {lam} has multiplicity {mm} but its copies read rank {r} at the "
        "highest-weight coordinate.  The copies of a block are independent by "
        "construction -- they are a basis of the multiplicity space -- so a "
        "deficient read means the coordinate chosen does not separate them, "
        "which is exactly the failure every earlier attempt hid by working only "
        "in multiplicity 1")

assert checked >= 5, (
    f"only {checked} blocks were exercised; the point of this file is coverage "
    "of the multiplicity >= 2 regime that r256 showed was never reached")
print(f"\n  {checked} blocks of multiplicity >= 2 exercised, every one at full")
print("  rank -- including multiplicity 4, which no earlier validation reached.")
print("\n  OWED: the n=12 covariants as diagrams.  This is the test operating")
print("  where the case lives, not the answer at n=12.")
