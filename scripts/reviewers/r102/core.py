"""Reviewer 102 -- independent implementation from the brief's definitions."""
import numpy as np
import itertools, functools

# ---------- index helpers ----------
@functools.lru_cache(maxsize=None)
def pairs(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]

@functools.lru_cache(maxsize=None)
def pair_index(n):
    return {p: a for a, p in enumerate(pairs(n))}

# ---------- Weyl projection ----------
def kn(A, B):
    """Kulkarni-Nomizu product (A o B)_{ijkl}."""
    t = np.einsum('ik,jl->ijkl', A, B) + np.einsum('jl,ik->ijkl', A, B)
    t -= np.einsum('il,jk->ijkl', A, B) + np.einsum('jk,il->ijkl', A, B)
    return t

def project_weyl(A):
    """Project an arbitrary (n,n,n,n) array onto the space of algebraic Weyl tensors."""
    n = A.shape[0]
    # pair antisymmetry
    A = A - np.transpose(A, (1, 0, 2, 3))
    A = A - np.transpose(A, (0, 1, 3, 2))
    A = A + np.transpose(A, (2, 3, 0, 1))
    A = A / 8.0
    # remove the Lambda^4 (Bianchi-violating) part
    b = (A + np.transpose(A, (0, 2, 3, 1)) + np.transpose(A, (0, 3, 1, 2))) / 3.0
    R = A - b
    # remove traces
    g = np.eye(n)
    Ric = np.einsum('ijil->jl', R)
    scal = np.trace(Ric)
    Ric0 = Ric - (scal / n) * g
    W = R - (1.0 / (n - 2)) * kn(Ric0, g) - (scal / (2.0 * n * (n - 1))) * kn(g, g)
    return W

def check_weyl(W, tol=1e-9):
    n = W.shape[0]
    errs = {}
    errs['antisym12'] = np.abs(W + np.transpose(W, (1, 0, 2, 3))).max()
    errs['antisym34'] = np.abs(W + np.transpose(W, (0, 1, 3, 2))).max()
    errs['pairsym'] = np.abs(W - np.transpose(W, (2, 3, 0, 1))).max()
    b = W + np.transpose(W, (0, 2, 3, 1)) + np.transpose(W, (0, 3, 1, 2))
    errs['bianchi'] = np.abs(b).max()
    errs['ricci'] = np.abs(np.einsum('ijil->jl', W)).max()
    return errs

def random_weyl(n, rng):
    A = rng.standard_normal((n, n, n, n))
    return project_weyl(A)

# ---------- Lambda^2 operator ----------
@functools.lru_cache(maxsize=None)
def _pidx(n):
    P = pairs(n)
    return (np.array([p[0] for p in P]), np.array([p[1] for p in P]))

def to_M(W):
    n = W.shape[0]
    I, J = _pidx(n)
    return W[I[:, None], J[:, None], I[None, :], J[None, :]]

def normalize(W):
    M = to_M(W)
    s = np.linalg.norm(M)
    return W / s, M / s

# ---------- structure constants of so(n) in phi_ij = E_ij - E_ji ----------
@functools.lru_cache(maxsize=None)
def struct_C(n):
    """C[a] is the matrix (c_{a gamma delta}) with [B_g,B_d] = sum_a c_{a g d} B_a."""
    P = pairs(n); N = len(P)
    B = np.zeros((N, n, n))
    for a, (i, j) in enumerate(P):
        B[a, i, j] = 1.0
        B[a, j, i] = -1.0
    C = np.zeros((N, N, N))
    for g in range(N):
        for d in range(N):
            comm = B[g] @ B[d] - B[d] @ B[g]
            # coefficients: <B_a, comm>/2 since <B_a,B_a> = 2
            C[:, g, d] = np.einsum('aij,ij->a', B, comm) / 2.0
    return C

def sharp(M, n):
    """(M^#)_{ab} = 1/2 c_{a g d} c_{b e z} M_{g e} M_{d z}."""
    C = struct_C(n)
    N = M.shape[0]
    out = np.zeros((N, N))
    for b in range(N):
        T = M @ C[b] @ M.T          # T_{g d} = sum_{e z} M_{g e} C^b_{e z} M_{d z}
        out[:, b] = 0.5 * np.einsum('agd,gd->a', C, T)
    return out

def theta_from_M(M, n):
    Ms = sharp(M, n)
    return np.trace(M @ M @ M) + np.sum(Ms * M)

# ---------- curvature operator of the second kind (Li's convention) ----------
@functools.lru_cache(maxsize=None)
def basis_S20(n):
    """Orthonormal basis of traceless symmetric matrices: off-diagonal phi's first, then psi's."""
    B = []
    for (i, j) in pairs(n):
        h = np.zeros((n, n)); h[i, j] = h[j, i] = 1 / np.sqrt(2.0)
        B.append(h)
    # traceless diagonal: orthonormal basis of 1^perp in R^n
    Q, _ = np.linalg.qr(np.concatenate([np.ones((n, 1)) / np.sqrt(n),
                                        np.eye(n)[:, 1:]], axis=1))
    for k in range(1, n):
        v = Q[:, k]
        B.append(np.diag(v))
    return np.array(B)

def ring_W(W, basis=None):
    n = W.shape[0]
    if basis is None:
        basis = basis_S20(n)
    # (ring W h)_{ij} = sum_{kl} W_{iklj} h_{kl}
    img = np.einsum('iklj,bkl->bij', W, basis)
    return np.einsum('aij,bij->ab', basis, img)

# ---------- vertex matrix ----------
def vertex_K(W):
    n = W.shape[0]
    K = np.einsum('abab->ab', W).copy()
    np.fill_diagonal(K, 0.0)
    return K

def rotate_W(W, R):
    T = np.tensordot(R, W, axes=([1], [0]))               # a j k l
    T = np.tensordot(R, T, axes=([1], [1])).transpose(1, 0, 2, 3)
    T = np.tensordot(R, T, axes=([1], [2])).transpose(1, 2, 0, 3)
    T = np.tensordot(R, T, axes=([1], [3])).transpose(1, 2, 3, 0)
    return T
