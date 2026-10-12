import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import *
from review_r30_spec import le_matrix

def report(blocks, tol=1e-8):
    n=sum(blocks); pairs,idx=pair_index(n)
    W,lab = sphere_product_W(blocks); W=normalize(W)
    th=float(np.tensordot(W,Q(n,W))); e=W/th
    B=weyl_basis(n); N=B.shape[1]; d=B.shape[0]
    L,leak = le_matrix(n,e,B,want_leak=False)
    L=0.5*(L+L.T)
    w,V = np.linalg.eigh(L)
    sel = np.abs(w-0.5)<tol
    E = V[:,sel]                      # coefficients in Weyl basis
    Bf = B.reshape(d,-1)
    Emat = (E.T @ Bf)                 # (k, N*N) rows orthonormal
    # orbit tangents
    mixed=[a for a,(i,j) in enumerate(pairs) if lab[i]!=lab[j]]
    unmixed=[a for a in range(len(pairs)) if a not in mixed]
    Tm = orbit_tangent(n,W,mixed); Tu = orbit_tangent(n,W,unmixed)
    Um = orthonormalize(Tm); 
    unm_norm = np.linalg.norm(Tu)
    # residual of orbit tangent inside Weyl
    inweyl = np.linalg.norm(Um - (Um@Bf.T)@Bf)
    cos = principal_cosines(Emat, Um) if Um.size else np.array([])
    p,q=blocks[0],blocks[1] if len(blocks)>1 else 0
    others=w[~sel]
    below=others[others<0.5]
    print(f"{blocks} n={n}: dimE(1/2)={int(sel.sum())} dimOrbit(mixed)={Um.shape[0]} pq={p*q} "
          f"|unmixed tangents|={unm_norm:.2e} orbit-outside-Weyl={inweyl:.2e}")
    print(f"   principal cosines: min={cos.min():.12f} max={cos.max():.12f}  n_cos={cos.size}")
    print(f"   ||Pi_E - Pi_T||_2 = {np.linalg.norm(Emat.T@Emat - Um.T@Um,2):.3e}")
    print(f"   nearest eigenvalue below 1/2: {below.max():.12f}   gap = {0.5-below.max():.9e}")
    print(f"   eigenvalues > 1/2 (excl 1/2): {sorted(set(np.round(others[others>0.5],9)))}")

if __name__=="__main__":
    import ast
    for b in ast.literal_eval(sys.argv[1]): report(tuple(b))
