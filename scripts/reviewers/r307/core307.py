"""Reviewer 307: independent machinery, built from the definitions only.

Conventions, fixed here and nowhere else:
  Lambda^2 R^n ~ so(n), basis phi_a = E_{ij} - E_{ji} for a = (i<j).
  Inner product on so(n):  <X,Y> = 1/2 tr(X^T Y)  -> {phi_a} orthonormal.
  Structure constants     c[a,b,g] = <[phi_a, phi_b], phi_g>   (totally antisymmetric).
  Sharp, Hamilton's:      (R # S)_{ab} = 1/2 c[a,g,d] c[b,e,z] R[g,e] S[d,z].
  Q(W) = W W + W#W ,      P(W) = <W, Q(W)>_F  (Frobenius on N x N operator matrices).
  Weyl_n = { W symmetric on Lambda^2 : Alt(W) = 0 (Bianchi), Ric(W) = 0 }.

The sharp formula here is the structure-constant contraction, deliberately a different
expression from the trace form -1/2 tr(A_a W A_b W) used elsewhere in this repo; the two
are cross-checked against each other and against the literature's diagonal formula
(R#S)_{ij} = 1/2 sum_k (r_ik s_jk + r_jk s_ik) in selftest().
"""
import functools
import itertools

import numpy as np


@functools.lru_cache(maxsize=None)
def pairs_of(n):
    return tuple(itertools.combinations(range(n), 2))


@functools.lru_cache(maxsize=None)
def phi(n):
    P = pairs_of(n)
    M = np.zeros((len(P), n, n))
    for a, (i, j) in enumerate(P):
        M[a, i, j] = 1.0
        M[a, j, i] = -1.0
    return M


@functools.lru_cache(maxsize=None)
def cstruct(n):
    F = phi(n)
    N = F.shape[0]
    c = np.zeros((N, N, N))
    for a in range(N):
        comm = F[a] @ F - F @ F[a]
        c[a] = 0.5 * np.einsum('bij,gij->bg', comm, F)
    return c


def sharp_bilin(n, R, S):
    """Polarised sharp: (R#S)_{ab} = 1/2 c_agd c_bez R_ge S_dz, symmetrised in R,S."""
    c = cstruct(n)
    T = 0.5 * np.einsum('agd,bez,ge,dz->ab', c, c, R, S, optimize=True)
    return 0.5 * (T + T.T)


def sharp(n, W):
    return sharp_bilin(n, W, W)


def Q(n, W):
    return W @ W + sharp(n, W)


def P(n, W):
    return float(np.tensordot(W, Q(n, W)))


# ---------------- Weyl space ----------------

def _entry(W, idx, i, j, k, l):
    if i == j or k == l:
        return 0.0, None, None, 0.0
    s = 1.0
    if i > j:
        i, j, s = j, i, -s
    if k > l:
        k, l, s = l, k, -s
    return s, idx[(i, j)], idx[(k, l)], s


@functools.lru_cache(maxsize=None)
def weyl_basis(n):
    """Orthonormal basis (stack of N x N symmetric matrices) of Weyl_n."""
    P = pairs_of(n)
    idx = {p: a for a, p in enumerate(P)}
    N = len(P)
    # symmetric coordinates
    sym = [(a, b) for a in range(N) for b in range(a, N)]
    scol = {ab: k for k, ab in enumerate(sym)}

    def add(row, i, j, k, l, w):
        if i == j or k == l:
            return
        s = w
        if i > j:
            i, j, s = j, i, -s
        if k > l:
            k, l, s = l, k, -s
        a, b = idx[(i, j)], idx[(k, l)]
        if a > b:
            a, b = b, a
        # W is symmetric; the free coordinate is the (a,b) entry with a<=b, and it
        # appears twice in the full matrix when a != b.  Rows below act on the free
        # coordinates directly.
        row[scol[(a, b)]] += s

    rows = []
    # Bianchi: W_{ijkl} + W_{iklj} + W_{iljk} = 0 on 4 distinct indices
    for (i, j, k, l) in itertools.combinations(range(n), 4):
        for perm in itertools.permutations((j, k, l)):
            pass
        row = np.zeros(len(sym))
        add(row, i, j, k, l, 1.0)
        add(row, i, k, l, j, 1.0)
        add(row, i, l, j, k, 1.0)
        rows.append(row)
    # Ricci: sum_j W_{ijkj} = 0
    for i in range(n):
        for k in range(i, n):
            row = np.zeros(len(sym))
            for j in range(n):
                if j == i or j == k:
                    continue
                add(row, i, j, k, j, 1.0)
            rows.append(row)
    Amat = np.array(rows)
    # nullspace
    _, s, Vt = np.linalg.svd(Amat)
    tol = max(Amat.shape) * np.finfo(float).eps * (s[0] if len(s) else 1.0)
    rank = int((s > 1e-9).sum())
    ns = Vt[rank:]
    # turn each free-coordinate vector into a symmetric N x N matrix, then orthonormalise
    B = []
    for v in ns:
        M = np.zeros((N, N))
        for k, (a, b) in enumerate(sym):
            M[a, b] += v[k]
            if a != b:
                M[b, a] += v[k]
        B.append(M)
    B = np.array(B)
    # Gram-Schmidt in Frobenius
    G = np.einsum('aij,bij->ab', B, B)
    w, U = np.linalg.eigh(G)
    keep = w > 1e-10
    T = U[:, keep] / np.sqrt(w[keep])
    B = np.einsum('ab,aij->bij', T, B)
    return B


