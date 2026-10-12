"""Gate 1 check of the small-mass sweep's pair identity, built on r1816's construction (scripts/reviewers/r1816_product_coupling_screen.py): rotates the unit product Weyl tensor of S^p x S^q by a random orthogonal g (a critical point in a generic frame), splits it into diagonal, pair and four-set parts, and compares rho with P(Bf) + 3<L_A Bf,Bf> + P(A) + 3 rho |Bp|^2 - 3<L_A Bp,Bp> - 2 P(Bp) - 3 T(Bp,Bp,Bf). Run: sage -python check_I121_pair_identity.py 4,4"""
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
    # product e
    Nn=(n-1)*(n-2); al=q*(q-1)/Nn; be=-(p-1)*(q-1)/Nn; ga=p*(p-1)/Nn
    E=np.zeros((N,N))
    for (a,b),i in idx.items(): E[i,i]= al if (a in P and b in P) else (ga if (a not in P and b not in P) else be)
    e=E/np.linalg.norm(E); d=np.sum(Qb(e,e)*e)

    # rotate e by a random orthogonal g: W = g.e (critical, value d), split in the standard frame
    rng=np.random.default_rng(3); g,_=np.linalg.qr(rng.standard_normal((n,n)))
    Lg=np.zeros((N,N))
    for (a,b),col in idx.items():
        for (p_,q_),row in idx.items():
            Lg[row,col]=g[p_,a]*g[q_,b]-g[q_,a]*g[p_,b]
    W=Lg@e@Lg.T; rho=np.sum(Qb(W,W)*W)
    print("criticality residual", np.linalg.norm(Qb(W,W)-rho*W), "rho", rho, "d", d)
    kind=np.zeros((N,N),dtype=int)   # 0 diag, 1 pair, 2 four-set
    for (a,b),i1 in idx.items():
        for (c,d_),j1 in idx.items():
            s_={a,b,c,d_}; kind[i1,j1]=0 if (i1==j1) else (1 if len(s_)==3 else 2)
    A=np.where(kind==0,W,0); Bp=np.where(kind==1,W,0); Bf=np.where(kind==2,W,0)
    T=lambda X,Y,Z: np.sum(Qb(X,Y)*Z); P_=lambda X: T(X,X,X)
    t=np.linalg.norm(A)
    rhs=P_(Bf)+3*T(A,Bf,Bf)+P_(A)+3*rho*np.linalg.norm(Bp)**2-3*T(A,Bp,Bp)-2*P_(Bp)-3*T(Bp,Bp,Bf)
    print(f"t={t:.4f} |Bp|^2={np.linalg.norm(Bp)**2:.4f} |Bf|^2={np.linalg.norm(Bf)**2:.4f}")
    print(f"identity: rho={rho:.12f}  rhs={rhs:.12f}  diff={abs(rho-rhs):.2e}")
    print(f"  pieces: P(Bf)={P_(Bf):.6f} 3<L_A Bf,Bf>={3*T(A,Bf,Bf):.6f} P(A)={P_(A):.6f} 3rho|Bp|^2={3*rho*np.linalg.norm(Bp)**2:.6f}")

import sys
for a in sys.argv[1:]:
    p,q=map(int,a.split(',')); run(p,q)
