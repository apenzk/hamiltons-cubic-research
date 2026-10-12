"""K5: does sharp_bilin(I_p,.) deviate from scalar exactly on merged L_e-eigenspaces?
K4 repair: does X_p (x) R^q occur inside (Weyl_n)^perp ?"""
import numpy as np, sys, collections
sys.path.insert(0, 'scripts/lib')
from review_r36_core import *
from review_r36_summands import summands, casimir_block, drho_matrix, adjoint_action_X, invariant_ops

def sym_basis(N):
    B=[]
    for a in range(N):
        for b in range(a,N):
            M=np.zeros((N,N))
            if a==b: M[a,a]=1.0
            else: M[a,b]=M[b,a]=1/np.sqrt(2)
            B.append(M)
    return np.array(B)

def perp_basis(n):
    N=n*(n-1)//2
    S=sym_basis(N); W=weyl_basis(n)
    Sf=S.reshape(len(S),N*N); Wf=W.reshape(len(W),N*N)
    C=Wf@Sf.T                      # (D x M) coords of Weyl basis in the sym basis
    G=C.T@C
    w,U=np.linalg.eigh(G)
    k=int(np.sum(w<1e-8))
    coef=U[:,:k].T                 # k x M
    return np.einsum('km,mij->kij',coef,S)

def analyse(p,q):
    n=p+q
    A=struct(n)
    B,ops,groups,D=summands(p,q)
    N=B.shape[1]; Bf=B.reshape(D,N*N)
    Ip=I_block(n,0,p); Iq=I_block(n,p,n); Imix=np.eye(N)-Ip-Iq
    W=W_pq(p,q); th=Qop(A,W)[0,0]/W[0,0]; e=W/th
    Le=0.5*(lambda M:(M+M.T))(L_matrix(A,B,e))
    Php=op_matrix(A,B,Ip); Phq=op_matrix(A,B,Iq); Phm=op_matrix(A,B,Imix)
    print(f"\n########## (p,q)=({p},{q})  n={n}  dim Weyl={D} ##########")
    print("  Phi_p+Phi_q+Phi_mix + Id  =", f"{np.abs(Php+Phq+Phm+np.eye(D)).max():.1e}")
    # per summand
    groups=sorted(groups,key=lambda g:-g[1].shape[1])
    info=[]
    prs,_=pairs_of(n)
    ty=lambda a: 0 if prs[a][1]<p else (2 if prs[a][0]>=p else 1)
    for val,U in groups:
        d=U.shape[1]
        sc=lambda M: (np.trace(U.T@M@U)/d, np.abs(U.T@M@U-(np.trace(U.T@M@U)/d)*np.eye(d)).max())
        le,_=sc(Le); fp,_=sc(Php); fq,_=sc(Phq); fm,_=sc(Phm)
        # raw identity: does sharp_bilin(I_p,.) leave Weyl_n on this summand?
        Vs=[np.tensordot(U[:,k],B,axes=1) for k in range(min(d,4))]
        out=max(np.linalg.norm(sharp_bilin(A,Ip,V)-(Bf.T@(Bf@sharp_bilin(A,Ip,V).reshape(N*N))).reshape(N,N))
                /np.linalg.norm(sharp_bilin(A,Ip,V)) for V in Vs)
        info.append(dict(d=d,le=le,fp=fp,fq=fq,fm=fm,out=out,U=U))
    print(f"  {'dim':>5} {'L_e':>10} {'Phi_p':>10} {'Phi_q':>10} {'Phi_mix':>10} {'raw leaves Weyl':>16} {'L_e recon':>10}")
    a_pp=e[0,0]
    # e values by plane type
    ev={t:None for t in (0,1,2)}
    for a in range(N): ev[ty(a)]=e[a,a]
    for I in info:
        # L_e = 1/2(e V + V e) + sharp_bilin(e,.) ; anticommutator scalar depends on support
        recon=0.0
        print(f"  {I['d']:5d} {I['le']:10.5f} {I['fp']:10.5f} {I['fq']:10.5f} {I['fm']:10.5f} {I['out']:16.2e} {recon:10.5f}")
    # K5: group summands by L_e eigenvalue
    print("  --- L_e eigenspaces ---")
    buckets=collections.defaultdict(list)
    for I in info: buckets[round(I['le'],9)].append(I)
    for val,lst in sorted(buckets.items()):
        dims=[I['d'] for I in lst]; fps=[I['fp'] for I in lst]
        tot=sum(dims)
        merged=len(lst)>1
        spread=max(fps)-min(fps)
        # actual deviation of Phi_p from scalar on the whole eigenspace
        Ue=np.hstack([I['U'] for I in lst])
        M=Ue.T@Php@Ue; mv=np.trace(M)/tot
        dev=np.abs(M-mv*np.eye(tot)).max()
        print(f"    L_e={val:9.5f} dim {tot:5d} from summands {dims}  Phi_p values {[round(x,5) for x in fps]}"
              f"  {'MERGED' if merged else 'single'}  dev-from-scalar {dev:.2e}  spread {spread:.3f}")
    return info,B,A,n,p,q

