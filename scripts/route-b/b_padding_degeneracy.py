"""Does padding push a degenerate point up towards theta_0?  Measured: no.

Padding freezes theta while theta_0(n) rises, so the worry is a point that is
NONDEGENERATE at its own dimension but degenerate after padding, sitting close to
the top.  Reviewer 44 showed padding can indeed create degeneracy -- the whole
S^2 x S^k family is nondegenerate natively and degenerate at every larger n.

The balanced products, which are the ones that sit closest to theta_0, do not:

    seed          n0->n    theta      theta/theta_0   orbit  dim E(1/2)
    S^4 x S^4      8->10   1.145644      0.9547         32       32     nondegenerate
    S^5 x S^5     10->12   1.200000      0.9708         45       45     nondegenerate
    S^3 x S^3      6->10   1.054093      0.8784         33       42     DEGENERATE

So the degenerate padded points are exactly those already degenerate at their own
dimension, and their theta falls further behind theta_0 with every padding step.

n = 14 IS now reached, by the matrix-free route in b_weyl_projector_free.py:
S^6 x S^6 padded 12->14 sits at 0.9797 theta_0(14), the highest ratio available,
and (L_e - 1/2)^2 off the orbit stays at 1.9e-2 over six starts -- nondegenerate,
in 22 seconds against a nine-minute timeout here.
"""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r30_core import (pair_index, adj, weyl_basis, Q, sphere_product_W,
                             orbit_tangent, orthonormalize)

def pad(Ws, ns, n):
    ps, _ = pair_index(ns); pairs, idx = pair_index(n); N = len(pairs)
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(ps):
        for b, (k, l) in enumerate(ps):
            W[idx[(i, j)], idx[(k, l)]] = Ws[a, b]
    return W / np.linalg.norm(W)

def check(p0, n0, n):
    W0, _ = sphere_product_W(p0); W0 = W0 / np.linalg.norm(W0)
    pairs, idx = pair_index(n); N = len(pairs); A = adj(n)
    W = pad(W0, n0, n); B = weyl_basis(n); D = len(B)
    th = float(np.tensordot(W, Q(n, W))); th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    e = W / th; A2 = A.reshape(N * N, N)
    Ae = (A2 @ e).reshape(N, N, N); AeT = Ae.transpose(0, 2, 1).reshape(N, N * N)
    M = np.zeros((D, D))
    for j, X in enumerate(B):
        AX = (A2 @ X).reshape(N, N, N); T = AX.reshape(N, N * N) @ AeT.T
        M[:, j] = [np.tensordot(b, 0.5 * (e @ X + X @ e) - 0.25 * (T + T.T)) for b in B]
    w = np.linalg.eigvalsh(0.5 * (M + M.T))
    dimE = int((np.abs(w - 0.5) < 1e-8).sum())
    orb = orthonormalize(orbit_tangent(n, W)).shape[0]
    return th, th / th0, orb, dimE

if __name__ == "__main__":
    print(f"{'seed':>10} {'n0->n':>8} {'theta':>10} {'th/th0':>8} {'orbit':>6} {'dimE':>6} {'nondeg':>7}")
    for (p0, n0, n) in [((4, 4), 8, 10), ((5, 5), 10, 12), ((3, 3), 6, 10)]:
        th, r, orb, dimE = check(p0, n0, n)
        print(f"{'S^%dxS^%d' % p0:>10} {'%d->%d' % (n0, n):>8} {th:10.6f} {r:8.4f} "
              f"{orb:6d} {dimE:6d} {str(dimE == orb):>7}", flush=True)
