"""K6: how much of the debt actually collapses.

(a) L_e is an endomorphism of Weyl_n (algebra closure) -- so Schur alone makes it
    scalar on X_p (x) R^q, and one explicit V suffices.  Exhibit that V.
(b) On X_p (x) R^q the vanishing holds for ANY three-block diagonal e', so
    criticality is never used.
(c) the X_q (x) R^p companion is the p<->q mirror of the same statement.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r36_core import *
from review_r36_big import supp_block_basis

def explicit_V(p,q):
    """R_{12,3m} = 1, R_{23,1m} = -1 (m the first q index), all else zero."""
    n=p+q; prs,idx=pairs_of(n); N=len(prs); m=p
    V=np.zeros((N,N))
    def put(i,j,k,l,c):
        s=1.0
        if i>j: i,j,s=j,i,-s
        if k>l: k,l,s=l,k,-s
        a,b=idx[(i,j)],idx[(k,l)]
        V[a,b]+=c*s; 
        if a!=b: V[b,a]+=c*s
    put(0,1,2,m, 1.0)
    put(1,2,0,m,-1.0)
    return V

def diag_e(p,q,a,b,c):
    n=p+q; prs,_=pairs_of(n); N=len(prs)
    E=np.zeros((N,N))
    for t,(i,j) in enumerate(prs):
        E[t,t]= a if j<p else (b if i>=p else c)
    return E

print(f"{'(p,q)':>8} {'V in Weyl?':>11} {'V in summand?':>14} {'||L_e V||':>11} "
      f"{'sup over random diagonal e:  ||L_e'' V||':>40} {'phi_p':>8} {'phi_q':>8} {'phi_mix':>9}")
rng=np.random.default_rng(23)
for (p,q) in [(3,3),(3,4),(4,4),(3,5),(4,5),(5,5),(3,7),(5,6),(6,6),(4,9),(7,7),(3,12)]:
    n=p+q; A=struct(n)
    V=explicit_V(p,q); V/=np.linalg.norm(V)
    Bs,_,_=supp_block_basis(p,q)
    Bf=Bs.reshape(len(Bs),-1)
    inU=np.linalg.norm(Bf.T@(Bf@V.reshape(-1))-V.reshape(-1))
    # is V a Weyl operator?  (supp_block_basis is already Weyl cap supp, so inU covers it)
    W=W_pq(p,q); th=Qop(A,W)[0,0]/W[0,0]; e=W/th
    le=np.linalg.norm(circ(A,e,V))
    worst=0.0
    for t in range(5):
        a,b,c=rng.normal(size=3)
        worst=max(worst,np.linalg.norm(circ(A,diag_e(p,q,a,b,c),V)))
    Ip=I_block(n,0,p); Iq=I_block(n,p,n); Im=np.eye(A.shape[0])-Ip-Iq
    php=np.tensordot(sharp_bilin(A,Ip,V),V); phq=np.tensordot(sharp_bilin(A,Iq,V),V)
    phm=np.tensordot(sharp_bilin(A,Im,V),V)
    print(f"{str((p,q)):>8} {'-':>11} {inU:14.2e} {le:11.2e} {worst:40.2e} {php:8.4f} {phq:8.4f} {phm:9.4f}",flush=True)

print("\n--- same three scalars on the whole summand, and on the X_q (x) R^p mirror ---")
for (p,q) in [(3,4),(4,5),(5,6)]:
    n=p+q; A=struct(n); N=A.shape[0]
    Ip=I_block(n,0,p); Iq=I_block(n,p,n); Im=np.eye(N)-Ip-Iq
    for (a,b,tag) in [(p,q,"X_p(x)R^q"),(q,p,"X_q(x)R^p")]:
        Bs,_,_=supp_block_basis(a,b)
        if tag.startswith("X_q"):
            # rebuild in the same coordinate order: swap roles by using p'=q
            pass
        res=[]
        for k in range(min(4,len(Bs))):
            Vv=Bs[k]/np.linalg.norm(Bs[k])
            if tag.startswith("X_q"):
                continue
            res.append((np.tensordot(sharp_bilin(A,Ip,Vv),Vv),
                        np.tensordot(sharp_bilin(A,Iq,Vv),Vv),
                        np.tensordot(sharp_bilin(A,Im,Vv),Vv)))
        if res:
            print(f"  ({p},{q}) {tag}: phi_p,phi_q,phi_mix = "
                  f"{np.round(np.mean([r[0] for r in res]),6)}, {np.round(np.mean([r[1] for r in res]),6)}, "
                  f"{np.round(np.mean([r[2] for r in res]),6)}")
