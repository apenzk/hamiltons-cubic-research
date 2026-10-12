"""
Lifting Jaeger's §3.3 off the diagonal locus, in trace form (plan.md C7 /
Track C step 1 of the analytic program).

Background (FINDINGS "Reading Jaeger's diagonal-case proof", REVIEW Reviewer 6):
the spectral compressions of the criticality equation give, at every critical
point theta*W = W^2 + W^#, the EXACT operator identity

    theta*|W| = |W|^2 + |W|^# - 2 W_-^2 - X_inv,
    X_inv := |W|^# - P_+ W^# P_+ + P_- W^# P_-,

which reduces to Jaeger's Lemma 3.2.1 on the diagonal locus (where X_inv = X >= 0).
Off-diagonal, X_inv >= 0 is FALSE (REVIEW), but Lemma 3.3.4 -- the workhorse of
§3.3 -- only ever uses the Ric(|W|)-contraction of this identity. Contracting and
splitting <Ric(|W|^2+|W|^#), Ric> by the defect-corrected identity (1.5)
[Ric(R^2+R^#) = R.Ric(R) for Bianchi R; general R carries a correction D(R) with
tr D(R) = 6||Alt(R)||^2], and using Jaeger's exact e-decomposition
|W| = sqrt(1-e^2)/||Ric^Ric|| * Ric^Ric + E and his Lemma 3.3.3, one gets the
EXACT scalar identity at every critical point:

  (**)  theta*r^2 = sqrt(2)*r^2*sqrt(1-tr S^4)*sqrt(1-e^2)
                    - 2<Ric(W_-^2), Ric>  +  J4  -  J5,

  J4 := <D(|W|), Ric> = <Ric(|W|^2+|W|^#) - |W|.Ric, Ric>,
  J5 := <Ric(X_inv), Ric>,

with Ric := Ric(|W|), r = ||Ric||, S = Ric/r. Jaeger's diagonal Lemma 3.3.4 is
exactly the statement J4 = 0 (|W| stays Bianchi) and J5 >= 0 (X >= 0). The
lifted §3.3 therefore holds verbatim wherever J4 - J5 <= 0, and the TRACE-FORM
GRANT replacing the refuted operator positivity is just J5 >= 0.

This script:
  PART 0 validates the two convention-dependent identities against the repo's
         machinery: (1.5) for random Bianchi R (residual ~0) and the defect
         trace tr[Ric(R^2+R^#) - R.Ric(R)] = 6||Alt R||^2 for random symmetric R.
  PART 1 computes every term of (**) at each catalogued critical point
         (sphere products incl. a randomly rotated frame, Fox S^4(alpha), SU(3),
         QK HP^2, and ascent-found generic critical points at n=6), checks (**)
         to machine precision (a strong self-test: it is exact at critical
         points), and tabulates J4, J5, J4-J5 against delta^2.
  PART 2 summarizes: does the trace-form grant J5 >= 0 hold? What sign and
         delta^2-scaling does J4 - J5 have? (J4 vanishes with delta -- |W| is
         Bianchi iff delta = 0 -- so any defect-penalized lifted 3.3.4 must
         control J4 - J5 by delta^2 terms.)
"""
import time
import numpy as np

from run_defect_penalty_test import setup, fox_weyl, sphere_weyl, qk_weyl
from run_bianchi_defect import bianchi_defect, spectral_split, alt_mop
from run_bianchi_defect_highp_seed import build_su3_n8
from run_vertex_bound import random_weyl_basis, mop_to_tensor4, rotate_tensor4, random_orthogonal
from run_unconstrained_search import build_weyl_basis as buildwb_search, run_search, cluster_by_value
from weyl import build_structure_constants, vec_to_mat
from weyl_decomposition import ricci_from_mop, mop_from_4tensor, norm, frob
from rsharp_basis_free import Q_full


def ric_of(L2, Mop):
    return ricci_from_mop(L2, Mop)


def dot_contract(L2, Mop, h):
    """(R.h)_ij = sum_{k,l} h_kl T_R(k,i,l,j) -- identity (1.5)'s right side in
    the repo's tensor convention (T(i,j,i,j) = diagonal entries, so the diagonal
    case gives (R.Ric)_ii = sum_k lambda_k T(k,i,k,i) = sum_k w_ki lambda_k)."""
    T = mop_to_tensor4(L2, Mop)
    return np.einsum('kl,kilj->ij', h, T)


def sharp_of(Mop, c):
    return Q_full(Mop, c) - Mop @ Mop


