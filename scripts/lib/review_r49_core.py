"""Reviewer 49: independent machinery for the block-sum-law audit.

Written from the definitions in the brief, sharing no code with scripts/b_*.py or
scripts/review_r*.py.

  Lambda^2 R^n has orthonormal basis phi_{ij} = E_ij - E_ji (i<j) under
  <X,Y> = 1/2 tr(X^T Y).
  Structure constants come from the closed bracket formula
      [phi_ij, phi_kl] = d_jk phi_il + d_il phi_jk - d_jl phi_ik - d_ik phi_jl
  rather than from matrix commutators, so the two implementations agree only if
  both are right.
  (A_a)_{mn} = c_{amn},  (W^#)_{ab} = -1/2 tr(A_a W A_b W),  Q(W) = W^2 + W^#,
  P(W) = <W, Q(W)> (Frobenius on the N x N matrix of W).
  Weyl_n = {W in Sym^2(Lambda^2) : Ricci(W) = 0, first Bianchi = 0}.
"""
import functools
import itertools

import numpy as np


def pairs_of(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]


@functools.lru_cache(maxsize=None)
def pindex(n):
    ps = pairs_of(n)
    return ps, {p: a for a, p in enumerate(ps)}


def _sgn_idx(idx, i, j):
    """index and sign of phi_{ij} for arbitrary i != j."""
    if i < j:
        return idx[(i, j)], 1.0
    return idx[(j, i)], -1.0


@functools.lru_cache(maxsize=None)
def struct(n):
    """c[a,b,g] = <[phi_a, phi_b], phi_g>, built from the bracket formula."""
    ps, idx = pindex(n)
    N = len(ps)
    c = np.zeros((N, N, N))
    for a, (i, j) in enumerate(ps):
        for b, (k, l) in enumerate(ps):
            # [phi_ij, phi_kl] = d_jk phi_il + d_il phi_jk - d_jl phi_ik - d_ik phi_jl
            for cond, (p, q) in ((j == k, (i, l)), (i == l, (j, k))):
                if cond and p != q:
                    g, s = _sgn_idx(idx, p, q)
                    c[a, b, g] += s
            for cond, (p, q) in ((j == l, (i, k)), (i == k, (j, l))):
                if cond and p != q:
                    g, s = _sgn_idx(idx, p, q)
                    c[a, b, g] -= s
    return c


@functools.lru_cache(maxsize=None)
def Amats(n):
    """A[a][m,n] = c[a,m,n]."""
    return struct(n)


def sharp(n, W):
    A = Amats(n)
    N = A.shape[0]
    AW = A @ W                       # AW[a] = A_a W
    return -0.5 * np.einsum('apq,bqp->ab', AW, AW, optimize=True)


def sharp_polar(n, X, Y):
    """1/2[(X+Y)^# - X^# - Y^#]."""
    A = Amats(n)
    AX = A @ X
    AY = A @ Y
    T = np.einsum('apq,bqp->ab', AX, AY, optimize=True)
    return -0.25 * (T + T.T)


def Qmap(n, W):
    return W @ W + sharp(n, W)


def circ(n, X, Y):
    return 0.5 * (X @ Y + Y @ X) + sharp_polar(n, X, Y)


def Pval(n, W):
    return float(np.sum(W * Qmap(n, W)))


def fro(X, Y=None):
    if Y is None:
        Y = X
    return float(np.sum(X * Y))


# ---------------- Weyl space ----------------

def Rget(W, idx, i, j, k, l):
    if i == j or k == l:
        return 0.0
    s = 1.0
    if i > j:
        i, j, s = j, i, -s
    if k > l:
        k, l, s = l, k, -s
    return s * W[idx[(i, j)], idx[(k, l)]]


def ricci(n, W):
    ps, idx = pindex(n)
    R = np.zeros((n, n))
    for i in range(n):
        for k in range(n):
            R[i, k] = sum(Rget(W, idx, i, j, k, j) for j in range(n))
    return R


def bianchi(n, W):
    """b[i,j,k,l] = R_ijkl + R_iklj + R_iljk over 4-subsets."""
    ps, idx = pindex(n)
    out = []
    for (i, j, k, l) in itertools.combinations(range(n), 4):
        out.append(Rget(W, idx, i, j, k, l) + Rget(W, idx, i, k, l, j) + Rget(W, idx, i, l, j, k))
    return np.array(out) if out else np.zeros(0)


