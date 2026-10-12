"""r265, addendum to claim 1 -- the OTHER decomposition of the same composite.

The composite r260 measured is

    invariant functionals on V^{(x)12}  --A--> trilinear forms on Weyl_n^3  --B--> functions of one W

A is restriction of the DOMAIN to the Weyl subspace in each of the three slots;
B is restitution, and Remark I.2.2 governs B alone.  Measuring the rank at THREE
INDEPENDENT Weyl tensors gives the dimension after A, and therefore splits the
10,393 between the two arrows.  (My other script splits the same composite the
other way round -- restitute on V^{(x)4} first, restrict second.  Both orders
refute the record; this one prices arrow B at zero.)
"""
import numpy as np
exec(open("scripts/reviewers/r265/c2_weyl_rank.py").read().split('print("STEP 0')[0]
     .split("import numpy as np")[1])

for n in (6, 7, 12):
    A, B, C = (weyl_batch(n, 40) for _ in range(3))
    D = weyl_batch(n, 40)
    ms = matchings(tuple(range(12)))
    VA = np.empty((40, len(ms)))
    VD = np.empty((40, len(ms)))
    for j, m in enumerate(ms):
        lab = [None] * 12
        for k, (x, y) in enumerate(m):
            lab[x] = lab[y] = LET[k]
        s = ",".join("s" + "".join(lab[4 * b:4 * b + 4]) for b in range(3)) + "->s"
        VA[:, j] = np.einsum(s, A, B, C, optimize=True)
        VD[:, j] = np.einsum(s, D, D, D, optimize=True)
    rk = lambda M: np.linalg.matrix_rank(M, tol=1e-8 * max(1.0, np.abs(M).max()))
    print(f"  n={n:>2}:  rank at THREE INDEPENDENT Weyl tensors = {rk(VA)};"
          f"   rank on the diagonal W(x)W(x)W = {rk(VD)}")
    print(f"        so arrow A (restrict the domain to Weyl^3) costs "
          f"{len(ms)-rk(VA)} of the 10,393, and arrow B (restitution) costs "
          f"{rk(VA)-rk(VD)}")
