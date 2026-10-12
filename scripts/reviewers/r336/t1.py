import sys; sys.path.insert(0,'scripts/reviewers/r336')
import numpy as np, w
np.random.seed(336)
for n in [5,6,7]:
    P,idx,ns=w.weyl_basis(n); N=len(P); c=w.struct(n)
    # (A) off Weyl entirely: row mass
    T=c**2
    print('n=%d  row mass sum_bc T_abc ='%n, np.unique(np.round(T.sum(axis=(1,2)),10)), ' 2(n-2)=',2*(n-2))
    # random Weyl tensor
    v=ns@np.random.randn(ns.shape[1]); M=w.coords_to_mat(v,idx,N); M=(M+M.T)/2
    M/= np.sqrt(np.sum(M*M))
    lam,U=np.linalg.eigh(M)
    cp=np.einsum('ia,jb,kc,ijk->abc',U,U,U,c)
    Tp=cp**2
    B=np.einsum('b,abc->a',lam,Tp)
    print('   (B) resid max |sum_bc lam_b T_abc + 2 lam_a| =', np.abs(B+2*lam).max())
    # Q preserves Weyl?
    QM=w.Q(M,c)
    qv=np.array([QM[a,b] for (a,b) in idx])
    # project onto Weyl coordinate space: need coordinate rep; use residual of QM against span
    # build matrix basis
    Bm=np.array([w.coords_to_mat(ns[:,k],idx,N) for k in range(ns.shape[1])])
    Bm=Bm.reshape(ns.shape[1],-1)
    G=Bm@Bm.T; rhs=Bm@QM.reshape(-1)
    coef=np.linalg.solve(G,rhs)
    res=QM.reshape(-1)-coef@Bm
    print('   Q(W) off Weyl residual =', np.linalg.norm(res), ' ||Q||=',np.linalg.norm(QM))
