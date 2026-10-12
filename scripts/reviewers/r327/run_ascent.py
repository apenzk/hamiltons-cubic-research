"""Projected gradient ascent on P over the unit sphere of Weyl_n: local maxima,
then saturation defect.  Also descent (ascent on -P) for the other end."""
import numpy as np, sys
sys.path.insert(0,'scripts/reviewers/r327')
from core import *; from search import *
n=int(sys.argv[1]); seed=int(sys.argv[2]); ntr=int(sys.argv[3]); sgn=float(sys.argv[4]) if len(sys.argv)>4 else 1.0
rng=np.random.default_rng(seed); M=ad_mats(n); N=n*(n-1)//2; _,idx=sym_coords(n)
B,W_of,res_crit,res_sat=make(n); d=B.shape[1]
out=[]
for t in range(ntr):
    x=rng.standard_normal(d); x/=np.linalg.norm(x)
    step=0.4
    for it in range(4000):
        W=W_of(x); QW=Q(W,M); th=float(np.trace(W@QW))
        g=B.T@vec(QW,idx) - th*x
        gn=np.linalg.norm(g)
        if gn<1e-13: break
        x=x+sgn*step*g; x/=np.linalg.norm(x)
    W=W_of(x); r=report(W,n,M)
    out.append(r)
crit=[r for r in out if r['crit']<1e-9]
print(f'n={n} sgn={sgn:+.0f} runs={ntr} converged={len(crit)}')
seen={}
for r in crit:
    key=tuple(np.round(r['spec'],5))
    seen.setdefault(key,[0,r]); seen[key][0]+=1
for k,(c,r) in sorted(seen.items(), key=lambda kv: abs(kv[1][1]['sat']))[:8]:
    print(f"  x{c:3d} theta={r['theta']:+.9f} crit={r['crit']:.1e} dW={r['dW']:.1e} |sat|={abs(r['sat']):.3e} dim_r={r['dim_r']} nonzero_r={r['r_nonzero']} spec={k}")
if crit: print('  MIN |sat| =', min(abs(r['sat']) for r in crit), '| min |sat| with dim_r>0 =', min([abs(r['sat']) for r in crit if r['dim_r']>0], default=None))
