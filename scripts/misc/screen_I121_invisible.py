"""Frame-free visibility screen for I121, built on r1816's construction: the largest P over unit pure four-set tensors B that every perfect matching sees at most eps of (E_M(B) <= eps for all M), by penalised projected ascent from four starts, for eps in 0.02..0.4. Run: sage -python screen_I121_invisible.py 4,4 (minutes at n=8, 105 matchings). A screen."""
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
    def sgn_idx(a,b):
        return (1,idx[(a,b)]) if a<b else (-1,idx[(b,a)])
    def matchings(lst):
        if not lst: yield []; return
        a=lst[0]
        for j in range(1,len(lst)):
            rest=lst[1:j]+lst[j+1:]
            for m in matchings(rest): yield [(a,lst[j])]+m
    allM=list(matchings(list(range(n))))
    # each matching's combos as linear functionals on F coordinates
    Fmat=np.array([o.ravel() for o in Fops])   # k x N^2
    def combo_vec(i_,j_,k_,l_):
        v=np.zeros(N*N)
        for (a,b,c,d_) in [(i_,k_,j_,l_),(i_,l_,j_,k_)]:
            s1,x=sgn_idx(a,b); s2,y=sgn_idx(c,d_); v[x*N+y]+=s1*s2
        return Fmat@v
    Cs=[]
    for Mt in allM:
        rowsM=[]
        for x in range(len(Mt)):
            for y in range(x+1,len(Mt)):
                (i_,j_),(k_,l_)=Mt[x],Mt[y]; rowsM.append(combo_vec(i_,j_,k_,l_))
        Cs.append(np.array(rowsM))
    print(f"n={n} dim F={len(Fops)} matchings={len(allM)}", flush=True)
    def PX(x):
        X=sum(c*o for c,o in zip(x,Fops)); return np.sum(Qb(X,X)*X), X
    rng=np.random.default_rng(11)
    for eps in [0.02,0.05,0.1,0.2,0.4]:
        best=-1; bestV=None
        for st in range(4):
            x=rng.standard_normal(len(Fops)); x/=np.linalg.norm(x)
            mu=50.0
            for it in range(600):
                v,X=PX(x); G=3*Qb(X,X); g=np.array([np.sum(G*o) for o in Fops])
                for Cmat in Cs:
                    cv=Cmat@x; E=np.dot(cv,cv)
                    if E>eps: g-=mu*2*(E-eps)*2*(Cmat.T@cv)
                g-=np.dot(g,x)*x; x=x+0.02*g; x/=np.linalg.norm(x)
            v,_=PX(x); V=max(np.dot(Cmat@x,Cmat@x) for Cmat in Cs)
            if V<=eps*1.05 and v>best: best=v; bestV=V
        print(f"  eps={eps}: max P found with every matching seeing <= eps: {best:.4f} (max visible {bestV})", flush=True)

import sys
for a_ in sys.argv[1:]:
    p,q=map(int,a_.split(',')); run(p,q)
