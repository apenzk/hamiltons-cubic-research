"""Reviewer 111: the test points, built here from geometry."""
import numpy as np
from core111 import Core


def sphere_product(C, parts):
    """Weyl tensor of a product of round unit spheres, unit Frobenius norm."""
    n = C.n
    assert sum(parts) == n
    blocks = []
    off = 0
    for p in parts:
        blocks.append(list(range(off, off + p)))
        off += p
    R = np.zeros((n, n, n, n))
    g = np.eye(n)
    for blk in blocks:
        P = np.zeros((n, n))
        for i in blk:
            P[i, i] = 1.0
        R += np.einsum('ik,jl->ijkl', P, P) - np.einsum('il,jk->ijkl', P, P)
    W = C.weyl_project_tensor(R)
    M = C.mat(W)
    return M / np.linalg.norm(M)


def cp2_native():
    """Weyl tensor of CP^2 at n=4: self-dual, Lambda^+ eigenvalues (2,-1,-1)."""
    C = Core(4)
    pi = C.pidx
    def vec(terms):
        v = np.zeros(6)
        for (i, j), c in terms:
            v[pi[(i, j)]] = c
        return v
    s = 1.0 / np.sqrt(2.0)
    lp = [vec([((0, 1), s), ((2, 3), s)]),
          vec([((0, 2), s), ((1, 3), -s)]),
          vec([((0, 3), s), ((1, 2), s)])]
    lam = np.array([2.0, -1.0, -1.0]) / np.sqrt(6.0)
    M = sum(l * np.outer(v, v) for l, v in zip(lam, lp))
    return C, M


def pad(C_small, M_small, n):
    """Embed a Weyl operator on R^m into R^n by zero padding the tensor."""
    Cn = Core(n)
    Rs = C_small.tens(M_small)
    m = C_small.n
    R = np.zeros((n, n, n, n))
    R[:m, :m, :m, :m] = Rs
    Mn = Cn.mat(R)
    return Cn, Mn / np.linalg.norm(Mn)


def random_weyl(C, rng):
    B = C.weyl_basis()
    v = rng.standard_normal(len(B))
    M = sum(x * b for x, b in zip(v, B))
    return M / np.linalg.norm(M)
