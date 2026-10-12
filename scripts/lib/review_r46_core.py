"""Reviewer 46: independent machinery for algebraic curvature operators.

Everything is built from definitions here; nothing is imported from the code
under review.  Conventions:

  Lambda^2(R^n) has orthonormal basis  E_{ij} = e_i ^ e_j,  i < j.
  The identification with so(n) sends E_{ij} to the matrix A_{ij} with
  (A_{ij})_{ij} = 1, (A_{ij})_{ji} = -1, and the inner product on so(n) is
  <A,B> = (1/2) tr(A^T B), which makes  E_{ij} <-> A_{ij}  an isometry.

  Curvature operators are symmetric endomorphisms of Lambda^2.
  Ric(R)_{ik} = sum_j R(e_i ^ e_j, e_k ^ e_j).
  First Bianchi: R_{ijkl} + R_{iklj} + R_{iljk} = 0 (all indices distinct).
  Q(R) = R^2 + R^#, with
      R^#_{ab} = (1/2) sum c_{a g d} c_{b e z} R_{g e} R_{d z},
  c_{abg} = <[phi_a, phi_b], phi_g>  the so(n) structure constants.
"""
import itertools
import numpy as np


# --------------------------------------------------------------- basic setup

def pairs_of(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]


def pair_index(n):
    return {p: k for k, p in enumerate(pairs_of(n))}


def so_generators(n):
    """A_{ij} as n x n matrices, ordered like pairs_of(n)."""
    out = []
    for (i, j) in pairs_of(n):
        A = np.zeros((n, n))
        A[i, j] = 1.0
        A[j, i] = -1.0
        out.append(A)
    return np.array(out)


def structure_constants(n):
    """c[a,b,g] = <[A_a, A_b], A_g> with <X,Y> = (1/2) tr(X^T Y).

    Built entrywise from the classical formula rather than by matrix products,
    then cross-checked against the matrix products in validate().
    """
    P = pairs_of(n)
    idx = pair_index(n)
    N = len(P)
    c = np.zeros((N, N, N))
    for a, (i, j) in enumerate(P):
        for b, (k, l) in enumerate(P):
            # [A_ij, A_kl] is nonzero only when the pairs share exactly one index
            shared = {i, j} & {k, l}
            if len(shared) != 1:
                continue
            s = shared.pop()
            u = j if s == i else i          # the other index of the first pair
            v = l if s == k else k          # the other index of the second pair
            if u == v:
                continue
            # [A_{s u}, A_{s v}] with the orientation signs restored
            sgn = (1.0 if s == i else -1.0) * (1.0 if s == k else -1.0)
            # [A_{su}, A_{sv}] = -A_{uv}   (check: (A_su A_sv)_{u v} etc.)
            p = (u, v) if u < v else (v, u)
            osgn = 1.0 if u < v else -1.0
            c[a, b, idx[p]] += -sgn * osgn
    return c


def lam2_to_mat(n, v):
    """Lambda^2 vector -> so(n) matrix."""
    A = np.zeros((n, n))
    for k, (i, j) in enumerate(pairs_of(n)):
        A[i, j] += v[k]
        A[j, i] -= v[k]
    return A


# --------------------------------------------------------- curvature algebra

def sharp_bilinear(c, X, Y):
    """Polarized #:  (X # Y)_{ab} = (1/2) sum c_{agd} c_{bez} X_{(ge} Y_{dz)}
    symmetrized in X,Y.  Returns a symmetric matrix."""
    def half(A, B):
        # Z[g,d,a] = sum_{e,z} A_{eg} B_{zd} c_{eza}
        Y1 = np.einsum('eg,eza->gza', A, c, optimize=True)
        Z = np.einsum('gza,zd->gda', Y1, B, optimize=True)
        return 0.5 * np.einsum('gda,gdb->ab', Z, c, optimize=True)
    M = 0.5 * (half(X, Y) + half(Y, X))
    return 0.5 * (M + M.T)


def sharp(c, X):
    return sharp_bilinear(c, X, X)


def B_bilin(c, X, Y):
    """Polarization of Q: B(X,X) = Q(X)."""
    return 0.5 * (X @ Y + Y @ X) + sharp_bilinear(c, X, Y)


def Q_of(c, X):
    return X @ X + sharp(c, X)


def P_of(c, X):
    return float(np.sum(X * Q_of(c, X)))


# ------------------------------------------------------- Weyl space, Ricci, Bianchi

