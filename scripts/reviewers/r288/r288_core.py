"""Reviewer 288: fully independent re-implementation from the definitions.

Different code path from scripts/review_r30_core.py:
  * structure constants from the delta-formula for [phi_ij, phi_kl], not matrix products
  * Weyl space as the nullspace of the FOUR-INDEX Bianchi + Ricci functionals,
    expressed in weighted upper-triangular coordinates on Sym^2(Lambda^2)
  * Taylor coefficients of P(x(t)) from the multinomial expansion of the
    trilinear form, not from polynomial interpolation
"""
import numpy as np, itertools, functools

def pairs_of(n):
    pr = [(i, j) for i in range(n) for j in range(i + 1, n)]
    return pr, {p: a for a, p in enumerate(pr)}

@functools.lru_cache(maxsize=None)
def cstruct(n):
    """c[a,b,g] = <[phi_a,phi_b],phi_g>, phi_ij = E_ij - E_ji, <X,Y> = 1/2 tr(X^T Y).
    [phi_ij,phi_kl] = d_jk phi_il - d_jl phi_ik - d_ik phi_jl + d_il phi_jk
    <phi_ab, phi_mp> = d_am d_bp - d_ap d_bm          (a!=b, m<p)"""
    pr, idx = pairs_of(n)
    N = len(pr)
    c = np.zeros((N, N, N))
    d = lambda p, q: 1.0 if p == q else 0.0
    def ip(a, b, g):           # <phi_ab, phi_g> with g a pair index (m<p)
        if a == b: return 0.0
        m, p = pr[g]
        return d(a, m) * d(b, p) - d(a, p) * d(b, m)
    for A, (i, j) in enumerate(pr):
        for B, (k, l) in enumerate(pr):
            for g in range(N):
                c[A, B, g] = (d(j, k) * ip(i, l, g) - d(j, l) * ip(i, k, g)
                              - d(i, k) * ip(j, l, g) + d(i, l) * ip(j, k, g))
    return c

def sharp_bilin(n, X, Y):
    """(X#Y)_ab = -1/4 [tr(A_a X A_b Y) + tr(A_a Y A_b X)], (A_a)_{mn}=c_{amn}."""
    c = cstruct(n); N = c.shape[0]
    AX = c @ X                     # AX[a] = A_a X
    AY = c @ Y
    T = np.einsum('amn,bnm->ab', AX, AY)
    return -0.25 * (T + T.T)

def sharp(n, X):
    return sharp_bilin(n, X, X)

def Q(n, X):
    return X @ X + sharp(n, X)

def circ(n, X, Y):
    return 0.5 * (X @ Y + Y @ X) + sharp_bilin(n, X, Y)

def T3(n, X, Y, Z):
    return float(np.tensordot(circ(n, X, Y), Z))

def P(n, X):
    return float(np.tensordot(X, Q(n, X)))

# ---------------- Weyl space, four-index route ----------------

def _sym_coords(n):
    """index maps for the weighted upper-triangular coordinates on Sym^2(R^N)."""
    pr, idx = pairs_of(n); N = len(pr)
    ent = [(a, b) for a in range(N) for b in range(a, N)]
    return pr, idx, N, ent

def _row_to_vec(row, ent):
    """functional <row, M> for symmetric M, in weighted upper-tri coords
    M = sum_{a<b} m_ab (E_ab+E_ba)/sqrt2 + sum_a m_aa E_aa."""
    row = 0.5 * (row + row.T)
    v = np.empty(len(ent))
    for k, (a, b) in enumerate(ent):
        v[k] = row[a, a] if a == b else np.sqrt(2.0) * row[a, b]
    return v

def _vec_to_mat(v, ent, N):
    M = np.zeros((N, N))
    for k, (a, b) in enumerate(ent):
        if a == b: M[a, a] = v[k]
        else:
            M[a, b] = M[b, a] = v[k] / np.sqrt(2.0)
    return M

