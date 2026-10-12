"""Reviewer 40 -- claims C1..C5 on the CP^m family.

C1  u(m) = {E antisym : EJ = JE}, dim m^2; the elementary-generator span is wrong.
C2  dim Weyl_{2m}^{u(m)} = 1, generator critical.
C3  theta(CP^m) closed form.
C4  dim E(1/2) = dim orbit = m(m-1).
C5  lambda_max(L_e|W^perp) = (m+2)/(2(m+1)) with multiplicity m^2-1.
"""
import sys, time
import numpy as np
from fractions import Fraction
from review_r40_core import (pairs_of, so_basis, struct_const, Qop, circ, ip,
                             weyl_basis, weyl_dim_formula, coords, project,
                             rho_alg, rho_grp, L_matrix)

LOG = '../agent_logs/review_r40_cpm.log'


def log(msg):
    print(msg, flush=True)
    with open(LOG, 'a') as f:
        f.write(msg + '\n')


def Jmat(m):
    n = 2 * m
    J = np.zeros((n, n))
    for k in range(m):
        J[2 * k, 2 * k + 1] = 1.0
        J[2 * k + 1, 2 * k] = -1.0
    return J


def u_m_basis(m):
    """Solution space of {E antisym : EJ = JE} -- solved as a linear system."""
    n = 2 * m
    J = Jmat(m)
    B, prs, idx = so_basis(n)
    N = len(prs)
    rows = []
    for a in range(N):
        C = B[a] @ J - J @ B[a]
        rows.append(C.reshape(-1))
    Mm = np.array(rows).T                      # (n*n, N)
    U, s, Vt = np.linalg.svd(Mm)
    tol = max(Mm.shape) * s[0] * 1e-12
    rank = int(np.sum(s > tol))
    ns = Vt[rank:]
    return np.einsum('kd,dij->kij', ns, B), prs, idx, J


def elementary_commuting(m):
    """The elementary phi_ab that individually commute with J."""
    n = 2 * m
    J = Jmat(m)
    B, prs, idx = so_basis(n)
    out = []
    for a in range(len(prs)):
        if np.max(np.abs(B[a] @ J - J @ B[a])) < 1e-12:
            out.append(B[a])
    return np.array(out) if out else np.zeros((0, n, n))


def invariant_weyl(n, gens, Bs, prs, need_all=True):
    """Kernel of [rho(E), .] on Weyl_n, for the listed so(n) generators."""
    D = Bs.shape[0]
    stack = []
    for E in gens:
        r = rho_alg(n, E, prs)
        img = np.einsum('ij,cjk->cik', r, Bs) - np.einsum('cij,jk->cik', Bs, r)
        stack.append(np.einsum('dij,cij->dc', Bs, img))
    S = np.vstack(stack)
    U, s, Vt = np.linalg.svd(S, full_matrices=True)
    tol = max(S.shape) * (s[0] if len(s) else 1.0) * 1e-11
    rank = int(np.sum(s > tol))
    return Vt[rank:], (s[rank - 1] if rank else np.inf), (s[rank] if rank < len(s) else 0.0)


