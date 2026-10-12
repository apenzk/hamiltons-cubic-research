"""The mechanism for the n<=5 syzygy: Lovelock's identity  delta^{a1..a6}_{b1..b6} = 0  for n<=5.
Contract it with W(x3) and read off the combination of alpha,beta it produces."""
import numpy as np, itertools
from math import prod
rng=np.random.default_rng(3)
def proj_weyl(A,n):
    R=A-A.transpose(1,0,2,3); R=R-R.transpose(0,1,3,2); R=R+R.transpose(2,3,0,1)
    R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
    g=np.eye(n); Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/n*g
    KN=lambda A,B:(np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                   -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    return R-KN(E,g)/(n-2)-s/(2*n*(n-1))*KN(g,g)
def perm_sign(p):
    s=1; p=list(p); 
    for i in range(len(p)):
        while p[i]!=i:
            j=p[i]; p[i],p[j]=p[j],p[i]; s=-s
    return s
L='abcdef'
def lovelock(W):
    """sum_sigma sign(sigma) W_{a1a2 b1b2} W_{a3a4 b3b4} W_{a5a6 b5b6} with b_j = a_{sigma^{-1}(j)}."""
    tot=0.0
    for sig in itertools.permutations(range(6)):
        inv=[0]*6
        for j,v in enumerate(sig): inv[v]=j
        # W1 lower a0,a1 upper b0,b1 -> a_{inv[0]}, a_{inv[1]}
        sub=(f"{L[0]}{L[1]}{L[inv[0]]}{L[inv[1]]},"
             f"{L[2]}{L[3]}{L[inv[2]]}{L[inv[3]]},"
             f"{L[4]}{L[5]}{L[inv[4]]}{L[inv[5]]}->")
        tot+=perm_sign(sig)*np.einsum(sub,W,W,W,optimize=True)
    return tot
print(f"{'n':>3} {'Lovelock contraction':>22} {'alpha':>12} {'beta':>12} {'beta-alpha/2':>14} {'LL / (beta-alpha/2)':>20}")
for n in [4,5,6,7,8]:
    W=proj_weyl(rng.standard_normal((n,n,n,n)),n); W/=np.sqrt(np.einsum('ijkl,ijkl',W,W))
    LL=lovelock(W)
    al=np.einsum('tpsq,tpkl,sqkl->',W,W,W); be=np.einsum('tspq,tjpl,sjql->',W,W,W)
    d=be-al/2
    print(f"{n:>3} {LL:>22.9f} {al:>12.6f} {be:>12.6f} {d:>14.6f} {LL/d if abs(d)>1e-9 else float('nan'):>20.6f}")
