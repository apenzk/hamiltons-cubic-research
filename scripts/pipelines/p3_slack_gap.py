"""
Is the graded-compression slack S bounded away from zero on ungraded critical points?

MOTIVATION (from the exact theta formula already proven here):

    theta * tr(W_-) = ||Ric(W_-)||^2 + 6 delta^2 - tr(W_-^2) - S,

so S enters with a MINUS sign: ungradedness mechanically subtracts from theta.
If S >= c > 0 on the ungraded critical set, theta drops by c/tr(W_-) below the
graded ceiling, which the enumeration already bounds.  The gap to close is 0.324
wide, so any positive c suffices -- unlike the three sharp inequalities that
died, none of which needed to be sharp either.

LITERATURE FRAMING.  Crit(P) inside the unit sphere of Weyl_n is a compact real
algebraic set, hence has FINITELY MANY connected components (Lojasiewicz;
Tarski-Seidenberg).  S is a polynomial on it and {S = 0} is exactly the graded
class.  So if the graded set is a union of connected components of Crit -- i.e.
no continuous path of critical points joins graded to ungraded -- then S is
bounded below on the remainder by compactness, with no further estimate needed.
This script probes that: it searches for critical points MINIMISING S subject to
S > 0, rather than maximising theta.  A sequence with S -> 0 and theta bounded
away from the graded values would refute the component separation; a floor is
evidence for it.

Objective on the unit sphere of Weyl_n:
    F(W) = ||Q(W) - theta W||^2 / ||Q(W)||^2  +  mu * S(W)
with mu > 0, so the search is actively pulled towards SMALL slack -- biased
against the gap, i.e. towards refuting it.
"""
import numpy as np
from scipy.optimize import minimize

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad
from run_unconstrained_search import build_weyl_basis

SQ32 = np.sqrt(1.5)


def slack_of(L2, W, c, alt):
    QW = Q_full(W, c)
    th = float(np.sum(W * QW))
    ev, V = np.linalg.eigh(W)
    neg = ev < 0
    Wm = (V[:, neg] * (-ev[neg])) @ V[:, neg].T
    d2 = float(delta2_and_grad(W, alt)[0])
    rm = ricci_from_mop(L2, Wm)
    S = float(np.sum(rm * rm)) + 6 * d2 - th * float(np.trace(Wm)) - float(np.trace(Wm @ Wm))
    res = np.linalg.norm(QW - th * W) / max(np.linalg.norm(QW), 1e-300)
    return th, S, d2, res


def run(n, seeds=24, mu=3.0):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    alt = build_alt_indices(L2)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    Nl = int(round(np.sqrt(Eflat.shape[1])))

    def F(x):
        x = x / np.linalg.norm(x)
        W = (Eflat.T @ x).reshape(Nl, Nl)
        W = 0.5 * (W + W.T)
        th, S, _d, res = slack_of(L2, W, c, alt)
        return res * res + mu * max(S, 0.0)

    rows = []
    import time; t0 = time.time()
    rng = np.random.default_rng(11)
    for s in range(seeds):
        x0 = rng.normal(size=D)
        x0 /= np.linalg.norm(x0)
        r = minimize(F, x0, method="Powell",
                     options={"maxiter": 400, "xtol": 1e-8, "ftol": 1e-10})
        x = r.x / np.linalg.norm(r.x)
        W = (Eflat.T @ x).reshape(Nl, Nl)
        W = 0.5 * (W + W.T)
        W /= np.linalg.norm(W)
        th, S, d2, res = slack_of(L2, W, c, alt)
        if th < 0:
            W = -W
            th, S, d2, res = slack_of(L2, W, c, alt)
        ric = float(np.max(np.abs(ricci_from_mop(L2, W))))
        if res < 1e-7 and ric < 1e-8 and th > 1e-6:
            rows.append((S, th, d2, res))
        if (s + 1) % 6 == 0:
            print(f"      [n={n}] seed {s+1}/{seeds}, {len(rows)} converged, {time.time()-t0:.0f}s", flush=True)

    ung = sorted([r for r in rows if r[0] > 1e-7])
    gra = [r for r in rows if r[0] <= 1e-7]
    print(f"n={n:3d}  dim Weyl={D:5d}   converged {len(rows)}   graded {len(gra)}   ungraded {len(ung)}")
    if ung:
        print(f"      smallest ungraded slacks (S, theta, delta^2, resid):")
        for S, th, d2, res in ung[:6]:
            print(f"        S={S:.9f}  theta={th:.9f}  delta^2={d2:.6f}  res={res:.1e}")
        print(f"      => inf S over ungraded found here = {ung[0][0]:.9f}")
    if gra:
        print(f"      max graded theta = {max(g[1] for g in gra):.9f}")
    print()
    return ung


print("Searching for critical points with SMALL positive slack.")
print("The objective rewards small S, so the search is biased AGAINST a gap.\n")
allung = []
for n in (6, 8):
    allung += run(n)
if allung:
    lo = min(a[0] for a in allung)
    print("=" * 66)
    print(f"Smallest ungraded slack found anywhere: S = {lo:.9f}")
    print(f"Previously recorded smallest slack: 0.303691")
    print("A value near zero would refute the component separation;")
    print("a floor is evidence that the graded set is a union of components.")
