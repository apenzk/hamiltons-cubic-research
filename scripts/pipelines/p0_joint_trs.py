"""
Cycle 2: close the alpha ~ 0.295 window by solving the inner maximisation exactly.

WHERE THE LOSS IS.  The coupled bound reads

  gamma/sqrt(2/3) = 3 c^2 s T(W_1,W_1,W_2) + 3 c s^2 T(W_1,W_2,W_2) + s^3 P(W_2)

and bounds the first two terms by separate suprema over W_1.  The SAME W_1 serves
both, so that is lossy -- Reviewer 19 measured the overshoot at a factor 1.40,
against the 1.009 needed at n=16.

THE STRUCTURE.  For fixed W_2 the expression is quadratic-plus-linear in W_1:

  T(W_1,W_1,W_2) = <A x, x>,   A = the symmetric operator on V_{1/3} induced by W_2
  T(W_1,W_2,W_2) = <b, x>,     b = Pi_{V13} Q(W_2)

so maximising over unit x is exactly the TRUST REGION SUBPROBLEM, max of a
quadratic plus a linear term on a sphere -- classical, with an exact solution via
a parameterised eigenvalue problem (Gould-Lucidi-Roma-Toint, SIAM J. Optim. 9
(1999); Sorensen, SIAM J. Numer. Anal. 19 (1982)).  Here it is solved by direct
eigendecomposition of A followed by a secular-equation solve in the multiplier,
which is exact for the dimensions involved.

WHAT DECIDES THE SAVING.  If b lies along A's top eigenvector the separated bound
is attained and nothing is gained; if b is orthogonal to it, the two terms cannot
both be extremal and the saving is large.  This measures that alignment directly,
and reports the exact inner maximum against the separated bound.

DESIGN FLAW -- read before reusing the numbers below.

This computes a LOWER bound where the repair needs an UPPER bound.  The inner
maximisation over W_1 is solved exactly by the trust-region subproblem, which is
correct; but the outer maximisation over W_2 is an ascent, so the reported value
under-estimates the supremum, and it is further restricted to the single slice
s^2 = 3 eps with c_0 = 1.  At n=12, alpha=0.25 it returns 0.356556 while the true
sup gamma there is about 0.838 -- so "CLOSES" in the output below certifies
nothing.

WHAT IT DOES ESTABLISH.  The alignment |<b, v_max>|/|b| = 0.6749 at that point:
b = Pi_{V13} Q(W_2) is only partly aligned with the top eigenvector of A_{W_2},
which is precisely why the separated bound (1.318) overshoots the truth (0.838).

WHAT AN UPPER BOUND NEEDS.  A UNIFORM lower bound on that angle over all
admissible W_2, not one sample: with ||A|| <= sqrt(5/6), ||b|| <= 2/3 and the
angle bounded away from zero, the two terms provably cannot both be extremal.
Failing that, the joint cubic in (W_1, W_2) wants a sum-of-squares relaxation --
see Pipeline K in the scripts index -- which certifies an upper bound rather than
sampling one.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from run_unconstrained_search import build_weyl_basis
from p0_tubular_hessian import fox_point, F_matrix

SQ32 = np.sqrt(1.5)
R23 = np.sqrt(2.0 / 3.0)


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n


def trs_max(ev, q, g, lin):
    """max over unit x of  g*<A x,x> + lin*<b,x>, with A = diag(ev) and b = q,
    both already expressed in A's eigenbasis.  Solved by the secular equation:
    the maximiser satisfies (g A - mu I) x = -(lin/2) b with mu > g*max(ev)."""
    if abs(lin) < 1e-14:
        return g * ev.max() if g >= 0 else g * ev.min()
    ga = g * ev
    lo = ga.max() + 1e-12
    hi = lo + 10.0 + abs(lin) * np.linalg.norm(q)
    for _ in range(200):
        mu = 0.5 * (lo + hi)
        x = -(lin / 2.0) * q / (ga - mu)
        if np.dot(x, x) > 1.0:
            lo = mu
        else:
            hi = mu
    mu = 0.5 * (lo + hi)
    x = -(lin / 2.0) * q / (ga - mu)
    nx = np.linalg.norm(x)
    if nx > 1e-300:
        x = x / nx
    return float(g * np.dot(ev * x, x) + lin * np.dot(q, x))


def run(n, alphas=(0.25, 0.29, 0.295, 0.30), restarts=24, iters=120, seed=11):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    u, th, _ = fox_point(n, L2, Eflat, c)
    Nl = u.shape[0]
    M = F_matrix(u, c, Eflat)
    r = np.linalg.eigh(M)[0] / SQ32
    _, V = np.linalg.eigh(M)
    V13 = V[:, np.abs(r - 1.0 / 3.0) < 1e-8]
    Vle0 = V[:, r < 1e-8]
    k13 = V13.shape[1]

    def op(basis, y):
        W = (Eflat.T @ (basis @ y)).reshape(Nl, Nl)
        W = 0.5 * (W + W.T)
        nrm = np.linalg.norm(W)
        return W / nrm if nrm > 1e-300 else W

    # A-matrix on V13 induced by W2, and b = Pi_{V13} Q(W2)
    E13 = [Eflat.T @ V13[:, i] for i in range(k13)]
    E13 = [0.5 * (e.reshape(Nl, Nl) + e.reshape(Nl, Nl).T) for e in E13]

    def A_and_b(W2):
        A = np.empty((k13, k13))
        for i in range(k13):
            col = (Q_full(E13[i] + W2, c) - Q_full(E13[i] - W2, c)) / 2.0
            A[:, i] = V13.T @ (Eflat @ col.reshape(-1))
        A = 0.5 * (A + A.T)
        b = V13.T @ (Eflat @ Q_full(W2, c).reshape(-1))
        return A, b

    rng = np.random.default_rng(seed)
    print(f"n={n:3d}  dim V_1/3={k13}  dim V_<=0={Vle0.shape[1]}   theta_0={theta0(n):.6f}")
    for a in alphas:
        eps = 1.0 / 3.0 - a
        s2 = 3.0 * eps                       # the coupled bound's maximiser: c_0=1, s^2=3eps
        if s2 <= 0 or s2 >= 1:
            continue
        s, cb = np.sqrt(s2), np.sqrt(1 - s2)
        best, bestalign = -9e9, None
        for _ in range(restarts):
            y2 = rng.normal(size=Vle0.shape[1]); y2 /= np.linalg.norm(y2)
            for _ in range(iters):
                W2 = op(Vle0, y2)
                A, b = A_and_b(W2)
                ev, U = np.linalg.eigh(A)
                q = U.T @ b
                val = trs_max(ev, q, 3 * cb * cb * s, 3 * cb * s2)
                # ascend in W2 along the gradient of the whole expression
                W1 = op(V13, U[:, -1])
                g2 = Eflat @ ((Q_full(W1 + W2, c) - Q_full(W1 - W2, c)) / 2.0).reshape(-1)
                y2n = Vle0.T @ g2
                if np.linalg.norm(y2n) < 1e-300:
                    break
                y2 = y2n / np.linalg.norm(y2n)
            W2 = op(Vle0, y2)
            A, b = A_and_b(W2)
            ev, U = np.linalg.eigh(A)
            q = U.T @ b
            val = trs_max(ev, q, 3 * cb * cb * s, 3 * cb * s2)
            pw2 = float(np.sum(W2 * Q_full(W2, c)))
            tot = R23 * (val + s2 * s * pw2)
            align = abs(q[-1]) / max(np.linalg.norm(q), 1e-300)
            if tot > best:
                best, bestalign = tot, align
        sep = R23 * (3 * cb * cb * s * np.sqrt(5 / 6) + 3 * cb * s2 * (2 / 3) + s2 * s * theta0(n))
        req = (3 - 5 * a) / np.sqrt(3)
        print(f"   alpha={a:.4f}  joint(TRS)={best:.6f}  separated={sep:.6f}  requirement={req:.6f}"
              f"   |b.v_max|/|b|={bestalign:.4f}"
              f"   {'CLOSES' if best < req else 'fails'}", flush=True)
    print(flush=True)


if __name__ == "__main__":
    for n in (12, 16):
        run(n)
