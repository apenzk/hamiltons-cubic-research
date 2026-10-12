import numpy as np, sys, math, time
sys.path.insert(0,'scripts/reviewers/r101')
from wcore import *; from wopt import proj_W, theta_grad, k2_grad_W
from fast import ascendF, kappa_ms

def norm2(W): return W*2.0/np.linalg.norm(W)

def run(W0,lam,rng,steps=400,inner=25):
    W=norm2(proj_W(W0)); n=W.shape[0]
    _,F=kappa_ms(W,starts=6,iters=100,rng=rng)
    step=0.05
    for it in range(steps):
        k2,F,_=ascendF(W,F,inner)
        th,Gt=theta_grad(W)
        _,Gk=k2_grad_W(W,F)
        obj=th-lam*k2
        G=Gt-lam*Gk; G=G-np.sum(G*W)*W/4.0
        if np.linalg.norm(G)<1e-11: break
        ok=False
        for _ in range(28):
            Wn=norm2(W+step*G)
            k2n,Fn,_=ascendF(Wn,F,12)
            thn,_=theta_grad(Wn)
            if thn-lam*k2n>obj+1e-15:
                W=Wn; F=Fn; step*=1.6; ok=True; break
            step*=0.4
            if step<1e-13: break
        if not ok: break
        if it%40==39:
            k2b,Fb=kappa_ms(W,starts=8,iters=120,rng=rng,F0list=[F])
            if k2b>k2: F=Fb
    k2,F=kappa_ms(W,starts=20,iters=200,rng=rng,F0list=[F])
    th,_=theta_grad(W)
    return W,th,k2

n=int(sys.argv[1]); trials=int(sys.argv[2]); lams=[float(x) for x in sys.argv[3].split(',')]
seed=int(sys.argv[4]); rng=np.random.default_rng(seed)
th0=math.sqrt(2*(n-1)*(n-2))/n
print(f"n={n} dimW={n*(n+1)*(n+2)*(n-3)//12} theta0={th0:.6f}  CP^(n/2): kappa2=6/(n+2)={6/(n+2):.6f}",flush=True)
res=[]
for lam in lams:
    rows=[]
    for t in range(trials):
        W0=random_weyl(n,rng)
        t0=time.time(); W,th,k2=run(W0,lam,rng)
        rows.append((th,k2))
        print(f"  lam={lam:7.3f} trial{t}: theta={th:.6f} kappa2={k2:.6f} obj={th-lam*k2:.6f} ({time.time()-t0:.0f}s)",flush=True)
        np.save(f'scripts/reviewers/r101/W_n{n}_lam{lam}_t{t}.npy',W)
    bi=int(np.argmax([r[0]-lam*r[1] for r in rows]))
    res.append((lam,)+rows[bi])
print("SUMMARY  lam  theta  kappa2")
for l,t,k in res: print(f"  {l:8.3f} {t:.6f} {k:.6f}")
