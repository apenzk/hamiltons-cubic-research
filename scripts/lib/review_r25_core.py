"""Reviewer 25, independent implementation of the Lambda^2 curvature algebra.

Everything is built from the definitions in the review brief; nothing is imported
from scripts/p5_casimir_family.py or scripts/weyl.py.

Basis: phi_{ij} = E_ij - E_ji for i<j, orthonormal under <X,Y> = 1/2 tr(X^T Y).
c_{abg} = <[phi_a, phi_b], phi_g>.
(W^#)_{ab} = -1/2 tr(A_a W A_b W),  (A_a)_{mn} = c_{amn}.
Q(W) = W^2 + W^#.  P(W) = <W, Q(W)>.
"""
import numpy as np
import itertools, functools

# ---------------------------------------------------------------- basis / c
@functools.lru_cache(maxsize=None)
def pairs(n):
    return tuple((i, j) for i in range(n) for j in range(i + 1, n))

@functools.lru_cache(maxsize=None)
def basis(n):
    P = pairs(n)
    B = np.zeros((len(P), n, n))
    for a, (i, j) in enumerate(P):
        B[a, i, j] = 1.0
        B[a, j, i] = -1.0
    return B

@functools.lru_cache(maxsize=None)
def struct(n):
    """c[a,b,g] = <[phi_a,phi_b],phi_g> with <X,Y> = 1/2 tr(X^T Y)."""
    B = basis(n)
    N = B.shape[0]
    # [A,B] then inner product; do it densely, n is small
    comm = np.einsum('aij,bjk->abik', B, B, optimize=True)
    comm = comm - np.einsum('abik->abki', comm)
    ii = np.array([p[0] for p in pairs(n)]); jj = np.array([p[1] for p in pairs(n)])
    C = comm[:, :, ii, jj]
    return C

def mat_of_2form(n, X):
    """coordinates of an n x n antisymmetric matrix X in the phi basis."""
    return np.array([X[i, j] for (i, j) in pairs(n)])

def twoform_of_vec(n, v):
    X = np.zeros((n, n))
    for a, (i, j) in enumerate(pairs(n)):
        X[i, j] += v[a]
        X[j, i] -= v[a]
    return X

# ---------------------------------------------------------------- algebra
def sharp(n, W):
    C = struct(n)
    N = W.shape[0]
    # (W^#)_ab = -1/2 sum_{mnpq} c_amn W_np c_bpq W_qm
    #          = -1/2 tr(A_a W A_b W)
    AW = np.einsum('amn,np->amp', C, W)     # A_a W
    return -0.5 * np.einsum('amp,bpm->ab', AW, AW)

def Q(n, W):
    return W @ W + sharp(n, W)

def P(n, W):
    return float(np.tensordot(W, Q(n, W)))

# ---------------------------------------------------------------- curvature ops
def ricci(n, W):
    """Ric_ik = sum_j R_ijkj with R_ijkl = <W phi_ij, phi_kl> (antisym-extended)."""
    idx = {(i, j): a for a, (i, j) in enumerate(pairs(n))}
    def R(i, j, k, l):
        if i == j or k == l:
            return 0.0
        si, sj = (i, j) if i < j else (j, i)
        sk, sl = (k, l) if k < l else (l, k)
        s = (1 if i < j else -1) * (1 if k < l else -1)
        return s * W[idx[(si, sj)], idx[(sk, sl)]]
    Ric = np.zeros((n, n))
    for i in range(n):
        for k in range(n):
            Ric[i, k] = sum(R(i, j, k, j) for j in range(n))
    return Ric

@functools.lru_cache(maxsize=None)
def lam4_basis(n):
    """Orthonormal-ish basis of Lambda^4 R^n realised inside Sym^2(Lambda^2)."""
    quads = list(itertools.combinations(range(n), 4))
    idx = {(i, j): a for a, (i, j) in enumerate(pairs(n))}
    N = len(idx)
    out = []
    for (i, j, k, l) in quads:
        M = np.zeros((N, N))
        # the 4-form e_i^e_j^e_k^e_l as a symmetric operator on Lambda^2
        for (a, b, c, d), sgn in (((i, j, k, l), 1), ((i, k, j, l), -1), ((i, l, j, k), 1)):
            p, q = idx[(a, b)], idx[(c, d)]
            M[p, q] += sgn
            M[q, p] += sgn
        out.append(M / np.linalg.norm(M))
    return tuple(out)

def alt_norm2(n, W):
    """squared norm of the orthogonal projection of W onto Lambda^4 (Bianchi defect)."""
    tot = 0.0
    for M in lam4_basis(n):
        tot += float(np.tensordot(W, M)) ** 2
    return tot

def is_weyl(n, W, tol=1e-9):
    return np.linalg.norm(ricci(n, W)) < tol and alt_norm2(n, W) < tol ** 2

# ---------------------------------------------------------------- subalgebra tools
def projector_from_span(vecs):
    A = np.array(vecs, dtype=float).T
    Uq, s, _ = np.linalg.svd(A, full_matrices=False)
    keep = s > 1e-9 * max(1.0, s[0])
    Uq = Uq[:, keep]
    return Uq @ Uq.T, int(keep.sum())

def h_data(n, gens):
    """gens: list of n x n antisymmetric matrices spanning h (closure not enforced).
    Returns (Pi_h, r, Pi_m)."""
    vecs = [mat_of_2form(n, X) for X in gens]
    Pi, r = projector_from_span(vecs)
    N = len(pairs(n))
    return Pi, r, np.eye(N) - Pi

def W_of_h(n, gens):
    Pi, r, _ = h_data(n, gens)
    N = len(pairs(n))
    W = Pi - (r / N) * np.eye(N)
    return W / np.linalg.norm(W), r, N

def S_sums(n, Pi_h):
    """S_hhh, S_hmm, S_mmm from the projector."""
    C = struct(n)
    N = Pi_h.shape[0]
    Pm = np.eye(N) - Pi_h
    def contract(P1, P2, P3):
        T = np.einsum('abg,aA->Abg', C, P1, optimize=True)
        T = np.einsum('Abg,bB->ABg', T, P2, optimize=True)
        T = np.einsum('ABg,gG->ABG', T, P3, optimize=True)
        return float(np.sum(T * T))
    return contract(Pi_h, Pi_h, Pi_h), contract(Pi_h, Pm, Pm), contract(Pm, Pm, Pm)

def kappa_check(n):
    C = struct(n)
    return np.einsum('abg,abg->a', C, C)
