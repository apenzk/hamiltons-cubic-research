"""Reviewer 306 -- independent implementations, written from the definitions.

Nothing under audit is imported.  Conventions are fixed by the two anchors the
record states as definitions:

  * a diagonal Weyl operator W = diag(M_ab) over coordinate 2-planes has
    Q(W)_{ab} = M_ab^2 + sum_k M_ak M_bk,
  * P(W) = <W, Q(W)> with the pair basis {e_a ^ e_b : a<b} orthonormal.

Everything else is built from the Lie-algebra square on so(n) and checked
against those anchors.
"""
import itertools
import numpy as np


def pair_index(n):
    pairs = [(a, b) for a in range(n) for b in range(a + 1, n)]
    idx = {p: i for i, p in enumerate(pairs)}
    return pairs, idx


def basis_so(n):
    """Orthonormal basis of so(n) under <A,B> = tr(A^T B): (E_ab - E_ba)/sqrt2."""
    pairs, _ = pair_index(n)
    B = np.zeros((len(pairs), n, n))
    for i, (a, b) in enumerate(pairs):
        B[i, a, b] = 1 / np.sqrt(2)
        B[i, b, a] = -1 / np.sqrt(2)
    return B


def structure_constants(n):
    """c[a,b,g] = <[b_a, b_b], b_g>."""
    B = basis_so(n)
    D = B.shape[0]
    br = np.einsum('aij,bjk->abik', B, B) - np.einsum('bij,ajk->abik', B, B)
    c = np.einsum('abij,gij->abg', br, B)
    return c


class Algebra:
    """The cubic algebra on symmetric operators over Lambda^2 R^n."""

    def __init__(self, n):
        self.n = n
        self.pairs, self.idx = pair_index(n)
        self.D = len(self.pairs)
        self.c = structure_constants(n)

    def sharp(self, R, S):
        """Lie-algebra square R # S, normalised by the diagonal anchor."""
        return np.einsum('agd,bez,ge,dz->ab', self.c, self.c, R, S)

    def circ(self, X, Y):
        """The commutative product X o Y with Q(X) = X o X."""
        return 0.5 * (X @ Y + Y @ X) + 0.5 * (self.sharp(X, Y) + self.sharp(Y, X))

    def Q(self, X):
        return X @ X + self.sharp(X, X)

    def P(self, X):
        return float(np.sum(X * self.Q(X)))

    def L(self, W):
        """The matrix of H -> W o H on the full pair space (D^2 x D^2 as an operator)."""
        D = self.D
        # act on the space of symmetric D x D matrices
        basis = sym_basis(D)
        cols = []
        for H in basis:
            cols.append(flatten_sym(self.circ(W, H)))
        return np.array(cols).T


def sym_basis(D):
    out = []
    for i in range(D):
        E = np.zeros((D, D)); E[i, i] = 1.0
        out.append(E)
    for i in range(D):
        for j in range(i + 1, D):
            E = np.zeros((D, D)); E[i, j] = E[j, i] = 1 / np.sqrt(2)
            out.append(E)
    return out


def flatten_sym(A):
    D = A.shape[0]
    out = [A[i, i] for i in range(D)]
    for i in range(D):
        for j in range(i + 1, D):
            out.append(np.sqrt(2) * A[i, j])
    return np.array(out)


def diag_operator(M):
    """The pair-diagonal operator of an n x n vertex matrix M."""
    n = M.shape[0]
    pairs, _ = pair_index(n)
    return np.diag(np.array([M[a, b] for a, b in pairs]))


# ---------- the diagonal locus, in n x n matrices ----------

def hollow(A):
    B = A.copy()
    np.fill_diagonal(B, 0.0)
    return B


def Phi(M):
    return M * M + M @ M


def crit_residual(M, theta=None):
    """Residual of  M o M + M^2 = theta M + diag(s)."""
    s = np.sum(M * M, axis=1)
    if theta is None:
        theta = theta_diag(M)
    return Phi(M) - theta * M - np.diag(s)


def theta_diag(M):
    """P of the diagonal operator, as a function of the vertex matrix."""
    return 0.5 * (np.sum(M ** 3) + np.trace(M @ M @ M))


def Lcal(M, N):
    """The diagonal-locus second-order operator: hollow(D Phi /2) with the
    diag(s) derivative removed, i.e. the derivative of the whole criticality map."""
    return hollow(M * N + 0.5 * (M @ N + N @ M))


