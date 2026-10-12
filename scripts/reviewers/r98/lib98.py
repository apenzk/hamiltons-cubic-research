"""Reviewer 98: independent implementation of algebraic Weyl tensors and cubic invariants.
Written from the brief's definitions only. No project code imported."""
import numpy as np
import itertools

# ---------- projections ----------

def proj_S2Lam2(T):
    """Orthogonal projection onto S^2(Lambda^2): antisym in (ij),(kl), sym pair swap."""
    A = T - np.transpose(T, (1, 0, 2, 3))
    A = A - np.transpose(A, (0, 1, 3, 2))
    A = A + np.transpose(A, (2, 3, 0, 1))
    return A / 8.0

def proj_bianchi(A):
    """For A in S^2(Lam^2): subtract the Lambda^4 (Bianchi) part."""
    b = (A + np.transpose(A, (1, 2, 0, 3)) + np.transpose(A, (2, 0, 1, 3))) / 3.0
    return A - b

def proj_curv(T):
    return proj_bianchi(proj_S2Lam2(T))

def ricci(R):
    """Ric_ij = sum_k R_{ikjk}."""
    return np.einsum('ikjk->ij', R)

def kn(A, B):
    """Kulkarni-Nomizu product."""
    return (np.einsum('ik,jl->ijkl', A, B) + np.einsum('jl,ik->ijkl', A, B)
            - np.einsum('il,jk->ijkl', A, B) - np.einsum('jk,il->ijkl', A, B))

def weyl_part(R, n):
    g = np.eye(n)
    Ric = ricci(R)
    s = np.trace(Ric)
    Ric0 = Ric - (s / n) * g
    return R - kn(Ric0, g) / (n - 2) - (s / (2 * n * (n - 1))) * kn(g, g)

def rand_weyl(n, rng):
    T = rng.standard_normal((n, n, n, n))
    return weyl_part(proj_curv(T), n)

def dim_weyl(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12

def check_weyl(W, n, tol=1e-9):
    errs = {}
    errs['antisym_ij'] = np.abs(W + np.transpose(W, (1, 0, 2, 3))).max()
    errs['antisym_kl'] = np.abs(W + np.transpose(W, (0, 1, 3, 2))).max()
    errs['pairsym'] = np.abs(W - np.transpose(W, (2, 3, 0, 1))).max()
    errs['bianchi'] = np.abs(W + np.transpose(W, (1, 2, 0, 3)) + np.transpose(W, (2, 0, 1, 3))).max()
    errs['tracefree'] = np.abs(ricci(W)).max()
    return errs

# ---------- Lambda^2 matrix ----------

def pairs(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]

def to_M(W, n):
    P = pairs(n)
    m = len(P)
    M = np.empty((m, m))
    for a, (i, j) in enumerate(P):
        for b, (k, l) in enumerate(P):
            M[a, b] = W[i, j, k, l]
    return M

def from_M(M, n):
    """Inverse: build W_{ijkl} from a symmetric matrix on Lambda^2 (pairs i<j)."""
    P = pairs(n)
    W = np.zeros((n, n, n, n))
    for a, (i, j) in enumerate(P):
        for b, (k, l) in enumerate(P):
            v = M[a, b]
            W[i, j, k, l] = v; W[j, i, k, l] = -v; W[i, j, l, k] = -v; W[j, i, l, k] = v
    return W

# ---------- so(n) structure constants and Hamilton sharp ----------

def struct_consts(n):
    """c[a,g,d] with [phi_g, phi_d] = sum_a c[a,g,d] phi_a,
    phi_ij = E_ij - E_ji, basis indexed by pairs i<j."""
    P = pairs(n)
    idx = {p: k for k, p in enumerate(P)}
    m = len(P)
    c = np.zeros((m, m, m))

    def add(i, l, coeff, g, d):
        if i == l:
            return
        if i < l:
            c[idx[(i, l)], g, d] += coeff
        else:
            c[idx[(l, i)], g, d] -= coeff

    for g, (i, j) in enumerate(P):
        for d, (k, l) in enumerate(P):
            # delta_jk phi_il - delta_ik phi_jl - delta_jl phi_ik + delta_il phi_jk
            if j == k: add(i, l, 1.0, g, d)
            if i == k: add(j, l, -1.0, g, d)
            if j == l: add(i, k, -1.0, g, d)
            if i == l: add(j, k, 1.0, g, d)
    return c

_CC = {}
def sharp(M, n):
    if n not in _CC:
        _CC[n] = struct_consts(n)
    c = _CC[n]
    # (M#)_ab = 1/2 c_{a g d} c_{b e z} M_{g e} M_{d z}
    return 0.5 * np.einsum('agd,bez,ge,dz->ab', c, c, M, M, optimize=True)

# ---------- invariants ----------

def alpha(W1, W2=None, W3=None):
    """W_tpsq W_tpkl W_sqkl  (raw, in the given argument order)."""
    if W2 is None: W2 = W1
    if W3 is None: W3 = W1
    return np.einsum('tpsq,tpkl,sqkl->', W1, W2, W3, optimize=True)

def beta(W1, W2=None, W3=None):
    """W_tspq W_tjpl W_sjql (raw)."""
    if W2 is None: W2 = W1
    if W3 is None: W3 = W1
    return np.einsum('tspq,tjpl,sjql->', W1, W2, W3, optimize=True)

def sym3(f, A, B, C):
    tot = 0.0
    for p in itertools.permutations([A, B, C]):
        tot += f(*p)
    return tot / 6.0

def ring_W(W, n):
    """Li's convention: (ring-W h)_{ij} = sum_{kl} W_{iklj} h_{kl}, on S^2 (orthonormal basis).
    For trace-free W, g is in the kernel, so tr over S^2 equals tr over S^2_0 for powers >= 1."""
    basis = []
    for i in range(n):
        E = np.zeros((n, n)); E[i, i] = 1.0
        basis.append(E)
    for i in range(n):
        for j in range(i + 1, n):
            E = np.zeros((n, n)); E[i, j] = E[j, i] = 1.0 / np.sqrt(2.0)
            basis.append(E)
    B = np.array(basis)                       # (N, n, n) orthonormal in Frobenius
    img = np.einsum('iklj,akl->aij', W, B, optimize=True)
    return np.einsum('aij,bij->ba', img, B, optimize=True)   # matrix entries <b, ring(a)>

def ring_W_0(W, n):
    """Same operator restricted to an explicit orthonormal basis of S^2_0."""
    basis = []
    for i in range(n):
        for j in range(i + 1, n):
            E = np.zeros((n, n)); E[i, j] = E[j, i] = 1.0 / np.sqrt(2.0)
            basis.append(E)
    # traceless diagonal: Gram-Schmidt on diag(1,-1,0..), etc.
    for k in range(1, n):
        d = np.zeros(n); d[:k] = 1.0; d[k] = -float(k)
        d /= np.linalg.norm(d)
        basis.append(np.diag(d))
    B = np.array(basis)
    img = np.einsum('iklj,akl->aij', W, B, optimize=True)
    return np.einsum('aij,bij->ba', img, B, optimize=True)

def theta_of(W, n, normalize=True):
    M = to_M(W, n)
    if normalize:
        M = M / np.linalg.norm(M)
    Ms = sharp(M, n)
    return np.trace(M @ M @ M) + np.sum(Ms * M), M
