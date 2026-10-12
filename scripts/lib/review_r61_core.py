"""Reviewer 61: independent re-implementation of the Weyl_m machinery.

Conventions (project's):
  Lambda^2 R^m = so(m); orthonormal basis phi_{ij} = E_ij - E_ji (i<j);
  <X,Y> = 1/2 tr(X^T Y)  =>  <phi_ij,phi_ij> = 1 and, for skew v,
  <v,phi_ij> = v_ij.  So the coordinate vector of a skew v is its
  strict upper triangle, and its Euclidean norm is |v|.
Written from the definitions; no project code read or imported.
"""
import numpy as np
import itertools


def pairs(m):
    return [(i, j) for i in range(m) for j in range(i + 1, m)]


def pair_index(m):
    return {p: k for k, p in enumerate(pairs(m))}


def vec_to_skew(v, m):
    X = np.zeros((m, m))
    for k, (i, j) in enumerate(pairs(m)):
        X[i, j] = v[k]
        X[j, i] = -v[k]
    return X


def skew_to_vec(X, m):
    return np.array([X[i, j] for (i, j) in pairs(m)])


def ad_matrix(v, m):
    """Matrix of ad(v): u -> [v,u] in the phi basis."""
    V = vec_to_skew(v, m) if v.ndim == 1 else v
    D = m * (m - 1) // 2
    C = np.zeros((D, D))
    for k, (i, j) in enumerate(pairs(m)):
        E = np.zeros((m, m)); E[i, j] = 1.0; E[j, i] = -1.0
        C[:, k] = skew_to_vec(V @ E - E @ V, m)
    return C


def ad_basis(m):
    """C_g = ad(phi_g) for every basis bivector g."""
    D = m * (m - 1) // 2
    out = []
    for k in range(D):
        e = np.zeros(D); e[k] = 1.0
        out.append(ad_matrix(e, m))
    return out


def comp(W, m, i, j, k, l, idx=None):
    """W_{ijkl} for arbitrary index order, from the D x D matrix W."""
    if idx is None:
        idx = pair_index(m)
    if i == j or k == l:
        return 0.0
    si = 1.0
    if i > j:
        i, j = j, i; si = -si
    if k > l:
        k, l = l, k; si = -si
    return si * W[idx[(i, j)], idx[(k, l)]]


def weyl_constraints(m):
    """Rows of a linear system on vec(Sym(D)) encoding Ricci-flat + Bianchi."""
    D = m * (m - 1) // 2
    idx = pair_index(m)
    P = pairs(m)
    rows = []

    def sym_row():
        return np.zeros((D, D))

    # Ricci: sum_j W_{ijkj} = 0, for i<=k
    for i in range(m):
        for k in range(i, m):
            R = sym_row()
            for j in range(m):
                if j == i or j == k:
                    continue
                a, b, sa = (i, j, 1.0) if i < j else (j, i, -1.0)
                c, d, sc = (k, j, 1.0) if k < j else (j, k, -1.0)
                R[idx[(a, b)], idx[(c, d)]] += sa * sc
            rows.append(0.5 * (R + R.T))
    # Bianchi: W_{ijkl}+W_{iklj}+W_{iljk}=0 for i<j<k<l
    for (i, j, k, l) in itertools.combinations(range(m), 4):
        R = sym_row()
        for (a, b, c, d) in [(i, j, k, l), (i, k, l, j), (i, l, j, k)]:
            aa, bb, s1 = (a, b, 1.0) if a < b else (b, a, -1.0)
            cc, dd, s2 = (c, d, 1.0) if c < d else (d, c, -1.0)
            R[idx[(aa, bb)], idx[(cc, dd)]] += s1 * s2
        rows.append(0.5 * (R + R.T))
    return np.array([r.ravel() for r in rows])


def sym_basis(D):
    """Orthonormal basis of symmetric D x D matrices, as flattened vectors."""
    B = []
    for i in range(D):
        M = np.zeros((D, D)); M[i, i] = 1.0
        B.append(M.ravel())
    for i in range(D):
        for j in range(i + 1, D):
            M = np.zeros((D, D)); M[i, j] = M[j, i] = 1 / np.sqrt(2)
            B.append(M.ravel())
    return np.array(B)


_cache = {}


