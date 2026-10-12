"""
Numerical verification of the FOX FIRST-ORDER PROTECTION LEMMA (plan.md C7).

Lemma. Let W be Fox's S^4(alpha) in its P-positive orientation, unit norm,
in any ambient dimension n >= 6. For every H in W_n with ||H||=1 and
<H,W>=0, the one-sided derivative of delta^2 = ||Alt(W_-)||^2 along H is

    d+ delta^2(H) = -2a * F(H),      a = 1/(3*sqrt(6)),
    F(H) = H_22 + H_33 + tr(Pi_ASD (P0 H P0)_-)  >=  (2/3)tr(B_+) + (1/3)tr(B_-)  >=  0,

where omega_1 (positive eigenvector), omega_2, omega_3 (negative
eigenvectors) span the self-dual 3-space of the distinguished R^4,
H_ii = <omega_i, H omega_i>, P0 is the projector onto ker(W), Pi_ASD the
projector onto the anti-self-dual 3-space of R^4, and B = Pi_ASD H Pi_ASD
(a 3x3 block). Consequently d+Phi <= 0 at Fox in every tangent direction
for every n >= 12 (kappa_n < 0), and d+Phi >= 0 in every direction with
F(H) > 0 for n <= 11 (kappa_n > 0) -- one lemma explains both the
protection and the observed n=8 escape.

Proof ingredients (each verified below):
  (i)   spectrum of W is (2, -1, -1, 0,...)/sqrt(6)  [trace-freeness forces 2:1],
  (ii)  Alt(W_-) = a * Star, Star = Pi_SD - Pi_ASD (the Hodge star of R^4,
        a genuine 4-form: T(i,j,k,l) = eps_{ijkl}), a = 1/(3 sqrt 6),
  (iii) the smooth branch of d(delta^2) is <G,H> with G = -2a*Pi_23
        (Daleckii-Krein; A diagonal in W's eigenbasis kills all rotation terms),
  (iv)  the kink branch is the zero-mode sliver 2<A,(P0 H P0)_->
        (first-order degenerate perturbation theory on the 0-eigenspace),
  (v)   Bianchi => <H, Star> = 0 => H_11+H_22+H_33 = tr(B),
  (vi)  tangency <H,W>=0 => 2 H_11 = H_22 + H_33,
  (vii) Jensen's trace inequality (Hansen-Pedersen, f(x)=x_-, f(0)=0):
        tr(Pi (X)_- Pi) >= tr((Pi X Pi)_-), giving the compression to B.
  (v)+(vi) => H_22+H_33 = (2/3) tr(B), and F >= (2/3)tr(B_+) + (1/3)tr(B_-).

Equality: F(H)=0  <=>  B=0 and (P0 H P0)_- has zero ASD-trace. The known
flat directions (O(n)-orbit, hyper-Kaehler subalgebra tangents) satisfy
exactly this, so the bound is sharp and the equality manifold is real.

This script verifies (i),(ii),(v) exactly, validates the full first-order
formula against one-sided finite differences on structured and random
directions, checks the inequality chain on every sample, and adversarially
minimizes F over the tangent Weyl sphere (multistart, including seeds
engineered to make B negative-definite -- the direction a violation would
need). Expected: min F ~ 0, never below -1e-8.
"""
import time
import numpy as np
from itertools import permutations
from scipy.optimize import minimize

from run_defect_penalty_test import setup, fox_weyl
from run_bianchi_defect import bianchi_defect, spectral_split, alt_mop
from run_bianchi_defect_highp_seed import project_to_x
from weyl_decomposition import frob, norm

A_EXACT = 1.0 / (3.0 * np.sqrt(6.0))


def star_operator(L2):
    """The Hodge star of the distinguished R^4 = span(e0..e3), embedded as a
    symmetric operator on Lambda^2 R^n: entries eps_{ijkl} on pairs within
    {0,1,2,3}, zero elsewhere. A genuine 4-form (totally antisymmetric)."""
    N = L2.N
    S = np.zeros((N, N))
    for p in permutations(range(4)):
        i, j, k, l = p
        if i < j and k < l:
            sgn = np.linalg.det(np.eye(4)[list(p)])
            S[L2.idx[(i, j)], L2.idx[(k, l)]] = sgn
    return S