@functools.lru_cache(maxsize=None)
def weyl_basis288(n):
    """Orthonormal (Frobenius) basis of {Bianchi=0, Ricci=0} in Sym^2(Lambda^2 R^n)."""
    pr, idx, N, ent = _sym_coords(n)
    def E(i, j, k, l):
        """matrix of the functional M -> R_{ijkl}."""
        if i == j or k == l: return None
        s = 1.0
        if i > j: i, j, s = j, i, -s
        if k > l: k, l, s = l, k, -s
        R = np.zeros((N, N)); R[idx[(i, j)], idx[(k, l)]] += s
        return R
    rows = []
    for (i, j, k, l) in itertools.combinations(range(n), 4):
        R = np.zeros((N, N))
        for (a, b, cc, dd) in [(i, j, k, l), (i, k, l, j), (i, l, j, k)]:
            R += E(a, b, cc, dd)
        rows.append(_row_to_vec(R, ent))
    for i in range(n):
        for k in range(i, n):
            R = np.zeros((N, N))
            for j in range(n):
                m = E(i, j, k, j)
                if m is not None: R += m
            rows.append(_row_to_vec(R, ent))
    C = np.array(rows)
    u, s, vt = np.linalg.svd(C, full_matrices=True)
    tol = max(C.shape) * s[0] * 1e-12
    rank = int((s > tol).sum())
    ns = vt[rank:]
    return np.array([_vec_to_mat(v, ent, N) for v in ns]), rank

def sphereprod(blocks):
    n = sum(blocks); pr, idx = pairs_of(n)
    lab = sum([[b] * d for b, d in enumerate(blocks)], [])
    W = np.zeros((len(pr), len(pr)))
    for a, (i, j) in enumerate(pr):
        if lab[i] == lab[j]:
            p = blocks[lab[i]]; W[a, a] = 1.0 / (p * (p - 1))
        else:
            p, q = blocks[lab[i]], blocks[lab[j]]; W[a, a] = -1.0 / (p * q)
    return W / np.linalg.norm(W)

def adrep(n):
    """matrix of ad(phi_a) on Lambda^2 in the phi basis: (ad phi_a)_{g b} = c_{a b g}."""
    c = cstruct(n)
    return c.transpose(0, 2, 1)          # M[a][g,b] = c[a,b,g]

def padded_cp2_288(n):
    """W_{CP^2} built independently: on Lambda^2 R^4, e = -(1/3) P_m + (2/3) P_omega,
    P_u the projector onto u(2) = {X in so(4): XJ = JX}, P_m = I - P_u,
    P_omega the rank-one projector on J.  Padded by zeros into Lambda^2 R^n."""
    pr4, idx4 = pairs_of(4)
    J = np.zeros((4, 4))
    for k in range(2):
        J[2*k, 2*k+1] = 1.0; J[2*k+1, 2*k] = -1.0
    basis = []
    for a in range(4):
        for b in range(a+1, 4):
            E = np.zeros((4, 4)); E[a, b] = 1.0; E[b, a] = -1.0
            basis.append(E)
    U = [E for E in basis]                      # so(4) basis, orthonormal in <,>
    # u(2) = commutant of J inside so(4)
    Msys = np.array([ (E@J - J@E).reshape(-1) for E in U ]).T
    u, s, vt = np.linalg.svd(Msys)
    ker = vt[(s > 1e-10).sum():] if Msys.shape[1] else np.eye(6)
    Pu = ker.T @ ker                             # projector on u(2) in the so(4) basis
    om = np.array([J[i, j] for (i, j) in pr4]); om = om / np.linalg.norm(om)
    Pw = np.outer(om, om)
    e = -(1.0/3.0)*(np.eye(6) - Pu) + (2.0/3.0)*Pw
    W4 = e / np.linalg.norm(e)
    pr, idx = pairs_of(n); N = len(pr)
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(pr4):
        for b, (k, l) in enumerate(pr4):
            W[idx[(i, j)], idx[(k, l)]] = W4[a, b]
    return W
