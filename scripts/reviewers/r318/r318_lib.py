"""Reviewer 318: independent implementation of the Weyl/Q/P/Delta framework.
Built from definitions only; imports nothing from the repository."""
import numpy as np
import itertools

# ---------- Lambda^2(R^n) ~ so(n), basis A_ij = E_ij - E_ji, <A,B> = 1/2 tr(A^T B) ----------

def pairs(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]

def basis_mats(n):
    P = pairs(n)
    N = len(P)
    B = np.zeros((N, n, n))
    for a, (i, j) in enumerate(P):
        B[a, i, j] = 1.0
        B[a, j, i] = -1.0
    return B  # <B[a],B[b]> = 1/2 tr(B[a]^T B[b]) = delta_ab

def vec_to_mat(v, n):
    return np.einsum('a,aij->ij', v, basis_mats(n))

def mat_to_vec(X, n):
    B = basis_mats(n)
    return 0.5 * np.einsum('aij,ij->a', B, X)

def struct_const(n):
    """c[a,b,g] = <[A_a,A_b], A_g>  (orthonormal basis, so totally antisymmetric)."""
    B = basis_mats(n)
    N = B.shape[0]
    br = np.einsum('aik,bkj->abij', B, B) - np.einsum('bik,akj->abij', B, B)
    return 0.5 * np.einsum('abij,gij->abg', br, B)

_CACHE = {}
def C(n):
    if n not in _CACHE:
        _CACHE[n] = struct_const(n)
    return _CACHE[n]

# ---------- Q(W) = W^2 + W^#,  P(W) = <W, Q(W)> ----------

def sharp(W, n):
    """W^#_{ab} = 1/2 sum c_{a g d} c_{b e z} W_{g e} W_{d z}."""
    c = C(n)
    M = np.einsum('agd,ge,dz->aez', c, W, W)
    return 0.5 * np.einsum('aez,bez->ab', M, c)

def Q(W, n):
    return W @ W + sharp(W, n)

def P(W, n):
    return float(np.sum(W * Q(W, n)))

def theta_of(W, n):
    """theta from Q(W) = theta W at unit norm; also returns criticality residual."""
    Wn = W / np.linalg.norm(W)
    QW = Q(Wn, n)
    th = float(np.sum(Wn * QW))
    return th, float(np.linalg.norm(QW - th * Wn))

# ---------- the Weyl space ----------

def bianchi_rows(n):
    """rows of the map Sym(Lambda^2) -> Lambda^4 (first Bianchi)."""
    P4 = pairs(n)
    idx = {p: a for a, p in enumerate(P4)}
    N = len(P4)
    def ent(i, j, k, l):
        # coefficient extraction with antisymmetry in each slot
        if i == j or k == l:
            return None
        si, a = (1, (i, j)) if i < j else (-1, (j, i))
        sk, b = (1, (k, l)) if k < l else (-1, (l, k))
        return si * sk, idx[a], idx[b]
    rows = []
    for i, j, k, l in itertools.combinations(range(n), 4):
        M = np.zeros((N, N))
        for (a, b, cc, d) in [(i, j, k, l), (i, k, l, j), (i, l, j, k)]:
            s, u, v = ent(a, b, cc, d)
            M[u, v] += s
            M[v, u] += s
        rows.append(M)
    return rows

def ricci_rows(n):
    """rows of Sym(Lambda^2) -> Sym^2(R^n):  Ric_{jl} = sum_i R_{(ij),(il)}."""
    P2 = pairs(n)
    idx = {p: a for a, p in enumerate(P2)}
    N = len(P2)
    def ent(i, j):
        if i == j:
            return None
        return (1, idx[(i, j)]) if i < j else (-1, idx[(j, i)])
    rows = []
    for j in range(n):
        for l in range(j, n):
            M = np.zeros((N, N))
            for i in range(n):
                e1 = ent(i, j); e2 = ent(i, l)
                if e1 is None or e2 is None:
                    continue
                s1, u = e1; s2, v = e2
                M[u, v] += 0.5 * s1 * s2
                M[v, u] += 0.5 * s1 * s2
            rows.append(M)
    return rows

