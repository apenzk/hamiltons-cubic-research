"""Reviewer 106 - own implementation from the brief's definitions."""
import numpy as np, itertools

def pairs(n):
    return [(i,j) for i in range(n) for j in range(i+1,n)]

def pair_index(n):
    P = pairs(n); return P, {p:k for k,p in enumerate(P)}

# ---------- algebraic Weyl tensors ----------
def sym_pair(R):
    """impose antisymmetry in (ij),(kl) and pair exchange"""
    R = R - np.transpose(R,(1,0,2,3)); R = R - np.transpose(R,(0,1,3,2))
    R = R + np.transpose(R,(2,3,0,1)); return R/8.0

def bianchi_proj(R):
    """projection onto first-Bianchi kernel, for tensors with Riemann pair symmetries"""
    return (2.0*R - np.transpose(R,(0,2,3,1)) - np.transpose(R,(0,3,1,2)))/3.0

def kn(h,g):
    """Kulkarni-Nomizu product (h kn g)_{ijkl}"""
    return (np.einsum('ik,jl->ijkl',h,g) - np.einsum('il,jk->ijkl',h,g)
          - np.einsum('jk,il->ijkl',h,g) + np.einsum('jl,ik->ijkl',h,g))

def trace_free(R):
    n = R.shape[0]; g = np.eye(n)
    Ric = np.einsum('ikjk->ij',R); S = np.trace(Ric)
    W = R - kn(Ric - S/n*g, g)/(n-2) - S/(2*n*(n-1))*kn(g,g)
    return W

def weyl_project(A):
    return trace_free(bianchi_proj(sym_pair(A)))

def rand_weyl(n,rng):
    W = weyl_project(rng.standard_normal((n,n,n,n)))
    return W

def residuals(W):
    n=W.shape[0]
    r1=np.abs(W+np.transpose(W,(1,0,2,3))).max()
    r2=np.abs(W-np.transpose(W,(2,3,0,1))).max()
    r3=np.abs(W+np.transpose(W,(0,2,3,1))+np.transpose(W,(0,3,1,2))).max()
    r4=np.abs(np.einsum('ikjk->ij',W)).max()
    return dict(antisym=r1,pairsym=r2,bianchi=r3,trace=r4)

# ---------- Lambda^2 matrix ----------
def to_M(W):
    n=W.shape[0]; P,_=pair_index(n); D=len(P)
    idx=np.array(P)
    return W[idx[:,None,0],idx[:,None,1],idx[None,:,0],idx[None,:,1]]

def from_M(M,n):
    """diagonal-in-pairs reconstruction: build a 4-tensor from a Lambda^2 matrix
    with full Riemann symmetries (only valid as an inverse of to_M on the image)."""
    P,_=pair_index(n); W=np.zeros((n,n,n,n))
    for a,(i,j) in enumerate(P):
        for b,(k,l) in enumerate(P):
            v=M[a,b]
            W[i,j,k,l]=v;  W[j,i,k,l]=-v; W[i,j,l,k]=-v; W[j,i,l,k]=v
            W[k,l,i,j]=v;  W[l,k,i,j]=-v; W[k,l,j,i]=-v; W[l,k,j,i]=v
    return W

def vertex_matrix(W):
    n=W.shape[0]
    K=np.array([[W[a,b,a,b] for b in range(n)] for a in range(n)])
    np.fill_diagonal(K,0.0); return K

# ---------- structure constants of so(n) in phi_ij = E_ij - E_ji ----------
_cache={}
def struct(n):
    if n in _cache: return _cache[n]
    P,pi=pair_index(n); D=len(P); c=np.zeros((D,D,D))
    def add(c,alpha_pair,g,d,val):
        a,b=alpha_pair
        if a==b: return
        if a<b: c[pi[(a,b)],g,d]+=val
        else:   c[pi[(b,a)],g,d]-=val
    for g,(i,j) in enumerate(P):
        for d,(k,l) in enumerate(P):
            # [phi_ij, phi_kl] = d_jk phi_il - d_ik phi_jl - d_jl phi_ik + d_il phi_jk
            if j==k: add(c,(i,l),g,d, 1.0)
            if i==k: add(c,(j,l),g,d,-1.0)
            if j==l: add(c,(i,k),g,d,-1.0)
            if i==l: add(c,(j,k),g,d, 1.0)
    _cache[n]=c; return c

def sharp_inner(M,n,scale=1.0):
    """<M^#, M> with M^#_{ab} = scale * sum c_{a,g,d} c_{b,e,z} M_{ge} M_{dz}"""
    c=struct(n)
    return scale*np.einsum('agd,bez,ge,dz,ab->',c,c,M,M,M,optimize=True)

def theta_from_M(M,n,scale):
    Mn=M/np.linalg.norm(M)
    return np.trace(Mn@Mn@Mn)+sharp_inner(Mn,n,scale)

def theta0(n): return np.sqrt(2.0*(n-1)*(n-2))/n

# ---------- named tensors ----------
def sphere_product(p,q):
    n=p+q; R=np.zeros((n,n,n,n)); g=np.eye(n)
    gA=np.zeros((n,n)); gA[:p,:p]=np.eye(p)
    gB=np.zeros((n,n)); gB[p:,p:]=np.eye(q)
    R=0.5*kn(gA,gA)+0.5*kn(gB,gB)   # curvature of product of unit spheres
    return trace_free(R)

if __name__=="__main__":
    rng=np.random.default_rng(0)
    for n in (5,6,7,8):
        W=rand_weyl(n,rng); print(n,{k:f"{v:.1e}" for k,v in residuals(W).items()})
    for (p,q) in [(3,3),(4,4),(5,5),(6,6)]:
        W=sphere_product(p,q); n=p+q
        print(f"S{p}xS{q} n={n}",{k:f"{v:.1e}" for k,v in residuals(W).items()})

def cpm(m):
    """Fubini-Study curvature of CP^m, real dimension n=2m, then Weyl-projected."""
    n=2*m; g=np.eye(n); J=np.zeros((n,n))
    for a in range(m):
        J[2*a,2*a+1]=1.0; J[2*a+1,2*a]=-1.0
    R=(np.einsum('ik,jl->ijkl',g,g)-np.einsum('il,jk->ijkl',g,g)
      +np.einsum('ik,jl->ijkl',J,J)-np.einsum('il,jk->ijkl',J,J)
      +2*np.einsum('ij,kl->ijkl',J,J))
    return trace_free(R)

def pad(W,n):
    m=W.shape[0]; V=np.zeros((n,n,n,n)); V[:m,:m,:m,:m]=W; return V

SCALE=0.5
def theta(W):
    n=W.shape[0]; M=to_M(W); return theta_from_M(M,n,SCALE)
