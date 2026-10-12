import numpy as np, core

def norm(W): return W/np.linalg.norm(W)

def theta(W,c): return float(np.tensordot(W, core.Q(W,c), 2))

def crit_res(W,c):
    th = theta(W,c); return float(np.linalg.norm(core.Q(W,c)-th*W)), th

def pair_index(n):
    P = core.pairs(n); return {p:a for a,p in enumerate(P)}

def proj_subalgebra(n, gens):
    """orthogonal projector onto span(gens) inside Lambda^2, gens given as N-vectors"""
    G = np.array(gens).T
    U,S,Vt = np.linalg.svd(G, full_matrices=False)
    U = U[:, S>1e-10]
    return U@U.T

def so_block(n, idxs):
    """basis vectors of so(idxs) inside Lambda^2 R^n"""
    pi = pair_index(n); N=n*(n-1)//2
    out=[]
    for a in range(len(idxs)):
        for b in range(a+1,len(idxs)):
            i,j = sorted((idxs[a],idxs[b]))
            v=np.zeros(N); v[pi[(i,j)]]=1.0; out.append(v)
    return out

def u_m(n):
    """u(m) subset so(2m), m=n/2, standard complex structure J: (0<->1),(2<->3),..."""
    m=n//2; pi=pair_index(n); N=n*(n-1)//2
    J=np.zeros((n,n))
    for k in range(m): J[2*k,2*k+1]=1; J[2*k+1,2*k]=-1
    out=[]
    B=core.basis(n)*np.sqrt(2.0)   # phi_ij = e_i e_j^T - e_j e_i^T
    for a in range(N):
        X=B[a]
        Y=0.5*(X - J@X@J.T*(-1))   # commutes-with-J part:  (X + J X J^{-1})/2, J^{-1}=-J
    # do it properly by projecting the basis onto the commutant of J
    M=[]
    for a in range(N):
        X=B[a]
        Y=0.5*(X + J@X@np.linalg.inv(J))
        M.append(np.array([np.sum(Y*B[b])/2.0 for b in range(N)]))
    M=np.array(M)
    U,S,Vt=np.linalg.svd(M)
    r=int((S>1e-8).sum())
    return [Vt[i] for i in range(r)]

def torus(n):
    pi=pair_index(n); N=n*(n-1)//2; out=[]
    for k in range(n//2):
        v=np.zeros(N); v[pi[(2*k,2*k+1)]]=1.0; out.append(v)
    return out

def ad_su3_in_so8(n=8):
    """ad(su(3)) acting on su(3)=R^8 -- 8-dim adjoint rep, image in so(8)."""
    lam=[]
    import numpy as np
    l1=np.array([[0,1,0],[1,0,0],[0,0,0]],dtype=complex)
    l2=np.array([[0,-1j,0],[1j,0,0],[0,0,0]])
    l3=np.array([[1,0,0],[0,-1,0],[0,0,0]],dtype=complex)
    l4=np.array([[0,0,1],[0,0,0],[1,0,0]],dtype=complex)
    l5=np.array([[0,0,-1j],[0,0,0],[1j,0,0]])
    l6=np.array([[0,0,0],[0,0,1],[0,1,0]],dtype=complex)
    l7=np.array([[0,0,0],[0,0,-1j],[0,1j,0]])
    l8=np.array([[1,0,0],[0,1,0],[0,0,-2]],dtype=complex)/np.sqrt(3)
    L=[l1,l2,l3,l4,l5,l6,l7,l8]
    X=[1j*l/2 for l in L]   # su(3) basis, <A,B> = -2 tr(AB) makes it orthonormal-ish
    # orthonormalise under <A,B> = -tr(AB)*2
    def ip(A,B): return float(np.real(-2*np.trace(A@B)))
    G=np.array([[ip(a,b) for b in X] for a in X])
    Ls=np.linalg.cholesky(G)
    Xi=[sum(np.linalg.inv(Ls)[i,j]*X[j] for j in range(8)) for i in range(8)]
    # ad matrices
    ad=[]
    for i in range(8):
        M=np.zeros((8,8))
        for j in range(8):
            br=Xi[i]@Xi[j]-Xi[j]@Xi[i]
            for k in range(8): M[k,j]=ip(br,Xi[k])
        ad.append(M)
    B=core.basis(8)*np.sqrt(2.0)
    N=28
    out=[]
    for M in ad:
        out.append(np.array([np.sum(M*B[b])/2.0 for b in range(N)]))
    return out

def W_from_subalgebra(n, gens, wl):
    Pi = proj_subalgebra(n, gens)
    return norm(wl.project(Pi))

def W_cp2():
    """self-dual Weyl tensor on n=4: diag(2,-1,-1)/sqrt6 on Lambda^2_+, 0 on Lambda^2_-"""
    n=4; pi=pair_index(4); N=6
    def v(i,j,k,l,s):
        w=np.zeros(N); w[pi[(i,j)]]=1/np.sqrt(2); w[pi[(k,l)]]=s/np.sqrt(2); return w
    sd=[v(0,1,2,3,1), v(0,2,1,3,-1), v(0,3,1,2,1)]
    W=np.zeros((N,N))
    sp=[2,-1,-1]
    for a,x in enumerate(sd): W += sp[a]*np.outer(x,x)
    return W/np.sqrt(6)

def pad(W4, n):
    """embed a Lambda^2 R^4 operator into Lambda^2 R^n on the first 4 coordinates"""
    pi4=pair_index(4); pin=pair_index(n); N=n*(n-1)//2
    W=np.zeros((N,N))
    for (i,j),a in pi4.items():
        for (k,l),b in pi4.items():
            W[pin[(i,j)],pin[(k,l)]]=W4[a,b]
    return W

def diagonal_weyl(n, K):
    """K symmetric hollow with zero row sums -> diagonal Weyl operator"""
    pi=pair_index(n); N=n*(n-1)//2
    W=np.zeros((N,N))
    for (i,j),a in pi.items(): W[a,a]=K[i,j]
    return W