def fox_frames(ctx):
    """Return (W, omega eigenvectors, P0, Pi_ASD, Star, a) with the sign of
    Star aligned so that Alt(W_-) = +a*Star."""
    L2, alt_idx, N = ctx["L2"], ctx["alt_idx"], ctx["N"]
    W = fox_weyl(ctx)
    w, V = np.linalg.eigh(W)
    tol = 1e-10
    i_pos = np.where(w > tol)[0]
    i_neg = np.where(w < -tol)[0]
    i_zero = np.where(np.abs(w) <= tol)[0]
    assert len(i_pos) == 1 and len(i_neg) == 2
    om1 = V[:, i_pos[0]]
    om2, om3 = V[:, i_neg[0]], V[:, i_neg[1]]
    P0 = V[:, i_zero] @ V[:, i_zero].T
    Star = star_operator(L2)
    A = alt_mop(spectral_split(W), alt_idx)
    sgn = np.sign(frob(A, Star))
    Star = sgn * Star
    Pi_SD = np.outer(om1, om1) + np.outer(om2, om2) + np.outer(om3, om3)
    Pi_L24 = 0.5 * (np.abs(Star) @ np.abs(Star) + np.diag(np.diag(np.abs(Star) @ np.abs(Star))))
    # cleaner: Lambda^2_4 projector = diag(1 on pairs within {0..3})
    Pi_L24 = np.zeros_like(Star)
    for (i, j), idx in L2.idx.items():
        if i < 4 and j < 4:
            Pi_L24[idx, idx] = 1.0
    Pi_ASD = 0.5 * (Pi_L24 - Star)
    return W, (om1, om2, om3), P0, Pi_ASD, Star, A, w


def F_value(H, om2, om3, P0, Pi_ASD):
    H22 = om2 @ H @ om2
    H33 = om3 @ H @ om3
    H00 = P0 @ H @ P0
    wH, VH = np.linalg.eigh(H00)
    neg = wH < 0
    Hm = (VH[:, neg] * (-wH[neg])) @ VH[:, neg].T
    return H22 + H33 + np.sum(Pi_ASD * Hm), H22 + H33


def B_block(H, Pi_ASD):
    M = Pi_ASD @ H @ Pi_ASD
    wB = np.linalg.eigvalsh(M)
    wB = wB[np.abs(wB) > 1e-13]
    return np.sum(wB[wB > 0]), -np.sum(wB[wB < 0])  # tr(B_+), tr(B_-)


def tangent_weyl(x, Eflat, N, xW):
    x = x - np.dot(x, xW) * xW
    x = x / np.linalg.norm(x)
    H = (x @ Eflat).reshape(N, N)
    return 0.5 * (H + H.T), x


