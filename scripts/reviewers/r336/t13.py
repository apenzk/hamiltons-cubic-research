import sys; sys.path.insert(0,'scripts/reviewers/r336')
import numpy as np, fast, pts, lp
n=6
print('two-eigenvalue family at n=6: r copies of a>0, 15-r of b<0, traceless')
print(' r  lmax/|lmin|  Lemma73 ok   pinned LP feasible')
for r in range(1,15):
    lam=np.array([ (15-r)/r ]*r + [-1.0]*(15-r)); lam=lam/np.linalg.norm(lam); lam=np.sort(lam)
    ok = (lam[-1]<=4*abs(lam[0])+1e-12) and (abs(lam[0])<=4*lam[-1]+1e-12)
    v=lp.pinned_lp(lam,n,True)
    print(' %2d   %8.4f     %-5s        %s'%(r,lam[-1]/abs(lam[0]),ok,'yes (max th=%.4f)'%v if v is not None else 'INFEASIBLE'))
print()
print('sphere products S^k x S^(n-k): is Lemma 73 slack?')
for n2 in [8,10]:
    c=fast.struct(n2)
    for k in range(3,n2//2+1):
        W=pts.make(n2,pts.block_alg(n2,[list(range(k)),list(range(k,n2))]))
        QW=fast.Q(W,c); th=float(np.sum(W*QW)); lam=np.linalg.eigvalsh(W)
        print('  n=%2d k=%d  theta=%.6f crit=%.1e  lmax/|lmin|=%.4f  |lmin|/lmax=%.4f   (n-2=%d)'
              %(n2,k,th,np.linalg.norm(QW-th*W),lam[-1]/abs(lam[0]),abs(lam[0])/lam[-1],n2-2))
