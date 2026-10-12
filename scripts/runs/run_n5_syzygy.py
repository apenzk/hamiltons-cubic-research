"""Harden the n<=5 syzygy  <W^#,W> = 2 tr(W^3)  (equivalently beta = alpha/2).
Positive controls: the sample must SPAN Weyl_n, and the identity must hold on an
independently built basis, not only on the projector's output."""
import numpy as np, itertools
from numpy.linalg import matrix_rank
rng=np.random.default_rng(11)
def proj_weyl(A,n):
    R=A-A.transpose(1,0,2,3); R=R-R.transpose(0,1,3,2); R=R+R.transpose(2,3,0,1)
    R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
    g=np.eye(n); Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/n*g
    KN=lambda A,B:(np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                   -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    return R-KN(E,g)/(n-2)-s/(2*n*(n-1))*KN(g,g)
def resid(W):
    n=W.shape[0]
    return (np.abs(np.einsum('ikjk->ij',W)).max(),
            np.abs(W+W.transpose(1,2,0,3)+W.transpose(2,0,1,3)).max(),
            np.abs(W-W.transpose(2,3,0,1)).max(),
            np.abs(W+W.transpose(1,0,2,3)).max())
def ab(W):
    return (np.einsum('tpsq,tpkl,sqkl->',W,W,W), np.einsum('tspq,tjpl,sjql->',W,W,W))
for n in [4,5,6,7]:
    # (1) does the sample span Weyl_n?
    V=[proj_weyl(rng.standard_normal((n,n,n,n)),n).ravel() for _ in range(80)]
    d=matrix_rank(np.array(V),tol=1e-9); dW=n*n*(n*n-1)//12-n*(n+1)//2+ (0 if n>2 else 0)
    dim_weyl=n*(n+1)*(n+2)*(n-3)//12
    # (2) identity on a BASIS of Weyl_n, and on all pairwise/triple polarisations
    B=[proj_weyl(rng.standard_normal((n,n,n,n)),n) for _ in range(6)]
    worst_r=max(max(resid(b)) for b in B)
    rats=[]
    for b in B:
        a_,be=ab(b); rats.append(be/a_)
    # (3) trilinear polarisation: is beta(X,Y,Z) = alpha(X,Y,Z)/2 as forms?
    def a3(X,Y,Z): return np.einsum('tpsq,tpkl,sqkl->',X,Y,Z)
    def b3(X,Y,Z): return np.einsum('tspq,tjpl,sjql->',X,Y,Z)
    pol=[]
    for X,Y,Z in itertools.product(B[:4],repeat=3):
        A_=(a3(X,Y,Z)+a3(Y,Z,X)+a3(Z,X,Y)+a3(X,Z,Y)+a3(Z,Y,X)+a3(Y,X,Z))/6
        Bv=(b3(X,Y,Z)+b3(Y,Z,X)+b3(Z,X,Y)+b3(X,Z,Y)+b3(Z,Y,X)+b3(Y,X,Z))/6
        pol.append(Bv-A_/2)
    print(f"n={n}: dim Weyl={dim_weyl:3d} sample rank={d:3d} {'SPANS' if d==dim_weyl else 'DEFICIENT'} | max Weyl residual={worst_r:.1e}"
          f" | beta/alpha = {np.mean(rats):.9f} +- {np.std(rats):.0e} | max |beta_3 - alpha_3/2| over 64 polarisations = {np.abs(pol).max():.2e}")
