"""Reviewer 101: independent implementation from brief3.md definitions."""
import numpy as np
import itertools, math

def pairs(n):
    return [(i,j) for i in range(n) for j in range(i+1,n)]

# ---------- symmetry projections ----------
def sym_riemann(T):
    """project onto S^2(Lambda^2): antisym in (0,1),(2,3), sym under pair swap."""
    T = 0.5*(T - T.transpose(1,0,2,3))
    T = 0.5*(T - T.transpose(0,1,3,2))
    T = 0.5*(T + T.transpose(2,3,0,1))
    return T

def bianchi(T):
    """remove the Lambda^4 part: b(T)_{ijkl}=(1/3)(T_{ijkl}+T_{iklj}+T_{iljk})."""
    b = (T + T.transpose(0,2,3,1) + T.transpose(0,3,1,2))/3.0
    return T - b

def kn(h, n):
    g = np.eye(n)
    return (np.einsum('ik,jl->ijkl',h,g) + np.einsum('jl,ik->ijkl',h,g)
            - np.einsum('il,jk->ijkl',h,g) - np.einsum('jk,il->ijkl',h,g))

_KNCACHE = {}
def kn_basis(n):
    if n in _KNCACHE: return _KNCACHE[n]
    rows = []
    for i in range(n):
        for j in range(i,n):
            h = np.zeros((n,n)); h[i,j]=1; h[j,i]=1
            rows.append(kn(h,n).ravel())
    A = np.array(rows).T           # (n^4, dim S^2)
    Q,_ = np.linalg.qr(A)
    _KNCACHE[n] = Q
    return Q

def weyl_project(T):
    """full projection onto W_n: Riemann sym -> Bianchi -> orthogonal to KN image."""
    n = T.shape[0]
    T = bianchi(sym_riemann(T))
    T = sym_riemann(T)             # bianchi step preserves it, re-symmetrise for safety
    Q = kn_basis(n)
    v = T.ravel()
    v = v - Q@(Q.T@v)
    return v.reshape(n,n,n,n)

def random_weyl(n, rng):
    N = n*(n-1)//2
    P = pairs(n)
    A = rng.standard_normal((N,N)); A = A+A.T
    T = np.zeros((n,n,n,n))
    for a,(i,j) in enumerate(P):
        for b,(k,l) in enumerate(P):
            v = A[a,b]
            T[i,j,k,l]=v; T[j,i,k,l]=-v; T[i,j,l,k]=-v; T[j,i,l,k]=v
    return weyl_project(T)

# ---------- operator on Lambda^2 ----------
def Mmat(W):
    n = W.shape[0]; P = pairs(n); N=len(P)
    M = np.empty((N,N))
    for a,(i,j) in enumerate(P):
        for b,(k,l) in enumerate(P):
            M[a,b]=W[i,j,k,l]
    return M

def normalise(W):
    M = Mmat(W)
    return W/np.linalg.norm(M)

# ---------- structure constants of so(n), unnormalised phi_ij = E_ij - E_ji ----------
_CCACHE={}
def struct_c(n):
    """c[a,g,d] with [phi_g, phi_d] = sum_a c[a,g,d] phi_a, basis pairs i<j."""
    if n in _CCACHE: return _CCACHE[n]
    P = pairs(n); N=len(P); idx={p:a for a,p in enumerate(P)}
    c = np.zeros((N,N,N))
    def add(c, i,j, val, g,d):
        if i==j: return
        if i<j: c[idx[(i,j)],g,d]+=val
        else:   c[idx[(j,i)],g,d]-=val
    for g,(i,j) in enumerate(P):
        for d,(k,l) in enumerate(P):
            # [phi_ij, phi_kl] = d_jk phi_il - d_ik phi_jl - d_jl phi_ik + d_il phi_jk
            if j==k: add(c,i,l, 1.0,g,d)
            if i==k: add(c,j,l,-1.0,g,d)
            if j==l: add(c,i,k,-1.0,g,d)
            if i==l: add(c,j,k, 1.0,g,d)
    _CCACHE[n]=c
    return c

def sharp(M, n):
    c = struct_c(n)                              # c[a,g,d]
    N = c.shape[0]
    X = (c.transpose(0,2,1).reshape(N*N, N) @ M).reshape(N, N, N)   # X[a,d,e]
    Y = (X.transpose(0,2,1).reshape(N*N, N) @ M).reshape(N, N, N)   # Y[a,e,z]
    return 0.5*(Y.reshape(N, N*N) @ c.reshape(N, N*N).T)

def theta_of(W):
    n=W.shape[0]; M=Mmat(W)
    Ms = sharp(M,n)
    return np.trace(M@M@M) + np.sum(Ms*M), M

