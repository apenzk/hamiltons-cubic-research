"""R4 last row: is the deflation residual real, or amplified noise?"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r42_core import *
from review_r42_spec import e_cpm
from review_r42_hw import Le_apply
np.random.seed(17)

for m in [4,5,6]:
    n=2*m; N=len(pairs(n)); e=e_cpm(m); Pm=P_mm(n)
    lam=2.0/(m+1)
    others=[1.0,(m+2)/(2*(m+1)),0.5,0.0,-3.0/(m+1)]
    amp=np.prod([lam-x for x in others])
    # test vector: v (x) w symmetrised, v,w in the m-part, projected to Weyl
    v=Pm@np.random.randn(N); w=Pm@np.random.randn(N)
    X=proj_weyl(n,0.5*(np.outer(v,w)+np.outer(w,v))); X/=np.linalg.norm(X)
    Y=X.copy()
    for x in others:
        Y=Le_apply(n,e,Y)-x*Y
    nY=np.linalg.norm(Y)
    LY=Le_apply(n,e,Y)
    res_abs=np.linalg.norm(LY-lam*Y); res_rel=res_abs/nY
    # exact size of the E(lambda) component of X, by deflation-free projection
    # (Le is symmetric on Weyl, so use the spectral projector via a polynomial in Le
    #  normalised to 1 at lam)
    comp=nY/abs(amp)
    print(f"m={m}: |deflated|/|X| = {nY:.3e}   deflation gain |prod(lam-mu)| = {abs(amp):.3e}")
    print(f"       => true E(2/(m+1))-component of X = {comp:.4f}  (i.e. {100*comp:.1f}% of the test vector)")
    print(f"       residual |L_e Y - lam Y| abs={res_abs:.2e}  rel={res_rel:.2e}   Weyl err={np.linalg.norm(Y-proj_weyl(n,Y))/nY:.1e}")
