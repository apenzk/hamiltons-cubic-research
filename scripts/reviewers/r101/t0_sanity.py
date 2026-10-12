import numpy as np, sys, math
sys.path.insert(0,'scripts/reviewers/r101')
from wcore import *
rng=np.random.default_rng(7)
for n in [4,5,6,8]:
    dim=n*(n+1)*(n+2)*(n-3)//12
    S=[random_weyl(n,rng).ravel() for _ in range(dim+15)]
    r=np.linalg.matrix_rank(np.array(S),tol=1e-8)
    W=random_weyl(n,rng)
    tr=np.abs(np.einsum('ijil->jl',W)).max()
    bi=np.abs(W+W.transpose(0,2,3,1)+W.transpose(0,3,1,2)).max()
    print(f"n={n} dimW={dim} sample_rank={r} maxRic={tr:.2e} bianchi={bi:.2e}")
# theta at balanced sphere product, and bispectral identity check
for n in [6,8,12]:
    W=normalise(weyl_sphere_product(n,n//2))
    th,M=theta_of(W)
    mu=np.linalg.eigvalsh(M); om=ring_spectrum(W)
    print(f"n={n} SPxSP theta={th:.9f} theta0={math.sqrt(2*(n-1)*(n-2))/n:.9f} "
          f"bispec={1.5*np.sum(mu**3)-0.5*np.sum(om**3):.9f} sum_om2={np.sum(om**2):.6f}")
