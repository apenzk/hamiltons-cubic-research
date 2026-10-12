import sys; sys.path.insert(0,'scripts/reviewers/r294')
import numpy as np, time
from scipy.optimize import minimize
from d4_lp import lp

def structured_lam(par, P, d, N):
    a = np.abs(par[:4]) + 1e-13; b = np.abs(par[4:6]) + 1e-13
    pos = np.concatenate([a[:3][:P], np.full(max(P-3,0), a[3])])[:P]
    neg = np.concatenate([[b[0]], np.full(max(d-1,0), b[1])])[:d]
    neg = neg * (pos.sum()/neg.sum())
    lam = np.concatenate([-neg, pos, np.zeros(N-d-P)])
    return lam/np.linalg.norm(lam)

def sweep(n, mode, ds=None, seeds=6):
    N = n*(n-1)//2; cap = (n*n)//4
    best = (-1e9, None, None)
    for d in (ds or range(3, cap)):
        bd = (-1e9, None, None)
        for P in sorted(set([1,2,3,4,5,6,8,min(12,N-d),N-d])):
            if not (1 <= P <= N-d): continue
            for k in range(seeds):
                x0 = np.random.default_rng(9173*d+41*P+k).standard_normal(6)
                f = lambda x: -(lp(structured_lam(x,P,d,N), n, d, **mode) or -1e9)
                r = minimize(f, x0, method='Nelder-Mead',
                             options=dict(maxfev=120, fatol=1e-9, xatol=1e-7))
                if -r.fun > bd[0]: bd = (-r.fun, P, structured_lam(r.x,P,d,N))
        print(f"    d={d:3d}  max = {bd[0]:10.5f}  (P={bd[1]})", flush=True)
        if bd[0] > best[0]: best = (bd[0], d, bd[2])
    return best

if __name__ == '__main__':
    n = int(sys.argv[1])
    modes = {'base (67/68 list)': dict(crit=False, ident=False, smmm=True),
             '+ per-row identity': dict(crit=False, ident=True, smmm=True),
             '+ per-row criticality': dict(crit=True, ident=False, smmm=True),
             '+ both (the D3 route)': dict(crit=True, ident=True, smmm=True)}
    for lbl, mode in modes.items():
        t0 = time.time(); print(f"n={n}  {lbl}", flush=True)
        b = sweep(n, mode)
        print(f"  => n={n} {lbl}: CEILING {b[0]:.6f} at d={b[1]}  [{time.time()-t0:.0f}s]", flush=True)
        print(f"     spectrum {np.array2string(np.sort(b[2])[::-1], precision=5)}", flush=True)
