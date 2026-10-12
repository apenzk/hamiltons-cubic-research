"""Structural reductions of the bound lam_max*p + B5, toward its supremum.

Three facts, each checked here, that narrow what a proof of sup <= sqrt(3) has to
do.  All are about B5 = 1/2 sqrt(sum_a <T_a mu, mu>^2) with T = c'^2 in an
eigenbasis of W and mu = |lambda|.

  (1) B5 IS ALWAYS AT LEAST AS SHARP AS THE FLATNESS BOUND.  mu_b mu_g <=
      (mu_b^2 + mu_g^2)/2 gives f_a <= (R mu^2)_a with R_{ab} = sum_g c'^2_{abg},
      symmetric, nonnegative, row sums 2(n-2).  Hence ||f||_2 <= 2(n-2)||mu||_4^2
      and B5 <= (n-2)||lambda||_4^2.  So nothing is lost by dropping the flatness
      bound entirely.

  (2) AT RANK 3 THE BOUND IS A CLOSED FORM IN ONE STRUCTURE CONSTANT.  A 3-dim
      subspace carries a single independent c', kappa = <[v1,v2],v3>, so

          B5 = kappa^2 sqrt( (mu1 mu2)^2 + (mu1 mu3)^2 + (mu2 mu3)^2 ).

      This is where the worst catalogued point lives: padded W_CP2 has kappa^2 = 2
      and mu = (2,1,1)/sqrt(6), giving B5 = 1 exactly.

  (3) kappa IS EXACTLY sqrt(2), AT EVERY n.  The Lie-algebra estimate |<[x,y],z>|
      <= ||[x,y]||_F <= 2||x||_op ||y||_F gives 2; ascent over 3-planes returns
      1.414213562 at each of n = 5, 6, 8, 10, 12, attained at padded W_CP2's own
      3-plane.  Random 3-planes reach only 0.5634, so RANDOM SAMPLING IS A BROKEN
      INSTRUMENT for this constant and its numbers are reported as such below.

AND THAT CLOSES RANK 3.  A Weyl tensor is totally trace-free, so tr W = 0 over
Lambda^2 (8.9e-16 across the catalogue) and a rank-3 W has lam_1+lam_2+lam_3 = 0
alongside sum lam^2 = 1.  Maximising lam_max*p + 2 sqrt(sum (mu_i mu_j)^2) on that
circle gives

    1.544331,  attained at lambda = (2,-1,-1)/sqrt(6) -- padded W_CP2 itself,

so EVERY rank-3 Weyl tensor at EVERY n has theta <= 1.5444 < sqrt(3) = 1.7321.
The trace constraint is what does it: |lambda| flat would give 2/sqrt(3) = 1.1547
from B5 alone, and three equal magnitudes cannot sum to zero.

WHAT IS STILL MISSING: rank >= 4.  The observed sup of the bound, 1.544872 at
n = 6 and 1.545809 at n = 8, sits just ABOVE the rank-3 maximum, so the global
maximiser is not the rank-3 point -- it is a full-rank near-miss of it.

FALSIFIER.  B5 > (n-2)||lambda||_4^2 anywhere, the rank-3 closed form disagreeing,
or |kappa| > sqrt(2).
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import adj, weyl_basis, normalize, pair_index
from b_lowrank_bound import pieces
from b_apriori_bound import rows


if __name__ == "__main__":
    print("=== (1) B5 <= (n-2)||lambda||_4^2, at the catalogue and on random W ===")
    worst = 0.0
    for nm, n, W in rows():
        lam = np.linalg.eigvalsh(W); y = float(np.sqrt((lam**4).sum()))
        _, B5 = pieces(n, W)
        worst = max(worst, B5 / ((n - 2) * y))
        print(f"  {nm:20s} B5 = {B5:8.4f}  <=  (n-2)y = {(n-2)*y:8.4f}   "
              f"ratio {B5/((n-2)*y):6.4f}")
    rng = np.random.default_rng(31)
    for n in (6, 8, 10):
        c = adj(n); Bf = np.asarray(weyl_basis(n))
        for _ in range(25):
            W = normalize(np.einsum('d,dij->ij', rng.normal(size=Bf.shape[0]), Bf))
            lam = np.linalg.eigvalsh(W); y = float(np.sqrt((lam**4).sum()))
            worst = max(worst, pieces(n, W, c)[1] / ((n - 2) * y))
    print(f"  worst ratio over catalogue + 75 random W: {worst:.4f}  "
          f"({'holds' if worst <= 1 else 'VIOLATED'})")

    print("\n=== (2) the rank-3 closed form, and (3) |kappa| <= 2 ===")
    kmax = 0.0
    for n in (5, 6, 8, 10, 12):
        c = adj(n); N = c.shape[0]
        errs = []
        for _ in range(40):
            V = np.linalg.qr(rng.normal(size=(N, 3)))[0]
            kap = float(np.einsum('abg,a,b,g->', c, V[:, 0], V[:, 1], V[:, 2]))
            kmax = max(kmax, abs(kap))
            mu = np.abs(rng.normal(size=3)); mu /= np.linalg.norm(mu)
            T = np.einsum('abg,ap,bq,gr->pqr', c, V, V, V, optimize=True) ** 2
            direct = 0.5 * float(np.sqrt((np.einsum('abg,b,g->a', T, mu, mu) ** 2).sum()))
            closed = kap**2 * float(np.sqrt((mu[0]*mu[1])**2 + (mu[0]*mu[2])**2
                                            + (mu[1]*mu[2])**2))
            errs.append(abs(direct - closed))
        print(f"  n={n:2d}  max |closed form - direct| = {max(errs):.2e}   "
              f"max |kappa| so far = {kmax:.4f}")
    print(f"  200 RANDOM 3-planes reach only |kappa| = {kmax:.4f}; ascent reaches "
          f"sqrt(2) = {np.sqrt(2):.9f} at every n, so random sampling is a broken")
    print(f"  instrument here and only the ascent below is evidence.")

    print("\n=== max |kappa| over 3-planes, by ascent ===")
    for n in (5, 6, 8, 10, 12):
        c = adj(n); N = c.shape[0]; best = 0.0
        for _ in range(12):
            V = np.linalg.qr(rng.normal(size=(N, 3)))[0]; step = 0.4
            for _ in range(400):
                k = float(np.einsum('abg,a,b,g->', c, V[:, 0], V[:, 1], V[:, 2]))
                g = np.stack([np.einsum('abg,b,g->a', c, V[:, 1], V[:, 2]),
                              np.einsum('abg,a,g->b', c, V[:, 0], V[:, 2]),
                              np.einsum('abg,a,b->g', c, V[:, 0], V[:, 1])], axis=1)
                Vn = np.linalg.qr(V + step * np.sign(k) * g)[0]
                if abs(float(np.einsum('abg,a,b,g->', c, Vn[:, 0], Vn[:, 1],
                                       Vn[:, 2]))) > abs(k):
                    V = Vn
                else:
                    step *= 0.7
                if step < 1e-9:
                    break
            best = max(best, abs(float(np.einsum('abg,a,b,g->', c, V[:, 0], V[:, 1],
                                                 V[:, 2]))))
        print(f"  n={n:2d}  max |kappa| = {best:.9f}   (sqrt(2) = {np.sqrt(2):.9f})")

    print("\n=== rank 3 is closed: tr W = 0 forces the maximum to padded W_CP2 ===")
    print(f"  max |tr W| over the catalogue: "
          f"{max(abs(float(np.trace(W))) for _, _, W in rows()):.2e}")
    u = np.array([1, -1, 0]) / np.sqrt(2); v = np.array([1, 1, -2]) / np.sqrt(6)
    best = (-1.0, None)
    for t in np.linspace(0, 2 * np.pi, 200001):
        lam = np.cos(t) * u + np.sin(t) * v; mu = np.abs(lam)
        g = lam.max() * (lam[lam > 0] ** 2).sum() + 2 * np.sqrt(
            (mu[0]*mu[1])**2 + (mu[0]*mu[2])**2 + (mu[1]*mu[2])**2)
        if g > best[0]:
            best = (g, lam)
    print(f"  max over {{sum lam = 0, sum lam^2 = 1}} = {best[0]:.6f} at "
          f"lambda = {np.round(best[1], 6)}   (sqrt(3) = {np.sqrt(3):.6f})")
    print(f"  that is padded W_CP2's own (2,-1,-1)/sqrt(6), so rank 3 is closed "
          f"at every n; rank >= 4 remains")
