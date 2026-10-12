"""Reviewer 324 -- independent build of so(n), #, Weyl_n, criticality.
Conventions: Lambda^2 R^n identified with so(n) via e_i^e_j <-> L_ij = E_ij - E_ji,
inner product <X,Y> = (1/2) tr(X^T Y), so {L_ij}_{i<j} is orthonormal.
Bracket = matrix commutator.  C[a,b,c] = <[phi_a,phi_b],phi_c>, totally antisymmetric.
Sharp:  (W#)_{ab} = (1/2) sum_{cdef} C[a,c,d] C[b,e,f] W[c,e] W[d,f].
"""
import numpy as np, itertools, functools

def pairs(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]

@functools.lru_cache(maxsize=None)
def basis(n):
    P = pairs(n)
    L = np.zeros((len(P), n, n))
    for a, (i, j) in enumerate(P):
        L[a, i, j] = 1.0
        L[a, j, i] = -1.0
    return P, L

@functools.lru_cache(maxsize=None)
def struct(n):
    """C[a,b,c] = <[L_a,L_b],L_c> with <X,Y>=(1/2)tr(X^T Y)."""
    P, L = basis(n)
    N = len(P)
    C = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            Cm = L[a] @ L[b] - L[b] @ L[a]
            for c, (i, j) in enumerate(P):
                C[a, b, c] = Cm[i, j]          # (1/2)tr(Cm^T L_c) = Cm[i,j]
    return C

def sharp(W, n):
    C = struct(n)
    X = np.einsum('acd,ce->ade', C, W, optimize=True)
    Y = np.einsum('ade,df->aef', X, W, optimize=True)
    return 0.5 * np.einsum('aef,bef->ab', Y, C, optimize=True)

def Q(W, n):
    return W @ W + sharp(W, n)

def adv(v, n):
    """ad(v) as a matrix on Lambda^2 in the orthonormal basis; v given in that basis."""
    C = struct(n)
    return np.einsum('a,abc->cb', v, C, optimize=True)   # (ad v)_{cb} = <[v,phi_b],phi_c>

# ---------------- curvature-tensor structure ----------------
@functools.lru_cache(maxsize=None)
def _idx(n):
    P = pairs(n)
    d = {}
    for a, (i, j) in enumerate(P):
        d[(i, j)] = (a, 1.0)
        d[(j, i)] = (a, -1.0)
    return P, d

def to4(W, n):
    P, d = _idx(n)
    R = np.zeros((n, n, n, n))
    for a, (i, j) in enumerate(P):
        for b, (k, l) in enumerate(P):
            w = W[a, b]
            for (ii, jj, s1) in ((i, j, 1.0), (j, i, -1.0)):
                for (kk, ll, s2) in ((k, l, 1.0), (l, k, -1.0)):
                    R[ii, jj, kk, ll] = s1 * s2 * w
    return R

@functools.lru_cache(maxsize=None)
def weyl_basis(n):
    """Orthonormal basis (in Sym(Lambda^2)) of algebraic Weyl operators: Bianchi + Ric=0."""
    P = pairs(n)
    N = len(P)
    sym = [(a, b) for a in range(N) for b in range(a, N)]
    M = len(sym)
    rows = []
    # first Bianchi: R_ijkl + R_jkil + R_kijl = 0  for i<j<k, all l
    _, d = _idx(n)
    def coef(i, j, k, l):
        """linear functional row for R_{ijkl} in terms of the sym coordinates"""
        if i == j or k == l:
            return {}
        a, s1 = d[(i, j)]
        b, s2 = d[(k, l)]
        key = (min(a, b), max(a, b))
        return {key: s1 * s2}
    cons = []
    for i, j, k in itertools.combinations(range(n), 3):
        for l in range(n):
            acc = {}
            for (x, y, z) in ((i, j, k), (j, k, i), (k, i, j)):
                for key, val in coef(x, y, z, l).items():
                    acc[key] = acc.get(key, 0.0) + val
            if acc:
                cons.append(acc)
    # Ricci: sum_j R_{ijkj} = 0
    for i in range(n):
        for k in range(i, n):
            acc = {}
            for j in range(n):
                for key, val in coef(i, j, k, j).items():
                    acc[key] = acc.get(key, 0.0) + val
            if acc:
                cons.append(acc)
    A = np.zeros((len(cons), M))
    pos = {s: t for t, s in enumerate(sym)}
    for r, acc in enumerate(cons):
        for key, val in acc.items():
            A[r, pos[key]] = val
    # coordinates are the upper-triangular entries; the natural inner product on
    # Sym is sum_{a<=b} m_ab * x_ab^2 with m=1 on diagonal, 2 off.  Rescale to
    # make the coordinate frame orthonormal.
    w = np.array([1.0 if a == b else np.sqrt(2.0) for (a, b) in sym])
    A = A / w[None, :]
    u, s, vt = np.linalg.svd(A, full_matrices=True)
    tol = max(A.shape) * np.finfo(float).eps * (s[0] if s.size else 1.0)
    rank = int((s > tol).sum())
    ns = vt[rank:]                      # (dim, M) orthonormal rows in rescaled coords
    B = np.zeros((ns.shape[0], N, N))
    for t, (a, b) in enumerate(sym):
        f = 1.0 / w[t]
        B[:, a, b] += ns[:, t] * f
        if a != b:
            B[:, b, a] += ns[:, t] * f
    return B                            # orthonormal in the Frobenius inner product

def weyl_proj(W, n):
    B = weyl_basis(n)
    c = np.einsum('kab,ab->k', B, W, optimize=True)
    return np.einsum('k,kab->ab', c, B, optimize=True)

def weyl_resid(W, n):
    return np.linalg.norm(W - weyl_proj(W, n)) / max(np.linalg.norm(W), 1e-300)

def crit_resid(W, n):
    """||Q(W) - theta W|| / ||W||  with theta = <W,Q(W)>/||W||^2."""
    q = Q(W, n)
    th = float(np.sum(W * q) / np.sum(W * W))
    return float(np.linalg.norm(q - th * W) / np.linalg.norm(W)), th

def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n
