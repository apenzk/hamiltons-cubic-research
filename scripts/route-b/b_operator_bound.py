"""P as a Rayleigh quotient, and the bound that makes theta its own eigenvalue.

THE IDENTITY.  In an eigenbasis of W, with c' the structure constants transported
there and lambda the spectrum,

    P  =  sum_a lam_a^3  +  1/2 sum c'^2_{abg} lam_a lam_b lam_g  =  <lambda, M lambda>,

    M(lambda)_{ab}  =  delta_{ab} lam_a  +  1/2 sum_g c'^2_{abg} lam_g,

and M is symmetric because c'^2 is symmetric in its first two indices.  Since
||lambda|| = 1 this gives at once

    theta  <=  lam_max( M(lambda) ),

with equality exactly when lambda is a top eigenvector of M.

WHY IT IS THE RIGHT OBJECT.  At a critical point Q(W) = theta W is diagonal in the
eigenbasis, so M(lambda) lambda = theta lambda: theta is ALREADY an eigenvalue of
M, not merely bounded by one.  Across the catalogue lam_max(M) equals theta to six
digits at every point except the C_5 blow-up, where lambda is not the top
eigenvector -- 0.809017 against theta = 0.670820.

AND ITS SUPREMUM LOOKS LIKE max(sqrt(3/2), theta_0(n)).  Ascent over Weyl_n gives
1.224745 = sqrt(3/2) at n = 6 and n = 8, where theta_0 is 1.054093 and 1.145644, so
the padded W_CP2 value dominates.  From n = 12 theta_0 overtakes it.  IF the
supremum is max(sqrt(3/2), theta_0(n)) in general, then for n >= 12

    M(n)  <=  sup lam_max(M)  =  theta_0(n),

which is Conjecture A, with equality at the balanced sphere product.

AGAINST THE EARLIER BOUND.  lam_max*p + B5 tops out at 1.5488 over the same set;
this one at 1.2248.  It is a strictly better object and it costs the same einsum.

FALSIFIER.  A W in Weyl_n with lam_max(M(W)) > max(sqrt(3/2), theta_0(n)).
"""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r30_core import adj, normalize, weyl_basis
from b_apriori_bound import rows, theta
from b_lowrank_bound import pieces


def M_of(n, W, c=None):
    c = adj(n) if c is None else c
    lam, V = np.linalg.eigh(W)
    T = np.einsum('abg,ap,bq,gr->pqr', c, V, V, V, optimize=True) ** 2
    M = np.diag(lam) + 0.5 * np.einsum('pqr,r->pq', T, lam)
    return 0.5 * (M + M.T), lam


def lam_max_M(n, W, c=None):
    return float(np.linalg.eigvalsh(M_of(n, W, c)[0]).max())


if __name__ == "__main__":
    print("=== the identity and its sharpness at the catalogue ===")
    print(f"{'point':20s} {'n':>3s} {'theta':>9s} {'<l,Ml>':>9s} {'lam_max(M)':>11s} "
          f"{'lam_max*p+B5':>12s}")
    for nm, n, W in rows():
        M, lam = M_of(n, W)
        a, b = pieces(n, W)
        print(f"{nm:20s} {n:3d} {theta(n,W):9.6f} {float(lam@M@lam):9.6f} "
              f"{float(np.linalg.eigvalsh(M).max()):11.6f} {a+b:12.6f}")

    print("\n=== sup lam_max(M) over Weyl_n, by full-gradient ascent ===")
    for n in (6, 8):
        B = np.asarray(weyl_basis(n)); c = adj(n); D = B.shape[0]
        W_of = lambda z: normalize(np.einsum('d,dij->ij', z, B))
        f = lambda z: lam_max_M(n, W_of(z), c)
        rng = np.random.default_rng(6); best = -9.0; t0 = time.time()
        for s in range(4 if n == 6 else 3):
            x = rng.normal(size=D); x /= np.linalg.norm(x); v = f(x); step = 0.2; h = 1e-5
            for _ in range(100):
                g = np.empty(D)
                for d in range(D):
                    e = np.zeros(D); e[d] = h; g[d] = (f(x + e) - v) / h
                g -= (g @ x) * x; gn = np.linalg.norm(g)
                if gn < 1e-11:
                    break
                g /= gn
                for t in (step, step / 2, step / 4, step / 8):
                    xn = x + t * g; xn /= np.linalg.norm(xn)
                    if f(xn) > v + 1e-13:
                        x, v = xn, f(xn); break
                else:
                    step /= 2
                    if step < 1e-8:
                        break
            best = max(best, v)
        th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
        print(f"  n={n}: sup = {best:.6f}   max(sqrt(3/2), theta_0={th0:.6f}) = "
              f"{max(np.sqrt(1.5), th0):.6f}   [{time.time()-t0:.0f}s]")
