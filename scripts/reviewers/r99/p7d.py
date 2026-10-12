import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r99'))
from wlib import *
from fast import Mfast,Jfast,iota_star,ringfast

def sphere_product_R(m1,m2):
    n=m1+m2; R=np.zeros((n,)*4)
    for (off,mm) in ((0,m1),(m1,m2)):
        I=range(off,off+mm)
        for i in I:
            for j in I:
                for k in I:
                    for l in I: R[i,j,k,l]=(i==k)*(j==l)-(i==l)*(j==k)
    return R
def cp2_W(n):
    Jm=np.zeros((4,4)); Jm[0,1]=1;Jm[1,0]=-1;Jm[2,3]=1;Jm[3,2]=-1; I=np.eye(4)
    R=(np.einsum('ik,jl->ijkl',I,I)-np.einsum('il,jk->ijkl',I,I)
       +np.einsum('ik,jl->ijkl',Jm,Jm)-np.einsum('il,jk->ijkl',Jm,Jm)+2*np.einsum('ij,kl->ijkl',Jm,Jm))
    W=np.zeros((n,)*4); W[:4,:4,:4,:4]=pr(R); return pr(W)
def th(W):
    M=Mfast(W); rw=ringfast(W); return 1.5*float(np.trace(M@M@M))-0.5*float(np.trace(rw@rw@rw))
def grad(W):
    n=W.shape[0]; M=Mfast(W); rw=ringfast(W)
    return 1.125*pr(Jfast(M@M,n)) - 1.5*pr(iota_star(rw@rw,n))

def ascend_from(W0,n,iters=600):
    W=W0/np.linalg.norm(W0); v=th(W); t=1.0
    for it in range(iters):
        G=grad(W); G=G-np.sum(G*W)*W
        moved=False
        for _ in range(30):
            Wn=pr(W+t*G); Wn/=np.linalg.norm(Wn); vn=th(Wn)
            if vn>v+1e-15: W,v=Wn,vn; t*=1.7; moved=True; break
            t*=0.4
        if not moved: break
    return v,W

print("A) heavy multistart falsification attempt on theta")
for n in [6,8,10,11,12]:
    rng=np.random.default_rng(4000+n); best=-9; cnt={}
    N=200 if n<=10 else 80
    for s in range(N):
        v,W=ascend_from(pr(rng.standard_normal((n,)*4)),n)
        v8=v*8.0  # ||M||=1 convention: theta(2V) = 8 theta(V)
        k=round(v8,6); cnt[k]=cnt.get(k,0)+1
        best=max(best,v8)
    top=sorted(cnt.items(),reverse=True)[:4]
    print(f"  n={n}: starts={N} best theta={best:.8f}  theta0={theta0(n):.6f} sqrt(3/2)={np.sqrt(1.5):.6f}"
          f"   top basins {top}")

print("\nB) Rayleigh sweep: max over random tangent U of <U,Hess U> - 3 theta  (Riemannian Hessian)")
for n in [10,12]:
    for (W0,lab) in [(cp2_W(n),"CP^2"),(pr(sphere_product_R(n//2,n//2)),f"S^{n//2}xS^{n//2}")]:
        W=W0/np.linalg.norm(W0); t=th(W); M=Mfast(W); rw=ringfast(W); w=W.reshape(-1)
        rng=np.random.default_rng(11); mx=-9
        for _ in range(400):
            U=pr(rng.standard_normal((n,)*4)); u=U.reshape(-1); u=u-np.dot(u,w)*w
            u/=np.linalg.norm(u); U=u.reshape((n,)*4)
            MU=Mfast(U); rU=ringfast(U)
            HU=4.5*pr(Jfast(M@MU+MU@M,n)/4.0) - 1.5*pr(iota_star(rw@rU+rU@rw,n))
            q=float(np.sum(HU*U))-3*t
            mx=max(mx,q)
        print(f"  n={n} {lab:10s}: max Rayleigh over 400 random tangents = {mx:+.6f}")

print("\nC) escape test: ascent seeded at perturbations of each candidate")
for n in [10,12]:
    for (W0,lab) in [(cp2_W(n),"CP^2"),(pr(sphere_product_R(n//2,n//2)),f"S^{n//2}xS^{n//2}")]:
        rng=np.random.default_rng(55); base=th(W0/np.linalg.norm(W0))*8
        outs=[]
        for eps in [0.02,0.1,0.3]:
            for _ in range(6):
                P=pr(rng.standard_normal((n,)*4)); P/=np.linalg.norm(P)
                v,_=ascend_from(W0/np.linalg.norm(W0)+eps*P,n)
                outs.append(round(v*8,6))
        print(f"  n={n} {lab:10s}: base={base:.6f}  escapes -> {sorted(set(outs),reverse=True)[:4]}")