def weyl_basis(n):
    """orthonormal basis of the Weyl space inside Sym(Lambda^2), as (d, N, N)."""
    P2 = pairs(n)
    N = len(P2)
    sym_idx = [(a, b) for a in range(N) for b in range(a, N)]
    D = len(sym_idx)
    def flat(M):
        return np.array([M[a, b] * (1.0 if a == b else np.sqrt(2.0)) for a, b in sym_idx])
    rows = [flat(M) for M in bianchi_rows(n)] + [flat(M) for M in ricci_rows(n)]
    A = np.array(rows)
    # nullspace of A
    u, s, vt = np.linalg.svd(A)
    rank = int((s > 1e-9 * s.max()).sum())
    ns = vt[rank:]
    out = np.zeros((ns.shape[0], N, N))
    for t, row in enumerate(ns):
        M = np.zeros((N, N))
        for k, (a, b) in enumerate(sym_idx):
            val = row[k] / (1.0 if a == b else np.sqrt(2.0))
            M[a, b] = val
            M[b, a] = val
        out[t] = M / np.linalg.norm(M) if np.linalg.norm(M) > 0 else M
    # re-orthonormalise in the matrix Frobenius inner product
    F = out.reshape(out.shape[0], -1)
    Qm, _ = np.linalg.qr(F.T)
    return Qm.T.reshape(-1, N, N)

def weyl_residual(W, n):
    """how far W is from the Weyl space: (bianchi, ricci, trace)."""
    b = max(abs(float(np.sum(M * W))) for M in bianchi_rows(n))
    r = max(abs(float(np.sum(M * W))) for M in ricci_rows(n))
    return b, r, abs(float(np.trace(W)))

# ---------- gradings ----------

def eig_split(W, tol=1e-9):
    w, V = np.linalg.eigh(W)
    scale = max(1.0, np.abs(w).max())
    pos = V[:, w > tol * scale]
    neg = V[:, w < -tol * scale]
    ker = V[:, np.abs(w) <= tol * scale]
    return w, pos, neg, ker

def bracket_leak(U, V, T, n):
    """sum over bases of <[u,v], t>^2 for u in U, v in V, t in T (columns)."""
    c = C(n)
    M = np.einsum('abg,ai,bj->ijg', c, U, V)
    return float(np.sum(np.einsum('ijg,gk->ijk', M, T) ** 2))

def grading_report(W, n, tol=1e-9):
    w, p, m, k = eig_split(W, tol)
    N = W.shape[0]
    rep = dict(dim_p=p.shape[1], dim_m=m.shape[1], dim_ker=k.shape[1], N=N)
    if k.shape[1] == 0:
        rep['pp_to_m'] = bracket_leak(p, p, m, n)
        rep['pm_to_p'] = bracket_leak(p, m, p, n)
        rep['mm_to_m'] = bracket_leak(m, m, m, n)
        rep['sign_graded'] = (max(rep['pp_to_m'], rep['pm_to_p'], rep['mm_to_m']) < 1e-16 * N**3)
    else:
        rep['sign_graded'] = False
    # S_mmm / S_mpp on the strictly-signed parts (the record's screen)
    rep['S_mmm'] = bracket_leak(m, m, m, n) if m.shape[1] else 0.0
    rep['S_mpp'] = bracket_leak(p, p, m, n) if (p.shape[1] and m.shape[1]) else 0.0
    return rep

def ad_op(v, n):
    """ad(v) as an N x N matrix on Lambda^2 ~ so(n)."""
    c = C(n)
    return np.einsum('a,agb->bg', v, c).T * 0.0 + np.einsum('a,abg->gb', v, c)