def ric_wedge(h):
    """(h^h) as 4-tensor T(i,j,k,l) = h_ik h_jl - h_il h_jk, returned as callable."""
    def T(i, j, k, l):
        return h[i, k] * h[j, l] - h[i, l] * h[j, k]
    return T


def spectral_parts(Wmat, tol=1e-10):
    w, V = np.linalg.eigh(Wmat)
    Pp = (V[:, w > tol]) @ (V[:, w > tol]).T
    Pm = (V[:, w < -tol]) @ (V[:, w < -tol]).T
    Wp = (V[:, w > tol] * w[w > tol]) @ (V[:, w > tol]).T
    Wm = -(V[:, w < -tol] * w[w < -tol]) @ (V[:, w < -tol]).T
    return Wp, Wm, Pp, Pm


def analyze_point(label, Wn, ctx, c, out):
    """All terms of (**) at one (near-)critical point Wn (unit norm)."""
    L2, alt_idx, N, n = ctx["L2"], ctx["alt_idx"], ctx["N"], ctx["n"]
    Q = Q_full(Wn, c)
    theta = frob(Wn, Q)
    resid = norm(Q - theta * Wn) / norm(Q)
    Wp, Wm, Pp, Pm = spectral_parts(Wn)
    absW = Wp + Wm
    delta2 = bianchi_defect(Wn, alt_idx) ** 2

    Ric = ric_of(L2, absW)
    r2 = frob(Ric, Ric)
    scal = np.trace(Ric)
    if r2 < 1e-14:
        print(f"  {label:32s} n={n} theta={theta:+.6f} resid={resid:.1e}  Ric(|W|)=0, identity vacuous")
        return
    S = Ric / np.sqrt(r2)
    trS4 = np.trace(np.linalg.matrix_power(S, 4))

    RwR = mop_from_4tensor(L2, ric_wedge(Ric))
    nRwR = norm(RwR)
    sq1me2 = frob(absW, RwR) / nRwR if nRwR > 1e-14 else 0.0  # = sqrt(1-e^2), exact

    Wsharp = sharp_of(Wn, c)
    absWsharp = sharp_of(absW, c)
    Xinv = absWsharp - Pp @ Wsharp @ Pp + Pm @ Wsharp @ Pm

    QabsW = absW @ absW + absWsharp
    J4 = frob(ric_of(L2, QabsW) - dot_contract(L2, absW, Ric), Ric)
    J5 = frob(ric_of(L2, Xinv), Ric)
    Jmain = np.sqrt(2.0) * r2 * np.sqrt(max(1 - trS4, 0)) * sq1me2
    Jneg = 2.0 * frob(ric_of(L2, Wm @ Wm), Ric)

    lhs = theta * r2
    rhs = Jmain - Jneg + J4 - J5
    id_resid = abs(lhs - rhs) / max(abs(lhs), 1e-10)
    ok334 = J4 - J5 <= 1e-10  # lifted Lemma 3.3.4 holds iff this
    print(f"  {label:32s} n={n} theta={theta:+.6f} resid={resid:.1e} id_resid={id_resid:.1e}\n"
          f"      r2={r2:.6f} scal={scal:.6f} delta^2={delta2:.6f}  "
          f"J4={J4:+.6f} J5={J5:+.6f} J4-J5={J4-J5:+.6f}  "
          f"[grant J5>=0: {'ok' if J5 >= -1e-10 else 'FAIL'}; lifted 3.3.4: {'ok' if ok334 else 'FAIL'}]")
    out.append(dict(label=label, n=n, theta=theta, resid=resid, id_resid=id_resid,
                    r2=r2, scal=scal, delta2=delta2, J4=J4, J5=J5))


def validate_conventions(n=6, seed=0):
    print("=" * 78)
    print("PART 0: convention validation of (1.5) and the defect trace")
    print("=" * 78)
    rng = np.random.default_rng(seed)
    ctx = setup(n, verbose=False)
    L2, alt_idx, N = ctx["L2"], ctx["alt_idx"], ctx["N"]
    idx, pos, N2, c = build_structure_constants(n)
    # Bianchi R WITH NONZERO RICCI (a Weyl-only sample makes (1.5) vacuous, 0=0):
    # h^h is Bianchi for any symmetric h, plus a random Weyl part
    weyl_basis, triu_idx, N3 = random_weyl_basis(n)
    for k in range(3):
        h = rng.normal(size=(n, n)); h = 0.5 * (h + h.T)
        Rw = vec_to_mat(weyl_basis @ rng.normal(size=weyl_basis.shape[1]), triu_idx, N3)
        R = mop_from_4tensor(L2, ric_wedge(h)) + Rw
        R = R / norm(R)
        lhsm = ric_of(L2, R @ R + sharp_of(R, c))
        rhsm = dot_contract(L2, R, ric_of(L2, R))
        print(f"  Bianchi R #{k}: ||Ric(R^2+R^#) - R.Ric(R)|| = {norm(lhsm - rhsm):.2e}  (expect 0)")
    for k in range(3):
        A = rng.normal(size=(N, N)); A = 0.5 * (A + A.T); A = A / norm(A)
        lhsm = ric_of(L2, A @ A + sharp_of(A, c))
        rhsm = dot_contract(L2, A, ric_of(L2, A))
        altn2 = frob(alt_mop(A, alt_idx), alt_mop(A, alt_idx))
        ratio = np.trace(lhsm - rhsm) / altn2
        print(f"  generic R #{k}: tr[D(R)]/||Alt R||^2 = {ratio:.8f}  (expect 6)")


