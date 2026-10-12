"""r271: does # preserve the Bianchi subspace?  Is S^2(L^2)=ker b (+) im b* orthogonal, and
does the Lambda^4 part of M# matter to <M#,M>?"""
import numpy as np, sys
from itertools import combinations
sys.path.insert(0, "scripts/lib")
from weyl import build_structure_constants, bianchi_constraint_matrix, vec_to_mat, mat_to_vec, R_val
from rsharp_basis_free import Rsharp_full

def bianchi_map(M, idx, pos, n):
    """b(M)_{ijkl} for i<j<k<l, using R_val to read entries with correct signs."""
    out=[]
    for (i,j,k,l) in combinations(range(n),4):
        def g(a,b,cc,d):
            return R_val(M,pos,n,a,b,cc,d)
        out.append(g(i,j,k,l)+g(i,k,l,j)+g(i,l,j,k))
    return np.array(out)

for n in (5,6,7):
    idx,pos,N,c = build_structure_constants(n)
    # orthonormal basis of Sym^2 under FROBENIUS
    basis=[]
    for a in range(N):
        E=np.zeros((N,N)); E[a,a]=1.0; basis.append(E)
    for a in range(N):
        for b in range(a+1,N):
            E=np.zeros((N,N)); E[a,b]=E[b,a]=1/np.sqrt(2); basis.append(E)
    B = np.array([bianchi_map(E,idx,pos,n) for E in basis]).T     # (#quads) x dimSym2
    U,S,Vt=np.linalg.svd(B); r=int(np.sum(S>1e-9*S[0]))
    ker = Vt[r:,:]        # orthonormal rows, coords in the Frobenius-orthonormal basis
    coI = Vt[:r,:]
    def coords(X): return np.array([np.tensordot(X,E) for E in basis])
    def fromc(v): return sum(v[i]*basis[i] for i in range(len(basis)))
    rng=np.random.default_rng(7+n)
    # random Bianchi tensor (not necessarily Weyl) and random Weyl tensor
    print(f"\n=== n={n}: dim Sym^2={len(basis)} rank b={r}  dim ker={len(basis)-r}  binom(n,4)={len(list(combinations(range(n),4)))}")
    for label in ("Bianchi","Weyl"):
        for t in range(2):
            v = ker.T@rng.standard_normal(ker.shape[0])
            M = fromc(v)
            if label=="Weyl":
                # project out Ricci: subtract using trace of M over Lambda^2 -> Ric; use record's Weyl basis instead
                pass
            M/=np.linalg.norm(M)
            Sh = Rsharp_full(M,c); Q = M@M + Sh
            cS = coords(Sh); cQ = coords(Q); cM2 = coords(M@M)
            f4 = lambda cx: np.linalg.norm(coI@cx)/np.linalg.norm(cx)
            print(f"  {label} t{t}: L4-frac  M={f4(coords(M)):.1e}  M#={f4(cS):.4f}  M^2={f4(cM2):.4f}  Q=M^2+M#={f4(cQ):.2e}")
            print(f"       <M#,M>={np.tensordot(Sh,M):+.8f}   <P_ker M#,M>={np.tensordot(fromc(ker.T@(ker@cS)),M):+.8f}")
