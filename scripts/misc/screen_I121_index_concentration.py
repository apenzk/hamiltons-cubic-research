"""Screen of the quantities in the index-concentration step on the Lambda^2 loss (I121 band).

At S^3xS^3, CP^3, CP^4 and random Weyl tensors (n = 6, 8): P, p3, p4, D = P*p3 - p4,
tr(G#G) for G = W^2, (1/2) sum r_k^2 in the identity frame and |N|_F^2/8, with a lower bound
on t_max from a few frames. The bracket is built in the Frobenius-unit basis, whose squared
bracket norms are half the record's, so the record's tr(G#G) is the commutator mass B itself (r1869).
The frame-wise (1/2) sum r_k^2 bounds tr(G#G) in no frame in general (r1868). The exact
relation tr(G#G) = |N|^2/8 - Sigma4/2 and its failure on Weyl tensors: screen_I121_sigma4.py.
The "padded CP2" row is the Weyl part of a padded CP^2 curvature
tensor in six dimensions, which is not the padded Weyl tensor of CP^2.
Run: sage -python scripts/misc/screen_I121_index_concentration.py   (seconds)
"""
import numpy as np, itertools, importlib.util, sys
spec=importlib.util.spec_from_file_location("g","scripts/misc/g1_I121_E_second_kind.py")
src=open("scripts/misc/g1_I121_E_second_kind.py").read()
src=src[:src.index("for n in (6,8,10):")]
ns={}; exec(src,ns)
bw=ns['bianchi_weyl']; lam2=ns['lam2']; normalise=ns['normalise']; K_of=ns['K_of']
rng=np.random.default_rng(3)
def basis(n):
    P=list(itertools.combinations(range(n),2)); B=[]
    for (i,j) in P:
        X=np.zeros((n,n)); X[i,j]=1; X[j,i]=-1; B.append(X/np.sqrt(2))  # Frobenius-unit
    return P,B
def stats(W,name):
    W=normalise(W); n=W.shape[0]; M=lam2(W); lam,V=np.linalg.eigh(M)
    P,B=basis(n)
    phis=[sum(V[a,k]*B[a] for a in range(len(P))) for k in range(len(P))]
    # structure constants c_{k a g} = <[phi_k,phi_a],phi_g> in Frobenius/2 pairing matching unit basis
    br=lambda X,Y: X@Y-Y@X
    ip=lambda X,Y: np.sum(X*Y)
    N=len(P)
    # commutator mass B = sum lam_k^2 lam_a^2 |[phi_k,phi_a]|^2 (norm in the same unit basis)
    L2=lam**2
    Bm=0.0
    for k in range(N):
        if L2[k]<1e-10: continue
        for a in range(N):
            if L2[a]<1e-10: continue
            c=br(phis[k],phis[a]); Bm+=L2[k]*L2[a]*ip(c,c)
    p3=(lam**3).sum(); p4=(lam**4).sum()
    # theta for a critical point = P(W); for non-critical W report P anyway
    sharp=0.5*np.einsum('ijkl,ipkq,jplq->',W,W,W)
    Pval=p3+sharp
    D=Pval*p3-p4
    # frame mass lower bound: identity frame and a few random frames
    t2=max((K_of(W,np.linalg.qr(rng.normal(size=(n,n)))[0] if s else np.eye(n))**2).sum()/2 for s in range(6))
    Nm=np.einsum('impq,kmpq->ik',W,W); nf=(Nm**2).sum()/8
    rk=np.diag(Nm)/2
    print(f"{name:14s} trN={np.trace(Nm):.3f} |N|^2/8={nf:.4f} half_sum_r2={0.5*(rk**2).sum():.4f} 2/n={2/n:.3f}")
    print(f"{name:14s} n={n} P={Pval:.4f} p3={p3:.4f} p4={p4:.4f} D=P*p3-p4={D:.4f} trG#G={Bm:.4f} t^2(frame lb)={t2:.3f}")
n=6
R=np.zeros((n,n,n,n))
for blk in (range(0,3),range(3,6)):
    for i in blk:
        for j in blk:
            if i!=j: R[i,j,i,j]=1; R[i,j,j,i]=-1
stats(bw(R),"S3xS3")
# padded CP2 in n=6: Kahler curvature on first 4 coords
def cp(m,n):
    J=np.zeros((n,n))
    for k in range(m): J[2*k,2*k+1]=1; J[2*k+1,2*k]=-1
    g=np.zeros((n,n)); g[:2*m,:2*m]=np.eye(2*m)
    R=np.einsum('ik,jl->ijkl',g,g)-np.einsum('il,jk->ijkl',g,g)+np.einsum('ik,jl->ijkl',J,J)-np.einsum('il,jk->ijkl',J,J)+2*np.einsum('ij,kl->ijkl',J,J)
    return bw(R)
stats(cp(2,6),"padded CP2")
stats(cp(3,6),"CP3")
stats(cp(4,8),"CP4")
for n in (6,8):
    for r in range(2): stats(bw(rng.normal(size=(n,n,n,n))),f"random")