def ricci(n, R):
    """Ric_{ik} = sum_j R(e_i^e_j, e_k^e_j)."""
    idx = pair_index(n)

    def comp(i, j, k, l):
        if i == j or k == l:
            return 0.0
        si = 1.0
        if i > j:
            i, j, si = j, i, -si
        sk = 1.0
        if k > l:
            k, l, sk = l, k, -sk
        return si * sk * R[idx[(i, j)], idx[(k, l)]]

    Ric = np.zeros((n, n))
    for i in range(n):
        for k in range(n):
            Ric[i, k] = sum(comp(i, j, k, j) for j in range(n))
    return Ric


def bianchi_vec(n, R):
    """The first-Bianchi residual, one number per 4-subset."""
    idx = pair_index(n)

    def comp(i, j, k, l):
        si = 1.0
        if i > j:
            i, j, si = j, i, -si
        sk = 1.0
        if k > l:
            k, l, sk = l, k, -sk
        return si * sk * R[idx[(i, j)], idx[(k, l)]]

    out = []
    for (i, j, k, l) in itertools.combinations(range(n), 4):
        out.append(comp(i, j, k, l) + comp(i, k, l, j) + comp(i, l, j, k))
    return np.array(out)


def weyl_basis(n):
    """Orthonormal basis of Weyl_n = {R symmetric on Lambda^2 : Ric=0, Bianchi=0},
    returned as an array of shape (dim, N, N)."""
    N = n * (n - 1) // 2
    # symmetric-matrix coordinates
    sym = []
    for a in range(N):
        for b in range(a, N):
            M = np.zeros((N, N))
            M[a, b] = 1.0
            M[b, a] = 1.0
            if a == b:
                M *= 1.0
            sym.append(M / np.linalg.norm(M))
    sym = np.array(sym)
    rows = []
    for M in sym:
        r = np.concatenate([ricci(n, M).ravel(), bianchi_vec(n, M)])
        rows.append(r)
    A = np.array(rows).T                     # constraints x coords
    # nullspace of A
    u, s, vt = np.linalg.svd(A, full_matrices=True)
    tol = max(A.shape) * (s[0] if s.size else 1.0) * 1e-12
    rank = int((s > tol).sum())
    ns = vt[rank:]                           # (dim, ncoords)
    basis = np.einsum('kc,cij->kij', ns, sym)
    # orthonormalize in the Frobenius inner product
    flat = basis.reshape(basis.shape[0], -1)
    qf, _ = np.linalg.qr(flat.T)
    basis = qf.T.reshape(-1, N, N)
    return basis


def weyl_projector_from_basis(basis):
    flat = basis.reshape(basis.shape[0], -1)
    return flat.T @ flat


# ------------------------------------------------------------ the slack S

def negative_part(W, tol=0.0):
    """W_- = -(negative part), a positive semidefinite operator, plus the
    projector onto the strictly negative eigenspace."""
    ev, V = np.linalg.eigh(W)
    neg = ev < -tol
    Wm = (V[:, neg] * (-ev[neg])) @ V[:, neg].T
    Pm = V[:, neg] @ V[:, neg].T
    return Wm, Pm, ev, V


def slack_structural(c, W, tol=1e-9):
    """S_mmm = sum_{a,b,g in m} c_{abg}^2 with m the (strictly) negative
    eigenspace of W.  Zero iff Pi_m [m, m] = 0."""
    _, Pm, _, _ = negative_part(W, tol)
    t = np.einsum('abg,ax->xbg', c, Pm, optimize=True)
    t = np.einsum('xbg,by->xyg', t, Pm, optimize=True)
    t = np.einsum('xyg,gz->xyz', t, Pm, optimize=True)
    return float(np.sum(t * t))


def slack_hhm(c, W, tol=1e-9):
    """S_hhm = sum over triples with exactly one index in m.  By total
    antisymmetry of c this is simultaneously the [h,h] -> m leak and the
    [h,m] -> h leak."""
    _, Pm, _, _ = negative_part(W, tol)
    Ph = np.eye(W.shape[0]) - Pm
    t = np.einsum('abg,ax->xbg', c, Ph, optimize=True)
    t = np.einsum('xbg,by->xyg', t, Ph, optimize=True)
    t = np.einsum('xyg,gz->xyz', t, Pm, optimize=True)
    return float(np.sum(t * t))


