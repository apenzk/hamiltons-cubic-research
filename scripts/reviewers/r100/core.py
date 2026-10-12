"""Reviewer 100: independent implementation of the Weyl / bi-spectral machinery.

Conventions taken verbatim from the brief:
  * W_n = algebraic Weyl tensors on R^n. dim = n(n+1)(n+2)(n-3)/12.
  * M_{(ij),(kl)} = W_{ijkl} over pairs i<j; normalise ||M||_F = 1; mu = spec(M).
  * Li's curvature operator of the second kind: (Wring h)_{ij} = sum_{k,l} W_{iklj} h_{kl}
    on trace-free symmetric 2-tensors S^2_0, dim = (n-1)(n+2)/2; omega = its spectrum.
  * Hamilton sharp: (M^#)_{ab} = 1/2 c_{a g d} c_{b e z} M_{g e} M_{d z}, structure
    constants of so(n) in the UNNORMALISED basis phi_ij = E_ij - E_ji.
  * theta = tr(M^3) + <M^#, M>;  theta_0(n) = sqrt(2(n-1)(n-2))/n.
"""
import numpy as np
from itertools import combinations
from functools import lru_cache


# ---------------------------------------------------------------- pair indexing
@lru_cache(maxsize=None)
def pairs(n):
    return tuple(combinations(range(n), 2))


@lru_cache(maxsize=None)
def pidx(n):
    return {p: a for a, p in enumerate(pairs(n))}


def pair_lookup(n, i, j):
    """Return (index, sign) for the Lambda^2 basis element e_i ^ e_j."""
    if i == j:
        return None, 0.0
    if i < j:
        return pidx(n)[(i, j)], 1.0
    return pidx(n)[(j, i)], -1.0


# ------------------------------------------------- symmetric-matrix vectorisation
@lru_cache(maxsize=None)
def svec_index(d):
    """List of (a,b,scale) so that svec(M)[t] = scale*M[a,b]; Euclidean == Frobenius."""
    out = []
    for a in range(d):
        for b in range(a, d):
            out.append((a, b, 1.0 if a == b else np.sqrt(2.0)))
    return tuple(out)


def svec(M):
    d = M.shape[0]
    idx = svec_index(d)
    return np.array([s * M[a, b] for (a, b, s) in idx])


def sunvec(v, d):
    M = np.zeros((d, d))
    for t, (a, b, s) in enumerate(svec_index(d)):
        M[a, b] = v[t] / s
        M[b, a] = M[a, b]
    return M


# ----------------------------------------------------------- Weyl-space basis
def weyl_basis(n):
    """Orthonormal basis of W_n as columns in svec coordinates on Sym(Lambda^2).

    Constraints on the symmetric matrix M on Lambda^2:
      (B) first Bianchi:  M[(ij),(kl)] - M[(ik),(jl)] + M[(il),(jk)] = 0, i<j<k<l
      (T) Ricci trace:    sum_i W_{ijil} = 0 for j<=l
    """
    P = pairs(n)
    d = len(P)
    D = d * (d + 1) // 2
    idx = svec_index(d)
    pos = {(a, b): t for t, (a, b, s) in enumerate(idx)}
    scl = {(a, b): s for t, (a, b, s) in enumerate(idx)}

    def addM(row, a, b, c):
        """row += c * M[a,b] expressed in svec coords."""
        aa, bb = (a, b) if a <= b else (b, a)
        row[pos[(aa, bb)]] += c / scl[(aa, bb)]

    rows = []
    # Bianchi
    for (i, j, k, l) in combinations(range(n), 4):
        r = np.zeros(D)
        addM(r, pidx(n)[(i, j)], pidx(n)[(k, l)], 1.0)
        addM(r, pidx(n)[(i, k)], pidx(n)[(j, l)], -1.0)
        addM(r, pidx(n)[(i, l)], pidx(n)[(j, k)], 1.0)
        rows.append(r)
    # Ricci trace: Ric_{jl} = sum_i W_{ijil}
    for j in range(n):
        for l in range(j, n):
            r = np.zeros(D)
            for i in range(n):
                a, sa = pair_lookup(n, i, j)
                b, sb = pair_lookup(n, i, l)
                if a is None or b is None:
                    continue
                addM(r, a, b, sa * sb)
            rows.append(r)
    C = np.array(rows)
    # null space
    U, s, Vt = np.linalg.svd(C, full_matrices=True)
    tol = max(C.shape) * np.finfo(float).eps * (s[0] if s.size else 1.0)
    rank = int((s > tol).sum())
    B = Vt[rank:].T          # D x dimW, orthonormal columns
    return B


