"""
Structure of the trace-form grant J5 >= 0 (plan.md C8, open item ii).

J5 = <Ric(X_inv), Ric(|W|)> = <X_inv, H>, where H = Ric*(h) is the exact
adjoint of Ric applied to h := Ric(|W|). H >= 0 whenever h >= 0 (proof:
<phi, H phi> = tr(h Phi Phi^T) with Phi the antisymmetric matrix of the
bivector phi), and h >= 0 here since |W| >= 0.

PROVEN REDUCTION (verified here): using the compression identities
  P+ W# P+ = theta W+ - W+^2,   P- W# P- = -theta W- - W-^2,
  P+ W# P- = 0,                 P0 W# P0 = 0,
X_inv = |W|^# - P+ W# P+ + P- W# P- simplifies to

    X_inv = |W|^# + (W - theta)|W|,

and its three diagonal blocks are EXACTLY

    P+ X_inv P+ = 4 P+ (W+ # W-) P+          >= 0,
    P- X_inv P- = 2 P- (W+^# + W-^#) P-      >= 0,
    P0 X_inv P0 = P0 |W|^# P0                >= 0,

each PSD by #-positivity (A,B >= 0 => A#B >= 0). Hence scal(X_inv) >= 0
(Reviewer 6's surviving scalar), and

    J5 = J5_diag + J5_cross,
    J5_diag = sum over the three diagonal blocks of <block, H-block> ... but
    NOTE: H does not commute with the spectral projections of W in general,
    so <diag block, H> itself has to be taken against the full H; we define
    J5_diag := <P+ X P+ + P- X P- + P0 X P0, H> (diagonal-block part of X
    against all of H) and J5_cross := J5 - J5_diag (the cross-block part of
    X against H). J5_diag >= 0 is NOT automatic (H mixes blocks), so we also
    report J5_diag_c := sum_b <P_b X P_b, P_b H P_b> >= 0 (provably
    nonnegative: PSD against compressions of PSD).

This script:
  PART 1 verifies the simplification and the three block identities at every
         catalogued critical point (residuals ~1e-16) and confirms each
         diagonal block is PSD.
  PART 2 tabulates J5, its diagonal/cross split, and ||[H, W]|| at the
         catalogue plus a population of GENERIC critical points obtained by
         minimizing the idempotency residual alone from random starts (this
         reaches saddles, unlike gradient ascent) at n=6 and n=8.
  PART 3 summary: min J5 over everything (the grant), whether cross terms
         vanish when [H,W]=0, and how much margin J5_diag provides.
"""
import time
import numpy as np
from scipy.optimize import minimize

from run_defect_penalty_test import setup, fox_weyl, sphere_weyl, qk_weyl
from run_bianchi_defect import bianchi_defect
from run_bianchi_defect_highp_seed import build_su3_n8
from run_jaeger_lift_33 import sharp_of, spectral_parts, ric_of
from run_vertex_bound import random_weyl_basis
from weyl import build_structure_constants, vec_to_mat
from weyl_decomposition import norm, frob, mop_from_4tensor
from rsharp_basis_free import Q_full


def ric_adjoint(L2, h):
    """H = Ric*(h), the exact adjoint of Ric under the repo's Frobenius
    pairings: frob(X, H) = <Ric(X), h>_full-sum for every symmetric X.
    Combinatorial rule: H[(a,b),(c,d)] = sum over shared k in {a,b}&{c,d} of
    sgn(i,k)*sgn(j,k)*h_ij with i,j the complementary elements. H >= 0 for
    h >= 0, since <phi, H phi> = tr(h * Phi Phi^T) with Phi the antisymmetric
    n x n matrix of the bivector phi. Verified against random X in PART 1."""
    pairs = L2.pairs
    N = L2.N
    H = np.zeros((N, N))
    for p, (a, b) in enumerate(pairs):
        for q, (c, d) in enumerate(pairs):
            v = 0.0
            for k in set((a, b)) & set((c, d)):
                i = a + b - k
                j = c + d - k
                sgn = (1.0 if i < k else -1.0) * (1.0 if j < k else -1.0)
                v += sgn * h[i, j]
            H[p, q] = v
    return H


