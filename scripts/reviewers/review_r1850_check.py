# r1850: check Claim 2 (E in a frame at pair-free W), the D_M identity, and sum X^2 vs ||B_f||^2
import numpy as np, itertools as it
rng=np.random.default_rng(1850)
def run(n):
    E=list(it.combinations(range(n),2)); idx={e:k for k,e in enumerate(E)}; N=len(E)
    def ent(i,j):  # bivector index and sign for e_i^e_j
        return (idx[(i,j)],1) if i<j else (idx[(j,i)],-1)
    def mat(k):
        i,j=E[k]; M=np.zeros((n,n)); M[i,j]=1; M[j,i]=-1; return M
    Ms=[mat(k) for k in range(N)]
    c=np.zeros((N,N,N))
    for a in range(N):
        for b in range(N):
            C=Ms[a]@Ms[b]-Ms[b]@Ms[a]
            for g in range(N): c[a,b,g]=0.5*np.trace(C.T@Ms[g])
    sharp=lambda R: 0.5*np.einsum('agd,bez,ge,dz->ab',c,c,R,R)
    assert np.allclose(sharp(np.eye(N)),(n-2)*np.eye(N))
    W=np.zeros((N,N))
    # diagonal part with zero row sums
    S=rng.standard_normal((n,n)); S=S+S.T; np.fill_diagonal(S,0)
    rows=[]; 
    for i in range(n):
        r=np.zeros(N)
        for k in range(n):
            if k!=i: r[ent(i,k)[0]]=1
        rows.append(r)
    Rm=np.array(rows); v=np.array([S[i,j] for (i,j) in E]); v=v-Rm.T@np.linalg.lstsq(Rm@Rm.T,Rm@v,rcond=None)[0]
    A=np.diag(v); W+=A
    for (i,j,k,l) in it.combinations(range(n),4):
        a,cc=rng.standard_normal(2); b=a+cc
        for (p,q,val) in [((i,j),(k,l),a),((i,k),(j,l),b),((i,l),(j,k),cc)]:
            W[idx[p],idx[q]]=val; W[idx[q],idx[p]]=val
    B=W-A
    # Weyl checks: Bianchi and Ricci
    def w(i,j,k,l):
        p,s1=ent(i,j); q,s2=ent(k,l); return s1*s2*W[p,q]
    ric=np.array([[sum(w(i,k,j,k) for k in range(n) if k not in(i,j)) for j in range(n)] for i in range(n)])
    assert np.allclose(ric,0)
    for (i,j,k,l) in it.combinations(range(n),4): assert abs(w(i,j,k,l)+w(i,k,l,j)+w(i,l,j,k))<1e-12
    Einv=np.sum(sharp(W)*W)-0.5*np.trace(W@W@W)
    PA=np.trace(A@A@A)+np.sum(sharp(A)*A)
    X=lambda e,f: 0.5*(w(e[0],f[0],e[1],f[1])+w(e[0],f[1],e[1],f[0]))
    pairs=[(e,f) for e in E for f in E if e<f and not set(e)&set(f)]
    coup=-6*sum((v[idx[e]]+v[idx[f]])*X(e,f)**2 for e,f in pairs)
    rects=[R for R in it.combinations(E,3) if len(set(sum(R,())))==6]
    vis=24*sum(X(R[0],R[1])*X(R[0],R[2])*X(R[1],R[2]) for R in rects)
    Efr=PA-1.5*np.trace(A@A@A)+coup+vis
    sx=sum(X(e,f)**2 for e,f in pairs); nb=np.sum(B*B)
    print(n,'E inv',Einv,'E frame',Efr,'sumX2 unordered/||Bf||^2',sx/nb)
    # D_M on matching (0,1),(2,3),...
    M=[(2*p,2*p+1) for p in range(n//2)]
    D=np.zeros((n,n)); 
    for p,q in it.combinations(range(n//2),2):
        x=X(M[p],M[q])
        for s in (0,1):
            for t in (0,1):
                D[2*p+s,2*q+t]=D[2*q+t,2*p+s]=(1 if s==t else -1)*x
    dv=np.array([D[i,j] for (i,j) in E]); Dm=np.diag(dv)
    PD=np.trace(Dm@Dm@Dm)+np.sum(sharp(Dm)*Dm)
    EM=sum(4*X(M[p],M[q])**2 for p,q in it.combinations(range(n//2),2))
    visM=24*sum(X(M[p],M[q])*X(M[p],M[r])*X(M[q],M[r]) for p,q,r in it.combinations(range(n//2),3))
    print(' P(D_M)',PD,'24sumXXX in M',visM,'||D_M||^2',np.sum(dv**2),'E(M)',EM,'rowsums',np.abs(D.sum(1)).max())
    # actual pi/4 rotation of B_f diagonal on cross pairs
    G=np.eye(n)
    for (i,j) in M: G[np.ix_([i,j],[i,j])]=np.array([[1,1],[1,-1]])/np.sqrt(2)
    def rotdiag(Wm,a,b):
        u=np.outer(G[:,a],G[:,b]); u=u-u.T; vec=np.array([u[i,j] for (i,j) in E]); return vec@Wm@vec
    err=max(abs(rotdiag(B,a,b)-D[a,b]) for a in range(n) for b in range(n) if a//2!=b//2)
    print(' max |rotated B_f diagonal - D_M| on cross pairs',err)
run(6); run(8)
