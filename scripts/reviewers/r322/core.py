"""Reviewer 322: independent implementation from the definitions. No repo imports."""
import numpy as np, itertools, functools

# ---------- so(n) = Lambda^2(R^n), orthonormal basis phi_{ij} = E_ij ----------
# <A,B> = -(1/2) tr(AB) on skew matrices;  |E_ij| = 1.

@functools.lru_cache(maxsize=None)
def pairs(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]

@functools.lru_cache(maxsize=None)
def pidx(n):
    return {p: a for a, p in enumerate(pairs(n))}

@functools.lru_cache(maxsize=None)
def basis(n):
    """(N,n,n) array of E_ij."""
    N = n * (n - 1) // 2
    B = np.zeros((N, n, n))
    for a, (i, j) in enumerate(pairs(n)):
        B[a, i, j] = 1.0
        B[a, j, i] = -1.0
    return B

def ip(A, B):
    """inner product on skew matrices, batched over leading axes."""
    return -0.5 * np.einsum('...ij,...ji->...', A, B)

@functools.lru_cache(maxsize=None)
def adjoints(n):
    """A[a] = matrix of ad(phi_a) in the orthonormal basis: (A[a])[b,c] s.t.
       [phi_a, phi_c] = sum_b A[a][b,c] phi_b."""
    B = basis(n)
    N = B.shape[0]
    # commutators C[a,c] = [phi_a, phi_c]
    C = np.einsum('aij,cjk->acik', B, B) - np.einsum('cij,ajk->acik', B, B)
    A = -0.5 * np.einsum('acij,bji->abc', C, B)   # A[a][b,c] = <[phi_a,phi_c],phi_b>
    return A

def struct(n):
    """c[a,b,c] = <[phi_a,phi_b],phi_c>, totally antisymmetric."""
    A = adjoints(n)
    return np.einsum('acb->abc', A)   # A[a][c,b] = <[phi_a,phi_b],phi_c>

# ---------- Hamilton sharp, in the record's stated convention ----------
def sharp(n, W):
    """sharp(n,W)_{ab} = -(1/2) tr(A_a W A_b W)."""
    A = adjoints(n)
    Bm = np.einsum('apq,qr->apr', A, W)          # B_a = A_a W
    N = W.shape[0]
    X = Bm.reshape(N, N * N)
    Y = np.transpose(Bm, (0, 2, 1)).reshape(N, N * N)
    return -0.5 * (X @ Y.T)

def Qop(n, W):
    return W @ W + sharp(n, W)

# ---------- Weyl space ----------
def to4(n, W):
    """R4[i,j,k,l] from the Lambda^2 matrix."""
    idx = pidx(n)
    S = np.zeros((n, n), dtype=int)      # signed pair index+1
    for (i, j), a in idx.items():
        S[i, j] = a + 1
        S[j, i] = -(a + 1)
    R4 = np.zeros((n, n, n, n))
    for i in range(n):
        for j in range(n):
            if i == j: continue
            si = 1 if i < j else -1
            a = abs(S[i, j]) - 1
            for k in range(n):
                for l in range(n):
                    if k == l: continue
                    sk = 1 if k < l else -1
                    b = abs(S[k, l]) - 1
                    R4[i, j, k, l] = si * sk * W[a, b]
    return R4

def ricci(n, W):
    R4 = to4(n, W)
    return np.einsum('ijkj->ik', R4)

def bianchi_defect(n, W):
    R4 = to4(n, W)
    return R4 + np.transpose(R4, (0, 2, 3, 1)) + np.transpose(R4, (0, 3, 1, 2))

@functools.lru_cache(maxsize=None)
def weyl_basis(n):
    """Orthonormal basis (K, N, N) of symmetric ops on Lambda^2 with
       first Bianchi and Ric = 0.  Built as a nullspace; no repo code."""
    N = n * (n - 1) // 2
    # orthonormal basis of Sym(N)
    sb = []
    for a in range(N):
        M = np.zeros((N, N)); M[a, a] = 1.0; sb.append(M)
    for a in range(N):
        for b in range(a + 1, N):
            M = np.zeros((N, N)); M[a, b] = M[b, a] = 1 / np.sqrt(2); sb.append(M)
    sb = np.array(sb)
    D = sb.shape[0]
    quads = list(itertools.combinations(range(n), 4))
    rows = []
    for M in sb:
        R4 = to4(n, M)
        r = [R4[i, j, k, l] + R4[i, k, l, j] + R4[i, l, j, k] for (i, j, k, l) in quads]
        Ric = np.einsum('ijkj->ik', R4)
        r += [Ric[i, k] for i in range(n) for k in range(i, n)]
        rows.append(r)
    Cst = np.array(rows).T                       # constraints x D
    u, s, vt = np.linalg.svd(Cst)
    rank = int((s > 1e-9 * s[0]).sum())
    ns = vt[rank:]                               # (K, D)
    K = ns.shape[0]
    out = np.einsum('kd,dij->kij', ns, sb)
    return out

def wproj(n, X):
    Bw = weyl_basis(n)
    co = np.einsum('kij,ij->k', Bw, X)
    return np.einsum('k,kij->ij', co, Bw)

def frob(A, B): return float(np.sum(A * B))
