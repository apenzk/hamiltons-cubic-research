"""Reviewer 113 -- independent implementation from the brief's definitions.

Weyl space W_n built as an explicit nullspace (Bianchi + Ricci) rather than by
random projection + SVD, so it is independent of the record's construction.
"""
import itertools
import numpy as np


def pairs(n):
    return list(itertools.combinations(range(n), 2))


def struct_consts(n):
    """c[a,b,g]: [phi_a, phi_b] = sum_g c[a,b,g] phi_g, phi_ij = E_ij - E_ji."""
    pr = pairs(n)
    N = len(pr)
    B = np.zeros((N, n, n))
    for a, (i, j) in enumerate(pr):
        B[a, i, j] = 1.0
        B[a, j, i] = -1.0
    c = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            C = B[a] @ B[b] - B[b] @ B[a]
            for g, (k, l) in enumerate(pr):
                c[a, b, g] = C[k, l]
    return c, B


def weyl_basis(n):
    """Orthonormal basis of the algebraic Weyl tensors, as symmetric N x N matrices
    in the i<j pair basis.  Built as the nullspace of (first Bianchi) + (Ricci)."""
    pr = pairs(n)
    N = len(pr)
    idx = {p: k for k, p in enumerate(pr)}

    # coordinates on Sym(N): the entries (a<=b)
    coords = [(a, b) for a in range(N) for b in range(a, N)]
    ncoord = len(coords)
    cpos = {ab: k for k, ab in enumerate(coords)}

    def unit(a, b):
        v = np.zeros(ncoord)
        v[cpos[(min(a, b), max(a, b))]] += 1.0
        return v

    def Wcoef(i, j, k, l):
        """linear functional (as coordinate vector) giving W_{ijkl}."""
        v = np.zeros(ncoord)
        if i == j or k == l:
            return v
        si = 1.0
        if i > j:
            i, j, si = j, i, -si
        if k > l:
            k, l, si = l, k, -si
        return si * unit(idx[(i, j)], idx[(k, l)])

    rows = []
    # first Bianchi: W_ijkl + W_iklj + W_iljk = 0 for i<j<k<l
    for i, j, k, l in itertools.combinations(range(n), 4):
        rows.append(Wcoef(i, j, k, l) + Wcoef(i, k, l, j) + Wcoef(i, l, j, k))
    # Ricci-flat: sum_j W_{ijkj} = 0 for i<=k
    for i in range(n):
        for k in range(i, n):
            r = np.zeros(ncoord)
            for j in range(n):
                r = r + Wcoef(i, j, k, j)
            rows.append(r)
    A = np.array(rows)
    # nullspace
    U, s, Vt = np.linalg.svd(A)
    tol = max(A.shape) * np.finfo(float).eps * (s[0] if len(s) else 1.0)
    ns = Vt[np.sum(s > tol):]
    # turn each nullspace vector into a symmetric matrix, then orthonormalise in Frobenius
    mats = []
    for v in ns:
        M = np.zeros((N, N))
        for k, (a, b) in enumerate(coords):
            M[a, b] += v[k]
            if a != b:
                M[b, a] += v[k]
        mats.append(M)
    X = np.array([M.ravel() for M in mats]).T
    U2, s2, _ = np.linalg.svd(X, full_matrices=False)
    d = int(np.sum(s2 > 1e-9))
    return [U2[:, k].reshape(N, N) for k in range(d)]


def make_sharp(c):
    def sharp(M):
        return 0.5 * np.einsum('agd,bez,ge,dz->ab', c, c, M, M, optimize=True)
    return sharp


def theta_of(M, sharp):
    Q = M @ M + sharp(M)
    return float(np.sum(Q * M) / np.sum(M * M)), Q


def grading_data(M, c, tol=1e-8):
    """The full grading test on the eigenvalue-sign split.

    h = span of eigenvectors with lambda >= -tol_signed (nonnegative, kernel included)
    m = span of eigenvectors with lambda <  0
    Returns S_mmm, S_hhm (= leak of [h,h] into m), S_hhh, plus the kernel-free variant.
    """
    lam, V = np.linalg.eigh(M)
    cE = np.einsum('abg,aA,bB,gG->ABG', c, V, V, V, optimize=True)
    T = cE ** 2
    neg = np.where(lam < -tol)[0]
    pos = np.where(lam > tol)[0]
    zer = np.where(np.abs(lam) <= tol)[0]
    h = np.concatenate([pos, zer]).astype(int)
    m = neg.astype(int)
    out = {}
    out['lam'] = lam
    out['n_neg'], out['n_pos'], out['n_zero'] = len(neg), len(pos), len(zer)
    out['S_mmm'] = float(T[np.ix_(m, m, m)].sum()) if len(m) else 0.0
    out['S_hhm'] = float(T[np.ix_(h, h, m)].sum()) if len(m) and len(h) else 0.0
    out['S_hmm'] = float(T[np.ix_(h, m, m)].sum()) if len(m) and len(h) else 0.0
    # kernel-free variant: grading of the span of the NONZERO eigenvectors only
    out['S_hhm_nokernel'] = (float(T[np.ix_(pos, pos, m)].sum())
                             if len(m) and len(pos) else 0.0)
    out['graded'] = (out['S_mmm'] < 1e-16 and out['S_hhm'] < 1e-16)
    nz = np.abs(lam[np.abs(lam) > 1e-9])
    out['gap'] = float(nz.min()) if len(nz) else 0.0
    return out
