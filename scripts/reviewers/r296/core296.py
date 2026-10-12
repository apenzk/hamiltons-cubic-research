"""Reviewer 296: machinery rebuilt from the definitions, sharing no code with scripts/lib.

  Lambda^2 R^n, basis phi_{ij} = E_ij - E_ji (i<j), <X,Y> = 1/2 tr(X^T Y) -> orthonormal.
  c_{abg} = <[phi_a,phi_b],phi_g>;  (A_a)_{mn} = c_{amn};
  (W^#)_{ab} = -1/2 tr(A_a W A_b W);  Q(W) = W^2 + W^#;  P(W) = <W, Q(W)> = tr(W Q(W)).
  Weyl_n = {W symmetric on Lambda^2 : first Bianchi = 0, Ricci = 0}.

Everything below is written from those lines; nothing is imported from scripts/lib.
"""
import functools
import itertools
import numpy as np


def pairs_of(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]


@functools.lru_cache(maxsize=None)
def _phi(n):
    prs = pairs_of(n)
    P = np.zeros((len(prs), n, n))
    for a, (i, j) in enumerate(prs):
        P[a, i, j] = 1.0
        P[a, j, i] = -1.0
    return P


@functools.lru_cache(maxsize=None)
def cst(n):
    """c[a,b,g] = <[phi_a,phi_b], phi_g>."""
    P = _phi(n)
    N = P.shape[0]
    c = np.zeros((N, N, N))
    for a in range(N):
        comm = P[a] @ P - P @ P[a]
        c[a] = 0.5 * np.einsum('bij,gij->bg', comm, P)
    return c


def ad(n):
    return cst(n)


def sharp(n, W):
    A = ad(n)
    N = A.shape[0]
    # (W^#)_ab = -1/2 tr(A_a W A_b W); same formula, BLAS-shaped
    AW = (A.reshape(N * N, N) @ W).reshape(N, N, N)
    return -0.5 * (AW.reshape(N, N * N) @ AW.transpose(0, 2, 1).reshape(N, N * N).T)


def sharp_bil(n, X, Y):
    """1/2[(X+Y)^# - X^# - Y^#] = -1/4 (T_ab + T_ba), T_ab = tr(A_a X A_b Y)."""
    A = ad(n)
    N = A.shape[0]
    AX = (A.reshape(N * N, N) @ X).reshape(N, N, N)
    AY = (A.reshape(N * N, N) @ Y).reshape(N, N, N)
    T = AX.reshape(N, N * N) @ AY.transpose(0, 2, 1).reshape(N, N * N).T
    return -0.25 * (T + T.T)


def Q(n, W):
    return W @ W + sharp(n, W)


def theta_of(n, W):
    return float(np.tensordot(W, Q(n, W)))


# ---- the 4-tensor and the Weyl conditions, from R_{ijkl} directly ----

def tensor4(n, W):
    """R[i,j,k,l] with R = W in the pair basis, antisymmetrised in (ij) and (kl)."""
    prs = pairs_of(n)
    idx = {p: a for a, p in enumerate(prs)}
    R = np.zeros((n, n, n, n))
    for (i, j) in prs:
        for (k, l) in prs:
            v = W[idx[(i, j)], idx[(k, l)]]
            for si, (a, b) in ((1, (i, j)), (-1, (j, i))):
                for sk, (c, d) in ((1, (k, l)), (-1, (l, k))):
                    R[a, b, c, d] = si * sk * v
    return R


def weyl_residuals(n, W):
    """(max |Bianchi|, max |Ricci|, |trace|) computed from the 4-tensor."""
    R = tensor4(n, W)
    B = R + np.transpose(R, (0, 2, 3, 1)) + np.transpose(R, (0, 3, 1, 2))
    ric = np.einsum('ijkj->ik', R)
    return (float(np.abs(B).max()), float(np.abs(ric).max()),
            float(abs(np.trace(W))))


@functools.lru_cache(maxsize=None)
def weyl_basis(n):
    """orthonormal basis of Weyl_n as (d, N, N), by nullspace of the linear conditions."""
    prs = pairs_of(n)
    N = len(prs)
    # coordinates: symmetric N x N, orthonormal basis
    S = []
    for a in range(N):
        E = np.zeros((N, N)); E[a, a] = 1.0; S.append(E)
    for a in range(N):
        for b in range(a + 1, N):
            E = np.zeros((N, N)); E[a, b] = E[b, a] = 1 / np.sqrt(2.0); S.append(E)
    S = np.array(S)
    rows = []
    for E in S:
        bi, ri, _ = None, None, None
        R = tensor4(n, E)
        Bt = R + np.transpose(R, (0, 2, 3, 1)) + np.transpose(R, (0, 3, 1, 2))
        bvals = [Bt[i, j, k, l] for (i, j, k, l) in itertools.combinations(range(n), 4)]
        rvals = np.einsum('ijkj->ik', R)[np.triu_indices(n)]
        rows.append(np.concatenate([np.array(bvals), rvals]))
    M = np.array(rows).T                       # (conds, D)
    u, s, vt = np.linalg.svd(M, full_matrices=True)
    tol = max(M.shape) * s[0] * 1e-12
    r = int((s > tol).sum())
    ns = vt[r:]
    return np.einsum('kd,dij->kij', ns, S)


def graded_split(n, p):
    prs = pairs_of(n)
    Pi = [a for a, (i, j) in enumerate(prs) if (i < p) == (j < p)]
    Mi = [a for a, (i, j) in enumerate(prs) if (i < p) != (j < p)]
    return np.array(Pi), np.array(Mi)


def block_basis(n, p):
    """orthonormal basis of {W in Weyl_n : W(p) in p, W(m) in m}, by projection+nullspace."""
    B = weyl_basis(n)
    Pi, Mi = graded_split(n, p)
    N = B.shape[1]
    off = np.ones((N, N), dtype=bool)
    off[np.ix_(Pi, Pi)] = False
    off[np.ix_(Mi, Mi)] = False
    # the block-diagonal subspace is the kernel of "restrict to the off-blocks"
    C = B.reshape(B.shape[0], -1)[:, off.reshape(-1)]      # (d, offdim)
    u, s, vt = np.linalg.svd(C, full_matrices=True)
    tol = max(C.shape) * (s[0] if s.size else 1.0) * 1e-12
    r = int((s > tol).sum())
    K = vt[r:] if C.shape[0] > r else np.zeros((0, C.shape[0]))
    # kernel vectors live in coefficient space of B -> u's complement
    # careful: svd of C (d x offdim): left singular vectors span coefficient space
    ker = u[:, r:].T if u.shape[1] >= B.shape[0] else None
    if ker is None or ker.shape[0] != B.shape[0] - r:
        # fall back: nullspace of C^T acting on coefficients
        uu, ss, vv = np.linalg.svd(C.T, full_matrices=True)
        rr = int((ss > tol).sum())
        ker = vv[rr:]
    return np.einsum('kd,dij->kij', ker, B), Pi, Mi
