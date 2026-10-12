"""Reviewer 105 core: built from the brief's definitions only.

W in Weyl space: Riemann symmetries + first Bianchi + totally trace-free.
M on Lambda^2: M[(i<j),(k<l)] = W_ijkl, normalised ||M||_F = 1.
theta = tr(M^3) + <M#,M>, # in the UNNORMALISED phi_ij = E_ij - E_ji basis
        => (M#)_ijkl = sum_{p,q} (W_ipkq W_jplq - W_iplq W_jpkq)
K_ab = W_abab (vertex matrix), t = ||K||_F^2.
"""
import numpy as np
import itertools


def pairs(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]


def sym_pair_project(T):
    """Impose Riemann symmetries: antisym in (ij),(kl); sym under pair swap."""
    T = 0.5 * (T - np.transpose(T, (1, 0, 2, 3)))
    T = 0.5 * (T - np.transpose(T, (0, 1, 3, 2)))
    T = 0.5 * (T + np.transpose(T, (2, 3, 0, 1)))
    return T


def bianchi_project(T):
    """T in Sym^2(Lambda^2) -> algebraic curvature tensor (first Bianchi)."""
    T = sym_pair_project(T)
    b = (T + np.transpose(T, (0, 2, 3, 1)) + np.transpose(T, (0, 3, 1, 2))) / 3.0
    return T - b


def ricci(R):
    return np.einsum('ikjk->ij', R)


def kn(A, B):
    """Kulkarni-Nomizu product."""
    return (np.einsum('ik,jl->ijkl', A, B) + np.einsum('jl,ik->ijkl', A, B)
            - np.einsum('il,jk->ijkl', A, B) - np.einsum('jk,il->ijkl', A, B))


def weyl_part(R):
    """Remove traces: W = R - (1/(n-2)) Ric (x) g + scal/(2(n-1)(n-2)) g (x) g."""
    n = R.shape[0]
    g = np.eye(n)
    Ric = ricci(R)
    scal = np.trace(Ric)
    return (R - kn(Ric, g) / (n - 2)
            + scal * kn(g, g) / (2.0 * (n - 1) * (n - 2)))


def random_weyl(n, rng):
    T = rng.standard_normal((n, n, n, n))
    R = bianchi_project(T)
    return weyl_part(R)


def check_weyl(W, tol=1e-10):
    n = W.shape[0]
    errs = {
        'antisym_ij': np.abs(W + np.transpose(W, (1, 0, 2, 3))).max(),
        'antisym_kl': np.abs(W + np.transpose(W, (0, 1, 3, 2))).max(),
        'pairsym': np.abs(W - np.transpose(W, (2, 3, 0, 1))).max(),
        'bianchi': np.abs(W + np.transpose(W, (0, 2, 3, 1))
                          + np.transpose(W, (0, 3, 1, 2))).max(),
        'tracefree': np.abs(ricci(W)).max(),
    }
    return errs


def M_of(W):
    n = W.shape[0]
    P = pairs(n)
    return np.array([[W[i, j, k, l] for (k, l) in P] for (i, j) in P])


def normalise(W):
    return W / np.linalg.norm(M_of(W))


def sharp(W):
    """(M#)_ijkl = sum_{p,q} (W_ipkq W_jplq - W_iplq W_jpkq)."""
    A = np.einsum('ipkq,jplq->ijkl', W, W)
    B = np.einsum('iplq,jpkq->ijkl', W, W)
    return A - B


def theta(W):
    M = M_of(W)
    S = sharp(W)
    MS = M_of(S)
    return np.trace(M @ M @ M) + float(np.sum(MS * M))


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n


def vertex_matrix(W):
    n = W.shape[0]
    K = np.array([[W[a, b, a, b] for b in range(n)] for a in range(n)])
    np.fill_diagonal(K, 0.0)
    return K


# ---------- named tensors ----------

def sphere_product(p, q):
    """R of S^p(1) x S^q(1): R_abab = 1 within a block, 0 across."""
    n = p + q
    R = np.zeros((n, n, n, n))
    blk = [0] * p + [1] * q
    for a in range(n):
        for b in range(n):
            if a != b and blk[a] == blk[b]:
                R[a, b, a, b] = 1.0
                R[a, b, b, a] = -1.0
    return weyl_part(R)


def cpm(m, n=None):
    """Fubini-Study curvature on CP^m (real dim 2m), holomorphic sec curv 4,
    zero-padded into dimension n >= 2m."""
    d = 2 * m
    J = np.zeros((d, d))
    for k in range(m):
        J[2 * k, 2 * k + 1] = 1.0
        J[2 * k + 1, 2 * k] = -1.0
    g = np.eye(d)
    R = kn(g, g) / 2.0 + (np.einsum('ik,jl->ijkl', J, J)
                          - np.einsum('il,jk->ijkl', J, J)
                          + 2 * np.einsum('ij,kl->ijkl', J, J))
    W = weyl_part(R)
    if n is None or n == d:
        return W
    Wn = np.zeros((n, n, n, n))
    Wn[:d, :d, :d, :d] = W
    return Wn


# ---------- the two spectra ----------

def s2_basis(n):
    """Orthonormal basis of trace-free symmetric 2-tensors:
    phi_ab = (E_ab+E_ba)/sqrt2 for a<b, then n-1 diagonal trace-free."""
    B = []
    for (a, b) in pairs(n):
        E = np.zeros((n, n))
        E[a, b] = E[b, a] = 1 / np.sqrt(2)
        B.append(E)
    # diagonal trace-free: Gram-Schmidt on 1^perp
    V = np.zeros((n, n - 1))
    for k in range(n - 1):
        v = np.zeros(n)
        v[:k + 1] = 1.0
        v[k + 1] = -(k + 1.0)
        V[:, k] = v / np.linalg.norm(v)
    for k in range(n - 1):
        B.append(np.diag(V[:, k]))
    return B


def Wring(W):
    """(W h)_ij = sum_kl W_iklj h_kl on S^2_0, as a matrix in s2_basis."""
    n = W.shape[0]
    B = s2_basis(n)
    N = len(B)
    A = np.zeros((N, N))
    for a, h in enumerate(B):
        Hh = np.einsum('iklj,kl->ij', W, h)
        for b, e in enumerate(B):
            A[b, a] = float(np.sum(Hh * e))
    return A


def spectra(W):
    """mu = spec(M) on Lambda^2, omega = spec(Wring) on S^2_0."""
    mu = np.linalg.eigvalsh(M_of(W))
    om = np.linalg.eigvalsh(Wring(W))
    return mu, om


def p3(x):
    return float(np.sum(np.asarray(x) ** 3))
