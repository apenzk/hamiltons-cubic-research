"""Reviewer 298: independent machinery, written from the definitions.

Conventions fixed here and used nowhere else in the repo's code:
  Lambda^2 R^n ~= so(n), basis phi_{ij} = E_ij - E_ji (i<j), <X,Y> = 1/2 tr(X^T Y),
  so the phi are ORTHONORMAL and the identification R^N -> so(n) is an isometry.
  c[a,b,g] = <[phi_a,phi_b],phi_g>, totally antisymmetric.
  ad(phi_a) as a matrix on R^N: (ad_a)[g,b] = c[a,b,g].
  Curvature operator W: symmetric N x N.  O(n) acts by conjugation with Lambda^2(g),
  so the infinitesimal action is  x . W = [ad(x), W].
  sharp from the Hamilton/Boehm-Wilking structure-constant formula
      (W#)_{ab} = 1/2 c_{anm} c_{bpq} W_{np} W_{mq},
  Q(W) = W@W + W#,  P(W) = <W,Q(W)>_F,  X o Y = 1/2(Q(X+Y)-Q(X)-Q(Y)).
  NOTE: on N x N matrices the norm used is FROBENIUS (that is the metric the repo's
  weyl_basis is orthonormal in), while on so(n) it is 1/2 tr(X^T Y).
"""
import numpy as np, functools, itertools


def pairs(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]


@functools.lru_cache(maxsize=None)
def phi(n):
    P = pairs(n)
    M = np.zeros((len(P), n, n))
    for a, (i, j) in enumerate(P):
        M[a, i, j] = 1.0
        M[a, j, i] = -1.0
    return M


@functools.lru_cache(maxsize=None)
def cst(n):
    """c[a,b,g] = <[phi_a,phi_b],phi_g> with <X,Y> = 1/2 tr(X^T Y)."""
    M = phi(n)
    br = np.einsum('aik,bkj->abij', M, M) - np.einsum('bik,akj->abij', M, M)
    return 0.5 * np.einsum('abij,gij->abg', br, M)


@functools.lru_cache(maxsize=None)
def ad(n):
    """ad[a] = matrix of ad(phi_a) on R^N: ad[a][g,b] = c[a,b,g]."""
    return np.transpose(cst(n), (0, 2, 1)).copy()


def ad_of(n, x):
    """ad(x) for x given as coefficient vector in the phi basis."""
    return np.einsum('a,agb->gb', x, ad(n))


def act(n, x, W):
    """infinitesimal O(n) action:  x . W = [ad(x), W]."""
    A = ad_of(n, x)
    return A @ W - W @ A


def sharp(n, W):
    c = cst(n)
    return 0.5 * np.einsum('anm,bpq,np,mq->ab', c, c, W, W, optimize=True)


def sharp_bil(n, X, Y):
    return 0.5 * (sharp(n, X + Y) - sharp(n, X) - sharp(n, Y))


def Qop(n, W):
    return W @ W + sharp(n, W)


def circ(n, X, Y):
    return 0.5 * (Qop(n, X + Y) - Qop(n, X) - Qop(n, Y))


def Pval(n, W):
    return float(np.sum(W * Qop(n, W)))


# ---------- Weyl space, built from the 4-tensor definition ----------

def _R4(n, W):
    """N x N operator -> 4-tensor R_ijkl."""
    P = pairs(n)
    idx = {p: a for a, p in enumerate(P)}
    R = np.zeros((n, n, n, n))
    for a, (i, j) in enumerate(P):
        for b, (k, l) in enumerate(P):
            v = W[a, b]
            for (p, q, s1) in ((i, j, 1), (j, i, -1)):
                for (r, s, s2) in ((k, l, 1), (l, k, -1)):
                    R[p, q, r, s] = s1 * s2 * v
    return R


@functools.lru_cache(maxsize=None)
def weyl_basis(n):
    """Frobenius-orthonormal basis of {W sym on Lambda^2 : Bianchi = 0, Ric = 0}."""
    P = pairs(n)
    N = len(P)
    idx = {p: a for a, p in enumerate(P)}
    # symmetric coordinates
    S = []
    for a in range(N):
        E = np.zeros((N, N)); E[a, a] = 1.0; S.append(E)
    for a in range(N):
        for b in range(a + 1, N):
            E = np.zeros((N, N)); E[a, b] = E[b, a] = 1 / np.sqrt(2); S.append(E)
    S = np.array(S)
    rows = []
    for E in S:
        R = _R4(n, E)
        con = []
        for (i, j, k, l) in itertools.combinations(range(n), 4):
            con.append(R[i, j, k, l] + R[i, k, l, j] + R[i, l, j, k])
        Ric = np.einsum('ikjk->ij', R)
        for i in range(n):
            for k in range(i, n):
                con.append(Ric[i, k])
        rows.append(con)
    Mat = np.array(rows).T                      # (r, D)
    u, s, vt = np.linalg.svd(Mat, full_matrices=True)
    tol = max(Mat.shape) * (s[0] if s.size else 1.0) * 1e-12
    rank = int((s > tol).sum())
    ns = vt[rank:]
    return np.einsum('kd,dij->kij', ns, S)


