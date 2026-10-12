"""Final K4 attack: the explicit counterexample, sb(I_q,.) on the raw block, and
the eigenvalue formula on Lambda^2(R^p) (x) R^p (x) R^q."""
import sys; sys.path.insert(0, 'scripts/lib')
import numpy as np
from review_r37_core import *
from review_r37_k1 import mask_ppmix

print("COUNTEREXAMPLE to K4 as stated: V = W itself, a multiplicity-one summand <W> of Weyl_n.")
for (p,q) in [(3,4),(4,4),(4,5),(5,5),(3,5)]:
    n=p+q; A=struct_A(n); B=weyl_basis(n); N=A.shape[0]
    W=W_pq(p,q); Wn=W/np.linalg.norm(W); Ip=I_block(p,q,'p')
    S=sharp_bilin(Ip,Wn,A)
    c=ip(S,Wn)
    par=np.linalg.norm(S-c*Wn)
    inW=np.linalg.norm(S-expand(B,coords(B,S)))
    print(f"  ({p},{q}): sb(I_p,W)= {c:+.6f} W + R,  |R|={par:.4f} (|W|=1),  of which {inW:.4f} lies outside Weyl_n"
          f"   -> sb(I_p,.) is NOT a scalar on <W>", flush=True)

print()
print("sharp_bilin(I_q, .) on the RAW (pp,mix) block -- is it identically zero (pure grading)?")
for (p,q) in [(3,4),(4,4),(4,5),(5,5),(3,6)]:
    n=p+q; A=struct_A(n); N=A.shape[0]; Iq=I_block(p,q,'q'); mask=mask_ppmix(p,q)
    rng=np.random.default_rng(3)
    R=rng.normal(size=(N,N)); V=(R+R.T)*mask
    S=sharp_bilin(Iq,V,A)
    print(f"  ({p},{q}): |sb(I_q,V)|/|V| on raw block = {np.linalg.norm(S)/np.linalg.norm(V):.2e}")

print()
print("eigenvalues of sb(I_p,.) on the raw block vs prediction {1 on Lambda^3, -1/2 on X_p, (p-2)/2 on R^p}")
for (p,q) in [(3,4),(4,6),(5,4),(6,3),(7,3)]:
    n=p+q
    if n>10: continue
    A=struct_A(n); N=A.shape[0]; Ip=I_block(p,q,'p'); mask=mask_ppmix(p,q)
    bas=[]
    for a in range(N):
        for b in range(a+1,N):
            if mask[a,b]:
                E=np.zeros((N,N)); E[a,b]=E[b,a]=1/np.sqrt(2.0); bas.append(E)
    bas=np.array(bas); d=bas.shape[0]
    M=np.zeros((d,d))
    for j in range(d): M[:,j]=coords(bas, sharp_bilin(Ip,bas[j],A))
    w=np.linalg.eigvalsh(0.5*(M+M.T))
    vals,cnt=np.unique(np.round(w,9),return_counts=True)
    pred=sorted([(1.0, p*(p-1)*(p-2)//6*q), (-0.5, p*(p*p-4)//3*q), ((p-2)/2, p*q)])
    print(f"  ({p},{q}) d={d}: measured {[(float(x),int(c)) for x,c in zip(vals,cnt)]}   predicted {pred}", flush=True)
