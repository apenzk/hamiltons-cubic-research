import numpy as np, sys, math
sys.path.insert(0,'scripts/reviewers/r101')
from wcore import *
from wopt import proj_W, theta_grad, k2_grad_W

def cayley(Om):
    n=Om.shape[0]; I=np.eye(n)
    return np.linalg.solve(I-0.5*Om, I+0.5*Om)

def ascendF(W,F,iters=60,step=0.3):
    f,_=kgrad(W,F)
    for it in range(iters):
        f,G=kgrad(W,F)
        Om=G@F.T-F@G.T
        if np.linalg.norm(Om)<1e-12: break
        ok=False
        for _ in range(20):
            Fn=polar(cayley(step*Om)@F)
            fn,_=kgrad(W,Fn)
            if fn>f+1e-15: F=Fn; f=fn; step*=1.7; ok=True; break
            step*=0.35
            if step<1e-13: break
        if not ok: break
    return f,F,step

def kappa_ms(W,starts=12,iters=120,rng=None,F0list=None):
    n=W.shape[0]
    if rng is None: rng=np.random.default_rng(0)
    cands=list(F0list) if F0list else []
    cands.append(np.eye(n))
    while len(cands)<starts:
        A=rng.standard_normal((n,n)); Q,R=np.linalg.qr(A); cands.append(Q*np.sign(np.diag(R)))
    best=-1;bF=None
    for F in cands:
        f,F,_=ascendF(W,polar(F),iters)
        if f>best: best=f;bF=F
    return best,bF
