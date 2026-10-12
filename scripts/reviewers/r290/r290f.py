import numpy as np, io, contextlib
buf=io.StringIO()
with contextlib.redirect_stdout(buf): from r290 import *
from scipy.optimize import minimize
from scipy.linalg import expm
def quiet(W,n,psi_diag=True):
    b=io.StringIO()
    with contextlib.redirect_stdout(b): r=analyse(W,n,psi_diag,verbose=True,name="")
    return r
def skew(v,n):
    A=np.zeros((n,n)); iu=np.triu_indices(n,1); A[iu]=v; return A-A.T
def frame_opt(W,n,tries=4,seed=0):
    rng=np.random.default_rng(seed); best=None; d=n*(n-1)//2
    f=lambda v: quiet(rot_tensor(W,expm(skew(v,n))),n)['bnd']
    for t in range(tries):
        v0=np.zeros(d) if t==0 else rng.standard_normal(d)*0.8
        r=minimize(f,v0,method='Nelder-Mead',options=dict(maxfev=3000,fatol=1e-9))
        if best is None or r.fun<best: best=r.fun
    return best
def p3min(N,m,p2=3.0):
    k=p2*N/(m*m*N+p2); a=k*m/(N-k); return -k*m**3+(N-k)*a**3
print("random Weyl: comparison of the three bounds at the SAME charity")
rng=np.random.default_rng(11)
for n in [6,8]:
    N=n*(n+1)//2-1; th0=np.sqrt(2*(n-1)*(n-2)/n**2)
    for k in range(3):
        W=weyl_part(sym_curv(rng.standard_normal((n,)*4),n),n); M,_=Mmat(W,n); W=W/np.linalg.norm(M)
        r=quiet(W,n)
        if r['th']<0: W=-W; r=quiet(W,n)
        mu=np.linalg.eigvalsh(Mmat(W,n)[0])
        opt=frame_opt(W,n,4,seed=k)
        triv=1.5*r['Mp']+1.5*r['m']; p33=1.5*np.sum(mu**3)-0.5*p3min(N,r['m'])
        print(f"  n={n} theta={r['th']:+.4f} th0={th0:.4f} | MAJ(opt)={opt:.4f} TRIV={triv:.4f} POST33(true p3mu)={p33:.4f}  winner={'MAJ' if opt<min(triv,p33) else ('TRIV' if triv<p33 else 'P33')}")
