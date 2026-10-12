"""Reviewer 46, T1/T2: the CP^m family, W_CP2, its padding, and the slack.

W_{CP^m} is produced as the u(m)-invariant line inside Weyl_{2m} -- no
hand-rolled self-dual operator, no curvature formula lookup.  It is then
zero-padded and every claim in T1 and T2 is measured.
"""
import numpy as np
from review_r46_core import (pairs_of, pair_index, structure_constants,
                             weyl_basis, Q_of, P_of, ricci, bianchi_vec,
                             slack_structural, slack_hhm, slack_weighted,
                             slack_theta_identity, negative_part, so_generators)


def lambda2_rep(n, A):
    """The action of A in so(n) on Lambda^2(R^n), in the E_{ij} basis."""
    P = pairs_of(n)
    idx = pair_index(n)
    N = len(P)
    rho = np.zeros((N, N))
    for col, (i, j) in enumerate(P):
        # A.(e_i ^ e_j) = (A e_i) ^ e_j + e_i ^ (A e_j)
        for k in range(n):
            if k != j:
                p, s = ((k, j), 1.0) if k < j else ((j, k), -1.0)
                rho[idx[p], col] += s * A[k, i]
            if k != i:
                p, s = ((i, k), 1.0) if i < k else ((k, i), -1.0)
                rho[idx[p], col] += s * A[k, j]
    return rho


def u_m_generators(m):
    """A spanning set of u(m) inside so(2m), with J = e_1 -> e_2 etc.
    Real form: complex coordinate a uses real basis (2a, 2a+1)."""
    n = 2 * m
    gens = []
    J = np.zeros((n, n))
    for a in range(m):
        J[2 * a, 2 * a + 1] = 1.0
        J[2 * a + 1, 2 * a] = -1.0
    # u(m) = { A in so(2m) : AJ = JA }
    G = so_generators(n)
    rows = []
    for A in G:
        rows.append((A @ J - J @ A).ravel())
    M = np.array(rows).T
    u, s, vt = np.linalg.svd(M, full_matrices=True)
    tol = max(M.shape) * s[0] * 1e-12
    rank = int((s > tol).sum())
    ns = vt[rank:]
    for coef in ns:
        gens.append(np.einsum('k,kij->ij', coef, G))
    return gens, J


def invariant_weyl_line(n, gens, tol=1e-9):
    """The subspace of Weyl_n annihilated by rho(X) . W  (commutator action)."""
    basis = weyl_basis(n)
    rhos = [lambda2_rep(n, A) for A in gens]
    rows = []
    for W in basis:
        blocks = [(r @ W - W @ r).ravel() for r in rhos]
        rows.append(np.concatenate(blocks))
    A = np.array(rows).T
    u, s, vt = np.linalg.svd(A, full_matrices=False)
    tol2 = max(A.shape) * (s[0] if s.size else 1.0) * 1e-11
    rank = int((s > tol2).sum())
    ns = vt[rank:] if vt.shape[0] > rank else np.zeros((0, len(basis)))
    return np.einsum('kc,cij->kij', ns, basis)


def pad(W, n_small, n_big):
    Ps, Pb = pairs_of(n_small), pairs_of(n_big)
    ib = pair_index(n_big)
    N = len(Pb)
    out = np.zeros((N, N))
    for a, pa in enumerate(Ps):
        for b, pb in enumerate(Ps):
            out[ib[pa], ib[pb]] = W[a, b]
    return out


def report(n, W, c, label):
    ev = np.linalg.eigvalsh(W)
    tol = 1e-9
    npos = int((ev > tol).sum()); nneg = int((ev < -tol).sum())
    nzero = len(ev) - npos - nneg
    QW = Q_of(c, W)
    th = P_of(c, W)
    res = np.abs(QW - th * W).max()
    ric = np.abs(ricci(n, W)).max()
    bia = np.abs(bianchi_vec(n, W)).max()
    Smmm = slack_structural(c, W)
    Shhm = slack_hhm(c, W)
    Sw = slack_weighted(c, W)
    Sid = slack_theta_identity(n, c, W)
    # dim [m,m]
    _, Pm, evs, V = negative_part(W, tol)
    m_basis = V[:, evs < -tol]
    d = m_basis.shape[1]
    brs = []
    for a in range(d):
        for b in range(a + 1, d):
            brs.append(np.einsum('i,j,ijg->g', m_basis[:, a], m_basis[:, b], c))
    dim_mm = 0 if not brs else int(np.linalg.matrix_rank(np.array(brs), tol=1e-9))
    print(f"{label:28s} n={n:3d} |W|={np.linalg.norm(W):.6f} theta={th:.9f} res={res:.2e} "
          f"|Ric|={ric:.1e} |Bianchi|={bia:.1e}")
    print(f"{'':28s} spectrum: {nneg} neg / {nzero} zero / {npos} pos  (N={len(ev)})  "
          f"dim m={d}  dim[m,m]={dim_mm}")
    print(f"{'':28s} S_mmm={Smmm:.6e}  S_hhm={Shhm:.6e}  S_weighted={Sw:.6e}  S_theta-id={Sid:.6e}")
    return dict(theta=th, res=res, nneg=nneg, nzero=nzero, npos=npos, dim_mm=dim_mm,
                Smmm=Smmm, Shhm=Shhm, Sw=Sw, Sid=Sid)


