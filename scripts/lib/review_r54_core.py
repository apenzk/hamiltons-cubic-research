"""Reviewer 54: independent machinery, built from the definitions.

Conventions fixed here and used nowhere else in the repository:
  Lambda^2(R^n) ~ so(n) with basis phi_a = E_{ij} - E_{ji}, a <-> (i<j),
  inner product <X,Y> = (1/2) tr(X^T Y), so <phi_a,phi_b> = delta_ab.
  Structure constants c[a,b,g] = <[phi_a,phi_b], phi_g>.
  W is a symmetric operator on Lambda^2, matrix in the phi basis.
  (W^#)_{ab} = -(1/2) tr(A_a W A_b W) with (A_a)_{mn} = c[a,m,n].
  Q(W) = W W + W^#,  P(W) = <W, Q(W)>,  X o Y = (1/2)(Q(X+Y)-Q(X)-Q(Y)).
  Weyl_n = {W sym : Ric(W) = 0, first Bianchi = 0}.
  S_structural: m = negative eigenspace of W inside so(n) (FUNDAMENTAL rep);
    S = sum_{i<j} |P_m [X_i, X_j]|^2 with X_i an orthonormal basis of m and the
    coefficients taken against the ORTHONORMAL phi basis.
"""
import functools
import itertools

import numpy as np


# ---------------- Lambda^2 and so(n) ----------------

@functools.lru_cache(maxsize=None)
def pairs_of(n):
    ps = tuple((i, j) for i in range(n) for j in range(i + 1, n))
    return ps, {p: a for a, p in enumerate(ps)}


@functools.lru_cache(maxsize=None)
def phi_basis(n):
    """(N, n, n) array of the antisymmetric basis matrices phi_a."""
    ps, _ = pairs_of(n)
    N = len(ps)
    phi = np.zeros((N, n, n))
    for a, (i, j) in enumerate(ps):
        phi[a, i, j] = 1.0
        phi[a, j, i] = -1.0
    return phi


@functools.lru_cache(maxsize=None)
def struct(n):
    """c[a,b,g] = <[phi_a,phi_b], phi_g>, totally antisymmetric."""
    phi = phi_basis(n)
    N = phi.shape[0]
    c = np.zeros((N, N, N))
    for a in range(N):
        comm = phi[a] @ phi - phi @ phi[a]
        c[a] = 0.5 * np.einsum('bij,gij->bg', comm, phi)
    return c


def sharp(n, W):
    c = struct(n)
    N = c.shape[0]
    M = np.einsum('amn,np->amp', c, W, optimize=True)
    return -0.5 * np.einsum('amn,bnm->ab', M, M, optimize=True)


def sharp_bilin(n, X, Y):
    c = struct(n)
    AX = np.einsum('amn,np->amp', c, X, optimize=True)
    AY = np.einsum('amn,np->amp', c, Y, optimize=True)
    T = np.einsum('amn,bnm->ab', AX, AY, optimize=True)
    return -0.25 * (T + T.T)


def Q(n, W):
    return W @ W + sharp(n, W)


def circ(n, X, Y):
    return 0.5 * (X @ Y + Y @ X) + sharp_bilin(n, X, Y)


def P(n, W):
    return float(np.tensordot(W, Q(n, W)))


