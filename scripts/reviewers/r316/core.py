"""r316 independent build: algebraic Weyl operators, Hamilton's sharp, Q, L_W.

Conventions fixed from scratch:
  Lambda^2 R^n ~ so(n), basis E_ij (i<j), (E_ij)_ab = d_ia d_jb - d_ja d_ib.
  Inner product <A,B> = -1/2 tr(AB): the E_ij are orthonormal.
  Structure constants c_{a g d} = <[phi_a, phi_g], phi_d>.
  Sharp:  (W#)_{ab} = 1/2 sum c_{a g d} c_{b e z} W_{ge} W_{dz}  = -1/2 tr(A_a W A_b W).
  Normalisation anchor: R = Id (constant curvature 1) gives R# = (n-2) Id,
  which is what Hamilton's dR/dt = Delta R + 2(R^2 + R#) forces on the shrinking round sphere.
"""
import numpy as np
from itertools import combinations


def pairs_of(n):
    prs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    return prs, {p: k for k, p in enumerate(prs)}


def so_basis(n):
    prs, _ = pairs_of(n)
    N = len(prs)
    B = np.zeros((N, n, n))
    for k, (i, j) in enumerate(prs):
        B[k, i, j] = 1.0
        B[k, j, i] = -1.0
    return B


def ad_matrices(n):
    """A[k] = ad(phi_k) as a matrix on Lambda^2 coordinates."""
    prs, idx = pairs_of(n)
    N = len(prs)
    B = so_basis(n)
    A = np.zeros((N, N, N))
    for k in range(N):
        Ck = B[k] @ B - B @ B[k]          # (N, n, n): [phi_k, phi_g] for all g
        for g in range(N):
            for d, (i, j) in enumerate(prs):
                A[k, d, g] = Ck[g, i, j]
    return A


class Alg:
    def __init__(self, n):
        self.n = n
        self.prs, self.idx = pairs_of(n)
        self.N = len(self.prs)
        self.A = ad_matrices(n)
        N = self.N
        self.Aflat = self.A.reshape(N, N * N)

    # ---- sharp -------------------------------------------------------
    def sharp(self, W):
        M = self.A @ W                       # (N,N,N): A_a W
        N = self.N
        Mf = M.reshape(N, N * N)
        Mt = M.transpose(0, 2, 1).reshape(N, N * N)
        return -0.5 * (Mf @ Mt.T)

    def sharp_bilin(self, W, H):
        return 0.5 * (self.sharp(W + H) - self.sharp(W) - self.sharp(H))

    def Q(self, W):
        return W @ W + self.sharp(W)

    def L(self, W, H):
        return 0.5 * (W @ H + H @ W) + self.sharp_bilin(W, H)

    # ---- 4-tensor view ----------------------------------------------
    def entry(self, M, i, j, k, l):
        if i == j or k == l:
            return 0.0
        si = 1.0
        if i > j:
            i, j, si = j, i, -si
        if k > l:
            k, l, si = l, k, -si
        return si * M[self.idx[(i, j)], self.idx[(k, l)]]


def sym_basis(N):
    """Orthonormal basis of symmetric NxN matrices, as (D, N, N)."""
    out = []
    for a in range(N):
        M = np.zeros((N, N)); M[a, a] = 1.0; out.append(M)
    for a in range(N):
        for b in range(a + 1, N):
            M = np.zeros((N, N)); M[a, b] = M[b, a] = 1 / np.sqrt(2); out.append(M)
    return np.array(out)


def constraints(alg):
    """Rows of the linear map Sym(Lambda^2) -> (Lambda^4) + Sym^2(R^n)."""
    n, N = alg.n, alg.N
    SB = sym_basis(N)
    D = SB.shape[0]
    rows = []
    # first Bianchi
    for (i, j, k, l) in combinations(range(n), 4):
        r = np.zeros(D)
        for t in range(D):
            M = SB[t]
            r[t] = alg.entry(M, i, j, k, l) + alg.entry(M, i, k, l, j) + alg.entry(M, i, l, j, k)
        rows.append(r)
    # Ricci
    for a in range(n):
        for b in range(a, n):
            r = np.zeros(D)
            for t in range(D):
                M = SB[t]
                r[t] = sum(alg.entry(M, i, a, i, b) for i in range(n))
            rows.append(r)
    return np.array(rows), SB


def weyl_basis(alg, tol=1e-9):
    """Orthonormal basis of {symmetric, first Bianchi, Ricci-flat} as (dim, N, N)."""
    C, SB = constraints(alg)
    G = C.T @ C
    w, V = np.linalg.eigh(G)
    keep = V[:, w < tol * max(1.0, w.max())]
    # keep columns -> matrices
    return np.einsum('td,tij->dij', keep, SB), keep


def flatten(basis):
    d = basis.shape[0]
    return basis.reshape(d, -1)


# ---------- sphere product / symmetric pair helpers -------------------

def proj_block(alg, S):
    """Orthogonal projection of Lambda^2 onto span{E_ij : (i,j) in S}."""
    P = np.zeros((alg.N, alg.N))
    for k in S:
        P[k, k] = 1.0
    return P


def pair_projectors(alg, a):
    """k = Lambda^2 R^a + Lambda^2 R^b (b=n-a), m = R^a tensor R^b."""
    n = alg.n
    ka, kb, m = [], [], []
    for k, (i, j) in enumerate(alg.prs):
        if j < a:
            ka.append(k)
        elif i >= a:
            kb.append(k)
        else:
            m.append(k)
    return proj_block(alg, ka), proj_block(alg, kb), proj_block(alg, m)


