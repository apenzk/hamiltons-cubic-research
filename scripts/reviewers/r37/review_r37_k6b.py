"""Is 'Weyl_n cap (pp,mix) block = X_p (x) R^q' free?  Test whether the first-Bianchi
obstruction is carried exactly by the Lambda^3 piece and the Ricci obstruction exactly
by the R^p piece."""
import sys; sys.path.insert(0, 'scripts/lib')
import numpy as np
from itertools import combinations
from review_r37_core import *
from review_r37_k1 import mask_ppmix

for (p,q) in [(3,4),(4,4),(4,5),(5,4),(3,6)]:
    n=p+q; A=struct_A(n); N=A.shape[0]; Ip=I_block(p,q,'p'); mask=mask_ppmix(p,q)
    P,idx=pair_index(n)
    def bian(M): return np.sqrt(sum((tensor_entry(M,idx,i,j,k,l)-tensor_entry(M,idx,i,k,j,l)+tensor_entry(M,idx,i,l,j,k))**2 for (i,j,k,l) in combinations(range(n),4)))
    def ric(M):  return np.sqrt(sum(sum(tensor_entry(M,idx,i,j,k,j) for j in range(n))**2 for i in range(n) for k in range(n)))
    bas=[]
    for a in range(N):
        for b in range(a+1,N):
            if mask[a,b]:
                E=np.zeros((N,N)); E[a,b]=E[b,a]=1/np.sqrt(2.0); bas.append(E)
    bas=np.array(bas); d=bas.shape[0]
    M=np.zeros((d,d))
    for j in range(d): M[:,j]=coords(bas, sharp_bilin(Ip,bas[j],A))
    w,v=np.linalg.eigh(0.5*(M+M.T))
    print(f"({p},{q}) raw block dim {d}")
    for lam in sorted(set(np.round(w,9))):
        sel=v[:, np.abs(w-lam)<1e-8]
        E=np.einsum('kd,dij->kij', sel.T, bas)
        bmax=max(bian(X) for X in E); rmax=max(ric(X) for X in E)
        name={1.0:'Lambda^3 (x) R^q', -0.5:'X_p (x) R^q'}.get(lam, 'R^p (x) R^q')
        print(f"    eig {lam:+.4f} mult {sel.shape[1]:4d}  {name:18s}  max|Bianchi| {bmax:.3e}  max|Ric| {rmax:.3e}")
