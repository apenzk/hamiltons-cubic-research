"""T5b: predictor-corrector on the excess directions at the degenerate S=0 UNGRADED points.
Does a curve of critical points leave the orbit and change S?"""
import numpy as np, time, sys
from scipy.optimize import least_squares
from review_r47_core import *
from review_r47_t3 import cp_m
from review_r47_t3b import block_sum

g4,Wcp2 = cp_m(2); g6=Geom(6); W33=sphere_product(g6,3,3)

def setup(which):
    if which=='cp2cp2':
        g,W,_,_ = block_sum(8,[(list(range(4)),g4,Wcp2),(list(range(4,8)),g4,Wcp2)])
    elif which=='pad33':
        g=Geom(8); W=pad(g6,g,W33)
    elif which=='padcp2':
        g=Geom(8); W=pad(g4,g,Wcp2)
    return g,W

which = sys.argv[1] if len(sys.argv)>1 else 'cp2cp2'
g,W = setup(which)
th,res = crit_residual(g,W); e=W/th
Bas=g.weyl_basis(); dW=Bas.shape[0]; Bm=Bas.reshape(dW,-1)
L=Le_matrix(g,e,Bas); L=(L+L.T)/2
ev,evec=np.linalg.eigh(L)
sel=np.abs(ev-0.5)<1e-7
V=evec[:,sel]
O=np.array([ Bm@(g.ad(X)@W-W@g.ad(X)).ravel() for X in g.so_basis()])
qo,ro=np.linalg.qr(O.T); rk=int((np.abs(np.diag(ro))>1e-9*np.abs(ro).max()).sum()); qo=qo[:,:rk]
Vp=V-qo@(qo.T@V)
u,sv,_=np.linalg.svd(Vp,full_matrices=False)
exc=u[:,sv>1e-6]
print(f"{which}: theta={th:.9f} res={res:.1e} dimE(1/2)={int(sel.sum())} orbit={rk} excess={exc.shape[1]}",flush=True)

def W_of(c):
    M=(c@Bm).reshape(g.N,g.N); return M/np.linalg.norm(M)
def resid(c):
    M=W_of(c); QM=g.Q(M); t=float((QM*M).sum()); return Bm@(QM-t*M).ravel()

c0=Bm@W.ravel()
print(f" residual at the point: {np.linalg.norm(resid(c0)):.2e}",flush=True)
rng=np.random.default_rng(5)
best=[]
for k in range(exc.shape[1]):
    d=exc[:,k]
    for t in (0.05,0.15,0.35):
        sol=least_squares(resid, c0+t*d, method='lm', xtol=1e-15,ftol=1e-15,gtol=1e-15,max_nfev=20000)
        M=W_of(sol.x); th2,r2=crit_residual(g,M)
        dist=np.linalg.norm(M-W)
        st=struct_sums(g,M)
        best.append((r2,th2,st['S'],dist,t,k))
    if k%4==0: print(f"  ...direction {k}/{exc.shape[1]} best res so far {min(b[0] for b in best):.2e}",flush=True)
conv=[b for b in best if b[0]<1e-9]
print(f" solves={len(best)} converged={len(conv)}",flush=True)
if conv:
    S0=[b for b in conv if b[2]<1e-10]; Sp=[b for b in conv if b[2]>=1e-10]
    print(f"  with S=0: {len(S0)}   with S>0: {len(Sp)}")
    dd=[b[3] for b in conv]
    print(f"  distance from start: min={min(dd):.4f} max={max(dd):.4f}")
    th2s=sorted(set(round(b[1],9) for b in conv))
    print(f"  distinct thetas reached: {th2s[:12]}")
    for b in Sp[:6]:
        print(f"   S>0 point: res={b[0]:.1e} theta={b[1]:.9f} S={b[2]:.4f} dist={b[3]:.4f} (dir {b[5]}, t={b[4]})")
else:
    print(f"  no solve converged; best residual {min(b[0] for b in best):.2e}")
