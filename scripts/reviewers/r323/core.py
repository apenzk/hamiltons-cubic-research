"""Reviewer 323 -- independent implementation of so(n), Weyl_n, #, Q, criticality.
Built from definitions only; no record scripts imported."""
import numpy as np, itertools

def pairs(n):
    return [(i,j) for i in range(n) for j in range(i+1,n)]

def so_basis(n):
    """Orthonormal basis L_ij of so(n) under <A,B> = (1/2) tr(A^T B)."""
    P = pairs(n); B = []
    for (i,j) in P:
        M = np.zeros((n,n)); M[i,j]=1.0; M[j,i]=-1.0; B.append(M)
    return P, np.array(B)

def ip(A,B):
    return 0.5*np.tensordot(A,B,axes=([0,1],[0,1]))

def struct(n):
    """C[a,b,c] = <[L_a,L_b],L_c>, orthonormal basis."""
    P,B = so_basis(n); N=len(P)
    C = np.zeros((N,N,N))
    for a in range(N):
        for b in range(N):
            K = B[a]@B[b]-B[b]@B[a]
            for c in range(N):
                (i,j)=P[c]
                C[a,b,c] = K[i,j]     # = (1/2)tr(K^T L_c) = K_ij
    return C

class Ctx:
    def __init__(self,n):
        self.n=n; self.P,self.B = so_basis(n); self.N=len(self.P)
        self.C = struct(n)
        # ad_a as matrix: (ad_a)_{c,b} = <[L_a,L_b],L_c> = C[a,b,c]
        self.ad = np.transpose(self.C,(0,2,1))   # ad[a][c,b]
        self.W = weyl_basis(self)                # orthonormal basis of Weyl_n, shape (dW,N,N)

def ad_of(ctx, v):
    """ad(v) as an N x N matrix for v a coefficient vector in so(n)."""
    return np.tensordot(v, ctx.ad, axes=(0,0))

def sharp(ctx, W):
    """W#_{ab} = -(1/2) tr(ad_a W ad_b W)."""
    U = np.einsum('adc,ce->ade', ctx.ad, W)      # ad_a W
    return -0.5*np.einsum('ade,bed->ab', U, U)

def Qmap(ctx, W):
    return W@W + sharp(ctx,W)

def Pval(ctx, W):
    return float(np.tensordot(W, Qmap(ctx,W), axes=([0,1],[0,1])))

# ---------- Weyl_n ----------
def weyl_basis(ctx):
    """Symmetric operators on Lambda^2 with R_{ijkl}+R_{iklj}+R_{iljk}=0 and Ricci=0."""
    n=ctx.n; P=ctx.P; N=ctx.N
    idx={}
    for a,(i,j) in enumerate(P):
        idx[(i,j)]=(a,1.0); idx[(j,i)]=(a,-1.0)
    # parametrise symmetric N x N matrices
    sym=[(a,b) for a in range(N) for b in range(a,N)]
    pos={ab:k for k,ab in enumerate(sym)}
    def col(a,b,s):
        k=pos[(a,b)] if a<=b else pos[(b,a)]
        return k,s
    rows=[]
    def R_entry(i,j,k,l):
        """returns list of (col_index, coeff) for R_{ijkl}"""
        if i==j or k==l: return []
        a,sa=idx[(i,j)]; b,sb=idx[(k,l)]
        c,s = col(a,b,sa*sb)
        return [(c,s)]
    # Bianchi
    seen=set()
    for i,j,k,l in itertools.product(range(n),repeat=4):
        key=(i,j,k,l)
        if len({i,j,k,l})<3: pass
        row=np.zeros(len(sym)); nz=False
        for (x,y,z,w) in [(i,j,k,l),(i,k,l,j),(i,l,j,k)]:
            for c,s in R_entry(x,y,z,w): row[c]+=s; nz=True
        if nz and np.any(row!=0):
            t=tuple(np.round(row,12)); 
            if t not in seen:
                seen.add(t); rows.append(row)
    # Ricci
    for i in range(n):
        for k in range(n):
            row=np.zeros(len(sym)); 
            for j in range(n):
                for c,s in R_entry(i,j,k,j): row[c]+=s
            if np.any(row!=0): rows.append(row)
    A=np.array(rows) if rows else np.zeros((1,len(sym)))
    # nullspace
    u,s,vt=np.linalg.svd(A)
    tol=max(A.shape)*np.finfo(float).eps*(s[0] if len(s) else 1.0)*10
    ns=vt[np.sum(s>tol):] if len(s) else vt
    out=[]
    for row in ns:
        M=np.zeros((N,N))
        for k,(a,b) in enumerate(sym):
            M[a,b]+=row[k]; 
            if a!=b: M[b,a]+=row[k]
        M/=np.sqrt(np.tensordot(M,M,axes=([0,1],[0,1])))
        out.append(M)
    # re-orthonormalise (Frobenius)
    V=np.array([M.ravel() for M in out])
    Qm,_=np.linalg.qr(V.T)
    return np.array([Qm[:,i].reshape(N,N) for i in range(Qm.shape[1])])

def proj_weyl(ctx, M):
    M=0.5*(M+M.T)
    co=np.einsum('kab,ab->k', ctx.W, M)
    return np.einsum('k,kab->ab', co, ctx.W)

def crit_residual(ctx, W):
    """||Q(W) - theta W|| / ||W||^2 with theta = <W,Q(W)>/||W||^2, W unit."""
    nw=np.sqrt(np.tensordot(W,W,axes=([0,1],[0,1])))
    Wn=W/nw
    QW=Qmap(ctx,Wn); th=float(np.tensordot(Wn,QW,axes=([0,1],[0,1])))
    return th, float(np.linalg.norm(QW-th*Wn))
