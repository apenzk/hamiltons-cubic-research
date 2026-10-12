"""Reviewer 330 -- independent implementation of Weyl_n, Q = W^2 + W^#, criticality,
Lemma 70's deficiency D, and the saturation structure.  Built from definitions only.
"""
import numpy as np
import itertools


# ---------- so(n) as Lambda^2 R^n, orthonormal basis ----------

def pairs(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]


def basis(n):
    """phi_a = (e_i e_j^T - e_j e_i^T)/sqrt(2); orthonormal for <A,B> = tr(A^T B)."""
    P = pairs(n)
    B = np.zeros((len(P), n, n))
    for a, (i, j) in enumerate(P):
        B[a, i, j] = 1 / np.sqrt(2)
        B[a, j, i] = -1 / np.sqrt(2)
    return B


def structure(n):
    """c[a,b,c] = <[phi_a, phi_b], phi_c>.  Totally antisymmetric."""
    B = basis(n)
    N = B.shape[0]
    # [phi_a, phi_b] = phi_a phi_b - phi_b phi_a
    Bf = B.reshape(N, n * n)
    prod = np.einsum('aij,bjk->abik', B, B)
    br = prod - np.transpose(prod, (1, 0, 2, 3))
    c = np.einsum('abik,cik->abc', br, B)
    # Fix the identification scale: Hamilton's # uses e_i^e_j <-> (e_i e_j^T - e_j e_i^T)
    # declared ORTHONORMAL, i.e. inner product (1/2)tr(A^T B).  Rescaling the basis by
    # sqrt(2) scales the structure constants by sqrt(2).  Check: sharp(I) = (n-2) I.
    return np.sqrt(2.0) * c


# ---------- Hamilton's # ----------

def sharp(W, c):
    """(W^#)_{ab} = 1/2 sum c_{acd} c_{bef} W_{ce} W_{df} = 1/2 tr((C^a)^T W C^b W)."""
    # M[a] = C^a = c[a,:,:]
    # tmp[a] = (C^a)^T W  -> then W^#_{ab} = 1/2 tr(tmp[a] C^b W)
    tmp = np.einsum('acd,ce->ade', c, W)          # (C^a)^T W  with index (a, d, e)  [C^a antisym => (C^a)^T_{dc}=c_{acd}... careful below]
    # explicit: sum_{cdef} c_{acd} c_{bef} W_{ce} W_{df}
    X = np.einsum('acd,ce->ade', c, W)            # X[a,d,e] = sum_c c_{acd} W_{ce}
    Y = np.einsum('ade,df->aef', X, W)            # Y[a,e,f] = sum_d X[a,d,e] W_{df}
    return 0.5 * np.einsum('aef,bef->ab', Y, c)


def Q(W, c):
    return W @ W + sharp(W, c)


# ---------- Weyl_n ----------

