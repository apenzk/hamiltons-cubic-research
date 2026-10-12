"""Reviewer 289 -- fully independent recomputation. No repo imports."""
import itertools, numpy as np
np.set_printoptions(precision=6, suppress=True)

# ---------- so(n) / Lambda^2 machinery, built from scratch ----------
def pairs(n): return list(itertools.combinations(range(n), 2))

def so_basis(n):
    """b_a = (E_ij - E_ji)/sqrt2, orthonormal for <A,B>=tr(A^T B)."""
    B=[]
    for (i,j) in pairs(n):
        m=np.zeros((n,n)); m[i,j]=1/np.sqrt(2); m[j,i]=-1/np.sqrt(2); B.append(m)
    return B

def struct(n):
    B=so_basis(n); N=len(B)
    C=np.zeros((N,N,N))
    for a in range(N):
        for b in range(N):
            com=B[a]@B[b]-B[b]@B[a]
            for c in range(N): C[a,b,c]=np.sum(com*B[c])
    return C

_Ccache={}
def Cn(n):
    if n not in _Ccache: _Ccache[n]=struct(n)
    return _Ccache[n]

def sharp(R,n):
    """(R^#)_ab = 1/2 sum c_{a g d} c_{b e z} R_{g e} R_{d z}  (Boehm-Wilking eq.(4))."""
    C=Cn(n)
    # T[a,e,z] = sum_{g,d} c_{a g d} R_{g e} R_{d z}
    T=np.einsum('agd,ge,dz->aez',C,R,R,optimize=True)
    return np.einsum('aez,bez->ab',T,C,optimize=True)  # factor fixed by Id^#=(n-2)Id

def theta_direct(M,n):
    """theta = <Q(M),M> = tr(M^3) + <M^#,M>."""
    return float(np.trace(M@M@M)+np.sum(sharp(M,n)*M))

# ---------- 4-tensor <-> Lambda^2 ----------
def to4(M,n):
    P=pairs(n); W=np.zeros((n,)*4)
    for a,(i,j) in enumerate(P):
        for b,(k,l) in enumerate(P):
            v=M[a,b]
            W[i,j,k,l]=v; W[j,i,k,l]=-v; W[i,j,l,k]=-v; W[j,i,l,k]=v
    return W

def lam2(W4,n):
    P=pairs(n)
    return np.array([[W4[i,j,k,l] for (k,l) in P] for (i,j) in P])

# ---------- second-kind operator, Li's convention ----------
def s20_basis(n, phi_only=False):
    B=[]
    for (i,j) in pairs(n):
        h=np.zeros((n,n)); h[i,j]=h[j,i]=1/np.sqrt(2); B.append(h)
    if phi_only: return B
    for k in range(n-1):
        v=np.zeros(n); v[:k+1]=1.0; v[k+1]=-(k+1.0); v/=np.linalg.norm(v)
        B.append(np.diag(v))
    return B

def ring(W4,B,order='iklj'):
    m=len(B); R=np.empty((m,m))
    for a,h in enumerate(B):
        Wh=np.einsum(order+',kl->ij',W4,h,optimize=True)
        R[a]=[float(np.sum(Wh*hb)) for hb in B]
    return 0.5*(R+R.T)

# ---------- Weyl tensors ----------
def KN(A,Bm):
    return (np.einsum('ik,jl->ijkl',A,Bm)+np.einsum('jl,ik->ijkl',A,Bm)
            -np.einsum('il,jk->ijkl',A,Bm)-np.einsum('jk,il->ijkl',A,Bm))

def proj_weyl(A,n):
    R=A-A.transpose(1,0,2,3); R=R-R.transpose(0,1,3,2); R=R+R.transpose(2,3,0,1)
    R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
    g=np.eye(n); Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/n*g
    return R-KN(E,g)/(n-2)-s/(2*n*(n-1))*KN(g,g)

def sphere_product(blocks):
    n=sum(blocks); R=np.zeros((n,)*4); off=0
    for b in blocks:
        idx=range(off,off+b)
        for i in idx:
            for j in idx:
                for k in idx:
                    for l in idx:
                        R[i,j,k,l]=(i==k)*(j==l)-(i==l)*(j==k)
        off+=b
    return proj_weyl(R,n)

