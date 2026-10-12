"""r314 independent library. Built from definitions; imports nothing from the repo."""
import numpy as np, itertools, functools

# ---------- Lambda^2 = so(n), orthonormal basis A_{ij}, <X,Y> = (1/2) tr(X^T Y)
@functools.lru_cache(maxsize=None)
def pairs(n):
    return tuple((i,j) for i in range(n) for j in range(i+1,n))

@functools.lru_cache(maxsize=None)
def so_mats(n):
    P = pairs(n); N=len(P)
    A = np.zeros((N,n,n))
    for a,(i,j) in enumerate(P):
        A[a,i,j]=1.0; A[a,j,i]=-1.0
    return A

@functools.lru_cache(maxsize=None)
def struct(n):
    """c[a,b,c] = <[A_a,A_b],A_c>, inner product (1/2)tr(X^T Y)."""
    A = so_mats(n); N=A.shape[0]
    # commutators
    C = np.einsum('aij,bjk->abik',A,A) - np.einsum('bij,ajk->abik',A,A)
    c = 0.5*np.einsum('abik,cik->abc',C,A)
    return c

# ---------- sharp
def sharp_raw(n,R,S):
    c = struct(n)
    X = np.einsum('abc,ga->gbc',c,R)          # X[g,b,c]
    Y = np.einsum('ged,eb->gbd',c,S)          # Y[g,b,d]
    return np.einsum('gbc,gbd->cd',X,Y)

_SCALE = {}
def sharp(n,R,S):
    """Hamilton sharp, symmetric bilinear, calibrated so that for coordinate-diagonal
    R,S:  (R#S)_{ij,ij} = 1/2 sum_k (r_ik s_jk + r_jk s_ik)."""
    k = _SCALE.get(n)
    if k is None:
        k = _calibrate(n); _SCALE[n]=k
    M = sharp_raw(n,R,S); M2 = sharp_raw(n,S,R)
    return k*0.5*(M+M2)

def diag_op(n,lam):
    """operator with W E_ij = lam[i,j] E_ij"""
    P=pairs(n); N=len(P)
    return np.diag(np.array([lam[i,j] for (i,j) in P]))

def _calibrate(n):
    rng=np.random.default_rng(0)
    L=rng.normal(size=(n,n)); L=L+L.T; np.fill_diagonal(L,0)
    M=rng.normal(size=(n,n)); M=M+M.T; np.fill_diagonal(M,0)
    R=diag_op(n,L); S=diag_op(n,M)
    A=sharp_raw(n,R,S); B=sharp_raw(n,S,R); H=0.5*(A+B)
    P=pairs(n)
    tgt=[]; got=[]
    for a,(i,j) in enumerate(P):
        v=0.0
        for kk in range(n):
            if kk==i or kk==j: continue
            v += L[i,kk]*M[j,kk] + L[j,kk]*M[i,kk]
        tgt.append(0.5*v); got.append(H[a,a])
    tgt=np.array(tgt); got=np.array(got)
    return float(tgt@got/(got@got))

# ---------- curvature-operator structure
def tensor_from_op(n,R):
    """R_{ijkl} full antisymmetric from operator matrix in E-basis."""
    P=pairs(n); T=np.zeros((n,n,n,n))
    for a,(i,j) in enumerate(P):
        for b,(k,l) in enumerate(P):
            v=R[a,b]
            for (si,ii,jj) in ((1,i,j),(-1,j,i)):
                for (sk,kk,ll) in ((1,k,l),(-1,l,k)):
                    T[ii,jj,kk,ll]=si*sk*v
    return T

