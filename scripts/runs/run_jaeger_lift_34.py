"""
Lifting Jaeger's SS3.4 off the diagonal locus (plan.md C8, open item iii).

Finding (a): his Lemma 3.4.1 pairing <., A ^ 2 id> is Bianchi-dependent, but
replacing it with the exact adjoint K = Ric*(Ric(|W|)) (run_j5_structure.
ric_adjoint) makes the Lemma 3.4.2 decomposition

    -2<Ric(W_-^2), Ric> = -sqrt(1-e^2)/||Ric^Ric|| * T1 + T2,
    T1 = 2 tr(W_- (Ric^Ric) K),   T2 = -2 tr(W_- E K),

an EXACT identity off-diagonal (W_- W_+ = 0 kills the only cross term, since
W_-|W| = W_-^2).

Finding (b): Lemma 3.4.3's lower bound
    T1 >= n*lam^4 + lam^2 (2-eps) r0^2 - lam (1+eps) tr(Ric0^3),
lam = scal(|W|)/n, eps = (sqrt(10)-3)/2, holds OFF-DIAGONAL with no defect
correction: margin exactly 0 at the balanced spheres, SU(3), and QK HP^2
(sharp), strictly positive at every other catalogued critical point and at
300 random unit Weyl tensors (n=6). Unlike SS3.3, this segment costs nothing.

Untested: SS3.4.2's T2 estimate (Lemma 3.4.7, which invokes Assumption 2).
"""
import numpy as np
from run_defect_penalty_test import setup, fox_weyl, sphere_weyl, qk_weyl
from run_bianchi_defect_highp_seed import build_su3_n8
from run_jaeger_lift_33 import spectral_parts, ric_of, ric_wedge
from run_j5_structure import ric_adjoint
from run_vertex_bound import random_weyl_basis
from weyl import build_structure_constants, vec_to_mat
from weyl_decomposition import norm, frob, mop_from_4tensor

EPS = (np.sqrt(10) - 3) / 2


def t1_terms(Wn, ctx):
    L2, n = ctx["L2"], ctx["n"]
    Wp, Wm, Pp, Pm = spectral_parts(Wn)
    absW = Wp + Wm
    h = ric_of(L2, absW)
    if norm(h) < 1e-12:
        return None
    scal = np.trace(h)
    lam = scal / n
    h0 = h - lam * np.eye(n)
    r02 = frob(h0, h0)
    trh03 = np.trace(h0 @ h0 @ h0)
    K = ric_adjoint(L2, h)
    RwR = mop_from_4tensor(L2, ric_wedge(h))
    nRwR = norm(RwR)
    sq1me2 = frob(absW, RwR) / nRwR
    E = absW - sq1me2 / nRwR * RwR
    lhs = -2 * frob(ric_of(L2, Wm @ Wm), h)
    T1 = 2 * np.trace(Wm @ RwR @ K)
    T2 = -2 * np.trace(Wm @ E @ K)
    id_res = abs(lhs - (-sq1me2 / nRwR * T1 + T2)) / max(abs(lhs), 1e-12)
    rhs343 = n * lam ** 4 + lam ** 2 * (2 - EPS) * r02 - lam * (1 + EPS) * trh03
    return id_res, T1, rhs343


def main():
    worst = np.inf
    for n in (6, 8):
        ctx = setup(n, verbose=False)
        print(f"-- n={n} critical points --")
        pts = [(f"sphere ({p},{n-p})", sphere_weyl(ctx, p)) for p in range(2, n // 2 + 1)]
        pts.append(("Fox S^4(alpha)", fox_weyl(ctx)))
        if n == 8:
            pts.append(("SU(3)", build_su3_n8()[1]))
            pts.append(("QK HP^2", qk_weyl(ctx, 2)))
        for label, Wn in pts:
            r = t1_terms(Wn, ctx)
            if r is None:
                continue
            id_res, T1, rhs = r
            worst = min(worst, T1 - rhs)
            flag = "  <-- 3.4.3 FAILS" if T1 < rhs - 1e-9 else ""
            print(f"  {label:24s} 3.4.2_id_res={id_res:.0e}  T1={T1:+.6f}  "
                  f"rhs={rhs:+.6f}  margin={T1-rhs:+.6f}{flag}")

    print("-- 300 random unit Weyl tensors, n=6 --")
    ctx = setup(6, verbose=False)
    weyl_basis, triu_idx, N2 = random_weyl_basis(6)
    rng = np.random.default_rng(1)
    worst_rand = np.inf
    for _ in range(300):
        W = vec_to_mat(weyl_basis @ rng.normal(size=weyl_basis.shape[1]), triu_idx, N2)
        r = t1_terms(W / norm(W), ctx)
        if r is not None:
            worst_rand = min(worst_rand, r[1] - r[2])
    print(f"worst margin, critical points: {worst:+.6f}")
    print(f"worst margin, random Weyl:     {worst_rand:+.6f}")


def part2_342(ns=(6, 8)):
    """SS3.4.2's W-dependent skeleton: Lemma 3.4.8 (T2 <= X - <K,E^2>), the
    invariant fact ||WK|| = |||W|K|| (W^2=|W|^2), and the exact ||WK||^2
    expansion from Lemma 3.4.11's proof. All at catalogued critical points."""
    from run_defect_penalty_test import qk_weyl
    from run_bianchi_defect_highp_seed import build_su3_n8
    for n in ns:
        ctx = setup(n, verbose=False)
        print(f"-- n={n} (part 2: SS3.4.2 skeleton) --")
        pts = [(f"sphere ({p},{n-p})", sphere_weyl(ctx, p)) for p in range(2, n // 2 + 1)]
        pts.append(("Fox S^4(alpha)", fox_weyl(ctx)))
        if n == 8:
            pts.append(("SU(3)", build_su3_n8()[1]))
            pts.append(("QK HP^2", qk_weyl(ctx, 2)))
        for label, Wn in pts:
            L2 = ctx["L2"]
            Wp, Wm, Pp, Pm = spectral_parts(Wn)
            absW = Wp + Wm
            h = ric_of(L2, absW)
            if norm(h) < 1e-12:
                continue
            K = ric_adjoint(L2, h)
            RwR = mop_from_4tensor(L2, ric_wedge(h))
            nR = norm(RwR)
            sq = frob(absW, RwR) / nR
            E = absW - sq / nR * RwR
            e = norm(E)
            T2 = -2 * np.trace(Wm @ E @ K)
            X = e * norm(Wn @ K) - sq / nR * np.trace(RwR @ K @ E)
            m348 = (X - np.trace(K @ E @ E)) - T2
            eqnorm = abs(norm(Wn @ K) - norm(absW @ K))
            lhs = norm(Wn @ K) ** 2
            rhs = sq**2 / nR**2 * norm(RwR @ K) ** 2 + norm(E @ K) ** 2 \
                  + 2 * sq / nR * np.trace(E @ RwR @ K @ K)
            print(f"  {label:24s} 3.4.8 margin={m348:+.6f}  ||WK||=|||W|K|| err={eqnorm:.0e}  "
                  f"expansion_res={abs(lhs-rhs)/max(lhs,1e-12):.0e}")


if __name__ == "__main__":
    main()
    part2_342()
