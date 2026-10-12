"""Refinement for the small-mass node screen: at n=12 (argument 6,6) and diagonal mass t=0.3, four starts of 1000 projected-ascent steps on the pair-free subspace D_n + F_n, reporting P, the distance of the operator's Lambda^2 spectrum from the balanced product's, and the full-space criticality residual. Built on r1816's construction. A screen."""
"""r1816 screen: at the unit product Weyl tensor e of S^p x S^q in its own frame, the largest eigenvalue of L_e = Q(e,.) compressed to the subspace the maximal frame allows (B perp D, within-factor pair profiles zero, mixed pair profiles perp delta) versus c_*, and with only the orbit line removed. Run with sage -python."""
import numpy as np, itertools, sys
def run(p,q):
    n=p+q; P=list(range(p))
    pairs=list(itertools.combinations(range(n),2)); idx={pr:i for i,pr in enumerate(pairs)}; N=len(pairs)
    def mat(a,b):
        M=np.zeros((n,n)); M[a,b]=1; M[b,a]=-1; return M/np.sqrt(2)
    basis=[mat(a,b) for (a,b) in pairs]
    C=np.zeros((N,N,N))
    for i in range(N):
        for j in range(N):
            br=basis[i]@basis[j]-basis[j]@basis[i]
            for k in range(N): C[i,j,k]=np.sum(br*basis[k])
    def sharp(X,Y): return 0.5*np.einsum('ack,bdl,cd,kl->ab',C,C,X,Y,optimize=True)
    I=np.eye(N); scale=(n-2)/sharp(I,I)[0,0]
    def Qb(X,Y): return 0.5*(X@Y+Y@X)+scale*0.5*(sharp(X,Y)+sharp(Y,X))
    # W_n basis: symmetric N x N, Bianchi, Ricci-free
    def ent(R,a,b,c,d):
        s=1
        if a>b: a,b=b,a; s=-s
        if c>d: c,d=d,c; s=-s
        if a==b or c==d: return None
        return (s,idx[(a,b)],idx[(c,d)])
    sym=[]
    for i in range(N):
        for j in range(i,N):
            M=np.zeros((N,N)); M[i,j]=M[j,i]=1 if i!=j else 1; sym.append(M)
    cons=[]
    for a,b,c,d in itertools.combinations(range(n),4):
        row=np.zeros(len(sym))
        cons_ops=[(a,b,c,d),(b,c,a,d),(c,a,b,d)]
        # linear functional R -> R_abcd + R_bcad + R_cabd
        cons.append(cons_ops)
    def bianchi(R):
        out=[]
        for a,b,c,d in itertools.combinations(range(n),4):
            v=0
            for (x,y,z,w) in [(a,b,c,d),(b,c,a,d),(c,a,b,d)]:
                s,i,j=ent(R,x,y,z,w); v+=s*R[i,j]
            out.append(v)
        return out
    def ricci(R):
        out=[]
        for a in range(n):
            for b in range(a,n):
                v=0
                for k in range(n):
                    if k in (a,b): continue
                    s1=ent(R,a,k,b,k)
                    s,i,j=s1; v+=s*R[i,j]
                out.append(v)
        return out
    A=np.array([bianchi(M)+ricci(M) for M in sym]).T
    _,sv,vt=np.linalg.svd(A); rank=(sv>1e-9).sum(); null=vt[rank:]
    Wb=[sum(c*M for c,M in zip(v,sym)) for v in null]
    Wb=[M/np.linalg.norm(M) for M in Wb]
    G=np.array([M.ravel() for M in Wb]).T; Qo,_=np.linalg.qr(G)   # orthonormal basis of W_n in HS
    dimW=Qo.shape[1]; assert dimW==n*(n-3)*(n+1)*(n+2)//12, dimW

    # D_n (diagonal Weyl) and F_n (pure four-set) bases in W_n coordinates
    kind=np.zeros((N,N),dtype=int)
    for (a,b),i1 in idx.items():
        for (c,d_),j1 in idx.items():
            kind[i1,j1]=0 if i1==j1 else (1 if len({a,b,c,d_})==3 else 2)
    def sub(keep):
        rows=[]
        for i1 in range(N):
            for j1 in range(i1,N):
                if kind[i1,j1] not in keep:
                    M=np.zeros((N,N)); M[i1,j1]+=1; M[j1,i1]+=1; rows.append(Qo.T@M.ravel())
        Cm=np.array(rows); _,sv,vt=np.linalg.svd(Cm); rk=(sv>1e-9).sum(); S=vt[rk:].T
        return [(Qo@S[:,k]).reshape(N,N) for k in range(S.shape[1])]
    Dops=sub({0}); Fops=sub({2})
    print(f"n={n} dim D={len(Dops)} dim F={len(Fops)}")
    def comb(x,ops): return sum(c*o for c,o in zip(x,ops))
    rng=np.random.default_rng(5)
    Nn=(n-1)*(n-2); P_=list(range(p)); al=q*(q-1)/Nn; be=-(p-1)*(q-1)/Nn; ga=p*(p-1)/Nn
    E=np.zeros((N,N))
    for (a_,b_),i_ in idx.items(): E[i_,i_]= al if (a_ in P_ and b_ in P_) else (ga if (a_ not in P_ and b_ not in P_) else be)
    e=E/np.linalg.norm(E); spec_e=np.sort(np.linalg.eigvalsh(e))
    t=0.3; b=np.sqrt(1-t*t)
    for st in range(4):
        xa=rng.standard_normal(len(Dops)); xa/=np.linalg.norm(xa)
        xf=rng.standard_normal(len(Fops)); xf/=np.linalg.norm(xf)
        for it in range(1000):
            A=comb(xa,Dops); F=comb(xf,Fops); U=t*A+b*F
            G=3*Qb(U,U)
            ga_=np.array([np.sum(G*o) for o in Dops])*t; gf=np.array([np.sum(G*o) for o in Fops])*b
            ga_-=np.dot(ga_,xa)*xa; gf-=np.dot(gf,xf)*xf
            xa=xa+0.05*ga_; xa/=np.linalg.norm(xa); xf=xf+0.05*gf; xf/=np.linalg.norm(xf)
        U=t*comb(xa,Dops)+b*comb(xf,Fops); v=np.sum(Qb(U,U)*U)
        spec=np.sort(np.linalg.eigvalsh(U)); d_spec=np.linalg.norm(spec-spec_e)
        crit=np.linalg.norm(Qb(U,U)-v*U)
        print(f"  start {st}: P={v:.6f}  |spec - spec(product)|={d_spec:.3e}  full-space criticality residual={crit:.3e}", flush=True)

import sys
for a in sys.argv[1:]:
    p,q=map(int,a.split(',')); run(p,q)