def cp2_weyl(n):
    """W_{CP^2}: self-dual part diag(2,-1,-1) on Lambda^+, anti-self-dual 0; padded into R^n."""
    P4=pairs(4); idx={p:a for a,p in enumerate(P4)}
    def e(p,s=1):
        v=np.zeros(6); v[idx[p]]=s; return v
    w1=(e((0,1))+e((2,3)))/np.sqrt(2)
    w2=(e((0,2))-e((1,3)))/np.sqrt(2)
    w3=(e((0,3))+e((1,2)))/np.sqrt(2)
    M4=2*np.outer(w1,w1)-np.outer(w2,w2)-np.outer(w3,w3)
    M4=M4/np.linalg.norm(M4)
    W=np.zeros((n,)*4); W[:4,:4,:4,:4]=to4(M4,4)
    return W

def random_weyl(n,rng):
    return proj_weyl(rng.standard_normal((n,)*4),n)

# ---------- diagnostics ----------
def analyse(name,W4,n,diagonalise_psi=True,verbose=True):
    M=lam2(W4,n); nrm=np.linalg.norm(M); M=M/nrm; W4=W4/nrm
    ric=np.abs(np.einsum('ikjk->ij',W4)).max()
    bia=np.abs(W4+W4.transpose(1,2,0,3)+W4.transpose(2,0,1,3)).max()
    B=s20_basis(n); R=ring(W4,B)
    Np=len(pairs(n))
    if diagonalise_psi:
        blk=R[Np:,Np:]; ev,Uv=np.linalg.eigh(blk)
        U=np.eye(len(B)); U[Np:,Np:]=Uv; R=U.T@R@U
    mu=np.linalg.eigvalsh(M); om=np.linalg.eigvalsh(R)
    K=np.array([M[a,a] for a in range(Np)]); Kp=np.diag(R).copy()
    th_bi=1.5*np.sum(mu**3)-0.5*np.sum(om**3)
    th_dir=theta_direct(M,n)
    m_,Mp_=-om.min(),mu.max()
    lo=np.sum(Kp**3)+3*m_*(np.sum(Kp**2)-3.0)
    hi=np.sum(K**3)+3*Mp_*(1.0-np.sum(K**2))
    bd=1.5*hi-0.5*lo
    offM=1-np.sum(K**2); offR=3-np.sum(Kp**2)
    claimed=4.5*Mp_*offM+1.5*m_*offR
    th_diag=1.5*np.sum(K**3)-0.5*np.sum(Kp**3)
    if verbose:
        print(f"{name:<22} n={n:<3} Ric={ric:.1e} Bia={bia:.1e} sum_mu2={mu@mu:.9f} "
              f"sum_om={om.sum():+.1e} sum_om2={om@om:.9f}")
        print(f"   theta(bispec)={th_bi:+.9f}  theta(direct Q)={th_dir:+.9f}  diff={th_bi-th_dir:+.2e}")
        print(f"   m={m_:.6f} Mp={Mp_:.6f}  ||M_off||^2={offM:.9f} ||Ring_off||^2={offR:.9f}")
        print(f"   bound={bd:+.6f}  true slack={bd-th_bi:+.6f}  claimed slack={claimed:+.6f}"
              f"  dropped term (theta_diag - theta)={th_diag-th_bi:+.6f}")
    return dict(n=n,M=M,R=R,mu=mu,om=om,K=K,Kp=Kp,th=th_bi,th_dir=th_dir,bd=bd,
                offM=offM,offR=offR,claimed=claimed,th_diag=th_diag,m=m_,Mp=Mp_)

def majorized(x,y,tol=1e-9):
    xs=np.sort(x)[::-1]; ys=np.sort(y)[::-1]
    if len(xs)!=len(ys): return None
    cx=np.cumsum(xs); cy=np.cumsum(ys)
    return float((cx-cy).max()), float(abs(cx[-1]-cy[-1]))
