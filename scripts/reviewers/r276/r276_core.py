"""r276: independent Weyl machinery.  Written from the definitions; cross-checked
against scripts/curvature_operator.py's slow reference sharp at small n.

Conventions:  Lambda^2 basis phi_{ij}=e_i^e_j (i<j) declared ORTHONORMAL; a Weyl
operator is the symmetric matrix M[a,b]=W_{ijkl}.  sharp: (M#)_{ab} = -1/2 tr(ad_a M ad_b M).
theta(M) = tr(M^3) + <M#,M>.
"""
import numpy as np, itertools


class Geom:
    def __init__(self, n):
        self.n = n
        self.pairs = list(itertools.combinations(range(n), 2))
        self.N = len(self.pairs)
        self.pos = {p: k for k, p in enumerate(self.pairs)}
        # structure constants c[a,b,g] = <[A_a,A_b],A_g>, A_a = E_ij - E_ji,
        # with <X,Y> = 1/2 tr(X^T Y) so that the phi_ij are orthonormal.
        B = np.zeros((self.N, n, n))
        for a, (i, j) in enumerate(self.pairs):
            B[a, i, j] = 1.0; B[a, j, i] = -1.0
        C = np.einsum('aik,bkj->abij', B, B) - np.einsum('bik,akj->abij', B, B)
        c = 0.5 * np.einsum('abij,gij->abg', C, B)
        self.ad = np.transpose(c, (0, 2, 1))   # (ad_a)[g,b] = c[a,b,g]

    # ---------- 4-tensor conversion ----------
    def to_tensor(self, M):
        n = self.n
        sg = np.zeros((n, n)); pk = np.zeros((n, n), dtype=int)
        for i in range(n):
            for j in range(n):
                if i == j: continue
                sg[i, j] = 1.0 if i < j else -1.0
                pk[i, j] = self.pos[(min(i, j), max(i, j))]
        return sg[:, :, None, None] * sg[None, None, :, :] * M[pk][:, :, pk]

    def to_matrix(self, R):
        I = np.array([i for i, j in self.pairs]); J = np.array([j for i, j in self.pairs])
        M = R[I[:, None], J[:, None], I[None, :], J[None, :]]
        return 0.5 * (M + M.T)

    # ---------- Weyl projection ----------
    def proj_weyl(self, M):
        n = self.n
        R = self.to_tensor(0.5 * (M + M.T))
        R = R - (R + np.transpose(R, (0, 2, 3, 1)) + np.transpose(R, (0, 3, 1, 2))) / 3.0
        Ric = np.einsum('ijkj->ik', R); S = np.trace(Ric)
        Ric0 = Ric - (S / n) * np.eye(n); I = np.eye(n)
        KN = (np.einsum('ik,jl->ijkl', Ric0, I) + np.einsum('jl,ik->ijkl', Ric0, I)
              - np.einsum('il,jk->ijkl', Ric0, I) - np.einsum('jk,il->ijkl', Ric0, I))
        G = np.einsum('ik,jl->ijkl', I, I) - np.einsum('il,jk->ijkl', I, I)
        R = R - KN / (n - 2) - (S / (n * (n - 1))) * G
        return self.to_matrix(R)

    # ---------- invariants ----------
    def sharp(self, M):
        # (M#)_{ab} = -1/2 tr(ad_a M ad_b M), as one BLAS matmul
        T = self.ad @ M                                   # T[a] = ad_a M
        N = self.N
        return -0.5 * (T.reshape(N, N*N) @ np.transpose(T, (0, 2, 1)).reshape(N, N*N).T)

    def theta(self, M):
        return float(np.trace(M @ M @ M) + np.sum(self.sharp(M) * M))

    def F(self, M):
        return float(np.trace(M @ M @ M)) + float(np.linalg.norm(self.sharp(M)))


def circ(g, A, B):
    """X o Y = 1/2 (Q(X+Y) - Q(X) - Q(Y)) with Q(W)=W^2+W#."""
    return 0.5 * (A @ B + B @ A) + 0.5 * (g.sharp(A + B) - g.sharp(A) - g.sharp(B))


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n


def weyl_basis(g, tol=1e-9):
    """Orthonormal basis of Weyl_n inside S^2(Lambda^2), as a (D, N, N) array."""
    N = g.N
    tri = [(a, b) for a in range(N) for b in range(a, N)]
    cols = []
    for (a, b) in tri:
        X = np.zeros((N, N)); X[a, b] += 1.0; X[b, a] += 1.0
        cols.append(g.proj_weyl(X).ravel())
    A = np.array(cols).T
    U, s, _ = np.linalg.svd(A, full_matrices=False)
    D = int((s > tol * s[0]).sum())
    B = U[:, :D].T.reshape(D, N, N)
    return np.array([0.5 * (b + b.T) for b in B])


def padded_cp2(g):
    """W_{CP^2} in the first four coordinates, padded by zeros; unit norm."""
    N = g.N
    def phi(i, j):
        v = np.zeros(N); v[g.pos[(min(i, j), max(i, j))]] = 1.0 if i < j else -1.0
        return v
    w1 = (phi(0, 1) + phi(2, 3)) / np.sqrt(2)
    w2 = (phi(0, 2) + phi(3, 1)) / np.sqrt(2)
    w3 = (phi(0, 3) + phi(1, 2)) / np.sqrt(2)
    M = (2 * np.outer(w1, w1) - np.outer(w2, w2) - np.outer(w3, w3)) / np.sqrt(6)
    return M


def sphere_product(g, m1=None):
    """Weyl operator of S^m x S^m (or S^{m1} x S^{n-m1}), unit norm, built by
    projecting the product metric's curvature operator onto Weyl_n."""
    n = g.n
    m = n // 2 if m1 is None else m1
    N = g.N
    R = np.zeros((N, N))
    A = list(range(m)); Bl = list(range(m, n))
    for a, (i, j) in enumerate(g.pairs):
        if (i in A and j in A):
            R[a, a] = 1.0                      # curvature of the first sphere
        elif (i in Bl and j in Bl):
            R[a, a] = 1.0                      # second sphere (equal radii)
    W = g.proj_weyl(R)
    return W / np.linalg.norm(W)