if __name__ == "__main__":
    print("=== CP^m family as the u(m)-invariant Weyl line ===")
    cp = {}
    for m in (2, 3, 4):
        n = 2 * m
        gens, J = u_m_generators(m)
        line = invariant_weyl_line(n, gens)
        print(f"m={m} (n={n}): dim Weyl^{{u({m})}}_{n} = {line.shape[0]}")
        if line.shape[0] != 1:
            continue
        W = line[0] / np.linalg.norm(line[0])
        c = structure_constants(n)
        if P_of(c, W) < 0:
            W = -W
        cp[m] = W
        report(n, W, c, f"W_CP^{m} (native n={n})")
        ev = np.linalg.eigvalsh(W)
        print(f"{'':28s} eigenvalues*sqrt(6): {np.round(ev*np.sqrt(6),9)}")
        print()

    print("=== T1: W_CP2 zero-padded ===")
    W4 = cp[2]
    for n in (8, 10, 12):
        c = structure_constants(n)
        Wp = pad(W4, 4, n)
        N = n * (n - 1) // 2
        r = report(n, Wp, c, "W_CP2 padded")
        claim_zero = {8: 25, 10: 42, 12: 63}[n]
        print(f"{'':28s} T1 claim: 2 neg / 1 pos / {claim_zero} zero   -> "
              f"{'MATCH' if (r['nneg'], r['npos'], r['nzero']) == (2, 1, claim_zero) else 'MISMATCH'}")
        print()

    print("=== T2: balanced sphere products ===")
    def sphere_product(n, p):
        """Weyl operator of S^p x S^q as the coordinate-diagonal operator with
        the two-block pattern, Ricci-flattened."""
        q = n - p
        idx = pair_index(n)
        lam = np.zeros(len(idx))
        # curvature of the product metric with radii chosen Einstein, then Weyl part:
        # take the diagonal ansatz a on pp-planes, b on qq-planes, x on mixed,
        # solve row-sum-zero + criticality within the 3-parameter family.
        for (i, j), k in idx.items():
            if i < p and j < p:
                lam[k] = 1.0
            elif i >= p and j >= p:
                lam[k] = 1.0
            else:
                lam[k] = 0.0
        # Weyl-project the product curvature: subtract Ricci parts.
        R = np.diag(lam)
        # explicit Weyl projection for coordinate-diagonal operators:
        Ric = ricci(n, R)
        s = float(np.trace(Ric))
        # R_weyl = R - (1/(n-2)) (Ric o Id) + s/((n-1)(n-2)) (Id o Id)/2 ...
        # easier: project onto the Weyl basis
        return R, Ric, s

    basis_cache = {}
    for n, p in ((8, 4), (12, 6)):
        c = structure_constants(n)
        R, Ric, s = sphere_product(n, p)
        B = weyl_basis(n) if n <= 10 else None
        if B is None:
            # project by solving least squares on the diagonal 3-parameter family
            idx = pair_index(n)
            lam = np.zeros(len(idx))
            # ansatz: a on pp, a on qq, x on mixed, row sums zero
            # row i<p: (p-1)a + q x = 0
            q = n - p
            a = 1.0
            x = -(p - 1) * a / q
            for (i, j), k in idx.items():
                if (i < p) == (j < p):
                    lam[k] = a
                else:
                    lam[k] = x
            W = np.diag(lam)
        else:
            flat = B.reshape(B.shape[0], -1)
            W = np.einsum('k,kij->ij', flat @ R.ravel(), B)
        W = W / np.linalg.norm(W)
        if P_of(c, W) < 0:
            W = -W
        report(n, W, c, f"S^{p} x S^{n-p}")
        print()
