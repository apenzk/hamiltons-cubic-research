"""The excess at the balanced sphere product: is it Morse-Bott nondegenerate at n = 12?

The excess is the count of exact 1/2-eigenvalues of L_e on W-perp, minus the orbit dimension.
Zero excess means the kernel of 2 L_D - theta off the diagonal locus is EXACTLY the orbit tangent,
which is the one hypothesis of the quantitative-isolation route: the off-diagonal part of
criticality reads (2 L_D - theta) N = -pi_perp(N o N), so an invertible linear part transverse to
the orbit forces |N| <= C |N|^2, hence N = 0 or |N| >= 1/C.

It is also R11's long-awaited object, and the record has it measured nowhere.

Screening only, on objects in hand: the route's hypothesis is decided by the count, not by the
script. Run at n = 6 and n = 8 first, where the answer is already known from an earlier screen
(excess 9 and 0), so a disagreement there is a bug rather than a finding.
"""
import sys
import time
import numpy as np
sys.path.insert(0, "scripts/lib")
from g1_le_machinery import weyl_basis, Le_matrix


def ip(a, b):
    return float(np.sum(a * b))


def balanced(n, N, idx):
    p = n // 2
    lam = np.zeros(N)
    for a, (i, j) in enumerate(idx):
        lam[a] = 1 / (p * (p - 1)) if (i < p) == (j < p) else -1 / (p * p)
    W = np.diag(lam)
    return W / np.sqrt(ip(W, W))


def orbit_dim(n):
    """dim so(n) - dim(stabiliser of the balanced product) = dim so(n) - 2 dim so(n/2)."""
    p = n // 2
    return n * (n - 1) // 2 - 2 * (p * (p - 1) // 2)


def run(n, tol=1e-8):
    t0 = time.time()
    N, c, L2, alt_idx, B = weyl_basis(n)
    idx = [(i, j) for i in range(n) for j in range(i + 1, n)]
    W = balanced(n, N, idx)
    # theta and criticality, from the structure constants alone
    Se = np.einsum('amn,np->amp', c, W, optimize=True)
    Wsharp = -0.5 * np.einsum('amp,bpm->ab', Se, Se, optimize=True)
    Q = W @ W + Wsharp
    th = ip(W, Q)
    res = np.sqrt(ip(Q - th * W, Q - th * W))
    e = W / th
    Le = Le_matrix(e, np.array(B), c)
    ev = np.linalg.eigvalsh(Le)
    # the eigenvalue 1 is the direction W itself; count halves on the whole space
    halves = int(np.sum(np.abs(ev - 0.5) < tol))
    d = orbit_dim(n)
    print(f"n={n:3d}  dim W_n={len(B):5d}  theta={th:.9f}  residual={res:.2e}  "
          f"({time.time()-t0:.0f}s)")
    print(f"        half-eigenvalues of L_e: {halves}   orbit dimension: {d}   "
          f"EXCESS = {halves - d}")
    print(f"        spectrum: min={ev.min():+.6f}  max={ev.max():+.6f}  "
          f"count(>1/2+tol) = {int(np.sum(ev > 0.5 + tol))}")
    return halves - d


if __name__ == "__main__":
    for n in (6, 8, 12):
        run(n)
