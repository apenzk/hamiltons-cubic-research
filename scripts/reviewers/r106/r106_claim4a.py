import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r106'))
from r106_core import *
from r106_hess import *
rng=np.random.default_rng(7)

print("=== validation of the cubic machinery ===")
for n in (5,6,7):
    W=rand_weyl(n,rng); M=to_M(W); M/=np.linalg.norm(M)
    print(f" n={n}: Theta(M)-theta(W)={Theta(M,n)-theta(W):.2e}  "
          f"Euler <grad,M>-3Theta={np.sum(grad(M,n)*M)-3*Theta(M,n):.2e}  "
          f"T(M,M,M)-Theta={Tform(M,M,M,n)-Theta(M,n):.2e}")
    A=to_M(rand_weyl(n,rng)); B=to_M(rand_weyl(n,rng))
    s1=Tform(M,A,B,n); s2=Tform(A,M,B,n); s3=Tform(B,A,M,n)
    print(f"      T symmetric: {abs(s1-s2):.2e} {abs(s1-s3):.2e};  "
          f"T(M,M,A)-<Q(M),A>={Tform(M,M,A,n)-np.sum(grad(M,n)*A)/3:.2e}")
    # projector checks
    X=rng.standard_normal((len(pairs(n)),)*2); X=(X+X.T)/2
    Y=rng.standard_normal((len(pairs(n)),)*2); Y=(Y+Y.T)/2
    print(f"      Pi_W idempotent {np.abs(Pi_W(Pi_W(X,n),n)-Pi_W(X,n)).max():.1e} "
          f"self-adjoint {abs(np.sum(Pi_W(X,n)*Y)-np.sum(X*Pi_W(Y,n))):.1e} "
          f"rank-anchor dim(W_n)={n*(n+1)*(n+2)*(n-3)//12}")

print("\n=== KEY FACT: is Q(D) diagonal for D a coordinate-diagonal Weyl tensor? ===")
for n in (5,6,7,8,10,12):
    K=rng.standard_normal((n,n)); K=(K+K.T)/2; np.fill_diagonal(K,0)
    # project to zero row sums
    for _ in range(500):
        r=K.sum(1); K=K-np.add.outer(r,r)/(n-2)+K.sum()/((n-1)*(n-2))
        K=(K+K.T)/2; np.fill_diagonal(K,0)
    Wd=diag_weyl=None
    Wt=np.zeros((n,n,n,n))
    for a in range(n):
        for b in range(n):
            if a!=b: Wt[a,b,a,b]=K[a,b]; Wt[a,b,b,a]=-K[a,b]
    D=to_M(Wt); D/=np.linalg.norm(D)
    Q=grad(D,n)/3.0
    off=Q-np.diag(np.diag(Q))
    Qw=Pi_W(Q,n); offw=Qw-np.diag(np.diag(Qw))
    print(f" n={n}: weyl-resid(D)={max(residuals(Wt).values()):.1e}  "
          f"|offdiag Q(D)|={np.abs(off).max():.2e}  |offdiag Pi_W Q(D)|={np.abs(offw).max():.2e}")