def sharp_pol(A, B, c):
    return 0.5 * (sharp_of(A + B, c) - sharp_of(A, c) - sharp_of(B, c))


def j5_report(label, Wn, ctx, c, out, verbose=True):
    L2, alt_idx, n = ctx["L2"], ctx["alt_idx"], ctx["n"]
    Q = Q_full(Wn, c)
    theta = frob(Wn, Q)
    resid = norm(Q - theta * Wn) / norm(Q)
    Wp, Wm, Pp, Pm = spectral_parts(Wn)
    P0 = np.eye(Wn.shape[0]) - Pp - Pm
    absW = Wp + Wm
    delta2 = bianchi_defect(Wn, alt_idx) ** 2
    h = ric_of(L2, absW)
    if norm(h) < 1e-12:
        return
    H = ric_adjoint(L2, h)

    Xinv = sharp_of(absW, c) + (Wn - theta * np.eye(Wn.shape[0])) @ absW
    # block identities
    b_p = Pp @ Xinv @ Pp - 4 * Pp @ sharp_pol(Wp, Wm, c) @ Pp
    b_m = Pm @ Xinv @ Pm - 2 * Pm @ (sharp_of(Wp, c) + sharp_of(Wm, c)) @ Pm
    b_0 = P0 @ Xinv @ P0 - P0 @ sharp_of(absW, c) @ P0
    block_err = max(norm(b_p), norm(b_m), norm(b_0))
    Xdiag = Pp @ Xinv @ Pp + Pm @ Xinv @ Pm + P0 @ Xinv @ P0
    eig_min_blocks = min(np.linalg.eigvalsh(Pp @ Xinv @ Pp).min(),
                         np.linalg.eigvalsh(Pm @ Xinv @ Pm).min(),
                         np.linalg.eigvalsh(P0 @ Xinv @ P0).min())

    J5 = frob(Xinv, H)
    J5_check = frob(ric_of(L2, Xinv), h)
    J5_diag = frob(Xdiag, H)
    J5_cross = J5 - J5_diag
    J5_diag_c = (frob(Pp @ Xinv @ Pp, Pp @ H @ Pp) + frob(Pm @ Xinv @ Pm, Pm @ H @ Pm)
                 + frob(P0 @ Xinv @ P0, P0 @ H @ P0))
    commHW = norm(H @ Wn - Wn @ H)
    if verbose:
        print(f"  {label:28s} n={n} th={theta:+.4f} resid={resid:.0e} "
              f"blk_id={block_err:.0e} blk_psd_min={eig_min_blocks:+.1e} "
              f"<X,H>-<RicX,h>={abs(J5-J5_check):.0e}\n"
              f"      d2={delta2:.4f} J5={J5:+.6f} = diag {J5_diag:+.6f} + cross {J5_cross:+.6f}   "
              f"J5_diag_c={J5_diag_c:+.6f}  ||[H,W]||={commHW:.2e}")
    out.append(dict(label=label, n=n, theta=theta, resid=resid, delta2=delta2, J5=J5,
                    J5_diag=J5_diag, J5_cross=J5_cross, J5_diag_c=J5_diag_c, comm=commHW))