def main():
    validate_conventions()
    out = []
    print()
    print("=" * 78)
    print("PART 1: the exact identity (**) and the terms J4, J5 at critical points")
    print("=" * 78)
    rng = np.random.default_rng(11)

    for n in (6, 8):
        ctx = setup(n, verbose=False)
        idx, pos, N2, c = build_structure_constants(n)
        print(f"\n  -- n={n} --")
        for p in range(2, n // 2 + 1):
            analyze_point(f"sphere ({p},{n-p})", sphere_weyl(ctx, p), ctx, c, out)
        # rotated sphere product: everything in (**) is spectral, so identical values
        L2 = ctx["L2"]
        T = mop_to_tensor4(L2, sphere_weyl(ctx, n // 2))
        O = random_orthogonal(n, rng)
        Wrot = mop_from_4tensor(L2, lambda i, j, k, l, Tr=rotate_tensor4(T, O): Tr[i, j, k, l])
        analyze_point(f"sphere ({n//2},{n//2}) rotated", Wrot / norm(Wrot), ctx, c, out)
        analyze_point("Fox S^4(alpha)", fox_weyl(ctx), ctx, c, out)
        if n == 8:
            _, Wsu3 = build_su3_n8()
            analyze_point("SU(3) bi-invariant", Wsu3, ctx, c, out)
            analyze_point("QK HP^2", qk_weyl(ctx, 2), ctx, c, out)

    # generic ascent-found critical points at n=6 (includes low-theta ones)
    print("\n  -- n=6 ascent-found critical points (generic, incl. low theta) --")
    n = 6
    ctx = setup(n, verbose=False)
    idx, pos, N2, c = build_structure_constants(n)
    Eflat, D = buildwb_search(n, idx, pos, N2, c, verbose=False)
    results = run_search(n, idx, pos, N2, c, Eflat, D, n_restarts=40, seed=1234)
    clusters, bad = cluster_by_value(results)
    for ci, cl in enumerate(clusters[:8]):
        rep = cl["members"][0]
        Wmat = (rep["x"] @ Eflat).reshape(N2, N2)
        Wmat = 0.5 * (Wmat + Wmat.T)
        analyze_point(f"ascent cluster {ci}", Wmat / norm(Wmat), ctx, c, out)

    print()
    print("=" * 78)
    print("PART 2: summary")
    print("=" * 78)
    ok = [o for o in out if o["resid"] < 1e-5]
    worst_id = max(o["id_resid"] for o in ok)
    print(f"  critical points analyzed: {len(ok)} (identity (**) worst residual: {worst_id:.1e})")
    minJ5 = min(o["J5"] for o in ok)
    print(f"  trace-form grant J5 >= 0: min J5 = {minJ5:+.6f}  "
          f"{'HOLDS at every point' if minJ5 >= -1e-10 else 'FAILS'}")
    viol = [o for o in ok if o["J4"] - o["J5"] > 1e-10]
    print(f"  lifted Lemma 3.3.4 (J4 - J5 <= 0): holds at {len(ok)-len(viol)}/{len(ok)} points")
    for o in viol:
        print(f"    excess at {o['label']}: J4-J5 = {o['J4']-o['J5']:+.6f}  delta^2 = {o['delta2']:.6f}  "
              f"ratio (J4-J5)/(delta^2*scal) = {(o['J4']-o['J5'])/(o['delta2']*o['scal'] + 1e-300):+.4f}")
    zd = [o for o in ok if o["delta2"] < 1e-12]
    print(f"  zero-defect points: J4 = 0 as predicted at {sum(1 for o in zd if abs(o['J4'])<1e-10)}/{len(zd)}")


if __name__ == "__main__":
    main()
