"""Attacks 5,6,7 (Reviewer 28): critical-point catalogue, L_e spectra, orbit multiplicity, bound."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time, itertools, numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
import review_r28_core as R


# ---------------------------------------------------------------- constructions
def op_from_tensor(n, T):
    prs, idx = R.pair_index(n)
    N = len(prs)
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(prs):
        for b, (k, l) in enumerate(prs):
            W[a, b] = T[i, j, k, l]
    return 0.5 * (W + W.T)


def subalgebra_point(n, blocks):
    prs, idx = R.pair_index(n)
    N = len(prs); P = np.zeros((N, N))
    for k, (i, j) in enumerate(prs):
        for b in blocks:
            if i in b and j in b:
                P[k, k] = 1.0
    r = np.trace(P)
    W = P - (r / N) * np.eye(N)
    return W / np.sqrt(np.trace(W @ W))


def complex_structs(r, kind='C'):
    """J's on R^r (r even for C, r divisible by 4 for H)."""
    m = r // 2
    J1 = np.zeros((r, r))
    for a in range(m):
        J1[2 * a, 2 * a + 1] = 1; J1[2 * a + 1, 2 * a] = -1
    if kind == 'C':
        return [J1]
    q = r // 4
    J1 = np.zeros((r, r)); J2 = np.zeros((r, r)); J3 = np.zeros((r, r))
    E = {}
    for a in range(q):
        s = 4 * a
        # quaternion left multiplication by i, j, k on span(e0,e1,e2,e3)
        for (M, prs_) in ((J1, [(0, 1, 1), (2, 3, 1)]),
                          (J2, [(0, 2, 1), (3, 1, 1)]),
                          (J3, [(0, 3, 1), (1, 2, 1)])):
            for (u, v, sg) in prs_:
                M[s + u, s + v] = sg; M[s + v, s + u] = -sg
    return [J1, J2, J3]


def kahler_type(n, r, kind='C'):
    Js = complex_structs(r, kind)
    T = np.zeros((n, n, n, n))
    d = np.eye(n)
    T += np.einsum('ik,jl->ijkl', d, d) - np.einsum('il,jk->ijkl', d, d)
    for J in Js:
        B = np.zeros((n, n)); B[:r, :r] = J.T
        T += (np.einsum('ik,jl->ijkl', B, B) - np.einsum('il,jk->ijkl', B, B)
              + 2 * np.einsum('ij,kl->ijkl', B, B))
    W = op_from_tensor(n, T)
    W = R.weyl_proj(n, W)
    nrm = np.sqrt(np.trace(W @ W))
    return W / nrm if nrm > 1e-9 else None


# ---------------------------------------------------------------- Newton solver
def crit_resid(n, W):
    Qw = R.Q(n, W)
    th = np.sum(W * Qw)
    return np.linalg.norm(Qw - th * W), th


def newton_crit(n, w0, iters=60, tol=1e-13):
    basis, _, _ = R.weyl_basis(n)
    D = basis.shape[0]
    w = w0 / np.linalg.norm(w0)
    for it in range(iters):
        W = np.einsum('d,dij->ij', w, basis)
        Qw = R.Q(n, W)
        q = np.einsum('ij,dij->d', Qw, basis)
        th = w @ q
        G = q - th * w
        if np.linalg.norm(G) < tol:
            return w, th, np.linalg.norm(G)
        Lm, _ = R.L_matrix(n, W)
        J = 2 * Lm - th * np.eye(D) - 3 * np.outer(w, q)
        # restrict to tangent w^perp
        Pt = np.eye(D) - np.outer(w, w)
        A = Pt @ J @ Pt + np.outer(w, w)   # regularize the w direction
        try:
            v = np.linalg.solve(A, -Pt @ G)
        except np.linalg.LinAlgError:
            v = -np.linalg.lstsq(A, Pt @ G, rcond=None)[0]
        v = Pt @ v
        step = 1.0
        w = w + step * v
        w = w / np.linalg.norm(w)
    W = np.einsum('d,dij->ij', w, basis)
    r, th = crit_resid(n, W)
    return w, th, r


# ---------------------------------------------------------------- orbit
def ad_on_lambda2(n, X):
    P = R.phi_matrices(n)
    adX = np.einsum('ij,bjk->bik', X, P) - np.einsum('bij,jk->bik', P, X)
    return 0.5 * np.einsum('bik,aik->ab', adX, P)


_AD = {}
def orbit_tangent(n, W):
    """Span of {A_X W + W A_X^T : X in so(n)} inside Weyl_n, as coefficient vectors."""
    if n not in _AD:
        gens = []
        for i in range(n):
            for j in range(i + 1, n):
                X = np.zeros((n, n)); X[i, j] = 1; X[j, i] = -1
                gens.append(ad_on_lambda2(n, X))
        _AD[n] = np.array(gens)
    A = _AD[n]
    imgs = np.einsum('gab,bc->gac', A, W) + np.einsum('ab,gcb->gac', W, A)
    basis, _, _ = R.weyl_basis(n)
    V = np.einsum('gac,dac->gd', imgs, basis)
    return V


def orbit_dim(n, W):
    V = orbit_tangent(n, W)
    s = np.linalg.svd(V, compute_uv=False)
    return int((s > 1e-8 * max(1.0, s[0])).sum()), V


# ---------------------------------------------------------------- analysis
def analyse(n, W, name):
    res, th = crit_resid(n, W)
    if abs(th) < 1e-9:
        return None
    e = W / th
    Lm, _ = R.L_matrix(n, e)
    Lm = 0.5 * (Lm + Lm.T)
    ev = np.linalg.eigvalsh(Lm)
    od, Vorb = orbit_dim(n, W)
    D = len(ev)
    kappa = (2 * n - 1) * (n - 1) / 4.0
    s2 = np.square(ev).sum()
    mult_half = int((np.abs(ev - 0.5) < 1e-7).sum())
    mult_one = int((np.abs(ev - 1.0) < 1e-7).sum())
    return dict(name=name, n=n, D=D, theta=th, resid=res, orb=od, ev=ev,
                s1=ev.sum(), s2=s2, s3=(ev ** 3).sum(), T3=th * th * s2, kappa=kappa,
                mhalf=mult_half, mone=mult_one, top=ev[-1])
