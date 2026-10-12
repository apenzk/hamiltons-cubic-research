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
    L=np.array([Qo.T@Qb(e,Qo[:,k].reshape(N,N)).ravel() for k in range(dimW)]).T; L=(L+L.T)/2
    cstar=d*(n-2)/(2*(p-1)*(q-1)); tauP=d*(p-2)/(2*(p-1)); tauQ=d*(q-2)/(2*(q-1))
    # constraint functionals on W (in Qo coordinates)
    rows=[]
    diag=[np.zeros((N,N)) for _ in range(N)]
    for i in range(N): diag[i][i,i]=1; rows.append(Qo.T@diag[i].ravel())   # B perp D
    orbit_rows=[]; plane_rows=[]
    for i,j in itertools.combinations(range(n),2):
        same=(i in P)==(j in P)
        prof=[]
        for k in range(n):
            if k in (i,j): continue
            s,a1,b1=ent(None,i,k,j,k); M=np.zeros((N,N)); M[a1,b1]+=s; M[b1,a1]+=s
            prof.append(Qo.T@M.ravel())
        if same: plane_rows+=prof
        else:
            delta=np.array([0.5*(e[idx[tuple(sorted((i,k)))],idx[tuple(sorted((i,k)))]]-e[idx[tuple(sorted((j,k)))],idx[tuple(sorted((j,k)))]]) for k in range(n) if k not in (i,j)])
            orbit_rows.append(sum(c*r for c,r in zip(delta,prof)))
    def maxeig(cons):
        Cm=np.array(cons); _,sv,vt=np.linalg.svd(Cm); r=(sv>1e-9).sum(); S=vt[r:].T
        ev=np.linalg.eigvalsh(S.T@L@S); return ev.max(), S.shape[1]
    full,dfull=maxeig(rows); orb,dorb=maxeig(rows+orbit_rows); allc,dall=maxeig(rows+orbit_rows+plane_rows)
    print(f"p={p} q={q} n={n} dimW={dimW} d={d:.6f} c*={cstar:.6f} tauP={tauP:.6f} tauQ={tauQ:.6f}")
    print(f"  max eig on D-perp: {full:.6f} (d/2={d/2:.6f}); orbit removed: {orb:.6f}; + one-plane zero: {allc:.6f} dim {dall}")
    print("  Q(e)=de residual", np.linalg.norm(Qb(e,e)-d*e))
for pq in sys.argv[1:]:
    p,q=map(int,pq.split(',')); run(p,q)
