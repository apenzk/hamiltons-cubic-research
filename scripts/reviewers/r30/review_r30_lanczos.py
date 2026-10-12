"""R30: matrix-free top-of-spectrum of L_e on Weyl_n at large n, via an explicit
Weyl projector (no basis materialisation)."""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, adj, sphere_product_W, normalize, Q, weyl_basis
from scipy.sparse.linalg import LinearOperator, eigsh

def make_tensor_maps(n):
    pairs, idx = pair_index(n); N=len(pairs)
    I=np.array([p[0] for p in pairs]); J=np.array([p[1] for p in pairs])
    return pairs, idx, N, I, J

def mat_to_tensor(n, X, I, J):
    """R[i,j,k,l] full antisymmetric-extended tensor from the Lambda^2 matrix."""
    N=X.shape[0]
    R=np.zeros((n,n,n,n))
    R[I[:,None],J[:,None],I[None,:],J[None,:]] = X
    R[J[:,None],I[:,None],I[None,:],J[None,:]] = -X
    R[I[:,None],J[:,None],J[None,:],I[None,:]] = -X
    R[J[:,None],I[:,None],J[None,:],I[None,:]] = X
    return R

def tensor_to_mat(n, R, I, J):
    return R[I[:,None],J[:,None],I[None,:],J[None,:]]

def weyl_project(n, X, I, J):
    R=mat_to_tensor(n,X,I,J)
    alt=(R + np.transpose(R,(0,2,3,1)) + np.transpose(R,(0,3,1,2)))/3.0
    Rb=R-alt
    ric=np.einsum('ijkj->ik', Rb)
    s=np.trace(ric)
    g=np.eye(n)
    def KN(A,B):
        return (np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    Rw = Rb - KN(ric,g)/(n-2) + (s/(2.0*(n-1)*(n-2)))*KN(g,g)
    return tensor_to_mat(n,Rw,I,J)

def build(n, blocks):
    pairs,idx,N,I,J = make_tensor_maps(n)
    W,lab=sphere_product_W(blocks); W=normalize(W)
    th=float(np.tensordot(W,Q(n,W))); e=W/th
    A=adj(n); A2=A.reshape(N*N,N)
    Ae=(A2@e).reshape(N,N,N); AeT=Ae.transpose(0,2,1).reshape(N,N*N)
    def op(v):
        X=v.reshape(N,N); X=0.5*(X+X.T)
        X=weyl_project(n,X,I,J)
        AX=(A2@X).reshape(N,N,N)
        T=AX.reshape(N,N*N)@AeT.T
        Y=0.5*(e@X+X@e)-0.25*(T+T.T)
        Y=weyl_project(n,Y,I,J)
        return Y.reshape(-1)
    return N, th, LinearOperator((N*N,N*N), matvec=op, dtype=float), W, I, J

if __name__=="__main__":
    import ast
    # validation of the explicit projector against the exact Weyl basis
    for n in (8,10):
        pairs,idx,N,I,J=make_tensor_maps(n)
        B=weyl_basis(n); Bf=B.reshape(B.shape[0],-1)
        rng=np.random.default_rng(3)
        X=rng.standard_normal((N,N)); X=0.5*(X+X.T)
        P1=weyl_project(n,X,I,J).reshape(-1)
        P2=Bf.T@(Bf@X.reshape(-1))
        print(f"projector validation n={n}: ||Pi_explicit - Pi_basis|| = {np.linalg.norm(P1-P2):.2e}  (||X||={np.linalg.norm(X):.1f})")
    for blocks in ast.literal_eval(sys.argv[1]):
        blocks=tuple(blocks); p,q=blocks; n=p+q
        t0=time.time()
        N,th,L,W,I,J=build(n,blocks)
        k=min(p*q+25, N*N-2)
        w=eigsh(L, k=k, which='LA', return_eigenvectors=False, tol=1e-10, maxiter=5000)
        w=np.sort(w)[::-1]
        half=int((np.abs(w-0.5)<1e-7).sum())
        below=w[w<0.5-1e-7]
        print(f"S^{p}xS^{q} n={n} theta={th:.10f}: top {k} eigenvalues of L_e|Weyl "
              f"({time.time()-t0:.0f}s)")
        print(f"   #(=1)={int((np.abs(w-1)<1e-7).sum())}  dim E(1/2)={half}  pq={p*q}  "
              f"nearest below = {below.max():.10f}  gap = {0.5-below.max():.6e}")
        print(f"   distinct top values: {sorted(set(np.round(w,8)))[::-1][:8]}")

def deflated_top(n, blocks, extra=6):
    """Top eigenvalues of L_e on Weyl_n after deflating W and the whole orbit tangent.
    If the top is < 1/2 then E(1/2) is EXACTLY the orbit tangent."""
    from review_r30_core import orbit_tangent, orthonormalize
    p,q=blocks
    N,th,L,W,I,J=build(n,blocks)
    T=orbit_tangent(n,W)
    U=orthonormalize(T)                      # (pq, N*N)
    w=W.reshape(-1)/np.linalg.norm(W)
    U=np.vstack([U,w])
    U,_=np.linalg.qr(U.T); U=U.T
    def op(v):
        v=v-U.T@(U@v)
        y=L.matvec(v)
        return y-U.T@(U@y)
    M=LinearOperator((N*N,N*N), matvec=op, dtype=float)
    k=extra
    ev=eigsh(M,k=k,which='LA',return_eigenvectors=False,tol=0,ncv=min(4*k+20,N*N-1))
    return np.sort(ev)[::-1], U.shape[0]-1, p*q