def dim_weyl(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12


# ---------------- Weyl subspace ----------------

def ricci_of(n, W):
    """Ric(W)_{ik} = sum_j W[(i,j),(k,j)] with signs; symmetric n x n."""
    ps, idx = pairs_of(n)
    R = np.zeros((n, n))
    for i in range(n):
        for k in range(i, n):
            s = 0.0
            for j in range(n):
                if j == i or j == k:
                    continue
                a = idx[(min(i, j), max(i, j))]
                sa = 1.0 if i < j else -1.0
                b = idx[(min(k, j), max(k, j))]
                sb = 1.0 if k < j else -1.0
                s += sa * sb * W[a, b]
            R[i, k] = R[k, i] = s
    return R


def bianchi_of(n, W):
    """Alt(W) on 4 distinct indices."""
    ps, idx = pairs_of(n)

    def g(i, j, k, l):
        s = 1.0
        if i > j:
            i, j, s = j, i, -s
        if k > l:
            k, l, s = l, k, -s
        return s * W[idx[(i, j)], idx[(k, l)]]

    out = []
    for (i, j, k, l) in itertools.combinations(range(n), 4):
        out.append(g(i, j, k, l) + g(i, k, l, j) + g(i, l, j, k))
    return np.array(out)


@functools.lru_cache(maxsize=None)
def weyl_basis(n):
    """Frobenius-orthonormal basis (D, N, N) of Weyl_n."""
    ps, idx = pairs_of(n)
    N = len(ps)
    sym = []
    for a in range(N):
        E = np.zeros((N, N))
        E[a, a] = 1.0
        sym.append(E)
    for a in range(N):
        for b in range(a + 1, N):
            E = np.zeros((N, N))
            E[a, b] = E[b, a] = 1.0 / np.sqrt(2.0)
            sym.append(E)
    sym = np.array(sym)
    rows = []
    for E in sym:
        rows.append(np.concatenate([ricci_of(n, E).ravel(), bianchi_of(n, E)]))
    A = np.array(rows).T                       # (constraints, D_sym)
    u, s, vt = np.linalg.svd(A, full_matrices=True)
    tol = max(A.shape) * (s[0] if s.size else 1.0) * 1e-12
    rank = int((s > tol).sum())
    ns = vt[rank:]
    B = np.einsum('kd,dij->kij', ns, sym)
    gram = np.einsum('imn,jmn->ij', B, B)
    assert np.allclose(gram, np.eye(len(B)), atol=1e-9)
    return B


# ---------------- L_e ----------------

def Le_matrix(n, e, B, chunk=32):
    """M[i,k] = <B_i, e o B_k> in the orthonormal Weyl basis B."""
    c = struct(n)
    N = c.shape[0]
    D = len(B)
    Ae = np.einsum('amn,np->amp', c, e, optimize=True)      # A_a e
    M = np.empty((D, D))
    eB = np.einsum('mn,knp->kmp', e, B, optimize=True)
    term1 = 0.5 * (np.einsum('imn,kmn->ik', B, eB, optimize=True)
                   + np.einsum('imn,knm->ik', B, eB, optimize=True))
    for s0 in range(0, D, chunk):
        Bc = B[s0:s0 + chunk]
        # K[i,a,p,q] = sum_b B_i[a,b] (A_b)_{pq}
        K = np.einsum('iab,bpq->iapq', Bc, c, optimize=True)
        # C_i[m,q] = sum_a (A_a e)[m,p] K[i,a,p,q]
        C = np.einsum('amp,iapq->imq', Ae, K, optimize=True)
        M[s0:s0 + chunk, :] = -0.5 * np.einsum('imq,kqm->ik', C, B, optimize=True)
    M += term1
    return 0.5 * (M + M.T)


def orbit_tangent(n, W):
    c = struct(n)
    N = c.shape[0]
    out = np.einsum('amn,nb->amb', c, W, optimize=True) - np.einsum('mn,anb->amb', W, c, optimize=True)
    return out


def onb_rows(V, tol=1e-9):
    F = V.reshape(V.shape[0], -1)
    u, s, vt = np.linalg.svd(F, full_matrices=False)
    r = int((s > tol * max(1.0, s[0])).sum())
    return vt[:r]


# ---------------- slack ----------------

def slack_structural(n, W, tol=1e-9):
    """|P_m [m,m]|^2 with m = negative eigenspace, fundamental rep, ON phi basis."""
    phi = phi_basis(n)
    w, V = np.linalg.eigh(W)
    neg = V[:, w < -tol]
    k = neg.shape[1]
    if k < 2:
        return 0.0
    X = np.einsum('ck,cij->kij', neg, phi)        # m basis as n x n matrices
    Pm = neg @ neg.T
    tot = 0.0
    for i in range(k):
        for j in range(i + 1, k):
            C = X[i] @ X[j] - X[j] @ X[i]
            v = 0.5 * np.einsum('ij,cij->c', C, phi)   # <C, phi_c>
            tot += float(v @ Pm @ v)
    return tot


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n
