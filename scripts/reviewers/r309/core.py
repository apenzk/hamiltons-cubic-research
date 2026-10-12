"""Reviewer 309 independent implementation. Nothing imported from scripts/lib."""
import numpy as np
import itertools

def pairs(n):
    return [(a, b) for a in range(n) for b in range(a + 1, n)]

def pidx(n):
    return {p: i for i, p in enumerate(pairs(n))}

def struct(n):
    """c[a,b,g] = <[phi_a,phi_b],phi_g> for orthonormal phi_ab = e_a ^ e_b.

    Realise phi_ab as the so(n) matrix A_ab = E_ab - E_ba (Frobenius <A,B>=(1/2)tr(A^T B)
    makes these orthonormal).  Bracket is the matrix commutator.
    """
    P = pairs(n); I = pidx(n); m = len(P)
    mats = np.zeros((m, n, n))
    for k, (a, b) in enumerate(P):
        mats[k, a, b] = 1.0; mats[k, b, a] = -1.0
    c = np.zeros((m, m, m))
    for i in range(m):
        for j in range(m):
            C = mats[i] @ mats[j] - mats[j] @ mats[i]
            for k in range(m):
                c[i, j, k] = 0.5 * np.tensordot(mats[k], C)
    return c

_CACHE = {}
def C(n):
    if n not in _CACHE:
        _CACHE[n] = struct(n)
    return _CACHE[n]

def sharp(R, S, n):
    """Hamilton's sharp, polarised: (R#S)_{ab} = (1/2) sum c_{a g d} c_{b e z} R_{g e} S_{d z}."""
    c = C(n)
    T = np.einsum('agd,bez,ge,dz->ab', c, c, R, S, optimize=True)
    return 0.5 * T

def Q(W, n):
    return W @ W + sharp(W, W, n)

def P_cubic(W, n):
    return float(np.tensordot(W, Q(W, n)))

def L(W, H, n):
    """L_W H = (WH+HW)/2 + W#H  = polarisation of Q."""
    return 0.5 * (W @ H + H @ W) + sharp(W, H, n)

# ---------- curvature-tensor bookkeeping ----------

def tensor_from_op(R, n):
    """R_{abcd} from the operator matrix in the orthonormal pair basis."""
    I = pidx(n); m = len(I)
    T = np.zeros((n, n, n, n))
    sgn = {}
    for (a, b), i in I.items():
        sgn[(a, b)] = (i, 1.0); sgn[(b, a)] = (i, -1.0)
    for a in range(n):
        for b in range(n):
            if a == b: continue
            i, si = sgn[(a, b)]
            for cc in range(n):
                for d in range(n):
                    if cc == d: continue
                    j, sj = sgn[(cc, d)]
                    T[a, b, cc, d] = si * sj * R[i, j]
    return T

def bianchi_resid(R, n):
    T = tensor_from_op(R, n)
    return T + np.transpose(T, (0, 2, 3, 1)) + np.transpose(T, (0, 3, 1, 2))

def ricci(R, n):
    T = tensor_from_op(R, n)
    return np.einsum('abcb->ac', T)

def weyl_basis(n, tol=1e-9):
    """Orthonormal basis (as m x m matrices) of algebraic Weyl operators:
    symmetric, first Bianchi, Ricci-flat."""
    P = pairs(n); m = len(P)
    sym = []
    for i in range(m):
        for j in range(i, m):
            E = np.zeros((m, m))
            E[i, j] = 1.0; E[j, i] = 1.0
            if i == j: E *= 1.0
            sym.append(E / np.linalg.norm(E))
    rows = []
    for E in sym:
        b = bianchi_resid(E, n).ravel()
        r = ricci(E, n).ravel()
        rows.append(np.concatenate([b, r]))
    A = np.array(rows).T            # constraints x dim(Sym)
    # null space
    u, s, vt = np.linalg.svd(A, full_matrices=True)
    ns = vt[np.sum(s > tol * max(1.0, s[0])):] if len(s) else vt
    # ns rows are coefficient vectors in the `sym` basis (orthonormal basis of Sym)
    B = []
    for coef in ns:
        Mx = np.zeros((m, m))
        for cf, E in zip(coef, sym):
            if cf != 0.0: Mx += cf * E
        B.append(Mx)
    return B

def diag_op(M):
    """Lambda^2 operator diag(w) from hollow symmetric n x n matrix M."""
    n = M.shape[0]; P = pairs(n); m = len(P)
    W = np.zeros((m, m))
    for i, (a, b) in enumerate(P):
        W[i, i] = M[a, b]
    return W

