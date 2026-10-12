"""Reviewer 56 -- independent re-implementation, from definitions.

Conventions fixed here and used nowhere else in the repo:
  * Lambda^2(R^n) has orthonormal basis b_{ij} = e_i ^ e_j, i<j, identified with
    so(n) via A_{ij} = E_ij - E_ji and <A,B> = 1/2 tr(A^T B).  Then |A_{ij}|=1.
  * structure constants  c[a,b,g] = <[b_a,b_b], b_g>  (totally antisymmetric).
  * a curvature operator is a symmetric N x N matrix R, N = C(n,2), and its
    4-tensor is  R_{ijkl} = <R b_ij, b_kl>  extended antisymmetrically.
  * Ric(R)_{ik} = sum_j R_{ijkj};  first Bianchi  b(R)_{ijkl} = R_{ijkl}+R_{iklj}+R_{iljk}.
  * Weyl_n = {R symmetric : b(R)=0, Ric(R)=0}.
  * R# via (R#)_{ab} = 1/2 sum c[a,c,e] c[b,d,f] R_{cd} R_{ef}, Q(R)=R^2+R#.
  * STRUCTURAL SLACK  S(W) = sum_{a,b,c in m} c_{abc}^2  over an orthonormal basis
    of m = negative eigenspace of W.  (This is the "component of [m,m] back in m".)
    Basis-independent.  Reported alongside the normalised leakage ratio
    ||Pi_m [m,m]||^2 / ||[m,m]||^2 and the repo's theta-identity slack.
"""
import numpy as np
from itertools import combinations

# ---------------------------------------------------------------- basics


def pairs_of(n):
    return list(combinations(range(n), 2))


def struct(n):
    """c[a,b,g] = <[b_a,b_b],b_g>, and ad[a] = N x N matrix of ad(b_a)."""
    idx = pairs_of(n)
    N = len(idx)
    pos = {p: k for k, p in enumerate(idx)}
    c = np.zeros((N, N, N))
    for a, (i, j) in enumerate(idx):
        for b, (k, l) in enumerate(idx):
            terms = []
            if j == k: terms.append((1.0, (i, l)))
            if i == k: terms.append((-1.0, (j, l)))
            if j == l: terms.append((-1.0, (i, k)))
            if i == l: terms.append((1.0, (j, k)))
            for co, (p, q) in terms:
                if p == q:
                    continue
                s = 1.0
                if p > q:
                    p, q, s = q, p, -1.0
                c[a, b, pos[(p, q)]] += co * s
    return idx, pos, N, c


def tensor4(M, idx, n):
    """full antisymmetric 4-tensor T_{ijkl} from the matrix M in the b-basis."""
    T = np.zeros((n, n, n, n))
    for a, (i, j) in enumerate(idx):
        for b, (k, l) in enumerate(idx):
            v = M[a, b]
            for si, (p, q) in ((1, (i, j)), (-1, (j, i))):
                for sk, (r, s) in ((1, (k, l)), (-1, (l, k))):
                    T[p, q, r, s] = si * sk * v
    return T


def mat_from_tensor4(T, idx):
    return np.array([[T[i, j, k, l] for (k, l) in idx] for (i, j) in idx])


def ricci(M, idx, n):
    T = tensor4(M, idx, n)
    return np.einsum('ijkj->ik', T)


def bianchi(M, idx, n):
    T = tensor4(M, idx, n)
    return T + np.transpose(T, (0, 2, 3, 1)) + np.transpose(T, (0, 3, 1, 2))


def kn(h, n):
    """(1/2)(h_ik d_jl + h_jl d_ik - h_il d_jk - h_jk d_il); kn(I)=Id on Lambda^2."""
    d = np.eye(n)
    return 0.5 * (np.einsum('ik,jl->ijkl', h, d) + np.einsum('jl,ik->ijkl', h, d)
                  - np.einsum('il,jk->ijkl', h, d) - np.einsum('jk,il->ijkl', h, d))


