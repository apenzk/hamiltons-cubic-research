"""Targeted M4 hunt: start near known saturating / near-saturating points and
solve criticality+saturation jointly.  Looking for a saturating critical point
whose non-extreme spectrum is nonzero."""
import numpy as np, sys, os
sys.path.insert(0,'scripts/reviewers/r327')
from core import *; from search import *; from points import *
from itertools import combinations
from scipy.optimize import least_squares

def cp2(n):
    P=list(combinations(range(n),2)); N=len(P)
    def e(i,j):
        v=np.zeros(N); v[P.index((i,j))]=1; return v
    sd=[e(0,1)+e(2,3), e(0,2)-e(1,3), e(0,3)+e(1,2)]
    sd=[v/np.linalg.norm(v) for v in sd]
    return 2*np.outer(sd[0],sd[0]) - np.outer(sd[1],sd[1]) - np.outer(sd[2],sd[2])

n=int(sys.argv[1]); seedno=int(sys.argv[2]); ntr=int(sys.argv[3])
rng=np.random.default_rng(seedno)
M=ad_mats(n); N=n*(n-1)//2; _,idx=sym_coords(n)
B,W_of,res_crit,res_sat=make(n); d=B.shape[1]
def coords(W): return B.T@vec(proj_weyl(W,n),idx)
seeds=[]
names=[]
for p in range(2, n//2+1):
    seeds.append(coords(W_from_subalg(n,so_pq_gens(n,p)))); names.append(f'so({p})+so({n-p})')
seeds.append(coords(W_from_subalg(n,torus_gens(n)))); names.append('torus')
seeds.append(coords(cp2(n))); names.append('padded CP2')
try:
    seeds.append(coords(W_from_subalg(n,u_m_gens(n)))); names.append('u(n/2)')
except Exception: pass
best=(9e9,None)
res=[]
for si,(s,nm) in enumerate(zip(seeds,names)):
    s=s/np.linalg.norm(s)
    for t in range(ntr):
        eps = [0.0,0.02,0.1,0.3,0.8][t%5]
        x0 = s + eps*rng.standard_normal(d)
        sol=least_squares(lambda x: res_sat(x,3.0), x0, method='lm', xtol=1e-14,ftol=1e-14,gtol=1e-14,max_nfev=4000)
        W=W_of(sol.x); r=report(W,n,M)
        if r['crit']<1e-9:
            res.append((abs(r['sat']),r,nm,eps))
            if abs(r['sat'])<1e-7 and r['r_nonzero']>0:
                print('*** COUNTEREXAMPLE CANDIDATE', nm, eps, r, flush=True)
res.sort(key=lambda z:z[0])
print(f'n={n}: {len(res)} critical points from targeted seeds')
for a,r,nm,eps in res[:10]:
    print(f"  seed={nm:14s} eps={eps:.2f} theta={r['theta']:.6f} crit={r['crit']:.1e} dW={r['dW']:.1e} |sat|={a:.3e} dim_r={r['dim_r']} nonzero_r={r['r_nonzero']} maxabs_r={r['maxabs_r']:.4f}")
sats=[z for z in res if z[0]<1e-7]
print('  saturating found:', len(sats), ' with nonzero non-extreme eigenvalue:', len([z for z in sats if z[1]['r_nonzero']>0]))
for a,r,nm,eps in sats[:6]:
    print(f"    SAT seed={nm} theta={r['theta']:.9f} dim_r={r['dim_r']} spec={r['spec']}")
