"""r315 independent build: Weyl operators, Hamilton sharp, Q, P, L_W.
Nothing imported from the repository. Conventions fixed by Id^# = (n-2) Id.
"""
import numpy as np
import itertools


def pair_list(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]


def pair_index(n):
    P = pair_list(n)
    idx = {}
    for a, (i, j) in enumerate(P):
        idx[(i, j)] = (a, 1.0)
        idx[(j, i)] = (a, -1.0)
    return P, idx


def struct_consts(n):
    """C[a,b,c] = <[E_a,E_b], E_c>, inner product <X,Y> = -tr(XY)/2 (orthonormal E_ij)."""
    P = pair_list(n)
    N = len(P)
    E = np.zeros((N, n, n))
    for a, (i, j) in enumerate(P):
        E[a, i, j] = 1.0
        E[a, j, i] = -1.0
    C = np.zeros((N, N, N))
    for a in range(N):
        Ea = E[a]
        for b in range(N):
            Br = Ea @ E[b] - E[b] @ Ea
            for c, (i, j) in enumerate(P):
                v = Br[i, j]
                if v != 0.0:
                    C[a, b, c] = v
    return C, E


class Alg:
    def __init__(self, n):
        self.n = n
        self.P = pair_list(n)
        self.N = len(self.P)
        C, self.E = struct_consts(n)
        self.C = C
        nz = np.nonzero(C)
        self.bi, self.ci, self.pi = nz
        self.vi = C[nz]
        self.nnz = len(self.vi)

    # ---- Hamilton sharp, bilinear: (A#B)_{pq} = 1/2 sum C[b,c,p] C[e,f,q] A[b,e] B[c,f]
    def sharp(self, A, B):
        N = self.N
        M1 = np.zeros((N, N, N))          # M1[c,p,e]
        np.add.at(M1, (self.ci, self.pi), self.vi[:, None] * A[self.bi, :])
        T = np.zeros((N, N, N))           # T[e,q,c]
        np.add.at(T, (self.bi, self.pi), self.vi[:, None] * B[:, self.ci].T)
        # note: reuse index names -- C[e,f,q] with e=bi, f=ci, q=pi
        M1r = np.transpose(M1, (0, 2, 1)).reshape(N * N, N)   # (c,e) x p
        Tr = np.transpose(T, (2, 0, 1)).reshape(N * N, N)     # (c,e) x q
        R = 0.5 * (M1r.T @ Tr)
        return 0.5 * (R + R.T)

    def sharp_self(self, A):
        return self.sharp(A, A)

    def Q(self, W):
        return W @ W + self.sharp_self(W)

    def L(self, W, H):
        return 0.5 * (W @ H + H @ W) + self.sharp(W, H)


def frob(A, B):
    return float(np.sum(A * B))


# ---------- Weyl subspace ----------
def sym_basis_index(N):
    """orthonormal basis of Sym(N): (u,v) u<=v."""
    out = []
    for u in range(N):
        for v in range(u, N):
            out.append((u, v))
    return out


def weyl_basis(n, verbose=True):
    P, idx = pair_index(n)
    N = len(P)
    D = N * (N + 1) // 2
    sb = sym_basis_index(N)
    pos = {uv: d for d, uv in enumerate(sb)}

    def add(fun, a, b, coef):
        u, v = (a, b) if a <= b else (b, a)
        fun[(u, v)] = fun.get((u, v), 0.0) + coef * (1.0 if a != b else 1.0)

    rows = []

    def functional_to_row(fun):
        # fun: dict (a,b)->c meaning sum c * M[a,b]; symmetric M
        r = np.zeros(D)
        agg = {}
        for (a, b), c in fun.items():
            key = (a, b) if a <= b else (b, a)
            agg[key] = agg.get(key, 0.0) + c
        for (u, v), c in agg.items():
            if u == v:
                r[pos[(u, v)]] += c
            else:
                r[pos[(u, v)]] += c / np.sqrt(2.0) * np.sqrt(2.0) / np.sqrt(2.0) * np.sqrt(2.0)
        # careful path below replaces this
        return r

    # build rows explicitly with correct scaling
    def row_from(fun):
        r = np.zeros(D)
        agg = {}
        for (a, b), c in fun.items():
            key = (a, b) if a <= b else (b, a)
            agg[key] = agg.get(key, 0.0) + c
        for (u, v), c in agg.items():
            if u == v:
                r[pos[(u, v)]] += c
            else:
                r[pos[(u, v)]] += c * np.sqrt(2.0)   # <F,S_uv> with S orthonormal
        return r

    # Bianchi: for i<j<k<l : M[ij,kl] - M[ik,jl] + M[il,jk] = 0
    for i, j, k, l in itertools.combinations(range(n), 4):
        fun = {}
        a, sa = idx[(i, j)]; b, sb_ = idx[(k, l)]
        fun[(a, b)] = fun.get((a, b), 0.0) + sa * sb_
        a, sa = idx[(i, k)]; b, sb_ = idx[(j, l)]
        fun[(a, b)] = fun.get((a, b), 0.0) - sa * sb_
        a, sa = idx[(i, l)]; b, sb_ = idx[(j, k)]
        fun[(a, b)] = fun.get((a, b), 0.0) + sa * sb_
        rows.append(row_from(fun))

    # Ricci: Ric_{ab} = sum_c R(a,c,b,c) = 0
    for a_ in range(n):
        for b_ in range(a_, n):
            fun = {}
            for c_ in range(n):
                if c_ == a_ or c_ == b_:
                    continue
                p1, s1 = idx[(a_, c_)]
                p2, s2 = idx[(b_, c_)]
                fun[(p1, p2)] = fun.get((p1, p2), 0.0) + s1 * s2
            rows.append(row_from(fun))

    A = np.array(rows)
    # nullspace via complete QR of A^T
    Qm, Rm = np.linalg.qr(A.T, mode='complete')
    diag = np.abs(np.diag(Rm)) if Rm.shape[0] >= Rm.shape[1] else np.abs(np.diag(Rm))
    rank = int(np.sum(np.abs(np.diag(Rm[:min(Rm.shape)])) > 1e-8))
    Ns = Qm[:, rank:]
    dim = Ns.shape[1]
    # convert coefficient vectors to matrices
    B = np.zeros((dim, N, N))
    for d, (u, v) in enumerate(sb):
        col = Ns[d]
        if u == v:
            B[:, u, v] += col
        else:
            B[:, u, v] += col / np.sqrt(2.0)
            B[:, v, u] += col / np.sqrt(2.0)
    if verbose:
        print(f"n={n} N={N} D={D} constraints={A.shape[0]} rank={rank} dim(Weyl)={dim}")
    return B


def expected_weyl_dim(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12