@functools.lru_cache(maxsize=None)
def weyl_basis(n):
    """Orthonormal (Frobenius) basis of Weyl_n, shape (d, N, N).

    Built by projecting a symmetric-matrix basis onto the joint kernel of the
    Bianchi and Ricci linear functionals.
    """
    ps, idx = pindex(n)
    N = len(ps)
    # symmetric basis, orthonormal in Frobenius
    S = []
    for a in range(N):
        E = np.zeros((N, N))
        E[a, a] = 1.0
        S.append(E)
    for a in range(N):
        for b in range(a + 1, N):
            E = np.zeros((N, N))
            E[a, b] = E[b, a] = 1.0 / np.sqrt(2.0)
            S.append(E)
    S = np.array(S)
    rows = []
    for E in S:
        rows.append(np.concatenate([bianchi(n, E), ricci(n, E)[np.triu_indices(n)]]))
    M = np.array(rows).T                      # (constraints, D)
    u, s, vt = np.linalg.svd(M, full_matrices=True)
    tol = max(M.shape) * (s[0] if s.size else 1.0) * 1e-12
    rank = int((s > tol).sum())
    ns = vt[rank:]
    return np.einsum('kd,dij->kij', ns, S)


def dim_weyl(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12


def project_weyl(n, X):
    B = weyl_basis(n)
    co = np.einsum('kij,ij->k', B, X)
    return np.einsum('k,kij->ij', co, B)


# ---------------- known operators ----------------

def sphere_product(blocks):
    """Weyl operator of a Ricci-flat-scaled product of round spheres.

    Diagonal on coordinate 2-planes: +1/(p(p-1)) inside a block of size p,
    -1/(p q) across blocks of sizes p, q.  Returned unnormalised.
    """
    n = sum(blocks)
    ps, idx = pindex(n)
    lab = []
    for bi, b in enumerate(blocks):
        lab += [bi] * b
    W = np.zeros((len(ps), len(ps)))
    for a, (i, j) in enumerate(ps):
        if lab[i] == lab[j]:
            p = blocks[lab[i]]
            W[a, a] = 1.0 / (p * (p - 1))
        else:
            p, q = blocks[lab[i]], blocks[lab[j]]
            W[a, a] = -1.0 / (p * q)
    return W


def fox_cp2(n=4, coords=(0, 1, 2, 3)):
    """The self-dual Weyl operator of CP^2 in dimension 4, embedded on `coords`.

    Built from the self-dual 2-forms of the 4-plane, eigenvalues (2,-1,-1)/sqrt6
    on Lambda^+ and 0 on Lambda^-.  Unit norm.
    """
    ps, idx = pindex(n)
    N = len(ps)
    a, b, c, d = coords
    trip = [((a, b), (c, d)), ((a, c), (d, b)), ((a, d), (b, c))]
    V = []
    for (p, q) in trip:
        v = np.zeros(N)
        g, s = _sgn_idx(idx, *p)
        v[g] += s / np.sqrt(2.0)
        g, s = _sgn_idx(idx, *q)
        v[g] += s / np.sqrt(2.0)
        V.append(v)
    lam = np.array([2.0, -1.0, -1.0]) / np.sqrt(6.0)
    W = sum(l * np.outer(v, v) for l, v in zip(lam, V))
    return W


def normalize(W):
    return W / np.sqrt(fro(W))


def theta_of(n, W):
    W = normalize(W)
    return Pval(n, W)


def crit_residual(n, W):
    W = normalize(W)
    th = Pval(n, W)
    return float(np.linalg.norm(Qmap(n, W) - th * W)), th


# ---------------- embedding / padding ----------------

def embed(Wsmall, nsmall, n, coords):
    """Embed an operator on Lambda^2 R^{nsmall} onto the chosen coordinates of R^n."""
    ps_s, idx_s = pindex(nsmall)
    ps, idx = pindex(n)
    M = np.zeros((len(ps), len(ps)))
    for a, (i, j) in enumerate(ps_s):
        ga, sa = _sgn_idx(idx, coords[i], coords[j])
        for b, (k, l) in enumerate(ps_s):
            gb, sb = _sgn_idx(idx, coords[k], coords[l])
            M[ga, gb] += sa * sb * Wsmall[a, b]
    return M


# ---------------- multiplication operator ----------------

def L_op(n, X):
    """Matrix of Y -> X o Y on Weyl_n, in the orthonormal Weyl basis."""
    B = weyl_basis(n)
    cols = [circ(n, X, E) for E in B]
    return np.array([[fro(B[i], cols[j]) for j in range(len(B))] for i in range(len(B))])
