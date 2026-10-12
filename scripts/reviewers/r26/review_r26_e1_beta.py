"""Sharp constant beta_n = max |<W^# X,X>| over unit Weyl W and unit X in Lambda^2,
and the true (w, T) data at the balanced sphere product."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys, math
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
from review_r26_core import *
rng=np.random.default_rng(31)

def beta(n, tries=25, iters=800):
    C=struct_const(n); B=weyl_basis(n); N=C.shape[0]; K=B.shape[0]
    best=0.0
    for t in range(tries):
        co=rng.normal(size=K); x=rng.normal(size=N)
        for it in range(iters):
            co/=np.linalg.norm(co); x/=np.linalg.norm(x)
            W=np.einsum('k,kab->ab',co,B)
            S=sharp_fast(W,C)
            f=x@S@x
            sgn=1.0 if f>=0 else -1.0
            gx=2*sgn*(S@x)
            # gradient in W: <W^#X,X> is quadratic in W;  d/dW of 1/2 sum c_acd c_bef W_ce W_df x_a x_b
            M1=np.einsum('acd,a->cd',C,x); M2=np.einsum('bef,b->ef',C,x)
            # <W^# x,x> = 1/2 sum_{cdef} M1_cd M2_ef W_ce W_df
            G=0.5*(np.einsum('cd,ef,df->ce',M1,M2,W)+np.einsum('cd,ef,ce->df',M1,M2,W))
            G=sgn*(G+G.T)/2
            gW=np.einsum('kab,ab->k',B,G)
            x=x+0.3*gx/ (np.linalg.norm(gx)+1e-12)
            co=co+0.3*gW/(np.linalg.norm(gW)+1e-12)
        co/=np.linalg.norm(co); x/=np.linalg.norm(x)
        W=np.einsum('k,kab->ab',co,B); S=sharp_fast(W,C)
        best=max(best,abs(x@S@x))
    return best

print(" n   beta_n = max|<W^# X,X>|   1/(n-2)   theta0(n)  sqrt(N)*beta_n")
for n in [5,6,7,8,9,10]:
    b=beta(n)
    N=n*(n-1)//2
    print(f"{n:3d}   {b:.8f}            {1/(n-2):.6f}  {math.sqrt(2*(n-1)*(n-2))/n:.6f}  {math.sqrt(N)*b:.6f}")

print()
print("=== the TRUE (w,T) at the balanced sphere product: does it sit in the relaxation polytope? ===")
for n in [6,8,10,12]:
    C=struct_const(n); B=weyl_basis(n)
    W=sphere_product_weyl(n, n//2)
    W=W/math.sqrt(np.trace(W@W))
    QW=Q(W,C); th=np.trace(W@QW)
    w,U=np.linalg.eigh(W)
    Crot=np.einsum('abg,ap,bq,gr->pqr',C,U,U,U,optimize=True); T=Crot**2
    row=T.sum(axis=(1,2)); pair=T.sum(axis=2)
    S=sharp_fast(W,C); V=np.diag(U.T@S@U)
    print(f" n={n}: theta={th:.8f}  theta0={math.sqrt(2*(n-1)*(n-2))/n:.8f}  crit_resid={np.abs(QW-th*W).max():.1e}")
    print(f"        row marginal [{row.min():.6f},{row.max():.6f}] (kappa={2*(n-2)})  "
          f"max pair marginal={pair.max():.6f}  max|T on repeats|={max(abs(T[a,a,b]) for a in range(len(w)) for b in range(len(w))):.1e}")
    print(f"        sum V_a = {V.sum():.8f} (must be -1)  max|V_a| = {np.abs(V).max():.6f}  "
          f"sum w^3 = {(w**3).sum():.6f}  sum w V = {(w*V).sum():.6f}  total={((w**3).sum()+(w*V).sum()):.6f}")
    print(f"        |w|_1 = {np.abs(w).sum():.6f}  sqrt(N)={math.sqrt(len(w)):.4f}")