def project_weyl(n, W):
    B = weyl_basis(n)
    co = np.einsum('kij,ij->k', B, W)
    return np.einsum('k,kij->ij', co, B)


# ---------- catalogue ----------

def sphere_product(blocks):
    n = sum(blocks)
    P = pairs(n)
    lab = []
    for bi, b in enumerate(blocks):
        lab += [bi] * b
    W = np.zeros((len(P), len(P)))
    for a, (i, j) in enumerate(P):
        if lab[i] == lab[j]:
            p = blocks[lab[i]]
            W[a, a] = 1.0 / (p * (p - 1))
        else:
            W[a, a] = -1.0 / (blocks[lab[i]] * blocks[lab[j]])
    return W / np.linalg.norm(W)


def cpm(m):
    """Weyl part of the Fubini-Study curvature operator on CP^m, n = 2m."""
    n = 2 * m
    J = np.zeros((n, n))
    for t in range(m):
        J[2 * t, 2 * t + 1] = 1.0; J[2 * t + 1, 2 * t] = -1.0
    d = np.eye(n)
    T = (np.einsum('ik,jl->ijkl', d, d) - np.einsum('il,jk->ijkl', d, d)
         + np.einsum('ik,jl->ijkl', J, J) - np.einsum('il,jk->ijkl', J, J)
         + 2.0 * np.einsum('ij,kl->ijkl', J, J))
    P = pairs(n)
    R = np.array([[T[i, j, k, l] for (k, l) in P] for (i, j) in P])
    W = project_weyl(n, R)
    return W / np.linalg.norm(W)


def pad(n0, n, W0):
    P0, P1 = pairs(n0), pairs(n)
    i1 = {p: a for a, p in enumerate(P1)}
    W = np.zeros((len(P1), len(P1)))
    for a, (i, j) in enumerate(P0):
        for b, (k, l) in enumerate(P0):
            W[i1[(i, j)], i1[(k, l)]] = W0[a, b]
    return W


# ---------- the quantities under audit ----------

def g_vector(n, W, tol=1e-9):
    """g[gamma] = sum_{ab} (lam_a - lam_b)^2 T_{gamma a b}, the record's definition,
    computed in the eigenbasis of W from the structure constants directly."""
    lam, V = np.linalg.eigh(W)
    c = cst(n)
    ce = np.einsum('abg,ap,bq,gr->pqr', c, V, V, V, optimize=True)   # eigenbasis
    T = ce ** 2
    return lam, np.einsum('dab,ab->d', T, (lam[:, None] - lam[None, :]) ** 2)


def Delta(n, W, tol=1e-9):
    lam, g = g_vector(n, W)
    return float(g[lam > tol].sum()), float(g.sum()), lam


def orbit_tangent(n, W, basis=None):
    """[ad(x_a), W] for x_a running over a basis of so(n)."""
    A = ad(n)
    if basis is None:
        gens = A
    else:
        gens = np.einsum('ka,agb->kgb', basis, A)
    return np.einsum('kij,jl->kil', gens, W) - np.einsum('ij,kjl->kil', W, gens)


def Le_matrix(n, W, theta):
    """matrix of L_e = e o (.) on Weyl_n in the Frobenius-orthonormal basis."""
    B = weyl_basis(n)
    e = W / theta
    out = np.array([circ(n, e, X) for X in B])
    return np.einsum('kij,lij->kl', out, B)


def sharp_fast(n, W):
    """Same as sharp(), via M_a = ad(phi_a) W and sharp_ab = -1/2 tr(M_a M_b^T-ish)."""
    A = ad(n)
    M = np.einsum('agb,bh->agh', A, W)
    return -0.5 * np.einsum('amn,bnm->ab', M, M)


def Qf(n, W):
    return W @ W + sharp_fast(n, W)


def circ_f(n, X, Y):
    return 0.5 * (Qf(n, X + Y) - Qf(n, X) - Qf(n, Y))


def Le_spectrum(n, W, basis=None):
    """spectrum of L_e = (1/theta) W o (.) on Weyl_n, and on e-perp."""
    B = weyl_basis(n) if basis is None else basis
    W = W / np.linalg.norm(W)
    th = float(np.sum(W * Qf(n, W)))
    out = np.array([circ_f(n, W, X) for X in B]) / th
    M = np.einsum('kij,lij->kl', out, B)
    M = 0.5 * (M + M.T)
    ev, U = np.linalg.eigh(M)
    w = np.einsum('kij,ij->k', B, W)
    # restrict to e-perp
    D = np.eye(len(B)) - np.outer(w, w) / (w @ w)
    Mp = D @ M @ D
    evp = np.linalg.eigvalsh(Mp)
    return th, ev, evp, M, w