def perp_decomp(p,q):
    n=p+q; N=n*(n-1)//2
    Bp=perp_basis(n); D=len(Bp)
    Cp=casimir_block(Bp,n,0,p); Cq=casimir_block(Bp,n,p,n)
    ops=[("Cas_p",Cp),("Cas_q",Cq)]+invariant_ops(Bp,n,p)
    rng=np.random.default_rng(5)
    M=sum(r*O for r,(_,O) in zip(rng.normal(size=len(ops)),ops)); M=0.5*(M+M.T)
    w,U=np.linalg.eigh(M)
    out=[]; start=0
    for i in range(1,D+1):
        if i==D or abs(w[i]-w[start])>1e-7*max(1.0,abs(w[start])):
            V=U[:,start:i]; d=i-start
            cp=np.trace(V.T@Cp@V)/d; cq=np.trace(V.T@Cq@V)/d
            out.append((d,cp,cq)); start=i
    return D,out

if __name__=="__main__":
    for pq in [(3,4),(4,4),(4,5)]:
        analyse(*pq)
    print("\n\n===== (Weyl_n)^perp decomposition vs the X_p (x) R^q signature =====")
    for (p,q) in [(3,4),(4,4),(3,5),(4,5),(5,5)]:
        n=p+q
        B,ops,groups,D=summands(p,q)
        prs,_=pairs_of(n)
        ty=lambda a: 0 if prs[a][1]<p else (2 if prs[a][0]>=p else 1)
        # find the (pp,mix) summand
        tgt=None
        for val,U in groups:
            d=U.shape[1]
            Vs=np.tensordot(U.T,B,axes=1)
            m=np.zeros((B.shape[1],B.shape[1]))
            for a in range(B.shape[1]):
                for b in range(B.shape[1]):
                    if tuple(sorted((ty(a),ty(b))))==(0,1): m[a,b]=1
            frac=np.sum((Vs*m)**2)/np.sum(Vs**2)
            if frac>0.999: tgt=(d,np.trace(U.T@ops[0][1]@U)/d,np.trace(U.T@ops[1][1]@U)/d)
        Dp,lst=perp_decomp(p,q)
        match=[x for x in lst if abs(x[1]-tgt[1])<1e-6 and abs(x[2]-tgt[2])<1e-6]
        print(f"({p},{q}): X_p(x)R^q = (dim {tgt[0]}, Cas_p {tgt[1]:.3f}, Cas_q {tgt[2]:.3f});"
              f"  dim (Weyl)^perp = {Dp}, its pieces (dim,Cas_p,Cas_q) = "
              f"{[(d,round(a,3),round(b,3)) for d,a,b in lst]}")
        print(f"        pieces of (Weyl)^perp with the SAME (Cas_p,Cas_q): {match}")
