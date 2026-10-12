import numpy as np, sys, math
sys.path.insert(0,'scripts/reviewers/r101')
from wcore import *
from fast import kappa_ms
from t11_relax import full_diag
rng=np.random.default_rng(2718)
print("(1) identity ||K(F)||_F^2 = 2*sum_a M(F)_aa^2  and  kappa^2 <= 2||M||^2:")
for n in [6,8,12]:
    W=normalise(random_weyl(n,rng)); F,_=np.linalg.qr(rng.standard_normal((n,n)))
    T=rotate(W,F); K=np.einsum('abab->ab',T).copy(); np.fill_diagonal(K,0)
    M=Mmat(T)
    print(f"   n={n}: ||K||^2={np.sum(K*K):.12f}  2*sum diag(M)^2={2*np.sum(np.diag(M)**2):.12f}  ||M||^2={np.linalg.norm(M)**2:.6f}")
print()
print("(2) Claim 1 numbers: ||d||^2 and ||K||^2 at random Weyl, n=12 (20 samples):")
v=[];k=[]
for _ in range(20):
    W=normalise(random_weyl(12,rng)); d=full_diag(W); v.append(np.sum(d**2)); k.append(np.sum(Kmat(W)**2))
print(f"   ||d||^2 (identity frame): min {min(v):.4f} med {np.median(v):.4f} max {max(v):.4f}")
print(f"   ||K||^2 (identity frame): min {min(k):.4f} med {np.median(k):.4f} max {max(k):.4f}")
print()
print("(3) kappa ascent quality at n=12, random Weyl, vs #starts:")
W=normalise(random_weyl(12,rng))
prev=0
for s in [1,5,20,60,150,300]:
    val,_=kappa_ms(W,starts=s,iters=200,rng=np.random.default_rng(1000+s))
    print(f"   starts={s:4d}: kappa^2={val:.8f}",flush=True)
print()
print("(4) min kappa^2 over random Weyl vs CP^6 value 6/(n+2)=0.42857 (n=12):")
mn=9
for _ in range(12):
    W=normalise(random_weyl(12,rng)); val,_=kappa_ms(W,starts=20,iters=200,rng=rng); mn=min(mn,val)
print(f"   min over 12 random unit Weyl tensors: {mn:.6f}")
