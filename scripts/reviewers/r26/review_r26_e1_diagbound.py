import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys, math
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
from review_r26_core import *
rng=np.random.default_rng(23)
print("Claim: for unit Weyl W and ANY unit X in Lambda^2, |<W^# X,X>| <= 1, and tr(W^#) = -1.")
print("Proof sketch: (W^#)_XX = -1/2 tr((ad_X W)^2), |tr(M^2)|<=||M||_F^2,")
print("              ||ad_X W||_F <= ||ad_X||_op ||W||_F <= sqrt(2)*1.")
print()
for n in [5,6,7,8,9,10]:
    C=struct_const(n); B=weyl_basis(n); N=C.shape[0]
    worst=0.0; worst_tr=0.0; adop=0.0
    for _ in range(40):
        co=rng.normal(size=B.shape[0]); co/=np.linalg.norm(co)
        W=np.einsum('k,kab->ab',co,B)
        S=sharp_fast(W,C)
        # over random orthonormal frames
        A=rng.normal(size=(N,N)); U,_=np.linalg.qr(A)
        d=np.einsum('ia,ab,ib->i',U.T.T,S,U.T.T)  # diag of U^T S U
        d=np.diag(U.T@S@U)
        worst=max(worst,np.abs(d).max())
        worst_tr=max(worst_tr,abs(np.trace(S)+1))
    # ||ad_X||_op over unit X
    for _ in range(300):
        x=rng.normal(size=N); x/=np.linalg.norm(x)
        D=np.einsum('a,abg->gb',x,C)   # (ad_X)_{gb} = c_{a b g} x_a
        adop=max(adop,np.linalg.svd(D,compute_uv=False)[0])
    print(f" n={n}: max |(W^#)_XX| over 40 W x random frames = {worst:.8f}   "
          f"max |tr(W^#)+1| = {worst_tr:.2e}   max ||ad_X||_op = {adop:.8f} (bound sqrt2={math.sqrt(2):.6f})")
# also: extremal ad_X operator norm by ascent
print()
print("ad_X operator norm, maximized by ascent (should hit sqrt(2)):")
for n in [4,6,8,10]:
    C=struct_const(n); N=C.shape[0]; best=0
    for t in range(40):
        x=rng.normal(size=N)
        for it in range(600):
            x/=np.linalg.norm(x)
            D=np.einsum('a,abg->gb',x,C)
            u,s,vt=np.linalg.svd(D)
            g=np.einsum('g,b,abg->a',u[:,0],vt[0],C)
            x=x+0.1*g
        x/=np.linalg.norm(x)
        D=np.einsum('a,abg->gb',x,C); best=max(best,np.linalg.svd(D,compute_uv=False)[0])
    print(f"  n={n}: {best:.10f}   (sqrt2 = {math.sqrt(2):.10f})")
