"""R30: is the triality image a NEW SO(8)-orbit of critical points?"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import *
from review_r30_inv import invariant_weyl, subalg_u, subalg_so_pq
from review_r30_triality import sp1_sp2_so8

def isotropy_algebra(n, W):
    """{A in so(n): [ad(A), W] = 0}; returns basis in phi-coordinates and dim."""
    A=adj(n); N=A.shape[0]
    rows=[]
    for a in range(N):
        rows.append((A[a]@W - W@A[a]).reshape(-1))
    M=np.array(rows)                       # (N, N*N): row a = action of generator a
    u,s,vt=np.linalg.svd(M.T, full_matrices=True)
    tol=max(M.shape)*s[0]*1e-11
    r=int((s>tol).sum())
    return vt[r:], N-r

def rep_commutant_dim(n, hcoef):
    """dim of {C in Mat(n,R): [C, h]=0 for all h in the algebra} -- 1 iff R-irreducible
    with real type; 2 complex type; 4 quaternionic; >4 reducible."""
    pairs,idx=pair_index(n)
    rows=[]
    for hv in hcoef:
        H=np.zeros((n,n))
        for a,(i,j) in enumerate(pairs):
            H[i,j]+=hv[a]; H[j,i]-=hv[a]
        # C -> HC - CH  as a linear map on Mat(n)
        rows.append(np.kron(H,np.eye(n))-np.kron(np.eye(n),H.T))
    M=np.vstack(rows)
    s=np.linalg.svd(M, compute_uv=False)
    tol=max(M.shape)*s[0]*1e-11
    return M.shape[1]-int((s>tol).sum())

def isotypic(n, hcoef):
    """dimensions of R^n-invariant subspaces via the commutant's symmetric part."""
    pairs,idx=pair_index(n)
    Hs=[]
    for hv in hcoef:
        H=np.zeros((n,n))
        for a,(i,j) in enumerate(pairs):
            H[i,j]+=hv[a]; H[j,i]-=hv[a]
        Hs.append(H)
    # random invariant symmetric matrix: average a random symmetric matrix over the algebra
    # instead: solve for symmetric C commuting with all H
    rows=[]
    for H in Hs:
        rows.append(np.kron(H,np.eye(n))-np.kron(np.eye(n),H.T))
    M=np.vstack(rows)
    u,s,vt=np.linalg.svd(M, full_matrices=True)
    tol=max(M.shape)*s[0]*1e-11
    r=int((s>tol).sum())
    ns=vt[r:]
    sym=[]
    for v in ns:
        C=v.reshape(n,n); C=0.5*(C+C.T)
        if np.linalg.norm(C)>1e-8: sym.append(C/np.linalg.norm(C))
    if not sym: return "none"
    S=np.array(sym); rng=np.random.default_rng(1)
    C=np.einsum('k,kij->ij', rng.standard_normal(len(S)), S)
    ev=np.linalg.eigvalsh(C)
    # cluster
    out=[]
    for x in ev:
        if out and abs(x-out[-1][0])<1e-8: out[-1][1]+=1
        else: out.append([x,1])
    return [m for _,m in out]

cases=[]
W,_=sphere_product_W((3,5)); cases.append(("S^3xS^5", 8, normalize(W)))
hb,_,_=sp1_sp2_so8(); d,b,_=invariant_weyl(8,hb); cases.append(("sp(1)+sp(2) inv", 8, normalize(b[0])))
W,_=sphere_product_W((2,6)); cases.append(("S^2xS^6", 8, normalize(W)))
n,hb=subalg_u(4); d,b,_=invariant_weyl(8,hb); cases.append(("CP^4 (u(4))", 8, normalize(b[0])))
W,_=sphere_product_W((4,4)); cases.append(("S^4xS^4", 8, normalize(W)))

for name,n,W in cases:
    th=float(np.tensordot(W,Q(n,W)))
    if th<0: W=-W; th=-th
    hc,dim=isotropy_algebra(n,W)
    print(f"{name:18s} theta={th:.9f}  dim Isotropy(so(8)) = {dim}  orbit = {n*(n-1)//2-dim}")
    print(f"      commutant of R^8-rep = {rep_commutant_dim(n,hc)}   irreducible summand dims = {isotypic(n,hc)}")
