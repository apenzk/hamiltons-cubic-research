"""
Falsification test for the DEFECT-PENALTY CANDIDATE inequality:

    P(W) <= theta0(n) + kappa_n * delta(W)^2      for all W in W_n, |W|=1,

with  theta0(n) = sqrt(2(n-1)(n-2))/n  (the balanced sphere-product value),
      delta(W)  = ||Alt(W_-)||          (the Bianchi defect, FINDINGS Result 4),
      kappa_n   = (sqrt(3/2) - theta0(n)) / d0,   d0 = delta(S^4(alpha))^2 = 1/9,

so that the bound is EQUALITY at both champions by construction: at the
balanced sphere product (delta=0) and at Fox's S^4(alpha) (delta^2=1/9,
P=sqrt(3/2), both n-independent under zero-padding). kappa_n changes sign
exactly at the crossover n = 6+2*sqrt(7), so for n<=11 the bound *permits*
S^4(alpha) above theta0 and for n>=12 it *penalizes* all defect. If true
for n>=12 it implies the zero-defect threshold conjecture (plan.md C6)
outright and quantifies Lemma 8's escape mechanism.

Equivalently: Phi(W) := P(W) - kappa_n*delta(W)^2 <= theta0(n) on |W|=1.

Test battery, ordered by cheapness of a kill:

  PART 0  setup + verify d0=1/9 at n=6,8,12 (padding invariance included).
  PART 1  margins at every catalogued critical point (sphere products all
          splits, Fox S^4(alpha), SU(3) bi-invariant + its n=12 padding,
          QK HP^2, padded HP^2, HP^3). Any negative margin at n=12 kills.
  PART 2  THE DECISIVE STRUCTURAL CHECK: sharpness at S^4(alpha) requires
          it to be a critical point of Phi on the sphere; since it is
          already critical for P, this needs the TANGENTIAL gradient of
          delta^2 to vanish there. One gradient evaluation decides it.
  PART 3  random-sample margins (1500 at n=8, 300 at n=12).
  PART 4  adversarial gradient ascent of Phi (analytic gradients via
          run_bianchi_defect_highp_seed.combined_step), seeded from
          perturbed champions plus random starts, at n=8 and n=12.

Everything is reused from validated repo machinery: Q_fast (bit-for-bit
validated vs Q_full), delta2_and_grad (validated vs central differences),
build_alt_indices/bianchi_defect (validated against the exact
scal(R^2+R^#) identity and both anchors).
"""
import time
import numpy as np

from curvature_operator import Lambda2
from weyl_decomposition import weyl_from_mop, mop_from_4tensor, norm, frob
from weyl import build_structure_constants
from run_sphere import sphere_product_mop
from run_cp2_ricci_flat import cp2_block_st_tensor
from run_hpm_qk import qk_tensor
from run_bianchi_defect import build_alt_indices, bianchi_defect
from run_bianchi_defect_highp_seed import (theta0, delta2_and_grad, build_su3_n8,
                                            pad_weyl_to_n, project_to_x,
                                            combined_step, combined_ascent)
from run_unconstrained_search import build_weyl_basis
from run_unconstrained_search_n12 import Q_fast, build_Cflat, validate_fast_vs_full

SQRT32 = np.sqrt(1.5)
D0_EXACT = 1.0 / 9.0


def kappa(n):
    return (SQRT32 - theta0(n)) / D0_EXACT


def setup(n, verbose=True):
    t0 = time.time()
    L2 = Lambda2(n)
    alt_idx = build_alt_indices(L2)
    idx, pos, N, c = build_structure_constants(n)
    Cflat = build_Cflat(c)
    Qfun = lambda W: Q_fast(W, Cflat, N)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    if verbose:
        print(f"  setup n={n}: N={N} dim(Weyl)={D}  theta0={theta0(n):.6f}  "
              f"kappa={kappa(n):+.6f}  [{time.time()-t0:.1f}s]")
    return dict(n=n, L2=L2, alt_idx=alt_idx, N=N, Qfun=Qfun, Eflat=Eflat, D=D)


def margin_row(label, Wn, ctx):
    """margin = RHS - P = theta0 + kappa*delta^2 - P; negative => violation."""
    n, Qfun, alt_idx = ctx["n"], ctx["Qfun"], ctx["alt_idx"]
    Q = Qfun(Wn)
    P = frob(Wn, Q)
    resid = norm(Q - P * Wn) / (norm(Q) + 1e-300)
    d = bianchi_defect(Wn, alt_idx)
    rhs = theta0(n) + kappa(n) * d * d
    m = rhs - P
    flag = "  <-- VIOLATION" if m < -1e-7 else ""
    print(f"  {label:42s} P={P:+.6f}  delta^2={d*d:.6f}  RHS={rhs:.6f}  "
          f"margin={m:+.6f}  idemp_resid={resid:.1e}{flag}")
    return m


