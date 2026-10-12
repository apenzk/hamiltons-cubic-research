"""K1 follow-up: full spectrum of V -> sharp_bilin(I_p,V) on the RAW (pp,mix)
support block, and a fairness check on 'generic V' over many seeds."""
import sys; sys.path.insert(0, 'scripts/lib')
import numpy as np
from review_r37_core import *
from review_r37_k1 import mask_ppmix, support_in_weyl

for (p,q) in [(3,4),(3,5),(4,4),(4,5),(5,5)]:
    n=p+q; A=struct_A(n); N=A.shape[0]
    Ip=I_block(p,q,'p'); mask=mask_ppmix(p,q)
    # orthonormal basis of raw symmetric matrices supported on the mask
    bas=[]
    k=kinds(p,q)
    for a in range(N):
        for b in range(a+1,N):
            if mask[a,b]:
                E=np.zeros((N,N)); E[a,b]=E[b,a]=1/np.sqrt(2.0); bas.append(E)
    bas=np.array(bas); d=bas.shape[0]
    M=np.zeros((d,d))
    for j in range(d): M[:,j]=coords(bas, sharp_bilin(Ip,bas[j],A))
    asym=np.linalg.norm(M-M.T)/np.linalg.norm(M)
    w,v=np.linalg.eigh(0.5*(M+M.T))
    vals,cnt=np.unique(np.round(w,9),return_counts=True)
    B=weyl_basis(n); Bs,_=support_in_weyl(B,mask)
    # is the -1/2 eigenspace exactly the Weyl-supported subspace?
    sel=v[:, np.abs(w+0.5)<1e-8]
    Ehalf=np.einsum('kd,dij->kij', sel.T, bas)
    # principal angles between span(Ehalf) and span(Bs)
    if Bs.shape[0] and Ehalf.shape[0]:
        G=np.einsum('aij,bij->ab', Ehalf, Bs)
        sv=np.linalg.svd(G,compute_uv=False)
    else: sv=np.array([])
    print(f"({p},{q}) raw block dim {d}, operator asym {asym:.1e}")
    print(f"    spectrum: {[(float(x),int(c)) for x,c in zip(vals,cnt)]}")
    print(f"    dim E(-1/2)={sel.shape[1]}  dim Weyl-supported={Bs.shape[0]}  X(p)q={p*(p*p-4)//3*q}  principal cosines min={sv.min() if sv.size else float('nan'):.9f} max={sv.max() if sv.size else float('nan'):.9f}", flush=True)

print()
print("fairness of 'generic V': 200 seeds at (4,4) -- distribution of best-fit c and residual")
p,q=4,4; n=8; A=struct_A(n); N=A.shape[0]; Ip=I_block(p,q,'p'); mask=mask_ppmix(p,q)
cs=[];rs=[]
rng=np.random.default_rng(7)
for _ in range(200):
    R=rng.normal(size=(N,N)); V=(R+R.T)*mask
    S=sharp_bilin(Ip,V,A); c=ip(S,V)/ip(V,V); cs.append(c)
    rs.append(np.linalg.norm(S-c*V)/np.linalg.norm(V))
cs=np.array(cs);rs=np.array(rs)
print(f"    c: mean {cs.mean():+.4f} sd {cs.std():.4f} min {cs.min():+.4f} max {cs.max():+.4f}")
print(f"    resid: mean {rs.mean():.4f} min {rs.min():.4f} max {rs.max():.4f}   (zero residuals: {(rs<1e-8).sum()})")
