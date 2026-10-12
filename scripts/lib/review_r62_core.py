"""Reviewer 62, independent implementation.  Core algebra: so(m), W^#, theta, T, R.

No dependence on any b0_*.py.  Conventions from the brief:
  Lambda^2 R^m = so(m), phi_{ij} = E_ij - E_ji (i<j), <X,Y> = (1/2) tr(X^T Y).
  W^# defined by (W^#)_{ij} = (1/2) sum_{k,p,l,q} c_{ikp} c_{jlq} W_{kl} W_{pq},
  with [b_k,b_p] = sum_i c_{ikp} b_i.
  theta = <W, W^2 + W^#>.
"""
import numpy as np
import itertools


def so_basis(m):
    B = []
    idx = []
    for i in range(m):
        for j in range(i + 1, m):
            E = np.zeros((m, m))
            E[i, j] = 1.0
            E[j, i] = -1.0
            B.append(E)
            idx.append((i, j))
    return np.array(B), idx


def ip(X, Y):
    return 0.5 * np.tensordot(X, Y, axes=([-2, -1], [-2, -1]))


def struct_consts(B):
    """c[i,k,p] = < [b_k, b_p], b_i >."""
    N = len(B)
    C = np.zeros((N, N, N))
    for k in range(N):
        for p in range(N):
            br = B[k] @ B[p] - B[p] @ B[k]
            C[:, k, p] = 0.5 * np.einsum('aij,ij->a', B, br)
    return C


def sharp(W, C):
    """W^# = (1/2) sum c_{ikp} c_{jlq} W_{kl} W_{pq}."""
    M = np.einsum('ikp,jlq,kl,pq->ij', C, C, W, W)
    return 0.5 * M


def theta_of(W, C):
    return ip_mat(W, W @ W + sharp(W, C))


def ip_mat(A, Bm):
    """Frobenius pairing of operators on Lambda^2 (already in an ON basis)."""
    return float(np.sum(A * Bm))


def eig_data(W, B, C):
    """Eigen-decomposition and the tensors T, R in the eigenframe."""
    lam, U = np.linalg.eigh(W)          # columns U[:,a] are eigenvectors in the b-basis
    # v_a as m x m matrices
    V = np.einsum('ia,ijk->ajk', U, B)
    N = len(lam)
    Cp = np.einsum('ia,jb,kg->abg', U, U, U, optimize=True)  # placeholder shape
    # c'_{abg} = <[v_a,v_b], v_g> = sum_{ikp} U_{i a?}...  do it directly
    cpr = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            br = V[a] @ V[b] - V[b] @ V[a]
            cpr[a, b, :] = 0.5 * np.einsum('gij,ij->g', V, br)
    T = cpr ** 2
    R = T.sum(axis=2)
    return lam, V, T, R


def c1_rhs(lam, T):
    N = len(lam)
    tot = 0.0
    for a in range(N):
        for b in range(a + 1, N):
            for g in range(b + 1, N):
                tot += T[a, b, g] * lam[a] * lam[b] * lam[g]
    return float(np.sum(lam ** 3) + 3.0 * tot)


# ---------- Weyl subspace ----------
def weyl_projector(m):
    """Orthonormal basis (as flattened symmetric N x N matrices) of Weyl_m."""
    B, idx = so_basis(m)
    N = len(B)
    # parametrise symmetric W by upper triangle
    pairs = [(i, j) for i in range(N) for j in range(i, N)]

    def to_W(x):
        W = np.zeros((N, N))
        for t, (i, j) in enumerate(pairs):
            W[i, j] += x[t]
            W[j, i] = W[i, j]
        return W

    rows = []
    # Ricci: sum_j R_{ijkj} = 0  where R_{ijkl} = W[idx(i,j), idx(k,l)] with sign
    pos = {}
    for a, (i, j) in enumerate(idx):
        pos[(i, j)] = (a, 1.0)
        pos[(j, i)] = (a, -1.0)

    def Rc(W, i, j, k, l):
        if i == j or k == l:
            return 0.0
        a, sa = pos[(i, j)]
        b, sb = pos[(k, l)]
        return sa * sb * W[a, b]

    basisW = []
    for t in range(len(pairs)):
        x = np.zeros(len(pairs)); x[t] = 1.0
        basisW.append(to_W(x))

    cons = []
    for i in range(m):
        for k in range(i, m):
            row = [sum(Rc(W, i, j, k, j) for j in range(m)) for W in basisW]
            cons.append(row)
    for q in itertools.combinations(range(m), 4):
        i, j, k, l = q
        for (a, b, c, d) in [(i, j, k, l), (j, i, k, l), (k, i, j, l), (l, i, j, k)]:
            pass
        row = [Rc(W, i, j, k, l) + Rc(W, i, k, l, j) + Rc(W, i, l, j, k) for W in basisW]
        cons.append(row)
    A = np.array(cons)
    # nullspace
    _, sv, Vt = np.linalg.svd(A)
    tol = 1e-10 * max(A.shape) * (sv[0] if len(sv) else 1.0)
    ns = Vt[np.sum(sv > tol):] if len(sv) < Vt.shape[0] else Vt[np.sum(sv > tol):]
    return [to_W(v) for v in ns], B, idx


def random_weyl(m, rng):
    ns, B, idx = weyl_projector(m)
    x = rng.normal(size=len(ns))
    W = sum(xi * Wi for xi, Wi in zip(x, ns))
    W = W / np.sqrt(np.sum(W * W))
    return W, B, idx


def w4_family(q, r, m=4, normalize=True):
    """(q+r) w1(x)w1 - q w2(x)w2 - r w3(x)w3, padded into so(m).  Signature (1,2)."""
    B, idx = so_basis(m)
    N = len(B)
    ind = {p: t for t, p in enumerate(idx)}
    s2 = np.sqrt(2.0)
    def vec(pairs):
        v = np.zeros(N)
        for (p, sg) in pairs:
            v[ind[p]] = sg / s2
        return v
    w1 = vec([((0, 1), 1), ((2, 3), 1)])
    w2 = np.zeros(N); w2[ind[(0, 2)]] = 1 / s2; w2[ind[(1, 3)]] = -1 / s2
    w3 = vec([((0, 3), 1), ((1, 2), 1)])
    W = (q + r) * np.outer(w1, w1) - q * np.outer(w2, w2) - r * np.outer(w3, w3)
    if normalize:
        W = W / np.sqrt(np.sum(W * W))
    return W, B, idx
