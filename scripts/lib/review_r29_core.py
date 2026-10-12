"""Reviewer 29: independent implementation of the Weyl algebra from the definitions.

Nothing here is imported from other project scripts.
"""
import numpy as np
import itertools


def pairs(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]


def struct(n):
    """c[a,b,g] = <[phi_a,phi_b],phi_g> with phi_ij = E_ij - E_ji, <X,Y>=1/2 tr(X^T Y)."""
    P = pairs(n)
    N = len(P)
    idx = {p: k for k, p in enumerate(P)}
    phi = np.zeros((N, n, n))
    for k, (i, j) in enumerate(P):
        phi[k, i, j] = 1.0
        phi[k, j, i] = -1.0
    c = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            com = phi[a] @ phi[b] - phi[b] @ phi[a]
            # <com, phi_g> = 1/2 tr(com^T phi_g) = com[i,j] for g=(i,j)
            for g, (i, j) in enumerate(P):
                c[a, b, g] = com[i, j]
    return P, N, phi, c


class Alg:
    def __init__(self, n):
        self.n = n
        self.P, self.N, self.phi, self.c = struct(n)
        N = self.N
        # A_a with (A_a)_{mn} = c_{amn}
        self.A = self.c.copy()
        # rho_a = ad(phi_a) as a matrix on Lambda^2: (rho_a)_{n,m} = c_{a,m,n}
        self.rho = np.transpose(self.c, (0, 2, 1)).copy()
        self.idx = {p: k for k, p in enumerate(self.P)}

    # ---------- sharp / Q ----------
    def F(self, X, Y):
        """F[a,b] = tr(A_a X A_b Y)."""
        c = self.c
        N = self.N
        U = np.tensordot(c, X, axes=([2], [0]))          # U[a,m,p]
        G = np.tensordot(c, Y, axes=([2], [0]))          # G[b,p,m]
        return U.reshape(N, N * N) @ np.transpose(G, (0, 2, 1)).reshape(N, N * N).T

    def sharp(self, X):
        return -0.5 * self.F(X, X)

    def Q(self, X):
        return X @ X + self.sharp(X)

    def circ(self, X, Y):
        F = self.F(X, Y)
        return 0.5 * (X @ Y + Y @ X) - 0.25 * (F + F.T)

    # ---------- tensor bookkeeping ----------
    def R_of(self, W):
        """(0,4) tensor R[i,j,k,l] from the operator W in the phi basis."""
        n, N = self.n, self.N
        R = np.zeros((n, n, n, n))
        for a, (i, j) in enumerate(self.P):
            for b, (k, l) in enumerate(self.P):
                v = W[a, b]
                for (si, ii, jj) in ((1, i, j), (-1, j, i)):
                    for (sk, kk, ll) in ((1, k, l), (-1, l, k)):
                        R[ii, jj, kk, ll] = si * sk * v
        return R


def sym_basis(N):
    """Orthonormal (Frobenius) basis of Sym(N): returns list of (i,j,value-pattern) as sparse spec."""
    out = []
    for i in range(N):
        out.append((i, i))
    for i in range(N):
        for j in range(i + 1, N):
            out.append((i, j))
    return out


def weyl_basis(alg):
    """Orthonormal basis of Weyl_n inside Sym(Lambda^2), Frobenius inner product <X,Y>=tr(XY)."""
    n, N, P = alg.n, alg.N, alg.P
    coords = sym_basis(N)
    M = len(coords)
    idx = alg.idx

    def val(a, b, i, j, k, l):
        """coefficient of basis matrix #(a,b) in R[i,j,k,l]"""
        # R[i,j,k,l] = s * W[p,q] with p=idx of sorted(i,j), q=idx of sorted(k,l)
        if i == j or k == l:
            return 0.0
        si = 1.0
        ii, jj = i, j
        if ii > jj:
            ii, jj, si = jj, ii, -si
        sk = 1.0
        kk, ll = k, l
        if kk > ll:
            kk, ll, sk = ll, kk, -sk
        p, q = idx[(ii, jj)], idx[(kk, ll)]
        s = si * sk
        if a == b:
            return s if (p, q) == (a, a) else 0.0
        # off diagonal orthonormal element (E_ab+E_ba)/sqrt(2)
        r = 0.0
        if (p, q) == (a, b):
            r += s
        if (p, q) == (b, a):
            r += s
        return r / np.sqrt(2.0)

    rows = []
    # Bianchi: R[i,j,k,l] + R[i,k,l,j] + R[i,l,j,k] = 0 for i<j<k<l
    for (i, j, k, l) in itertools.combinations(range(n), 4):
        row = np.zeros(M)
        for m, (a, b) in enumerate(coords):
            row[m] = (val(a, b, i, j, k, l) + val(a, b, i, k, l, j)
                      + val(a, b, i, l, j, k))
        rows.append(row)
    # Ricci: sum_k R[i,k,j,k] = 0 for i<=j
    for i in range(n):
        for j in range(i, n):
            row = np.zeros(M)
            for m, (a, b) in enumerate(coords):
                s = 0.0
                for k in range(n):
                    s += val(a, b, i, k, j, k)
                row[m] = s
            rows.append(row)
    C = np.array(rows)
    u, s, vt = np.linalg.svd(C)
    tol = max(C.shape) * np.finfo(float).eps * (s[0] if len(s) else 1.0)
    r = int((s > tol).sum())
    ns = vt[r:]                       # (D, M) orthonormal rows
    D = ns.shape[0]
    B = np.zeros((D, N, N))
    for d in range(D):
        X = np.zeros((N, N))
        for m, (a, b) in enumerate(coords):
            if a == b:
                X[a, a] += ns[d, m]
            else:
                X[a, b] += ns[d, m] / np.sqrt(2.0)
                X[b, a] += ns[d, m] / np.sqrt(2.0)
        B[d] = X
    return B, C.shape[0], r


def ip(X, Y):
    return float(np.sum(X * Y))


def project(B, X):
    return np.tensordot(np.tensordot(B, X, axes=([1, 2], [0, 1])), B, axes=([0], [0]))


def coords_in(B, X):
    return np.tensordot(B, X, axes=([1, 2], [0, 1]))


def L_matrix(alg, B, x):
    """L[l,k] = <B_l, x o B_k>."""
    D, N, _ = B.shape
    c = alg.c
    U = np.tensordot(c, x, axes=([2], [0])).reshape(N, N * N)   # (a,(m,p))
    Bf = B.reshape(D, N * N)
    L = np.zeros((D, D))
    for k in range(D):
        Y = B[k]
        G = np.tensordot(c, Y, axes=([2], [0]))                  # (b,p,m)
        F = U @ np.transpose(G, (0, 2, 1)).reshape(N, N * N).T
        Mk = 0.5 * (x @ Y + Y @ x) - 0.25 * (F + F.T)
        L[:, k] = Bf @ Mk.reshape(N * N)
    return L


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n
