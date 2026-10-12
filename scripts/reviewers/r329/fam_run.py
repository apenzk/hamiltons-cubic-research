import sys; sys.path.insert(0,'scripts/reviewers/r329')
import numpy as np, itertools; from core import *; from families import *
from core import _pairidx
def report(n,name,W,c,Bo):
    nr=np.linalg.norm(W)
    if nr<1e-12: return
    W=W/nr; d=crit_data(W,c,n,Bo)
    ev=d['ev']; nk=int((np.abs(ev)<1e-9).sum())
    print("n=%2d %-26s theta=%+.6f crit=%.2e distWn=%.2e slack=%+.9f ker=%d nev=%d"%(
        n,name,d['theta'],d['res'],d['dist'],d['slack'],nk,len(np.unique(np.round(ev,7)))),flush=True)
for n in (5,6,7,8):
    idx,B,c=struct_consts(n); Bo=weyl_basis(n)
    for p in range(2,n//2+1):
        q=n-p; report(n,"so(%d)+so(%d)"%(p,q),W_from_h(n,h_blocks(n,[0]*p+[1]*q)),c,Bo)
    blocks=[i//2 for i in range(n)] if n%2==0 else [i//2 for i in range(n-1)]+[(n-1)//2]
    report(n,"max torus",W_from_h(n,h_blocks(n,blocks)),c,Bo)
    for p in range(2,n):
        for q in range(p,n):
            r=n-p-q
            if r<q or r<1: continue
            report(n,"so(%d)+so(%d)+so(%d)"%(p,q,r),W_from_h(n,h_blocks(n,[0]*p+[1]*q+[2]*r)),c,Bo)
    if n%2==0:
        m=n//2; J=np.zeros((n,n))
        for i in range(m): J[2*i,2*i+1]=1; J[2*i+1,2*i]=-1
        _,Bb=so_basis(n); N=len(idx)
        Wu,k=W_subalg_from_mats(n,[Bb[a]+J@Bb[a]@J.T for a in range(N)])
        report(n,"u(%d)"%m,Wu,c,Bo)
    for m in range(2,n//2+1):
        Wc=W_cp(n,m); Wc=dist_weyl(Wc,Bo)[1]
        if np.linalg.norm(Wc)>1e-10: report(n,"CP^%d padded"%m,Wc,c,Bo)
    Bo4=weyl_basis(4); Wc4=W_cp(4,2); Wc4=dist_weyl(Wc4,Bo4)[1]; Wc4/=np.linalg.norm(Wc4)
    idx4=_pairidx(4); idxn=_pairidx(n); pos={p:a for a,p in enumerate(idxn)}
    Wp=np.zeros((len(idxn),len(idxn)))
    for a,pa in enumerate(idx4):
        for b,pb in enumerate(idx4): Wp[pos[pa],pos[pb]]=Wc4[a,b]
    report(n,"padded W_CP2",Wp,c,Bo)
    Ws4=W_from_h(4,h_blocks(4,[0,0,1,1]))
    Wp2=np.zeros((len(idxn),len(idxn)))
    for a,pa in enumerate(idx4):
        for b,pb in enumerate(idx4): Wp2[pos[pa],pos[pb]]=Ws4[a,b]
    report(n,"padded S2xS2",Wp2,c,Bo)
