import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys, time
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r100'))
from core import *

def make_obj(kind, n, B, d):
    def f_and_g(v):
        M = sunvec(B@v, d)
        if kind=='theta':
            Ms = sharp(M,n)
            val = float(np.trace(M@M@M) + np.sum(Ms*M))
            gM = 3.0*(M@M + Ms)
        else:  # 'mp3om' = maximise -p3(omega)
            W = full_tensor(M,n); A = Wring(W,n)
            val = -float(np.trace(A@A@A))
            gM = -3.0*iota_star(A@A, n)
        return val, B.T@svec(gM)
    return f_and_g

def ascend(f_and_g, dim, rng, starts, steps=500):
    best=(-1e18,None)
    for s in range(starts):
        v=rng.standard_normal(dim); v/=np.linalg.norm(v)
        eta=0.25
        val,g=f_and_g(v)
        for t in range(steps):
            gt=g-np.dot(g,v)*v
            ng=np.linalg.norm(gt)
            if ng<1e-13: break
            ok=False
            for _ in range(30):
                w=v+eta*gt/ng; w/=np.linalg.norm(w)
                nv,ngd=f_and_g(w)
                if nv>val: v,val,g=w,nv,ngd; eta*=1.3; ok=True; break
                eta*=0.5
            if not ok: break
        if val>best[0]: best=(val,v.copy())
    return best

def sphere_prod_v(m,B,n):
    R=np.zeros((n,n,n,n))
    for off in (0,m):
        g=np.zeros((n,n))
        for a in range(off,off+m): g[a,a]=1.0
        R+=np.einsum('ik,jl->ijkl',g,g)-np.einsum('il,jk->ijkl',g,g)
    _,v=project_weyl(M_from_tensor(R,n),B,n)
    return v/np.linalg.norm(v)

rng=np.random.default_rng(606)
print(f"{'n':>3} {'theta0':>9} {'sqrt1.5':>9} | {'max theta':>10} {'-p3om @arg':>11} | {'max -p3om':>10} {'theta @arg':>10} | overlap w/ sphere-prod")
for n in [6,8,10,12]:
    t0=time.time()
    B=weyl_basis(n); dim=B.shape[1]; d=len(pairs(n))
    starts = 40 if n<=10 else 18
    fT=make_obj('theta',n,B,d); fO=make_obj('mp3om',n,B,d)
    vT_val,vT=ascend(fT,dim,rng,starts)
    vO_val,vO=ascend(fO,dim,rng,starts)
    vsp=sphere_prod_v(6 if n==12 else n//2,B,n)
    def th(v):
        M=sunvec(B@v,d); Ms=sharp(M,n); return float(np.trace(M@M@M)+np.sum(Ms*M))
    def mp(v):
        M=sunvec(B@v,d); A=Wring(full_tensor(M,n),n); return -float(np.trace(A@A@A))
    ovT=abs(float(np.dot(vT,vsp))); ovO=abs(float(np.dot(vO,vsp)))
    print(f"{n:>3} {theta0(n):>9.6f} {np.sqrt(1.5):>9.6f} | {vT_val:>10.6f} {mp(vT):>11.6f} | {vO_val:>10.6f} {th(vO):>10.6f} | theta-arg {ovT:.4f}  om-arg {ovO:.4f}")
    print(f"      sphere-prod ref: theta={th(vsp):.6f}  -p3om={mp(vsp):.6f}   [{time.time()-t0:.0f}s, dim {dim}, {starts} starts]")