# ---------- curvature operator of the second kind, Li's convention ----------
def s20_basis(n):
    B=[]
    for i in range(n):
        for j in range(i+1,n):
            h=np.zeros((n,n)); h[i,j]=h[j,i]=1/math.sqrt(2); B.append(h)
    for k in range(1,n):
        h=np.zeros((n,n))
        for i in range(k): h[i,i]=1.0
        h[k,k]=-k
        h/=np.linalg.norm(h); B.append(h)
    return B

def ring_spectrum(W):
    n=W.shape[0]; B=s20_basis(n); m=len(B)
    Op=np.empty((m,m))
    for q,h in enumerate(B):
        img = np.einsum('iklj,kl->ij', W, h)
        for p,b in enumerate(B):
            Op[p,q]=np.sum(b*img)
    Op=0.5*(Op+Op.T)
    return np.linalg.eigvalsh(Op)

# ---------- model tensors ----------
def weyl_sphere_product(n, p, pad=0):
    """S^p x S^q, q=n-p-pad, unit curvature on each factor, padded with zeros."""
    m=n-pad
    q=m-p
    T=np.zeros((n,n,n,n)); g=np.eye(n)
    for lo,hi in [(0,p),(p,p+q)]:
        gg=np.zeros((n,n))
        for i in range(lo,hi): gg[i,i]=1.0
        T += np.einsum('ik,jl->ijkl',gg,gg)-np.einsum('il,jk->ijkl',gg,gg)
    return weyl_project(T)

def weyl_cpm(m, n=None):
    """Fubini-Study, real dim 2m, padded into R^n."""
    d=2*m
    if n is None: n=d
    J=np.zeros((n,n))
    for i in range(m):
        J[2*i,2*i+1]=1.0; J[2*i+1,2*i]=-1.0
    g=np.zeros((n,n))
    for i in range(d): g[i,i]=1.0
    T=(np.einsum('ik,jl->ijkl',g,g)-np.einsum('il,jk->ijkl',g,g)
       +np.einsum('ik,jl->ijkl',J,J)-np.einsum('il,jk->ijkl',J,J)
       +2*np.einsum('ij,kl->ijkl',J,J))
    return weyl_project(T)

# ---------- vertex matrix and kappa ----------
def rotate(W,F):
    return np.einsum('ijkl,ia,jb,kc,ld->abcd', W, F, F, F, F, optimize=True)

def Kmat(W):
    n=W.shape[0]
    K=np.einsum('abab->ab', W).copy()
    np.fill_diagonal(K,0.0)
    return K

def kfro2(W,F):
    T=rotate(W,F)
    K=np.einsum('abab->ab',T).copy(); np.fill_diagonal(K,0.0)
    return np.sum(K*K)

def kgrad(W,F):
    n=W.shape[0]
    T=rotate(W,F)
    D=np.zeros((n,n,n,n))
    diag=np.einsum('abab->ab',T).copy(); np.fill_diagonal(diag,0.0)
    for a in range(n):
        for b in range(n):
            if a!=b: D[a,b,a,b]=2*diag[a,b]
    G  = np.einsum('pbcd,mjkl,jb,kc,ld->mp', D, W, F,F,F, optimize=True)
    G += np.einsum('apcd,imkl,ia,kc,ld->mp', D, W, F,F,F, optimize=True)
    G += np.einsum('abpd,ijml,ia,jb,ld->mp', D, W, F,F,F, optimize=True)
    G += np.einsum('abcp,ijkm,ia,jb,kc->mp', D, W, F,F,F, optimize=True)
    return np.sum(diag*diag), G

def polar(F):
    U,_,Vt=np.linalg.svd(F)
    return U@Vt

def kappa2(W, starts=40, iters=400, rng=None, F0list=None, verbose=False):
    """max over O(n) of ||K(F)||_F^2 by Riemannian ascent, multi-start."""
    n=W.shape[0]
    if rng is None: rng=np.random.default_rng(0)
    cands=[]
    if F0list: cands+=list(F0list)
    cands.append(np.eye(n))
    while len(cands)<starts:
        A=rng.standard_normal((n,n)); Q,R=np.linalg.qr(A); Q=Q*np.sign(np.diag(R))
        cands.append(Q)
    best=-1; bestF=None
    for F in cands:
        F=polar(F); step=0.3
        f,_=kgrad(W,F)
        for it in range(iters):
            f,G=kgrad(W,F)
            Om=G@F.T-F@G.T
            gn=np.linalg.norm(Om)
            if gn<1e-13: break
            ok=False
            for _ in range(30):
                from scipy.linalg import expm
                Fn=polar(expm(step*Om)@F)
                fn,_=kgrad(W,Fn)
                if fn>f+1e-16:
                    F=Fn; f=fn; step*=1.6; ok=True; break
                step*=0.4
                if step<1e-14: break
            if not ok: break
        if f>best: best=f; bestF=F
    return best, bestF

def pad(W, n):
    d=W.shape[0]
    if n==d: return W
    T=np.zeros((n,n,n,n)); T[:d,:d,:d,:d]=W
    return T