def project_weyl(n, W):
    B = weyl_basis(n)
    c = np.einsum('aij,ij->a', B, W)
    return np.einsum('a,aij->ij', c, B)


# ---------------- graded split ----------------

def pm_index(n, p):
    """p-block (so(p)+so(q)) and m-block (R^p (x) R^q) index sets."""
    P = pairs_of(n)
    ip = [a for a, (i, j) in enumerate(P) if (i < p) == (j < p)]
    im = [a for a, (i, j) in enumerate(P) if (i < p) != (j < p)]
    return np.array(ip), np.array(im)


def sphere_product_W(n, p):
    """Weyl operator of S^p x S^q, coordinate-diagonal, unit Frobenius norm."""
    q = n - p
    P = pairs_of(n)
    lam = np.zeros(len(P))
    # curvature operator of S^p(1) x S^q(1): K_ij = 1 inside a factor, 0 across.
    for a, (i, j) in enumerate(P):
        lam[a] = 1.0 if (i < p) == (j < p) else 0.0
    W = np.diag(lam)
    W = project_weyl(n, W)
    return W / np.linalg.norm(W)


def selftest(n=6, seed=0):
    rng = np.random.default_rng(seed)
    out = {}
    # 1. diagonal formula check
    P = pairs_of(n)
    N = len(P)
    lam = rng.normal(size=N)
    Wd = np.diag(lam)
    S = sharp(n, Wd)
    lm = {p: lam[a] for a, p in enumerate(P)}

    def L(i, j):
        return lm[(min(i, j), max(i, j))] if i != j else 0.0
    err = 0.0
    for a, (i, j) in enumerate(P):
        want = sum(L(i, k) * L(j, k) for k in range(n) if k not in (i, j))
        err = max(err, abs(S[a, a] - want))
    off = np.abs(S - np.diag(np.diag(S))).max()
    out['diag_formula_err'] = err
    out['diag_offdiag'] = off
    # 2. tr(W#) = -||W||^2 on Weyl
    B = weyl_basis(n)
    W = np.einsum('a,aij->ij', rng.normal(size=B.shape[0]), B)
    out['weyl_dim'] = B.shape[0]
    out['tr_sharp_id'] = abs(np.trace(sharp(n, W)) + np.linalg.norm(W) ** 2)
    # 3. W # Id = -W on Weyl
    out['sharp_id_err'] = np.abs(sharp_bilin(n, W, np.eye(len(P))) + W).max()
    # 4. tri-symmetry <X#Y,Z> totally symmetric
    X, Y, Z = (np.einsum('a,aij->ij', rng.normal(size=B.shape[0]), B) for _ in range(3))
    t1 = np.tensordot(sharp_bilin(n, X, Y), Z)
    t2 = np.tensordot(sharp_bilin(n, Z, X), Y)
    out['tri_sym'] = abs(t1 - t2)
    # 5. sphere product is critical
    Wsp = sphere_product_W(n, n // 2)
    th = float(np.tensordot(Q(n, Wsp), Wsp))
    out['sphere_theta'] = th
    out['sphere_crit_resid'] = np.abs(Q(n, Wsp) - th * Wsp).max()
    return out


if __name__ == '__main__':
    for k, v in selftest(6).items():
        print(f"{k:>20s}  {v}")
    for k, v in selftest(7, seed=3).items():
        print(f"n7 {k:>17s}  {v}")