def sphere_product_weyl(alg, a):
    """Weyl operator of the Einstein metric on S^a x S^b, b = n-a, normalised."""
    n = alg.n
    b = n - a
    Pa, Pb, Pm = pair_projectors(alg, a)
    # curvature operator k1*Pa + k2*Pb with (a-1)k1 = (b-1)k2 (Einstein), a,b>=2
    k1, k2 = (b - 1.0), (a - 1.0)
    R = k1 * Pa + k2 * Pb
    # subtract the constant-curvature piece to kill Ricci
    lam = (a - 1) * k1                      # Ricci eigenvalue
    W = R - (lam / (n - 1)) * np.eye(alg.N)
    return W / np.sqrt(np.sum(W * W))


def grading_involution(alg, a):
    """Conjugation by Lambda^2 diag(I_a, -I_b) acting on operators: sign per basis pair."""
    s = np.array([1.0 if (j < a or i >= a) else -1.0 for (i, j) in alg.prs])
    return np.outer(s, s)                    # W -> sigma * W (entrywise)


# ---------- ambient projector onto Weyl_n (no basis needed) -----------

def _sign_index(alg):
    n, N = alg.n, alg.N
    S = np.zeros((n, n), dtype=int)
    G = np.zeros((n, n))
    for k, (i, j) in enumerate(alg.prs):
        S[i, j] = k; S[j, i] = k
        G[i, j] = 1.0; G[j, i] = -1.0
    return S, G


class Proj:
    """Orthogonal projection Sym(Lambda^2) -> Weyl_n, built from the symmetries only."""

    def __init__(self, alg):
        self.alg = alg
        n, N = alg.n, alg.N
        self.S, self.G = _sign_index(alg)
        # Kulkarni-Nomizu images h (x) g, orthonormalised
        cols = []
        for a in range(n):
            for b in range(a, n):
                h = np.zeros((n, n)); h[a, b] = h[b, a] = 1.0
                cols.append(self.kn(h).reshape(-1))
        Kn = np.array(cols)
        Qm, _ = np.linalg.qr(Kn.T)
        self.KN = Qm.T                       # rows: ON basis of the Ricci directions

    def to4(self, M, i, j, k, l):
        return self.G[i, j] * self.G[k, l] * M[self.S[i, j], self.S[k, l]]

    def kn(self, h):
        n, alg = self.alg.n, self.alg
        M = np.zeros((alg.N, alg.N))
        for p, (i, j) in enumerate(alg.prs):
            for q, (k, l) in enumerate(alg.prs):
                M[p, q] = (h[i, k] * (j == l) + h[j, l] * (i == k)
                           - h[i, l] * (j == k) - h[j, k] * (i == l))
        return M

    def bianchi_part(self, M):
        """The self-adjoint projection onto the Lambda^4 part."""
        n, alg = self.alg.n, self.alg
        out = np.zeros_like(M)
        for p, (i, j) in enumerate(alg.prs):
            for q, (k, l) in enumerate(alg.prs):
                out[p, q] = (self.to4(M, i, j, k, l) + self.to4(M, i, k, l, j)
                             + self.to4(M, i, l, j, k)) / 3.0
        return out

    def build_matrices(self):
        """Cache the Bianchi projection as a dense matrix on flattened Sym."""
        alg = self.alg; N = alg.N
        E = np.eye(N * N).reshape(N * N, N, N)
        cols = [self.bianchi_part(0.5 * (e + e.T)).reshape(-1) for e in E]
        self.Bmat = np.array(cols).T
        return self.Bmat

    def apply(self, M):
        M = 0.5 * (M + M.T)
        M = M - self.bianchi_part(M)
        v = M.reshape(-1)
        v = v - self.KN.T @ (self.KN @ v)
        return v.reshape(M.shape)


class ProjFast(Proj):
    """Same projection, vectorised: Bianchi via cached index/sign arrays."""

    def __init__(self, alg):
        super().__init__(alg)
        N = alg.N
        S, G = self.S, self.G
        R = np.zeros((3, N, N), dtype=int); C = np.zeros((3, N, N), dtype=int)
        SG = np.zeros((3, N, N))
        for p, (i, j) in enumerate(alg.prs):
            for q, (k, l) in enumerate(alg.prs):
                for t, (a, b, c, d) in enumerate(((i, j, k, l), (i, k, l, j), (i, l, j, k))):
                    R[t, p, q] = S[a, b]; C[t, p, q] = S[c, d]
                    SG[t, p, q] = G[a, b] * G[c, d]
        self.R, self.C, self.SG = R, C, SG

    def bianchi_part(self, M):
        return (self.SG[0] * M[self.R[0], self.C[0]]
                + self.SG[1] * M[self.R[1], self.C[1]]
                + self.SG[2] * M[self.R[2], self.C[2]]) / 3.0


class Sharp:
    """Cached sharp bilinear at a fixed W."""

    def __init__(self, alg, W):
        self.alg = alg; self.W = W
        N = alg.N
        MW = alg.A @ W
        self.MWf = MW.reshape(N, N * N)
        self.MWt = MW.transpose(0, 2, 1).reshape(N, N * N)

    def bil(self, H):
        alg = self.alg; N = alg.N
        MH = alg.A @ H
        MHt = MH.transpose(0, 2, 1).reshape(N, N * N)
        Sm = self.MWf @ MHt.T
        return -0.25 * (Sm + Sm.T)

    def L(self, H):
        W = self.W
        return 0.5 * (W @ H + H @ W) + self.bil(H)
