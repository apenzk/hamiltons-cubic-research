"""Reviewer 40 -- C6 continued: the Schur step checked directly (commutant dimensions),
the closed forms in m, and the push to m=6 (n=12).

The three things a proof of CP^m nondegeneracy needs, and how each is tested here:
  (i)  L_e is an endomorphism of Weyl_n  -> out-of-Weyl residual of e o X, measured;
  (ii) the U(m)-decomposition is multiplicity-free -> commutant dimension of the
       u(m)-action on Weyl_n equals sum of dim D_i over the real summands, and the
       SYMMETRIC part of the commutant has dimension = number of real summands;
  (iii) each summand's eigenvalue in closed form in m.
"""
import sys, time
import numpy as np
from fractions import Fraction

from review_r40_core import (pairs_of, so_basis, struct_const, Qop, ip, weyl_basis,
                             weyl_dim_formula, coords, project, rho_alg, rho_grp, L_matrix)
from review_r40_cpm import Jmat, u_m_basis

LOG = '../agent_logs/review_r40_cpm.log'


def log(msg):
    print(msg, flush=True)
    with open(LOG, 'a') as f:
        f.write(msg + '\n')


def ad_on_weyl(n, E, Bs, prs):
    r = rho_alg(n, E, prs)
    D, N, _ = Bs.shape
    img = np.matmul(r[None, :, :], Bs) - np.matmul(Bs, r[None, :, :])
    return Bs.reshape(D, -1) @ img.reshape(D, -1).T


def commutant_dims(ads, D):
    """dim of {A : [A,ad]=0 for all ad} and of its symmetric part, on R^D."""
    # vectorised: sum_E  M_E^T M_E  where M_E(A) = ad_E A - A ad_E
    # build on the full D^2 space only when D is small; otherwise on Sym and Skew apart.
    n2 = D * D
    if n2 > 4_000_000:
        return None, None
    rows = []
    I = np.eye(D)
    for ad in ads:
        rows.append(np.kron(ad, I) - np.kron(I, ad.T))
    S = np.vstack(rows)
    sv = np.linalg.svd(S, compute_uv=False)
    tol = max(S.shape) * sv[0] * 1e-11
    full = n2 - int(np.sum(sv > tol))
    return full, None


def commutant_by_projection(ads, D, tries=6, seed=0):
    """dim of the commutant and of its symmetric part, by averaging random operators
    over the group generated (via the heat-kernel of the Casimir of the u(m)-action)."""
    C = sum(ad @ ad for ad in ads)          # -Casimir, negative semidefinite
    w, V = np.linalg.eigh(C)
    # A commutes with every ad iff  sum_E [ad,[ad,A]] = 0, i.e. A in ker of the
    # Casimir acting on End(R^D);  that operator is  L = C (x) I + I (x) C - 2 sum ad(x)ad
    # Diagonalise in the V basis:  the Casimir on End acts as
    #   (LA)_{ab} = (w_a + w_b) A_ab - 2 sum_E (V^T ad V A V^T ad V)_{ab}
    Ads = [V.T @ ad @ V for ad in ads]
    # power iteration on the projector: average A -> A - t*L(A) is slow; use the kernel
    # of L via its action on random matrices instead.
    return None


def kernel_dim_of_commutator(ads, D, sym_only=None, iters=200):
    """dim ker of A -> (ad_E A - A ad_E)_E, computed as the 0-eigenspace of the PSD
    operator  T(A) = sum_E [ad_E,[ad_E,A]]  (acting on D x D matrices), by Lanczos-free
    dense eigendecomposition on a basis of Sym or Skew when D^2 is too big."""
    raise NotImplementedError


def isotypic_report(m, Le, Bs, prs, idx, gens):
    """dimension of the commutant and of its symmetric part, computed on the
    eigenspaces of L_e (which are u(m)-invariant), which keeps the matrices small."""
    n = 2 * m
    D = Bs.shape[0]
    ads = [ad_on_weyl(n, E, Bs, prs) for E in gens]
    eq = max(np.max(np.abs(ad @ Le - Le @ ad)) for ad in ads)
    log(f"  [L_e, u({m})] = {eq:.2e}")
    w, V = np.linalg.eigh(Le)
    rw = np.round(w, 7)
    uu = np.unique(rw)
    tot_c, tot_s = 0, 0
    for lam in uu:
        sel = np.where(rw == lam)[0]
        U = V[:, sel]
        d = len(sel)
        adr = [U.T @ ad @ U for ad in ads]
        # commutant on this eigenspace
        I = np.eye(d)
        S = np.vstack([np.kron(a, I) - np.kron(I, a.T) for a in adr])
        sv = np.linalg.svd(S, compute_uv=False)
        tol = max(S.shape) * sv[0] * 1e-10
        cdim = d * d - int(np.sum(sv > tol))
        # symmetric part: restrict to Sym(d)
        idxs = [(i, j) for i in range(d) for j in range(i, d)]
        P = np.zeros((d * d, len(idxs)))
        for c, (i, j) in enumerate(idxs):
            P[i * d + j, c] = 1.0
            if i != j:
                P[j * d + i, c] = 1.0
        Ss = S @ P
        svs = np.linalg.svd(Ss, compute_uv=False)
        tols = max(Ss.shape) * svs[0] * 1e-10
        sdim = len(idxs) - int(np.sum(svs > tols))
        tot_c += cdim
        tot_s += sdim
        log(f"    lambda={lam:+.6f} dim {d:5d}: commutant {cdim}, symmetric part {sdim}")
    log(f"  totals over eigenspaces: commutant {tot_c}, symmetric commutant {tot_s}")
    return tot_c, tot_s


