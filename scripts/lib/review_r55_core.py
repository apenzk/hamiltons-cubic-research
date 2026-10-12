"""Reviewer 55: independent core for the C_5 blow-up audit.

Built from the definitions, not from the repository's helpers.  Conventions:

  Lambda^2(R^n) has orthonormal basis b_{ij} = e_i ^ e_j (i<j), identified with
  so(n) via b_{ij} <-> E_ij - E_ji and <A,B> = 1/2 tr(A^T B).

  c[a,b,g] = <[b_a,b_b],b_g>  is totally antisymmetric.

  (X^#)_{gd} = 1/2 sum c_{gab} c_{dmn} X_{am} X_{bn}      (Lie algebra square)
  Q(X)       = X^2 + X^#
  X o Y      = 1/2(XY+YX) + X#Y  with X#Y the polarization, X#X = X^#.

  Weyl_n = { R in Sym^2(Lambda^2) : first Bianchi = 0, Ric(R) = 0 }.

  STRUCTURAL SLACK.  m = negative eigenspace of W inside so(n).
  S_struct = sum_{a<b} || Pi_m [X_a, X_b] ||^2   over an orthonormal basis of m,
  brackets and norms taken in so(n) itself (NOT the adjoint representation).
"""
import itertools, functools
import numpy as np


# ---------------------------------------------------------------- basis / brackets

@functools.lru_cache(maxsize=None)
def pairs_of(n):
    return tuple((i, j) for i in range(n) for j in range(i + 1, n))


@functools.lru_cache(maxsize=None)
def pidx(n):
    return {p: a for a, p in enumerate(pairs_of(n))}


@functools.lru_cache(maxsize=None)
def struct(n):
    """Totally antisymmetric structure constants, built combinatorially.

    [A_ij, A_jk] = A_ik for distinct i,j,k, so the only nonzero entries come from
    triangles {i,j,k}.  Fill all 6 orderings by antisymmetry.
    """
    ix = pidx(n)
    N = n * (n - 1) // 2
    c = np.zeros((N, N, N))

    def put(a, b, g, v):
        for (p, q, r), s in (((a, b, g), 1), ((b, g, a), 1), ((g, a, b), 1),
                             ((b, a, g), -1), ((a, g, b), -1), ((g, b, a), -1)):
            c[p, q, r] = s * v

    for i, j, k in itertools.combinations(range(n), 3):
        # [A_ij, A_jk] = A_ik  ->  c[(ij),(jk),(ik)] = 1
        put(ix[(i, j)], ix[(j, k)], ix[(i, k)], 1.0)
    return c


@functools.lru_cache(maxsize=None)
def so_matrices(n):
    """b_a as antisymmetric n x n matrices."""
    N = n * (n - 1) // 2
    M = np.zeros((N, n, n))
    for a, (i, j) in enumerate(pairs_of(n)):
        M[a, i, j] = 1.0
        M[a, j, i] = -1.0
    return M


def check_struct(n):
    """Cross-check struct() against explicit matrix commutators."""
    M = so_matrices(n)
    c = struct(n)
    N = M.shape[0]
    cm = np.einsum('aij,bjk->abik', M, M) - np.einsum('bij,ajk->abik', M, M)
    c2 = 0.5 * np.einsum('abij,gij->abg', cm, M)
    return float(np.abs(c - c2).max())


# ---------------------------------------------------------------- Q, #, o

def sharp(n, X):
    """(X^#)_{gd} = 1/2 sum c_{gab} c_{dmn} X_{am} X_{bn}, via M_a = A_a X."""
    c = struct(n)
    N = c.shape[0]
    M = (c.reshape(N * N, N) @ X).reshape(N, N, N)      # M[g,a,b] = (A_g X)_{ab}
    return -0.5 * (M.reshape(N, N * N) @ M.transpose(0, 2, 1).reshape(N, N * N).T)


def sharp_slow(n, X):
    """Direct 4-index contraction; independent route for validation."""
    c = struct(n)
    return 0.5 * np.einsum('gab,dmn,am,bn->gd', c, c, X, X, optimize=True)


def sharp_bil(n, X, Y):
    """Polarization: X#Y with X#X = X^#."""
    c = struct(n)
    N = c.shape[0]
    MX = (c.reshape(N * N, N) @ X).reshape(N, N, N)
    MY = (c.reshape(N * N, N) @ Y).reshape(N, N, N)
    T = MX.reshape(N, N * N) @ MY.transpose(0, 2, 1).reshape(N, N * N).T
    return -0.25 * (T + T.T)


def Q(n, X):
    return X @ X + sharp(n, X)


def circ(n, X, Y):
    return 0.5 * (X @ Y + Y @ X) + sharp_bil(n, X, Y)


def Pval(n, X):
    return float(np.tensordot(X, Q(n, X)))


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n


# ---------------------------------------------------------------- Weyl space

def _R(W, ix, i, j, k, l):
    if i == j or k == l:
        return 0.0, 0, 0
    s = 1.0
    if i > j:
        i, j, s = j, i, -s
    if k > l:
        k, l, s = l, k, -s
    return s, ix[(i, j)], ix[(k, l)]


