import sys; sys.path.insert(0,'scripts/reviewers/r294')
import numpy as np, json, time
from scipy.optimize import minimize
from d4_lp import lp

MODES = {'base': dict(crit=False, ident=False, smmm=True),
         'ident': dict(crit=False, ident=True, smmm=True),
         'crit': dict(crit=True, ident=False, smmm=True),
         'both': dict(crit=True, ident=True, smmm=True)}

def structured(par, P, d, N):
    a = np.abs(par[:4])+1e-13; b = np.abs(par[4:6])+1e-13
    pos = np.concatenate([a[:3][:P], np.full(max(P-3,0), a[3])])[:P]
    neg = np.concatenate([[b[0]], np.full(max(d-1,0), b[1])])[:d]
    neg = neg*(pos.sum()/neg.sum())
    lam = np.concatenate([-neg, pos, np.zeros(N-d-P)])
    return lam/np.linalg.norm(lam)

def sweep(n, key, seeds=3, maxfev=70):
    N = n*(n-1)//2; best = (-1e9, None, None)
    for d in ([4,5,8,11] if n==8 else range(3,(n*n)//4)):
        for P in sorted(set([3,4,6,8])):
            if not (1 <= P <= N-d): continue
            for k in range(seeds):
                x0 = np.random.default_rng(1000003*d+977*P+k).standard_normal(6)
                f = lambda x: -(lp(structured(x,P,d,N), n, d, **MODES[key]) or -1e9)
                r = minimize(f, x0, method='Nelder-Mead',
                             options=dict(maxfev=maxfev, fatol=1e-10, xatol=1e-8))
                if -r.fun > best[0]: best = (-r.fun, d, structured(r.x,P,d,N))
    return best

if __name__ == '__main__':
    n = int(sys.argv[1]) if len(sys.argv)>1 else 6; out = {}
    for key in MODES:
        t0 = time.time(); v, d, lam = sweep(n, key)
        out[key] = (v, d, lam.tolist())
        print(f"  {key:6s} ceiling {v:.6f} at d={d}  [{time.time()-t0:.0f}s]", flush=True)
        np.save(f'scripts/reviewers/r294/lam_{key}_{n}.npy', lam)
    print("\n=== cross-evaluation: LP value of each constraint set at each optimum spectrum ===")
    print(f"  {'spectrum from':14s}" + ''.join(f"{k:>14s}" for k in MODES))
    for src in MODES:
        lam = np.array(out[src][2]); d = int((lam < -1e-12).sum())
        row = ''
        for key in MODES:
            v = lp(lam, n, d, **MODES[key])
            row += f"{('INFEAS' if v is None else format(v,'.6f')):>14s}"
        print(f"  {src:14s}" + row)
    json.dump(out, open('scripts/reviewers/r294/ceilings_%d.json'%n,'w'))
