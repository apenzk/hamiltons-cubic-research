"""Reviewer 45: independent implementation, written from the definitions only.

Nothing here imports b_*.py or review_r*.py.  Conventions, all from the brief:

  * Lambda^2(R^n) is identified with so(n) via the orthonormal basis
    phi_ij = E_ij - E_ji (i<j), with <X,Y> = 1/2 tr(X^T Y).  In that basis
    phi_ij has norm 1, so the coefficient vector carries the plain
    Euclidean inner product, and operators on Lambda^2 carry Frobenius.
  * c_abc = <[phi_a, phi_b], phi_c>;  (A_a)_mn = c_amn.
  * (W^#)_ab = -1/2 tr(A_a W A_b W),  Q(W) = W^2 + W^#.
  * sharp_bilin is the polarization of #, and X o Y = 1/2(XY+YX) + sharp(X,Y),
    so Q(W) = W o W.
  * Weyl_n = {symmetric M on Lambda^2 : first Bianchi, Ricci-flat}, with
    M_[(ij),(kl)] = R_ijkl.
"""
import numpy as np
from itertools import combinations


# ---------------------------------------------------------------- basis / so(n)

def pairs_of(n):
    ps = list(combinations(range(n), 2))
    return ps, {p: a for a, p in enumerate(ps)}


def phi_matrices(n):
    ps, _ = pairs_of(n)
    P = np.zeros((len(ps), n, n))
    for a, (i, j) in enumerate(ps):
        P[a, i, j] = 1.0
        P[a, j, i] = -1.0
    return P


def struct(n):
    """A[a] = matrix of entries c_{a,m,n}.  Shape (N,N,N)."""
    P = phi_matrices(n)
    N = P.shape[0]
    A = np.zeros((N, N, N))
    for a in range(N):
        C = P[a] @ P - P @ P[a]           # (N,n,n): [phi_a, phi_m]
        # coefficient of phi_c in C[m] is <C[m], phi_c> = 1/2 tr(C[m]^T phi_c)
        A[a] = 0.5 * np.einsum('mij,cij->mc', C, P)
    return A


# ---------------------------------------------------------------- Q and sharp

def sharp(W, A):
    """(W^#)_ab = -1/2 tr(A_a W A_b W)."""
    N = A.shape[0]
    G = A.reshape(N * N, N) @ W          # A_a W stacked
    G = G.reshape(N, N, N)
    M = G.reshape(N, N * N) @ G.transpose(0, 2, 1).reshape(N, N * N).T
    return -0.5 * M


def sharp_bilin(X, Y, A):
    """Polarization: sharp(X,X) = X^#, symmetric in X,Y."""
    N = A.shape[0]
    GX = (A.reshape(N * N, N) @ X).reshape(N, N, N)
    GY = (A.reshape(N * N, N) @ Y).reshape(N, N, N)
    M = GX.reshape(N, N * N) @ GY.transpose(0, 2, 1).reshape(N, N * N).T
    return -0.25 * (M + M.T)


def Qop(W, A):
    return W @ W + sharp(W, A)


def circ(X, Y, A):
    return 0.5 * (X @ Y + Y @ X) + sharp_bilin(X, Y, A)


# ---------------------------------------------------------------- Weyl_n

def weyl_constraints(n):
    """Rows of a linear system on the symmetric-matrix coordinates."""
    ps, idx = pairs_of(n)
    N = len(ps)
    # coordinates: upper-triangular entries (a<=b) of the symmetric matrix
    coord = {}
    k = 0
    for a in range(N):
        for b in range(a, N):
            coord[(a, b)] = k
            k += 1
    ncoord = k

    def add(row, i, j, kk, l, val):
        """accumulate coefficient of R_{ij,kl} (any index order) into row."""
        if i == j or kk == l:
            return
        s = 1.0
        if i > j:
            i, j = j, i
            s = -s
        if kk > l:
            kk, l = l, kk
            s = -s
        a, b = idx[(i, j)], idx[(kk, l)]
        if a > b:
            a, b = b, a
        row[coord[(a, b)]] += s * val

    rows = []
    # first Bianchi, one equation per 4-subset
    for (i, j, kk, l) in combinations(range(n), 4):
        r = np.zeros(ncoord)
        add(r, i, j, kk, l, 1.0)
        add(r, i, kk, l, j, 1.0)
        add(r, i, l, j, kk, 1.0)
        rows.append(r)
    # Ricci flatness: Ric_ik = sum_j R_{ijkj}
    for i in range(n):
        for kk in range(i, n):
            r = np.zeros(ncoord)
            for j in range(n):
                add(r, i, j, kk, j, 1.0)
            rows.append(r)
    return np.array(rows), coord, ncoord, N


