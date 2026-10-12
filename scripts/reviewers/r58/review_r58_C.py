import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r58_core import *
from review_r58_secondkind import circ
from review_r58_iii import weyl4_12

print('lam_max(L_e) on the Weyl_n directions leaving the padding  (C<=0  <=>  this <= 1/2)')
print('  q     r      n   theta      dim(leaving)  lam_max(L_e)   C = 3*lam - 1.5*theta ... sign')
for (q,r) in [(1,1),(1,0.7),(1,0.5),(1,0.4),(1,0.3),(2,0.3),(1,0.1)]:
    for n in [6]:
        W=pad(weyl4_12(q,r),4,n); th=theta(W,n); e=W/th
        B=weyl_basis(n); d=len(B); N=n*(n-1)//2; pr=pairs(n)
        u=n-1
        # directions in Weyl_n orthogonal to the padded Weyl_{n-1} subspace
        B5=weyl_basis(n-1); P5=np.array([pad(b,n-1,n).reshape(-1) for b in B5])
        f=B.reshape(d,-1)
        Gram=f@P5.T
        U_,s_,Vt=np.linalg.svd(Gram, full_matrices=True)
        rk=int(np.sum(s_>1e-9)); C_=U_[:,rk:].T
        E=np.einsum('kd,dij->kij',C_,B)
        fl=E.reshape(len(E),-1); qq,_=np.linalg.qr(fl.T); E=qq.T.reshape(-1,N,N)
        L=np.zeros((len(E),len(E)))
        for k in range(len(E)):
            LX=circ(e,E[k],n)
            for l in range(len(E)): L[l,k]=np.sum(E[l]*LX)
        L=0.5*(L+L.T)
        lm=np.linalg.eigvalsh(L)[-1]
        Cval=3*lm-1.5
        print('  %.1f   %.2f   %d   %.6f     %3d        %.9f     C/theta = %+.6f   %s'%(
            q,r,n,th,len(E),lm,Cval,'C>0 : PERTURBING OFF THE PADDING RAISES theta' if lm>0.5+1e-9 else 'C<=0'))
