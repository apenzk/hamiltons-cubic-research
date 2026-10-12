"""The GL-trace necessary condition, finalized:

    trGL(W) := sum_{A in ONB of Sym_0(R^n)} Hess(H_A, H_A)
             = a_n s + b_n t - 12 theta (n^2+n-8)/n + 36 theta/(n-2)
               - 12 theta ||Ric_op(W^2)_0||^2

at any unit-norm critical point (s = tr W^3, t = <W^#,W> = theta - s), and
'W a local max of P on the unit Weyl sphere  =>  trGL(W) <= 0'.

This script: (1) extracts a_n, b_n at n = 6, 7, 8 and fits closed forms;
(2) verifies the assembled scalar against the direct pipeline sum at every
catalogued critical point; (3) evaluates the condition on the catalogue
(local maxima must pass; CP^3 and the other GL-detected saddles must fail).
"""
import numpy as np
from fractions import Fraction

from weyl_decomposition import norm, frob
from run_bianchi_defect import bianchi_defect
from run_bianchi_defect_highp_seed import build_su3_n8
from run_defect_penalty_test import fox_weyl, sphere_weyl, qk_weyl
from run_defect_max_hunt import su_m_kahler_weyl

from run_defect_instability_probe import make_ctx, cp3_weyl, plateau2_weyl
from run_defect_instability_diag2 import DA_on_lambda2, sym0_basis
from run_defect_instability_diag3 import ric_of_op, w_dot_A
from run_defect_instability_proof import T4_of, d2_sharp, hess_GL_formula


def cubic_sum(W, ctx):
    """S_cubic(W) = sum_A [P''_A - 12/(n-2) <W.(W.A),W.A>]  (exact)."""
    n = ctx["n"]
    T4 = T4_of(W, ctx)
    tot = 0.0
    for A in sym0_basis(n):
        DA = DA_on_lambda2(A, ctx)
        E1 = np.trace(W @ W @ W @ DA @ DA)
        E2 = np.trace(W @ W @ DA @ W @ DA)
        WA = w_dot_A(W, A, ctx)
        WWA = w_dot_A(W, WA, ctx)
        tot += (12 * E1 + 24 * E2 + d2_sharp(T4, A, 4.0, n)
                - 12.0 / (n - 2.0) * frob(WWA, WA))
    return tot


def extract_ab(n, nsamp=6, seed=123):
    ctx = make_ctx(n, verbose=False)
    N, Eflat, Qfun = ctx["N"], ctx["Eflat"], ctx["Qfun"]
    rng = np.random.default_rng(seed)
    M, y = [], []
    for _ in range(nsamp):
        co = rng.normal(size=Eflat.shape[0])
        W = (Eflat.T @ co).reshape(N, N)
        W /= norm(W)
        s = np.trace(W @ W @ W)
        t = frob(Qfun(W) - W @ W, W)
        M.append([s, t])
        y.append(cubic_sum(W, ctx))
    coef, *_ = np.linalg.lstsq(np.array(M), np.array(y), rcond=None)
    resid = np.max(np.abs(np.array(M) @ coef - np.array(y))) / np.max(np.abs(y))
    return coef, resid, ctx


def trGL_closed(W, ctx, a, b):
    n, Qfun = ctx["n"], ctx["Qfun"]
    Q = Qfun(W)
    theta = frob(W, Q)
    s = np.trace(W @ W @ W)
    t = frob(Q - W @ W, W)
    Ric2 = ric_of_op(W @ W, ctx)
    Ric2_0 = Ric2 - np.trace(Ric2) / n * np.eye(n)
    return (a * s + b * t
            - 12.0 * theta * (n * n + n - 8.0) / n
            + 36.0 * theta / (n - 2.0)
            - 12.0 * theta * frob(Ric2_0, Ric2_0)), theta


def trGL_direct(W, ctx):
    n, Qfun = ctx["n"], ctx["Qfun"]
    theta = frob(W, Qfun(W))
    tot = 0.0
    for A in sym0_basis(n):
        v, _ = hess_GL_formula(W, A, ctx, theta)
        tot += v
    return tot


def main():
    consts = {}
    for n in (6, 7, 8):
        coef, resid, ctx = extract_ab(n)
        fa = Fraction(coef[0]).limit_denominator(4000)
        fb = Fraction(coef[1]).limit_denominator(4000)
        consts[n] = (coef[0], coef[1], ctx)
        print(f"n={n}: a={coef[0]:.9f} (~{fa})  b={coef[1]:.9f} (~{fb})  "
              f"resid={resid:.1e}")
    # closed-form guesses for a_n, b_n: fit a_n = (p2 n^2 + p1 n + p0)/n etc.
    ns = np.array([6.0, 7.0, 8.0])
    for k, lbl in [(0, "a_n"), (1, "b_n")]:
        vals = np.array([consts[6][k], consts[7][k], consts[8][k]])
        # try quadratic-over-n form: v = (alpha n^2 + beta n + gamma)/n
        Mfit = np.column_stack([ns, np.ones(3), 1.0 / ns])
        c = np.linalg.solve(Mfit, vals)
        fr = [Fraction(x).limit_denominator(200) for x in c]
        print(f"  {lbl} = ({fr[0]} n^2 + {fr[1]} n + {fr[2]})/n   "
              f"[floats {np.round(c,6)}]")

    # catalogue verification: closed form vs direct sum, and the condition
    print("-" * 90)
    print("catalogue: trGL (closed) vs (direct), verdict [local max needs <= 0]")
    for n in (6, 8):
        a, b, ctx = consts[n]
        pts = []
        if n == 6:
            L2 = ctx["L2"]
            pts = [("sphere (3,3) [max]", sphere_weyl(ctx, 3)),
                   ("Fox [max]", fox_weyl(ctx)),
                   ("su(3) [max]", su_m_kahler_weyl(L2, 3)),
                   ("CP^3 [saddle]", cp3_weyl(ctx))]
        else:
            L2 = ctx["L2"]
            _, Wsu3bi = build_su3_n8()
            pts = [("sphere (4,4) [max]", sphere_weyl(ctx, 4)),
                   ("Fox [max]", fox_weyl(ctx)),
                   ("su(4) [saddle]", su_m_kahler_weyl(L2, 4)),
                   ("QK HP^2 [max]", qk_weyl(ctx, 2)),
                   ("violator [saddle]", np.load("scripts/data/defect_violation_n8_0.120000.npy")),
                   ("plateau [saddle]", plateau2_weyl(ctx)),
                   ("SU(3)bi [saddle]", Wsu3bi)]
        for lbl, Wr in pts:
            W = Wr / norm(Wr)
            if frob(W, ctx["Qfun"](W)) < 0:
                W = -W
            v_closed, theta = trGL_closed(W, ctx, a, b)
            v_direct = trGL_direct(W, ctx)
            d2 = bianchi_defect(W, ctx["alt_idx"]) ** 2
            verdict = "detects SADDLE" if v_closed > 1e-7 else "consistent with max"
            print(f"  n={n} {lbl:22s} theta={theta:+.4f} d2={d2:.4f} "
                  f"trGL={v_closed:+.6f} (direct {v_direct:+.6f}, "
                  f"diff {abs(v_closed-v_direct):.1e})  {verdict}")


if __name__ == "__main__":
    main()
