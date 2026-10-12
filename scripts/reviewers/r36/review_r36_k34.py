"""K2/K3/K4/K5: what sharp_bilin(I_p,.) does on each of the ten summands."""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r36_core import *
from review_r36_summands import summands, predicted_dims, casimir_block

def support_masks(n,p):
    prs,_=pair_index=pairs_of(n)
    N=len(prs)
    def ty(a):
        i,j=prs[a]
        return 0 if j<p else (2 if i>=p else 1)   # 0 pp, 1 mix, 2 qq
    M={}
    for s in [(0,0),(0,1),(0,2),(1,1),(1,2),(2,2)]:
        m=np.zeros((N,N))
        for a in range(N):
            for b in range(N):
                if tuple(sorted((ty(a),ty(b))))==s: m[a,b]=1
        M[s]=m
    return M

def label(supp, cas_p, cas_q, dim, p, q):
    return None

def run(p,q):
    n=p+q
    B,ops,groups,D=summands(p,q)
    N=B.shape[1]; A=struct(n)
    Ip=I_block(n,0,p); Iq=I_block(n,p,n)
    Bf=B.reshape(D,N*N)
    masks=support_masks(n,p)
    W=W_pq(p,q); th=Qop(A,W)[0,0]/W[0,0]; e=W/th
    Le=L_matrix(A,B,e)
    print(f"\n================ (p,q)=({p},{q})  n={n}  dim Weyl={D} ================")
    print(f"{'dim':>4} {'supp profile (pp,pp)(pp,mx)(pp,qq)(mx,mx)(mx,qq)(qq,qq)':>58} {'Cas_p':>8} {'Cas_q':>8} {'L_e':>18} {'sb(Ip,.) scalar?':>18} {'out-of-Weyl':>12}")
    rows=[]
    for val,U in groups:
        d=U.shape[1]
        Vs=[np.tensordot(U[:,k],B,axes=1) for k in range(d)]
        prof=[]
        for s in [(0,0),(0,1),(0,2),(1,1),(1,2),(2,2)]:
            num=sum(np.sum((V*masks[s])**2) for V in Vs); den=sum(np.sum(V**2) for V in Vs)
            prof.append(num/den)
        cp=(U.T@ops[0][1]@U); cq=(U.T@ops[1][1]@U)
        cpv=np.trace(cp)/d; cqv=np.trace(cq)/d
        # L_e on the summand
        Lsub=U.T@Le@U
        lev=np.trace(Lsub)/d
        lescal=np.abs(Lsub-lev*np.eye(d)).max()
        # sharp_bilin(I_p,.) on the summand
        resid_scalar=0.0; resid_out=0.0; ratios=[]
        Ys=[sharp_bilin(A,Ip,V) for V in Vs]
        # best scalar fit c with sum ||Y - c V||^2 minimal
        num=sum(np.tensordot(Y,V) for Y,V in zip(Ys,Vs)); den=sum(np.tensordot(V,V) for V in Vs)
        c=num/den
        rs=np.sqrt(sum(np.linalg.norm(Y-c*V)**2 for Y,V in zip(Ys,Vs))/sum(np.linalg.norm(Y)**2 for Y in Ys))
        ro=np.sqrt(sum(np.linalg.norm(Y-(Bf.T@(Bf@Y.reshape(N*N))).reshape(N,N))**2 for Y in Ys)
                   /sum(np.linalg.norm(Y)**2 for Y in Ys))
        # Weyl-projected map scalar?
        Ycoef=np.array([Bf@Y.reshape(N*N) for Y in Ys]).T   # D x d
        Psub=U.T@Ycoef
        pv=np.trace(Psub)/d
        pscal=np.abs(Psub-pv*np.eye(d)).max()
        pout=np.linalg.norm(Ycoef-U@Psub)/max(np.linalg.norm(Ycoef),1e-30)
        rows.append((d,prof,cpv,cqv,lev,lescal,c,rs,ro,pv,pscal,pout))
    rows.sort(key=lambda r:-r[0])
    for (d,prof,cpv,cqv,lev,lescal,c,rs,ro,pv,pscal,pout) in rows:
        ps=" ".join(f"{x:5.2f}" for x in prof)
        print(f"{d:4d} {ps:>58} {cpv:8.3f} {cqv:8.3f} {lev:9.5f}(dev {lescal:5.0e}) "
              f"c={c:7.4f} rel-resid {rs:8.2e} outWeyl {ro:8.2e} | Pweyl scalar {pv:7.4f} dev {pscal:.1e} leaks {pout:.1e}")
    return rows

if __name__=="__main__":
    for pq in [(3,4),(4,4),(3,5),(4,5)]:
        run(*pq)
