import sys, numpy as np, itertools
sys.path.insert(0,'scripts/reviewers/r320')
import lib320 as L

def sphere_product(p,q,n=None):
    """Weyl operator of S^p x S^q (unit norm), padded into so(n)."""
    n0=p+q; n = n0 if n is None else n
    P,idx,_=L.basis(n0); N=len(P)
    R=np.zeros((N,N))
    for a,(i,j) in enumerate(P):
        if i<p and j<p: R[a,a]=1.0     # curvature 1 on block 1
    W=L.proj_weyl(R,n0)
    W=W/np.sqrt(L.frob(W))
    return pad(W,n0,n)

def pad(W,n0,n):
    if n==n0: return W
    P0,idx0,_=L.basis(n0); P,idx,_=L.basis(n)
    N=len(P); out=np.zeros((N,N))
    for a,pa in enumerate(P0):
        for b,pb in enumerate(P0):
            out[idx[pa],idx[pb]]=W[a,b]
    return out

def cp2(n=4):
    """self-dual Weyl operator of CP^2, eigenvalues (2,-1,-1) on Lambda^2_+."""
    n0=4; P,idx,_=L.basis(4)
    sd=[]
    for (a,b),(c,d) in [((0,1),(2,3)),((0,2),(3,1)),((0,3),(1,2))]:
        v=np.zeros(6)
        v[idx[(a,b)]]+=1.0
        cc,dd=(c,d) if c<d else (d,c); s=1.0 if c<d else -1.0
        v[idx[(cc,dd)]]+=s
        sd.append(v/np.linalg.norm(v))
    sd=np.array(sd)
    W=2*np.outer(sd[0],sd[0])-np.outer(sd[1],sd[1])-np.outer(sd[2],sd[2])
    W=W/np.sqrt(L.frob(W))
    return pad(W,4,n)

def cpm(m,n=None):
    """W of CP^m (real dim n0=2m): Weyl part of the Fubini-Study curvature."""
    n0=2*m; n=n0 if n is None else n
    # complex structure J: J e_{2k}=e_{2k+1}
    J=np.zeros((n0,n0))
    for k in range(m):
        J[2*k,2*k+1]=1.0; J[2*k+1,2*k]=-1.0
    # FS curvature R_{ijkl}= (d_ik d_jl - d_il d_jk) + (J_ik J_jl - J_il J_jk + 2 J_ij J_kl)
    d=np.eye(n0)
    R4=(np.einsum('ik,jl->ijkl',d,d)-np.einsum('il,jk->ijkl',d,d)
        +np.einsum('ik,jl->ijkl',J,J)-np.einsum('il,jk->ijkl',J,J)
        +2*np.einsum('ij,kl->ijkl',J,J))
    P,idx,_=L.basis(n0); N=len(P)
    Wop=np.zeros((N,N))
    for a,(i,j) in enumerate(P):
        for b,(k,l) in enumerate(P):
            Wop[a,b]=R4[i,j,k,l]
    W=L.proj_weyl(Wop,n0); W=W/np.sqrt(L.frob(W))
    return pad(W,n0,n)

def casimir(hbasis,n):
    """W_h = c (Pi_h - r/N Id) for a subalgebra given by an orthonormal list of Lambda^2 vectors."""
    N=L.struct(n).shape[0]
    H=np.array(hbasis); r=H.shape[0]
    Pi=H.T@H
    W=Pi-(r/N)*np.eye(N)
    return W/np.sqrt(L.frob(W)), r

def so_block_subalg(blocks,n):
    """orthonormal basis of so(p1)+so(p2)+... embedded blockwise in so(n)."""
    P,idx,_=L.basis(n); N=len(P)
    out=[]; off=0
    for p in blocks:
        for i,j in itertools.combinations(range(off,off+p),2):
            v=np.zeros(N); v[idx[(i,j)]]=1.0; out.append(v)
        off+=p
    return out

def report(name,W,n):
    q=L.Q(W,n); th=L.frob(W,q); res=np.linalg.norm(q-th*W)
    ev=np.linalg.eigvalsh(W)
    rp=int((ev>1e-9).sum()); rm=int((ev<-1e-9).sum()); k=len(ev)-rp-rm
    return dict(name=name,n=n,theta=th,res=res,rplus=rp,rminus=rm,ker=k,
                lmin=float(ev.min()),lmax=float(ev.max()),
                nev=len(np.unique(np.round(ev,9))),
                ric=float(np.abs(L.ricci(W,n)).max()), bia=L.bianchi_norm(W,n),
                nrm=float(np.sqrt(L.frob(W))))
