import sys; sys.path.insert(0,'scripts/reviewers/r336')
import numpy as np, fast, lp
from scipy.optimize import least_squares
np.random.seed(2336)
n=6; P,N,q=fast.weyl_ortho(n); c=fast.struct(n); D=q.shape[1]
def Wof(x):
    W=(q@x).reshape(N,N); return (W+W.T)/2
def res(x):
    W=Wof(x); QW=fast.Q(W,c); th=float(np.sum(W*QW))
    r=(QW-th*W).reshape(-1)
    return np.concatenate([q.T@r,[np.sum(x*x)-1.0]])
found=[]
for t in range(40):
    x0=np.random.randn(D); x0/=np.linalg.norm(x0)
    s=least_squares(res,x0,xtol=1e-14,ftol=1e-14,gtol=1e-14,max_nfev=4000)
    if np.linalg.norm(s.fun)>1e-10: continue
    W=Wof(s.x); W/=np.linalg.norm(W)
    QW=fast.Q(W,c); th=float(np.sum(W*QW))
    if th<1e-6: continue
    lam=np.linalg.eigvalsh(W)
    nd=len(set(np.round(lam,6)))
    found.append((th,nd,lam,np.linalg.norm(QW-th*W)))
found.sort()
seen=[]
for th,nd,lam,cr in found:
    if any(abs(th-s)<1e-6 for s in seen): continue
    seen.append(th)
    mx=lp.pinned_lp(lam,n,True); mn=lp.pinned_lp(lam,n,False)
    print('theta=%.6f  distinct-eig=%2d  crit=%.1e   LP max=%s  LP min=%s   gap=%s'
          %(th,nd,cr,('%.6f'%mx) if mx is not None else 'INFEAS',('%.6f'%mn) if mn is not None else 'INFEAS',
            ('%.6f'%(mx-th)) if mx is not None else '-'))
    print('     lmin=%.6f lmax=%.6f  L70=%.6f  PI=%.6f'%(lam[0],lam[-1],lam[0]+(n-2)*lam[-1],(n-1)*abs(lam[0])))