def fox_weyl(ctx):
    """The P-POSITIVE orientation of Fox's S^4(alpha): cp2_block_st_tensor's
    (s,t)=(1,-1) convention lands on the P<0 antipode, which is a different
    point for every sign-odd quantity here (P flips, and delta^2 swaps
    W_- for W_+), so the champion must be oriented by the sign of P."""
    n, L2 = ctx["n"], ctx["L2"]
    T = cp2_block_st_tensor(n, 1.0, -1.0)
    Weyl, Ric, S = weyl_from_mop(L2, mop_from_4tensor(L2, T))
    Wn = Weyl / norm(Weyl)
    if frob(Wn, ctx["Qfun"](Wn)) < 0:
        Wn = -Wn
    return Wn


def sphere_weyl(ctx, p):
    L2 = ctx["L2"]
    Weyl, Ric, S = weyl_from_mop(L2, sphere_product_mop(L2, p))
    return Weyl / norm(Weyl)


def qk_weyl(ctx, m, c1=1.0, c2=1.0, ambient_block=None):
    n, L2 = ctx["n"], ctx["L2"]
    T = qk_tensor(n, m, c1, c2, ambient_block=ambient_block)
    Weyl, Ric, S = weyl_from_mop(L2, mop_from_4tensor(L2, T))
    return Weyl / norm(Weyl)


# ---------------------------------------------------------------------
# PART 2: tangential gradients at a point, decomposed into the P part
# and the delta^2 part, so a sharpness failure is attributed exactly.
# ---------------------------------------------------------------------
def tangential_report(label, Wn, ctx):
    n, N, Eflat, Qfun, alt_idx = ctx["n"], ctx["N"], ctx["Eflat"], ctx["Qfun"], ctx["alt_idx"]
    x, recon = project_to_x(Wn, Eflat, N)
    Phi, grad_x, Wmat, Qmat, P, d2 = combined_step(x, Eflat, N, alt_idx, kappa(n), Qfun)
    # pure-P tangential gradient
    gP = Eflat @ (3.0 * Qmat.reshape(-1))
    gP_tan = gP - np.dot(gP, x) * x
    # pure-delta^2 tangential gradient
    _, Gd2 = delta2_and_grad(Wmat, alt_idx)
    gd = Eflat @ Gd2.reshape(-1)
    gd_tan = gd - np.dot(gd, x) * x
    # combined
    g_tan = grad_x - np.dot(grad_x, x) * x
    print(f"  {label:32s} recon_err={recon:.1e}  Phi={Phi:.6f} (theta0={theta0(n):.6f})")
    print(f"    ||tan grad P||={np.linalg.norm(gP_tan):.3e}   "
          f"||tan grad delta^2||={np.linalg.norm(gd_tan):.3e}   "
          f"||tan grad Phi||={np.linalg.norm(g_tan):.3e}")
    return np.linalg.norm(g_tan), gd_tan, x


