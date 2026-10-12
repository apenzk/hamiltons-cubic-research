import numpy as np, sys, os, time, json
sys.path.insert(0,'scripts/reviewers/r327')
from core import *; from search import *
from scipy.optimize import least_squares
rng = np.random.default_rng(int(sys.argv[2]) if len(sys.argv)>2 else 1)
n = int(sys.argv[1]); ntr = int(sys.argv[3]) if len(sys.argv)>3 else 40
M = ad_mats(n)
B, W_of, res_crit, res_sat = make(n)
d = B.shape[1]
best = []
t0=time.time()
for t in range(ntr):
    x0 = rng.standard_normal(d)
    mode = t % 2
    f = (lambda x: res_crit(x)) if mode==0 else (lambda x: res_sat(x, 3.0))
    try:
        sol = least_squares(f, x0, method='lm', xtol=1e-14, ftol=1e-14, gtol=1e-14, max_nfev=4000)
    except Exception as e:
        continue
    W = W_of(sol.x)
    rep = report(W, n, M)
    rep['mode']=mode; rep['t']=t
    best.append(rep)
    if rep['crit']<1e-9 and abs(rep['sat'])<1e-7:
        print('SATURATING', json.dumps({k:(v.tolist() if hasattr(v,'tolist') else v) for k,v in rep.items()}), flush=True)
# summary
sat = [r for r in best if r['crit']<1e-9]
print(f'n={n} trials={ntr} solved-critical={len(sat)} time={time.time()-t0:.0f}s')
if sat:
    sat.sort(key=lambda r: abs(r['sat']))
    for r in sat[:6]:
        print(f"  theta={r['theta']:.6f} crit={r['crit']:.1e} dW={r['dW']:.1e} sat_defect={r['sat']:.6f} dim_r={r['dim_r']} nonzero_r={r['r_nonzero']} maxabs_r={r['maxabs_r']:.4f} spec={r['spec']}")
    print('  MIN |sat defect| over critical points found:', min(abs(r['sat']) for r in sat))
    print('  min |sat| among those with dim_r>0:', min([abs(r['sat']) for r in sat if r['dim_r']>0], default=None))
