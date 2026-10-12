import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r100'))
from core import *
exec(open(_os.path.join(_ROOT, 'scripts/reviewers/r100/p6_ascent.py')).read().split("rng=np.random.default_rng(606)")[0])
rng=np.random.default_rng(808)

print("=== crossover arithmetic: theta = 3/2 p3(mu) + (-1/2 p3(om)) ===")
print(f"{'n':>4} {'theta0(n)':>10} {'SP first':>9} {'SP second':>10} | {'CP2 first':>10} {'CP2 second':>11} | {'SP-CP2':>8}")
for n in [6,8,10,11,12,14]:
    if n%2==0:
        m=n//2; A=1.0/(m*np.sqrt((m-1)*(2*m-1)))
        f=1.5*A; s=0.5*(4*m*m-6*m-1)*A
        print(f"{n:>4} {theta0(n):>10.6f} {f:>9.6f} {s:>10.6f} | {0.612372:>10.6f} {0.612372:>11.6f} | {f+s-np.sqrt(1.5):>+8.6f}")
print(f"crossover theta0(n)=sqrt(3/2):  n = 6+2*sqrt(7) = {6+2*np.sqrt(7):.6f}")
print(f"check theta0(6+2sqrt7) = {theta0(6+2*np.sqrt(7)):.9f}  vs sqrt(3/2) = {np.sqrt(1.5):.9f}")

print()
print("=== n=11 (odd, just BELOW the crossover): does ascent still cap at sqrt(3/2)? ===")
for n in [11]:
    B=weyl_basis(n); dim=B.shape[1]; d=len(pairs(n))
    v1,_=ascend(make_obj('theta',n,B,d),dim,rng,14)
    print(f"n={n}: dim W={dim}  max theta found = {v1:.8f}   sqrt(3/2)={np.sqrt(1.5):.8f}  theta0(11)={theta0(11):.8f}")

print()
print("=== omega spectrum of the -p3(omega) maximiser at n=8 (is it the sphere product?) ===")
n=8; B=weyl_basis(n); dim=B.shape[1]; d=len(pairs(n))
val,v=ascend(make_obj('mp3om',n,B,d),dim,rng,25)
A=Wring(full_tensor(sunvec(B@v,d),n),n); om=np.round(np.linalg.eigvalsh(A),6)
import collections; print(f"  -p3om={val:.6f}; omega clusters:",sorted(collections.Counter(om).items()))
print("  Claim-2 prediction m=4:", [(-1.309307,1),(-0.163663,16),(0.218218,18)])

print()
print("=== local-max test: Hessian of theta on the unit sphere at CP^2 (n=8) and SP (n=12) ===")
for n,which in [(8,'cp2'),(12,'sp')]:
    B=weyl_basis(n); dim=B.shape[1]; d=len(pairs(n))
    val,v=ascend(make_obj('theta',n,B,d),dim,rng,12 if n==8 else 8)
    f=make_obj('theta',n,B,d)
    g0=f(v)[1]; lam=float(np.dot(g0,v))
    # tangent Hessian via finite differences of the projected gradient, on a random tangent subspace
    T=np.linalg.qr(np.random.default_rng(9).standard_normal((dim,min(40,dim-1))) - np.outer(v, v@np.random.default_rng(9).standard_normal((dim,min(40,dim-1)))))[0]
    T=T-np.outer(v,v@T); T,_=np.linalg.qr(T)
    h=1e-5; H=np.zeros((T.shape[1],T.shape[1]))
    for a in range(T.shape[1]):
        vp=v+h*T[:,a]; vp/=np.linalg.norm(vp); vm=v-h*T[:,a]; vm/=np.linalg.norm(vm)
        gp=f(vp)[1]; gm=f(vm)[1]
        H[:,a]=T.T@((gp-gm)/(2*h)) 
    H=(H+H.T)/2 - lam*np.eye(T.shape[1])
    e=np.linalg.eigvalsh(H)
    print(f"  n={n} ({which}) theta={val:.8f}  |proj grad|={np.linalg.norm(g0-lam*v):.2e}  tangent-Hessian eigs on a random 40-dim slice: max {e.max():+.4f} min {e.min():+.4f}  -> {'LOCAL MAX' if e.max()<1e-6 else 'NOT a local max on this slice'}")
