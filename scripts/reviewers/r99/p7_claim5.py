import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time, numpy as np
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r99'))
from wlib import *
from fast import Mfast,Jfast,iota_star,ringfast

def norm_t(W): return np.linalg.norm(W)

def make(obj):
    def f(W):
        M=Mfast(W); rw=ringfast(W)
        pm=float(np.trace(M@M@M)); po=float(np.trace(rw@rw@rw))
        return (1.5*pm-0.5*po) if obj=='theta' else (-po), pm, po
    def g(W):
        n=W.shape[0]; M=Mfast(W); rw=ringfast(W)
        if obj=='theta':
            return 1.5*(0.75*pr(Jfast(M@M,n))) - 0.5*(3*pr(iota_star(rw@rw,n)))
        return -3*pr(iota_star(rw@rw,n))
    return f,g

def ascend(n,obj,starts=24,iters=400,seed=0):
    rng=np.random.default_rng(seed); f,g=make(obj)
    best=(-1e9,None)
    for s in range(starts):
        W=pr(rng.standard_normal((n,)*4)); W/=norm_t(W)
        t=1.0; v=f(W)[0]
        for it in range(iters):
            G=g(W); G=G-np.sum(G*W)*W
            ok=False
            for _ in range(25):
                Wn=W+t*G; Wn=pr(Wn); Wn/=norm_t(Wn)
                vn=f(Wn)[0]
                if vn>v+1e-14: W,v=Wn,vn; t*=1.6; ok=True; break
                t*=0.4
            if not ok: break
        if v>best[0]: best=(v,W.copy())
    return best

def sphere_product_R(m1,m2):
    n=m1+m2; R=np.zeros((n,)*4)
    for (off,mm) in ((0,m1),(m1,m2)):
        I=range(off,off+mm)
        for i in I:
            for j in I:
                for k in I:
                    for l in I:
                        R[i,j,k,l]=(i==k)*(j==l)-(i==l)*(j==k)
    return R
def cp2_W(n):
    Jm=np.zeros((4,4)); Jm[0,1]=1;Jm[1,0]=-1;Jm[2,3]=1;Jm[3,2]=-1; I=np.eye(4)
    R=(np.einsum('ik,jl->ijkl',I,I)-np.einsum('il,jk->ijkl',I,I)
       +np.einsum('ik,jl->ijkl',Jm,Jm)-np.einsum('il,jk->ijkl',Jm,Jm)+2*np.einsum('ij,kl->ijkl',Jm,Jm))
    W4=pr(R); W=np.zeros((n,)*4); W[:4,:4,:4,:4]=W4; return pr(W)

def report(W,n,label):
    W=W/np.linalg.norm(Mfast(W))
    M=Mfast(W); rw=ringfast(W)
    pm=float(np.trace(M@M@M)); po=float(np.trace(rw@rw@rw))
    print(f"    {label:34s} theta={1.5*pm-0.5*po:+.6f}  p3(mu)={pm:+.6f}  -p3(om)={-po:+.6f}")
    return 1.5*pm-0.5*po, pm, po

for n in [6,8,10,12]:
    t0=time.time()
    print(f"=== n={n}  theta0={theta0(n):.6f}  sqrt(3/2)={np.sqrt(1.5):.6f} ===")
    for obj in ['negp3omega','theta']:
        v,W=ascend(n,obj,starts=20,iters=300,seed=100+n)
        # scale to ||M||=1 convention
        Wn=W/np.linalg.norm(Mfast(W))
        M=Mfast(Wn); rw=ringfast(Wn)
        pm=float(np.trace(M@M@M)); po=float(np.trace(rw@rw@rw))
        print(f"  ascent[{obj}] -> theta={1.5*pm-0.5*po:+.6f} p3(mu)={pm:+.6f} -p3(om)={-po:+.6f}")
    # references
    if n%2==0: report(pr(sphere_product_R(n//2,n//2)),n,f"S^{n//2}xS^{n//2} (balanced)")
    for p in range(2,n//2):
        report(pr(sphere_product_R(p,n-p)),n,f"S^{p}xS^{n-p} (unbalanced)")
    report(cp2_W(n),n,"CP^2 (extended)")
    print(f"    [{time.time()-t0:.0f}s]")