def main(n=8, n_fd=14, n_min_restarts=40, seed=7):
    rng = np.random.default_rng(seed)
    ctx = setup(n)
    N, D, Eflat, alt_idx = ctx["N"], ctx["D"], ctx["Eflat"], ctx["alt_idx"]
    W, (om1, om2, om3), P0, Pi_ASD, Star, A, w = fox_frames(ctx)
    xW, _ = project_to_x(W, Eflat, N)

    print("=" * 78)
    print(f"INGREDIENTS (n={n})")
    print("=" * 78)
    mus = np.sort(w)[[0, 1, -1]]
    print(f"  (i)  spectrum: mu_+ = {np.max(w):.10f} (expect 2/sqrt6 = {2/np.sqrt(6):.10f}),")
    print(f"       mu_- = {-np.min(w):.10f} (expect 1/sqrt6 = {1/np.sqrt(6):.10f}), "
          f"#nonzero = {np.sum(np.abs(w) > 1e-10)}")
    err_ii = norm(A - A_EXACT * Star)
    print(f"  (ii) ||Alt(W_-) - a*Star|| = {err_ii:.2e}   (a = 1/(3 sqrt 6) = {A_EXACT:.10f})")
    alt_star = alt_mop(Star, alt_idx)
    print(f"       Star is a 4-form: ||Alt(Star)-Star|| = {norm(alt_star - Star):.2e}")
    # (v): Bianchi trace balance for random genuine Weyl H
    errs = []
    for _ in range(6):
        Hr, _ = tangent_weyl(rng.normal(size=D), Eflat, N, xW * 0.0)
        errs.append(abs(frob(Hr, Star)))
    print(f"  (v)  max |<H, Star>| over 6 random Weyl H = {max(errs):.2e}  (Bianchi => 0)")

    print()
    print("=" * 78)
    print(f"FIRST-ORDER FORMULA vs ONE-SIDED FINITE DIFFERENCES (n={n})")
    print("=" * 78)
    print("  d+ delta^2(H) predicted = -2a*F(H); slope measured at t=1e-6 (checked at 1e-5)")
    d0sq = bianchi_defect(W, alt_idx) ** 2
    worst_rel = 0.0
    rows = []
    # structured seeds: generic, ASD-negative-engineered, ASD-positive-engineered
    seeds = [("random", rng.normal(size=D)) for _ in range(n_fd - 4)]
    for lab, sgn in (("B<0 seed", -1.0), ("B>0 seed", +1.0)):
        for _ in range(2):
            u = rng.normal(size=3)
            M = np.zeros((N, N))
            asd_basis = np.linalg.svd(Pi_ASD)[0][:, :3]
            v = asd_basis @ (u / np.linalg.norm(u))
            M = sgn * np.outer(v, v)
            seeds.append((lab, Eflat @ M.reshape(-1)))
    for lab, x0 in seeds:
        H, _ = tangent_weyl(x0, Eflat, N, xW)
        Fv, _ = F_value(H, om2, om3, P0, Pi_ASD)
        pred = -2 * A_EXACT * Fv
        slopes = {}
        for t in (1e-6, 1e-5):
            Wp = W + t * H
            Wp = Wp / norm(Wp)
            slopes[t] = (bianchi_defect(Wp, alt_idx) ** 2 - d0sq) / t
        meas = slopes[1e-6]
        rel = abs(meas - pred) / max(abs(pred), 1e-6)
        worst_rel = max(worst_rel, rel)
        trBp, trBm = B_block(H, Pi_ASD)
        chain_ok = Fv >= (2 * trBp + trBm) / 3 - 1e-10
        rows.append((lab, Fv, pred, meas, rel, trBp, trBm, chain_ok))
    for lab, Fv, pred, meas, rel, trBp, trBm, chain_ok in rows:
        print(f"  {lab:10s} F={Fv:+.6f}  pred={pred:+.6f}  meas={meas:+.6f}  rel_err={rel:.1e}  "
              f"trB+={trBp:.4f} trB-={trBm:.4f}  chain F>=(2B+ + B-)/3: {'ok' if chain_ok else 'FAIL'}")
    print(f"  worst relative error: {worst_rel:.2e}")

    print()
    print("=" * 78)
    print(f"ADVERSARIAL MINIMIZATION OF F over the tangent Weyl sphere (n={n})")
    print("=" * 78)

    def obj(x):
        H, _ = tangent_weyl(x, Eflat, N, xW)
        return F_value(H, om2, om3, P0, Pi_ASD)[0]

    t0 = time.time()
    best = np.inf
    vals = []
    starts = [rng.normal(size=D) for _ in range(n_min_restarts - 8)]
    # engineered starts: push mass onto negative-definite ASD blocks
    asd_basis = np.linalg.svd(Pi_ASD)[0][:, :3]
    for k in range(8):
        u = rng.normal(size=(3, 3))
        Mneg = -asd_basis @ (u @ u.T) @ asd_basis.T
        starts.append(Eflat @ Mneg.reshape(-1) + 0.05 * rng.normal(size=D))
    for x0 in starts:
        res = minimize(obj, x0, method="Nelder-Mead",
                       options=dict(maxiter=4000, xatol=1e-10, fatol=1e-12))
        vals.append(res.fun)
        best = min(best, res.fun)
    print(f"  {len(starts)} restarts in {time.time()-t0:.1f}s: min F = {best:+.3e}, "
          f"median = {np.median(vals):+.3e}")
    print(f"  VERDICT: {'LEMMA CONSISTENT (min F >= -1e-8)' if best >= -1e-8 else 'VIOLATION FOUND'}")


if __name__ == "__main__":
    import sys
    main(n=int(sys.argv[1]) if len(sys.argv) > 1 else 8)
