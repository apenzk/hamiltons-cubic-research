"""Reviewer 304: independent implementation of the Weyl algebra from the definitions.

Nothing under review is imported. Conventions fixed here and checked against the
record's own diagonal identities in r304_selfcheck.py.
"""
import itertools, numpy as np

# ---------- Lambda^2 = so(n) ----------
def pairs(n):
    return list(itertools.combinations(range(n), 2))

def basis_so(n):
    """Orthonormal basis B_a = (E_ij - E_ji)/sqrt2, <X,Y> = tr(X^T Y)."""
    P = pairs(n); B = np.zeros((len(P), n, n))
    for a, (i, j) in enumerate(P):
        B[a, i, j] = 1/np.sqrt(2); B[a, j, i] = -1/np.sqrt(2)
    return P, B

def struct_consts(n):
    """c[a,b,g] = <[B_a,B_b], B_g>, totally antisymmetric."""
    P, B = basis_so(n); m = len(P)
    c = np.zeros((m, m, m))
    for a in range(m):
        for b in range(m):
            K = B[a] @ B[b] - B[b] @ B[a]
            c[a, b, :] = np.einsum('gij,ij->g', B, K)
    return c

# ---------- the algebra ----------
def sharp_bilin(c, R, S):
    """(R # S)_{ab} = sum c_{a g d} c_{b e z} R_{g e} S_{d z}; symmetric in R,S.

    Normalisation fixed so that for coordinate-diagonal R,S the value at pair (ij)
    is (1/2) sum_k (r_ik s_jk + r_jk s_ik) -- Jaeger's diagonal # formula.
    """
    T = np.einsum('agd,ge->aed', c, R)
    U = np.einsum('bez,dz->bed', c, S)
    return np.einsum('aed,bed->ab', T, U)

def Q(c, W):
    return W @ W + sharp_bilin(c, W, W)

def L_W(c, W, H):
    """The polarisation: L_W H = (1/2)(Q(W+H)-Q(W)-Q(H)) = (WH+HW)/2 + W#H."""
    return (W @ H + H @ W) / 2 + sharp_bilin(c, W, H)

def P_cubic(c, W):
    return float(np.sum(W * Q(c, W)))

# ---------- diagonal locus ----------
def diag_op(M):
    """n x n hollow symmetric pair-weight matrix -> operator on Lambda^2."""
    n = M.shape[0]; P = pairs(n)
    return np.diag([M[i, j] for (i, j) in P])

def op_to_M(n, X):
    """pair-diagonal of an operator -> n x n hollow matrix (drops off-diagonal)."""
    P = pairs(n); M = np.zeros((n, n))
    for a, (i, j) in enumerate(P):
        M[i, j] = M[j, i] = X[a, a]
    return M

def offdiag_mass(n, X):
    D = np.diag(np.diag(X))
    return float(np.linalg.norm(X - D))

def hollow(A):
    return A - np.diag(np.diag(A))

def Phi(M):
    return M * M + M @ M

def theta_of(M):
    """theta = <M, Phi(M)>/<M,M> with <,> Frobenius; equals P(W) when tr M^2 = 2."""
    return float(np.sum(M * Phi(M)) / np.sum(M * M))

def crit_residual(M):
    """hollow(Phi(M)) - theta M ; zero iff M is a diagonal critical point."""
    return hollow(Phi(M)) - theta_of(M) * M

def calL(M, N):
    """claimed n x n second-order operator, hollow part."""
    return hollow(M * N + (M @ N + N @ M) / 2)

def calL_full(M, N):
    """the claim as literally written (no hollowing)."""
    return M * N + (M @ N + N @ M) / 2

def defect_delta(M, tol=1e-9):
    """Delta = sum over positive edges of g_ab, g_ab = 2||M_a-M_b||^2 - 4 M_ab^2."""
    n = M.shape[0]; s = (M * M).sum(1); M2 = M @ M; tot = 0.0; gs = []
    for i in range(n):
        for j in range(i+1, n):
            g = 2*(s[i]+s[j]) - 4*M2[i, j] - 4*M[i, j]**2
            gs.append(((i, j), M[i, j], g))
            if M[i, j] > tol:
                tot += g
    return tot, gs

# ---------- constraint spaces ----------
def basis_hollow_zero_rowsum(n):
    """orthonormal (Frobenius) basis of {N sym, hollow, N 1 = 0}, dim n(n-3)/2."""
    P = pairs(n); m = len(P)
    A = np.zeros((n, m))
    for a, (i, j) in enumerate(P):
        A[i, a] = 1; A[j, a] = 1
    # nullspace of A acting on the vector of pair weights
    u, sv, vt = np.linalg.svd(A)
    ns = vt[np.sum(sv > 1e-10):]
    out = []
    for v in ns:
        N = np.zeros((n, n))
        for a, (i, j) in enumerate(P):
            N[i, j] = N[j, i] = v[a]
        out.append(N / np.linalg.norm(N))
    return out  # each unit in Frobenius norm

def op_matrix(basisNs, action):
    """matrix of a linear map on a Frobenius-orthonormal list of matrices."""
    k = len(basisNs); Amat = np.zeros((k, k))
    for b in range(k):
        img = action(basisNs[b])
        for a in range(k):
            Amat[a, b] = float(np.sum(basisNs[a] * img))
    return Amat

def orth_complement_of(basisNs, M):
    """orthonormal basis of the span minus the direction M."""
    G = np.array([np.array(N).ravel() for N in basisNs])
    mv = np.array(M).ravel(); mv = mv / np.linalg.norm(mv)
    G = G - np.outer(G @ mv, mv)
    u, sv, vt = np.linalg.svd(G, full_matrices=False)
    keep = vt[sv > 1e-9]
    n = M.shape[0]
    return [k.reshape(n, n) for k in keep]
