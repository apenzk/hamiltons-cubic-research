import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
from collections import Counter
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r100'))
from core import *
exec(open(_os.path.join(_ROOT, 'scripts/reviewers/r100/p6_ascent.py')).read().split("rng=np.random.default_rng(606)")[0])

rng=np.random.default_rng(707)
print("=== identity of the theta-maximiser (is it CP^2 padded?) ===")
for n in [6,8,12]:
    B=weyl_basis(n); dim=B.shape[1]; d=len(pairs(n))
    val,v=ascend(make_obj('theta',n,B,d),dim,rng,20)
    M=sunvec(B@v,d); A=Wring(full_tensor(M,n),n)
    mu=np.linalg.eigvalsh(M); om=np.linalg.eigvalsh(A)
    nz=mu[np.abs(mu)>1e-7]
    print(f"n={n}: theta={val:.8f}  rank(M)={len(nz)}  nonzero mu = {np.round(np.sort(nz),6)}  ratio {np.round(np.sort(nz)/np.abs(nz).max(),4)}")
    print(f"      p3(mu)={p3(mu):+.6f} -> 3/2 p3mu = {1.5*p3(mu):+.6f} ;  p3(om)={p3(om):+.6f} -> -1/2 p3om = {-0.5*p3(om):+.6f}")
    onz=om[np.abs(om)>1e-7]
    print(f"      nonzero omega ({len(onz)}): {np.round(np.sort(onz),6)}")

print()
print("=== CLAIM 4 consequence: joint body vs product of Okumura marginals ===")
for n in [6,8,12]:
    B=weyl_basis(n); dim=B.shape[1]; d=len(pairs(n))
    dl=len(pairs(n)); N=(n-1)*(n+2)//2
    okm=(dl-2)/np.sqrt(dl*(dl-1))
    oko=(N-2)/np.sqrt(N*(N-1))*3**1.5
    print(f"n={n}: Okumura cap p3(mu) <= {okm:.6f};  -p3(om) <= {oko:.6f}")
    print(f"   product-of-marginals bound on theta = 3/2*{okm:.4f} + 1/2*{oko:.4f} = {1.5*okm+0.5*oko:.6f}   [theta0={theta0(n):.6f}]")
    # true marginals by ascent
    fmu=lambda v,n=n,B=B,d=d: (lambda M: (float(np.trace(M@M@M)), B.T@svec(3.0*(M@M))))(sunvec(B@v,d))
    mmu,_=ascend(fmu,dim,rng,25)
    mom,_=ascend(make_obj('mp3om',n,B,d),dim,rng,25)
    mth,_=ascend(make_obj('theta',n,B,d),dim,rng,25)
    print(f"   ATTAINED marginals:  max p3(mu) = {mmu:.6f} (cap {okm:.4f}, {100*mmu/okm:.1f}% of cap)")
    print(f"                        max -p3(om) = {mom:.6f} (cap {oko:.4f}, {100*mom/oko:.1f}% of cap)")
    print(f"   max theta (joint)  = {mth:.6f}   vs sum-of-attained-marginals {1.5*mmu+0.5*mom:.6f}")
    print(f"   -> the two marginals are NOT simultaneously attainable: joint max is {100*mth/(1.5*mmu+0.5*mom):.1f}% of the marginal sum")