@functools.lru_cache(maxsize=None)
def weyl_basis(n):
    """Orthonormal basis of Weyl_n inside Sym(Lambda^2) w.r.t. Frobenius on operators."""
    P=pairs(n); N=len(P)
    # symmetric coordinates
    sy=[(a,b) for a in range(N) for b in range(a,N)]
    D=len(sy)
    rows=[]
    # Bianchi constraints: for i<j<k<l, R_{ijkl}+R_{iklj}+R_{iljk}=0
    idx={p:a for a,p in enumerate(P)}
    def opidx(i,j,k,l):
        s=1.0
        if i>j: i,j=j,i; s=-s
        if k>l: k,l=l,k; s=-s
        a,b=idx[(i,j)],idx[(k,l)]
        if a>b: a,b=b,a
        return sy.index((a,b)) if False else (a,b),s
    symidx={}
    for t,(a,b) in enumerate(sy): symidx[(a,b)]=t
    def add(row,i,j,k,l,coef):
        (a,b),s=opidx(i,j,k,l)
        row[symidx[(a,b)]] += coef*s
    for (i,j,k,l) in itertools.combinations(range(n),4):
        row=np.zeros(D)
        add(row,i,j,k,l,1.0); add(row,i,k,l,j,1.0); add(row,i,l,j,k,1.0)
        rows.append(row)
    # Ricci constraints: Ric_{ik}=sum_j R_{ijkj}=0
    for i in range(n):
        for k in range(i,n):
            row=np.zeros(D)
            for j in range(n):
                if j==i or j==k: continue
                add(row,i,j,k,j,1.0)
            rows.append(row)
    Cm=np.array(rows)
    # metric on sym coords: <X,Y>_F = sum_{a} X_aa Y_aa + 2 sum_{a<b}
    w=np.array([1.0 if a==b else 2.0 for (a,b) in sy])
    # solve Cm x = 0 in the weighted metric: substitute y = sqrt(w) x
    Cw = Cm/np.sqrt(w)[None,:]
    u,s,vt=np.linalg.svd(Cw)
    tol=1e-9*max(Cw.shape)*(s[0] if len(s) else 1)
    r=int((s>tol).sum())
    Ynull=vt[r:]           # (k, D) orthonormal in y coords
    k=Ynull.shape[0]
    B=np.zeros((k,N,N))
    Xn = Ynull/np.sqrt(w)[None,:]
    for t,(a,b) in enumerate(sy):
        B[:,a,b]+=Xn[:,t]
        if a!=b: B[:,b,a]+=Xn[:,t]
    return B

def weyl_proj_factory(n):
    B=weyl_basis(n); k=B.shape[0]; N=B.shape[1]
    Bf=B.reshape(k,-1)
    def proj(M):
        v=Bf@M.reshape(-1)
        return (v@Bf).reshape(N,N)
    def coords(M):
        return Bf@M.reshape(-1)
    def fromc(v):
        return (v@Bf).reshape(N,N)
    return proj,coords,fromc,B

def Q(n,W): return W@W + sharp(n,W,W)
def Pcubic(n,W): return float(np.sum(W*Q(n,W)))
def L_W(n,W,H): return 0.5*(W@H+H@W) + sharp(n,W,H)

# ---------- fast L_W as a matrix on Weyl coords
def sharp_map_matrix(n,W):
    """Kmat[(c,d),(x,y)] with sharp(W,H)_cd = sum Kmat[(c,d),(x,y)] H[x,y]."""
    c = struct(n); N=c.shape[0]
    k=_SCALE.get(n)
    if k is None: k=_calibrate(n); _SCALE[n]=k
    G  = np.einsum('abc,ga->cgb',c,W)                 # G[c,g,b]
    M1 = np.einsum('cgb,ged->cdeb',G,c)               # sharp_raw(W,H)
    H2 = np.einsum('ged,eb->gdb',c,W)
    M2 = np.einsum('abc,gdb->cdga',c,H2)              # sharp_raw(H,W)
    K  = 0.5*k*(M1+M2)
    return K.reshape(N*N,N*N)

def LW_matrix_on_weyl(n,W,B=None):
    if B is None: B=weyl_basis(n)
    dim,N,_=B.shape
    Bf=B.reshape(dim,-1)
    A = 0.5*(np.einsum('ij,kjl->kil',W,B)+np.einsum('kij,jl->kil',B,W)).reshape(dim,-1)
    K = sharp_map_matrix(n,W)
    S = Bf@K.T
    M = (A+S)@Bf.T
    del K,S
    return M
