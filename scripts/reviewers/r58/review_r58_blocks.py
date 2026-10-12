"""Is block (a) L_e-invariant inside Weyl_n? (FINDINGS says the blocks are not.)"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r58_core import *
from review_r58_secondkind import circ
for n in [6,8]:
    W=pad(wcp2(),4,n); th=theta(W,n); e=W/th
    B=weyl_basis(n); d=len(B); N=n*(n-1)//2
    pr=pairs(n); pidx={p:a for a,p in enumerate(pr)}
    u=n-1; A_idx=set(pidx[(i,u)] for i in range(n-1))
    # directions leaving the padding: Weyl_n orthogonal to the padded block
    f=B.reshape(d,-1)
    padmask=np.zeros((N,N))
    inb=[a for a,p in enumerate(pr) if u not in p]
    for a in inb:
        for b in inb: padmask[a,b]=1.0
    # project the Weyl basis onto "leaving the padding" = entries touching u
    G=np.array([ (Bd*(1-padmask)).reshape(-1) for Bd in B])
    # subspace of Weyl_n whose padded-block part vanishes
    Mp=np.array([ (Bd*padmask).reshape(-1) for Bd in B])
    uu,ss,vt=np.linalg.svd(Mp)
    k=int(np.sum(ss>1e-9)); leave=vt[k:] if False else None
    # nullspace of Mp^T acting on coefficients: coefficients x with sum x_d (B_d*padmask)=0
    u2,s2,v2=np.linalg.svd(Mp.T@ (0*Mp.T).T) if False else (None,None,None)
    U_,S_,Vt_=np.linalg.svd(Mp, full_matrices=True)
    rk=int(np.sum(S_>1e-9))
    coef=Vt_[rk:] if Mp.shape[0]>=Mp.shape[1] else None
    # solve directly: coefficients x in R^d with Mp^T x = 0  -> nullspace of Mp^T? Mp is (d, N*N)
    A_=Mp.T                      # (N*N, d)
    _,sA,VA=np.linalg.svd(A_)
    rA=int(np.sum(sA>1e-9))
    Xs=VA[rA:]                   # (dim, d)
    print('n=%d  dim Weyl=%d  directions leaving the padding = %d'%(n,d,len(Xs)))
    E=np.einsum('kd,dij->kij',Xs,B)
    # orthonormalise
    fl=E.reshape(len(E),-1); qq,_=np.linalg.qr(fl.T); E=qq.T.reshape(-1,N,N)
    # split into block (a) [supported on u^u-perp] and block (b)
    a_part=[]; b_part=[]
    for k_ in range(len(E)):
        Ea=E[k_].copy()
        m=np.zeros((N,N))
        for i in A_idx:
            for j in A_idx: m[i,j]=1
        na=np.sum((Ea*m)**2); nb=np.sum(Ea**2)-na
        (a_part if nb<1e-12 else (b_part if na<1e-12 else b_part)).append(k_)
    # build L_e matrix on the leaving subspace
    L=np.zeros((len(E),len(E)))
    for k_ in range(len(E)):
        LX=circ(e,E[k_],n)
        for l_ in range(len(E)): L[l_,k_]=np.sum(E[l_]*LX)
    L=0.5*(L+L.T)
    print('   lam_max(L_e) on the whole padding-leaving subspace = %.9f'%np.linalg.eigvalsh(L)[-1])
    # block a = span of E supported on u^u-perp: build it directly
    m=np.zeros((N,N))
    for i in A_idx:
        for j in A_idx: m[i,j]=1
    Pa=np.array([ (E[k_]*m).reshape(-1) for k_ in range(len(E))])
    ua,sa,va=np.linalg.svd(Pa,full_matrices=False)
    dimA=int(np.sum(sa>1e-9))
    # orthonormal basis of Weyl-directions lying entirely in block (a)
    # = nullspace of the "block b" part
    Pb=np.array([ (E[k_]*(1-m)).reshape(-1) for k_ in range(len(E))])
    _,sb,vb=np.linalg.svd(Pb.T)
    rb=int(np.sum(sb>1e-9)); Ca=vb[rb:]
    print('   dim(Weyl-directions lying wholly in block (a)) = %d   (n-1)(n+2)/2 = %d'%(len(Ca),(n-1)*(n+2)//2))
    if len(Ca):
        La=Ca@L@Ca.T; print('   lam_max(L_e) on block (a)  = %.9f'%np.linalg.eigvalsh(0.5*(La+La.T))[-1])
        # complement
        Q_,_=np.linalg.qr(np.eye(len(E))-Ca.T@Ca)
        rest=np.linalg.svd(np.eye(len(E))-Ca.T@Ca)[0][:, :len(E)-len(Ca)].T
        Lb=rest@L@rest.T; print('   lam_max(L_e) on block (b)  = %.9f'%np.linalg.eigvalsh(0.5*(Lb+Lb.T))[-1])
        off=Ca@L@rest.T; print('   || block(a)-block(b) coupling of L_e || = %.3e'%np.max(np.abs(off)))