def dim_weyl(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12


# --------------------------------------------------------- tensor from M matrix
def full_tensor(M, n):
    """W_{ijkl} as an n^4 array from the Lambda^2 matrix M."""
    W = np.zeros((n, n, n, n))
    P = pairs(n)
    for a, (i, j) in enumerate(P):
        for b, (k, l) in enumerate(P):
            v = M[a, b]
            if v == 0.0:
                continue
            W[i, j, k, l] += v
            W[j, i, k, l] -= v
            W[i, j, l, k] -= v
            W[j, i, l, k] += v
    return W


def M_from_tensor(W, n):
    """Inverse of full_tensor for a tensor with Riemann pair symmetries."""
    P = pairs(n)
    d = len(P)
    M = np.zeros((d, d))
    for a, (i, j) in enumerate(P):
        for b, (k, l) in enumerate(P):
            M[a, b] = W[i, j, k, l]
    return M


# ------------------------------------------------------------- S^2_0 machinery
@lru_cache(maxsize=None)
def s20_basis(n):
    """Orthonormal basis of trace-free symmetric 2-tensors, returned as an
    (n^2 x dim) matrix whose columns are vec(F_alpha).  Off-diagonals first
    (NPW 'phi_ij'), then the trace-free diagonals ('psi_k')."""
    cols = []
    labels = []
    for (i, j) in pairs(n):
        F = np.zeros((n, n))
        F[i, j] = F[j, i] = 1.0 / np.sqrt(2.0)
        cols.append(F.reshape(-1))
        labels.append(('phi', i, j))
    # trace-free diagonal: Gram-Schmidt on e_k e_k^T - (1/n) I
    D = np.eye(n) - np.ones((n, n)) / n     # rows = diag of e_k e_k^T - I/n
    Q, _ = np.linalg.qr(D)
    for k in range(n - 1):
        v = Q[:, k]
        F = np.diag(v)
        cols.append(F.reshape(-1))
        labels.append(('psi', k, k))
    return np.array(cols).T, tuple(labels)


def Wring(W, n):
    """Li's curvature operator of the second kind as a matrix on S^2_0."""
    B, _ = s20_basis(n)
    # T2[(i,j),(k,l)] = W[i,k,l,j]
    T2 = np.transpose(W, (0, 3, 1, 2)).reshape(n * n, n * n)
    return B.T @ T2 @ B


def iota_star(X, n):
    """Adjoint of W -> Wring, returned as a Lambda^2 matrix N with
    <N, M>_F = <X, Wring(W)>  for every W with the Riemann pair symmetries."""
    B, _ = s20_basis(n)
    P4 = (B @ X @ B.T).reshape(n, n, n, n)           # P4[p,q,k,l]
    Y = np.transpose(P4, (0, 2, 3, 1))               # Y[p,k,l,q] = P4[p,q,k,l]
    # project Y onto tensors antisymmetric in each pair, symmetric under pair swap
    Yh = (Y - np.transpose(Y, (1, 0, 2, 3))
            - np.transpose(Y, (0, 1, 3, 2))
            + np.transpose(Y, (1, 0, 3, 2)))
    Yh = (Yh + np.transpose(Yh, (2, 3, 0, 1))) / 8.0
    N = M_from_tensor(Yh, n)
    return 4.0 * N


# ------------------------------------------------------- so(n) structure consts
@lru_cache(maxsize=None)
def struct_consts(n):
    """c[a,g,d] with [phi_g, phi_d] = sum_a c[a,g,d] phi_a, phi_ij = E_ij - E_ji."""
    P = pairs(n)
    d = len(P)
    c = np.zeros((d, d, d))
    for g, (i, j) in enumerate(P):
        for dd, (k, l) in enumerate(P):
            # [phi_ij, phi_kl] = d_jk phi_il - d_jl phi_ik - d_ik phi_jl + d_il phi_jk
            for (cond, p, q, sg) in ((j == k, i, l, 1.0), (j == l, i, k, -1.0),
                                     (i == k, j, l, -1.0), (i == l, j, k, 1.0)):
                if not cond:
                    continue
                a, sa = pair_lookup(n, p, q)
                if a is None:
                    continue
                c[a, g, dd] += sg * sa
    return c


def sharp(M, n):
    """(M^#)_{ab} = 1/2 c_{a g d} c_{b e z} M_{g e} M_{d z}."""
    c = struct_consts(n)
    d = M.shape[0]
    # T[a,e,z] = sum_{g,d} c[a,g,d] M[g,e] M[d,z]
    T = np.einsum('agd,ge,dz->aez', c, M, M, optimize=True)
    return 0.5 * np.einsum('aez,bez->ab', T, c, optimize=True)


# --------------------------------------------------------------------- scalars
def theta_from_M(M, n):
    Ms = sharp(M, n)
    return np.trace(M @ M @ M) + float(np.sum(Ms * M))


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n


def p3(x):
    return float(np.sum(x ** 3))


# --------------------------------------------------------------- sampling
def random_weyl(n, B, rng, normalise=True):
    v = rng.standard_normal(B.shape[1])
    if normalise:
        v /= np.linalg.norm(v)
    d = len(pairs(n))
    return sunvec(B @ v, d), v


def project_weyl(N, B, n):
    d = len(pairs(n))
    v = B.T @ svec(N)
    return sunvec(B @ v, d), v
