import sys; sys.path.insert(0,'scripts/reviewers/r323')
import numpy as np, core, lp, lem70, math
from t2 import W_of, block_h
from t3 import su3_in_so8
D='scripts/data/'
rows=[]
def show(name,W,n):
    W=0.5*(W+W.T); W/=np.sqrt(np.trace(W@W))
    c=ctx[n]; th,res=core.crit_residual(c,W)
    lam=np.linalg.eigvalsh(W); lmin,lmax=lam[0],lam[-1]
    trueD=abs(lmin)*(lmin+(n-2)*lmax-th)
    r=lp.lp_min_D(lam,n,use_marg=True)
    Dlp=r.fun; bound=lmin+(n-2)*lmax-Dlp/abs(lmin)
    r0=lp.lp_min_D(lam,n,use_marg=False); b0=lmin+(n-2)*lmax-r0.fun/abs(lmin)
    print(f'{name:26s} n={n:2d} res={res:.1e} theta={th:.6f} trueD={trueD:.6f} LPD={Dlp:.6f} bound={bound:.6f} (nomarg {b0:.4f}) theta0={math.sqrt(2*(n-1)*(n-2))/n:.6f}')
ctx={}
for n in [6,8,10,12]: ctx[n]=core.Ctx(n)
for n in [6,8,10,12]:
    m=n//2
    show(f'so({m})+so({m})',W_of(ctx[n],block_h(n,[m,m])),n)
    show('max torus',W_of(ctx[n],block_h(n,[2]*(n//2))),n)
show('ad(su(3))<so(8)',W_of(ctx[8],su3_in_so8(ctx[8])),8)
for f,n in [('review_r40_W_cpm3.npy',6),('review_r40_W_cpm4.npy',8),('review_r40_W_cpm5.npy',10),
            ('w_n8_nondiagonal_witness.npy',8),('frontier_n6_th1.224745_d20.111111.npy',6),
            ('frontier_n8_th1.224745_d20.111111.npy',8),('frontier_n12_th1.224745_d20.111111.npy',12),
            ('frontier_n12_th1.236033_d20.000000.npy',12)]:
    show(f[:-4][:26],np.load(D+f),n)
