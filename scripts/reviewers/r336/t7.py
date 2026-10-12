import sys; sys.path.insert(0,'scripts/reviewers/r336')
import numpy as np, fast, pts, itertools
np.set_printoptions(precision=6,suppress=True)

def pad(n,Ws,ns_):
    Ps=fast.pairs(ns_); Pb=fast.pairs(n); ix={p:a for a,p in enumerate(Pb)}; N=len(Pb)
    M=np.zeros((N,N))
    for a,pa in enumerate(Ps):
        for b,pb in enumerate(Ps): M[ix[pa],ix[pb]]=Ws[a,b]
    return M

def rowfam(lam,n):
    """min over rows a of the (C) row upper bound on theta; also the lower bounds."""
    N=len(lam); ub=np.inf; lb=-np.inf; arg=None
    for a in range(N):
        la=lam[a]
        if abs(la)<1e-12: continue
        rest=[lam[b] for b in range(N) if b!=a]
        prods=[]
        rs=sorted(rest)
        cand=[rs[0]*rs[-1],rs[0]*rs[1],rs[-1]*rs[-2]]
        ma=min(cand); Ma=max(cand)
        if la>0: u=la+(n-2)*Ma/la; l=la+(n-2)*ma/la
        else:    u=la+(n-2)*ma/la; l=la+(n-2)*Ma/la
        if u<ub: ub=u; arg=a
        lb=max(lb,l)
    return ub,lb,arg

def summarise(name,n,W,c):
    QW=fast.Q(W,c); th=float(np.sum(W*QW)); crit=np.linalg.norm(QW-th*W)
    lam=np.linalg.eigvalsh(W); lmin,lmax=lam[0],lam[-1]
    L70=lmin+(n-2)*lmax; PI=(n-1)*abs(lmin)
    ub,lb,arg=rowfam(lam,n)
    print('%-18s n=%d theta=%.6f crit=%.1e | L70=%.6f  PI=%.6f  ROWFAM=%.6f (row %d, lam=%.6f)  lower=%.6f'
          %(name,n,th,crit,L70,PI,ub,arg,lam[arg],lb))
    print('%20s ker dim=%d  lmin=%.6f (mult %d)  lmax=%.6f (mult %d)  lmax/|lmin|=%.6f'
          %('',int(np.sum(np.abs(lam)<1e-9)),lmin,int(np.sum(np.isclose(lam,lmin,atol=1e-9))),lmax,int(np.sum(np.isclose(lam,lmax,atol=1e-9))),lmax/abs(lmin)))
    return th,lam

# CP^2 at n=4
c4=fast.struct(4); W4=pts.make(4,pts.u_m(4)); summarise('CP^2 (n=4)',4,W4,c4)
# padded into n=6,8
for n in [6,8]:
    c=fast.struct(n)
    Wp=fast.weyl_proj(n,pad(n,W4,4)); Wp=(Wp+Wp.T)/2; Wp/=np.linalg.norm(Wp)
    summarise('padded W_CP2',n,Wp,c)
for n in [6,8]:
    c=fast.struct(n); m=n//2
    summarise('CP^%d'%m,n,pts.make(n,pts.u_m(n)),c)
    summarise('max torus',n,pts.make(n,pts.cartan(n)),c)
    summarise('S^%dxS^%d'%(m,m),n,pts.make(n,pts.block_alg(n,[list(range(m)),list(range(m,n))])),c)
