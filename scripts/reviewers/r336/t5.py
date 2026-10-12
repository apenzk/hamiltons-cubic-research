import sys; sys.path.insert(0,'scripts/reviewers/r336')
import numpy as np, fast, pts
def rep(name,n,W,c):
    QW=fast.Q(W,c); th=float(np.sum(W*QW)); crit=np.linalg.norm(QW-th*W)
    lam=np.round(np.linalg.eigvalsh(W),12); lmax,lmin=lam[-1],lam[0]
    th0=np.sqrt(2*(n-1)*(n-2))/n
    # strengthened: two largest / two smallest
    s_lo=(lam[-1]+lam[-2])/2   # cap on E[X] for row argmin
    s_hi=(lam[0]+lam[1])/2
    print('%-20s n=%2d th=%9.6f th0=%9.6f crit=%8.1e | lmax=%9.6f lmin=%9.6f  lmax/|lmin|=%8.4f |lmin|/lmax=%8.4f  (n-2=%d)'
          %(name,n,th,th0,crit,lmax,lmin,lmax/abs(lmin),abs(lmin)/lmax,n-2))
    print('%22s strengthened:  |lmin|/(n-2) = %.6f  <= (l1+l2)/2 = %.6f   [slack %.2e];   lmax/(n-2) = %.6f <= |(lN+lN-1)/2| = %.6f  [slack %.2e]'
          %('',abs(lmin)/(n-2),s_lo,s_lo-abs(lmin)/(n-2), lmax/(n-2), -s_hi, -s_hi-lmax/(n-2)))
    print('%22s distinct eigenvalues (mult): %s'%('',[(round(x,6),int(np.sum(np.isclose(lam,x,atol=1e-9)))) for x in sorted(set(np.round(lam,9)))]))
for n in [6,8,10]:
    c=fast.struct(n); m=n//2
    rep('CP^%d'%m,n,pts.make(n,pts.u_m(n)),c)
    rep('max torus',n,pts.make(n,pts.cartan(n)),c)
    rep('S^%dxS^%d'%(m,m),n,pts.make(n,pts.block_alg(n,[list(range(m)),list(range(m,n))])),c)
    print()
