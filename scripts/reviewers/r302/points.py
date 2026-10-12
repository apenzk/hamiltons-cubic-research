"""Critical points, built from scratch."""
import sys, os, itertools
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from core import Geom, weyl_basis, sym_basis, mat_to_vec, vec_to_mat


def normalize_sign(g, W):
    W = W / np.linalg.norm(W)
    return W if g.P(W) > 0 else -W


def sphere_product(p, q):
    """Weyl part of S^p x S^q: diagonal, a on pp, b on qq, c on mixed, Ricci-free."""
    n = p + q
    g = Geom(n)
    c = -1.0
    a = q / (p - 1.0)
    b = p / (q - 1.0)
    lam = []
    for (i, j) in g.pairs:
        if i < p and j < p:
            lam.append(a)
        elif i >= p and j >= p:
            lam.append(b)
        else:
            lam.append(c)
    return g, normalize_sign(g, np.diag(lam))


def c5_blowup(sizes=(2, 2, 2, 2, 2), diag=4.0, adjv=-2.0, nonadj=1.0):
    k = len(sizes); n = sum(sizes)
    g = Geom(n)
    lab = []
    for bi, s in enumerate(sizes):
        lab += [bi] * s
    adj = lambda x, y: (abs(x - y) % k) in (1, k - 1)
    lam = []
    for (i, j) in g.pairs:
        A_, B_ = lab[i], lab[j]
        lam.append(diag if A_ == B_ else (adjv if adj(A_, B_) else nonadj))
    return g, normalize_sign(g, np.diag(lam))


def u_m_algebra(m):
    """basis of u(m) inside so(2m), complex structure J: e_{2k} -> e_{2k+1}."""
    n = 2 * m
    J = np.zeros((n, n))
    for k in range(m):
        J[2 * k, 2 * k + 1] = -1.0
        J[2 * k + 1, 2 * k] = 1.0
    # u(m) = {X in so(n) : [X,J] = 0}, computed as a nullspace
    basis = []
    for i in range(n):
        for j in range(i + 1, n):
            E = np.zeros((n, n)); E[i, j] = 1.0; E[j, i] = -1.0
            basis.append(E)
    A = np.array([(E @ J - J @ E).ravel() for E in basis]).T
    u, s, vt = np.linalg.svd(A)
    ker = vt[(s > 1e-10 * s[0]).sum():]
    gens = [sum(c * E for c, E in zip(row, basis)) for row in ker]
    return gens, J


def cpm(m):
    """the unique U(m)-invariant unit vector of Weyl_{2m} with theta>0."""
    n = 2 * m
    g = Geom(n)
    B, idxs = weyl_basis(g)
    gens, J = u_m_algebra(m)
    rows = []
    for X in gens:
        DX = g.D(X)   # D_X for skew X is the so(n) action on Lambda^2
        Mfun = lambda M, DX=DX: DX @ M + M @ DX.T
        blk = np.zeros((B.shape[1], B.shape[1]))
        for k in range(B.shape[1]):
            Mk = vec_to_mat(B[:, k], idxs, g.N)
            blk[:, k] = B.T @ mat_to_vec(Mfun(Mk), idxs)
        rows.append(blk)
    S = np.vstack(rows)
    u, s, vt = np.linalg.svd(S)
    ker = vt[(s > 1e-8 * s[0]).sum():] if s.size else vt
    assert ker.shape[0] == 1, f"U({m})-invariants in Weyl_{n}: dim {ker.shape[0]}"  # noqa
    W = vec_to_mat(B @ ker[0], idxs, g.N)
    return g, normalize_sign(g, W)


def witness():
    W = np.load('scripts/data/w_n8_nondiagonal_witness.npy')
    g = Geom(8)
    return g, normalize_sign(g, W)
