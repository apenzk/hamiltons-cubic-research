"""Small-mass node screen for I121, built on r1816's W_n construction (scripts/reviewers/r1816_product_coupling_screen.py): the pure four-set sector F_n (operators with zero diagonal and zero pair blocks, every entry with four distinct indices, dim 2*C(n,4)) and the largest P on its unit sphere from 12 random-start projected ascents. Run: sage -python screen_I121_fourset_sector.py 4,4 5,5 6,6 (the p,q argument only sets n = p+q). Seconds at n=8, about two minutes for n=10 and 12. A screen, local ascent, not a certificate."""
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

    # the pure four-set sector F_n: zero diagonal, zero pair blocks (every entry with a repeated index)
    rows=[]
    for (a,b),i1 in idx.items():
        for (c,d_),j1 in idx.items():
            if len({a,b,c,d_})<4:
                M=np.zeros((N,N)); M[i1,j1]+=1; M[j1,i1]+=1; rows.append(Qo.T@M.ravel())
    Cm=np.array(rows); _,sv,vt=np.linalg.svd(Cm); rk=(sv>1e-9).sum(); S=vt[rk:].T
    dF=S.shape[1]; ops=[(Qo@S[:,k]).reshape(N,N) for k in range(dF)]
    print(f"n={n} dim F_n={dF} (2*C(n,4)={2*len(list(itertools.combinations(range(n),4)))})")
    def PX(x):
        X=sum(c*o for c,o in zip(x,ops)); return np.sum(Qb(X,X)*X), X
    rng=np.random.default_rng(0); best=-1
    for st in range(12):
        x=rng.standard_normal(dF); x/=np.linalg.norm(x)
        for it in range(400):
            _,X=PX(x); G=3*Qb(X,X); g=np.array([np.sum(G*o) for o in ops]); g-=np.dot(g,x)*x; x=x+0.05*g; x/=np.linalg.norm(x)
        v,_=PX(x); best=max(best,v)
        print(f"  start {st}: P={v:.6f}")
    print(f"  max P on F_n found: {best:.6f}   sqrt(3/2)={np.sqrt(1.5):.6f}")

import sys
for a in sys.argv[1:]:
    p,q=map(int,a.split(',')); run(p,q)
