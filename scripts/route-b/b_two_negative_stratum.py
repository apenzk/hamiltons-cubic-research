"""The one-positive/two-negative stratum: theta <= sqrt(3/2), proved.

THE STATEMENT.  Let W in Weyl_n have ||W|| = 1 and exactly one positive and two
negative eigenvalues, say lam_1 > 0 > -a >= -b.  Then

    theta(W) <= sqrt(3/2),   with equality iff the spectrum is (2,-1,-1)/sqrt(6).

Since sqrt(3/2) < theta_0(n) from n = 12, this excludes the whole stratum there --
and it is exactly the stratum padded W_CP2 lives in, which is route B's sharp case.

THE PROOF.  Write P = tr W^3 + <W,W#> and expand the second term in an eigenbasis,
<W,W#> = 1/2 sum T_abg lam_a lam_b lam_g with T = c'^2 nonnegative and totally
symmetric.  Split the sum by the signs of its three indices.  Three of the four
blocks vanish, each for a structural reason rather than numerically:

  (+++)  needs three positive indices, and there is only one, while T vanishes
         whenever two indices coincide;
  (++-)  needs two distinct positive indices, likewise unavailable;
  (---)  needs three indices in the 2-dimensional negative eigenspace, and c' is
         antisymmetric in three indices, so it vanishes identically there.

Only (+--) survives, and it equals 3 T_{1,N-1,N} lam_1 a b.  The pair cap --
sum_g T_abg = ||[v_a,v_b]||^2 <= 2 for orthonormal v_a, v_b, on record as proven
through ||ad_X||_op <= sqrt(2) -- gives T_{1,N-1,N} <= 2, so

    <W,W#> <= 6 lam_1 a b,        tr W^3 = lam_1^3 - (a^3 + b^3)  exactly.

Trace-freeness gives lam_1 = a + b and unit norm gives (a+b)^2 + a^2 + b^2 = 1.
Both constraints are scale-free in the ratio t = b/a, and substituting collapses the
bound to a single closed form:

    theta <= f(t) = 9 sqrt(2) t (t+1) / (4 (t^2 + t + 1)^(3/2)).

f has a unique stationary point on t >= 0, at t = 1, where f(1) = sqrt(3/2); f(0) =
0 and f -> 0 as t -> infinity.  So the maximum is sqrt(3/2), attained only at a = b,
which is the spectrum (2,-1,-1)/sqrt(6).  QED

WHAT IT DOES NOT REACH.  Two or more positive eigenvalues alongside the two
negative ones: the (+++) and (++-) blocks reappear and neither is controlled by the
pair cap alone.  That is the remaining half of the dim m <= 2 stratum.

FALSIFIER.  A Weyl tensor with one positive and two negative eigenvalues and
theta > sqrt(3/2).
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import adj, normalize, sharp
from b_cp2_nondegenerate import padded_cp2
from b_apriori_bound import theta


def blocks(n, W, c=None):
    """The four sign-blocks of <W,W#> = 1/2 sum T lam lam lam."""
    c = adj(n) if c is None else c
    lam, V = np.linalg.eigh(W)
    T = np.einsum('abg,ap,bq,gr->pqr', c, V, V, V, optimize=True) ** 2
    pos, neg = lam > 1e-12, lam < -1e-12
    B = lambda s1, s2, s3: 0.5 * float(np.einsum('pqr,p,q,r->',
                                                 T[np.ix_(s1, s2, s3)],
                                                 lam[s1], lam[s2], lam[s3]))
    return dict(ppp=B(pos, pos, pos), ppm=3 * B(pos, pos, neg),
                pmm=3 * B(pos, neg, neg), mmm=B(neg, neg, neg)), lam, T


def f(t):
    return 9 * np.sqrt(2) * t * (t + 1) / (4 * (t ** 2 + t + 1) ** 1.5)


if __name__ == "__main__":
    print("=== the three structural vanishings, and the surviving block ===")
    for n in (6, 8, 12):
        W = normalize(padded_cp2(n)[0]); c = adj(n)
        bl, lam, T = blocks(n, W, c)
        ip = int(np.argmax(lam)); ns = np.flatnonzero(lam < -1e-12)
        l1, a, b = lam[ip], -lam[ns[0]], -lam[ns[1]]
        print(f"  n={n:2d}  (+++)={bl['ppp']:.0e}  (++-)={bl['ppm']:.0e}  "
              f"(---)={bl['mmm']:.0e}  (+--)={bl['pmm']:.6f} = 6 lam1 a b = "
              f"{6*l1*a*b:.6f}")
        print(f"        pair cap ||[v_N-1,v_N]||^2 = {float(T[:, ns[0], ns[1]].sum()):.6f}"
              f" (<= 2, attained),  theta = {theta(n, W):.6f} = f(1) = {f(1.0):.6f}")

    print("\n=== f(t) = 9 sqrt2 t(t+1) / (4 (t^2+t+1)^{3/2}) on t >= 0 ===")
    for t in (0.0, 0.25, 0.5, 1.0, 2.0, 4.0, 20.0):
        mark = "   <-- maximum, = sqrt(3/2)" if t == 1.0 else ""
        print(f"  f({t:5.2f}) = {f(t):.9f}{mark}")
    ts = np.linspace(1e-6, 200, 2000001)
    print(f"  numerical max over a fine grid: {f(ts).max():.9f}   "
          f"sqrt(3/2) = {np.sqrt(1.5):.9f}")
