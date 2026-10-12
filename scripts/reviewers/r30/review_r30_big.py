"""R30: memory-lean Weyl basis + L_e spectra at larger n; closed-form check."""
import numpy as np, sys, itertools, time
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, adj, structure_constants, sphere_product_W, normalize, Q, orbit_tangent, orthonormalize, principal_cosines
from review_r30_spec import cluster

def sym_coords(N):
    """index map for symmetric NxN in orthonormal coords: diag a -> a; (a<b) -> off."""
    pos={}
    k=0
    for a in range(N): pos[(a,a)]=k; k+=1
    for a in range(N):
        for b in range(a+1,N): pos[(a,b)]=k; k+=1
    return pos,k

def to_coords(pos,D,M):
    N=M.shape[0]
    v=np.empty(D)
    dg=np.diag(M); v[:N]=dg
    iu=np.triu_indices(N,1)
    v[N:]=np.sqrt(2)*M[iu]
    return v

def from_coords(N,D,v):
    M=np.zeros((N,N))
    np.fill_diagonal(M,v[:N])
    iu=np.triu_indices(N,1)
    M[iu]=v[N:]/np.sqrt(2)
    return M+M.T-np.diag(np.diag(M))

def weyl_basis_lean(n):
    pairs,idx=pair_index(n); N=len(pairs)
    pos,D=sym_coords(N)
    def put(row,a,b,val):
        if a>b: a,b=b,a
        if a==b: row[pos[(a,a)]]+=val
        else: row[pos[(a,b)]]+=val/np.sqrt(2)
    rows=[]
    def bidx(i,j):
        s=1.0
        if i>j: i,j=j,i; s=-1.0
        return idx[(i,j)], s
    for (i,j,k,l) in itertools.combinations(range(n),4):
        row=np.zeros(D)
        for (a,b,c_,d) in ((i,j,k,l),(i,k,l,j),(i,l,j,k)):
            A,sa=bidx(a,b); B,sb=bidx(c_,d)
            put(row,A,B,sa*sb)
        rows.append(row)
    for i in range(n):
        for k in range(i,n):
            row=np.zeros(D)
            for j in range(n):
                if j==i or j==k: continue
                A,sa=bidx(i,j); B,sb=bidx(k,j)
                put(row,A,B,sa*sb)
            rows.append(row)
    C=np.array(rows)
    # orthonormal basis of the nullspace of C
    u,s,vt=np.linalg.svd(C, full_matrices=False)
    r=int((s>max(C.shape)*s[0]*1e-12).sum())
    Rowsp=vt[:r]                        # (r, D)
    # complement via QR of a random block? use eigh of I - Rowsp^T Rowsp
    G=-Rowsp.T@Rowsp
    G[np.diag_indices_from(G)]+=1.0
    ev,V=np.linalg.eigh(G)
    ns=V[:,ev>0.5].T                    # (D-r, D)
    return ns, pos, D, N

def le_spectrum(n, blocks, want_orbit=True):
    t0=time.time()
    ns,pos,D,N=weyl_basis_lean(n)
    d=ns.shape[0]
    W,lab=sphere_product_W(blocks); W=normalize(W)
    th=float(np.tensordot(W,Q(n,W))); e=W/th
    A=adj(n); A2=A.reshape(N*N,N)
    Ae=(A2@e).reshape(N,N,N); AeT=Ae.transpose(0,2,1).reshape(N,N*N)
    L=np.empty((d,d))
    for k in range(d):
        X=from_coords(N,D,ns[k])
        AX=(A2@X).reshape(N,N,N)
        T=AX.reshape(N,N*N)@AeT.T
        Y=0.5*(e@X+X@e)-0.25*(T+T.T)
        L[:,k]=ns@to_coords(pos,D,Y)
    L=0.5*(L+L.T)
    w,V=np.linalg.eigh(L)
    out=dict(n=n,blocks=blocks,theta=th,d=d,ev=w,secs=time.time()-t0)
    if want_orbit:
        sel=np.abs(w-0.5)<1e-8
        E=np.array([ (V[:,i]@ns) for i in np.where(sel)[0] ])
        Tg=orbit_tangent(n,W)
        U=np.array([to_coords(pos,D,t) for t in Tg])
        u2,s2,vt2=np.linalg.svd(U,full_matrices=False)
        U=vt2[:int((s2>1e-9*s2[0]).sum())]
        out['dimE']=int(sel.sum()); out['orbit']=U.shape[0]
        out['projdiff']=float(np.linalg.norm(E.T@E-U.T@U,2)) if E.size else None
    return out

def closed_form(p,q):
    n=p+q
    fam={}
    def add(v,m):
        v=round(v,12); fam[v]=fam.get(v,0)+m
    add(1.0,1); add(0.5,p*q)
    add((p-2)/(2*(p-1)), (p+2)*(p-1)//2)
    add((q-2)/(2*(q-1)), (q+2)*(q-1)//2)
    v=(n-2)/(2*(p-1)*(q-1))
    add(v, (p*(p-1)//2)*(q*(q-1)//2))
    add(-v, ((p+2)*(p-1)//2)*((q+2)*(q-1)//2))
    dim=n*(n+1)*(n+2)*(n-3)//12
    rest=dim-sum(fam.values())
    add(0.0,rest)
    return fam,rest

if __name__=="__main__":
    import ast
    for blocks in ast.literal_eval(sys.argv[1]):
        blocks=tuple(blocks); p,q=blocks; n=p+q
        r=le_spectrum(n,blocks)
        cl=cluster(r['ev'])
        pred,rest=closed_form(p,q)
        got={round(v,9):m for v,m in cl}
        pr={round(v,9):m for v,m in pred.items()}
        ok = got==pr
        print(f"=== S^{p} x S^{q}  n={n}  dimWeyl={r['d']}  theta={r['theta']:.10f}  ({r['secs']:.0f}s)")
        print(f"    dim E(1/2)={r['dimE']}  pq={p*q}  orbit={r['orbit']}  ||Pi_E-Pi_T||={r['projdiff']:.2e}")
        below=r['ev'][(np.abs(r['ev']-0.5)>=1e-8)&(r['ev']<0.5)]
        print(f"    nearest below 1/2 = {below.max():.10f}  gap = {0.5-below.max():.6e}")
        print(f"    measured: "+"  ".join(f"{v:.9f}^{m}" for v,m in cl))
        print(f"    closed  : "+"  ".join(f"{v:.9f}^{m}" for v,m in sorted(pred.items())))
        print(f"    CLOSED FORM MATCH: {ok}")
