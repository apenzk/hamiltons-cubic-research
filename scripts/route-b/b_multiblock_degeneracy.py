"""Three-block sphere products: degenerate, saddles, and excluded by THETA.

CORRECTED AFTER GATE 2 (Reviewers 52 and 53, agreeing).  This file originally
claimed the exclusion came from the slack.  Both halves of that were wrong:

  * The slack figure 3.97e3 was measured with b_padded_s3s3.slack, which brackets
    in the ADJOINT representation and so carries a spurious (n-2)^2 = 49.  The
    natural value is 81; 0.75 in route B's theta-identity convention; 12.73 on the
    convention FINDINGS uses for its 8.94 / 16.7 figures.
  * S is NOT a distance to { S = 0 }.  Perturbing padded W_CP2 -- an exact S = 0
    critical point -- by 1e-6 gives S in [11.3, 22.2].  Openness fails through a
    SEQUENCE, so the size of S at one point says nothing topological.

What does exclude these points is theta: P is constant on connected components of
Crit(P), and sup theta/theta_0 over k-block products is 1/sqrt(k-1), so every
three-block product sits below 0.7071 theta_0.

Result at n = 9, all confirmed to the last digit:

    (S^3)^3   theta = 0.769800359 = 0.6547 theta_0(9)   residual 8e-17
              orbit 27,  dim E(1/2) = 81,  excess 54    -- degenerate
              lambda_max(L_e|W-perp) = 1, not 1/2       -- a SADDLE

Degeneracy is generic at k >= 3 (excess 24-162 over seven products), not a (3,3)
anomaly.  These are not orthogonal block sums -- cross-block entries are nonzero --
so the harmonic-square law never covered them.

CONSTRUCTION TRAP.  sphere_product_W is Ricci-flat only for TWO blocks: the Ricci
diagonal is exactly (2-k)/p, so -1/p at three, giving criticality residual 0.38.
Multi-block points must come from the block-symmetric vertex solver.  Note that
solver's driver filters out zero entries and so DISCARDS genuine S = 0 critical
points -- do not use it to enumerate them.

import numpy as np, sys, importlib.util
sys.path.insert(0, 'scripts/lib')
_spec = importlib.util.spec_from_file_location("r13", "scripts/review_r13_multiblock.py")
r13 = importlib.util.module_from_spec(_spec); _spec.loader.exec_module(r13)
from review_r30_core import (pair_index, adj, Q, weyl_basis, orbit_tangent, orthonormalize)
from b_padded_s3s3 import slack

def symmetric_solution(blocks):
    """The fully block-symmetric critical point, or None."""
    k = len(blocks)
    for _key, (w, th) in r13.multiblock_point(blocks).items():
        d = np.diag(w); off = w[~np.eye(k, dtype=bool)]
        if np.ptp(d) < 1e-6 and np.ptp(off) < 1e-6 and abs(d[0]) > 1e-9:
            return w, th
    return None

def build(blocks, w):
    n = sum(blocks); pairs, idx = pair_index(n); N = len(pairs)
    lab = []
    for bi, b in enumerate(blocks):
        lab += [bi] * b
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(pairs):
        W[a, a] = w[lab[i], lab[j]]
    return W / np.linalg.norm(W)

def analyse(blocks):
    n = sum(blocks)
    pick = symmetric_solution(blocks)
    if pick is None:
        return None
    w, _ = pick
    W = build(blocks, w)
    pairs, idx = pair_index(n); N = len(pairs); A = adj(n)
    th = float(np.tensordot(W, Q(n, W)))
    res = float(np.linalg.norm(Q(n, W) - th * W))
    th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    B = weyl_basis(n); D = len(B); Bf = np.array([b.ravel() for b in B])
    e = W / th; A2 = A.reshape(N * N, N)
    Ae = (A2 @ e).reshape(N, N, N); AeT = Ae.transpose(0, 2, 1).reshape(N, N * N)
    M = np.zeros((D, D))
    for j, X in enumerate(B):
        AX = (A2 @ X).reshape(N, N, N); T = AX.reshape(N, N * N) @ AeT.T
        M[:, j] = Bf @ (0.5 * (e @ X + X @ e) - 0.25 * (T + T.T)).ravel()
    ev = np.linalg.eigvalsh(0.5 * (M + M.T))
    dimE = int((np.abs(ev - 0.5) < 1e-8).sum())
    orb = orthonormalize(orbit_tangent(n, W)).shape[0]
    return th, th / th0, res, orb, dimE, slack(n, W, A, N)

if __name__ == "__main__":
    print(f"{'blocks':>14} {'n':>3} {'theta':>12} {'th/th0':>8} {'resid':>9} "
          f"{'orbit':>6} {'dimE':>6} {'nondeg':>7} {'slack S':>10}")
    for blocks in [(3, 3, 3)]:
        r = analyse(blocks)
        if r is None:
            print(f"{str(blocks):>14}  no symmetric solution"); continue
        th, ratio, res, orb, dimE, S = r
        print(f"{'x'.join('S^%d' % b for b in blocks):>14} {sum(blocks):3d} {th:12.9f} "
              f"{ratio:8.4f} {res:9.1e} {orb:6d} {dimE:6d} {str(dimE == orb):>7} {S:10.2e}",
              flush=True)
