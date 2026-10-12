import sys; sys.path.insert(0,'scripts/reviewers/r336')
import numpy as np, w
def report(name,n,mats,P,proj,c):
    M=w.subalg_proj(n,mats,P); W=proj(M); W=(W+W.T)/2; W/=np.linalg.norm(W)
    QW=w.Q(W,c); th=np.sum(W*QW)
    crit=np.linalg.norm(QW-th*W)
    lam=np.linalg.eigvalsh(W)
    lmax,lmin=lam[-1],lam[0]
    th0=np.sqrt(2*(n-1)*(n-2))/n
    print('%-22s n=%2d  theta=%.6f (theta0=%.6f)  crit-resid=%.2e  lmax=%.6f lmin=%.6f  lmax/|lmin|=%.6f  |lmin|/lmax=%.6f   n-2=%d'
          %(name,n,th,th0,crit,lmax,lmin,lmax/abs(lmin),abs(lmin)/lmax,n-2))
    return lam
for n in [6,8,10,12]:
    P,idx,proj,N=w.weyl_proj_maker(n); c=w.struct(n)
    m=n//2
    report('CP^%d (u(%d))'%(m,m),n,w.u_m(n),P,proj,c)
    report('max torus so(2)^%d'%m,n,w.cartan(n),P,proj,c)
    report('S^%d x S^%d'%(m,m),n,w.block_alg(n,[list(range(m)),list(range(m,n))]),P,proj,c)
    print()
