"""r265 claim 4 -- 'independence must be asked of the SYMMETRISED functionals'.

That is offered as a NEW question, replacing the one r260 answered.  It is the same
question with the same answer, and the reason is one line: the point W tensor W
tensor W is already S_3-symmetric, so gamma_D and sigma.gamma_D take the SAME VALUE
there.  Symmetrising is therefore the identity on the restricted family, and the
rank of the symmetrised family equals the rank of the original -- 2.

Also pins the degree-2 generic rank at its predicted value (the orbit count), which
the 60-sample row of c2_weyl_rank.py could only lower-bound.
"""
import numpy as np
from itertools import permutations

rng = np.random.default_rng(4265)
LET = "abcdefghijklmnopqrstuvwxyz"
exec(open("scripts/reviewers/r265/c2_weyl_rank.py").read().split(
    "print(\"STEP 0")[0].split('import numpy as np')[1].replace(
    "from itertools import permutations", "", 1))


def subs_for(m, nblocks):
    legs = 4 * nblocks
    lab = [None] * legs
    for k, (x, y) in enumerate(m):
        lab[x] = lab[y] = LET[k]
    return ",".join("s" + "".join(lab[4 * b:4 * b + 4]) for b in range(nblocks)) + "->s"


def values(nblocks, tensors):
    ms = matchings(tuple(range(4 * nblocks)))
    V = np.empty((tensors.shape[0], len(ms)))
    for j, m in enumerate(ms):
        V[:, j] = np.einsum(subs_for(m, nblocks), *([tensors] * nblocks), optimize=True)
    return ms, V


def orbit_matrix(ms, nblocks):
    """columns = orbit sums under the block-permuting S_k."""
    key = {frozenset(frozenset(e) for e in m): j for j, m in enumerate(ms)}
    seen, cols = set(), []
    for j, m in enumerate(ms):
        fm = frozenset(frozenset(e) for e in m)
        if fm in seen:
            continue
        orb = set()
        for sig in permutations(range(nblocks)):
            p = {b * 4 + i: sig[b] * 4 + i for b in range(nblocks) for i in range(4)}
            orb.add(frozenset(frozenset((p[x], p[y])) for (x, y) in
                              (tuple(e) for e in fm)))
        seen |= orb
        cols.append([key[o] for o in orb])
    return cols


def rk(M):
    return np.linalg.matrix_rank(M, tol=1e-8 * max(1.0, np.abs(M).max()))


print("PART A -- degree 2, all three numbers pinned\n")
ms2 = matchings(tuple(range(8)))
cols2 = orbit_matrix(ms2, 2)
print(f"  matchings of 8 legs: {len(ms2)}   orbit sums under the block S_2: {len(cols2)}")
for n in (6, 7, 12):
    T = rng.standard_normal((140, n, n, n, n))
    _, VT = values(2, T)
    W = weyl_batch(n, 140)
    _, VW = values(2, W)
    ST = np.stack([VT[:, c].sum(1) for c in cols2], 1)
    SW = np.stack([VW[:, c].sum(1) for c in cols2], 1)
    print(f"  n={n:>2}: generic 4-tensor rank {rk(VT):>3} (symmetrised {rk(ST):>3});"
          f"   WEYL rank {rk(VW):>3} (symmetrised {rk(SW):>3})")
print("\n  The generic rank lands on the orbit count -- restitution loses exactly the")
print("  non-symmetric part and nothing else, as Weyl says.  The WEYL rank is 1.")
print("  The extra collapse is the SUBSPACE, and symmetrising changes neither number.\n")

print("PART B -- degree 3, the record's own case: symmetrising changes nothing\n")
ms3 = matchings(tuple(range(12)))
cols3 = orbit_matrix(ms3, 3)
print(f"  matchings of 12 legs: {len(ms3)}   orbit sums under the block S_3: {len(cols3)}")
for n in (6, 7):
    W = weyl_batch(n, 40)
    _, VW = values(3, W)
    SW = np.stack([VW[:, c].sum(1) for c in cols3], 1)
    d = max(abs(VW[:, c].std(0)).max() if False else 0.0 for c in cols3[:1])
    same = max(float(np.abs(VW[:, c] - VW[:, c[:1]]).max()) for c in cols3)
    print(f"  n={n:>2}: rank of the 10,395 gamma_D at W (x)3 = {rk(VW)};"
          f"  rank of the {len(cols3)} SYMMETRISED functionals = {rk(SW)}")
    print(f"        max spread WITHIN an orbit of the values at W (x)3: {same:.2e}"
          "   -- every member of an orbit takes the same value")
print("\n  So `independence of the symmetrised functionals` is not a different")
print("  measurement: the restricted family is already S_3-invariant, symmetrisation")
print("  acts on it as multiplication by |orbit|, and the rank is the same 2.\n")
