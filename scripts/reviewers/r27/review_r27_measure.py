"""Reviewer 27: the L_e measurement, independently."""
import numpy as np
import review_r27_core as C


def Le_matrix(n, e, basis=None):
    """Matrix of L_e = e o (.) in an orthonormal basis of the Weyl space."""
    B = C.weyl_basis(n) if basis is None else basis
    A = C.Aops(n)
    N = A.shape[0]
    Af = A.reshape(N * N, N)
    Ue = (Af @ e).reshape(N, N, N)            # U[a] = A_a e
    Uef = Ue.reshape(N, N * N)
    out = np.empty((B.shape[0], N, N))
    for k, Y in enumerate(B):
        V = (Af @ Y).reshape(N, N, N)          # V[b] = A_b Y
        M = Uef @ np.transpose(V, (0, 2, 1)).reshape(N, N * N).T   # tr(A_a e A_b Y)
        M = -0.5 * M
        M = 0.5 * (M + M.T)
        out[k] = 0.5 * (e @ Y + Y @ e) + M
    L = np.einsum('kab,lab->kl', B, out)
    return 0.5 * (L + L.T), B


def analyse(n, W, name, want_vecs=False):
    QW = C.Q(n, W)
    nrm = np.sqrt(np.trace(W @ W))
    theta = float(np.trace(W @ QW)) / nrm**2
    res = np.linalg.norm(QW - theta * W)
    pr, idx, c = C.struct(n)
    ricn = np.abs(C.ricci(W, n, idx)).max()
    altn = C.alt_norm(W, n, idx)
    e = W / theta
    L, B = Le_matrix(n, e)
    coW = np.einsum('kab,ab->k', B, W / nrm)
    # restrict to W-perp inside Weyl
    dim = L.shape[0]
    Pperp = np.eye(dim) - np.outer(coW, coW)
    # orthonormal basis of W-perp
    u, s, vt = np.linalg.svd(Pperp)
    K = u[:, :dim - 1]
    Lp = K.T @ L @ K
    ev = np.linalg.eigvalsh(Lp)
    out = dict(name=name, n=n, theta=theta, res=res, ric=ricn, alt=altn,
               lam_max=ev[-1], lam_min=ev[0], ev=ev, L=L, B=B, e=e, coW=coW, K=K,
               LW=float(coW @ L @ coW))
    if want_vecs:
        w, V = np.linalg.eigh(Lp)
        out['evecs'] = K @ V
        out['evals'] = w
    return out


def gradedness(n, W, tol=1e-9):
    """S_mmm = sum over an orthonormal basis of m of <[x,y],z>^2, m = negative eigenspace."""
    pr, idx, c = C.struct(n)
    ev, U = np.linalg.eigh(W)
    neg = U[:, ev < -tol]
    cm = np.einsum('abg,ai,bj,gk->ijk', c, neg, neg, neg)
    return float((cm**2).sum()), neg, U, ev
