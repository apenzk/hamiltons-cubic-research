"""Reviewer 30: independent machinery for Conjecture A nondegeneracy audit.

Built from the definitions only:
  Lambda^2 R^n, orthonormal basis phi_{ij} = E_ij - E_ji (i<j), <X,Y> = 1/2 tr(X^T Y).
  c_{abg} = <[phi_a,phi_b],phi_g>;  (A_a)_{mn} = c_{amn}
  (W^#)_{ab} = -1/2 tr(A_a W A_b W);  Q(W) = W^2 + W^#;  P(W) = <W,Q(W)>
  Weyl_n = {Ricci-flat, Alt(W)=0}
  X o Y = 1/2 (Q(X+Y) - Q(X) - Q(Y))
"""
import numpy as np
import itertools, functools


def pair_index(n):
    pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    idx = {p: a for a, p in enumerate(pairs)}
    return pairs, idx


@functools.lru_cache(maxsize=None)
def structure_constants(n):
    """c[a,b,g] = <[phi_a,phi_b],phi_g>, totally antisymmetric."""
    pairs, idx = pair_index(n)
    N = len(pairs)
    # build phi as n x n matrices
    phi = np.zeros((N, n, n))
    for a, (i, j) in enumerate(pairs):
        phi[a, i, j] = 1.0
        phi[a, j, i] = -1.0
    c = np.zeros((N, N, N))
    # [phi_a, phi_b] then inner product 1/2 tr(X^T Y)
    for a in range(N):
        Pa = phi[a]
        comm = Pa @ phi - phi @ Pa           # (N,n,n)
        # <comm_b, phi_g> = 1/2 tr(comm_b^T phi_g)
        c[a] = 0.5 * np.einsum('bij,gij->bg', comm, phi)
    return c


@functools.lru_cache(maxsize=None)
def adj(n):
    """A[a] = A_a with (A_a)_{mn} = c_{amn}."""
    return structure_constants(n).copy()


def sharp(n, W):
    """(W^#)_{ab} = -1/2 tr(A_a W A_b W)."""
    A = adj(n)
    N = A.shape[0]
    M = (A.reshape(N * N, N) @ W).reshape(N, N, N)   # M[a] = A_a W
    Mf = M.reshape(N, N * N)
    Mtf = M.transpose(0, 2, 1).reshape(N, N * N)
    return -0.5 * (Mf @ Mtf.T)


def sharp_bilin(n, X, Y):
    """Polarized part of #: 1/2[(X+Y)^# - X^# - Y^#], entry_ab = -1/4(T_ab + T_ba),
    T_ab = tr(A_a X A_b Y)."""
    A = adj(n)
    N = A.shape[0]
    AX = (A.reshape(N * N, N) @ X).reshape(N, N, N)
    AY = (A.reshape(N * N, N) @ Y).reshape(N, N, N)
    T = AX.reshape(N, N * N) @ AY.transpose(0, 2, 1).reshape(N, N * N).T
    return -0.25 * (T + T.T)


def Q(n, W):
    return W @ W + sharp(n, W)


def circ(n, X, Y):
    return 0.5 * (X @ Y + Y @ X) + sharp_bilin(n, X, Y)


def P(n, W):
    return float(np.tensordot(W, Q(n, W)))


# ---------- Weyl space ----------

