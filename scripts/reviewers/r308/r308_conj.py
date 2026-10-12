"""r308: conjugate the n=8 witness so its grading becomes the COORDINATE so(3)+so(5)."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
import r308_lib as L


def lam2(g, idx):
    N = len(idx)
    M = np.zeros((N, N))
    for a, (k, l) in enumerate(idx):
        for b, (i, j) in enumerate(idx):
            M[a, b] = g[k, i] * g[l, j] - g[l, i] * g[k, j]
    return M


def to_mat(vec, idx, n):
    M = np.zeros((n, n))
    for a, (i, j) in enumerate(idx):
        M[i, j] += vec[a]; M[j, i] -= vec[a]
    return M


def align(n, W, ptarget_dim):
    idx, pos, N, c = L.struct(n)
    lam, V = np.linalg.eigh(W)
    P = V[:, lam > 1e-9]
    Xs = [to_mat(P[:, k], idx, n) for k in range(P.shape[1])]
    A = np.vstack([np.kron(X, np.eye(n)) - np.kron(np.eye(n), X.T) for X in Xs])
    U, s, Vt = np.linalg.svd(A)
    ns = Vt[int((s > 1e-9 * s[0]).sum()):]
    G = sum(np.random.default_rng(3).normal() * ns[k].reshape(n, n)
            for k in range(ns.shape[0]))
    G = (G + G.T) / 2
    ev, EV = np.linalg.eigh(G)
    import collections
    cnt = collections.Counter(np.round(ev, 7))
    small = [v for v in cnt if cnt[v] == ptarget_dim][0]
    cols = [EV[:, k] for k in range(n) if abs(round(ev[k], 7) - small) < 1e-9]
    rest = [EV[:, k] for k in range(n) if abs(round(ev[k], 7) - small) >= 1e-9]
    g = np.array(cols + rest).T          # maps coordinate frame -> invariant frame
    g = np.linalg.qr(g)[0]
    if np.linalg.det(g) < 0:
        g[:, -1] *= -1
    Lg = lam2(g.T, idx)                  # conjugate W by g^{-1}
    return Lg @ W @ Lg.T, idx
