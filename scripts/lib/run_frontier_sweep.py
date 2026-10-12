"""
The empirical (theta, delta^2) PARETO FRONTIER of the critical set, measured
against the line the defect-penalty candidate (plan.md C7) draws.

    F(t) := max { delta(W)^2 : ||W|| = 1, Q(W) = theta*W, theta >= t },

    delta(W)^2 = ||Alt(W_-)||^2   (the Bianchi defect, FINDINGS Result 4),
    Q(W)       = W^2 + W^#,       theta = P(W) = <W, Q(W)> at a critical point.

C7 asserts  P <= theta_0(n) + kappa_n*delta^2  with kappa_n = 9(sqrt(3/2) - theta_0(n)),
which is NEGATIVE for n >= 12, so on the critical set (P = theta) it reads

    delta^2  <=  L(theta) := (theta_0(n) - theta) / |kappa_n|      (n >= 12).

The question this script answers empirically: does F hug L (rigidity), or does it
sit strictly below L away from the points where C7 is sharp by construction? At
n = 12 the line passes exactly through both champions -- L(theta_0(12)) = 0 at the
balanced (6,6) sphere product and L(sqrt(3/2)) = 1/9 at Fox's S^4(alpha) -- so
those two touches are forced and everything between them is the open question.

THE LINE USED FOR BOTH DIMENSIONS IS L_12. Zero-padding an n=8 critical point into
R^12 preserves theta and delta^2 to ten digits (verified in PART 0 here, and in
FINDINGS Result 7), so every n=8 critical point IS an n=12 critical point with the
same coordinates: the n=8 sweep is a search of a 300-dimensional subvariety of the
n=12 critical set, and its frontier is a lower bound for the n=12 frontier. The
n=8 line L_8 is reported alongside for completeness; kappa_8 = +0.71 is positive,
so at n = 8 the candidate reads as a defect FLOOR (delta^2 >= (theta-theta_0(8))/kappa_8
once theta > theta_0(8)) rather than a ceiling, which is the n <= 11 regime that
FINDINGS Result 3 already refutes in its interpolation form.

STRUCTURE OF THE ANSWER, which the numbers then fill in. P is a polynomial, hence
real-analytic, so P is constant on each connected component of its critical set
(Lojasiewicz), and the critical set is a compact real-algebraic set with finitely
many components. So the critical values theta_1 > theta_2 > ... are a FINITE set
and F is a STEP function of t: it can meet the strictly decreasing line L only at
isolated critical values. "Hugging L" is therefore a statement about how many
critical components sit near the line, and the sweep measures exactly that.

METHOD, with FINDINGS Result 7's three recorded traps heeded

  (i)  THETA IS PINNED BY A SECOND PENALTY. Maximize delta^2 subject to criticality
       via  -delta^2 + mu*||Q - P W||^2 + nu*(P - t)^2  with (mu, nu) ramped
       1 -> 1e5, which is the method that produced the delta^2 = 3/25 violator in
       run_defect_max_hunt PART 3c. An unpinned criticality ramp slides back to Fox.
  (ii) NO EPSILON-ANNEALED SMOOTHING as the primary search: delta^2 is non-smooth at
       every zero eigenvalue of W and annealing eps 0.3 -> 0 funnels every seed to
       Fox (32/32 in the record). Seeds are prepared with defect_polish_loop, which
       is raw subgradient ascent interrupted by SHORT small-eps passes (eps <= 0.01),
       and the pinned stage itself runs at eps = 0 throughout.
  (iii) ACCEPTANCE USES THE ABSOLUTE RESIDUAL ||Q - theta W|| < 1e-7. The relative
       residual is 0/0 on the theta = 0 stratum; this grid starts at t = 0.4, but the
       absolute test is used anyway so no accepted point owes anything to a denominator.

  Five complementary probes feed one pooled catalogue of accepted critical points,
  and the frontier is read off the pool (any point with theta >= t counts toward F(t),
  whichever probe found it):

    PROBE A  theta-pinned defect maximization, one bin per grid point, seeded from
             perturbed Fox, perturbed balanced and unbalanced sphere products, the
             known delta^2 = 3/25 violator padded up, su(m) family members, Fox-block
             plus sphere-product mixtures on complementary blocks, Fox <-> sphere
             great-circle interpolations, and random starts. Two pin forms run in each
             bin: the equality pin (P - t)^2, which is Result 7's recipe, and the hinge
             max(0, t - P)^2, which is F(t)'s own constraint theta >= t and lets a seed
             climb in theta while holding its defect.
    PROBE B  the dual sweep: maximize theta subject to criticality and a defect FLOOR
             delta^2 >= d (hinge penalty). This asks the same frontier sideways --
             G(d) = max{theta : critical, delta^2 >= d} -- and C7 predicts
             G(d) <= theta_0 - |kappa|*d.
    PROBE C  Pareto scalarization over the critical set: maximize theta + lam*delta^2
             for several lam. At lam = |kappa_12| the maximum IS the C7 statement
             restricted to critical points, so its value is the sharpest single number
             the sweep produces. (FINDINGS Result 4 ascended the same objective over
             ALL of W_n; constraining to the critical set reaches saddles that plain
             ascent cannot.)
    PROBE E  unbiased census: residual minimization from random starts, with no defect
             term at all, as the coverage control on PROBEs A-D.
    PROBE D  refinement: the accepted points with the smallest C7 margin are perturbed
             at several scales and re-run pinned at their own theta and just below it,
             which is where a violation would hide.

  Every accepted point is identified against the catalogue (Fox orbit, sphere splits,
  su(m) Kaehler family, Fox plateau, SU(3), QK, the known violator) by (theta, delta^2)
  and spectrum; anything unmatched is reported as NEW with its spectrum and the
  dimension of its so(n) stabilizer (n(n-1)/2 minus the rank of A -> [ad(A), W]).
  Points with delta^2 >= 0.9*L(theta), and points on the line, are near-active for C7:
  each is saved to .npy and gets a local analysis -- the Riemannian Hessian of P on the
  unit Weyl sphere there (hessian_fast's construction, generalized off the
  coordinate-diagonal and validated against it in PART 0b). A Hessian kernel of exactly
  the orbit dimension says the point is isolated modulo O(n), so the frontier's step at
  that theta is not the end of a critical curve that could track the line.
  A point with delta^2 > L(theta) + 1e-8 at residual < 1e-7 REFUTES C7; it is
  re-checked with a second, structurally different Q (Q_full / Q_op) and saved.

Reused machinery, all validated in its home script: setup/fox_weyl/sphere_weyl/qk_weyl/
kappa (run_defect_penalty_test), theta0/delta2_and_grad/project_to_x/pad_weyl_to_n/
build_su3_n8 (run_bianchi_defect_highp_seed), build_alt_indices/bianchi_defect
(run_bianchi_defect), Q_fast (run_unconstrained_search_n12), Q_full (rsharp_basis_free),
Q_op (curvature_operator), defect_polish_loop/polish_to_critical/resid_and_grad/
su_m_kahler_weyl/fox_on_block (run_defect_max_hunt).

Usage
-----
    python3 run_frontier_sweep.py            # n=8 thorough, then n=12 moderate
    python3 run_frontier_sweep.py 8          # one dimension
    python3 run_frontier_sweep.py 12 quick   # reduced budget

Runtimes measured on one core: n=8 thorough 350s (34 bins, 120 census starts),
n=12 moderate 3400s (27 bins, 40 census starts; PROBE A is 1350s of it and the
census another 1800s), n=12 quick 440s.
"""
import os
import sys
import time
import numpy as np
from scipy.optimize import minimize