def run(m, do_spectrum=True):
    n = 2 * m
    t0 = time.time()
    log(f"--- m={m} (n={n}) ---")
    A = struct_const(n)
    Bs, prs, idx = weyl_basis(n)
    D = Bs.shape[0]
    assert D == weyl_dim_formula(n)
    log(f"  dim Weyl_{n} = {D} (formula {weyl_dim_formula(n)})")

    # ---- C1
    gens, prs2, idx2, J = u_m_basis(m)
    log(f"  C1: dim{{E antisym: EJ=JE}} = {gens.shape[0]}  (m^2 = {m*m})")
    elem = elementary_commuting(m)
    log(f"  C1: # elementary phi_ab commuting with J = {elem.shape[0]}")
    if elem.shape[0]:
        inv_e, _, _ = invariant_weyl(n, elem, Bs, prs)
        log(f"  C1: dim Weyl^{{span of elementary commuting phi}} = {inv_e.shape[0]}"
            f"   (m(m-1) = {m*(m-1)})")
    else:
        log("  C1: elementary set empty")

    # ---- C2: full u(m) invariants; also 2 random elements only, as a cross-check
    inv, s_last, s_first = invariant_weyl(n, gens, Bs, prs)
    log(f"  C2: dim Weyl_{n}^u({m}) = {inv.shape[0]}   (gap {s_last:.3e} -> {s_first:.3e})")
    rng = np.random.default_rng(1000 + m)
    r2 = [np.einsum('k,kij->ij', rng.standard_normal(gens.shape[0]), gens) for _ in range(2)]
    inv2, _, _ = invariant_weyl(n, r2, Bs, prs)
    log(f"  C2: dim of commutant of 2 random u({m}) elements = {inv2.shape[0]}")

    if inv.shape[0] != 1:
        log("  C2: NOT one-dimensional -- stopping this m")
        return None
    W = np.einsum('d,dij->ij', inv[0], Bs)
    W = W / np.sqrt(ip(W, W))
    QW = Qop(A, W)
    theta = ip(W, QW)
    if theta < 0:
        W = -W
        QW = Qop(A, W)
        theta = ip(W, QW)
        log("  C2: invariant generator was on the negative branch -- sign flipped")
    resid = np.max(np.abs(QW - theta * W))
    log(f"  C2/C3: theta = {theta:.12f}   |Q(W)-theta W|_inf = {resid:.3e}")

    # ---- C3 closed form
    cf = np.sqrt((m + 1) * (2 * m - 1) / (3.0 * m * (m - 1)))
    log(f"  C3: sqrt((m+1)(2m-1)/(3m(m-1))) = {cf:.12f}   diff = {abs(cf-theta):.2e}")

    # sanity: is W really the CP^m Weyl operator?  Its stabiliser and eigenvalues
    ev = np.linalg.eigvalsh(W)
    uu, cc = np.unique(np.round(ev, 9), return_counts=True)
    log(f"  W spectrum: {[(float(a), int(b)) for a, b in zip(uu, cc)]}")

    if not do_spectrum:
        return dict(m=m, theta=theta)

    # ---- L_e
    e = W / theta
    Le, out_res = L_matrix(A, Bs, e, chunk=40,
                           progress=lambda i, D_, r: None)
    log(f"  L_e built, out-of-Weyl residual {out_res:.2e}, symmetry {np.max(np.abs(Le-Le.T)):.2e},"
        f" tr = {np.trace(Le):.2e}")
    cW = coords(Bs, W)
    log(f"  L_e W - W  (coords) = {np.max(np.abs(Le@cW - cW)):.2e}")

    w, V = np.linalg.eigh(Le)
    # collapse
    rw = np.round(w, 8)
    uu, cc = np.unique(rw, return_counts=True)
    spec = [(float(a), int(b)) for a, b in zip(uu, cc)]
    log(f"  L_e spectrum: {spec}")

    # ---- C4: orbit tangent
    Bso, _, _ = so_basis(n)
    tang = []
    for a in range(Bso.shape[0]):
        r = rho_alg(n, Bso[a], prs)
        tang.append(coords(Bs, r @ W - W @ r))
    Tt = np.array(tang)
    sv = np.linalg.svd(Tt, compute_uv=False)
    tol = max(Tt.shape) * sv[0] * 1e-11
    orb = int(np.sum(sv > tol))
    log(f"  C4: dim orbit = {orb}   (m(m-1) = {m*(m-1)})   [sv gap {sv[orb-1]:.2e} -> "
        f"{sv[orb] if orb < len(sv) else 0.0:.2e}]")
    half = np.where(np.abs(w - 0.5) < 1e-7)[0]
    log(f"  C4: dim E(1/2) = {len(half)}")
    if len(half) and orb:
        # principal angles between E(1/2) and orbit tangent
        Uo = np.linalg.svd(Tt.T, full_matrices=False)[0][:, :orb]
        Uh = V[:, half]
        cs = np.linalg.svd(Uh.T @ Uo, compute_uv=False)
        log(f"  C4: principal cosines E(1/2) vs orbit: min {cs.min():.9f} max {cs.max():.9f}")

    # ---- C5
    mask = np.abs(w - 1.0) > 1e-7
    lam_max = w[mask].max()
    mult = int(np.sum(np.abs(w - lam_max) < 1e-7))
    pred = (m + 2) / (2.0 * (m + 1))
    log(f"  C5: lambda_max(L_e|W^perp) = {lam_max:.12f}  pred (m+2)/(2(m+1)) = {pred:.12f}"
        f"  mult = {mult}  (m^2-1 = {m*m-1})")
    # check the lambda=1 eigenvector really is W
    top = np.where(np.abs(w - 1.0) < 1e-7)[0]
    log(f"  C5: dim E(1) = {len(top)};  |<E(1),W>| = "
        f"{np.linalg.norm(V[:, top].T @ cW):.9f}")

    np.save(f'scripts/data/review_r40_W_cpm{m}.npy', W)
    np.save(f'review_r40_Le_cpm{m}.npy', Le)
    np.save(f'review_r40_Bs_n{n}.npy', Bs)
    log(f"  [m={m} done in {time.time()-t0:.1f}s]")
    return dict(m=m, theta=theta, spec=spec, orb=orb, half=len(half))


if __name__ == '__main__':
    ms = [int(x) for x in sys.argv[1:]] or [3, 4, 5]
    for m in ms:
        run(m)
