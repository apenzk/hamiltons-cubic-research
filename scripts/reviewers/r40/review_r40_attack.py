"""Reviewer 40 -- attacks on C1..C6.

A1  Independent Fubini-Study construction of W_{CP^m}, compared with the u(m)-invariant
    generator: is the invariant element really the CP^m Weyl operator?
A2  The m=2 boundary and whether dim Weyl_{2m}^{u(m)} = 1 can fail.
A3  C1's elementary-generator span, identified as a group (which subgroup is it?).
A4  Moment consistency of the closed-form spectrum: tr(L_e), tr(L_e^2), tr(L_e^3).
A5  Does the invariant generator ever land on the negative branch?
A6  Is the stabiliser bigger than U(m)?  (conjugation, and the full isotropy algebra)
"""
import sys, time
import numpy as np
import sympy as sp
from fractions import Fraction

from review_r40_core import (pairs_of, so_basis, struct_const, Qop, ip, weyl_basis,
                             weyl_dim_formula, coords, project, rho_alg, rho_grp,
                             L_matrix, to_tensor)
from review_r40_cpm import Jmat, u_m_basis, invariant_weyl, elementary_commuting

LOG = '../agent_logs/review_r40_cpm.log'


def log(msg):
    print(msg, flush=True)
    with open(LOG, 'a') as f:
        f.write(msg + '\n')


def fubini_study_operator(m):
    """Curvature operator of CP^m (holomorphic sectional curvature 4), from the
    standard tensor formula, built with no reference to the invariant-subspace code:
       R(X,Y,Z,T) = <X,Z><Y,T> - <X,T><Y,Z>
                  + <JX,Z><JY,T> - <JX,T><JY,Z> + 2<JX,Y><JZ,T>
    """
    n = 2 * m
    J = Jmat(m)
    d = np.eye(n)
    R = (np.einsum('ik,jl->ijkl', d, d) - np.einsum('il,jk->ijkl', d, d)
         + np.einsum('ik,jl->ijkl', J, J) - np.einsum('il,jk->ijkl', J, J)
         + 2 * np.einsum('ij,kl->ijkl', J, J))
    return R


def tensor_to_pair(n, R, prs):
    N = len(prs)
    M = np.zeros((N, N))
    for a, (i, j) in enumerate(prs):
        for b, (k, l) in enumerate(prs):
            M[a, b] = R[i, j, k, l]
    return M


def A1(ms=(3, 4, 5)):
    log("=== A1: independent Fubini-Study construction ===")
    for m in ms:
        n = 2 * m
        prs, idx = pairs_of(n)
        A = struct_const(n)
        Bs, _, _ = weyl_basis(n)
        R = fubini_study_operator(m)
        # curvature-tensor sanity
        bia = R + np.transpose(R, (0, 2, 3, 1)) + np.transpose(R, (0, 3, 1, 2))
        sym = R - np.transpose(R, (2, 3, 0, 1))
        anti = R + np.transpose(R, (1, 0, 2, 3))
        ric = np.einsum('ijil->jl', R)
        log(f"  m={m}: Bianchi {np.max(np.abs(bia)):.1e}, pair-swap {np.max(np.abs(sym)):.1e}, "
            f"antisym {np.max(np.abs(anti)):.1e}, Ric = {ric[0,0]:.3f}*Id "
            f"(off {np.max(np.abs(ric - ric[0,0]*np.eye(n))):.1e})")
        Rp = tensor_to_pair(n, R, prs)
        Wp = project(Bs, Rp)             # Weyl part = orthogonal projection onto Weyl_n
        out = np.max(np.abs(Rp - Wp - project(Bs, Rp - Wp)))
        Wp = Wp / np.sqrt(ip(Wp, Wp))
        th = ip(Wp, Qop(A, Wp))
        if th < 0:
            Wp, th = -Wp, -th
        res = np.max(np.abs(Qop(A, Wp) - th * Wp))
        Wi = np.load(f'scripts/data/review_r40_W_cpm{m}.npy')
        ov = abs(ip(Wp, Wi))
        cf = np.sqrt((m + 1) * (2 * m - 1) / (3.0 * m * (m - 1)))
        log(f"       Weyl part: theta = {th:.12f} (closed form {cf:.12f}), crit resid {res:.1e},"
            f" |<W_FS, W_invariant>| = {ov:.12f}")


def A2(ms=(2, 3, 4, 5, 6, 7)):
    log("=== A2: dim Weyl_{2m}^{u(m)} across m, including the m=2 boundary ===")
    for m in ms:
        n = 2 * m
        if n > 12:
            log(f"  m={m}: (skipped, covered by the full pipeline)")
            continue
        prs, idx = pairs_of(n)
        Bs, _, _ = weyl_basis(n)
        gens, _, _, _ = u_m_basis(m)
        inv, sl, sf = invariant_weyl(n, gens, Bs, prs)
        log(f"  m={m} (n={n}): dim Weyl_{n} = {Bs.shape[0]}, dim u({m}) = {gens.shape[0]}, "
            f"dim invariants = {inv.shape[0]}  (gap {sl:.2e} -> {sf:.2e})")
        if inv.shape[0] > 1:
            A = struct_const(n)
            for k in range(inv.shape[0]):
                W = np.einsum('d,dij->ij', inv[k], Bs)
                W = W / np.sqrt(ip(W, W))
                th = ip(W, Qop(A, W))
                r = np.max(np.abs(Qop(A, W) - th * W))
                log(f"      basis vector {k}: theta = {th:+.9f}, criticality residual {r:.1e}")