from curvature_operator import Lambda2, Q_op
from weyl import build_structure_constants
from weyl_decomposition import norm, frob
from rsharp_basis_free import Q_full
import hessian_fast
from run_defect_penalty_test import setup, fox_weyl, sphere_weyl, qk_weyl, kappa
from run_bianchi_defect_highp_seed import (theta0, delta2_and_grad, project_to_x,
                                           pad_weyl_to_n, build_su3_n8)
from run_defect_max_hunt import (defect_polish_loop, polish_to_critical, resid_and_grad,
                                 su_m_kahler_weyl, su_m_theta, su_m_delta2, fox_on_block,
                                 D0_EXACT)

SQRT32 = np.sqrt(1.5)
N_LINE = 12                      # the dimension whose C7 line is the reference
KAPPA_LINE = abs(kappa(N_LINE))  # 0.101594...
RESID_TOL = 1e-7                 # absolute ||Q - theta W||
NEAR_ACTIVE = 0.9                # delta^2 >= 0.9*L(theta) counts as near-active
VIOL_TOL = 1e-8

# The reported grid: coarse below 1.0, fine on [1.0, 1.20], very fine across the
# window where the line binds -- L(t) < 1/4 only for t > 1.2106 (delta^2 <= 1/4 is
# proven unconditionally), and L(t) < 0.147 (the unconstrained defect maximum at
# n=12) only for t > 1.2211, so the last four hundredths carry the whole question.
GRID = ([round(0.40 + 0.05 * k, 4) for k in range(12)] +
        [round(1.00 + 0.025 * k, 4) for k in range(8)] +
        [1.205, 1.210, 1.215, 1.2200, 1.2225, 1.2240,
         float(SQRT32), 1.2260, 1.2280, 1.2300, 1.2320,
         float(theta0(12)), 1.2380, 1.2400])


def Lline(theta, n_line=N_LINE):
    """C7's ceiling on delta^2 at a critical point of value theta."""
    return (theta0(n_line) - theta) / abs(kappa(n_line))


def c7_margin(theta, d2, n_line=N_LINE):
    """theta_0 - (theta + |kappa|*delta^2); negative = C7 refuted at that point."""
    return theta0(n_line) - (theta + abs(kappa(n_line)) * d2)


# ---------------------------------------------------------------------
# objectives (all at eps = 0: no smoothing of delta^2 anywhere here)
# ---------------------------------------------------------------------
def _pieces(xx, Eflat, N, Qfun):
    nx = np.linalg.norm(xx)
    u = xx / nx
    W = (u @ Eflat).reshape(N, N)
    W = 0.5 * (W + W.T)
    Q = Qfun(W)
    return nx, u, W, Q, frob(W, Q)


def obj_theta_pinned(mu, nu, tt, Eflat, N, Qfun, alt_idx):
    """PROBE A: -delta^2 + mu*||Q - P W||^2 + nu*(P - tt)^2."""
    def fg(xx):
        nx, u, W, Q, P = _pieces(xx, Eflat, N, Qfun)
        d2, Gd = delta2_and_grad(W, alt_idx)
        R, GR = resid_and_grad(W, Q, P, Qfun)
        G = -Gd + mu * GR + nu * 2.0 * (P - tt) * 3.0 * Q
        g = Eflat @ G.reshape(-1)
        return -d2 + mu * R + nu * (P - tt) ** 2, (g - np.dot(g, u) * u) / nx
    return fg


def obj_theta_floor(mu, nu, tt, Eflat, N, Qfun, alt_idx):
    """PROBE A, hinge form: -delta^2 + mu*||Q - P W||^2 + nu*max(0, tt - P)^2, which
    is F(t)'s own constraint theta >= t rather than the equality pin. The equality
    pin is the recipe that found the 3/25 violator and is kept as the primary form;
    the hinge is run alongside it because it lets a seed climb in theta while it
    keeps its defect, which is the direction a frontier point above the line lies in."""
    def fg(xx):
        nx, u, W, Q, P = _pieces(xx, Eflat, N, Qfun)
        d2, Gd = delta2_and_grad(W, alt_idx)
        R, GR = resid_and_grad(W, Q, P, Qfun)
        short = max(0.0, tt - P)
        G = -Gd + mu * GR - nu * 2.0 * short * 3.0 * Q
        g = Eflat @ G.reshape(-1)
        return -d2 + mu * R + nu * short ** 2, (g - np.dot(g, u) * u) / nx
    return fg


