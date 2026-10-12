"""Reviewer 21 (e): explicit worst-case margin scan over the whole interval,
for each version of the frontier, plus the (c0, s) location of the maximiser."""
import sys
import numpy as np
from review_r21_bound import requirement, nienhaus_gamma, c_n, TSTAR
from review_r21_coverage import coupled

ns = [int(x) for x in sys.argv[1:]] or [12, 16, 20, 40, 100, 200, 1000]
alphas = np.linspace(1e-4, 1.0/3.0 - 1e-6, 401)
for n in ns:
    c = c_n(n)
    rows = []
    for a in alphas:
        gN = nienhaus_gamma(a, c)
        gC, c0, s = coupled(a, n, "closed", nc0=201, ns=201)
        gK, _, _ = coupled(a, n, "claim", nc0=201, ns=201)
        req = requirement(a)
        rows.append((a, gN, gC, gK, req, c0, s))
    rows = np.array(rows)
    mC = rows[:, 4] - np.minimum(rows[:, 1], rows[:, 2])
    mK = rows[:, 4] - np.minimum(rows[:, 1], rows[:, 3])
    iC, iK = int(np.argmin(mC)), int(np.argmin(mK))
    # where does the coupled/closed branch alone fail?
    failC = rows[rows[:, 2] >= rows[:, 4], 0]
    failK = rows[rows[:, 3] >= rows[:, 4], 0]
    print(f"n={n:>5d} c_n={c:.6f}", flush=True)
    print(f"   combined worst margin, closed frontier: {mC[iC]:+.6f} at alpha={rows[iC,0]:.5f}"
          f"  (c0={rows[iC,5]:.3f}, s={rows[iC,6]:.4f})")
    print(f"   combined worst margin, claim frontier : {mK[iK]:+.6f} at alpha={rows[iK,0]:.5f}")
    print(f"   closed branch alone fails on alpha in "
          f"{'[]' if len(failC)==0 else f'[{failC.min():.4f}, {failC.max():.4f}]'}"
          f" ; claim branch alone fails on "
          f"{'[]' if len(failK)==0 else f'[{failK.min():.4f}, {failK.max():.4f}]'}", flush=True)
    # c0 of the maximiser across the top of the range
    sub = [(a, coupled(a, n, "closed", 401, 401)[1], coupled(a, n, "closed", 401, 401)[2],
            np.sqrt(3*(1/3-a))) for a in (0.20, 0.2269504, 0.24, 0.26, 0.28, 0.30, 0.32)]
    print("   maximiser: " + "  ".join(f"a={a:.4f}:c0={c0:.3f},s={s:.4f}(s_max={sm:.4f})"
                                       for a, c0, s, sm in sub), flush=True)