def weyl_basis(n):
    """orthonormal basis of Weyl_n as a list of N x N symmetric matrices, and
    the orthogonal projector onto Weyl_n as a function."""
    idx, pos, N, c = struct(n)
    # ambient: symmetric N x N matrices, orthonormal basis
    amb = []
    for a in range(N):
        E = np.zeros((N, N)); E[a, a] = 1.0; amb.append(E)
    for a in range(N):
        for b in range(a + 1, N):
            E = np.zeros((N, N)); E[a, b] = E[b, a] = 1 / np.sqrt(2); amb.append(E)
    D = len(amb)
    # non-Weyl span: Lambda^4 image + kn(Sym^2) image
    bad = []
    for (i, j, k, l) in combinations(range(n), 4):
        T = np.zeros((n, n, n, n))
        for p in [(i, j, k, l)]:
            pass
        # build the elementary 4-form e_i^e_j^e_k^e_l as an element of Sym^2(Lambda^2)
        from itertools import permutations
        def sgn(perm):
            s = 1
            perm = list(perm)
            for x in range(len(perm)):
                for y in range(x + 1, len(perm)):
                    if perm[x] > perm[y]: s = -s
            return s
        base = (i, j, k, l)
        for pm in permutations(range(4)):
            a, b, cc, d = [base[t] for t in pm]
            T[a, b, cc, d] += sgn(pm)
        bad.append(mat_from_tensor4(T, idx))
    for a in range(n):
        for b in range(a, n):
            h = np.zeros((n, n)); h[a, b] = h[b, a] = 1.0
            bad.append(mat_from_tensor4(kn(h, n), idx))
    if bad:
        Bv = np.array([m[np.triu_indices(N)] * np.where(
            np.eye(N)[np.triu_indices(N)] == 1, 1.0, np.sqrt(2)) for m in bad])
        # rows in the orthonormal ambient coordinates
        U, s, Vt = np.linalg.svd(Bv, full_matrices=False)
        r = int((s > 1e-9 * s[0]).sum())
        badspan = Vt[:r]
    else:
        badspan = np.zeros((0, D))
    # complement
    P = np.eye(D) - badspan.T @ badspan
    ev, V = np.linalg.eigh(P)
    keep = V[:, ev > 0.5]
    basis = []
    tri = np.triu_indices(N)
    scale = np.where(np.eye(N)[tri] == 1, 1.0, np.sqrt(2))
    for k in range(keep.shape[1]):
        v = keep[:, k] / scale
        M = np.zeros((N, N)); M[tri] = v; M = M + M.T - np.diag(np.diag(M))
        basis.append(M / np.linalg.norm(M))
    return idx, pos, N, c, basis


def sharp(R, c):
    S = np.einsum('amn,np->amp', c, R, optimize=True)
    return -0.5 * np.einsum('amp,bpm->ab', S, S, optimize=True)


def Q(R, c):
    return R @ R + sharp(R, c)


def bil(X, Y, c):
    return 0.5 * (Q(X + Y, c) - Q(X, c) - Q(Y, c))


def theta_res(W, c):
    QW = Q(W, c)
    th = float(np.sum(W * QW))
    return th, float(np.linalg.norm(QW - th * W))


# ---------------------------------------------------------------- slack


def slack_struct(W, c, tol=1e-9):
    """S = sum_{a,b,g in m} c_abg^2 ; also the normalised leakage ratio."""
    ev, V = np.linalg.eigh(W)
    m = V[:, ev < -tol]
    if m.shape[1] == 0:
        return 0.0, 0.0
    cm = np.einsum('abg,ai,bj->ijg', c, m, m, optimize=True)   # [m_i,m_j] in b-basis
    tot = float(np.sum(cm * cm))
    inside = float(np.sum(np.einsum('ijg,gk->ijk', cm, m, optimize=True) ** 2))
    return inside, inside / max(tot, 1e-300)


# ---------------------------------------------------------------- diagonality


def offdiag_mass(W):
    return float(np.linalg.norm(W - np.diag(np.diag(W)))) / float(np.linalg.norm(W))


def offdiag_max(W):
    A = np.abs(W - np.diag(np.diag(W)))
    return float(A.max()) / float(np.linalg.norm(W))


_RHO_CACHE = {}


def rho(g, idx):
    """the O(n) action on Lambda^2 in the b-basis (vectorised)."""
    key = (len(idx), id(idx))
    ar = _RHO_CACHE.get(key)
    if ar is None:
        ar = (np.array([p[0] for p in idx]), np.array([p[1] for p in idx]))
        _RHO_CACHE[key] = ar
    I, J = ar
    return g[np.ix_(I, I)] * g[np.ix_(J, J)] - g[np.ix_(J, I)] * g[np.ix_(I, J)]


