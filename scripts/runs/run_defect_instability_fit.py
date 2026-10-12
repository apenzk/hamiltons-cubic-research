"""Fit the sharp-part second derivative d2_sharp(W,A) (exact slot-insertion
sum, validated in run_defect_instability_proof.py) against an operator-level
candidate basis, to obtain a human-readable closed form.  Exact rational
coefficients are recovered and verified on held-out samples at several n.
"""
import numpy as np
from fractions import Fraction

from weyl_decomposition import norm, frob
from run_defect_instability_probe import make_ctx
from run_defect_instability_diag2 import DA_on_lambda2
from run_defect_instability_diag3 import ric_of_op, w_dot_A
from run_defect_instability_proof import (T4_of, d2_sharp, part_B4, _expm_sym,
                                          lam2_of, t_slots)


def action_of_op(Mop, A, ctx):
    """(X.A)_{ik} = sum_{j,l} X_{ijkl} A_{jl} for any symmetric operator X."""
    return w_dot_A(Mop, A, ctx)


def basis_terms(W, A, ctx):
    """Candidate closed-form terms for d2_sharp(W,A)."""
    n, N, Qfun = ctx["n"], ctx["N"], ctx["Qfun"]
    DA = DA_on_lambda2(A, ctx)
    A2 = A @ A
    DA2op = DA_on_lambda2(A2, ctx)         # derivation by A^2
    Wsharp = Qfun(W) - W @ W
    W2 = W @ W
    W3 = W2 @ W
    WA = w_dot_A(W, A, ctx)
    terms = {}
    terms["E1=tr(W3 DA^2)"] = np.trace(W3 @ DA @ DA)
    terms["E2=tr(W2 DA W DA)"] = np.trace(W2 @ DA @ W @ DA)
    terms["F1=tr(W# W DA^2)"] = np.trace(Wsharp @ W @ DA @ DA)
    terms["F2=tr(W# DA W DA)"] = np.trace(Wsharp @ DA @ W @ DA)
    terms["F3=tr(W# W DA2op)"] = np.trace(0.5 * (Wsharp @ W + W @ Wsharp) @ DA2op)
    terms["F4=tr(W3 DA2op)"] = np.trace(W3 @ DA2op)
    terms["G1=<W.(W.A),W.A>"] = frob(w_dot_A(W, WA, ctx), WA)
    terms["G3=<W#.A, W.A>"] = frob(action_of_op(Wsharp, A, ctx), WA)
    terms["G4=<W2.A, W.A>"] = frob(action_of_op(W2, A, ctx), WA)
    terms["G5=<W3.A, A>"] = frob(action_of_op(W3, A, ctx), A)
    terms["G6=<(W#W).A, A>"] = frob(action_of_op(0.5 * (Wsharp @ W + W @ Wsharp), A, ctx), A)
    terms["G7=<A2, Ric(W3)>"] = frob(A2, ric_of_op(W3, ctx))
    terms["G8=<A2, Ric(W#W)>"] = frob(A2, ric_of_op(0.5 * (Wsharp @ W + W @ Wsharp), ctx))
    terms["G9=tr(A2)*s"] = np.trace(A2) * np.trace(W3)
    terms["G10=tr(A2)*t"] = np.trace(A2) * frob(Wsharp, W)
    return terms


def collect(n, nsamp, rng, ctx=None):
    ctx = ctx or make_ctx(n, verbose=False)
    N, Eflat = ctx["N"], ctx["Eflat"]
    kappa = 4.0
    rows, ys, names = [], [], None
    for _ in range(nsamp):
        co = rng.normal(size=Eflat.shape[0])
        W = (Eflat.T @ co).reshape(N, N)
        W /= norm(W)
        A = rng.normal(size=(n, n)); A = 0.5 * (A + A.T)
        A -= np.trace(A) / n * np.eye(n)
        T4 = T4_of(W, ctx)
        y = d2_sharp(T4, A, kappa, n)
        t = basis_terms(W, A, ctx)
        if names is None:
            names = list(t.keys())
        rows.append([t[k] for k in names])
        ys.append(y)
    return np.array(rows), np.array(ys), names, ctx


def main():
    rng = np.random.default_rng(31415)
    X5, y5, names, ctx5 = collect(5, 40, rng)
    X6, y6, _, ctx6 = collect(6, 40, rng)
    # Fit with n-dependent coefficients? Try n-independent first, else per-n.
    for label, X, y in [("n=5", X5, y5), ("n=6", X6, y6)]:
        coef, res, rank, sv = np.linalg.lstsq(X, y, rcond=None)
        pred = X @ coef
        rr = np.max(np.abs(pred - y)) / np.max(np.abs(y))
        print(f"[{label}] fit rank={rank}/{X.shape[1]}  max rel resid={rr:.2e}")
        for nm, c in zip(names, coef):
            fr = Fraction(c).limit_denominator(600)
            mark = "*" if abs(c) > 1e-8 else " "
            print(f"   {mark} {nm:22s} {c:+.9f}  ~ {fr}")
    # joint fit with terms allowed n-dependence via extra 1/(n-2) columns
    print("\njoint fit with columns [T, T/(n-2)]:")
    Xj = np.vstack([np.hstack([X5, X5 / 3.0]), np.hstack([X6, X6 / 4.0])])
    yj = np.concatenate([y5, y6])
    coef, res, rank, sv = np.linalg.lstsq(Xj, yj, rcond=None)
    pred = Xj @ coef
    rr = np.max(np.abs(pred - yj)) / np.max(np.abs(yj))
    print(f"  rank={rank}/{Xj.shape[1]}  max rel resid={rr:.2e}")
    nn = names + [f"{nm}/(n-2)" for nm in names]
    for nm, c in zip(nn, coef):
        if abs(c) > 1e-8:
            fr = Fraction(c).limit_denominator(600)
            print(f"    {nm:28s} {c:+.9f}  ~ {fr}")
    # held-out at n=7
    X7, y7, _, _ = collect(7, 10, rng)
    Xj7 = np.hstack([X7, X7 / 5.0])
    pred7 = Xj7 @ coef
    rr7 = np.max(np.abs(pred7 - y7)) / np.max(np.abs(y7))
    print(f"  HELD-OUT n=7: max rel resid={rr7:.2e}")


if __name__ == "__main__":
    main()
