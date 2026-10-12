"""r282: independent Weyl-tensor toolkit built from the definitions.

Conventions fixed here and cross-checked against scripts/curvature_operator.py:
  Lambda^2 basis E_a, a=(i<j), with E[i,j]=-1, E[j,i]=+1; coefficient basis
  declared orthonormal, so <X,Y> = -1/2 tr(XY).
  A Weyl operator is the symmetric N x N matrix M[(ij),(kl)] = W_ijkl.
  Q(M) = M@M + M^#,  P(M) = <M, Q(M)> = tr(M Q(M)).
"""
import itertools
import numpy as np


def pairs_of(n):
    return list(itertools.combinations(range(n), 2))


def struct_const(n):
    """c[a,b,c] = <[E_a,E_b], E_c> in the coefficient-orthonormal basis."""
    prs = pairs_of(n)
    N = len(prs)
    E = np.zeros((N, n, n))
    for a, (i, j) in enumerate(prs):
        E[a, i, j] = -1.0
        E[a, j, i] = 1.0
    c = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            C = E[a] @ E[b] - E[b] @ E[a]
            # coefficient extraction: coefficient on E_c=(i<j) is C[j,i]
            for cc, (i, j) in enumerate(prs):
                if C[j, i] != 0.0:
                    c[a, b, cc] = C[j, i]
    return c, prs


_CACHE = {}


def cconst(n):
    if n not in _CACHE:
        _CACHE[n] = struct_const(n)
    return _CACHE[n]


def sharp(M, n):
    """(M^#)_ab = 1/2 c_{a g d} c_{b e z} M_{g e} M_{d z}."""
    c, prs = cconst(n)
    N = len(prs)
    out = np.zeros((N, N))
    for a in range(N):
        T = M @ c[a] @ M                      # (e,z)
        out[a] = 0.5 * np.einsum('bez,ez->b', c, T)
    return 0.5 * (out + out.T)


def Q(M, n):
    return M @ M + sharp(M, n)


def P(M, n):
    return float(np.tensordot(M, Q(M, n)))


def norm(M):
    return float(np.sqrt(np.tensordot(M, M)))


# ---------- 4-tensor <-> operator ----------

def op_to_tensor(M, n):
    prs = pairs_of(n)
    idx = {p: a for a, p in enumerate(prs)}
    R = np.zeros((n, n, n, n))
    for (i, j) in prs:
        for (k, l) in prs:
            v = M[idx[(i, j)], idx[(k, l)]]
            R[i, j, k, l] = v
            R[j, i, k, l] = -v
            R[i, j, l, k] = -v
            R[j, i, l, k] = v
    return R


def tensor_to_op(R, n):
    prs = pairs_of(n)
    N = len(prs)
    M = np.zeros((N, N))
    for a, (i, j) in enumerate(prs):
        for b, (k, l) in enumerate(prs):
            M[a, b] = R[i, j, k, l]
    return M


# ---------- projection onto Weyl_n ----------

def project_weyl(R, n):
    """R: any 4-tensor. Returns the Weyl part (curvature symmetries, first
    Bianchi, Ricci-traceless)."""
    # pair antisymmetry + pair exchange
    R = R - np.transpose(R, (1, 0, 2, 3))
    R = R - np.transpose(R, (0, 1, 3, 2))
    R = R + np.transpose(R, (2, 3, 0, 1))
    R = R / 8.0
    # first Bianchi: subtract the totally antisymmetric (Lambda^4) part
    A = (R + np.transpose(R, (0, 2, 3, 1)) + np.transpose(R, (0, 3, 1, 2))) / 3.0
    R = R - A
    # remove Ricci
    ric = np.einsum('ijkj->ik', R)
    scal = np.trace(ric)
    ric0 = ric - (scal / n) * np.eye(n)
    d = np.eye(n)
    kn = (np.einsum('ik,jl->ijkl', ric0, d) + np.einsum('jl,ik->ijkl', ric0, d)
          - np.einsum('il,jk->ijkl', ric0, d) - np.einsum('jk,il->ijkl', ric0, d))
    gg = 2.0 * (np.einsum('ik,jl->ijkl', d, d) - np.einsum('il,jk->ijkl', d, d))
    R = R - kn / (n - 2) - scal / (2.0 * n * (n - 1)) * gg
    return R


def random_weyl(n, rng):
    R = rng.normal(size=(n, n, n, n))
    W = project_weyl(R, n)
    M = tensor_to_op(W, n)
    return M / norm(M)


def support_matrix(M, n):
    R = op_to_tensor(M, n)
    return np.einsum('ijkl,pjkl->ip', R, R)


def support_dim(M, n, tol=1e-9):
    T = support_matrix(M, n)
    ev = np.linalg.eigvalsh(T)
    return int(np.sum(ev > tol * max(1.0, ev.max())))


def pad(M, n, N2):
    """Pad an operator on Lambda^2 R^n into Lambda^2 R^{N2} (first n coords)."""
    prs_s = pairs_of(n)
    prs_b = pairs_of(N2)
    idx_b = {p: a for a, p in enumerate(prs_b)}
    out = np.zeros((len(prs_b), len(prs_b)))
    for a, pa in enumerate(prs_s):
        for b, pb in enumerate(prs_s):
            out[idx_b[pa], idx_b[pb]] = M[a, b]
    return out


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n