def min_offdiag_over_frames(W, n, idx, tries=12, seed=0, iters=400):
    """global-ish minimisation of ||offdiag(rho(g) W rho(g)^T)|| over g in SO(n)."""
    from scipy.optimize import minimize
    from scipy.linalg import expm
    rng = np.random.default_rng(seed)
    tri = np.triu_indices(n, 1)
    Wn = W / np.linalg.norm(W)

    def unpack(x):
        A = np.zeros((n, n)); A[tri] = x; A = A - A.T
        return expm(A)

    def f(x):
        R = rho(unpack(x), idx)
        M = R @ Wn @ R.T
        return float(np.sum((M - np.diag(np.diag(M))) ** 2))

    best = f(np.zeros(len(tri[0])))
    for t in range(tries):
        x0 = rng.normal(scale=0.8, size=len(tri[0])) if t else np.zeros(len(tri[0]))
        r = minimize(f, x0, method='L-BFGS-B',
                     options=dict(maxiter=iters, maxfun=200 * len(tri[0])))
        r2 = minimize(f, r.x, method='L-BFGS-B',
                      options=dict(maxiter=iters, maxfun=200 * len(tri[0])))
        best = min(best, float(r.fun), float(r2.fun))
    return np.sqrt(max(best, 0.0))


def plucker_min(E, idx, n, tries=40, seed=0):
    """min over unit w in span(E) of ||w ^ w|| : 0 iff E meets the Grassmann cone."""
    from scipy.optimize import minimize
    rng = np.random.default_rng(seed)
    k = E.shape[1]
    quads = list(combinations(range(n), 4))

    def wedge(v):
        M = np.zeros((n, n))
        for a, (i, j) in enumerate(idx):
            M[i, j] = v[a]; M[j, i] = -v[a]
        out = []
        for (i, j, p, q) in quads:
            out.append(M[i, j] * M[p, q] - M[i, p] * M[j, q] + M[i, q] * M[j, p])
        return np.array(out)

    def f(y):
        v = E @ y
        nv = np.linalg.norm(v)
        if nv < 1e-12:
            return 1.0
        return float(np.sum(wedge(v / nv) ** 2))

    best = np.inf
    for t in range(tries):
        y0 = rng.normal(size=k)
        r = minimize(f, y0, method='Nelder-Mead',
                     options=dict(maxiter=4000, fatol=1e-14, xatol=1e-10))
        best = min(best, float(r.fun))
    return np.sqrt(max(best, 0.0))


def isotropy_algebra(W, idx, n, c, tol=1e-8):
    """dim {A in so(n) : ad(A) commutes with W}, as a subalgebra of so(n)."""
    N = len(idx)
    ad = np.transpose(c, (0, 2, 1))          # ad[a][g,b] = c[a,b,g]
    rows = []
    for a in range(N):
        Cm = ad[a] @ W - W @ ad[a]
        rows.append(Cm.reshape(-1))
    Mtx = np.array(rows).T
    s = np.linalg.svd(Mtx, compute_uv=False)
    return int((s < tol * max(1.0, s[0])).sum()) + max(0, N - len(s))


def fixing_reflections(W, idx, n, tries=60, seed=0):
    """does some reflection r_u = I - 2 u u^T fix W?  returns min residual found.
    Coordinate-diagonal W always admits one (u = a frame vector)."""
    from scipy.optimize import minimize
    rng = np.random.default_rng(seed)
    Wn = W / np.linalg.norm(W)

    def f(u):
        u = u / np.linalg.norm(u)
        g = np.eye(n) - 2 * np.outer(u, u)
        R = rho(g, idx)
        return float(np.linalg.norm(R @ Wn @ R.T - Wn) ** 2)

    best = np.inf
    for t in range(tries):
        u0 = rng.normal(size=n)
        r = minimize(f, u0, method='Nelder-Mead',
                     options=dict(maxiter=3000, fatol=1e-16, xatol=1e-10))
        best = min(best, float(r.fun))
    return np.sqrt(max(best, 0.0))


# ---------------------------------------------------------------- constructions


def weyl_project(T, idx, n, basis=None):
    M = mat_from_tensor4(T, idx)
    if basis is None:
        return weyl_project_fast(M, idx, n)
    coef = np.array([np.sum(M * b) for b in basis])
    return sum(x * b for x, b in zip(coef, basis))


def sphere_product(n, sizes, idx, basis=None):
    """Weyl part of the product of unit round spheres with the given block sizes."""
    lab = []
    for bi, s in enumerate(sizes):
        lab += [bi] * s
    N = len(idx)
    R = np.zeros((N, N))
    for a, (i, j) in enumerate(idx):
        R[a, a] = 1.0 if lab[i] == lab[j] else 0.0
    T = tensor4(R, idx, n)
    W = weyl_project(T, idx, n, basis)
    return W / np.linalg.norm(W)