def weyl_projector_data(n):
    """Return (basis of Sym^2(Lambda^2) as flat vectors is implicit) an orthonormal
    basis U (columns) of the Weyl subspace inside Sym^2(Lambda^2 R^n).

    Weyl = {W symmetric on Lambda^2 : first Bianchi = 0, Ric = 0}.
    """
    P = pairs(n)
    N = len(P)
    idx = {p: a for a, p in enumerate(P)}

    def R(Wm, i, j, k, l):
        """R_{ijkl} = <W(e_i ^ e_j), e_k ^ e_l> with e_i^e_j the ORTHONORMAL basis
        vector phi_{(i,j)} (so a constant overall factor, irrelevant to kernels)."""
        if i == j or k == l:
            return 0.0
        si = 1.0
        if i > j:
            i, j = j, i
            si = -si
        if k > l:
            k, l = l, k
            si = -si
        return si * Wm[idx[(i, j)], idx[(k, l)]]

    # coordinates on Sym^2(Lambda^2): upper triangle (a<=b)
    coords = [(a, b) for a in range(N) for b in range(a, N)]
    ncoord = len(coords)

    def sym_from_vec(v):
        M = np.zeros((N, N))
        for t, (a, b) in enumerate(coords):
            M[a, b] = v[t]
            M[b, a] = v[t]
        return M

    # build constraint rows by acting on basis elements
    rows = []
    quads = list(itertools.combinations(range(n), 4))
    trips = [(i, k) for i in range(n) for k in range(i, n)]

    # Precompute for speed: constraint value is linear in the coords.
    # Bianchi rows
    Cb = np.zeros((len(quads) * 3, ncoord))
    Cr = np.zeros((len(trips), ncoord))
    E = np.eye(ncoord)
    # Instead of per-basis-element loops (slow), assemble analytically.
    # Bianchi at (i,j,k,l): R_{ijkl} + R_{iklj} + R_{iljk} = 0.
    # For 4 distinct indices this gives, over the C(n,4) quadruples, 3 relations
    # (choices of which index is "i"); classically the Bianchi map lands in Lambda^4
    # which is C(n,4)-dimensional, so one relation per quadruple suffices, but we add
    # the redundant ones -- harmless for a kernel computation.
    def add_row(target, r, terms):
        for (a, b, s) in terms:
            if a > b:
                a, b = b, a
            t = coords_index[(a, b)]
            target[r, t] += s

    coords_index = {(a, b): t for t, (a, b) in enumerate(coords)}

    def Rterms(i, j, k, l):
        """R_{ijkl} as (a,b,sign) into the symmetric-coordinate vector."""
        if i == j or k == l:
            return []
        s = 1.0
        if i > j:
            i, j = j, i
            s = -s
        if k > l:
            k, l = l, k
            s = -s
        a, b = idx[(i, j)], idx[(k, l)]
        return [(a, b, s)]

    r = 0
    for (p, q, u, w) in quads:
        for perm in [(p, q, u, w), (q, p, u, w), (u, p, q, w)]:
            i, j, k, l = perm
            terms = Rterms(i, j, k, l) + Rterms(i, k, l, j) + Rterms(i, l, j, k)
            add_row(Cb, r, terms)
            r += 1
    Cb = Cb[:r]

    for r2, (i, k) in enumerate(trips):
        terms = []
        for j in range(n):
            terms += Rterms(i, j, k, j)
        add_row(Cr, r2, terms)

    Cons = np.vstack([Cb, Cr])
    # Weyl = kernel of Cons in the coordinate space -- BUT the coordinate space is not
    # orthonormal (off-diagonal coords carry weight 2 in Frobenius).  Rescale so the
    # coordinate vector is an isometry onto Sym^2 with Frobenius norm.
    wgt = np.array([1.0 if a == b else np.sqrt(2.0) for (a, b) in coords])
    Cons_o = Cons / wgt[None, :]          # constraint in orthonormal coordinates
    # kernel via SVD
    U, S, Vt = np.linalg.svd(Cons_o, full_matrices=True)
    tol = max(Cons_o.shape) * S.max() * 1e-12 if S.size else 0.0
    rank = int((S > tol).sum())
    K = Vt[rank:].T                        # orthonormal basis of the kernel, columns
    return coords, coords_index, wgt, K


class Weyl:
    def __init__(self, n):
        self.n = n
        self.N = n * (n - 1) // 2
        self.c = structure(n)
        self.coords, self.cidx, self.wgt, self.K = weyl_projector_data(n)

    def to_vec(self, W):
        v = np.array([W[a, b] for (a, b) in self.coords])
        return v * self.wgt

    def from_vec(self, v):
        v = v / self.wgt
        M = np.zeros((self.N, self.N))
        for t, (a, b) in enumerate(self.coords):
            M[a, b] = v[t]
            M[b, a] = v[t]
        return M

    def project(self, W):
        W = 0.5 * (W + W.T)
        v = self.to_vec(W)
        return self.from_vec(self.K @ (self.K.T @ v))

    def dist(self, W):
        W = 0.5 * (W + W.T)
        return np.linalg.norm(W - self.project(W))

    def dim(self):
        return self.K.shape[1]
