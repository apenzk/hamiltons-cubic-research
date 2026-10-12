"""Reviewer 103: independent implementation from the brief's definitions.

Everything here is built from scratch:
  - random algebraic Weyl tensors (Riemann syms + first Bianchi + totally trace-free)
  - M = W on Lambda^2 over pairs i<j, normalised ||M||_F = 1
  - ringW on S^2_0 in Li's convention (ringW h)_ij = sum_kl W_iklj h_kl
  - NPW-style orthonormal basis {phi_ab, psi_k} of S^2_0
  - vertex matrix K_ab = W_abab,  t = ||K||_F^2
  - theta = (3/2) p3(mu) - (1/2) p3(omega)   [granted identity]
"""
import numpy as np
from itertools import combinations
from scipy.linalg import null_space

# ---------------------------------------------------------------- Weyl tensors

def kn(A, B):
    """Kulkarni-Nomizu product (A o B)_{ijkl} = A_ik B_jl + A_jl B_ik - A_il B_jk - A_jk B_il."""
    return (np.einsum('ik,jl->ijkl', A, B) + np.einsum('jl,ik->ijkl', A, B)
            - np.einsum('il,jk->ijkl', A, B) - np.einsum('jk,il->ijkl', A, B))

def bianchi_project(R):
    """Remove the totally antisymmetric (Lambda^4) part from R in Sym^2(Lambda^2)."""
    b = (R + np.transpose(R, (0, 2, 3, 1)) + np.transpose(R, (0, 3, 1, 2))) / 3.0
    return R - b

def ricci(R):
    return np.einsum('ijil->jl', R)

def weyl_from_random(n, rng):
    """Random algebraic Weyl tensor at dimension n."""
    D = n * (n - 1) // 2
    prs = list(combinations(range(n), 2))
    A = rng.standard_normal((D, D)); A = (A + A.T) / 2.0
    R = np.zeros((n, n, n, n))
    for p, (i, j) in enumerate(prs):
        for q, (k, l) in enumerate(prs):
            v = A[p, q]
            R[i, j, k, l] = v;  R[j, i, k, l] = -v
            R[i, j, l, k] = -v; R[j, i, l, k] = v
    R = bianchi_project(R)
    return weyl_part(R, n)

def weyl_part(R, n):
    """Strip Ricci and scalar parts of an algebraic curvature tensor."""
    Ric = ricci(R); scal = np.trace(Ric)
    Ric0 = Ric - (scal / n) * np.eye(n)
    W = R - kn(Ric0, np.eye(n)) / (n - 2) - (scal / (2 * n * (n - 1))) * kn(np.eye(n), np.eye(n))
    return W

def weyl_checks(W, n):
    """Returns dict of residuals: antisymmetry, pair symmetry, Bianchi, trace-free."""
    return dict(
        anti1=np.abs(W + np.transpose(W, (1, 0, 2, 3))).max(),
        anti2=np.abs(W + np.transpose(W, (0, 1, 3, 2))).max(),
        pair=np.abs(W - np.transpose(W, (2, 3, 0, 1))).max(),
        bianchi=np.abs(W + np.transpose(W, (0, 2, 3, 1)) + np.transpose(W, (0, 3, 1, 2))).max(),
        tracefree=np.abs(ricci(W)).max(),
    )

def weyl_from_vertex(K):
    """Coordinate-diagonal Weyl tensor with W_ijij = K_ij (K hollow sym, zero row sums)."""
    n = K.shape[0]
    W = np.zeros((n, n, n, n))
    for i, j in combinations(range(n), 2):
        v = K[i, j]
        W[i, j, i, j] = v;  W[j, i, j, i] = v
        W[i, j, j, i] = -v; W[j, i, i, j] = -v
    return W

# ---------------------------------------------------------------- the operators

def M_of(W, n):
    """W on Lambda^2 over pairs i<j (orthonormal basis e_i ^ e_j)."""
    prs = list(combinations(range(n), 2))
    return np.array([[W[i, j, k, l] for (k, l) in prs] for (i, j) in prs])

def s20_basis(n, psi_vecs=None):
    """Orthonormal basis of S^2_0: phi_ab (a<b) then psi_k from traceless-diagonal vectors."""
    B = []
    for a, b in combinations(range(n), 2):
        E = np.zeros((n, n)); E[a, b] = E[b, a] = 1 / np.sqrt(2.0)
        B.append(E)
    if psi_vecs is None:
        psi_vecs = null_space(np.ones((1, n))).T   # (n-1) x n orthonormal rows
    for v in psi_vecs:
        B.append(np.diag(v))
    return B

def ringW_matrix(W, n, psi_vecs=None):
    """Matrix of ringW on S^2_0 in the basis above; Li's convention W_{iklj}."""
    B = s20_basis(n, psi_vecs)
    N = len(B)
    out = np.zeros((N, N))
    for q, X in enumerate(B):
        Y = np.einsum('iklj,kl->ij', W, X)
        for p, Z in enumerate(B):
            out[p, q] = np.sum(Y * Z)
    return out

def vertex_matrix(W, n):
    K = np.zeros((n, n))
    for a, b in combinations(range(n), 2):
        K[a, b] = K[b, a] = W[a, b, a, b]
    return K

def p3(x):
    return float(np.sum(np.asarray(x) ** 3))

def theta_bispectral(W, n):
    M = M_of(W, n)
    nrm = np.linalg.norm(M)
    W = W / nrm
    M = M / nrm
    mu = np.linalg.eigvalsh(M)
    RW = ringW_matrix(W, n)
    om = np.linalg.eigvalsh(RW)
    return 1.5 * p3(mu) - 0.5 * p3(om), mu, om, W

# ---------------------------------------------------------------- vertex class

def vertex_space_basis(n):
    """Orthonormal basis (in the D = n(n-1)/2 coordinates, i<j) of {hollow sym, zero row sums}."""
    prs = list(combinations(range(n), 2))
    D = len(prs)
    C = np.zeros((n, D))
    for p, (i, j) in enumerate(prs):
        C[i, p] = 1.0; C[j, p] = 1.0
    return null_space(C), prs           # D x (D-n)

def K_from_coords(c, basis, prs, n):
    v = basis @ c
    K = np.zeros((n, n))
    for p, (i, j) in enumerate(prs):
        K[i, j] = K[j, i] = v[p]
    return K

def diagonals_from_K(K):
    """d_phi (length D, the i<j entries of K) and the full S^2_0 diagonal d
       when the psi's are taken as K's eigenvectors on 1-perp."""
    n = K.shape[0]
    dphi = np.array([K[i, j] for i, j in combinations(range(n), 2)])
    P = null_space(np.ones((1, n)))          # n x (n-1)
    Kr = P.T @ K @ P
    nu = np.linalg.eigvalsh(Kr)
    d = np.concatenate([dphi, -nu])
    return dphi, d, nu
