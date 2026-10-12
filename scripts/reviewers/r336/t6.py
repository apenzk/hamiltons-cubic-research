import sys; sys.path.insert(0,'scripts/reviewers/r336')
import numpy as np, fast, pts
from scipy.optimize import minimize
np.random.seed(336)
for n in [5,6,7,8]:
    P,N,q=fast.weyl_ortho(n); c=fast.struct(n); D=q.shape[1]
    def ratio(x):
        W=(q@x).reshape(N,N); W=(W+W.T)/2; nn=np.linalg.norm(W); W/=nn
        lam=np.linalg.eigvalsh(W); return lam[-1]/abs(lam[0])
    best=(-1,None)
    for t in range(30):
        x0=np.random.randn(D)
        r=minimize(lambda x:-ratio(x),x0,method='Nelder-Mead',
                   options={'maxiter':20000,'maxfev':20000,'fatol':1e-12,'xatol':1e-10})
        if -r.fun>best[0]: best=(-r.fun,r.x)
    val,x=best
    W=(q@x).reshape(N,N); W=(W+W.T)/2; W/=np.linalg.norm(W)
    QW=fast.Q(W,c); th=float(np.sum(W*QW)); crit=np.linalg.norm(QW-th*W)
    lam=np.linalg.eigvalsh(W)
    print('n=%d  max over Weyl_n of lmax/|lmin| = %.6f   (n-2 = %d)   at that point: theta=%.6f crit-resid=%.3e'%(n,val,n-2,th,crit))
    print('     spectrum multiplicities:',[(round(v,5),int(np.sum(np.isclose(lam,v,atol=1e-6)))) for v in sorted(set(np.round(lam,5)))])
