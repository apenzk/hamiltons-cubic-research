"""Reviewer 65 / C2 adversarial search: hunt for an isotropic subspace of dimension
floor(n^2/4)+1.  Riemannian gradient descent + Adam on the Stiefel manifold with QR
retraction, many random restarts, plus a control run at floor(n^2/4).

This is a control on the proof in review_r65_c2_proof.py: the proof says the search
MUST fail at floor(n^2/4)+1 and MUST succeed at floor(n^2/4).
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from review_r65_lib import structure_tensor, orth, mu


def f_and_grad(V, C):
    D = np.einsum('ijk,ia,jb,kc->abc', C, V, V, V, optimize=True)
    f = (D ** 2).sum()
    G = 6.0 * np.einsum('abc,ijk,jb,kc->ia', D, C, V, V, optimize=True)
    return f, G


def descend(C, d, rng, iters=4000, lr=0.05, seedV=None):
    N = C.shape[0]
    V = orth(rng.standard_normal((N, d))) if seedV is None else seedV
    m1 = np.zeros_like(V); m2 = np.zeros_like(V)
    best = np.inf
    for t in range(1, iters + 1):
        f, G = f_and_grad(V, C)
        best = min(best, f)
        if f < 1e-20:
            break
        G = G - V @ ((V.T @ G + G.T @ V) / 2.0)          # project to Stiefel tangent
        m1 = 0.9 * m1 + 0.1 * G
        m2 = 0.999 * m2 + 0.001 * (G ** 2)
        step = lr * (m1 / (1 - 0.9 ** t)) / (np.sqrt(m2 / (1 - 0.999 ** t)) + 1e-12)
        V = orth(V - step)
    f, _ = f_and_grad(V, C)
    return min(best, f), V


if __name__ == "__main__":
    ns = [int(x) for x in sys.argv[1:]] or [5, 6, 7, 8]
    rng = np.random.default_rng(6565)
    for n in ns:
        C = structure_tensor(n); N = C.shape[0]; cap = n * n // 4
        for d in [cap, cap + 1]:
            if d > N:
                continue
            res = []
            restarts = 60 if n <= 6 else (30 if n == 7 else 15)
            for r in range(restarts):
                f, V = descend(C, d, rng)
                res.append(f)
            res = np.array(res)
            tag = "CAP  " if d == cap else "CAP+1"
            print(f"n={n} N={N} d={d:>3} [{tag}]  best residual = {res.min():.3e}   "
                  f"median = {np.median(res):.3e}   #(<1e-14) = {(res<1e-14).sum()}/{len(res)}",
                  flush=True)
