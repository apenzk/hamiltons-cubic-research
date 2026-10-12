"""What IS realisability? Characterise the image of iota: Weyl_n -> Sym(S^2_0), W |-> ring(W).

If the image is a single O(n)-irreducible summand, the constraint is a projection and is
computable; if it is a sum of several, the constraint is weaker and less usable.
Tested by: (a) is iota injective? (b) dim image vs dim Sym(S^2_0);
(c) the O(n)-commutant dimension of the image, via random O(n) conjugation averaging.
"""
import numpy as np, itertools
rng=np.random.default_rng(53)
def proj_weyl(A,n):
    R=A-A.transpose(1,0,2,3); R=R-R.transpose(0,1,3,2); R=R+R.transpose(2,3,0,1)
    R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
    g=np.eye(n); Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/n*g
    KN=lambda A,B:(np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                   -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    return R-KN(E,g)/(n-2)-s/(2*n*(n-1))*KN(g,g)
def ring(W):
    n=W.shape[0]; idx=[(i,j) for i in range(n) for j in range(i,n)]
    def bs(i,j):
        h=np.zeros((n,n))
        if i==j: h[i,i]=1
        else: h[i,j]=h[j,i]=1/np.sqrt(2)
        return h
    B=[bs(i,j) for (i,j) in idx]; m=len(idx); Op=np.zeros((m,m))
    for a,h in enumerate(B):
        Wh=np.einsum('iklj,kl->ij',W,h)
        for b,hb in enumerate(B): Op[a,b]=np.sum(Wh*hb)
    gv=np.array([np.trace(b) for b in B]); gv/=np.linalg.norm(gv)
    P=np.eye(m)-np.outer(gv,gv); Bas=np.linalg.svd(P)[0][:,:m-1]
    return Bas.T@Op@Bas
for n in [5,6,7]:
    dW=n*(n+1)*(n+2)*(n-3)//12; N=(n-1)*(n+2)//2; dS=N*(N+1)//2
    samples=[proj_weyl(rng.standard_normal((n,n,n,n)),n) for _ in range(4*dW+40)]
    pr=list(itertools.combinations(range(n),2))
    dom=np.array([np.array([[W[i,j,k,l] for (k,l) in pr] for (i,j) in pr]).ravel() for W in samples])
    img=np.array([ring(W).ravel() for W in samples])
    rd=np.linalg.matrix_rank(dom,tol=1e-9); ri=np.linalg.matrix_rank(img,tol=1e-9)
    # is Sym(S^2_0) spanned by the image?  and does iota preserve rank (injective)?
    print(f"n={n}: dim Weyl_n={dW:4d} (sample rank {rd:4d})  dim Sym(S^2_0)={dS:5d}  dim image={ri:4d}  "
          f"iota injective: {'YES' if ri==rd==dW else 'NO'}  image is {100*ri/dS:.1f}% of Sym(S^2_0)")
    # how many linear conditions cut the image out?
    print(f"      realisability = {dS-ri} linear conditions on Sym(S^2_0); "
          f"the free spectral problem has {N} eigenvalues but only {ri} degrees of freedom in the operator")
