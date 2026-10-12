"""M1: Morse-Bott nondegeneracy of sphere products -- lambda_max(L_e|W-perp)
and the orbit tangent, computed from my own L_e."""
import numpy as np, sys, os, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import r311_core as K

def sphere_product(ns):
    n=sum(ns); M=np.zeros((n,n)); off=0
    for m in ns:
        for i in range(off,off+m):
            for j in range(off,off+m):
                if i!=j: M[i,j]=1.0/(2*(m-1))
        off+=m
    R=np.diag(np.array([M[i,j] for (i,j) in K.pair_list(n)]))
    return n, R-np.eye(len(R))/(2*(n-1))

def orbit_dim(n,W):
    A=K.ad_matrices(n); N=len(W)
    V=np.array([(A[a]@W-W@A[a]).ravel() for a in range(len(A))])
    return np.linalg.matrix_rank(V, tol=1e-9), V

cases=[(3,3),(3,5),(4,4),(3,7),(4,6),(5,5),(5,7),(6,6)]
for ns in cases:
    t0=time.time(); n,W=sphere_product(ns)
    nrm=np.linalg.norm(W); Wn=W/nrm
    theta=float(np.sum(K.Q(n,Wn)*Wn))
    bas=K.weyl_basis(n)
    ev=K.lambda_max_perp(n,Wn,theta,bas)
    od,_=orbit_dim(n,Wn)
    p,q=ns
    mu=0.5-((p-2)*(q-2)-1)/(2.0*(p-1)*(q-1))
    top=ev[-1]; mult=int(np.sum(ev>top-1e-9))
    second=ev[ev<top-1e-9]
    print(f"S{p}xS{q} n={n:3d} dimWeyl={len(bas)} theta={theta:.9f} "
          f"lam_max={top:.12f} mult={mult} dim(orbit)={od} "
          f"2nd={second[-1] if len(second) else float('nan'):.9f} mu_formula={mu:.9f} "
          f"({time.time()-t0:.0f}s)", flush=True)