def obj_defect_floor(mu, nu, dd, Eflat, N, Qfun, alt_idx):
    """PROBE B: -P + mu*||Q - P W||^2 + nu*max(0, dd - delta^2)^2."""
    def fg(xx):
        nx, u, W, Q, P = _pieces(xx, Eflat, N, Qfun)
        d2, Gd = delta2_and_grad(W, alt_idx)
        R, GR = resid_and_grad(W, Q, P, Qfun)
        short = max(0.0, dd - d2)
        G = -3.0 * Q + mu * GR - nu * 2.0 * short * Gd
        g = Eflat @ G.reshape(-1)
        return -P + mu * R + nu * short ** 2, (g - np.dot(g, u) * u) / nx
    return fg


def obj_pareto(mu, lam, Eflat, N, Qfun, alt_idx):
    """PROBE C: -(P + lam*delta^2) + mu*||Q - P W||^2."""
    def fg(xx):
        nx, u, W, Q, P = _pieces(xx, Eflat, N, Qfun)
        d2, Gd = delta2_and_grad(W, alt_idx)
        R, GR = resid_and_grad(W, Q, P, Qfun)
        G = -3.0 * Q - lam * Gd + mu * GR
        g = Eflat @ G.reshape(-1)
        return -P - lam * d2 + mu * R, (g - np.dot(g, u) * u) / nx
    return fg


def ramp(x0, obj_at_mu, mus, maxiter):
    x = x0 / np.linalg.norm(x0)
    for mu in mus:
        x = minimize(obj_at_mu(mu), x, jac=True, method="L-BFGS-B",
                     options=dict(maxiter=maxiter, ftol=1e-20, gtol=1e-16)).x
        x /= np.linalg.norm(x)
    return x


# ---------------------------------------------------------------------
# accepted-point records
# ---------------------------------------------------------------------
def record(W, ctx, label):
    """theta > 0 orientation, absolute residual, defect, spectrum signature."""
    Qfun, alt_idx = ctx["Qfun"], ctx["alt_idx"]
    Q = Qfun(W)
    th = frob(W, Q)
    if th < 0:
        W, Q, th = -W, Qfun(-W), -th
    absres = norm(Q - th * W)
    d2 = delta2_and_grad(W, alt_idx)[0]
    w = np.linalg.eigvalsh(W)
    return dict(theta=float(th), d2=float(d2), absres=float(absres), W=W,
                label=label, rplus=int(np.sum(w > 1e-8)), rminus=int(np.sum(w < -1e-8)),
                eigs=w)


def stabilizer_dim(W, c):
    """dim of {A in so(n) : [ad(A), W] = 0}, from the rank of A -> [ad(A), W].
    ad(e_a) on Lambda^2 = so(n) is exactly the structure-constant matrix
    A_a[m,p] = c[a,m,p], so the orbit tangent space is the row space below."""
    M = np.einsum('amp,pq->amq', c, W) - np.einsum('mp,apq->amq', W, c)
    N = W.shape[0]
    s = np.linalg.svd(M.reshape(N, -1), compute_uv=False)
    rank = int(np.sum(s > 1e-8 * max(1.0, s[0])))
    return N - rank, rank


def qform_sym(W, c):
    """The N^2 x N^2 symmetric matrix with vec(H) Qf vec(H) = <W, Q(H)>, i.e.
    hessian_fast.build_qform_sym generalized off the coordinate-diagonal:
        <W, H@H>  = sum_{i,j,k} W[i,j] H[i,k] H[k,j],
        <W, H^#>  = -1/2 sum_{a,b,m,n,p,q} W[a,b] c[a,m,n] H[n,p] c[b,p,q] H[q,m].
    Validated in PART 0 against hessian_fast.run at the balanced sphere product."""
    N = W.shape[0]
    D1 = np.einsum('ij,kl->iklj', W, np.eye(N), optimize=True).reshape(N * N, N * N)
    Wc = np.einsum('ab,bpq->apq', W, c, optimize=True)
    K = -0.5 * np.einsum('amn,apq->npqm', c, Wc, optimize=True).reshape(N * N, N * N)
    Qf = D1 + K
    return 0.5 * (Qf + Qf.T)


def hessian_profile(W, ctx, c):
    """Riemannian Hessian of P on the unit Weyl sphere at a critical point:
    Hess = 6*M - 3*theta*I with M_ab = <W, Q-polarization(E_a, E_b)> on an
    orthonormal tangent basis. Its kernel always contains the O(n)-orbit tangent
    space; kernel dimension EQUAL to the orbit dimension says no branch of critical
    points leaves the point transversally to its orbit, so the frontier's step at
    that theta cannot be smoothed out by a nearby critical curve."""
    N, Eflat = ctx["N"], ctx["Eflat"]
    Qf = qform_sym(W, c)
    wvec = W.reshape(-1)
    theta = float(wvec @ Qf @ wvec)
    T = Eflat - np.outer(Eflat @ wvec, wvec)
    G = T @ T.T
    wt, Vt = np.linalg.eigh(G)
    order = np.argsort(-wt)
    wt, Vt = wt[order], Vt[:, order]
    Dt = int(np.sum(wt > 1e-8 * wt[0]))
    Etan = (Vt[:, :Dt] @ np.diag(1.0 / np.sqrt(wt[:Dt]))).T @ T
    M = Etan @ Qf @ Etan.T
    Hess = 6 * 0.5 * (M + M.T) - 3 * theta * np.eye(Dt)
    return np.linalg.eigvalsh(Hess), theta, Dt


