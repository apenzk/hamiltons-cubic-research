import numpy as np, sys, math
sys.path.insert(0,'scripts/reviewers/r101')
from wcore import *
from fast import cayley
def descendF(W,F,iters=800,step=0.3):
    def f_(F): return kfro2(W,F)
    f,_=kgrad(W,F)
    for it in range(iters):
        f,G=kgrad(W,F)
        Om=G@F.T-F@G.T
        if np.linalg.norm(Om)<1e-14: break
        ok=False
        for _ in range(30):
            Fn=polar(cayley(-step*Om)@F)
            fn,_=kgrad(W,Fn)
            if fn<f-1e-18: F=Fn; f=fn; step*=1.6; ok=True; break
            step*=0.35
            if step<1e-15: break
        if not ok: break
    return f,F
rng=np.random.default_rng(2026)
print("min_F ||K(F)||_F^2   (Claim 4(i): is the infimum 0?)")
cases=[]
W4=normalise(weyl_cpm(2))
for n in [4,6,8,10,12]:
    cases.append((f"padded CP^2 in n={n}", pad(W4,n)))
for n in [6,8,10,12]:
    cases.append((f"balanced SxS n={n}", normalise(weyl_sphere_product(n,n//2))))
for n in [6,8,10]:
    cases.append((f"random Weyl n={n}", normalise(random_weyl(n,rng))))
for name,W in cases:
    n=W.shape[0]
    best=1e9
    for s in range(25):
        A=rng.standard_normal((n,n)); Q,R=np.linalg.qr(A); F=Q*np.sign(np.diag(R))
        v,_=descendF(W,F)
        best=min(best,v)
    th,_=theta_of(W)
    print(f"  {name:24s} theta={th:.6f}  min||K||^2={best:.3e}  min||K||={math.sqrt(max(best,0)):.3e}")
