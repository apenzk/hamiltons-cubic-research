"""Is the residual eigenvalue EXACTLY zero, or is something small hiding there?"""
import sys, numpy as np
sys.path.insert(0, 'scripts/lib')
from review_r33_spec import weyl_basis, L_matrix, predicted, s_m, c_m

for (p,q) in [(2,2),(2,4),(3,3),(3,4),(3,5),(4,4),(4,5),(4,6),(5,5),(4,8),(5,7),(6,6),(3,9),(2,10),(4,10),(7,7)]:
    n=p+q
    B,_=weyl_basis(n); dim=B.shape[0]
    L=L_matrix(p,q,B); L=(L+L.T)/2
    ev=np.linalg.eigvalsh(L)
    pred,named=predicted(p,q,dim)
    zmult=dim-named
    # the eigenvalues nearest zero, excluding those that belong to a named nonzero family
    named_vals=sorted(v for v in pred if abs(v)>1e-9)
    # window around 0: everything strictly between the nearest named values
    lo=max([v for v in named_vals if v<0], default=-1e9)
    hi=min([v for v in named_vals if v>0], default=1e9)
    win=ev[(ev>lo+1e-6)&(ev<hi-1e-6)]
    # sanity: singular values of L to get exact rank information
    sv=np.linalg.svd(L,compute_uv=False)
    tol=dim*np.finfo(float).eps*sv[0]
    rank=int((sv>tol).sum())
    print(f"({p},{q}) n={n:2d} dim={dim:5d}: predicted zero-mult={zmult:5d}  "
          f"|eig| in zero-window: count={len(win)} max={np.max(np.abs(win)) if len(win) else 0:.3e}  "
          f"nullity(L)={dim-rank} (svd tol {tol:.1e})  gap to nearest named: {min(abs(lo),abs(hi)):.4f}", flush=True)