def gl_dim(lam):
    """Weyl dimension formula for the GL(m) irrep with h.w. lam."""
    m = len(lam)
    l = [lam[i] + (m - 1 - i) for i in range(m)]
    num = 1
    den = 1
    for i in range(m):
        for j in range(i + 1, m):
            num *= (l[i] - l[j])
            den *= (j - i)
    return num // den


def closed_forms(mmax=12):
    log("=== closed-form dimensions of the seven U(m)-summands ===")
    log("  hw                      formula                      m=3..%d" % mmax)
    def hws(m):
        z = [0] * m
        return {
            'trivial <W>':        tuple(z),
            'adjoint su(m)':      tuple([1] + [0] * (m - 2) + [-1]),
            'Lam2 + dual':        tuple([1, 1] + [0] * (m - 2)),
            'Lam2 x Lam2* (0)':   tuple([1, 1] + [0] * (m - 4) + [-1, -1]) if m >= 4 else None,
            'S22 + dual':         tuple([2, 2] + [0] * (m - 2)),
            '(2,1,0..,-1)+dual':  tuple([2, 1] + [0] * (m - 3) + [-1]),
            '(2,0..,-2)':         tuple([2] + [0] * (m - 2) + [-2]),
        }
    forms = {
        'trivial <W>': lambda m: 1,
        'adjoint su(m)': lambda m: m * m - 1,
        'Lam2 + dual': lambda m: m * (m - 1),
        'Lam2 x Lam2* (0)': lambda m: m * m * (m + 1) * (m - 3) // 4,
        'S22 + dual': lambda m: m * m * (m * m - 1) // 6,
        '(2,1,0..,-1)+dual': lambda m: (m * m - 1) * (m * m - 4) // 3,
        '(2,0..,-2)': lambda m: m * m * (m + 3) * (m - 1) // 4,
    }
    doubled = {'Lam2 + dual', 'S22 + dual', '(2,1,0..,-1)+dual'}
    for m in range(3, mmax + 1):
        h = hws(m)
        tot = 0
        parts = []
        for k, f in forms.items():
            hw = h[k]
            d = 0 if hw is None else gl_dim(hw) * (2 if k in doubled else 1)
            pred = f(m)
            ok = 'ok' if d == pred else f'MISMATCH({d} vs {pred})'
            parts.append(f"{k}={d}{'' if ok=='ok' else ' '+ok}")
            tot += d
        log(f"  m={m}: total {tot} vs dim Weyl_{2*m} = {weyl_dim_formula(2*m)}"
            f"  {'OK' if tot == weyl_dim_formula(2*m) else 'MISMATCH'}")
        if m <= 6:
            log(f"        {'; '.join(parts)}")


def eigen_closed_forms(mmax=12):
    log("=== closed-form eigenvalues ===")
    log("  <W>: 1 | su(m): (m+2)/(2(m+1)) | Lam2+dual: 1/2 | Lam2xLam2*: 2/(m+1) "
        "| S22+dual: -3/(m+1) | (2,1,..,-1)+dual: 0 | (2,0..,-2): 0")
    for m in range(3, mmax + 1):
        vals = {'1': Fraction(1), 'su': Fraction(m + 2, 2 * (m + 1)),
                'orbit': Fraction(1, 2), 'L2L2*': Fraction(2, m + 1),
                'S22': Fraction(-3, m + 1)}
        hits = [k for k, v in vals.items() if v == Fraction(1, 2) and k != 'orbit']
        exists = m >= 4
        log(f"  m={m}: su={vals['su']}  L2L2*={vals['L2L2*']}"
            f"{' (summand absent)' if not exists else ''}  S22={vals['S22']}"
            f"   others equal to 1/2: {hits if (hits != ['L2L2*'] or exists) else []}")