def weyl_basis(n, verbose=False):
    """Orthonormal basis of Weyl_n as a (D, N, N) array of symmetric matrices."""
    C, coord, ncoord, N = weyl_constraints(n)
    # null space of C
    _, s, Vt = np.linalg.svd(C, full_matrices=True)
    rank = int((s > max(C.shape) * np.finfo(float).eps * s[0]).sum())
    K = Vt[rank:]                                # (D, ncoord), orthonormal rows
    D = K.shape[0]
    # convert coordinate vectors -> symmetric matrices; the coordinate basis is
    # NOT orthonormal in Frobenius (off-diagonal coords have Frobenius norm
    # sqrt(2)), so re-orthonormalize in Frobenius afterwards.
    B = np.zeros((D, N, N))
    ia = np.array([a for (a, b) in coord], dtype=int)
    ib = np.array([b for (a, b) in coord], dtype=int)
    for d in range(D):
        M = np.zeros((N, N))
        M[ia, ib] = K[d]
        M = M + M.T - np.diag(np.diag(M))
        B[d] = M
    # Gram-Schmidt via symmetric orthonormalization in the Frobenius metric
    F = B.reshape(D, N * N)
    G = F @ F.T
    w, U = np.linalg.eigh(G)
    assert w.min() > 1e-10, w.min()
    F = (U * (w ** -0.5)) @ U.T @ F
    if verbose:
        print(f"  weyl_basis n={n}: D={D}  orthonormality err="
              f"{np.abs(F @ F.T - np.eye(D)).max():.2e}")
    return F.reshape(D, N, N)


def project(Bflat, M):
    """Orthogonal projection onto span(rows of Bflat) (Frobenius)."""
    v = Bflat @ M.reshape(-1)
    return (v @ Bflat).reshape(M.shape)


# ---------------------------------------------------------------- named points

def sphere_product(k, l, n):
    """Weyl operator of S^k x S^l inside Lambda^2(R^n), built exactly.

    Coordinate-diagonal with a on 2-planes inside the first block, b inside
    the second, c on mixed planes; Bianchi is automatic and Ricci-flatness
    forces (k-1)a + l c = 0, (l-1)b + k c = 0.  Unnormalized.
    """
    assert k + l <= n and k >= 2 and l >= 2
    ps, idx = pairs_of(n)
    N = len(ps)
    a, b, c = l / (k - 1.0), k / (l - 1.0), -1.0
    M = np.zeros((N, N))
    for p, (i, j) in enumerate(ps):
        if i < k and j < k:
            M[p, p] = a
        elif k <= i < k + l and k <= j < k + l:
            M[p, p] = b
        elif (i < k <= j < k + l):
            M[p, p] = c
    return M


def pad(Msmall, n0, n):
    """Zero-pad an operator on Lambda^2(R^n0) into Lambda^2(R^n)."""
    ps0, _ = pairs_of(n0)
    ps, idx = pairs_of(n)
    N = len(ps)
    M = np.zeros((N, N))
    ii = np.array([idx[p] for p in ps0])
    M[np.ix_(ii, ii)] = Msmall
    return M


# ---------------------------------------------------------------- diagnostics

def theta_and_residual(W, A):
    QW = Qop(W, A)
    th = float(np.tensordot(W, QW))
    return th, float(np.linalg.norm(QW - th * W))


def orbit_tangent(W, A):
    """span{[A_a, W]}; returns an orthonormal basis (rows, flattened)."""
    N = A.shape[0]
    T = np.einsum('amn,np->amp', A, W) - np.einsum('mn,anp->amp', W, A)
    T = T.reshape(N, N * N)
    u, s, _ = np.linalg.svd(T, full_matrices=False)
    tol = max(T.shape) * np.finfo(float).eps * (s[0] if s.size else 1.0)
    r = int((s > tol).sum())
    return (u[:, :r].T @ T) / s[:r, None], s


def Le_matrix(Bflat, e, A, progress=None):
    """Matrix of X -> e o X restricted to Weyl_n, in the orthonormal basis."""
    D, NN = Bflat.shape
    N = A.shape[0]
    Aflat = A.reshape(N * N, N)
    G = (Aflat @ e).reshape(N, N, N)                       # A_a e
    Gt = G.transpose(0, 2, 1).reshape(N, N * N)
    Gf = G.reshape(N, N * N)
    M = np.empty((D, D))
    for d in range(D):
        X = Bflat[d].reshape(N, N)
        P = (Aflat @ X).reshape(N, N, N)                   # A_b X
        T = Gf @ P.transpose(0, 2, 1).reshape(N, N * N).T  # T[a,b]=tr(A_a e A_b X)
        Y = 0.5 * (e @ X + X @ e) - 0.25 * (T + T.T)
        M[:, d] = Bflat @ Y.reshape(-1)
        if progress and d % progress == 0:
            print(f"    Le col {d}/{D}", flush=True)
    return 0.5 * (M + M.T)


def slack(W, A, tol=1e-9):
    """S = sum_{i<j} || Pi_m [X_i, X_j] ||^2 over an orthonormal basis of the
    negative eigenspace m of W (as a subspace of so(n))."""
    N = A.shape[0]
    w, V = np.linalg.eigh(W)
    C = V[:, w < -tol]
    if C.shape[1] < 2:
        return 0.0
    Pm = C @ C.T
    # commutator of basis elements in coefficient coordinates: [X_i,X_j] has
    # coefficient vector  sum_{m,n} C[m,i] C[n,j] c_{m n .}
    # c_{m,n,p} = A[m][n,p]
    K = C.shape[1]
    tot = 0.0
    for i in range(K):
        # (A contracted with C[:,i]) : matrix  R_i[n,p] = sum_m C[m,i] A[m,n,p]
        Ri = np.tensordot(C[:, i], A, axes=(0, 0))         # (N,N)
        V2 = C.T @ Ri                                      # rows: [X_i, X_j]
        Vin = V2 @ Pm
        tot += float(np.sum(V2[i + 1:] * Vin[i + 1:]))
    return tot
