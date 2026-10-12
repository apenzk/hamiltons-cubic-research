"""
Lifting Jaeger's SS3.6 endgame, and locating what the whole lifted chain
still needs (plan.md C8 item iii, final segment).

SS3.6 turns "scal(|W|) >= (n+1)*tt0(n)" into "W is the sphere product". Its
setup is frame-free: Notation 3.6.1 decomposes |W| = sqrt(1-a^2-b^2) I/||I||
+ a W + b X with ||X||=1, X ⊥ W, X ⊥ I -- an orthogonal decomposition of
operators, no basis anywhere. Lemma 3.6.2 is norm/trace algebra using only
tr W = 0, Ric(W) = 0, scal(X) = <X,I> = 0; Lemma 3.6.3 (a^2+b^2 <= 3/(n(n-2)))
uses only those plus Lemma 3.5.6. Both lift verbatim. From Lemma 3.6.4 on,
the section consumes Lemma 3.2.2, which off-diagonal carries the known
+24||Alt(W_-)||^2 correction -- so the defect re-enters there and nowhere else.

This script tabulates, at every catalogued critical point: theta vs theta_0
(Jaeger's Assumption 1), the SS3.6 coordinates a, b, whether Lemma 3.6.3 and
Lemma 3.5.6 hold, and the Bianchi defect. The table shows the architecture:

  * Assumption 1 is satisfied by exactly the BALANCED sphere product at every
    n -- plus Fox's S^4(alpha) at n = 6, 8, but NOT at n = 12, where the
    crossover has already pushed theta_0(12) = 1.2360 above Fox's 1.2247.
  * At every A1 point with zero defect, 3.5.6 and 3.6.3 both hold.
  * At Fox (A1 satisfied, delta^2 = 1/9) both fail massively -- scal = 3.27
    against a required 10.25 at n = 8, and a^2+b^2 = 0.90 against 0.0625.
    So the defect is not a marginal correction at the one point where the
    diagonal theorem is false off-diagonal; it is the whole discrepancy.

Consequence for the remaining gap. The lifted chain reads

   critical, theta >= theta_0(n), defect small  ==>  scal large  ==>  W = S^m x S^m,

so what is missing is exactly: NO CRITICAL POINT HAS BOTH theta >= theta_0(n)
AND LARGE DEFECT. That is a strictly weaker, purely qualitative form of the
defect-penalty conjecture -- it is needed only above the threshold and only
for defects above the explicit c(n), not as the sharp inequality for all W.
"""
import numpy as np
from run_defect_penalty_test import setup, fox_weyl, sphere_weyl, qk_weyl
from run_bianchi_defect import bianchi_defect
from run_bianchi_defect_highp_seed import build_su3_n8
from run_jaeger_lift_33 import spectral_parts, ric_of
from weyl_decomposition import norm, frob
from rsharp_basis_free import Q_full
from weyl import build_structure_constants


def theta0(n):
    return np.sqrt(2 * (n - 1) * (n - 2)) / n


def theta_tilde0(n):
    return np.sqrt(2 * (n - 1) * (n - 3) / ((n + 1) * (n - 2)))


def main(ns=(6, 8, 12)):
    print(f"{'point':24s} {'n':>2} {'theta':>8} {'th0':>7} {'A1?':>4} {'a':>8} {'b':>8} "
          f"{'a2+b2':>8} {'bound':>8} {'3.6.3':>6} {'scal':>7} {'need':>7} {'3.5.6':>6} {'d2':>7}")
    for n in ns:
        ctx = setup(n, verbose=False)
        idx, pos, N, c = build_structure_constants(n)
        L2, alt_idx = ctx["L2"], ctx["alt_idx"]
        pts = [(f"sphere ({p},{n-p})", sphere_weyl(ctx, p)) for p in range(2, n // 2 + 1)]
        pts.append(("Fox S^4(alpha)", fox_weyl(ctx)))
        if n == 8:
            pts += [("SU(3)", build_su3_n8()[1]), ("QK HP^2", qk_weyl(ctx, 2))]
        for label, W in pts:
            theta = frob(W, Q_full(W, c))
            Wp, Wm, Pp, Pm = spectral_parts(W)
            absW = Wp + Wm
            I = np.eye(N)
            nI = norm(I)
            a = frob(absW, W)
            X_rem = absW - (frob(absW, I) / nI) * I / nI - a * W
            b = norm(X_rem)
            scal = np.trace(ric_of(L2, absW))
            d2 = bianchi_defect(W, alt_idx) ** 2
            print(f"  {label:22s} {n:>2} {theta:>8.5f} {theta0(n):>7.4f} "
                  f"{'yes' if theta >= theta0(n) - 1e-9 else 'no':>4} {a:>8.5f} {b:>8.5f} "
                  f"{a*a+b*b:>8.5f} {3/(n*(n-2)):>8.5f} "
                  f"{'ok' if a*a+b*b <= 3/(n*(n-2)) + 1e-9 else 'FAIL':>6} {scal:>7.3f} "
                  f"{(n+1)*theta_tilde0(n):>7.3f} "
                  f"{'ok' if scal >= (n+1)*theta_tilde0(n) - 1e-9 else 'FAIL':>6} {d2:>7.4f}")


if __name__ == "__main__":
    main()