def weyl_basis(m):
    """Orthonormal basis (in the Frobenius inner product on D x D matrices)
    of Weyl_m, returned as an array of shape (dim, D, D)."""
    if m in _cache:
        return _cache[m]
    D = m * (m - 1) // 2
    S = sym_basis(D)                    # (Ns, D*D), orthonormal rows
    A = weyl_constraints(m)             # (Nc, D*D)
    M = A @ S.T                         # constraints in the sym coordinates
    # nullspace of M
    _, s, Vt = np.linalg.svd(M)
    tol = max(M.shape) * np.finfo(float).eps * (s[0] if s.size else 1.0)
    rank = int((s > max(tol, 1e-9)).sum())
    N = Vt[rank:]                       # (dim, Ns)
    B = (N @ S).reshape(-1, D, D)
    _cache[m] = B
    return B


def weyl_dim_formula(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12


def project_weyl(W, m):
    B = weyl_basis(m)
    c = np.einsum('kij,ij->k', B, W)
    return np.einsum('k,kij->ij', c, B)


def sharp(W, m):
    """W^# = 1/2 sum_{a,b} lam_a lam_b [v_a,v_b] (x) [v_a,v_b]."""
    lam, V = np.linalg.eigh(W)
    D = W.shape[0]
    ads = [ad_matrix(V[:, a], m) for a in range(D)]
    out = np.zeros((D, D))
    for a in range(D):
        if abs(lam[a]) < 1e-14:
            continue
        for b in range(D):
            if abs(lam[b]) < 1e-14:
                continue
            w = ads[a] @ V[:, b]          # [v_a, v_b]
            out += 0.5 * lam[a] * lam[b] * np.outer(w, w)
    return out


def Q(W, m):
    return W @ W + sharp(W, m)


def theta(W, m):
    nrm = np.linalg.norm(W)
    return float(np.sum(W * Q(W, m)) / nrm ** 3)


def ricci_defect(W, m):
    idx = pair_index(m)
    R = np.zeros((m, m))
    for i in range(m):
        for k in range(m):
            R[i, k] = sum(comp(W, m, i, j, k, j, idx) for j in range(m))
    return np.abs(R).max()


def bianchi_defect(W, m):
    idx = pair_index(m)
    d = 0.0
    for (i, j, k, l) in itertools.combinations(range(m), 4):
        for (a, b, c, dd) in itertools.permutations((i, j, k, l)):
            v = (comp(W, m, a, b, c, dd, idx) + comp(W, m, a, c, dd, b, idx)
                 + comp(W, m, a, dd, b, c, idx))
            d = max(d, abs(v))
    return d


def diag_weyl(wmat, m):
    """Coordinate-diagonal Weyl operator from a hollow symmetric vertex matrix."""
    D = m * (m - 1) // 2
    W = np.zeros((D, D))
    for k, (i, j) in enumerate(pairs(m)):
        W[k, k] = wmat[i, j]
    return W


def sphere_product(k, l):
    """Weyl operator of S^k x S^l (product Einstein-normalised), unit norm."""
    n = k + l
    wm = np.zeros((n, n))
    a, b = 1.0, 0.0
    # within-block value a for block1, c for block2, cross value b
    # Ricci-flatness: (k-1)a + l*b = 0 and (l-1)c + k*b = 0
    b = -1.0
    a = l * 1.0 / (k - 1)
    c = k * 1.0 / (l - 1)
    for i in range(n):
        for j in range(n):
            if i == j:
                continue
            if i < k and j < k:
                wm[i, j] = a
            elif i >= k and j >= k:
                wm[i, j] = c
            else:
                wm[i, j] = b
    W = diag_weyl(wm, n)
    return W / np.linalg.norm(W)


if __name__ == '__main__':
    print("dim Weyl_m: computed vs formula")
    for m in range(4, 9):
        B = weyl_basis(m)
        print(f"  m={m}: {B.shape[0]}  formula {weyl_dim_formula(m)}")
    print("\nvalidation: theta at balanced sphere products vs theta_0(n)")
    for n in (6, 8, 10, 12):
        W = sphere_product(n // 2, n // 2)
        t0 = (n - 1) / n * np.sqrt(2 * (n - 2) / (n - 1))
        print(f"  n={n}: ricci {ricci_defect(W,n):.2e} bianchi {bianchi_defect(W,n):.2e}"
              f" theta={theta(W,n):.9f} theta_0={t0:.9f}")
    print("\nvalidation: Q preserves Weyl_m (m=6, random)")
    rng = np.random.default_rng(0)
    B = weyl_basis(6)
    W = np.einsum('k,kij->ij', rng.normal(size=B.shape[0]), B)
    W /= np.linalg.norm(W)
    QW = Q(W, 6)
    print(f"  ricci(Q) {ricci_defect(QW,6):.2e}  bianchi(Q) {bianchi_defect(QW,6):.2e}"
          f"  |Q-proj Q| {np.linalg.norm(QW-project_weyl(QW,6)):.2e}")