def symmetry_algebra(W, n, tol=1e-8):
    """basis of k(W) = {x in so(n) : [ad x, W] = 0}, as columns in R^N."""
    c = C(n)
    N = W.shape[0]
    rows = []
    for a in range(N):
        e = np.zeros(N); e[a] = 1.0
        A = ad_op(e, n)
        rows.append((A @ W - W @ A).ravel())
    A = np.array(rows).T  # columns indexed by a
    u, s, vt = np.linalg.svd(A)
    rank = int((s > tol * max(1.0, s.max())).sum())
    return vt[rank:].T, s

def defect(W, n, tol=1e-9):
    """Delta = sum over unit eigenvectors with lambda > 0 of ||[ad(v), W]||^2."""
    w, V = np.linalg.eigh(W)
    scale = max(1.0, np.abs(w).max())
    tot = 0.0
    for a in range(len(w)):
        if w[a] > tol * scale:
            A = ad_op(V[:, a], n)
            tot += float(np.linalg.norm(A @ W - W @ A) ** 2)
    return tot

def lam2(sigma, n):
    """Lambda^2(sigma) as an N x N operator: X -> sigma X sigma^T."""
    B = basis_mats(n)
    Bs = np.einsum('ip,apq,jq->aij', sigma, B, sigma)
    return 0.5 * np.einsum('aij,bij->ba', Bs, B)

# ---------- curvature operators from isotropy blocks ----------

def op_from_projs(projs, n, einstein=0.5):
    """R = sum lambda_i Pi_i solved so that Ric(R) = einstein * I; returns R, lambdas."""
    rrows = ricci_rows(n)
    A = np.array([[float(np.sum(M * Pi)) for Pi in projs] for M in rrows])
    # target vector: Ric = einstein*I  -> the (j,l) entries
    tgt = []
    k = 0
    for j in range(n):
        for l in range(j, n):
            tgt.append(einstein if j == l else 0.0)
    tgt = np.array(tgt)
    lam, *_ = np.linalg.lstsq(A, tgt, rcond=None)
    R = sum(l * Pi for l, Pi in zip(lam, projs))
    return R, lam, float(np.linalg.norm(A @ lam - tgt))

def proj_from_cols(Ucols):
    Qm, _ = np.linalg.qr(Ucols)
    return Qm @ Qm.T

def weyl_of(R, n):
    c = np.trace(R) / R.shape[0]
    W = R - c * np.eye(R.shape[0])
    return W

def pad(W, n, n2):
    P1 = pairs(n); P2 = pairs(n2)
    idx = {p: a for a, p in enumerate(P2)}
    out = np.zeros((len(P2), len(P2)))
    for a, pa in enumerate(P1):
        for b, pb in enumerate(P1):
            out[idx[pa], idx[pb]] = W[a, b]
    return out

def sharp_pol(A, B, n):
    return (sharp(A + B, n) - sharp(A - B, n)) / 4.0

def Le_spectrum(W, n, wb=None):
    """L_e = DQ(W)/(2 theta) restricted to Weyl_n cap W^perp; returns eigenvalues."""
    if wb is None:
        wb = weyl_basis(n)
    W = W / np.linalg.norm(W)
    th = float(np.sum(W * Q(W, n)))
    # orthonormal basis of Weyl_n cap W^perp
    F = wb.reshape(len(wb), -1)
    wv = W.ravel()
    coef = F @ wv
    F = F - np.outer(coef, wv)
    u, s, vt = np.linalg.svd(F, full_matrices=False)
    keep = vt[s > 1e-8 * s.max()]
    M = np.zeros((len(keep), len(keep)))
    imgs = []
    for r in keep:
        h = r.reshape(W.shape)
        imgs.append((W @ h + h @ W + 2 * sharp_pol(W, h, n)).ravel())
    imgs = np.array(imgs)
    M = keep @ imgs.T
    M = (M + M.T) / 2
    return np.linalg.eigvalsh(M) / (2 * th), th