@functools.lru_cache(maxsize=None)
def weyl_basis(n):
    """Orthonormal basis of Weyl_n, as a (D, N, N) array of symmetric matrices."""
    ix = pidx(n)
    N = n * (n - 1) // 2
    # coordinates: symmetric matrices, param by upper triangle
    sym = [(a, b) for a in range(N) for b in range(a, N)]
    sidx = {p: t for t, p in enumerate(sym)}
    nv = len(sym)

    def addsym(row, a, b, v):
        row[sidx[(a, b)] if a <= b else sidx[(b, a)]] += v

    rows = []
    for (i, j, k, l) in itertools.combinations(range(n), 4):
        # R_{ij,kl} - R_{ik,jl} + R_{il,jk} = 0, for the three pairings
        for (p, q, r, s_) in ((i, j, k, l), (i, k, j, l), (i, l, j, k)):
            pass
        row = np.zeros(nv)
        for (aa, bb, cc, dd, sg) in ((i, j, k, l, 1.0), (i, k, j, l, -1.0), (i, l, j, k, 1.0)):
            s, u, v = _R(None, ix, aa, bb, cc, dd)
            addsym(row, u, v, sg * s)
        rows.append(row)
    for a in range(n):
        for b in range(a, n):
            row = np.zeros(nv)
            for m in range(n):
                if m == a or m == b:
                    continue
                s, u, v = _R(None, ix, a, m, b, m)
                addsym(row, u, v, s)
            rows.append(row)
    Aeq = np.array(rows)
    # nullspace
    _, sv, Vt = np.linalg.svd(Aeq)
    tol = max(Aeq.shape) * np.finfo(float).eps * sv.max()
    ns = Vt[(sv > tol).sum():] if len(sv) < Vt.shape[0] else Vt[(sv > tol).sum():]
    # rebuild matrices; orthonormalize under Frobenius
    B = np.zeros((ns.shape[0], N, N))
    for t, (a, b) in enumerate(sym):
        B[:, a, b] += ns[:, t]
        if a != b:
            B[:, b, a] += ns[:, t]
    # Gram-Schmidt in Frobenius
    Bf = B.reshape(B.shape[0], -1)
    Qm, _ = np.linalg.qr(Bf.T)
    B = Qm.T.reshape(-1, N, N)
    B = 0.5 * (B + B.transpose(0, 2, 1))
    Bf = B.reshape(B.shape[0], -1)
    Qm, _ = np.linalg.qr(Bf.T)
    return np.ascontiguousarray(Qm.T.reshape(-1, N, N))


def dim_weyl(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12


# ---------------------------------------------------------------- orbit

def orbit_tangent(n, W):
    """Span of d/dt|_0 exp(t g) W exp(-t g) for g in so(n) acting on Lambda^2."""
    c = struct(n)
    N = c.shape[0]
    out = []
    for a in range(N):
        Aa = c[a]                       # ad(b_a) acting on Lambda^2 == so(n)
        out.append(Aa @ W - W @ Aa)
    return np.array(out)


def onb(V, tol=1e-9):
    """Orthonormal basis of the row space of V (rows are matrices or vectors)."""
    F = V.reshape(V.shape[0], -1)
    u, s, vt = np.linalg.svd(F, full_matrices=False)
    k = int((s > tol * max(1.0, s.max())).sum())
    return vt[:k]


# ---------------------------------------------------------------- slack

def slack_struct(n, W, tol=1e-9):
    """S = sum_{a<b} ||Pi_m [X_a,X_b]||^2, brackets in so(n) itself."""
    ev, V = np.linalg.eigh(W)
    neg = V[:, ev < -tol]
    k = neg.shape[1]
    if k < 3:
        return 0.0 if k < 3 else 0.0
    c = struct(n)
    N = c.shape[0]
    # bracket in Lambda^2 coordinates: [x,y]_g = sum c_{abg} x_a y_b
    # Pi_m = neg neg^T
    tot = 0.0
    # vectorized: for each a, Ca = c[a] (N x N) with (Ca)_{b g} = c_{a b g}
    for i in range(k):
        xi = neg[:, i]
        Ci = np.einsum('a,abg->bg', xi, c)     # (Ci)_{bg} = [x_i, b_b]_g
        Br = neg[:, i + 1:].T @ Ci             # rows: [x_i, x_j] in coords
        proj = Br @ neg
        tot += float((proj ** 2).sum())
    return tot


def slack_struct_full(n, W, tol=1e-9):
    """Same but summed over ALL ordered pairs (a,b): equals 2 * slack_struct."""
    return 2.0 * slack_struct(n, W, tol)


# ---------------------------------------------------------------- diagonal ops

def diag_operator(lam):
    """Given hollow symmetric n x n vertex matrix lam, the diagonal W on Lambda^2."""
    n = lam.shape[0]
    N = n * (n - 1) // 2
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(pairs_of(n)):
        W[a, a] = lam[i, j]
    return W


def diag_Q(lam):
    """(Q W)_{ij} = w_ij^2 + sum_{k != i,j} w_ik w_jk, as a vertex matrix."""
    n = lam.shape[0]
    M = lam @ lam                               # sum_k w_ik w_kj  (k over all)
    out = lam ** 2 + M - lam * np.diag(M)[:, None] * 0.0
    # remove k = i and k = j terms: w_ii w_ji = 0 and w_ij w_jj = 0 since hollow
    np.fill_diagonal(out, 0.0)
    return out


def diag_theta_norm(lam):
    """theta and |W| for a diagonal operator with vertex matrix lam."""
    nrm = np.sqrt(0.5 * float((lam ** 2).sum()))
    P = 0.5 * (float((lam ** 3).sum()) + float(np.trace(lam @ lam @ lam)))
    return P / nrm ** 3, nrm