def mat_from_diagop(W, n):
    P = pairs(n); M = np.zeros((n, n))
    for i, (a, b) in enumerate(P):
        M[a, b] = W[i, i]; M[b, a] = W[i, i]
    return M

# ---------- symmetry defect ----------

def ad_matrix(v, n):
    """ad(v) as an m x m matrix, v a vector in Lambda^2 (orthonormal pair basis)."""
    c = C(n)
    # (ad v)_{g b} = <[v, phi_b], phi_g> = sum_a v_a c[a,b,g]
    return np.einsum('a,abg->gb', v, c)

def defect(W, n, tol=1e-9, only_positive=True):
    ev, V = np.linalg.eigh(W)
    tot = 0.0; per = []
    for k in range(len(ev)):
        if only_positive and ev[k] <= tol: 
            per.append((ev[k], None)); continue
        Ad = ad_matrix(V[:, k], n)
        g = np.linalg.norm(Ad @ W - W @ Ad) ** 2
        per.append((ev[k], g))
        tot += g
    return tot, per

# ---------- L_W as a matrix on the Weyl space ----------

def orthonormalise(B):
    m = B[0].shape[0]
    V = np.array([X.ravel() for X in B])
    u, s, vt = np.linalg.svd(V, full_matrices=False)
    keep = s > 1e-10 * s[0]
    return [vt[i].reshape(m, m) for i in range(len(s)) if keep[i]]

_WB = {}
def WB(n):
    if n not in _WB:
        _WB[n] = orthonormalise(weyl_basis(n))
    return _WB[n]

def L_matrix(W, n, basis=None):
    B = WB(n) if basis is None else basis
    k = len(B)
    LB = [L(W, X, n) for X in B]
    A = np.zeros((k, k))
    for i in range(k):
        for j in range(k):
            A[i, j] = np.tensordot(B[i], LB[j])
    return A, B

def lam_max_perp(W, n, theta=None, basis=None):
    """lambda_max of L_e restricted to Weyl_n cap W^perp, L_e = L_W/theta."""
    A, B = L_matrix(W, n, basis)
    k = len(B)
    w = np.array([np.tensordot(X, W) for X in B])
    w = w / np.linalg.norm(w)
    Pp = np.eye(k) - np.outer(w, w)
    Ar = Pp @ A @ Pp
    # restrict properly: build orthonormal basis of w^perp
    u, s, vt = np.linalg.svd(Pp)
    Z = u[:, s > 0.5]
    Ar = Z.T @ A @ Z
    Ar = 0.5 * (Ar + Ar.T)
    ev = np.linalg.eigvalsh(Ar)
    th = P_cubic(W, n) if theta is None else theta
    return ev[-1] / th, ev / th, th

# ---------- the diagonal-locus n x n operator ----------

def diag_locus_basis(n, ricci_flat=True):
    """Orthonormal basis of hollow symmetric n x n matrices (with zero row sums if asked)."""
    P = pairs(n); vecs = []
    for (a, b) in P:
        E = np.zeros((n, n)); E[a, b] = 1.0; E[b, a] = 1.0
        vecs.append(E / np.sqrt(2.0))
    if not ricci_flat:
        return vecs
    A = np.array([X.sum(1) for X in vecs]).T          # n x |P|
    u, s, vt = np.linalg.svd(A)
    ns = vt[np.sum(s > 1e-10):]
    out = []
    for coef in ns:
        Z = np.zeros((n, n))
        for cf, X in zip(coef, vecs): Z += cf * X
        out.append(Z)
    return out

def Lcal(M, N, hollow=True):
    Z = M * N + 0.5 * (M @ N + N @ M)
    if hollow: Z = Z - np.diag(np.diag(Z))
    return Z

def diag_lam_max(M, theta, exclude_radial=True, hollow=True):
    n = M.shape[0]
    B = diag_locus_basis(n)
    k = len(B)
    A = np.zeros((k, k))
    LB = [Lcal(M, X, hollow) for X in B]
    for i in range(k):
        for j in range(k):
            A[i, j] = np.tensordot(B[i], LB[j])
    A = 0.5 * (A + A.T)
    if exclude_radial:
        w = np.array([np.tensordot(X, M) for X in B])
        nw = np.linalg.norm(w)
        if nw > 1e-12:
            w = w / nw
            u, s, vt = np.linalg.svd(np.eye(k) - np.outer(w, w))
            Z = u[:, s > 0.5]
            A = Z.T @ A @ Z
    ev = np.linalg.eigvalsh(A)
    return ev[-1] / theta, ev / theta
