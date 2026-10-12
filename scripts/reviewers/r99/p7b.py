import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r99'))
from wlib import *
from fast import Mfast,Jfast,iota_star,ringfast
rng=np.random.default_rng(7071)

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

def basisW(n,seed=3):
    r=np.random.default_rng(seed); d=dim_W(n)
    S=np.array([pr(r.standard_normal((n,)*4)).reshape(-1) for _ in range(d+15)])
    U,s,Vt=np.linalg.svd(S,full_matrices=False); return Vt[:d]

def local_max_check(W,n,label,Bas):
    W=W/np.linalg.norm(W)            # unit tensor sphere; theta homogeneous deg 3
    v0=th(W)
    # tangent basis
    c=Bas@W.reshape(-1)
    Tg=Bas-np.outer(c,W.reshape(-1))
    Q,_=np.linalg.qr(Tg.T); Q=Q.T
    Q=np.array([q for q in Q if np.linalg.norm(q)>1e-8])
    # drop the (numerically) radial direction
    keep=[q for q in Q if abs(np.dot(q,W.reshape(-1)))<1e-8]
    Q=np.array(keep)
    h=1e-4; k=Q.shape[0]; H=np.zeros((k,k))
    def val(v):
        v=v/np.linalg.norm(v); return th(v.reshape((n,)*4))
    w=W.reshape(-1)
    f0=val(w)
    for a in range(k):
        for b in range(a,k):
            fpp=val(w+h*Q[a]+h*Q[b]); fmm=val(w-h*Q[a]-h*Q[b])
            fpm=val(w+h*Q[a]-h*Q[b]); fmp=val(w-h*Q[a]+h*Q[b])
            H[a,b]=H[b,a]=(fpp-fpm-fmp+fmm)/(4*h*h)
    g=np.array([(val(w+h*Q[a])-val(w-h*Q[a]))/(2*h) for a in range(k)])
    ev=np.linalg.eigvalsh(H)
    print(f"   {label:26s} theta(||M||=1)={th(W/np.linalg.norm(Mfast(W))):+.8f} "
          f"|grad_tangent|={np.linalg.norm(g):.2e}  Hess eig in [{ev.min():+.4f},{ev.max():+.4f}]  #pos>1e-6: {(ev>1e-6).sum()}/{k}")

for n in [6,8,10]:
    print(f"=== n={n} local-max certification (tangent Hessian of theta on the unit sphere) ===")
    Bas=basisW(n)
    local_max_check(cp2_W(n),n,"CP^2 extended",Bas)
    local_max_check(pr(sphere_product_R(n//2,n//2)),n,f"S^{n//2}xS^{n//2}",Bas)
print("=== n=12 ===")
Bas=basisW(12)
local_max_check(pr(sphere_product_R(6,6)),12,"S^6xS^6",Bas)
local_max_check(cp2_W(12),12,"CP^2 extended",Bas)
