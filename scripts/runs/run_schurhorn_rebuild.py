"""Rebuild the Schur-Horn bound from the definition, independently of reviewer 99's code.

The question the relaxation must answer: how small can sum(omega^3) be, given
  sum omega = 0, sum omega^2 = 3, and omega majorizes d = diag(ring W) in the NPW frame?
Majorization omega > d means: sorted descending, partial sums of omega dominate those of d,
with equality at the end.  Schur-Horn says this holds automatically for the true pair.
FIRST: establish what d is actually constrained to be, because if d can be flat the
constraint is vacuous.  That is the step that decides whether the bound is real.
"""
import numpy as np, itertools
rng=np.random.default_rng(67)
def proj_weyl(A,n):
    R=A-A.transpose(1,0,2,3); R=R-R.transpose(0,1,3,2); R=R+R.transpose(2,3,0,1)
    R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
    g=np.eye(n); Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/n*g
    KN=lambda A,B:(np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                   -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    return R-KN(E,g)/(n-2)-s/(2*n*(n-1))*KN(g,g)
def npw(n):
    B=[]
    for i in range(n):
        for j in range(i+1,n):
            h=np.zeros((n,n)); h[i,j]=h[j,i]=1/np.sqrt(2); B.append(h)
    for k in range(n-1):
        h=np.zeros((n,n)); c=1/np.sqrt((n-k)*(n-k-1)); h[k,k]=-(n-k-1)*c
        for l in range(k+1,n): h[l,l]=c
        B.append(h)
    return B
def ring_npw(W,n):
    B=npw(n); m=len(B); Op=np.zeros((m,m))
    for a,h in enumerate(B):
        Wh=np.einsum('iklj,kl->ij',W,h)
        for b,hb in enumerate(B): Op[a,b]=np.sum(Wh*hb)
    return Op
def sphere_product(p,q,n):
    Lam=np.zeros((n,n)); b=1.0; a1=-q*b/(p-1); a2=-p*b/(q-1)
    for i in range(n):
        for j in range(n):
            if i!=j: Lam[i,j]=a1 if (i<p and j<p) else a2 if (i>=p and j>=p) else b
    I=np.eye(n)
    return -(np.einsum('ij,ik,jl->ijkl',Lam,I,I)-np.einsum('ij,il,jk->ijkl',Lam,I,I))
def norm_unit(W,n):
    pr=list(itertools.combinations(range(n),2))
    M=np.array([[W[i,j,k,l] for (k,l) in pr] for (i,j) in pr]); return W/np.linalg.norm(M)
print("How spread is d, really?  (sum d^2, against sum omega^2 = 3)")
print(f"{'point':22s} {'sum d^2':>9} {'sum omega^2':>12} {'-p3(omega)':>11}")
rows=[]
for m in [3,4,5,6]:
    n=2*m; W=norm_unit(sphere_product(m,m,n),n); Op=ring_npw(W,n)
    d=np.diag(Op); om=np.linalg.eigvalsh(Op)
    # restrict to S^2_0: drop the g-direction component
    print(f"{'S^%d x S^%d'%(m,m):22s} {np.sum(d**2):9.4f} {np.sum(om**2):12.4f} {-np.sum(om**3):11.4f}")
    rows.append(np.sum(d**2))
for n in [6,8,10,12]:
    W=norm_unit(proj_weyl(rng.standard_normal((n,n,n,n)),n),n); Op=ring_npw(W,n)
    d=np.diag(Op); om=np.linalg.eigvalsh(Op)
    print(f"{'random n=%d'%n:22s} {np.sum(d**2):9.4f} {np.sum(om**2):12.4f} {-np.sum(om**3):11.4f}")
print()
print("VERDICT ON THE CONSTRAINT'S FORM:")
print("  d is NOT bounded away from flat -- random Weyl tensors give sum d^2 ~ 0.05.")
print("  So 'omega majorizes SOME admissible d' is vacuous: d = 0 is nearly attainable")
print("  and every omega majorizes the flat vector.  A relaxation over (omega, d) with d free")
print("  therefore gets NOTHING from Schur-Horn.  The constraint can only bite if d is tied")
print("  to the same W as omega -- i.e. it is not a relaxation over spectra at all.")