def full_battery(n, n_samples=200, n_random_seeds=8, iters=500, seed=20260819):
    """The complete falsification battery at a single dimension n: d0 anchor,
    catalogue margins, two-sided kink profile at Fox, Fox->balanced ridge,
    random samples, and adversarial ascent. Written for n=14 (dim W_14=3080,
    Eflat ~204MB), where kappa_14 = -0.332 tightens the penalty to ~3.3x the
    n=12 value -- the likelier failure regime per FINDINGS."""
    rng = np.random.default_rng(seed)
    ctx = setup(n)
    N, D, Eflat, Qfun, alt_idx = ctx["N"], ctx["D"], ctx["Eflat"], ctx["Qfun"], ctx["alt_idx"]
    kap = kappa(n)

    print(f"\n  -- PART 0: d0 anchor at n={n} --")
    Wfox = fox_weyl(ctx)
    d = bianchi_defect(Wfox, alt_idx)
    print(f"  delta(S^4(alpha))^2 = {d*d:.10f}   (exact 1/9 = {1/9:.10f})")

    print(f"\n  -- PART 1: catalogue margins at n={n} --")
    worst = np.inf
    for p in range(2, n // 2 + 1):
        worst = min(worst, margin_row(f"sphere ({p},{n-p})", sphere_weyl(ctx, p), ctx))
    worst = min(worst, margin_row("Fox S^4(alpha) (padded)", Wfox, ctx))
    L2_8, Wsu3 = build_su3_n8()
    _, Wsu3_n = pad_weyl_to_n(L2_8, Wsu3, n)
    worst = min(worst, margin_row(f"SU(3) padded 8->{n}", Wsu3_n, ctx))
    L2_8b = Lambda2(8)
    Whp2 = weyl_from_mop(L2_8b, mop_from_4tensor(L2_8b, qk_tensor(8, 2, 1.0, 1.0)))[0]
    _, Whp2_n = pad_weyl_to_n(L2_8b, Whp2 / norm(Whp2), n)
    worst = min(worst, margin_row(f"QK HP^2 padded 8->{n}", Whp2_n, ctx))
    L2_12 = Lambda2(12)
    Whp3 = weyl_from_mop(L2_12, mop_from_4tensor(L2_12, qk_tensor(12, 3, 1.0, 1.0)))[0]
    _, Whp3_n = pad_weyl_to_n(L2_12, Whp3 / norm(Whp3), n)
    worst = min(worst, margin_row(f"QK HP^3 padded 12->{n}", Whp3_n, ctx))
    print(f"  worst catalogue margin: {worst:+.6f}")

    print(f"\n  -- PART 2: two-sided kink profile at Fox (n={n}) --")
    xf, recon = project_to_x(Wfox, Eflat, N)
    Phi0, grad_x, Wmat, Qmat, P0, d20 = combined_step(xf, Eflat, N, alt_idx, kap, Qfun)
    g_tan = grad_x - np.dot(grad_x, xf) * xf
    u = g_tan / np.linalg.norm(g_tan)
    w = np.linalg.eigvalsh(Wmat)
    print(f"  recon_err={recon:.1e}  Phi(fox)-theta0={Phi0-theta0(n):+.2e}  "
          f"spectrum: #zero={int(np.sum(np.abs(w)<1e-10))}, #neg={int(np.sum(w<-1e-10))}, "
          f"#pos={int(np.sum(w>1e-10))}  ||tan subgrad Phi||={np.linalg.norm(g_tan):.3e}")
    for t in (1e-6, 1e-4, 1e-3, 1e-2, 3e-2):
        row = []
        for s in (+t, -t):
            x = xf + s * u
            x /= np.linalg.norm(x)
            Phi, _, _, _, P, d2 = combined_step(x, Eflat, N, alt_idx, kap, Qfun)
            row += [Phi - theta0(n), d2 - d20]
        print(f"    t={t:.0e}: Phi(+t)-theta0={row[0]:+.3e} d2(+t)-d2_0={row[1]:+.3e}   "
              f"Phi(-t)-theta0={row[2]:+.3e} d2(-t)-d2_0={row[3]:+.3e}")
    best = -np.inf
    for _ in range(200):
        v = rng.normal(size=D)
        v -= np.dot(v, xf) * xf
        v /= np.linalg.norm(v)
        for t in (1e-3, 1e-2):
            for s in (+t, -t):
                x = xf + s * v
                x /= np.linalg.norm(x)
                Phi, _, _, _, _, _ = combined_step(x, Eflat, N, alt_idx, kap, Qfun)
                best = max(best, Phi - theta0(n))
    print(f"  best Phi-theta0 over 200 random tangent dirs at Fox: {best:+.3e}")

    print(f"\n  -- PART 2b: Fox -> balanced great-circle ridge (n={n}) --")
    xb, _ = project_to_x(sphere_weyl(ctx, n // 2), Eflat, N)
    ang = np.arccos(np.clip(np.dot(xf, xb), -1, 1))
    worst_path = -np.inf
    for s in np.linspace(0, 1, 41):
        x = (np.sin((1 - s) * ang) * xf + np.sin(s * ang) * xb) / np.sin(ang)
        x /= np.linalg.norm(x)
        Phi, _, _, _, P, d2 = combined_step(x, Eflat, N, alt_idx, kap, Qfun)
        worst_path = max(worst_path, Phi - theta0(n))
    print(f"  max (Phi-theta0) on 41-point path: {worst_path:+.6f}")

    print(f"\n  -- PART 3: {n_samples} random unit Weyl tensors (n={n}) --")
    t0 = time.time()
    mmin = np.inf
    for _ in range(n_samples):
        x = rng.normal(size=D)
        x /= np.linalg.norm(x)
        W = (x @ Eflat).reshape(N, N)
        W = 0.5 * (W + W.T)
        P = frob(W, Qfun(W))
        dd = bianchi_defect(W, alt_idx)
        mmin = min(mmin, theta0(n) + kap * dd * dd - P)
    print(f"  min margin={mmin:+.6f}  [{time.time()-t0:.1f}s]")

    print(f"\n  -- PART 4: adversarial ascent of Phi (n={n}) --")
    schedule = ((kap, iters),)
    seeds = []
    for name, xc in (("fox", xf), ("balanced", xb)):
        seeds.append((f"{name}(exact)", xc.copy()))
        for s in (0.05, 0.2, 0.5):
            dvec = rng.normal(size=D)
            dvec /= np.linalg.norm(dvec)
            seeds.append((f"{name}(pert s={s})", xc + s * dvec))
    for s in (0.25, 0.5, 0.75):
        seeds.append((f"path s={s}",
                      (np.sin((1 - s) * ang) * xf + np.sin(s * ang) * xb) / np.sin(ang)))
    for r in range(n_random_seeds):
        seeds.append((f"random {r}", rng.normal(size=D)))
    t0 = time.time()
    best = []
    for label, x0 in seeds:
        x, Wmat, P, resid, delta = combined_ascent(x0, Eflat, N, alt_idx, Qfun,
                                                    schedule, tol=1e-12)
        Phi = P - kap * delta ** 2
        best.append((Phi, label, P, delta ** 2, resid))
    best.sort(reverse=True)
    print(f"  {len(seeds)} seeds, {time.time()-t0:.1f}s; theta0={theta0(n):.6f}")
    for Phi, label, P, d2, resid in best[:6]:
        flag = "  <-- VIOLATION" if Phi > theta0(n) + 1e-6 else ""
        print(f"    Phi={Phi:.8f}  P={P:+.6f}  delta^2={d2:.6f}  resid={resid:.1e}  "
              f"seed={label}{flag}")
    n_above = sum(1 for b in best if b[0] > theta0(n) + 1e-6)
    print(f"  seeds ending above theta0+1e-6: {n_above}/{len(seeds)}")


def main():
    t_start = time.time()
    rng = np.random.default_rng(20260819)

    print("=" * 78)
    print("PART 0: setup, Q_fast validation, and d0 = delta(S^4(alpha))^2 = 1/9")
    print("=" * 78)
    validate_fast_vs_full(n=6, ntrials=3, seed=0)
    validate_fast_vs_full(n=8, ntrials=3, seed=0)
    ctxs = {n: setup(n) for n in (6, 8, 12)}
    for n in (6, 8, 12):
        W = fox_weyl(ctxs[n])
        d = bianchi_defect(W, ctxs[n]["alt_idx"])
        print(f"  n={n}: delta(S^4(alpha))^2 = {d*d:.10f}   (exact 1/9 = {1/9:.10f})")

    print()
    print("=" * 78)
    print("PART 1: margins at catalogued critical points (negative margin = violation)")
    print("=" * 78)
    worst = np.inf
    print("\n  -- n=6 --")
    ctx = ctxs[6]
    for p in (2, 3):
        worst = min(worst, margin_row(f"sphere ({p},{6-p})", sphere_weyl(ctx, p), ctx))
    worst = min(worst, margin_row("Fox S^4(alpha)", fox_weyl(ctx), ctx))

    print("\n  -- n=8 --")
    ctx = ctxs[8]
    for p in (2, 3, 4):
        worst = min(worst, margin_row(f"sphere ({p},{8-p})", sphere_weyl(ctx, p), ctx))
    worst = min(worst, margin_row("Fox S^4(alpha)", fox_weyl(ctx), ctx))
    L2_8, Wsu3 = build_su3_n8()
    worst = min(worst, margin_row("SU(3) bi-invariant", Wsu3, ctx))
    worst = min(worst, margin_row("QK HP^2", qk_weyl(ctx, 2), ctx))

    print("\n  -- n=12 --")
    ctx = ctxs[12]
    for p in (2, 3, 4, 5, 6):
        worst = min(worst, margin_row(f"sphere ({p},{12-p})", sphere_weyl(ctx, p), ctx))
    worst = min(worst, margin_row("Fox S^4(alpha) (padded)", fox_weyl(ctx), ctx))
    _, Wsu3_12 = pad_weyl_to_n(L2_8, Wsu3, 12)
    worst = min(worst, margin_row("SU(3) padded 8->12", Wsu3_12, ctx))
    worst = min(worst, margin_row("QK HP^2 padded (Ricci-flat ratio)",
                                   qk_weyl(ctx, 2, -9.0 / 7.0, 1.0, ambient_block=list(range(8))), ctx))
    worst = min(worst, margin_row("QK HP^3", qk_weyl(ctx, 3), ctx))
    print(f"\n  worst catalogue margin: {worst:+.6f}")

    print()
    print("=" * 78)
    print("PART 2: sharpness structure -- is each champion a critical point of Phi?")
    print("  (sharpness at S^4(alpha) REQUIRES ||tan grad delta^2|| = 0 there;")
    print("   a nonzero value kills the candidate in this exact form, since any")
    print("   smooth penalty h(delta^2) with h'!=0 inherits the same defect slope)")
    print("=" * 78)
    for n in (8, 12):
        print(f"\n  -- n={n} --")
        ctx = ctxs[n]
        tangential_report("balanced sphere product", sphere_weyl(ctx, n // 2), ctx)
        gnorm_fox, gd_tan_fox, x_fox = tangential_report("Fox S^4(alpha)", fox_weyl(ctx), ctx)

    print()
    print("=" * 78)
    print("PART 3: random-sample margins (unit-norm Weyl tensors)")
    print("=" * 78)
    for n, nsamp in ((8, 1500), (12, 300)):
        ctx = ctxs[n]
        N, D, Eflat, Qfun, alt_idx = ctx["N"], ctx["D"], ctx["Eflat"], ctx["Qfun"], ctx["alt_idx"]
        t0 = time.time()
        mmin = np.inf
        nviol = 0
        for _ in range(nsamp):
            x = rng.normal(size=D)
            x /= np.linalg.norm(x)
            W = (x @ Eflat).reshape(N, N)
            W = 0.5 * (W + W.T)
            P = frob(W, Qfun(W))
            d = bianchi_defect(W, alt_idx)
            m = theta0(n) + kappa(n) * d * d - P
            mmin = min(mmin, m)
            if m < -1e-7:
                nviol += 1
        print(f"  n={n}: {nsamp} samples, min margin={mmin:+.6f}, violations={nviol}  "
              f"[{time.time()-t0:.1f}s]")

    print()
    print("=" * 78)
    print("PART 4: adversarial ascent of Phi = P - kappa_n*delta^2 on the unit sphere")
    print("  (claim: sup Phi = theta0(n); any Phi > theta0 + 1e-6 is a violation)")
    print("=" * 78)
    for n, n_random, iters in ((8, 30, 500), (12, 12, 500)):
        ctx = ctxs[n]
        N, D, Eflat, Qfun, alt_idx = ctx["N"], ctx["D"], ctx["Eflat"], ctx["Qfun"], ctx["alt_idx"]
        schedule = ((kappa(n), iters),)
        seeds = []
        # perturbed champions: the equality cases are where a violation would hide
        for name, Wc in (("fox", fox_weyl(ctx)), ("balanced", sphere_weyl(ctx, n // 2))):
            xc, _ = project_to_x(Wc, Eflat, N)
            seeds.append((f"{name}(exact)", xc))
            for s in (0.05, 0.2, 0.5):
                for k in range(2):
                    dvec = rng.normal(size=D)
                    dvec /= np.linalg.norm(dvec)
                    seeds.append((f"{name}(pert s={s})", xc + s * dvec))
        for r in range(n_random):
            seeds.append((f"random {r}", rng.normal(size=D)))
        t0 = time.time()
        best = []
        for label, x0 in seeds:
            x, Wmat, P, resid, delta = combined_ascent(x0, Eflat, N, alt_idx, Qfun,
                                                        schedule, tol=1e-12)
            Phi = P - kappa(n) * delta ** 2
            best.append((Phi, label, P, delta ** 2, resid))
        best.sort(reverse=True)
        print(f"\n  -- n={n}: {len(seeds)} seeds, {time.time()-t0:.1f}s; theta0={theta0(n):.6f} --")
        for Phi, label, P, d2, resid in best[:6]:
            flag = "  <-- VIOLATION" if Phi > theta0(n) + 1e-6 else ""
            print(f"    Phi={Phi:.6f}  P={P:+.6f}  delta^2={d2:.6f}  "
              f"idemp_resid={resid:.1e}  seed={label}{flag}")
        n_above = sum(1 for b in best if b[0] > theta0(n) + 1e-6)
        print(f"    seeds ending above theta0+1e-6: {n_above}/{len(seeds)}")

    print(f"\ntotal runtime: {time.time()-t_start:.1f}s")


if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1:
        full_battery(int(sys.argv[1]))
    else:
        main()