def catalogue_table(n):
    """(label, theta, delta^2) for every named critical point that lives at
    dimension n, including zero-padded copies of lower-dimensional ones."""
    rows = [("Fox S^4(alpha) = su(2) Kahler", SQRT32, D0_EXACT),
            ("SU(3) bi-invariant", 0.836660026534, 0.0),
            ("QK HP^2", 1.115546702, 0.031746032),
            ("known violator (3/25 point)", np.sqrt(3.0 / 20.0), 0.12),
            ("theta=0 stratum point", 0.0, 0.125)]
    for m in range(2, n // 2 + 1):
        rows.append((f"su({m}) Kahler family", su_m_theta(m), su_m_delta2(m)))
    for k in range(1, n // 4 + 1):
        rows.append((f"Fox plateau, {k} blocks", SQRT32 / np.sqrt(k), D0_EXACT))
    if n >= 12:
        rows.append(("QK HP^3", 0.852943860, 0.028058361))
    return rows


def identify(rec, ctx, cat, tol=1e-6):
    for lab, th, d2 in cat:
        if abs(rec["theta"] - th) < tol and abs(rec["d2"] - d2) < tol:
            return lab
    for lab, th in ctx["sphere_thetas"]:
        if abs(rec["theta"] - th) < tol and rec["d2"] < tol:
            return lab
    if rec["d2"] < 1e-9:
        return "NEW (zero defect)"
    return "NEW"


# ---------------------------------------------------------------------
# seeds
# ---------------------------------------------------------------------
def build_anchors(n, ctx):
    """Named critical points at dimension n, as (label, W). These enter the pool
    directly (they are exact) and also serve as seeds."""
    out = []
    L2 = ctx["L2"]
    out.append(("Fox S^4(alpha)", fox_weyl(ctx)))
    for p in range(2, n // 2 + 1):
        out.append((f"sphere ({p},{n-p})", sphere_weyl(ctx, p)))
    L2_8, Wsu3 = build_su3_n8()
    out.append(("SU(3) bi-invariant", Wsu3 if n == 8 else pad_weyl_to_n(L2_8, Wsu3, n)[1]))
    for m in range(2, n // 2 + 1):
        L2m = Lambda2(2 * m)
        Wm = su_m_kahler_weyl(L2m, m)
        Wm = Wm / norm(Wm)
        out.append((f"su({m}) Kahler", Wm if 2 * m == n else pad_weyl_to_n(L2m, Wm, n)[1]))
    for k in range(1, n // 4 + 1):
        blocks = [list(range(4 * i, 4 * i + 4)) for i in range(k)]
        Wk = sum(fox_on_block(L2, b, ctx["Qfun"]) for b in blocks)
        out.append((f"Fox plateau k={k}", Wk / norm(Wk)))
    out.append(("QK HP^2", qk_weyl(ctx, 2) if n == 8 else
                pad_weyl_to_n(Lambda2(8), qk_weyl(setup(8, verbose=False), 2), n)[1]))
    if n >= 12:
        out.append(("QK HP^3", qk_weyl(ctx, 3)))
    here = os.path.dirname(os.path.abspath(__file__))
    for fn, lab in ((f"scripts/data/defect_violation_n8_0.120000.npy", "known violator 3/25"),
                    (f"scripts/data/defect_theta0_n8_0.125000.npy", "theta=0 stratum point")):
        path = os.path.join(here, fn)
        if os.path.exists(path):
            W8 = np.load(path)
            out.append((lab, W8 if n == 8 else pad_weyl_to_n(Lambda2(8), W8, n)[1]))
    return out


def build_seed_pool(n, ctx, rng):
    """(label, x) seeds in Weyl coordinates. Anchors, perturbed anchors, mixtures of
    a Fox block with a sphere product on the complementary block, great-circle
    interpolations, and random starts."""
    Eflat, N = ctx["Eflat"], ctx["N"]
    seeds = []
    anchors = ctx["anchors"]
    xs = {}
    for lab, W in anchors:
        x, err = project_to_x(W, Eflat, N)
        assert err < 1e-8, f"{lab}: not in the Weyl basis (recon err {err:.1e})"
        xs[lab] = x
        seeds.append((f"{lab}", x.copy()))
    for lab in ("Fox S^4(alpha)", f"sphere ({n//2},{n//2})", f"sphere ({n//2-1},{n-n//2+1})",
                "known violator 3/25", "su(3) Kahler"):
        if lab not in xs:
            continue
        for s in (0.05, 0.2, 0.5):
            d = rng.normal(size=ctx["D"])
            seeds.append((f"{lab} +{s}", xs[lab] + s * d / np.linalg.norm(d)))
    # Fox block on R^4 mixed with a sphere product on the complementary R^{n-4}:
    # the natural way to carry Fox-sized defect at sphere-product-sized theta.
    Wfox4 = fox_on_block(ctx["L2"], list(range(4)), ctx["Qfun"])
    for p in (n // 2,):
        Wsp = sphere_weyl(ctx, p)
        for s in (0.25, 0.5, 0.75):
            Wm = s * Wfox4 + np.sqrt(1.0 - s * s) * Wsp
            seeds.append((f"Fox4+sphere({p}) s={s}", project_to_x(Wm / norm(Wm), Eflat, N)[0]))
    # great circles between Fox and the two highest-theta sphere splits
    xf = xs["Fox S^4(alpha)"]
    for p in (n // 2, n // 2 - 1):
        xb = xs[f"sphere ({p},{n-p})"]
        ang = np.arccos(np.clip(np.dot(xf, xb), -1, 1))
        for s in (0.2, 0.4, 0.6, 0.8):
            xg = (np.sin((1 - s) * ang) * xf + np.sin(s * ang) * xb) / np.sin(ang)
            seeds.append((f"circle Fox->({p},{n-p}) s={s}", xg))
    return seeds


# ---------------------------------------------------------------------
# the sweep
# ---------------------------------------------------------------------
def accept(pool, rec, ctx, cat, verbose_prefix=None):
    if rec["absres"] >= RESID_TOL or rec["theta"] <= 1e-6:
        return False
    rec["id"] = identify(rec, ctx, cat)
    rec["margin"] = c7_margin(rec["theta"], rec["d2"])
    pool.append(rec)
    if verbose_prefix:
        print(f"{verbose_prefix} theta={rec['theta']:.9f} d2={rec['d2']:.9f} "
              f"absres={rec['absres']:.1e} L={Lline(rec['theta']):+.6f} "
              f"C7margin={rec['margin']:+.3e}  [{rec['id']}]")
    return True


PRIORITY_PREFIXES = ("Fox", "known violator", "circle", "Fox4+sphere", "sphere")


def probe_A(n, ctx, pool, cat, rng, budget):
    print(f"\n  -- PROBE A: theta-pinned defect maximization, {len(budget['targets'])} bins (n={n}) --")
    Eflat, N, Qfun, alt_idx, D = ctx["Eflat"], ctx["N"], ctx["Qfun"], ctx["alt_idx"], ctx["D"]
    seeds_all = ctx["seeds"]
    prio = [s for s in seeds_all if s[0].startswith(PRIORITY_PREFIXES)]
    rest = [s for s in seeds_all if not s[0].startswith(PRIORITY_PREFIXES)]
    mus, maxiter = budget["mus"], budget["maxiter"]
    t_start = time.time()
    for tt in budget["targets"]:
        # the binding window (L < 1/4 only above 1.2106) gets the priority seeds in full
        if tt >= 1.20:
            k = min(budget["seeds_window"], len(prio))
            picks = [prio[i] for i in rng.choice(len(prio), size=k, replace=False)]
        else:
            k = min(budget["seeds_hi"] if tt >= 1.0 else budget["seeds_lo"], len(seeds_all))
            picks = [seeds_all[i] for i in rng.choice(len(seeds_all), size=k, replace=False)]
        picks += [(f"random {j}", rng.normal(size=D)) for j in range(budget["n_random"])]
        # the hinge form (theta >= t, F's own constraint) runs on the last few seeds
        n_hinge = budget["seeds_hinge"] if tt >= 1.0 else 0
        best = None
        for j, (lab, x0) in enumerate(picks):
            x = defect_polish_loop(x0, Eflat, N, alt_idx, Qfun,
                                   rounds=1, iters=budget["polish_iters"]) \
                if lab.startswith("random") else x0 / np.linalg.norm(x0)
            hinge = j >= len(picks) - n_hinge
            obj = (obj_theta_floor if hinge else obj_theta_pinned)
            x = ramp(x, lambda mu: obj(mu, mu, tt, Eflat, N, Qfun, alt_idx), mus, maxiter)
            _, W, th, rel, d2 = polish_to_critical(x, Eflat, N, alt_idx, Qfun)
            rec = record(W, ctx, f"A{'hinge' if hinge else ''} t={tt:.4f} <- {lab}")
            if accept(pool, rec, ctx, cat) and (best is None or rec["d2"] > best["d2"]):
                best = rec
        if best is None:
            print(f"    t={tt:.6f}: no seed converged to residual < {RESID_TOL:.0e}")
        else:
            print(f"    t={tt:.6f}: best theta={best['theta']:.9f} d2={best['d2']:.9f} "
                  f"absres={best['absres']:.1e}  [{best['id']}]")
    print(f"    PROBE A done [{time.time()-t_start:.0f}s], pool size {len(pool)}")


def probe_B(n, ctx, pool, cat, rng, budget):
    floors = budget["floors"]
    print(f"\n  -- PROBE B: dual sweep, max theta subject to delta^2 >= d (n={n}) --")
    Eflat, N, Qfun, alt_idx, D = ctx["Eflat"], ctx["N"], ctx["Qfun"], ctx["alt_idx"], ctx["D"]
    mus, maxiter = budget["mus"], budget["maxiter"]
    t_start = time.time()
    for dd in floors:
        best = None
        picks = [ctx["seeds"][i] for i in rng.choice(len(ctx["seeds"]),
                                                     size=budget["seeds_dual"], replace=False)]
        picks += [(f"random {j}", rng.normal(size=D)) for j in range(1)]
        for lab, x0 in picks:
            x = ramp(x0, lambda mu: obj_defect_floor(mu, 10.0 * mu, dd, Eflat, N, Qfun, alt_idx),
                     mus, maxiter)
            _, W, th, rel, d2 = polish_to_critical(x, Eflat, N, alt_idx, Qfun)
            rec = record(W, ctx, f"B d>={dd:.4f} <- {lab}")
            ok = accept(pool, rec, ctx, cat)
            if ok and rec["d2"] >= dd - 1e-9 and (best is None or rec["theta"] > best["theta"]):
                best = rec
        pred = theta0(N_LINE) - KAPPA_LINE * dd
        if best is None:
            print(f"    floor d2>={dd:.6f}: no accepted point kept the floor "
                  f"(C7 allows theta <= {pred:.6f})")
        else:
            print(f"    floor d2>={dd:.6f}: G(d)={best['theta']:.9f} at d2={best['d2']:.9f} "
                  f"(C7 allows {pred:.6f}, slack {pred-best['theta']:+.6f})  [{best['id']}]")
    print(f"    PROBE B done [{time.time()-t_start:.0f}s], pool size {len(pool)}")


def probe_C(n, ctx, pool, cat, rng, budget):
    print(f"\n  -- PROBE C: Pareto scalarization max(theta + lam*delta^2) on the critical set (n={n}) --")
    Eflat, N, Qfun, alt_idx, D = ctx["Eflat"], ctx["N"], ctx["Qfun"], ctx["alt_idx"], ctx["D"]
    mus, maxiter = budget["mus"], budget["maxiter"]
    t_start = time.time()
    for lam in budget["lams"]:
        best = None
        picks = [ctx["seeds"][i] for i in rng.choice(len(ctx["seeds"]),
                                                     size=budget["seeds_dual"], replace=False)]
        picks += [(f"random {j}", rng.normal(size=D)) for j in range(1)]
        for lab, x0 in picks:
            x = ramp(x0, lambda mu: obj_pareto(mu, lam, Eflat, N, Qfun, alt_idx), mus, maxiter)
            _, W, th, rel, d2 = polish_to_critical(x, Eflat, N, alt_idx, Qfun)
            rec = record(W, ctx, f"C lam={lam:.4f} <- {lab}")
            if accept(pool, rec, ctx, cat):
                val = rec["theta"] + lam * rec["d2"]
                if best is None or val > best[0]:
                    best = (val, rec)
        if best is not None:
            val, rec = best
            tag = ""
            if abs(lam - KAPPA_LINE) < 1e-9:
                tag = (f"   <== C7 at n=12 reads max <= theta_0(12)={theta0(12):.9f}; "
                       f"margin {theta0(12)-val:+.3e}")
            print(f"    lam={lam:.6f}: max={val:.9f} at theta={rec['theta']:.9f} "
                  f"d2={rec['d2']:.9f}  [{rec['id']}]{tag}")
    print(f"    PROBE C done [{time.time()-t_start:.0f}s], pool size {len(pool)}")


def probe_D(n, ctx, pool, cat, rng, budget):
    """Refinement around the smallest-margin accepted points: perturb and re-pin at
    the point's own theta and just below it, where a violation would hide."""
    print(f"\n  -- PROBE D: refinement around the near-active points (n={n}) --")
    Eflat, N, Qfun, alt_idx, D = ctx["Eflat"], ctx["N"], ctx["Qfun"], ctx["alt_idx"], ctx["D"]
    mus, maxiter = budget["mus"], budget["maxiter"]
    ranked = sorted(pool, key=lambda r: r["margin"])
    picks, seen = [], []
    for r in ranked:
        if any(abs(r["theta"] - t) < 1e-7 and abs(r["d2"] - d) < 1e-7 for t, d in seen):
            continue
        seen.append((r["theta"], r["d2"]))
        picks.append(r)
        if len(picks) >= budget["n_refine"]:
            break
    t_start = time.time()
    for r in picks:
        x0, _ = project_to_x(r["W"], Eflat, N)
        print(f"    around theta={r['theta']:.9f} d2={r['d2']:.9f} margin={r['margin']:+.3e} "
              f"[{r['id']}]")
        for scale in budget["refine_scales"]:
            for dth in budget["refine_dtheta"]:
                dvec = rng.normal(size=D)
                x = x0 + scale * dvec / np.linalg.norm(dvec)
                x = ramp(x, lambda mu: obj_theta_pinned(mu, mu, r["theta"] + dth,
                                                        Eflat, N, Qfun, alt_idx), mus, maxiter)
                _, W, th, rel, d2 = polish_to_critical(x, Eflat, N, alt_idx, Qfun)
                rec = record(W, ctx, f"D around {r['theta']:.4f} scale={scale}")
                if accept(pool, rec, ctx, cat) and rec["margin"] < r["margin"] - 1e-12:
                    print(f"      improved: theta={rec['theta']:.9f} d2={rec['d2']:.9f} "
                          f"margin={rec['margin']:+.3e}  [{rec['id']}]")
    print(f"    PROBE D done [{time.time()-t_start:.0f}s], pool size {len(pool)}")


def probe_E(n, ctx, pool, cat, rng, budget):
    """Unbiased census, the coverage control for PROBEs A-D: minimize the criticality
    residual from random starts (analytic gradients, so saddles are reached as well as
    maxima) and read (theta, delta^2) wherever it lands. No defect term anywhere, so
    this samples the critical set without the pull toward high defect that every other
    probe applies -- what it turns up at theta >= 0.4 is an independent check on the
    frontier's height."""
    k = budget["census_starts"]
    print(f"\n  -- PROBE E: unbiased critical-point census, {k} random starts (n={n}) --")
    Eflat, N, Qfun, alt_idx, D = ctx["Eflat"], ctx["N"], ctx["Qfun"], ctx["alt_idx"], ctx["D"]
    t_start = time.time()
    got, clusters, best_res, loose = 0, [], np.inf, []
    for j in range(k):
        # two L-BFGS passes: the second restart is what gets D = 1638 starts down to
        # 1e-7, since one pass stalls on the flat directions of the residual
        x, W, th, rel, d2 = polish_to_critical(rng.normal(size=D), Eflat, N, alt_idx, Qfun)
        x, W, th, rel, d2 = polish_to_critical(x, Eflat, N, alt_idx, Qfun)
        rec = record(W, ctx, f"E census {j}")
        best_res = min(best_res, rec["absres"])
        if rec["absres"] < 1e-4 and rec["theta"] >= 0.4:
            loose.append((rec["theta"], rec["d2"], rec["absres"]))
        if accept(pool, rec, ctx, cat):
            got += 1
            if not any(abs(rec["theta"] - a) < 1e-6 and abs(rec["d2"] - b) < 1e-6
                       for a, b in clusters):
                clusters.append((rec["theta"], rec["d2"]))
    hi = [(a, b) for a, b in clusters if a >= 0.4]
    print(f"    {got}/{k} starts reached residual < {RESID_TOL:.0e} (best residual reached "
          f"{best_res:.1e}); {len(clusters)} distinct (theta, delta^2) values, "
          f"{len(hi)} of them at theta >= 0.4")
    if loose:
        a, b, rr = max(loose, key=lambda p: p[1])
        print(f"    including the near-critical starts (residual < 1e-4, {len(loose)} of them): "
              f"max delta^2 = {b:.9f} at theta = {a:.9f}, residual {rr:.1e} (L={Lline(a):.6f})")
    if hi:
        a, b = max(hi, key=lambda p: p[1])
        print(f"    census maximum defect at theta >= 0.4: delta^2={b:.9f} at theta={a:.9f} "
              f"(L={Lline(a):.6f})")
    print(f"    PROBE E done [{time.time()-t_start:.0f}s], pool size {len(pool)}")


# ---------------------------------------------------------------------
# reporting
# ---------------------------------------------------------------------
def dedupe(pool, tol=1e-7):
    """One representative per (theta, delta^2) cluster: the one with the smallest
    absolute residual, so the printed coordinates are the best-resolved ones."""
    out = []
    for r in sorted(pool, key=lambda r: r["absres"]):
        if any(abs(r["theta"] - o["theta"]) < tol and abs(r["d2"] - o["d2"]) < tol for o in out):
            continue
        out.append(r)
    return sorted(out, key=lambda r: (-r["theta"], -r["d2"]))


def frontier_table(n, pool):
    print(f"\n{'='*104}")
    print(f"FRONTIER TABLE at n={n}:  F(t) = max delta^2 over accepted critical points with theta >= t")
    print(f"  line: L(t) = (theta_0(12) - t)/|kappa_12| = ({theta0(12):.9f} - t)/{KAPPA_LINE:.9f}")
    print(f"  L_8(t) = (theta_0(8) - t)/|kappa_8| is printed too; kappa_8 = {kappa(8):+.6f} > 0,")
    print(f"  so at n=8 the candidate reads as a defect floor and L_8 binds only below theta_0(8).")
    print(f"{'='*104}")
    print(f"  {'t':>9} {'F(t)':>11} {'L_12(t)':>11} {'L_12-F':>11} {'L_8(t)':>11} "
          f"{'argmax theta':>13} {'C7 margin@arg':>14}  identity")
    for t in GRID:
        cand = [r for r in pool if r["theta"] >= t - 1e-9]
        if not cand:
            print(f"  {t:9.6f} {'(empty)':>11} {Lline(t):11.6f} {'--':>11} "
                  f"{Lline(t, 8):11.6f} {'--':>13} {'--':>14}  no critical point found at theta >= t")
            continue
        best = max(cand, key=lambda r: r["d2"])
        L12, L8 = Lline(t), Lline(t, 8)
        note = ""
        if L12 > 0.25:
            note = "   (L_12 > 1/4: vacuous, delta^2 <= 1/4 is proven)"
        print(f"  {t:9.6f} {best['d2']:11.6f} {L12:11.6f} {L12-best['d2']:11.6f} {L8:11.6f} "
              f"{best['theta']:13.9f} {best['margin']:+14.3e}  {best['id']}{note}")


def report_points(n, ctx, pool, c):
    print(f"\n  -- accepted critical points at n={n} (deduped), sorted by theta --")
    print(f"  {'theta':>13} {'delta^2':>11} {'L_12(theta)':>12} {'C7 margin':>12} "
          f"{'(r+,r-)':>10} {'stab':>5}  identity   (found by)")
    here = os.path.dirname(os.path.abspath(__file__))
    saved = 0
    for r in sorted(pool, key=lambda r: -r["theta"]):
        L = Lline(r["theta"])
        stab, orb = stabilizer_dim(r["W"], c)
        on_line = abs(r["margin"]) <= VIOL_TOL
        near = on_line or (L > 0 and r["d2"] >= NEAR_ACTIVE * L)
        tag = "  <-- ON THE LINE" if on_line else ("  <-- NEAR-ACTIVE" if near else "")
        if r["margin"] < -VIOL_TOL:
            tag = "  <<<<< ABOVE THE LINE: C7 REFUTED"
        print(f"  {r['theta']:13.9f} {r['d2']:11.6f} {L:12.6f} {r['margin']:+12.3e} "
              f"({r['rplus']:2d},{r['rminus']:2d}) {stab:5d}  {r['id']}   ({r['label']}){tag}")
        if r["id"].startswith("NEW"):
            vals, mult = np.unique(np.round(r["eigs"], 7), return_counts=True)
            sig = ", ".join(f"{v:+.6f}x{m}" for v, m in zip(vals[::-1], mult[::-1]) if abs(v) > 1e-7)
            print(f"      NEW point spectrum (nonzero eigenvalues with multiplicity): {sig}")
        if near or r["margin"] < -VIOL_TOL:
            fn = os.path.join(here, f"frontier_n{n}_th{r['theta']:.6f}_d2{r['d2']:.6f}.npy")
            np.save(fn, r["W"])
            saved += 1
            nz = np.sort(r["eigs"][np.abs(r["eigs"]) > 1e-9])[::-1]
            print(f"      saved {os.path.basename(fn)}; orbit dim {orb}, stabilizer dim {stab}; "
                  f"{len(nz)} nonzero eigenvalues, top/bottom "
                  f"{np.array2string(nz[:3], precision=6)} / {np.array2string(nz[-3:], precision=6)}")
            # second, structurally different Q implementations
            Q2 = Q_full(r["W"], c)
            res2 = norm(Q2 - r["theta"] * r["W"])
            line = f"      cross-check Q_full: ||Q2 - theta W|| = {res2:.2e}"
            if r["margin"] < -VIOL_TOL or n <= 8:
                Q3 = Q_op(ctx["L2"], r["W"])
                line += f";  Q_op: {norm(Q3 - r['theta'] * r['W']):.2e}"
            print(line)
            ev, th_h, Dt = hessian_profile(r["W"], ctx, c)
            nz, npos, nneg = (int(np.sum(np.abs(ev) < 1e-7)), int(np.sum(ev > 1e-7)),
                              int(np.sum(ev < -1e-7)))
            verdict_local = ("kernel = orbit: isolated modulo O(n), so no critical branch "
                             "leaves it" if nz == orb else
                             f"kernel exceeds the orbit by {nz-orb}: a critical branch may leave it")
            print(f"      Hessian of P on the sphere: dim {Dt}, {npos} positive / {nz} zero / "
                  f"{nneg} negative, top eigenvalue {ev[-1]:+.3e} -- {verdict_local}")
    print(f"  {saved} near-active/violating points saved to scripts/frontier_n{n}_*.npy")


def verdict(n, pool):
    viol = [r for r in pool if r["margin"] < -VIOL_TOL]
    print(f"\n  -- VERDICT at n={n} --")
    if viol:
        r = min(viol, key=lambda r: r["margin"])
        print(f"    C7 IS REFUTED: critical point with theta={r['theta']:.9f}, "
              f"delta^2={r['d2']:.9f}, absres={r['absres']:.1e}, margin={r['margin']:+.3e}")
        return
    touch = [r for r in pool if abs(r["margin"]) <= VIOL_TOL]
    print(f"    no accepted critical point lies above the line "
          f"(worst margin {min(r['margin'] for r in pool):+.3e})")
    if touch:
        print(f"    points ON the line (|margin| <= {VIOL_TOL:.0e}):")
        for r in touch:
            print(f"      {r['id']}: theta={r['theta']:.9f} d2={r['d2']:.9f} "
                  f"margin={r['margin']:+.3e}")
    else:
        print(f"    no point sits on the line to within {VIOL_TOL:.0e}")
    below = sorted((r for r in pool if r["margin"] > VIOL_TOL), key=lambda r: r["margin"])[:5]
    print("    nearest points below the line:")
    for r in below:
        print(f"      {r['id']}: theta={r['theta']:.9f} d2={r['d2']:.9f} "
              f"margin={r['margin']:+.6f}  (L={Lline(r['theta']):.6f})")


BUDGETS = {
    ("thorough"): dict(mus=(1.0, 10.0, 1e2, 1e3, 1e4, 1e5), maxiter=400, polish_iters=150,
                       seeds_hi=8, seeds_lo=4, seeds_window=16, seeds_hinge=3, n_random=2, seeds_dual=5,
                       n_refine=4, refine_scales=(0.02, 0.1, 0.3),
                       refine_dtheta=(0.0, -0.002, -0.006, +0.002, +0.006),
                       floors=(0.02, 0.05, 0.08, 1 / 9. - 1e-4, 0.115, 0.12, 0.13, 0.145),
                       lams=(KAPPA_LINE, 0.05, 0.2, 0.5, 1.0, 3.0), census_starts=120, targets=GRID),
    ("moderate"): dict(mus=(1.0, 10.0, 1e2, 1e3, 1e4, 1e5), maxiter=250, polish_iters=100,
                       seeds_hi=4, seeds_lo=2, seeds_window=8, seeds_hinge=2, n_random=1, seeds_dual=3,
                       n_refine=3, refine_scales=(0.03, 0.15),
                       refine_dtheta=(0.0, -0.004, +0.004),
                       floors=(0.05, 1 / 9. - 1e-4, 0.12, 0.145),
                       lams=(KAPPA_LINE, 0.3, 1.0), census_starts=40,
                       targets=sorted([0.4, 0.6, 0.8] + [t for t in GRID if t >= 0.9])),
    ("quick"): dict(mus=(1.0, 1e2, 1e4), maxiter=150, polish_iters=60,
                    seeds_hi=2, seeds_lo=1, seeds_window=3, seeds_hinge=1, n_random=1, seeds_dual=2,
                    n_refine=2, refine_scales=(0.05,), refine_dtheta=(0.0, -0.004),
                    floors=(1 / 9. - 1e-4, 0.13),
                    lams=(KAPPA_LINE,), census_starts=6,
                    targets=[1.0, 1.15, 1.2200, float(SQRT32), 1.2300]),
}


def sweep(n, mode="thorough", seed=20260820):
    t_start = time.time()
    print("=" * 104)
    print(f"FRONTIER SWEEP at n={n} ({mode}):  theta_0({n})={theta0(n):.9f}  kappa_{n}={kappa(n):+.9f}"
          f"   |  line from n=12: theta_0(12)={theta0(12):.9f}, |kappa_12|={KAPPA_LINE:.9f}")
    print("=" * 104)
    rng = np.random.default_rng(seed)
    ctx = setup(n)
    idx, pos, N, c = build_structure_constants(n)
    ctx["anchors"] = build_anchors(n, ctx)
    ctx["sphere_thetas"] = []
    cat = catalogue_table(n)
    pool = []

    print(f"\n  -- PART 0: anchors (exact catalogue points), padding invariance included --")
    for lab, W in ctx["anchors"]:
        rec = record(W, ctx, "anchor")
        if lab.startswith("sphere"):
            ctx["sphere_thetas"].append((lab, rec["theta"]))
        rec["id"] = lab
        ok = accept(pool, rec, ctx, cat)
        state = "accepted" if ok else f"REJECTED (absres={rec['absres']:.1e}, theta={rec['theta']:.2e})"
        print(f"    {lab:34s} theta={rec['theta']:.9f} d2={rec['d2']:.9f} "
              f"absres={rec['absres']:.1e} L_12={Lline(rec['theta']):+.6f} "
              f"C7margin={c7_margin(rec['theta'], rec['d2']):+.3e}  [{state}]")
        rec["id"] = lab
    ctx["seeds"] = build_seed_pool(n, ctx, rng)
    print(f"    {len(ctx['seeds'])} structured seeds prepared")

    print(f"\n  -- PART 0b: validating the off-diagonal Hessian construction --")
    Wbal = sphere_weyl(ctx, n // 2)
    Qf = qform_sym(Wbal, c)
    worst = 0.0
    for _ in range(5):
        H = (rng.normal(size=ctx["D"]) @ ctx["Eflat"]).reshape(N, N)
        H = 0.5 * (H + H.T)
        worst = max(worst, abs(frob(Wbal, ctx["Qfun"](H)) - float(H.reshape(-1) @ Qf @ H.reshape(-1))))
    ev, th_h, Dt = hessian_profile(Wbal, ctx, c)
    ev_ref, lam_ref, Dt_ref = hessian_fast.run(n, n // 2, n - n // 2, verbose=False)
    print(f"    quadratic form vs direct <W,Q(H)>: worst {worst:.1e} over 5 random H")
    print(f"    balanced-split Hessian vs hessian_fast (validated): dim {Dt} vs {Dt_ref}, "
          f"theta {th_h:.9f} vs {lam_ref:.9f}, "
          f"max |eigenvalue difference| {np.max(np.abs(np.sort(ev) - np.sort(ev_ref))):.1e}")

    budget = BUDGETS[mode]
    probe_A(n, ctx, pool, cat, rng, budget)
    probe_B(n, ctx, pool, cat, rng, budget)
    probe_C(n, ctx, pool, cat, rng, budget)
    probe_E(n, ctx, pool, cat, rng, budget)
    probe_D(n, ctx, pool, cat, rng, budget)

    pool = dedupe(pool)
    for r in pool:
        if r["id"] in ("NEW", "NEW (zero defect)"):
            r["id"] = identify(r, ctx, cat)
    frontier_table(n, pool)
    report_points(n, ctx, pool, c)
    verdict(n, pool)
    print(f"\n  n={n} sweep total runtime {time.time()-t_start:.0f}s")
    return pool


def main():
    args = [a for a in sys.argv[1:]]
    mode = None
    for m in ("thorough", "moderate", "quick"):
        if m in args:
            mode = m
            args.remove(m)
    ns = [int(a) for a in args] if args else [8, 12]
    for n in ns:
        sweep(n, mode or ("thorough" if n <= 8 else "moderate"))


if __name__ == "__main__":
    main()
