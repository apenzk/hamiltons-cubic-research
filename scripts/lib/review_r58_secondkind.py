"""Claim 4: block (a) of L_e equals (1/2) Rring_e ; and lam_max(Rring_W) <= 2 b Sigma."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r58_core import *

def sharp_bilin(X,Y,n):
    A=Amats(n)
    AX=np.einsum('amn,np->amp',A,X); AY=np.einsum('bmn,np->bmp',A,Y)
    T=np.einsum('amp,bpm->ab',AX,AY)
    return -0.25*(T+T.T)

def circ(X,Y,n):
    return 0.5*(X@Y+Y@X)+sharp_bilin(X,Y,n)

print('=== (0) sanity: W o W == Q(W) ? ===')
rng=np.random.default_rng(1)
for n in [5,6]:
    B=weyl_basis(n); x=rng.standard_normal(len(B)); W=np.einsum('d,dij->ij',x,B); W/=fro(W)
    print('  n=%d  max|W o W - Q(W)| = %.2e'%(n,np.max(np.abs(circ(W,W,n)-Q(W,n)))))

print()
print('=== (1) block (a) of L_e  vs  (1/2) Rring_e ===')
def block_a_test(W0,n0,n,label):
    """u = last coordinate e_{n-1}; W = pad(W0) so u is in the kernel direction."""
    W=pad(W0,n0,n); N=n*(n-1)//2; pr=pairs(n); pidx={p:a for a,p in enumerate(pr)}
    th=theta(W,n); e=W/th
    u=n-1
    A_idx=[pidx[(i,u)] for i in range(n-1)]        # basis of u ^ u-perp
    m=len(A_idx)
    # basis of symmetric operators supported on u^u-perp
    R=R_of(e,n)
    Rring=np.zeros((m*m,m*m))
    L=np.zeros((m,m,m,m))
    for i in range(m):
        for j in range(m):
            Xh=np.zeros((N,N))
            # h = symmetric basis element E_ij + E_ji (or E_ii)
            Xh[A_idx[i],A_idx[j]]+=1.0; Xh[A_idx[j],A_idx[i]]+=1.0
            if i==j: Xh[A_idx[i],A_idx[i]]=1.0
            LX=circ(e,Xh,n)
            for k in range(m):
                for l in range(m):
                    L[i,j,k,l]=LX[A_idx[k],A_idx[l]]
            # leakage out of block (a)
    # now compare against (1/2) Rring on the same h-basis
    # Rring h_{ij} = sum_{kl} e_{ikjl} h_{kl}, indices in u-perp = 0..n-2
    err=0.0; mx=0.0
    for i in range(m):
        for j in range(m):
            h=np.zeros((m,m)); h[i,j]+=1.0; h[j,i]+=1.0
            if i==j: h[i,i]=1.0
            Rh=np.einsum('ikjl,kl->ij',R[:n-1,:n-1,:n-1,:n-1],h)
            Lh=L[i,j]
            err=max(err,np.max(np.abs(Lh-0.5*Rh))); mx=max(mx,np.max(np.abs(0.5*Rh)))
    # leakage: is L_e X still supported on block (a)?
    leak=0.0
    for i in range(m):
        for j in range(i,m):
            Xh=np.zeros((N,N)); Xh[A_idx[i],A_idx[j]]+=1.0; Xh[A_idx[j],A_idx[i]]+=1.0
            if i==j: Xh[A_idx[i],A_idx[i]]=1.0
            LX=circ(e,Xh,n); M=LX.copy()
            for k in A_idx:
                for l in A_idx: M[k,l]=0.0
            leak=max(leak,np.max(np.abs(M)))
    print('  %-22s n=%2d  max|L_e|_(a) - (1/2)Rring_e| = %.3e   (scale %.4f)   leakage out of block (a) = %.3e'%(
        label,n,err,mx,leak))
W4=wcp2()
for n in [6,8,10]: block_a_test(W4,4,n,'padded W_CP2')
# a random padded Weyl_5 and Weyl_6
for (n0,n) in [(5,6),(5,7),(6,8)]:
    B=weyl_basis(n0); x=rng.standard_normal(len(B)); W0=np.einsum('d,dij->ij',x,B); W0/=fro(W0)
    block_a_test(W0,n0,n,'random padded W_%d'%n0)
