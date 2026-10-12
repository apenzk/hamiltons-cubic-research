import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r58_core import *
from review_r58_secondkind import sharp_bilin, circ

def Rring_mat(W,n,sub=None):
    """matrix of h -> (Rring h)_ij = sum_kl R_ikjl h_kl on symmetric 2-tensors of R^m (m=n or sub)."""
    R=R_of(W,n); m=n if sub is None else sub
    R=R[:m,:m,:m,:m]
    idx=[(i,j) for i in range(m) for j in range(i,m)]
    M=np.zeros((len(idx),len(idx)))
    def hb(p):
        i,j=idx[p]; h=np.zeros((m,m))
        if i==j: h[i,i]=1.0
        else: h[i,j]=h[j,i]=1/np.sqrt(2)
        return h
    for q in range(len(idx)):
        Rh=np.einsum('ikjl,kl->ij',R,hb(q))
        for p in range(len(idx)):
            M[p,q]=np.sum(hb(p)*Rh)
    return 0.5*(M+M.T)

print('=== (2) L_e is self-adjoint, and block (a) is invariant  ===')
rng=np.random.default_rng(2); n=6
B=weyl_basis(n); x=rng.standard_normal(len(B)); e=np.einsum('d,dij->ij',x,B); e/=fro(e)
N=n*(n-1)//2
Xs=[rng.standard_normal((N,N)) for _ in range(3)]; Xs=[(X+X.T)/2 for X in Xs]
X,Y,Z=Xs
print('  <e o X, Y> - <X, e o Y> = %.2e'%(np.sum(circ(e,X,n)*Y)-np.sum(X*circ(e,Y,n))))

print()
print('=== (3) lam_max(Rring_W) <= 2 b Sigma  ===')
def sigma_and_b(W,n,kmax=2):
    lam,V=np.linalg.eigh(W); P=phis(n)
    neg=[i for i in range(len(lam)) if lam[i]<-1e-10]
    b=max(-lam[i] for i in neg) if neg else 0.0
    s=[]
    for i in neg:
        v=np.einsum('p,pij->ij',V[:,i],P)
        s.append(np.linalg.svd(v,compute_uv=False)[0]**2)
    s.sort(reverse=True)
    return b, sum(s[:kmax]), sum(s), len(neg)

print('  point                       n   #neg   lam_max(Rring_W)   2b*Sigma(top2)   2b*Sigma(all)   theta')
W4=wcp2()
for n in [6,8,10]:
    W=pad(W4,4,n); b,S2,Sa,k=sigma_and_b(W,n)
    lm=np.linalg.eigvalsh(Rring_mat(W,n))[-1]
    print('  padded W_CP2             %3d   %3d   %14.9f  %14.9f  %14.9f  %.6f'%(n,k,lm,2*b*S2,2*b*Sa,theta(W,n)))
# padded generic Weyl_4 with <=2 negatives (the (1,2) stratum)
from review_r58_l29 import weyl4_12
for (q,r) in [(1,1),(1,0.4),(2,0.3)]:
    for n in [6,8]:
        W=pad(weyl4_12(q,r),4,n); b,S2,Sa,k=sigma_and_b(W,n)
        lm=np.linalg.eigvalsh(Rring_mat(W,n))[-1]
        print('  padded Weyl4 q=%.1f r=%.1f    %3d   %3d   %14.9f  %14.9f  %14.9f  %.6f'%(q,r,n,k,lm,2*b*S2,2*b*Sa,theta(W,n)))
print()
print('  --- random Weyl_n (many negative eigenvalues): does the bound fail? ---')
rng=np.random.default_rng(5)
for n in [5,6,7]:
    B=weyl_basis(n); fail2=0; failall=0; tot=40
    worst2=0; worstall=0
    for _ in range(tot):
        x=rng.standard_normal(len(B)); W=np.einsum('d,dij->ij',x,B); W/=fro(W)
        b,S2,Sa,k=sigma_and_b(W,n); lm=np.linalg.eigvalsh(Rring_mat(W,n))[-1]
        if lm>2*b*S2+1e-9: fail2+=1; worst2=max(worst2,lm/(2*b*S2))
        if lm>2*b*Sa+1e-9: failall+=1; worstall=max(worstall,lm/(2*b*Sa))
    print('   n=%d  truncated Sigma(top 2) violated %d/%d (worst ratio %.3f) | full Sigma(all negatives) violated %d/%d (worst %.3f)'%(
        n,fail2,tot,worst2,failall,tot,worstall))
