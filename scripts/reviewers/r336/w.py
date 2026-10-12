"""Reviewer 336 -- independent implementation from the definitions alone."""
import numpy as np, itertools

def pairs(n): return [(i,j) for i in range(n) for j in range(i+1,n)]

def so_basis(n):
    """v_{ij} = E_ij - E_ji as n x n matrices; <A,B> = 1/2 tr(A^T B) makes them orthonormal."""
    P = pairs(n); B = []
    for (i,j) in P:
        M = np.zeros((n,n)); M[i,j]=1.0; M[j,i]=-1.0; B.append(M)
    return P, np.array(B)

def struct(n):
    """c[a,b,cc] = <[v_a,v_b], v_c> with <A,B>=1/2 tr(A^T B). Totally antisymmetric."""
    P,B = so_basis(n); N=len(P)
    c = np.zeros((N,N,N))
    for a in range(N):
        for b in range(N):
            C = B[a]@B[b]-B[b]@B[a]
            # expand C in the basis: coefficient on v_{ij} is C[i,j]
            for cc,(i,j) in enumerate(P):
                c[a,b,cc]=C[i,j]
    return c

def op_to_tensor(M,n,P):
    R = np.zeros((n,n,n,n))
    for a,(i,j) in enumerate(P):
        for b,(k,l) in enumerate(P):
            v=M[a,b]
            R[i,j,k,l]=v; R[j,i,k,l]=-v; R[i,j,l,k]=-v; R[j,i,l,k]=v
    return R

def weyl_basis(n):
    """Basis of Weyl_n inside Sym^2(Lambda^2): first Bianchi + Ricci-flat."""
    P = pairs(n); N=len(P)
    # symmetric matrix coordinates
    idx=[(a,b) for a in range(N) for b in range(a,N)]
    rows=[]
    def sym_mat(k):
        M=np.zeros((N,N)); a,b=idx[k]; M[a,b]=1.0; M[b,a]=1.0
        return M
    # build constraint matrix
    cons=[]
    for k in range(len(idx)):
        R=op_to_tensor(sym_mat(k),n,P)
        v=[]
        for i,j,k2,l in itertools.combinations(range(n),4):
            # first Bianchi on 4 distinct indices (the only nontrivial component)
            v.append(R[i,j,k2,l]+R[i,k2,l,j]+R[i,l,j,k2])
        for i in range(n):
            for k2 in range(i,n):
                v.append(sum(R[i,j,k2,j] for j in range(n)))
        cons.append(v)
    C=np.array(cons).T  # constraints x coords
    from scipy.linalg import null_space
    ns=null_space(C)
    return P, idx, ns  # columns of ns are coordinate vectors

def coords_to_mat(v,idx,N):
    M=np.zeros((N,N))
    for k,(a,b) in enumerate(idx):
        M[a,b]+=v[k]; 
        if a!=b: M[b,a]+=v[k]
        else: pass
    return M

def sharp(M,c):
    """Hamilton's #: M#_{ab} = 1/2 sum_{gd} c_{agd} c_{bgd'} M_{gg'} M_{dd'} -> general form."""
    # M#_{ab} = 1/2 c_{a g d} c_{b e f} M_{ge} M_{df}
    X=np.einsum('agd,bef,ge,df->ab',c,c,M,M)
    return 0.5*X

def Q(M,c): return M@M + sharp(M,c)

def weyl_proj_maker(n):
    P,idx,ns=weyl_basis(n); N=len(P)
    Bm=np.array([coords_to_mat(ns[:,k],idx,N) for k in range(ns.shape[1])]).reshape(ns.shape[1],-1)
    q,_=np.linalg.qr(Bm.T)
    def proj(M):
        v=M.reshape(-1); return (q@(q.T@v)).reshape(N,N)
    return P,idx,proj,N

def subalg_proj(n,mats,P):
    """orthogonal projection of Lambda^2 onto span of the given so(n) matrices, in the v_ij basis"""
    N=len(P)
    G=np.array([[A[i,j] for (i,j) in P] for A in mats])
    q,_=np.linalg.qr(G.T)
    return q@q.T

def u_m(n):
    m=n//2
    J=np.zeros((n,n))
    for k in range(m): J[2*k,2*k+1]=1; J[2*k+1,2*k]=-1
    out=[]
    for i in range(n):
        for j in range(i+1,n):
            A=np.zeros((n,n)); A[i,j]=1; A[j,i]=-1; out.append(A)
    rows=np.array([ (A@J-J@A).ravel() for A in out ])
    # nullspace of the map coeff -> [A,J]
    Cm=rows.T
    u,s,vt=np.linalg.svd(Cm)
    r=int(np.sum(s>1e-9)); nsp=vt[r:]
    mats=[]
    for v in nsp:
        A=np.zeros((n,n)); k=0
        for i in range(n):
            for j in range(i+1,n):
                A[i,j]=v[k]; A[j,i]=-v[k]; k+=1
        mats.append(A)
    return mats

def cartan(n):
    m=n//2; out=[]
    for k in range(m):
        A=np.zeros((n,n)); A[2*k,2*k+1]=1; A[2*k+1,2*k]=-1; out.append(A)
    return out

def block_alg(n,blocks):
    out=[]
    for bl in blocks:
        for x in range(len(bl)):
            for y in range(x+1,len(bl)):
                i,j=bl[x],bl[y]
                A=np.zeros((n,n)); A[i,j]=1; A[j,i]=-1; out.append(A)
    return out
