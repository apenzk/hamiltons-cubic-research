"""r332 core: so(n) machinery rebuilt from definitions. Independent of the record's scripts.

Conventions:
  so(n) basis e_ij (i<j), matrices E_ij - E_ji, orthonormal under <A,B> = -1/2 tr(AB).
  Curvature 4-tensor R_ijkl with pair symmetry; operator (R phi)_ij = 1/2 sum_kl R_ijkl phi_kl.
  W# by polarization: (W#)_kl = -1/2 tr(ad(u_k) W ad(u_l) W)  (W as operator matrix, ad on coords).
  Q(W) = W^2 + W#, criticality Q(W) = theta W.
"""
import numpy as np
from itertools import combinations


def basis_so(n):
    idx = list(combinations(range(n), 2))
    mats = []
    for (i, j) in idx:
        m = np.zeros((n, n))
        m[i, j] = 1.0
        m[j, i] = -1.0
        mats.append(m)
    return idx, mats


def ip(a, b):
    return -0.5 * np.trace(a @ b)


def vec(m, mats):
    return np.array([ip(m, b) for b in mats])


def ad_matrices(mats):
    """ad(b_a) as N x N matrices on so(n) coordinates: ad[a][c,b] = <[b_a, b_b], b_c>."""
    N = len(mats)
    ads = []
    for a in range(N):
        A = np.zeros((N, N))
        for b in range(N):
            br = mats[a] @ mats[b] - mats[b] @ mats[a]
            A[:, b] = [ip(br, mats[c]) for c in range(N)]
        ads.append(A)
    return ads


def op_from_R4(R4, idx):
    """Operator on the e_ij basis from a 4-tensor: W_{(ij),(kl)} = R_ijkl."""
    N = len(idx)
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(idx):
        for b, (k, l) in enumerate(idx):
            W[a, b] = R4[i, j, k, l]
    return W


def R4_sphere_product(p, q, kap1, kap2):
    n = p + q
    R4 = np.zeros((n, n, n, n))
    for i in range(n):
        for j in range(n):
            if i == j:
                continue
            if i < p and j < p:
                k = kap1
            elif i >= p and j >= p:
                k = kap2
            else:
                k = 0.0
            R4[i, j, i, j] += k
            R4[i, j, j, i] -= k
    return R4


def kn(h, g):
    """Kulkarni-Nomizu product as 4-tensor."""
    n = h.shape[0]
    T = np.zeros((n, n, n, n))
    for i in range(n):
        for j in range(n):
            for k in range(n):
                for l in range(n):
                    T[i, j, k, l] = (h[i, k] * g[j, l] - h[i, l] * g[j, k]
                                     + g[i, k] * h[j, l] - g[i, l] * h[j, k])
    return T


def weyl_project_R4(R4):
    n = R4.shape[0]
    g = np.eye(n)
    Ric = np.einsum('ijkj->ik', R4)
    s = np.trace(Ric)
    Ric0 = Ric - s / n * g
    W4 = R4 - kn(Ric0, g) / (n - 2) - s * kn(g, g) / (2 * n * (n - 1))
    return W4


def sharp(W, ads):
    N = W.shape[0]
    AW = [ads[k] @ W for k in range(N)]
    S = np.zeros((N, N))
    for k in range(N):
        for l in range(k, N):
            S[k, l] = S[l, k] = -0.5 * np.trace(AW[k] @ AW[l])
    return S


def theta_crit(W, ads):
    """Return (theta, criticality residual) for unit-norm symmetric W."""
    Q = W @ W + sharp(W, ads)
    th = np.sum(Q * W) / np.sum(W * W)
    res = np.linalg.norm(Q - th * W)
    return th, res


def eig_and_T(W, ads, mats):
    """Eigen-decomposition and squared structure constants T_abc in W's eigenbasis."""
    lam, U = np.linalg.eigh(W)  # columns of U: eigenvectors in e-basis coords
    N = len(lam)
    # c_abc = <[u_a,u_b],u_c>; using ad-matrices on coordinates: [u_a, u_b] = sum coords
    # bracket of coordinate vectors: [x, y]_c = sum_a x_a (ads[a] y)_c
    brack = np.zeros((N, N, N))
    for a in range(N):
        Ma = sum(U[i, a] * ads[i] for i in range(N))  # ad(u_a) on coords
        vb = Ma @ U  # columns: [u_a, u_b] in coords
        brack[a] = (U.T @ vb).T  # brack[a][b,c] = <[u_a,u_b],u_c>
    T = brack ** 2
    return lam, U, T


def rows_ABC(lam, T):
    """Per-index row sums: A_k, B_k, C_k."""
    A = np.einsum('kbc->k', T)
    B = np.einsum('b,kbc->k', lam, T)
    C = np.einsum('b,c,kbc->k', lam, lam, T)
    return A, B, C


def g_dist(lam, T):
    d = lam[:, None] - lam[None, :]
    return np.einsum('bc,kbc->k', d ** 2, T)


def S22_of(lam, T):
    return np.einsum('a,b,abc->', lam ** 2, lam ** 2, T)


def padded_cp2(n, idx):
    """Padded W_CP2: spectrum (2,-1,-1,0,...)/sqrt6 on the so(4)-block self-dual frame."""
    N = len(idx)

    def unit(coords):
        v = np.zeros(N)
        for (pair, c) in coords:
            v[idx.index(pair)] = c
        return v / np.linalg.norm(v)

    om = unit([((0, 1), 1.0), ((2, 3), 1.0)])
    x2 = unit([((0, 2), 1.0), ((1, 3), -1.0)])
    x3 = unit([((0, 3), 1.0), ((1, 2), 1.0)])
    W = (2.0 * np.outer(om, om) - np.outer(x2, x2) - np.outer(x3, x3)) / np.sqrt(6.0)
    return W
