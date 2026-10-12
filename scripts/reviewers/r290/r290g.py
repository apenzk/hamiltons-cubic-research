import numpy as np, io, contextlib
buf=io.StringIO()
with contextlib.redirect_stdout(buf): from r290 import *
from scipy.linalg import expm
def quiet(W,n,psi_diag=True):
    b=io.StringIO()
    with contextlib.redirect_stdout(b): return analyse(W,n,psi_diag,verbose=True,name="")
def skew(v,n):
    A=np.zeros((n,n)); iu=np.triu_indices(n,1); A[iu]=v; return A-A.T
rng=np.random.default_rng(99); diffs=[]
for t in range(60):
    n=int(rng.choice([5,6,7]))
    W=weyl_part(sym_curv(rng.standard_normal((n,)*4),n),n); M,_=Mmat(W,n); W=W/np.linalg.norm(M)
    W=rot_tensor(W,expm(skew(rng.standard_normal(n*(n-1)//2),n)))
    r=quiet(W,n); diffs.append(r['pen']-(r['bnd']-r['th']))
diffs=np.array(diffs)
print(f"penalty-sum minus true gap over 60 random Weyl x random frame: min={diffs.min():+.4f} max={diffs.max():+.4f} mean={diffs.mean():+.4f}  sign changes: {np.any(diffs>0)} / {np.any(diffs<0)}")
