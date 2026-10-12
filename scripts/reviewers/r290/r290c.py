import numpy as np, io, contextlib
buf=io.StringIO()
with contextlib.redirect_stdout(buf):
    from r290 import *
from scipy.optimize import minimize
from scipy.linalg import expm
np.set_printoptions(precision=6,suppress=True)

def quiet(W,n,psi_diag=True):
    b=io.StringIO()
    with contextlib.redirect_stdout(b):
        r=analyse(W,n,psi_diag,verbose=True,name="")
    return r

def skew(v,n):
    A=np.zeros((n,n)); iu=np.triu_indices(n,1); A[iu]=v; return A-A.T

def frame_opt(W,n,tries=6,seed=0):
    rng=np.random.default_rng(seed); best=None
    d=n*(n-1)//2
    def f(v):
        O=expm(skew(v,n)); return quiet(rot_tensor(W,O),n)['bnd']
    for t in range(tries):
        v0=np.zeros(d) if t==0 else rng.standard_normal(d)*0.8
        res=minimize(f,v0,method='Nelder-Mead',options=dict(maxfev=4000,xatol=1e-6,fatol=1e-9))
        if best is None or res.fun<best[0]: best=(res.fun,res.x)
    return best

print("=== C3 direction test: S1>=0 and S2>=0 on random Weyl tensors x random frames ===")
rng=np.random.default_rng(7)
bad=0; worst=(0,0)
for trial in range(40):
    n=rng.choice([5,6,7])
    W=weyl_part(sym_curv(rng.standard_normal((n,)*4),n),n)
    M,_=Mmat(W,n); W=W/np.linalg.norm(M)
    O=expm(skew(rng.standard_normal(n*(n-1)//2),n))
    r=quiet(rot_tensor(W,O),n)
    if r['S1']<-1e-10 or r['S2']<-1e-10: bad+=1; print("   VIOLATION",n,r['S1'],r['S2'])
    worst=(min(worst[0],r['S1']),min(worst[1],r['S2']))
print(f"   40 trials, violations={bad}, min S1={worst[0]:.2e}, min S2={worst[1]:.2e}")

print("\n=== is diagonalising the psi block optimal? (random rotations inside the psi block) ===")
for name,W,n in [("padCP2 n=8",None,8)]:
    W4=weyl_part(cp2(4),4); Wp=np.zeros((8,)*4); Wp[:4,:4,:4,:4]=W4
    M,_=Mmat(Wp,8); Wp=Wp/np.linalg.norm(M)
    bd=quiet(Wp,8,True)['bnd']; asis=quiet(Wp,8,False)['bnd']
    print(f"   psi diagonalised bound={bd:.6f}   psi as-is bound={asis:.6f}  (lower is better)")

print("\n=== frame optimisation ===")
W4=weyl_part(cp2(4),4)
for n in [6,8]:
    Wp=np.zeros((n,)*4); Wp[:4,:4,:4,:4]=W4
    M,_=Mmat(Wp,n); Wp=Wp/np.linalg.norm(M)
    b=frame_opt(Wp,n,tries=4,seed=1)
    r0=quiet(Wp,n)
    print(f"   padded CP2 n={n}: standard-frame bound={r0['bnd']:.6f}  frame-optimised={b[0]:.6f}  theta={r0['th']:.6f} theta0={np.sqrt(2*(n-1)*(n-2)/n**2):.6f}")

print("\n=== random Weyl tensors: frame-optimised bound / theta_0 ===")
rng=np.random.default_rng(11)
for n in [6,7,8]:
    th0=np.sqrt(2*(n-1)*(n-2)/n**2)
    for k in range(2):
        W=weyl_part(sym_curv(rng.standard_normal((n,)*4),n),n)
        M,_=Mmat(W,n); W=W/np.linalg.norm(M)
        r0=quiet(W,n)
        if r0['th']<0: W=-W; r0=quiet(W,n)
        b=frame_opt(W,n,tries=4,seed=k+3)
        print(f"   n={n} theta={r0['th']:+.4f} std bound={r0['bnd']:.4f} opt bound={b[0]:.4f} opt/theta0={b[0]/th0:.3f}")
