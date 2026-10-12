"""The strongest bound D2/D3 supports at the R level: ONE symmetric R shared by all rows,
plus the criticality row-inequality X_a >= 2 lam_a theta - 2 lam_a^2 at EVERY a (both signs).

    max theta  s.t.  R >= 0 sym, diag 0, R <= 2, sum_b R_ab = 2(n-2),
                     sum_b lam_b R_ab = -2 lam_a,   sum_b lam_b^2 R_ab >= 2 lam_a theta - 2 lam_a^2.
The record's version drops the shared-R coupling, the symmetry, and every row with lam <= 0.
"""
import sys; sys.path.insert(0,'scripts/reviewers/r294')
import numpy as np
from itertools import combinations
from scipy.optimize import linprog, minimize
import core294 as C
from d3_bound import d3bound


def joint(lam, n, use_neg=True, sym=True, cap=True):
    N = len(lam); prs = list(combinations(range(N), 2)); nv = len(prs)
    pidx = {p: i for i, p in enumerate(prs)}
    def rowvec(a):
        v = np.zeros(nv)
        for b in range(N):
            if b != a: v[pidx[(min(a,b), max(a,b))]] = 1.0
        return v
    def wrow(a, w):
        v = np.zeros(nv)
        for b in range(N):
            if b != a: v[pidx[(min(a,b), max(a,b))]] = w[b]
        return v
    Aeq, beq, Aub, bub = [], [], [], []
    for a in range(N):
        Aeq.append(np.append(rowvec(a), 0.0)); beq.append(2.0*(n-2))
        Aeq.append(np.append(wrow(a, lam), 0.0)); beq.append(-2.0*lam[a])
        if lam[a] > 1e-12 or (use_neg and abs(lam[a]) > 1e-12):
            # -X_a + 2 lam_a theta <= 2 lam_a^2
            Aub.append(np.append(-wrow(a, lam**2), 2.0*lam[a])); bub.append(2.0*lam[a]**2)
    obj = np.zeros(nv+1); obj[nv] = -1.0
    r = linprog(obj, A_ub=np.array(Aub), b_ub=np.array(bub),
                A_eq=np.array(Aeq), b_eq=np.array(beq),
                bounds=[(0.0, 2.0 if cap else None)]*nv + [(None, None)], method='highs')
    return float(-r.fun) if r.success else None


if __name__ == '__main__':
    print("=== joint-R bound at the catalogue (must stay >= theta) ===")
    for lbl, (n, W) in [('S^3xS^3', C.sphere_product([3,3])), ('S^4xS^4', C.sphere_product([4,4])),
                        ('S^6xS^6', C.sphere_product([6,6])), ('S^3xS^5', C.sphere_product([3,5])),
                        ('S^5xS^7', C.sphere_product([5,7])), ('CP^3', C.cpm(3)), ('CP^4', C.cpm(4))]:
        lam = np.linalg.eigvalsh(W); th = C.theta(n, W)
        j = joint(lam, n); jp = joint(lam, n, use_neg=False); pr = d3bound(lam, n)
        print(f"  {lbl:9s} n={n:2d} theta {th:.6f}  per-row {pr:.6f}  joint(pos only) {jp:.6f}"
              f"  joint(all rows) {j:.6f}")

    print("\n=== maximised over band spectra ===")
    def structured(par, P, d, N):
        a = np.abs(par[:4])+1e-13; b = np.abs(par[4:6])+1e-13
        pos = np.concatenate([a[:3][:P], np.full(max(P-3,0), a[3])])[:P]
        neg = np.concatenate([[b[0]], np.full(max(d-1,0), b[1])])[:d]
        neg = neg*(pos.sum()/neg.sum())
        lam = np.concatenate([-neg, pos, np.zeros(N-d-P)])
        return lam/np.linalg.norm(lam)
    for n in (6, 8, 12):
        N = n*(n-1)//2
        for tag, kw in [('joint, positive rows only', dict(use_neg=False)),
                        ('joint, all rows', dict(use_neg=True))]:
            best = (-1e9, None, None)
            for d in range(3, (n*n)//4):
                for P in sorted(set([1,2,3,4,5,6,8,min(12,N-d),N-d])):
                    if not (1 <= P <= N-d): continue
                    for k in range(4):
                        x0 = np.random.default_rng(700*d+13*P+k).standard_normal(6)
                        f = lambda x: -(joint(structured(x,P,d,N), n, **kw) or -1e9)
                        r = minimize(f, x0, method='Nelder-Mead',
                                     options=dict(maxfev=90, fatol=1e-9, xatol=1e-7))
                        if -r.fun > best[0]: best = (-r.fun, d, structured(r.x,P,d,N))
            print(f"  n={n:2d}  {tag:28s} band max >= {best[0]:9.4f} at d={best[1]}", flush=True)
