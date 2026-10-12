"""Reviewer 320: independent rebuild from the definitions. No repo imports."""
import numpy as np, itertools, functools

def pairs(n):
    return [(i,j) for i in range(n) for j in range(i+1,n)]

@functools.lru_cache(maxsize=None)
def basis(n):
    P = pairs(n); N=len(P)
    idx = {p:a for a,p in enumerate(P)}
    phi = np.zeros((N,n,n))
    for a,(i,j) in enumerate(P):
        phi[a,i,j]=1.0; phi[a,j,i]=-1.0
    return P, idx, phi

def ip(X,Y):           # <A,B> = 1/2 tr(A^T B)  -> phi orthonormal
    return 0.5*np.einsum('ij,ij->',X,Y)

@functools.lru_cache(maxsize=None)
def struct(n):
    """c[a,b,c] = <[phi_a,phi_b],phi_c>, orthonormal phi."""
    P,idx,phi = basis(n); N=len(P)
    c = np.zeros((N,N,N))
    for a in range(N):
        for b in range(N):
            com = phi[a]@phi[b]-phi[b]@phi[a]
            if not com.any(): continue
            # expand in phi: coefficient = <com,phi_e> = com[i,j]
            for e,(i,j) in enumerate(P):
                if com[i,j]!=0: c[a,b,e]=com[i,j]
    return c

def sharp(W,n):
    """(W#)_{ab} = 1/2 c_{a g d} c_{b e z} W_{g e} W_{d z}."""
    c = struct(n)
    T1 = np.einsum('agd,ge->aed', c, W, optimize=True)
    T2 = np.einsum('aed,dz->aez', T1, W, optimize=True)
    return 0.5*np.einsum('aez,bez->ab', T2, c, optimize=True)

def Q(W,n): return W@W + sharp(W,n)
def frob(A,B=None):
    B = A if B is None else B
    return float(np.einsum('ab,ab->',A,B))
def P_of(W,n): return frob(W,Q(W,n))
def theta0(n): return np.sqrt(2.0*(n-1)*(n-2))/n

# ---- Riemann 4-tensor <-> Lambda^2 operator ----
def op_to_R4(W,n):
    P,idx,_ = basis(n)
    R = np.zeros((n,n,n,n))
    for a,(i,j) in enumerate(P):
        for b,(k,l) in enumerate(P):
            v = W[a,b]
            R[i,j,k,l]=v;  R[j,i,k,l]=-v;  R[i,j,l,k]=-v;  R[j,i,l,k]=v
    return R

def bianchi_norm(W,n):
    R = op_to_R4(W,n); s=0.0
    for i,j,k,l in itertools.combinations(range(n),4):
        s += (R[i,j,k,l]+R[i,k,l,j]+R[i,l,j,k])**2
    return np.sqrt(s)

def ricci(W,n):
    R = op_to_R4(W,n)
    return np.einsum('ijkj->ik', R)

@functools.lru_cache(maxsize=None)
def weyl_basis(n):
    """Orthonormal basis of Weyl_n inside symmetric NxN matrices (flattened)."""
    P,idx,_ = basis(n); N=len(P)
    # symmetric coordinates
    sym = [(a,b) for a in range(N) for b in range(a,N)]
    D = len(sym)
    cons = []
    # Bianchi
    for i,j,k,l in itertools.combinations(range(n),4):
        row = np.zeros(D)
        for (x,y,z,w),sg in [((i,j,k,l),1),((i,k,l,j),1),((i,l,j,k),1)]:
            # R[x,y,z,w] with x<y? build with signs
            s=sg
            xx,yy = (x,y) if x<y else (y,x)
            if x>y: s=-s
            zz,ww = (z,w) if z<w else (w,z)
            if z>w: s=-s
            a,b = idx[(xx,yy)], idx[(zz,ww)]
            aa,bb = min(a,b),max(a,b)
            row[sym.index((aa,bb))] += s
        cons.append(row)
    # Ricci  Ric_ik = sum_j R[i,j,k,j]
    for i in range(n):
        for k in range(i,n):
            row = np.zeros(D)
            for j in range(n):
                if j==i or j==k: continue
                s=1.0
                x,y=(i,j) if i<j else (j,i)
                if i>j: s=-s
                z,w=(k,j) if k<j else (j,k)
                if k>j: s=-s
                a,b = idx[(x,y)], idx[(z,w)]
                aa,bb=min(a,b),max(a,b)
                row[sym.index((aa,bb))] += s
            cons.append(row)
    Cm = np.array(cons)
    # weight so that the flattened inner product is the Frobenius one:
    # coordinate (a,b) with a<b appears twice in the matrix -> weight sqrt(2)
    wgt = np.array([1.0 if a==b else np.sqrt(2.0) for (a,b) in sym])
    Cw = Cm/wgt                      # constraints in the weighted (orthonormal) coords
    u,s,vt = np.linalg.svd(Cw)
    rank = int((s>1e-9*max(1.0,s[0])).sum())
    ns = vt[rank:]                   # (D-rank, D) orthonormal in weighted coords
    # build matrices
    B = np.zeros((ns.shape[0],N,N))
    for t in range(ns.shape[0]):
        v = ns[t]/wgt
        M = np.zeros((N,N))
        for q,(a,b) in enumerate(sym):
            M[a,b]=v[q]; M[b,a]=v[q]
        B[t]=M
    return B

def proj_weyl(W,n):
    B = weyl_basis(n)
    co = np.einsum('tab,ab->t',B,W)
    return np.einsum('t,tab->ab',co,B)
