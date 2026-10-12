"""K2/K3: the summand as ker L_e cap (pp,mix) support, its dimension, and the
constant on it.  Projector-based throughout -- no eigenvector filtering."""
import sys; sys.path.insert(0, 'scripts/lib')
import numpy as np
from review_r37_core import *
from review_r37_k1 import mask_ppmix, support_in_weyl

def run(p,q):
    n=p+q
    A=struct_A(n); B=weyl_basis(n); N=A.shape[0]; D=B.shape[0]
    W=W_pq(p,q); theta=ip(Qop(W,A),W)/ip(W,W); e=W/theta
    Ip=I_block(p,q,'p'); mask=mask_ppmix(p,q)
    # support subspace inside Weyl_n (projector compression, eigenvalue 1)
    Bs,_ = support_in_weyl(B, mask)
    d=Bs.shape[0]
    # is it inside ker L_e?
    maxLe = max(np.linalg.norm(circ(e,Bs[j],A)) for j in range(d)) if d else 0.0
    # dim of ker L_e cap support, computed as nullity of [L_e ; (1-P_supp)] on Weyl coords
    Me = operator_matrix(B, lambda V: circ(e,V,A))
    Ps = np.zeros((D,D))
    for j in range(D): Ps[:,j]=coords(B, mask*B[j])
    Ps=0.5*(Ps+Ps.T)
    Stack = np.vstack([Me, np.eye(D)-Ps])
    s=np.linalg.svd(Stack,compute_uv=False)
    nul=int((s<1e-8*max(1.0,s[0])).sum()) + (Stack.shape[1]-len(s))
    # constant on the summand: worst case over an orthonormal basis and 20 randoms
    worst=0.0; cmin=cmax=float('nan')
    if d:
        cs=[]
        rng=np.random.default_rng(500+p*10+q)
        tests=list(Bs)+[expand(Bs,rng.normal(size=d)) for _ in range(20)]
        for V in tests:
            S=sharp_bilin(Ip,V,A); nv=np.linalg.norm(V)
            worst=max(worst, np.linalg.norm(S+0.5*V)/nv)
            cs.append(ip(S,V)/ip(V,V))
        cmin,cmax=min(cs),max(cs)
    return d, nul, p*(p*p-4)//3*q, maxLe, worst, cmin, cmax

print(f"{'(p,q)':>7} {'n':>3} {'dimSupp':>8} {'nullity':>8} {'X(p)q':>7} {'max|L_e V|':>11} {'max|sb+V/2|/|V|':>16} {'c range':>26}")
for (p,q) in [(3,3),(3,4),(4,3),(3,5),(5,3),(4,4),(4,5),(5,4),(3,6),(6,3),(5,5),(4,6),(6,4),(3,7),(7,3),(5,6),(6,5)]:
    n=p+q
    if n>11: continue
    d,nul,pred,mx,worst,c0,c1=run(p,q)
    flag='OK' if (d==nul==pred) else '*** MISMATCH ***'
    print(f"({p},{q}) {n:3d} {d:8d} {nul:8d} {pred:7d} {mx:11.2e} {worst:16.2e}  [{c0:+.12f},{c1:+.12f}] {flag}", flush=True)
