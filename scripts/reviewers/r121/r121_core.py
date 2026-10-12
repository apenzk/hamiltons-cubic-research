import numpy as np, itertools
np.random.seed(0)

# ---------- basic algebra, my own conventions derived by hand ----------
# operator on Lambda^2 : (W h)_ij = 1/2 W_ijkl h_kl   (so sphere R_ijkl=d_ik d_jl - d_il d_jk gives Id)
# inner product on antisym matrices <A,B> = sum_ij A_ij B_ij
# ||W||_F^2 (as operator on Lambda^2) = 1/4 sum_ijkl W_ijkl^2

def sym_project(T):
    """project a (0,4) array onto tensors with Riemann symmetries + first Bianchi"""
    # antisymmetry in first and last pair, pair symmetry
    T = T - T.transpose(1,0,2,3); T = T - T.transpose(0,1,3,2); T = T/4.0
    T = (T + T.transpose(2,3,0,1))/2.0
    # first Bianchi projector: R -> R - (1/3)(cyclic sum) ... standard
    B = (T + T.transpose(0,2,3,1) + T.transpose(0,3,1,2))/3.0
    T = T - B
    return T

def ricci(T):
    return np.einsum('ijil->jl', T)

def scal(T):
    return np.einsum('ijij->', T)

def weyl_project(T):
    """project onto totally trace-free (Weyl) part, keeping Riemann symmetries"""
    n = T.shape[0]
    T = sym_project(T)
    Ric = ricci(T); S = scal(T)
    g = np.eye(n)
    Ric0 = Ric - S/n*g
    # Kulkarni-Nomizu  (A?g)_ijkl = A_ik g_jl + A_jl g_ik - A_il g_jk - A_jk g_il
    def kn(A,B):
        return (np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
               -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    W = T - kn(Ric0,g)/(n-2) - S/(n*(n-1))*kn(g,g)/2.0
    return W

def rand_weyl(n, rng):
    T = rng.standard_normal((n,n,n,n))
    W = weyl_project(T)
    return W

def op_norm2(W):   # ||W||_F^2 as operator on Lambda^2
    return np.einsum('ijkl,ijkl->',W,W)/4.0

def W2(W):
    return 0.5*np.einsum('ijpq,pqkl->ijkl',W,W)

def Wsharp_tensor(W):
    """step 4's claimed formula"""
    T = np.einsum('ipkq,jplq->ijkl',W,W) - np.einsum('iplq,jpkq->ijkl',W,W)
    return T

# ---------- independent W# from structure constants ----------
def so_basis(n):
    B=[]
    for i in range(n):
        for j in range(i+1,n):
            A=np.zeros((n,n)); A[i,j]=1.0; A[j,i]=-1.0
            B.append(A/np.sqrt(2.0))   # <A,A> = sum A_ij^2 = 1
    return np.array(B)

def op_matrix(W, B):
    """matrix of W acting on Lambda^2 in ON basis B"""
    m=len(B)
    WB = 0.5*np.einsum('ijkl,akl->aij',W,B)
    return np.einsum('aij,bij->ba',WB,B)   # M[b,a] = <phi^b, W phi^a>

def sharp_from_structure(W, B):
    """<R# x,y> = sum_{gd} <[phi^g,phi^d],x><[W phi^g, W phi^d],y>  (kappa=1: Id# = (n-2)Id)"""
    m=len(B)
    WB = 0.5*np.einsum('ijkl,akl->aij',W,B)     # W phi^a
    # brackets
    br0 = np.einsum('aij,bjk->abik',B,B) - np.einsum('bij,ajk->abik',B,B)      # [phi^a,phi^b]
    br1 = np.einsum('aij,bjk->abik',WB,WB) - np.einsum('bij,ajk->abik',WB,WB)  # [W phi^a, W phi^b]
    # components in basis
    c0 = np.einsum('abik,cik->abc',br0,B)
    c1 = np.einsum('abik,cik->abc',br1,B)
    M  = np.einsum('abc,abd->cd',c0,c1)   # <R# phi^c, phi^d>
    return M

def tensor_to_opmatrix(T,B):
    return op_matrix(T,B)

def ring(T, h):
    return np.einsum('iklj,kl->ij',T,h)

def ring_matrix(T, S0basis):
    m=len(S0basis)
    R=np.zeros((m,m))
    for a,ha in enumerate(S0basis):
        v = ring(T,ha)
        for b,hb in enumerate(S0basis):
            R[b,a]=np.einsum('ij,ij->',hb,v)
    return R

def s20_basis(n):
    B=[]
    for i in range(n):
        for j in range(i+1,n):
            A=np.zeros((n,n)); A[i,j]=A[j,i]=1/np.sqrt(2.0); B.append(A)
    # diagonal trace-free
    for k in range(1,n):
        A=np.zeros((n,n))
        for i in range(k): A[i,i]=1.0
        A[k,k]=-k
        A/=np.linalg.norm(A); B.append(A)
    return np.array(B)

# ---------- checks ----------
n=6
rng=np.random.default_rng(1)
B=so_basis(n)
W=rand_weyl(n,rng); W/=np.sqrt(op_norm2(W))

print("== sanity ==")
print("op norm^2", op_norm2(W), " tensor |W|^2", np.einsum('ijkl,ijkl->',W,W))
print("Ricci(W) max", np.abs(ricci(W)).max())
print("Bianchi resid", np.abs(W+W.transpose(0,2,3,1)+W.transpose(0,3,1,2)).max())

# Id# = (n-2) Id ?
Idt = np.einsum('ik,jl->ijkl',np.eye(n),np.eye(n))-np.einsum('il,jk->ijkl',np.eye(n),np.eye(n))
Mid = sharp_from_structure(Idt,B)
print("Id# / Id  (should be n-2 =",n-2,"):", np.diag(Mid)[:3], "offdiag", np.abs(Mid-np.diag(np.diag(Mid))).max())

# step 4 formula vs structure constants
Ms = sharp_from_structure(W,B)
Mt = tensor_to_opmatrix(Wsharp_tensor(W),B)
print("STEP4 |sharp_struct - sharp_tensorformula| =", np.abs(Ms-Mt).max(), " scale", np.abs(Ms).max())
