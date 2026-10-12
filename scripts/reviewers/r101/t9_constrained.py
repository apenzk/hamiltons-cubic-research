import numpy as np, sys, math, time
sys.path.insert(0,'scripts/reviewers/r101')
from wcore import *; from wopt import proj_W, theta_grad, k2_grad_W
from fast import ascendF, kappa_ms
def norm2(W): return W*2.0/np.linalg.norm(W)

def run(W0,c,rho,rng,steps=400,inner=25):
    W=norm2(proj_W(W0))
    _,F=kappa_ms(W,starts=6,iters=100,rng=rng)
    step=0.05
    def val(W,F):
        k2,F,_=ascendF(W,F,inner)
        th,_=theta_grad(W)
        return th-rho*max(0.0,k2-c), th, k2, F
    obj,th,k2,F=val(W,F)
    for it in range(steps):
        k2,F,_=ascendF(W,F,inner)
        th,Gt=theta_grad(W)
        _,Gk=k2_grad_W(W,F)
        obj=th-rho*max(0.0,k2-c)
        G=Gt-(rho if k2>c else 0.0)*Gk
        G=G-np.sum(G*W)*W/4.0
        if np.linalg.norm(G)<1e-11: break
        ok=False
        for _ in range(30):
            Wn=norm2(W+step*G)
            k2n,Fn,_=ascendF(Wn,F,12); thn,_=theta_grad(Wn)
            if thn-rho*max(0.0,k2n-c)>obj+1e-15:
                W=Wn; F=Fn; step*=1.6; ok=True; break
            step*=0.4
            if step<1e-13: break
        if not ok: break
        if it%50==49:
            k2b,Fb=kappa_ms(W,starts=8,iters=120,rng=rng,F0list=[F])
            if k2b>k2: F=Fb
    k2,F=kappa_ms(W,starts=20,iters=200,rng=rng,F0list=[F])
    th,_=theta_grad(W)
    return W,th,k2

n=int(sys.argv[1]); trials=int(sys.argv[2]); cs=[float(x) for x in sys.argv[3].split(',')]
rng=np.random.default_rng(int(sys.argv[4])); rho=float(sys.argv[5]) if len(sys.argv)>5 else 12.0
th0=math.sqrt(2*(n-1)*(n-2))/n
print(f"n={n} theta0={th0:.6f} kappa2(CP^(n/2))={6/(n+2):.6f} rho={rho}",flush=True)
for c in cs:
    best=(-9,0)
    for t in range(trials):
        W0=random_weyl(n,rng)
        W,th,k2=run(W0,c,rho,rng)
        eff=th if k2<=c+1e-6 else -9
        if eff>best[0]: best=(th,k2); np.save(f'scripts/reviewers/r101/C_n{n}_c{c}.npy',W)
        print(f"   c={c:.2f} t{t}: theta={th:.6f} kappa2={k2:.6f}",flush=True)
    print(f"  FRONTIER c={c:.2f}  max theta={best[0]:.6f} at kappa2={best[1]:.6f}",flush=True)
