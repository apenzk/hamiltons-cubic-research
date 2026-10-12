import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys; sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r102'))
import numpy as np, core, kappa, grads, models
def unit(W): return W/np.linalg.norm(core.to_M(W))
def ratio_run(n,W0,rng,outer=400):
    W=unit(W0); k2,R=kappa.kappa(W,starts=8,iters=400,rng=rng,return_frame=True)
    th=core.theta_from_M(core.to_M(W),n)
    if th<=0: W=-W; th=-th
    J=th/np.sqrt(k2); step=0.05
    for it in range(outer):
        g=grads.grad_theta(W)/np.sqrt(k2) - 0.5*th*k2**-1.5*grads.grad_kappa2(W,R)
        g=g-(np.sum(g*W)/np.sum(W*W))*W; ng=np.linalg.norm(g)
        if ng<1e-13: break
        Wn=unit(W+step*g/ng)
        k2n,Rn=kappa.kappa_from(Wn,R,iters=120)
        thn=core.theta_from_M(core.to_M(Wn),n); Jn=thn/np.sqrt(k2n)
        if Jn>J: W,R,k2,th,J=Wn,Rn,k2n,thn,Jn; step*=1.3
        else: step*=0.5
        if step<1e-11: break
        if it%40==0:
            k2f,Rf=kappa.kappa(W,starts=5,iters=400,rng=rng,return_frame=True)
            if k2f>k2: k2,R=k2f,Rf; J=th/np.sqrt(k2)
    k2,R=kappa.kappa(W,starts=16,iters=900,rng=rng,return_frame=True)
    th=core.theta_from_M(core.to_M(W),n)
    return th/np.sqrt(k2), th, k2
for n in (6,8,10,12,14):
    m=n//2
    cp=(m+1)*np.sqrt(2*m-1)/(3*np.sqrt(m*(m-1)))
    rng=np.random.default_rng(900+n); best=None
    for s in range(14):
        W0=core.random_weyl(n,rng)
        r,th,k2=ratio_run(n,W0,rng)
        if best is None or r>best[0]: best=(r,th,k2)
    # also start from CP^{n/2} itself
    r,th,k2=ratio_run(n,models.cpm(m)[0],rng)
    if r>best[0]: best=(r,th,k2)
    print(f'n={n}: max theta/kappa found = {best[0]:.6f} (theta={best[1]:.6f}, kappa^2={best[2]:.6f})'
          f'   CP^{m} value = {cp:.6f}   theta_0(n)/C_n -> kappa_min^2 = {(np.sqrt(2*(n-1)*(n-2))/n/best[0])**2:.4f}',flush=True)
