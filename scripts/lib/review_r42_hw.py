"""Reviewer 42: explicit U(m) highest-weight vectors inside Weyl_{2m} (x) C,
and the L_e eigenvalue each one carries.  Independent of any deflation."""
import numpy as np, sys, itertools
sys.path.insert(0, 'scripts/lib')
from review_r42_core import *
from review_r42_spec import e_cpm

def cbasis(n):
    """f_k = e_{2k} + i e_{2k+1}  (J f_k = i f_k),  fbar_k."""
    m=n//2
    f=np.zeros((m,n),dtype=complex); fb=np.zeros((m,n),dtype=complex)
    for k in range(m):
        f[k,2*k]=1; f[k,2*k+1]=1j
        fb[k,2*k]=1; fb[k,2*k+1]=-1j
    return f,fb

def wedge(n,u,v):
    P=pairs(n); M=np.outer(u,v)-np.outer(v,u)
    return np.array([M[i,j] for (i,j) in P])

def lam2_weight_basis(n):
    """weight basis of Lambda^2 (x) C with U(1)^m weights (as integer vectors)."""
    m=n//2; f,fb=cbasis(n); out=[]
    for k in range(m):
        for l in range(k+1,m):
            w=np.zeros(m,int); w[k]+=1; w[l]+=1
            out.append((wedge(n,f[k],f[l]), w, 2))          # Lambda^2 V, charge +2
    for k in range(m):
        for l in range(m):
            w=np.zeros(m,int); w[k]+=1; w[l]-=1
            out.append((wedge(n,f[k],fb[l]), w, 0))         # V (x) Vbar = gl(m)
    for k in range(m):
        for l in range(k+1,m):
            w=np.zeros(m,int); w[k]-=1; w[l]-=1
            out.append((wedge(n,fb[k],fb[l]), w, -2))       # Lambda^2 Vbar
    return out

def Dmat(n,Y):
    """induced action of Y in so(2m,C) on Lambda^2 (x) C, in the phi basis."""
    P=pairs(n); N=len(P)
    D=np.zeros((N,N),dtype=complex)
    for b,(i,j) in enumerate(P):
        pb=phi(n,i,j).astype(complex)
        C=Y@pb-pb@Y
        D[:,b]=[C[k,l] for (k,l) in P]
    return D

def gl_element(n,M):
    """so(2m,C) element acting as M on V and -M^T on Vbar."""
    m=n//2; f,fb=cbasis(n)
    S=np.zeros((n,n),dtype=complex)
    S[:,:m]=f.T; S[:,m:]=fb.T
    blk=np.zeros((n,n),dtype=complex); blk[:m,:m]=M; blk[m:,m:]=-M.T
    Y=S@blk@np.linalg.inv(S)
    return Y

def sym_prod(u,v):
    return 0.5*(np.outer(u,v)+np.outer(v,u))

def Le_apply(n,e,X):
    N=len(pairs(n)); A=Amats(n)
    AX=(A.reshape(N*N,N)@X).reshape(N,N,N)
    Ae=(A.reshape(N*N,N)@e).reshape(N,N,N)
    T=Ae.reshape(N,N*N)@np.transpose(AX,(0,2,1)).reshape(N,N*N).T
    return 0.5*(e@X+X@e)-0.25*(T+T.T)

def hw_vector(m, nu, verbose=True):
    n=2*m; N=len(pairs(n)); e=e_cpm(m)
    wb=lam2_weight_basis(n)
    # weight-nu subspace of Sym^2 -> project to Weyl
    cols=[]
    for i in range(len(wb)):
        for j in range(i,len(wb)):
            if tuple(wb[i][1]+wb[j][1])==tuple(nu):
                X=sym_prod(wb[i][0],wb[j][0])
                cols.append(proj_weyl(n,X).ravel())
    if not cols: return None,0,0,None
    A=np.array(cols).T
    # complex orthonormal basis of the projected weight space
    U,s,_=np.linalg.svd(A, full_matrices=False)
    tol=1e-9*max(1.0,s.max()); keep=s>tol
    Bw=U[:,keep]
    dimw=Bw.shape[1]
    # raising operators E_{kl}, k<l
    rows=[]
    for k in range(m):
        for l in range(k+1,m):
            M=np.zeros((m,m),dtype=complex); M[k,l]=1
            D=Dmat(n,gl_element(n,M))
            for c in range(dimw):
                X=Bw[:,c].reshape(N,N)
                Y=D@X-X@D
                rows.append(Y.ravel())
    R=np.array(rows).reshape(-1,dimw*0+N*N) if False else None
    # build the matrix of the raising action in the Bw coordinates
    blocks=[]
    for k in range(m):
        for l in range(k+1,m):
            M=np.zeros((m,m),dtype=complex); M[k,l]=1
            D=Dmat(n,gl_element(n,M))
            Mat=np.zeros((N*N,dimw),dtype=complex)
            for c in range(dimw):
                X=Bw[:,c].reshape(N,N)
                Mat[:,c]=(D@X-X@D).ravel()
            blocks.append(Mat)
    Big=np.vstack(blocks) if blocks else np.zeros((1,dimw))
    U2,s2,Vh=np.linalg.svd(Big, full_matrices=True)
    tol2=1e-8*max(1.0,s2.max() if s2.size else 1.0)
    nz=(s2>tol2).sum()
    ker=Vh[nz:,:].conj().T           # dimw x (dimw-nz)
    khw=ker.shape[1]
    if khw==0: return None,dimw,0,None
    vecs=Bw@ker
    out=[]
    for c in range(khw):
        X=vecs[:,c].reshape(N,N)
        Y=Le_apply(n,e,X)
        lam=np.vdot(X.ravel(),Y.ravel())/np.vdot(X.ravel(),X.ravel())
        res=np.linalg.norm(Y-lam*X)/np.linalg.norm(X)
        wl=np.linalg.norm(proj_weyl(n,X)-X)/np.linalg.norm(X)
        out.append((lam,res,wl,np.linalg.norm(X)))
    return out,dimw,khw,vecs
