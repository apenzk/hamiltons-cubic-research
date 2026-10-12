import sys; sys.path.insert(0,'scripts/reviewers/r336')
import numpy as np, fast, pts
from scipy.optimize import least_squares
np.random.seed(6336)
n=6; P,N,q=fast.weyl_ortho(n); c=fast.struct(n); D=q.shape[1]

# --- S1 nonvacuity: perturb CP^3 off the critical set, watch the ratio ---
W0=pts.make(n,pts.u_m(n))
print('S1 nonvacuity screen -- perturbing CP^3 inside Weyl_6 by a random Weyl direction:')
for t in [0.0,1e-3,1e-2,3e-2,1e-1]:
    V=(q@np.random.randn(D)).reshape(N,N); V=(V+V.T)/2; V/=np.linalg.norm(V)
    W=W0+t*V; W/=np.linalg.norm(W)
    lam=np.linalg.eigvalsh(W); QW=fast.Q(W,c); th=float(np.sum(W*QW))
    print('   t=%.3f  lmax/|lmin| = %.6f  (bound %d)  criticality residual = %.4f'%(t,lam[-1]/abs(lam[0]),n-2,np.linalg.norm(QW-th*W)))

# --- S5 validity at generic critical points, and the excluded-index refinement of L70 ---
def rowfam(lam,n,exclude=True):
    N=len(lam); ub=np.inf; arg=None
    for a in range(N):
        la=lam[a]
        if abs(la)<1e-12: continue
        rest=sorted([lam[b] for b in range(N) if b!=a]) if exclude else sorted(lam)
        cand=[rest[0]*rest[-1],rest[0]*rest[1],rest[-1]*rest[-2]]
        ma,Ma=min(cand),max(cand)
        u=la+(n-2)*(Ma if la>0 else ma)/la
        if u<ub: ub=u; arg=a
    return ub,arg
def res(x):
    W=(q@x).reshape(N,N); W=(W+W.T)/2; QW=fast.Q(W,c); th=float(np.sum(W*QW))
    return np.concatenate([q.T@(QW-th*W).reshape(-1),[np.sum(x*x)-1.0]])
print('\nS5 at generic critical points of Weyl_6  (all eigenvalues simple):')
cnt=0
for t in range(60):
    if cnt>=6: break
    s=least_squares(res,np.random.randn(D),xtol=1e-14,ftol=1e-14,gtol=1e-14,max_nfev=4000)
    if np.linalg.norm(s.fun)>1e-10: continue
    W=(q@s.x).reshape(N,N); W=(W+W.T)/2; W/=np.linalg.norm(W)
    QW=fast.Q(W,c); th=float(np.sum(W*QW))
    if th<1e-3: continue
    lam=np.linalg.eigvalsh(W)
    if len(set(np.round(lam,6)))<15: continue
    cnt+=1
    ub,a=rowfam(lam,n); L70=lam[0]+(n-2)*lam[-1]
    # excluded-index refinement of Lemma 70 alone (a = argmin row)
    rest=sorted(lam[1:]); L70x=lam[0]+(n-2)*min(rest[0]*rest[-1],rest[0]*rest[1],rest[-1]*rest[-2])/lam[0]
    print('  theta=%.6f | rowfam=%.6f (row lam=%.4f)  L70=%.6f  L70-excl=%.6f  PI=%.6f  |  valid: %s'
          %(th,ub,lam[a],L70,L70x,(n-1)*abs(lam[0]),'yes' if ub>=th-1e-9 else 'NO'))
