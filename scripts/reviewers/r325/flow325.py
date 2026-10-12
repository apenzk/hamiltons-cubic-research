"""Generate genuine critical points of P on the unit sphere of Weyl_n by projected flow."""
import sys, numpy as np
sys.path.insert(0, 'scripts/reviewers/r325')
import lib325 as L


def make(n):
    fr, sym, unvec, ns = L.weyl_basis(n)
    return fr, sym, unvec, ns


def project(fr, sym, unvec, ns, W):
    """orthogonal projection of a symmetric operator onto Weyl_n."""
    N = fr.N
    x = np.array([W[a, a] if a == b else np.sqrt(2) * W[a, b] for (a, b) in sym])
    return unvec(ns @ (ns.T @ x))


def flow(fr, sym, unvec, ns, W, iters=4000, step=0.35):
    for _ in range(iters):
        G = project(fr, sym, unvec, ns, fr.Q(W))
        th = float(np.tensordot(W, G))
        W = W + step * (G - th * W)
        W = W / np.linalg.norm(W)
    return W
