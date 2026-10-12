"""Visibility screen for I121's small-mass node, built on r1816's construction: over every perfect matching of n indices (10395 at n=12), the visible four-set energy E(M), the sum over pairs of matching edges e={i,j}, f={k,l} of (W(ik,jl)+W(il,jk))^2, and its largest share of the four-set mass, for the rotated-product witness, random pair-free tensors and a four-set-sector ascent. Run: sage -python screen_I121_visibility.py 6,6 (a few minutes). A screen."""
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

    def ent2(W,a,b,c,d):
        s1=1
        if a>b: a,b=b,a; s1=-s1
        if c>d: c,d=d,c; s1=-s1
        return s1*W[idx[(a,b)],idx[(c,d)]]
    def matchings(lst):
        if not lst: yield []; return
        a=lst[0]
        for j in range(1,len(lst)):
            rest=lst[1:j]+lst[j+1:]
            for m in matchings(rest): yield [(a,lst[j])]+m
    allM=list(matchings(list(range(n))))
    def visible(W):
        four=0.0
        for (a,b),i1 in idx.items():
            for (c,d_),j1 in idx.items():
                if len({a,b,c,d_})==4: four+=W[i1,j1]**2
        best=0; bestM=None
        for M in allM:
            E=0.0
            for x in range(len(M)):
                for y in range(x+1,len(M)):
                    (i_,j_),(k_,l_)=M[x],M[y]
                    E+=(ent2(W,i_,k_,j_,l_)+ent2(W,i_,l_,j_,k_))**2
            if E>best: best=E; bestM=M
        return best, four
    def rot_op(g):
        Lg=np.zeros((N,N))
        for (a,b),col in idx.items():
            for (p_,q_),row in idx.items():
                Lg[row,col]=g[p_,a]*g[q_,b]-g[q_,a]*g[p_,b]
        return Lg
    g=np.eye(n)
    for k in range(p):
        c,s_=np.cos(np.pi/4),np.sin(np.pi/4); R=np.eye(n); a,b=k,p+k
        R[a,a]=c; R[b,b]=c; R[a,b]=-s_; R[b,a]=s_; g=R@g
    Lg=rot_op(g); Ww=Lg@e@Lg.T
    E,F=visible(Ww); print(f"n={n} matchings={len(allM)}  witness: P={np.sum(Qb(Ww,Ww)*Ww):.4f} max visible E={E:.4f} four-set mass={F:.4f} fraction={E/F:.4f}", flush=True)
    rng=np.random.default_rng(7)
    # random pair-free: random W_n element projected to four-set entries, re-projected onto W_n
    kind=np.zeros((N,N),dtype=int)
    for (a,b),i1 in idx.items():
        for (c,d_),j1 in idx.items():
            kind[i1,j1]=0 if i1==j1 else (1 if len({a,b,c,d_})==3 else 2)
    rows=[]
    for i1 in range(N):
        for j1 in range(i1,N):
            if kind[i1,j1]!=2:
                M_=np.zeros((N,N)); M_[i1,j1]+=1; M_[j1,i1]+=1; rows.append(Qo.T@M_.ravel())
    Cm=np.array(rows); _,sv,vt=np.linalg.svd(Cm); rk=(sv>1e-9).sum(); S=vt[rk:].T
    Fops=[(Qo@S[:,k]).reshape(N,N) for k in range(S.shape[1])]
    for r in range(3):
        x=rng.standard_normal(len(Fops)); x/=np.linalg.norm(x); X=sum(c*o for c,o in zip(x,Fops))
        E,F=visible(X); print(f"  random four-set {r}: P={np.sum(Qb(X,X)*X):.4f} max visible fraction={E/F:.4f}", flush=True)
    # pure four-set maximiser (short ascent)
    x=rng.standard_normal(len(Fops)); x/=np.linalg.norm(x)
    for it in range(300):
        X=sum(c*o for c,o in zip(x,Fops)); G=3*Qb(X,X); gg=np.array([np.sum(G*o) for o in Fops]); gg-=np.dot(gg,x)*x; x=x+0.05*gg; x/=np.linalg.norm(x)
    X=sum(c*o for c,o in zip(x,Fops)); E,F=visible(X)
    print(f"  four-set sector ascent: P={np.sum(Qb(X,X)*X):.4f} max visible fraction={E/F:.4f}", flush=True)

import sys
for a_ in sys.argv[1:]:
    p,q=map(int,a_.split(',')); run(p,q)