def slack_weighted(c, W, tol=0.0):
    """S_w = <(W_-)^#, W_-> = (1/2) sum_{abg} c^2 nu_a nu_b nu_g, the
    eigenvalue-weighted version.  A polynomial in W_-, hence continuous."""
    Wm, _, _, _ = negative_part(W, tol)
    return float(np.sum(sharp(c, Wm) * Wm))


def slack_theta_identity(n, c, W):
    """The project's definition: S = ||Ric(W_-)||^2 + 6 delta^2
       - theta tr(W_-) - tr(W_-^2), with delta the Bianchi defect."""
    Wm, _, _, _ = negative_part(W)
    th = P_of(c, W)
    d2 = float(np.sum(bianchi_vec(n, Wm) ** 2))
    rm = ricci(n, Wm)
    return (float(np.sum(rm * rm)) + 6.0 * d2
            - th * float(np.trace(Wm)) - float(np.trace(Wm @ Wm)))


# ------------------------------------------------------------- validations

def validate(nmax=9, verbose=True):
    ok = True
    for n in range(4, nmax + 1):
        d = weyl_basis(n).shape[0]
        pred = n * (n + 1) * (n + 2) * (n - 3) // 12
        good = (d == pred)
        ok &= good
        if verbose:
            print(f"  dim Weyl_{n} = {d:5d}  predicted {pred:5d}  {'OK' if good else 'FAIL'}")
    # structure constants against matrix commutators
    for n in (4, 6, 7):
        c = structure_constants(n)
        G = so_generators(n)
        N = G.shape[0]
        cm = np.zeros((N, N, N))
        for a in range(N):
            for b in range(N):
                Cm = G[a] @ G[b] - G[b] @ G[a]
                for g in range(N):
                    cm[a, b, g] = 0.5 * np.trace(Cm.T @ G[g])
        e = np.abs(c - cm).max()
        anti = max(np.abs(c + np.transpose(c, (1, 0, 2))).max(),
                   np.abs(c + np.transpose(c, (0, 2, 1))).max(),
                   np.abs(c - np.transpose(c, (2, 0, 1))).max())
        if verbose:
            print(f"  n={n}: |c - c_matrix| = {e:.2e}   total antisymmetry residual = {anti:.2e}")
        ok &= (e < 1e-12 and anti < 1e-12)
        # Casimir: sum_{b,g} c_{abg}^2 = 2(n-2) for every a
        cas = np.einsum('abg,abg->a', c, c)
        if verbose:
            print(f"        Casimir sum_bg c^2 = {cas.min():.6f}..{cas.max():.6f}  (2(n-2)={2*(n-2)})")
        ok &= abs(cas.max() - 2 * (n - 2)) < 1e-12 and abs(cas.min() - 2 * (n - 2)) < 1e-12
    # diagonal sharp formula
    for n in (5, 6, 7):
        c = structure_constants(n)
        rng = np.random.default_rng(7)
        P = pairs_of(n)
        idx = pair_index(n)
        lam = rng.normal(size=len(P))
        R = np.diag(lam)
        Rs = sharp(c, R)
        err = 0.0
        for a, (i, j) in enumerate(P):
            want = sum(lam[idx[tuple(sorted((i, k)))]] * lam[idx[tuple(sorted((j, k)))]]
                       for k in range(n) if k != i and k != j)
            err = max(err, abs(Rs[a, a] - want))
        off = np.abs(Rs - np.diag(np.diag(Rs))).max()
        if verbose:
            print(f"  n={n}: diagonal R^# formula err {err:.2e}, off-diagonal leak {off:.2e}")
        ok &= err < 1e-10 and off < 1e-10
    # trilinear symmetry of T(X,Y,Z) = <X, B(Y,Z)>
    n = 6
    c = structure_constants(n)
    rng = np.random.default_rng(3)
    N = n * (n - 1) // 2
    def rs():
        M = rng.normal(size=(N, N))
        return M + M.T
    X, Y, Z = rs(), rs(), rs()
    vals = [float(np.sum(A * B_bilin(c, Bm, C))) for (A, Bm, C) in
            [(X, Y, Z), (Y, X, Z), (Z, Y, X), (Y, Z, X), (X, Z, Y), (Z, X, Y)]]
    spread = max(vals) - min(vals)
    if verbose:
        print(f"  trilinear symmetry spread = {spread:.2e}  (scale {abs(vals[0]):.3e})")
    ok &= spread < 1e-9 * max(1.0, abs(vals[0]))
    return ok


if __name__ == "__main__":
    print("Reviewer 46 core validation")
    print("PASS" if validate() else "FAIL")