def J_std(n, k=None):
    """standard complex structure on R^n (n even)."""
    J = np.zeros((n, n))
    m = n // 2
    for i in range(m):
        J[2 * i, 2 * i + 1] = -1.0
        J[2 * i + 1, 2 * i] = 1.0
    return J


def fs_tensor(n, Js):
    """R(X,Y,Z,W)=<X,Z><Y,W>-<X,W><Y,Z> + sum_a [<JaX,Z><JaY,W>-<JaX,W><JaY,Z>
       + 2<JaX,Y><JaZ,W>]  -- Fubini-Study / quaternionic model, padded by zero."""
    d = np.eye(n)
    T = (np.einsum('ik,jl->ijkl', d, d) - np.einsum('il,jk->ijkl', d, d))
    for J in Js:
        T = T + (np.einsum('ik,jl->ijkl', J, J) - np.einsum('il,jk->ijkl', J, J)
                 + 2 * np.einsum('ij,kl->ijkl', J, J))
    return T


def cpm(n, idx, basis=None):
    """Weyl part of Fubini-Study on CP^{n/2} (real dimension n)."""
    T = fs_tensor(n, [J_std(n)])
    W = weyl_project(T, idx, n, basis)
    return W / np.linalg.norm(W)


def hpm(n, idx, basis=None):
    """Weyl part of the quaternionic model on HP^{n/4}."""
    m = n // 4
    I = np.zeros((n, n)); Jm = np.zeros((n, n)); K = np.zeros((n, n))
    for q in range(m):
        o = 4 * q
        for (A, (a, b), s) in ((I, (0, 1), 1), (I, (2, 3), 1),
                               (Jm, (0, 2), 1), (Jm, (3, 1), 1),
                               (K, (0, 3), 1), (K, (1, 2), 1)):
            A[o + a, o + b] = -s; A[o + b, o + a] = s
    T = fs_tensor(n, [I, Jm, K])
    W = weyl_project(T, idx, n, basis)
    return W / np.linalg.norm(W)


def w_cp2_padded(n, idx):
    """Nienhaus's W_{CP^2}: diag(0,0,0,-1,-1,2)/sqrt6 on Lambda^2 R^4, zero-padded."""
    N = len(idx)
    p4 = [a for a, (i, j) in enumerate(idx) if j < 4]
    assert len(p4) == 6
    om = np.zeros(N); om[[a for a in p4 if idx[a] in ((0, 1), (2, 3))]] = 1 / np.sqrt(2)
    om[[a for a in p4 if idx[a] == (2, 3)]] = 1 / np.sqrt(2)
    # Lambda^2_+ of the 4-plane, relative to e0..e3
    sd = []
    for (p, q, r, s), sg in (((0, 1, 2, 3), 1), ((0, 2, 3, 1), 1), ((0, 3, 1, 2), 1)):
        v = np.zeros(N)
        v[idx.index((min(p, q), max(p, q)))] += (1 if p < q else -1) / np.sqrt(2)
        a, b = (min(r, s), max(r, s))
        v[idx.index((a, b))] += sg * (1 if r < s else -1) / np.sqrt(2)
        sd.append(v)
    sd = np.array(sd).T
    Pplus = sd @ sd.T
    Pom = np.outer(om, om)
    W = (3 * Pom - Pplus) / np.sqrt(6)
    return W / np.linalg.norm(W)


def c5_blowup(n, sizes, idx):
    k = len(sizes)
    G = [[1 if (abs(a - b) % k == 1 or abs(a - b) % k == k - 1) else 0 for b in range(k)]
         for a in range(k)]
    lab = []
    for bi, s in enumerate(sizes):
        lab += [bi] * s
    N = len(idx)
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(idx):
        A_, B_ = lab[i], lab[j]
        W[a, a] = 4.0 if A_ == B_ else (-2.0 if G[A_][B_] else 1.0)
    return W / np.linalg.norm(W)


def theta0(n):
    return np.sqrt(2 * (n - 1) * (n - 2)) / n


def weyl_project_fast(M, idx, n):
    """orthogonal projection of a symmetric operator M on Lambda^2 onto Weyl_n,
    with no basis: kill the Lambda^4 part, then the Kulkarni-Nomizu part."""
    T = tensor4(M, idx, n)
    T = T - bianchi(M, idx, n) / 3.0
    Mb = mat_from_tensor4(T, idx)
    ric = ricci(Mb, idx, n)
    h = (2 * ric - np.trace(ric) / (n - 1) * np.eye(n)) / (n - 2)
    return Mb - mat_from_tensor4(kn(h, n), idx)
