"""Both-sided Schur-Horn. Verify the two diagonals from the definition, then set up the
joint relaxation.  Reviewer claims to rebuild rather than quote:
  (i)  diag M in the phi-basis of Lambda^2 is exactly K_ab = W_abab
  (ii) the psi-block of ringW is exactly -K restricted to 1-perp
  (iii) hence sum d^2 = (3/2)||K||_F^2 for the FULL S^2_0 diagonal
"""
import numpy as np, itertools
rng=np.random.default_rng(107)
def proj_weyl(A,n):
    R=A-A.transpose(1,0,2,3); R=R-R.transpose(0,1,3,2); R=R+R.transpose(2,3,0,1)
    R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
    g=np.eye(n); Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/n*g
    KN=lambda A,B:(np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                   -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    return R-KN(E,g)/(n-2)-s/(2*n*(n-1))*KN(g,g)
def pairs(n): return list(itertools.combinations(range(n),2))
def toM(W,n):
    pr=pairs(n); return np.array([[W[i,j,k,l] for (k,l) in pr] for (i,j) in pr])
def Kof(W,n):
    K=np.zeros((n,n))
    for a in range(n):
        for b in range(n):
            if a!=b: K[a,b]=W[a,b,a,b]
    return K
def ring_full(W,n):
    idx=[(i,j) for i in range(n) for j in range(i,n)]
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
def npw_diag(W,n):
    """diagonal of ringW in the NPW basis with psi's taken as K's eigenvectors on 1-perp."""
    K=Kof(W,n)
    dphi=np.array([W[a,b,a,b] for (a,b) in pairs(n)])
    nu=np.linalg.eigvalsh(K)          # K1 = 0 for Ricci-flat W, so one eigenvalue is 0
    # drop the eigenvalue belonging to the all-ones direction
    v1=np.ones(n)/np.sqrt(n); w,V=np.linalg.eigh(K)
    keep=[i for i in range(n) if abs(V[:,i]@v1)<0.9]
    dpsi=-w[keep]
    return dphi, dpsi, K
def sphere_product(p,q,n):
    Lam=np.zeros((n,n)); b=1.0; a1=-q*b/(p-1); a2=-p*b/(q-1)
    for i in range(n):
        for j in range(n):
            if i!=j: Lam[i,j]=a1 if (i<p and j<p) else a2 if (i>=p and j>=p) else b
    I=np.eye(n)
    return -(np.einsum('ij,ik,jl->ijkl',Lam,I,I)-np.einsum('ij,il,jk->ijkl',Lam,I,I))
print(f"{'point':20s} {'K1=0?':>8} {'diagM==K?':>10} {'sum dphi^2':>11} {'sum d^2':>9} {'1.5||K||^2':>11} {'sum om^2':>9}")
for n in [6,8,12]:
    for lbl,W in [(f"S^{n//2}xS^{n//2}",sphere_product(n//2,n//2,n)),
                  (f"random n={n}",proj_weyl(rng.standard_normal((n,n,n,n)),n))]:
        M=toM(W,n); nm=np.linalg.norm(M); W=W/nm; M=M/nm
        dphi,dpsi,K=npw_diag(W,n)
        diagM=np.diag(M); Kvec=np.array([K[a,b] for (a,b) in pairs(n)])
        R0=ring_full(W,n); om=np.linalg.eigvalsh(R0)
        d=np.concatenate([dphi,dpsi])
        print(f"{lbl:20s} {np.abs(K@np.ones(n)).max():8.1e} {np.abs(diagM-Kvec).max():10.1e} "
              f"{np.sum(dphi**2):11.5f} {np.sum(d**2):9.5f} {1.5*np.linalg.norm(K)**2:11.5f} {np.sum(om**2):9.5f}")
        # does d majorize-check out against omega?
        so=np.sort(om)[::-1]; sd=np.sort(d)[::-1]
        sl=np.cumsum(so)-np.cumsum(sd)
        print(f"{'':20s} majorization omega > d: min cumulative slack {sl.min():+.2e}  (sum diff {abs(so.sum()-sd.sum()):.1e})")