def adm_basis(n):
    """Orthonormal basis of {N symmetric, hollow, N 1 = 0} (Frobenius)."""
    rows = []
    vecs = []
    pairs, idx = pair_index(n)
    D = len(pairs)
    # build the constraint: sum_b N_ab = 0 for each a, over the D pair coordinates
    C = np.zeros((n, D))
    for i, (a, b) in enumerate(pairs):
        C[a, i] = 1.0
        C[b, i] = 1.0
    # nullspace of C
    u, s, vt = np.linalg.svd(C)
    ns = vt[np.sum(s > 1e-10):].T   # D x k
    out = []
    for k in range(ns.shape[1]):
        N = np.zeros((n, n))
        for i, (a, b) in enumerate(pairs):
            N[a, b] = N[b, a] = ns[k, i] if False else ns[i, k]
        out.append(N)
    # orthonormalise in Frobenius
    Xs = np.array([N.ravel() for N in out])
    Xs, _ = np.linalg.qr(Xs.T)
    return [Xs[:, k].reshape(n, n) for k in range(Xs.shape[1])]


def Lcal_matrix(M):
    """Matrix of Lcal on the admissible space, in an orthonormal basis."""
    n = M.shape[0]
    bas = adm_basis(n)
    A = np.array([[np.sum(bas[i] * Lcal(M, bas[j])) for j in range(len(bas))]
                  for i in range(len(bas))])
    return A, bas


# ---------- named diagonal critical points ----------

def sphere_product(p, q):
    """Vertex matrix of the Weyl tensor of S^p x S^q, unit norm."""
    n = p + q
    M = np.zeros((n, n))
    al = 1.0 / (p * (p - 1)) if p > 1 else 0.0
    be = 1.0 / (q * (q - 1)) if q > 1 else 0.0
    ga = -1.0 / (p * q)
    for a in range(n):
        for b in range(n):
            if a == b:
                continue
            if a < p and b < p:
                M[a, b] = al
            elif a >= p and b >= p:
                M[a, b] = be
            else:
                M[a, b] = ga
    M /= np.sqrt(np.sum(M * M) / 2.0)
    return M


# ---------- the Weyl subspace and the full second-order operator ----------

def weyl_basis(n):
    """Orthonormal basis of Weyl_n inside Sym(Lambda^2 R^n), as D x D matrices."""
    pairs, idx = pair_index(n)
    D = len(pairs)
    S = sym_basis(D)                      # orthonormal basis of symmetric matrices
    def tens(Rm):
        T = np.zeros((n, n, n, n))
        for i, (a, b) in enumerate(pairs):
            for j, (c, d) in enumerate(pairs):
                v = Rm[i, j]
                for (x, y, sx) in ((a, b, 1), (b, a, -1)):
                    for (z, w, sz) in ((c, d, 1), (d, c, -1)):
                        T[x, y, z, w] = sx * sz * v
        return T
    rows = []
    for Rm in S:
        T = tens(Rm)
        con = []
        for a in range(n):
            for b in range(a + 1, n):
                for c in range(b + 1, n):
                    for d in range(c + 1, n):
                        con.append(T[a, b, c, d] + T[a, c, d, b] + T[a, d, b, c])
        for a in range(n):
            for b in range(a, n):
                con.append(sum(T[a, k, b, k] for k in range(n)))
        rows.append(con)
    Cm = np.array(rows).T                 # constraints x dim(Sym)
    u, s, vt = np.linalg.svd(Cm)
    k = int(np.sum(s > 1e-9))
    ns = vt[k:]                           # coefficient vectors in the S basis
    out = []
    for v in ns:
        Rm = sum(v[i] * S[i] for i in range(len(S)))
        out.append(Rm)
    return out


def L_full_matrix(alg, W, basis):
    """Matrix of H -> W o H on span(basis), assumed orthonormal in Frobenius."""
    k = len(basis)
    A = np.zeros((k, k))
    imgs = [alg.circ(W, H) for H in basis]
    for j in range(k):
        for i in range(k):
            A[i, j] = np.sum(basis[i] * imgs[j])
    # closure check
    err = 0.0
    for j in range(k):
        rec = sum(A[i, j] * basis[i] for i in range(k))
        err = max(err, np.abs(rec - imgs[j]).max())
    return A, err


def diag_lam_max(M, theta=None):
    """lambda_max of L_e = Lcal/theta over admissible N orthogonal to M."""
    if theta is None:
        theta = theta_diag(M)
    A, bas = Lcal_matrix(M)
    k = len(bas)
    m = np.array([np.sum(b * M) for b in bas])
    m /= np.linalg.norm(m)
    Pr = np.eye(k) - np.outer(m, m)
    ev = np.linalg.eigvalsh(Pr @ (A / theta) @ Pr)
    return ev[-1], ev


def full_lam_max(alg, W, basis=None, theta=None):
    if basis is None:
        basis = weyl_basis(alg.n)
    if theta is None:
        theta = alg.P(W)
    Lm, err = L_full_matrix(alg, W, basis)
    w = np.array([np.sum(b * W) for b in basis]); w /= np.linalg.norm(w)
    Pr = np.eye(len(basis)) - np.outer(w, w)
    ev = np.linalg.eigvalsh(Pr @ (Lm / theta) @ Pr)
    return ev[-1], ev, err