def weyl_constraints(n):
    """Linear constraints on symmetric N x N matrices W (Frobenius inner product):
    Bianchi (Alt(W)=0 -> Lambda^4 component) and Ricci(W)=0."""
    pairs, idx = pair_index(n)
    N = len(pairs)

    def Rget(W, i, j, k, l):
        if i == j or k == l:
            return 0.0
        s = 1.0
        if i > j:
            i, j, s = j, i, -s
        if k > l:
            k, l, s = l, k, -s
        return s * W[idx[(i, j)], idx[(k, l)]]

    rows = []
    # Bianchi on 4 distinct indices
    for (i, j, k, l) in itertools.combinations(range(n), 4):
        row = np.zeros((N, N))
        for (a, b, cc, d), sgn in (((i, j, k, l), 1.0), ((i, k, l, j), 1.0), ((i, l, j, k), 1.0)):
            row[idx[(a, b)] if a < b else idx[(b, a)],
                idx[(cc, d)] if cc < d else idx[(d, cc)]] += sgn * (1 if a < b else -1) * (1 if cc < d else -1)
        row = 0.5 * (row + row.T)
        rows.append(row)
    # Ricci
    for i in range(n):
        for k in range(i, n):
            row = np.zeros((N, N))
            for j in range(n):
                if j == i or j == k:
                    continue
                aa = idx[(min(i, j), max(i, j))]
                sa = 1.0 if i < j else -1.0
                bb = idx[(min(k, j), max(k, j))]
                sb = 1.0 if k < j else -1.0
                row[aa, bb] += sa * sb
            row = 0.5 * (row + row.T)
            rows.append(row)
    return np.array(rows)


def sym_basis(N):
    """orthonormal basis of Sym^2 as flattened N*N vectors (Frobenius)."""
    vs = []
    for a in range(N):
        E = np.zeros((N, N)); E[a, a] = 1.0
        vs.append(E)
    for a in range(N):
        for b in range(a + 1, N):
            E = np.zeros((N, N)); E[a, b] = E[b, a] = 1 / np.sqrt(2)
            vs.append(E)
    return np.array(vs)


@functools.lru_cache(maxsize=None)
def weyl_basis(n):
    """Orthonormal basis of Weyl_n as array (d, N, N), Frobenius-orthonormal."""
    pairs, idx = pair_index(n)
    N = len(pairs)
    C = weyl_constraints(n)              # (r, N, N)
    S = sym_basis(N)                     # (D, N, N)
    D = S.shape[0]
    Mat = np.einsum('rij,dij->rd', C, S)  # constraints in the sym coordinates
    # nullspace
    u, s, vt = np.linalg.svd(Mat, full_matrices=True)
    tol = max(Mat.shape) * (s[0] if s.size else 1.0) * 1e-12
    rank = int((s > tol).sum())
    ns = vt[rank:]                       # (d, D)
    B = np.einsum('kd,dij->kij', ns, S)
    return B


def dim_weyl_formula(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12


# ---------- sphere products ----------

def sphere_product_W(blocks):
    """Weyl operator of a product of round spheres, blocks = list of dims (each >=2).
    diagonal in coordinate 2-planes: 1/(p(p-1)) within block p, -1/(p q) across."""
    n = sum(blocks)
    pairs, idx = pair_index(n)
    N = len(pairs)
    lab = []
    for bi, b in enumerate(blocks):
        lab += [bi] * b
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(pairs):
        if lab[i] == lab[j]:
            p = blocks[lab[i]]
            W[a, a] = 1.0 / (p * (p - 1))
        else:
            p, q = blocks[lab[i]], blocks[lab[j]]
            W[a, a] = -1.0 / (p * q)
    return W, lab


def normalize(W):
    return W / np.sqrt(np.tensordot(W, W))


# ---------- orbit tangent ----------

def orbit_tangent(n, W, gens=None):
    """span of [ad(phi_a), W] = -[A_a, W]; returns array (k, N, N)."""
    A = adj(n)
    N = A.shape[0]
    if gens is None:
        gens = range(N)
    out = []
    for a in gens:
        out.append(A[a] @ W - W @ A[a])
    return np.array(out)


def orthonormalize(V, tol=1e-9):
    """V: (k, N, N) -> orthonormal (r, N*N) rows."""
    F = V.reshape(V.shape[0], -1)
    u, s, vt = np.linalg.svd(F, full_matrices=False)
    r = int((s > tol * max(1.0, s[0])).sum())
    return vt[:r]


def principal_cosines(U, V):
    """U,V orthonormal row-bases (r1,D),(r2,D)."""
    M = U @ V.T
    return np.linalg.svd(M, compute_uv=False)
