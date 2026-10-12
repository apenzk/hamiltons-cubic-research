import sys; sys.path.insert(0,'scripts/reviewers/r336')
import numpy as np, w, itertools
from scipy.linalg import null_space
np.random.seed(7)
n=6
P=w.pairs(n); N=len(P); c=w.struct(n)
idx=[(a,b) for a in range(N) for b in range(a,N)]
def build(bianchi,ricci):
    cons=[]
    for k in range(len(idx)):
        M=np.zeros((N,N)); a,b=idx[k]; M[a,b]=1.0; M[b,a]=1.0
        R=w.op_to_tensor(M,n,P); v=[]
        if bianchi:
            for i,j,k2,l in itertools.combinations(range(n),4):
                v.append(R[i,j,k2,l]+R[i,k2,l,j]+R[i,l,j,k2])
        if ricci:
            for i in range(n):
                for k2 in range(i,n):
                    v.append(sum(R[i,j,k2,j] for j in range(n)))
        cons.append(v)
    C=np.array(cons).T
    return null_space(C) if C.size else np.eye(len(idx))
def testB(ns,label):
    worst=0
    for _ in range(6):
        v=ns@np.random.randn(ns.shape[1]); M=w.coords_to_mat(v,idx,N); M=(M+M.T)/2
        M/=np.sqrt(np.sum(M*M))
        lam,U=np.linalg.eigh(M)
        cp=np.einsum('ia,jb,kc,ijk->abc',U,U,U,c); Tp=cp**2
        B=np.einsum('b,abc->a',lam,Tp)
        worst=max(worst,np.abs(B+2*lam).max())
    print('%-28s dim=%3d   max |(B) residual| = %.3e'%(label,ns.shape[1],worst))
testB(build(True,True),'Weyl (Bianchi+Ricci)')
testB(build(True,False),'alg curvature (Bianchi only)')
testB(build(False,True),'Ricci-flat only')
testB(build(False,False),'Sym^2(Lambda^2), no cond')
