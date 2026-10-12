import numpy as np, sys
from fractions import Fraction as F
sys.path.insert(0, 'scripts/lib')
from review_r42_core import *
np.random.seed(1)
for n in [6,8,10,12]:
    N=len(pairs(n)); I=np.eye(N)
    def rs():
        M=np.random.randn(N,N); return M+M.T
    # isotypic pieces of a random symmetric X
    X=rs()
    A=alt(n,X)
    rest=X-A
    Wp=proj_weyl(n,X)
    # trace/scalar piece
    t=np.sum(rest*I)/N
    S0=rest-Wp-t*I
    pieces={'Lam4':A,'Weyl':Wp,'S2_0':S0,'triv':t*I}
    out={}
    for k,v in pieces.items():
        nv=np.sum(v*v)
        if nv<1e-12: out[k]=None; continue
        r=sb(n,I,v)
        lam=np.sum(r*v)/nv
        out[k]=(lam, np.abs(r-lam*v).max()/max(1e-30,np.abs(v).max()))
    print(n, {k:(None if v is None else (round(v[0],10), f"{v[1]:.1e}")) for k,v in out.items()})
