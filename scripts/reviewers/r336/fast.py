"""Fast Weyl projection: constraints written directly on operator entries."""
import numpy as np, itertools
from scipy.linalg import null_space
_cache={}
def pairs(n): return [(i,j) for i in range(n) for j in range(i+1,n)]
def pidx(n):
    P=pairs(n); d={}
    for a,(i,j) in enumerate(P): d[(i,j)]=(a,1.0); d[(j,i)]=(a,-1.0)
    return P,d
def weyl_ortho(n):
    """orthonormal columns spanning Weyl_n inside Sym^2(Lambda^2), flattened as N*N vectors."""
    if n in _cache: return _cache[n]
    P,d=pidx(n); N=len(P)
    coords=[(a,b) for a in range(N) for b in range(a,N)]
    cpos={c:k for k,c in enumerate(coords)}
    def add(row,a,b,v):
        key=(a,b) if a<=b else (b,a); row[cpos[key]]+=v
    rows=[]
    for i,j,k,l in itertools.combinations(range(n),4):
        # R_ijkl - R_ikjl + R_iljk = 0   (first Bianchi, only nontrivial on 4 distinct)
        r=np.zeros(len(coords))
        for (p,q,s) in [((i,j),(k,l),1.0),((i,k),(j,l),-1.0),((i,l),(j,k),1.0)]:
            a,sa=d[p]; b,sb=d[q]; add(r,a,b,s*sa*sb)
        rows.append(r)
    for i in range(n):
        for k in range(i,n):
            r=np.zeros(len(coords))
            for j in range(n):
                if j==i or j==k: continue
                a,sa=d[(i,j)]; b,sb=d[(k,j)]; add(r,a,b,sa*sb)
            rows.append(r)
    C=np.array(rows)
    # column scaling: coordinate (a,b) with a<b contributes to two matrix entries
    ns=null_space(C)              # coords x dim
    # turn each coordinate vector into a flattened symmetric matrix
    B=np.zeros((ns.shape[1],N*N))
    for k,(a,b) in enumerate(coords):
        B[:,a*N+b]+=ns[k]; 
        if a!=b: B[:,b*N+a]+=ns[k]
    q,_=np.linalg.qr(B.T)
    _cache[n]=(P,N,q)
    return _cache[n]
def weyl_proj(n,M):
    P,N,q=weyl_ortho(n); v=M.reshape(-1)
    return (q@(q.T@v)).reshape(N,N)
_sc={}
def struct(n):
    if n in _sc: return _sc[n]
    P=pairs(n); N=len(P)
    B=np.zeros((N,n,n))
    for a,(i,j) in enumerate(P): B[a,i,j]=1.0; B[a,j,i]=-1.0
    C=np.einsum('aij,bjk->abik',B,B)-np.einsum('bij,ajk->abik',B,B)
    c=np.zeros((N,N,N))
    for cc,(i,j) in enumerate(P): c[:,:,cc]=C[:,:,i,j]
    _sc[n]=c; return c
def sharp(M,c):
    Z=np.einsum('agd,ge,df->aef',c,M,M,optimize=True)
    return 0.5*np.einsum('aef,bef->ab',Z,c,optimize=True)
def Q(M,c): return M@M+sharp(M,c)
