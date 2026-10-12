"""The bound D4 says is capped by the 67/68 ceiling: theta <= min_{gamma in p} [ Xmax_gamma/(2 lam_g) + lam_g ],
Xmax_gamma = max { sum_a lam_a^2 R_a : R >= 0, R_gamma = 0, sum R = 2(n-2), sum lam_a R_a = -2 lam_g, R <= 2 }."""
import sys; sys.path.insert(0,'scripts/reviewers/r294')
import numpy as np
from scipy.optimize import linprog, minimize
import core294 as C


def Xmax(lam, g, n, cap=True):
    N = len(lam); keep = [a for a in range(N) if a != g]
    obj = -lam[keep]**2
    Aeq = np.vstack([np.ones(len(keep)), lam[keep]])
    beq = np.array([2.0*(n-2), -2.0*lam[g]])
    r = linprog(obj, A_eq=Aeq, b_eq=beq,
                bounds=[(0, 2.0 if cap else None)]*len(keep), method='highs')
    return None if not r.success else -r.fun


def d3bound(lam, n, cap=True):
    vals = []
    for g in np.where(lam > 1e-12)[0]:
        X = Xmax(lam, g, n, cap)
        if X is None: return None
        vals.append(X/(2*lam[g]) + lam[g])
    return min(vals) if vals else None


if __name__ == '__main__':
    print("=== the D3-derived bound at the catalogue ===")
    for lbl, (n, W) in [('S^3xS^3', C.sphere_product([3,3])), ('S^4xS^4', C.sphere_product([4,4])),
                        ('S^5xS^5', C.sphere_product([5,5])), ('S^6xS^6', C.sphere_product([6,6])),
                        ('S^3xS^5', C.sphere_product([3,5])), ('S^5xS^7', C.sphere_product([5,7])),
                        ('CP^3', C.cpm(3)), ('CP^4', C.cpm(4))]:
        lam = np.linalg.eigvalsh(W); th = C.theta(n, W)
        b = d3bound(lam, n); bnc = d3bound(lam, n, cap=False)
        print(f"  {lbl:9s} n={n:2d}  theta {th:.6f}   D3 bound {b:.6f}"
              f"   (no pair cap {bnc:.6f})   slack {b-th:+.3e}")

    print("\n=== maximised over band spectra (structured search) ===")
    def structured(par, P, d, N):
        a = np.abs(par[:4])+1e-13; b = np.abs(par[4:6])+1e-13
        pos = np.concatenate([a[:3][:P], np.full(max(P-3,0), a[3])])[:P]
        neg = np.concatenate([[b[0]], np.full(max(d-1,0), b[1])])[:d]
        neg = neg*(pos.sum()/neg.sum())
        lam = np.concatenate([-neg, pos, np.zeros(N-d-P)])
        return lam/np.linalg.norm(lam)
    for n in (6, 8, 12):
        N = n*(n-1)//2; best = (-1e9, None, None)
        for d in range(3, (n*n)//4):
            for P in sorted(set([1,2,3,4,5,6,8,min(12,N-d),N-d])):
                if not (1 <= P <= N-d): continue
                for k in range(4):
                    x0 = np.random.default_rng(700*d+13*P+k).standard_normal(6)
                    f = lambda x: -(d3bound(structured(x,P,d,N), n) or -1e9)
                    r = minimize(f, x0, method='Nelder-Mead',
                                 options=dict(maxfev=100, fatol=1e-9, xatol=1e-7))
                    if -r.fun > best[0]: best = (-r.fun, d, structured(r.x,P,d,N))
        print(f"  n={n:2d}  band max of the D3 bound >= {best[0]:.4f} at d={best[1]}"
              f"   (67/68 ceiling {[1.6038,2.2913,2.4942][[6,8,12].index(n)]},"
              f" target {max(np.sqrt(1.5), np.sqrt(2*(n-1)*(n-2))/n):.4f})", flush=True)
