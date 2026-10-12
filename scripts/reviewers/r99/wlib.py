"""Reviewer 99: independent implementation from brief2.md definitions only."""
import numpy as np, itertools

# ---------- index helpers ----------
def pairs(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]

# ---------- tensor projections ----------
def sym_riemann(T):
    """orthogonal projection onto S^2(Lambda^2)."""
    T = 0.5 * (T - T.transpose(1, 0, 2, 3))
    T = 0.5 * (T - T.transpose(0, 1, 3, 2))
    T = 0.5 * (T + T.transpose(2, 3, 0, 1))
    return T

def bianchi_A(R):
    """(1/3)(R_ijkl + R_iklj + R_iljk); on S^2(L^2) this is the projection onto Lambda^4."""
    return (R + R.transpose(0, 2, 3, 1) + R.transpose(0, 3, 1, 2)) / 3.0

def kn(h):
    """Kulkarni-Nomizu with g = identity."""
    n = h.shape[0]
    I = np.eye(n)
    return (np.einsum('ik,jl->ijkl', h, I) + np.einsum('jl,ik->ijkl', h, I)
            - np.einsum('il,jk->ijkl', h, I) - np.einsum('jk,il->ijkl', h, I))

_KNB = {}
def kn_basis(n):
    """orthonormal basis (flattened) of the KN image inside Riem."""
    if n in _KNB:
        return _KNB[n]
    vecs = []
    for i in range(n):
        for j in range(i, n):
            h = np.zeros((n, n)); h[i, j] = 1.0; h[j, i] = 1.0
            vecs.append(kn(h).reshape(-1))
    Aa = np.array(vecs).T
    Q, R = np.linalg.qr(Aa)
    keep = np.abs(np.diag(R)) > 1e-9 * max(1.0, np.abs(np.diag(R)).max())
    Q = Q[:, keep]
    _KNB[n] = Q
    return Q

def pr(T):
    """orthogonal projection of an arbitrary (n,n,n,n) array onto W_n."""
    n = T.shape[0]
    R = sym_riemann(T)
    R = R - bianchi_A(R)
    Q = kn_basis(n)
    v = R.reshape(-1)
    v = v - Q @ (Q.T @ v)
    return v.reshape(n, n, n, n)

def dim_W(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12

def rand_weyl(n, rng):
    T = rng.standard_normal((n, n, n, n))
    W = pr(T)
    return W

# ---------- Lambda^2 operator ----------
def M_of(W):
    n = W.shape[0]
    P = pairs(n)
    return np.array([[W[i, j, k, l] for (k, l) in P] for (i, j) in P])

def tensor_of_M(X, n):
    """the antisymmetric-extension identification: T_ijkl = X_{(ij),(kl)} with signs."""
    P = pairs(n)
    idx = {p: a for a, p in enumerate(P)}
    T = np.zeros((n, n, n, n))
    for (i, j) in P:
        for (k, l) in P:
            v = X[idx[(i, j)], idx[(k, l)]]
            for (a, b, sab) in ((i, j, 1), (j, i, -1)):
                for (c, d, scd) in ((k, l, 1), (l, k, -1)):
                    T[a, b, c, d] = sab * scd * v
    return T

# ---------- S^2_0 basis and ring(W) ----------
_S20 = {}
def s20_basis(n):
    """orthonormal (Frobenius) basis of trace-free symmetric 2-tensors."""
    if n in _S20:
        return _S20[n]
    B = []
    for i in range(n):
        for j in range(i + 1, n):
            h = np.zeros((n, n)); h[i, j] = h[j, i] = 1 / np.sqrt(2.0)
            B.append(h)
    for k in range(1, n):
        h = np.zeros((n, n))
        for i in range(k):
            h[i, i] = 1.0
        h[k, k] = -float(k)
        h /= np.linalg.norm(h)
        B.append(h)
    B = np.array(B)
    _S20[n] = B
    return B

def ringW(W):
    """Li convention: (ring W h)_{ij} = sum_{kl} W_{iklj} h_{kl}, matrix in the S^2_0 basis."""
    n = W.shape[0]
    B = s20_basis(n)
    # image of basis element b: A_ij = W_{iklj} b_kl
    img = np.einsum('iklj,bkl->bij', W, B)
    return np.einsum('bij,cij->cb', img, B)

# ---------- Hamilton sharp ----------
_CS = {}
def struct_const(n):
    """c[a,g,d]: [phi_g, phi_d] = sum_a c[a,g,d] phi_a, phi_ij = E_ij - E_ji (unnormalised)."""
    if n in _CS:
        return _CS[n]
    P = pairs(n)
    m = len(P)
    ph = np.zeros((m, n, n))
    for a, (i, j) in enumerate(P):
        ph[a, i, j] = 1.0; ph[a, j, i] = -1.0
    C = np.zeros((m, m, m))
    for g in range(m):
        for d in range(m):
            X = ph[g] @ ph[d] - ph[d] @ ph[g]
            for a, (i, j) in enumerate(P):
                C[a, g, d] = X[i, j]
    _CS[n] = C
    return C

def sharp(M, n):
    C = struct_const(n)
    return 0.5 * np.einsum('agd,bez,ge,dz->ab', C, C, M, M, optimize=True)

def p3(X):
    return float(np.trace(X @ X @ X))

def theta_of_W(W, normalise=True):
    n = W.shape[0]
    M = M_of(W)
    if normalise:
        M = M / np.linalg.norm(M)
        W = W / np.linalg.norm(M_of(W))
    Ms = sharp(M, n)
    return float(np.trace(M @ M @ M) + np.sum(Ms * M)), M, W

def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n
