import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys; sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r104'))
import numpy as np, weyl104 as w, itertools

def weyl_basis(n):
    """Orthonormal basis of Weyl_n inside S^2(Lambda^2), as M-matrices."""
    P=w.pair_index(n); N=len(P)
    cols=[]
    for a in range(N):
        for b in range(a,N):
            E=np.zeros((N,N)); E[a,b]=E[b,a]=1.0
            T=w.M_to_tensor(E,n); T=w.weyl_project(w.bianchi_project(T),n)
            cols.append(w.tensor_to_M(T,n).ravel())
    A=np.array(cols).T
    U,s,_=np.linalg.svd(A,full_matrices=False)
    r=int((s>1e-9).sum())
    return [U[:,i].reshape(N,N) for i in range(r)], r

for n in (5,6,7):
    B,r=weyl_basis(n)
    print(f"n={n}: dim span of my generator's ambient projection = {r}, dim Weyl_n = {n*(n+1)*(n+2)*(n-3)//12}")
    P=w.pair_index(n); N=len(P)
    # vertex map on this basis: M -> diag
    V=np.array([np.diag(b) for b in B])            # (r, N)
    rk=np.linalg.matrix_rank(V,tol=1e-9)
    print(f"   rank of W -> diag_phi(M)=K map: {rk};  dim{{hollow sym, zero row sums}} = {n*(n-3)//2}")
    # min-norm preimage norm for random unit-norm K in the target space
    rng=np.random.default_rng(7)
    worst=0
    for it_ in range(200):
        A0=rng.standard_normal((n,n)); K=(A0+A0.T)/2; np.fill_diagonal(K,0)
        # project onto zero-row-sum hollow symmetric
        for _it in range(200):
            rs=K.sum(axis=1); K=K-(np.add.outer(rs,rs))/(n-2)+ (rs.sum()/((n-1)*(n-2)))*(np.ones((n,n))-np.eye(n))
            np.fill_diagonal(K,0); K=(K+K.T)/2
            if np.abs(K.sum(axis=1)).max()<1e-14: break
        K=K/np.linalg.norm(K)*np.sqrt(2.0)          # ||K||^2 = 2
        d=np.array([K[i,j] for (i,j) in P])
        sol,res,_,_=np.linalg.lstsq(V.T,d,rcond=None)
        recon=V.T@sol
        err=np.abs(recon-d).max()
        Mrec=sum(c*b for c,b in zip(sol,B))
        worst=max(worst,err)
        if it_==0:
            print(f"   sample: recon err {err:.2e}, min-norm ||M||^2 = {np.linalg.norm(Mrec)**2:.6f} (must be >= t/2 = 1)")
    print(f"   worst recon err over 200 random target K (||K||^2=2): {worst:.2e}")