def A3(ms=(3, 4, 5)):
    log("=== A3: C1's elementary-generator span, identified ===")
    for m in ms:
        n = 2 * m
        prs, idx = pairs_of(n)
        Bs, _, _ = weyl_basis(n)
        elem = elementary_commuting(m)
        names = [prs[a] for a in range(len(prs))
                 if np.max(np.abs(so_basis(n)[0][a] @ Jmat(m) - Jmat(m) @ so_basis(n)[0][a])) < 1e-12]
        log(f"  m={m}: elementary phi_ab commuting with J: {names}  (the maximal torus of U({m}))")
        # the Lie algebra they generate
        span = [E for E in elem]
        for _ in range(3):
            new = []
            for X in span:
                for Y in span:
                    new.append(X @ Y - Y @ X)
            allv = np.array([v.reshape(-1) for v in span + new])
            r = np.linalg.matrix_rank(allv, tol=1e-10)
            if r == len(span):
                break
        log(f"       Lie algebra generated: dim {np.linalg.matrix_rank(np.array([v.reshape(-1) for v in span]), tol=1e-10)}"
            f" (abelian: {max(np.max(np.abs(X@Y-Y@X)) for X in span for Y in span):.1e})")
        inv, _, _ = invariant_weyl(n, elem, Bs, prs)
        log(f"       dim of its Weyl-invariants = {inv.shape[0]}  (m(m-1) = {m*(m-1)}, "
            f"m^2 = {m*m}, claim says m(m-1))")


def A4(mmax=14):
    log("=== A4: moments of the closed-form spectrum, symbolic in m ===")
    m = sp.symbols('m', positive=True)
    fams = [
        (sp.Integer(1), sp.Integer(1)),                                   # <W>
        ((m + 2) / (2 * (m + 1)), m**2 - 1),                              # su(m)
        (sp.Rational(1, 2), m * (m - 1)),                                 # orbit
        (2 / (m + 1), m**2 * (m + 1) * (m - 3) / 4),                      # Lam2 x Lam2*_0
        (-3 / (m + 1), m**2 * (m**2 - 1) / 6),                            # S22 + dual
        (sp.Integer(0), 2 * m**2 * (m**2 - 4) / 3 + m**2 * (m + 3) * (m - 1) / 4),
    ]
    for k in (0, 1, 2, 3):
        s = sp.simplify(sum(d * v**k for v, d in fams))
        log(f"  tr(L_e^{k}) = {sp.factor(sp.simplify(s))}")
    dw = sp.factor(sp.simplify(m * (m + 1) * (2 * m + 1) * (2 * m - 3) / 3))
    log(f"  (dim Weyl_2m = {dw}; tr(L_e^0) must equal it)")
    for mm in (3, 4, 5, 6, 7):
        Le = np.load(f'review_r40_Le_cpm{mm}.npy')
        t1, t2, t3 = np.trace(Le), np.trace(Le @ Le), np.trace(Le @ Le @ Le)
        p2 = sp.simplify(sum(d * v**2 for v, d in fams)).subs(m, mm)
        p3 = sp.simplify(sum(d * v**3 for v, d in fams)).subs(m, mm)
        log(f"  m={mm}: measured tr={t1:+.2e} tr^2={t2:.9f} tr^3={t3:.9f} | "
            f"predicted {float(p2):.9f} {float(p3):.9f}")


def A5A6(ms=(3, 4, 5, 6, 7)):
    log("=== A5/A6: sign branch, conjugation, and the full isotropy algebra ===")
    for m in ms:
        n = 2 * m
        prs, idx = pairs_of(n)
        A = struct_const(n)
        W = np.load(f'scripts/data/review_r40_W_cpm{m}.npy')
        # full isotropy algebra of W inside so(n)
        Bso, _, _ = so_basis(n)
        rows = []
        for a in range(Bso.shape[0]):
            r = rho_alg(n, Bso[a], prs)
            rows.append((r @ W - W @ r).reshape(-1))
        Mm = np.array(rows)
        sv = np.linalg.svd(Mm, compute_uv=False)
        rank = int(np.sum(sv > max(Mm.shape) * sv[0] * 1e-11))
        log(f"  m={m}: dim so({n}) = {Bso.shape[0]}, orbit rank {rank}, "
            f"isotropy dim {Bso.shape[0]-rank} (m^2 = {m*m})")
        c = np.eye(n)
        for k in range(m):
            c[2 * k + 1, 2 * k + 1] = -1.0
        rc = rho_grp(n, c, prs)
        log(f"       conjugation c: det = {np.linalg.det(c):+.0f}, "
            f"|c.W - W| = {np.max(np.abs(rc @ W @ rc.T - W)):.1e}, "
            f"c.J + J = {np.max(np.abs(c @ Jmat(m) @ c.T + Jmat(m))):.1e}")
        th = ip(W, Qop(A, W))
        log(f"       theta(+W) = {th:+.9f}, theta(-W) = {ip(-W, Qop(A, -W)):+.9f}"
            f"  (Q is quadratic: Q(-W) = Q(W))")


if __name__ == '__main__':
    args = sys.argv[1:] or ['A1', 'A2', 'A3', 'A4', 'A5A6']
    if 'A1' in args: A1()
    if 'A2' in args: A2()
    if 'A3' in args: A3()
    if 'A4' in args: A4()
    if 'A5A6' in args: A5A6()
