import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(__file__))
from core import *

def proj_subalg(n, gens):
    """orthogonal projector onto span(gens) inside so(n), gens list of n x n antisym."""
    B = basis_mats(n); N = B.shape[0]
    V = np.array([[ip(g, B[a]) for a in range(N)] for g in gens])
    Uu,s,Vt = np.linalg.svd(V, full_matrices=False)
    r = int((s>1e-10).sum()); Vt = Vt[:r]
    return Vt.T@Vt, r

def E(n,i,j):
    A = np.zeros((n,n)); A[i,j]=1; A[j,i]=-1; return A

def so_pq_gens(n,p):
    g = [E(n,i,j) for i in range(p) for j in range(i+1,p)]
    g += [E(n,i,j) for i in range(p,n) for j in range(i+1,n)]
    return g

def u_m_gens(n):
    """u(m) inside so(2m): commutant of J."""
    m = n//2
    J = np.zeros((n,n))
    for k in range(m): J[2*k,2*k+1]=1; J[2*k+1,2*k]=-1
    B = basis_mats(n); out=[]
    for a in range(B.shape[0]):
        pass
    # basis of {X antisym : XJ=JX}
    gens=[]
    for a in range(B.shape[0]):
        X=B[a]; gens.append(X)
    # solve linear system
    N=B.shape[0]
    Amat = np.array([ (B[a]@J - J@B[a]).ravel() for a in range(N)]).T
    U,s,Vt = np.linalg.svd(Amat)
    ns = Vt[(s.shape[0] if Amat.shape[0]<N else 0):] if False else None
    # nullspace of Amat (n^2 x N)
    U,s,Vt=np.linalg.svd(Amat, full_matrices=True)
    tol=1e-10; r=int((s>tol).sum())
    nulls = Vt[r:]
    return [np.einsum('a,aij->ij', v, B) for v in nulls]

def torus_gens(n):
    return [E(n,2*k,2*k+1) for k in range(n//2)]

def W_from_subalg(n, gens):
    Pi, r = proj_subalg(n, gens)
    N = n*(n-1)//2
    W = Pi - (r/N)*np.eye(N)
    return W/np.linalg.norm(W)

def su3_in_so8_gens():
    """ad(su(3)) acting on su(3) = R^8 (adjoint rep), image in so(8)."""
    import numpy as np
    # Gell-Mann matrices /2 basis of su(3) (anti-hermitian: i*lambda/2)
    lam=[]
    l=np.zeros((3,3),complex); l[0,1]=1;l[1,0]=1; lam.append(l.copy())
    l=np.zeros((3,3),complex); l[0,1]=-1j;l[1,0]=1j; lam.append(l.copy())
    l=np.diag([1,-1,0]).astype(complex); lam.append(l)
    l=np.zeros((3,3),complex); l[0,2]=1;l[2,0]=1; lam.append(l.copy())
    l=np.zeros((3,3),complex); l[0,2]=-1j;l[2,0]=1j; lam.append(l.copy())
    l=np.zeros((3,3),complex); l[1,2]=1;l[2,1]=1; lam.append(l.copy())
    l=np.zeros((3,3),complex); l[1,2]=-1j;l[2,1]=1j; lam.append(l.copy())
    l=np.diag([1,1,-2]).astype(complex)/np.sqrt(3); lam.append(l)
    X=[1j*L/2 for L in lam]   # anti-hermitian basis, <X,Y>=-2tr(XY) orthonormal-ish
    # structure constants -> ad matrices (real 8x8, antisym wrt tr form)
    G=np.array([[ -2*np.trace(X[a]@X[b]).real for b in range(8)] for a in range(8)])
    Ginv=np.linalg.inv(G)
    ads=[]
    for a in range(8):
        Amat=np.zeros((8,8))
        for b in range(8):
            C=X[a]@X[b]-X[b]@X[a]
            co=Ginv@np.array([-2*np.trace(C@X[c]).real for c in range(8)])
            Amat[:,b]=co
        ads.append(Amat)
    # orthonormalise the rep space: G should be prop. to identity for this basis
    return ads