def run_m(m):
    n = 2 * m
    t0 = time.time()
    log(f"=== m={m} (n={n}) full pipeline ===")
    A = struct_const(n)
    log(f"  struct_const done {time.time()-t0:.1f}s")
    Bs, prs, idx = weyl_basis(n)
    D = Bs.shape[0]
    log(f"  dim Weyl_{n} = {D} (formula {weyl_dim_formula(n)})  [{time.time()-t0:.1f}s]")
    gens, _, _, J = u_m_basis(m)
    log(f"  dim u({m}) = {gens.shape[0]}")
    rng = np.random.default_rng(4000 + m)
    r2 = [np.einsum('k,kij->ij', rng.standard_normal(gens.shape[0]), gens) for _ in range(2)]
    S = np.vstack([ad_on_weyl(n, E, Bs, prs) for E in r2])
    U_, sv, Vt = np.linalg.svd(S)
    tol = max(S.shape) * sv[0] * 1e-11
    rank = int(np.sum(sv > tol))
    ns = Vt[rank:]
    log(f"  invariants of 2 random u({m}) elements: dim {ns.shape[0]}  "
        f"(gap {sv[rank-1]:.2e} -> {sv[rank] if rank < len(sv) else 0:.2e})  "
        f"[{time.time()-t0:.1f}s]")
    if ns.shape[0] != 1:
        log("  NOT one-dimensional")
        return
    W = np.einsum('d,dij->ij', ns[0], Bs)
    W = W / np.sqrt(ip(W, W))
    # confirm invariance under ALL u(m) generators
    worst = 0.0
    for E in gens:
        r = rho_alg(n, E, prs)
        worst = max(worst, np.max(np.abs(r @ W - W @ r)))
    log(f"  full u({m})-invariance of the generator: {worst:.2e}")
    theta = ip(W, Qop(A, W))
    if theta < 0:
        W = -W
        theta = ip(W, Qop(A, W))
        log("  generator was on the negative branch -- flipped")
    res = np.max(np.abs(Qop(A, W) - theta * W))
    cf = np.sqrt((m + 1) * (2 * m - 1) / (3.0 * m * (m - 1)))
    log(f"  theta = {theta:.12f}  closed form {cf:.12f}  diff {abs(theta-cf):.2e}  "
        f"crit resid {res:.2e}")
    # conjugation element c: e_{2k} -> -e_{2k};  in SO(2m) iff m even
    c = np.eye(n)
    for k in range(m):
        c[2 * k + 1, 2 * k + 1] = -1.0
    rc = rho_grp(n, c, prs)
    log(f"  conjugation c (det {np.linalg.det(c):+.0f}) fixes W: "
        f"{np.max(np.abs(rc @ W @ rc.T - W)):.2e}")
    e = W / theta
    Le, out_res = L_matrix(A, Bs, e, chunk=30)
    log(f"  L_e built [{time.time()-t0:.1f}s], out-of-Weyl {out_res:.2e}, "
        f"sym {np.max(np.abs(Le-Le.T)):.2e}, tr {np.trace(Le):.2e}")
    w = np.linalg.eigvalsh(Le)
    uu, cc = np.unique(np.round(w, 7), return_counts=True)
    log(f"  L_e spectrum: {[(float(a), int(b)) for a, b in zip(uu, cc)]}")
    # orbit
    Bso, _, _ = so_basis(n)
    Tt = np.array([coords(Bs, rho_alg(n, Bso[a], prs) @ W - W @ rho_alg(n, Bso[a], prs))
                   for a in range(Bso.shape[0])])
    svt = np.linalg.svd(Tt, compute_uv=False)
    orb = int(np.sum(svt > max(Tt.shape) * svt[0] * 1e-11))
    half = int(np.sum(np.abs(w - 0.5) < 1e-7))
    lam2 = w[np.abs(w - 1.0) > 1e-7].max()
    log(f"  orbit dim {orb} (m(m-1)={m*(m-1)}), dim E(1/2) = {half}, "
        f"lambda_max|W^perp = {lam2:.12f} (pred {(m+2)/(2*(m+1)):.12f}), "
        f"mult {int(np.sum(np.abs(w-lam2)<1e-7))} (m^2-1={m*m-1})")
    np.save(f'scripts/data/review_r40_W_cpm{m}.npy', W)
    np.save(f'review_r40_Le_cpm{m}.npy', Le)
    np.save(f'review_r40_Bs_n{n}.npy', Bs)
    log(f"  [m={m} done in {time.time()-t0:.1f}s]")


if __name__ == '__main__':
    args = sys.argv[1:]
    if 'forms' in args:
        closed_forms(12)
        eigen_closed_forms(12)
    if 'commutant' in args:
        for m in (3, 4, 5):
            n = 2 * m
            log(f"=== commutant check, m={m} ===")
            Bs = np.load(f'review_r40_Bs_n{n}.npy')
            Le = np.load(f'review_r40_Le_cpm{m}.npy')
            prs, idx = pairs_of(n)
            gens, _, _, _ = u_m_basis(m)
            isotypic_report(m, Le, Bs, prs, idx, gens)
    for a in args:
        if a.isdigit():
            run_m(int(a))