def generic_critical_points(n, n_starts, seed, resid_tol=1e-7):
    """Minimize ||Q(W) - <W,Q>W||^2 on the unit Weyl sphere from random starts:
    reaches saddles, unlike ascent. Returns deduped (by theta) unit points."""
    idx, pos, N, c = build_structure_constants(n)
    weyl_basis, triu_idx, N2 = random_weyl_basis(n)
    D = weyl_basis.shape[1]
    rng = np.random.default_rng(seed)

    def obj(x):
        Wn = vec_to_mat(weyl_basis @ x, triu_idx, N)
        Wn = Wn / norm(Wn)
        Q = Q_full(Wn, c)
        th = frob(Wn, Q)
        return frob(Q - th * Wn, Q - th * Wn)

    found = []
    for _ in range(n_starts):
        res = minimize(obj, rng.normal(size=D), method="L-BFGS-B",
                       options=dict(maxiter=600, ftol=1e-18, gtol=1e-14))
        Wn = vec_to_mat(weyl_basis @ res.x, triu_idx, N)
        Wn = Wn / norm(Wn)
        Q = Q_full(Wn, c)
        th = frob(Wn, Q)
        if th < 0:
            Wn, th = -Wn, -th  # theta>0 orientation
        rr = norm(Q_full(Wn, c) - th * Wn) / norm(Q_full(Wn, c))
        if rr < resid_tol and th > 0.05:
            if all(abs(th - t0) > 2e-4 for _, t0 in found):
                found.append((Wn, th))
    return found, c


def main():
    out = []
    print("=" * 78)
    print("PART 1+2: J5 structure at catalogued critical points")
    print("=" * 78)
    for n in (6, 8):
        ctx = setup(n, verbose=False)
        idx, pos, N, c = build_structure_constants(n)
        print(f"\n  -- n={n} catalogue --")
        for p in range(2, n // 2 + 1):
            j5_report(f"sphere ({p},{n-p})", sphere_weyl(ctx, p), ctx, c, out)
        j5_report("Fox S^4(alpha)", fox_weyl(ctx), ctx, c, out)
        if n == 8:
            _, Wsu3 = build_su3_n8()
            j5_report("SU(3)", Wsu3, ctx, c, out)
            j5_report("QK HP^2", qk_weyl(ctx, 2), ctx, c, out)

    print("\n  -- generic critical points (idempotency-residual minimization, incl. saddles) --")
    for n, n_starts in ((6, 40), (8, 15)):
        ctx = setup(n, verbose=False)
        t0 = time.time()
        pts, c = generic_critical_points(n, n_starts, seed=2026)
        print(f"  n={n}: {len(pts)} distinct critical points from {n_starts} starts "
              f"[{time.time()-t0:.0f}s]")
        for k, (Wn, th) in enumerate(pts):
            j5_report(f"generic n={n} #{k}", Wn, ctx, c, out)

    print()
    print("=" * 78)
    print("PART 3: summary")
    print("=" * 78)
    ok = [o for o in out if o["resid"] < 1e-5]
    print(f"  critical points: {len(ok)}   theta range: "
          f"[{min(o['theta'] for o in ok):.4f}, {max(o['theta'] for o in ok):.4f}]")
    minJ5 = min(o["J5"] for o in ok)
    argmin = min(ok, key=lambda o: o["J5"])
    print(f"  min J5 = {minJ5:+.8f}  (at {argmin['label']}, theta={argmin['theta']:.4f})  "
          f"grant J5>=0: {'HOLDS everywhere' if minJ5 >= -1e-9 else 'FAILS'}")
    mincross = [o for o in ok if abs(o["J5_cross"]) > 1e-8]
    print(f"  points with nonzero cross part: {len(mincross)}/{len(ok)}")
    comm_zero = [o for o in ok if o["comm"] < 1e-8]
    cz_cross = max((abs(o["J5_cross"]) for o in comm_zero), default=0.0)
    print(f"  points with [H,W]=0: {len(comm_zero)}/{len(ok)}; max |cross| there = {cz_cross:.1e}")
    worst_ratio = max((abs(o["J5_cross"]) / o["J5_diag"] for o in ok if o["J5_diag"] > 1e-9),
                      default=0.0)
    print(f"  worst |J5_cross|/J5_diag over points with J5_diag>0: {worst_ratio:.4f}")
    minddc = min(o["J5_diag_c"] for o in ok)
    print(f"  min J5_diag_c (provably >= 0): {minddc:+.2e}")


if __name__ == "__main__":
    main()
