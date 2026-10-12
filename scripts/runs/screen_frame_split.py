"""Gate 1 screen for Lemma L214, the frame split.

Two exact relations and one maximiser inequality, checked at a critical point whose L24 cap is on
the record, in random orthonormal frames. Exact only up to floating point: the point is that the
identities hold to machine precision in EVERY frame, which is what distinguishes them from a
statement about the eigenframe.

  theta t     = P(D) + a          with a = <L_D N, N>
  theta (1-t) = 2a + P(N)
  a >= (theta/2) t (1-t)          at a maximiser

Screening only, seconds of compute: the lemma is the derivation.
"""
import sys
import numpy as np
sys.path.insert(0, "scripts/lib")
from weyl import build_structure_constants
from rsharp_basis_free import Q_full


def ip(a, b):
    return float(np.sum(a * b))


def balanced(n, idx, N):
    """The balanced sphere product's Weyl operator, unit norm, in the pair basis."""
    p = n // 2
    lam = np.zeros(N)
    for a, (i, j) in enumerate(idx):
        lam[a] = 1 / (p * (p - 1)) if (i < p) == (j < p) else -1 / (p * p)
    W = np.diag(lam)
    return W / np.sqrt(ip(W, W))


def lambda2(g, idx, N):
    """The induced action of g in SO(n) on Lambda^2, in the pair basis."""
    G = np.zeros((N, N))
    for a, (i, j) in enumerate(idx):
        for b, (k, l) in enumerate(idx):
            G[a, b] = g[i, k] * g[j, l] - g[i, l] * g[j, k]
    return G


def run(n=8, trials=60, seed=3):
    idx, pos, N, c = build_structure_constants(n)
    Q = lambda M: Q_full(M, c)
    circ = lambda x, y: 0.5 * (Q(x + y) - Q(x) - Q(y))
    P = lambda x: ip(x, Q(x))
    W = balanced(n, idx, N)
    th = P(W)
    res = np.sqrt(ip(Q(W) - th * W, Q(W) - th * W))
    print(f"n={n}: theta = {th:.9f}, criticality residual = {res:.2e}")
    rng = np.random.default_rng(seed)
    worst_id, worst_a, worst_pd, ts = 0.0, -1e9, -1e9, []
    for _ in range(trials):
        g, _ = np.linalg.qr(rng.standard_normal((n, n)))
        G = lambda2(g, idx, N)
        Wg = G @ W @ G.T
        D = np.diag(np.diag(Wg))
        Nn = Wg - D
        t = ip(D, D)
        ts.append(t)
        a = ip(circ(D, Nn), Nn)
        worst_id = max(worst_id, abs(th * t - P(D) - a), abs(th * (1 - t) - 2 * a - P(Nn)))
        worst_a = max(worst_a, (th / 2) * t * (1 - t) - a)
        worst_pd = max(worst_pd, P(D) - (th / 2) * t * (1 + t))
    print(f"  {trials} random frames, t_F in [{min(ts):.3f}, {max(ts):.3f}]")
    print(f"  worst residual of the two relations: {worst_id:.2e}")
    print(f"  worst violation of a >= (theta/2)t(1-t):  {worst_a:+.3e}  (positive would refute)")
    print(f"  worst violation of P(D) <= (theta/2)t(1+t): {worst_pd:+.3e}  (positive would refute)")


if __name__ == "__main__":
    run(8)
    run(6)
