"""I113 (a): screens the outside archive's second-kind/Hessian defect identity (1.5),
(beta mu - lambda)|Z(h)|^2 = Delta_M - Delta_H, at three critical points of Weyl_8.

Conventions are pinned by the source's own <W,Z> = mu/2: mu is the TOP eigenvalue of h -> sum_jl W_ijkl h_jl on
traceless symmetric h (Frobenius-unit), M = mu - that operator, Z = pi_W(h wedge h)/2, and the so(n) basis is
orthonormal in <A,B> = tr(A^T B)/2, acting on operators by conjugation.  The other scale (Frobenius tr) is run as
the control and fails by 1e-1 and 1e-2, so the test can fail.  The archive states the identity and never proves it.
Seconds on stored or constructed objects.
"""
import sys, numpy as np
sys.path.insert(0, __file__.rsplit("/", 1)[0])
from screen_I73_pair_direction import pairs, structure_constants, weyl_projector, sharp_mat, circ, ortho_basis
from screen_I66_sphere_product_anchor import sphere_weight, br
from screen_I73_pair_blindness import padded_cp2
def to4(M,n):
    pr=pairs(n); R=np.zeros((n,n,n,n))
    for a,(i,j) in enumerate(pr):
        for b,(k,l) in enumerate(pr):
            x=M[a,b]; R[i,j,k,l]=x; R[j,i,k,l]=-x; R[i,j,l,k]=-x; R[j,i,l,k]=x
    return R
def from4(R,n):
    pr=pairs(n); return np.array([[R[i,j,k,l] for (k,l) in pr] for (i,j) in pr])
def test(W,n,label):
    N=len(pairs(n)); c=structure_constants(n); Pi,_=weyl_projector(n); P=ortho_basis(n)
    W=W/np.sqrt(np.trace(W@W)); lam=np.trace(W@W@W)+np.sum(W*sharp_mat(c,W,W))
    W4=to4(W,n)
    # S^2_0 basis (Frobenius orthonormal)
    S=[]
    for i in range(n):
        for j in range(i,n):
            m=np.zeros((n,n)); m[i,j]=m[j,i]=1; S.append(m/np.linalg.norm(m))
    S=np.array(S); tr=np.array([np.trace(m) for m in S]); 
    # project out identity
    I=np.eye(n)/np.sqrt(n)
    Sm=np.array([m-np.sum(m*I)*I for m in S]).reshape(len(S),-1)
    U,sv,_=np.linalg.svd(Sm.T,full_matrices=False); B0=U[:,sv>1e-9]  # basis of S^2_0 (vectorised)
    What=lambda h: np.einsum('ijkl,jl->ik',W4,h)
    Mw=np.array([[np.sum(B0[:,a].reshape(n,n)*What(B0[:,b].reshape(n,n))) for b in range(B0.shape[1])] for a in range(B0.shape[1])])
    ev,EV=np.linalg.eigh((Mw+Mw.T)/2); mu=ev[-1]; h=(B0@EV[:,-1]).reshape(n,n)
    hh4=2*(np.einsum('ik,jl->ijkl',h,h)-np.einsum('il,jk->ijkl',h,h))
    Z=0.5*(Pi@from4(hh4,n).ravel()).reshape(N,N)
    c_=np.sum(W*Z)
    h2=h@h; r0=h2-np.trace(h2)/n*np.eye(n)
    DM=(n-3)/(2*(n-2))*(mu*np.sum(r0*r0)-np.sum(r0*What(r0)))
    beta=(n-1)/n
    # so(n) action on operators: (A.Z)(X)=[A,Z X]-Z[A,X], in phi basis
    def actmat(A):
        adA=np.array([[ 0.5*np.trace(P[x].T@br(A,P[y])) for y in range(N)] for x in range(N)])
        return adA
    out={}
    for scale in (1.0,np.sqrt(2)):
        DH_a=DH_b=0.0
        for k in range(N):
            A=P[k]/scale
            ad=actmat(A)
            AZ=ad@Z-Z@ad
            w=W.ravel(); v=AZ.ravel(); vp=(v-(v@w)*w).reshape(N,N)
            for V,key in ((AZ,'a'),(vp,'b')):
                val=lam/2*np.sum(V*V)-np.sum(V*circ(c,W,V))
                if key=='a': DH_a+=val
                else: DH_b+=val
        for key,DH in (('a',DH_a),('b',DH_b)):
            lhs=(beta*mu-lam)*np.sum(Z*Z); rhs=DM-DH/(2*(n-1))
            out[(round(scale,3),key)]=lhs-rhs
    print(f"{label}: lam={lam:.6f} mu={mu:.6f} <W,Z>={c_:.6f} (mu/2={mu/2:.6f})  residuals:", {k:f"{v:+.2e}" for k,v in out.items()})
n=8; N=len(pairs(n))
test(padded_cp2(n),n,"padded CP2")
w=sphere_weight(n,4); test(np.diag([w[i,j] for (i,j) in pairs(n)]),n,"S4xS4")
test(np.load(__file__.rsplit("/", 2)[0] + "/reviewers/r305/out/r305_n8_seed9015.npy"),n,"F39 witness")

# THE REDUCTION: at a RANDOM Weyl W, arbitrary lambda, ANY eigenpair of the second-kind operator,
# the Hessian sum is (c/2)(lambda|Z|^2 - T(W,Z,Z)) with c = 4(n-1) the Casimir on Weyl_n, and
# T(W,Z,Z) = beta mu |Z|^2 - Delta_M, so (1.5) needs no criticality and no bottom eigenvector.
rng=np.random.default_rng(1)
for n in (5,6,7):
    N=len(pairs(n)); c=structure_constants(n); Pi,_=weyl_projector(n); P=ortho_basis(n)
    M=rng.normal(size=(N,N)); M=(M+M.T)/2; W=(Pi@M.ravel()).reshape(N,N); W/=np.sqrt(np.trace(W@W))
    lam=rng.normal()  # arbitrary, no criticality
    W4=to4(W,n)
    S=[]
    for i in range(n):
        for j in range(i,n):
            m=np.zeros((n,n)); m[i,j]=m[j,i]=1; S.append((m/np.linalg.norm(m)).ravel())
    I=np.eye(n).ravel()/np.sqrt(n); S=np.array([s-(s@I)*I for s in S]).T
    U,sv,_=np.linalg.svd(S,full_matrices=False); B0=U[:,sv>1e-9]
    What=lambda h: np.einsum('ijkl,jl->ik',W4,h)
    Mw=np.array([[np.sum(B0[:,a].reshape(n,n)*What(B0[:,b].reshape(n,n))) for b in range(B0.shape[1])] for a in range(B0.shape[1])])
    ev,EV=np.linalg.eigh((Mw+Mw.T)/2)
    ads=[np.array([[0.5*np.trace(P[x].T@br(P[k],P[y])) for y in range(N)] for x in range(N)]) for k in range(N)]
    # Casimir on Weyl_n
    Zr=(Pi@rng.normal(size=N*N)).reshape(N,N); Zr=(Zr+Zr.T)/2; Zr=(Pi@Zr.ravel()).reshape(N,N)
    CZ=sum(ad@(ad@Zr-Zr@ad)-(ad@Zr-Zr@ad)@ad for ad in ads)
    cas=-np.sum(CZ*Zr)/np.sum(Zr*Zr)
    r1=r2=0
    for idx in (0,len(ev)//2,len(ev)-1):
        mu=ev[idx]; h=(B0@EV[:,idx]).reshape(n,n)
        hh=2*(np.einsum('ik,jl->ijkl',h,h)-np.einsum('il,jk->ijkl',h,h))
        Z=0.5*(Pi@from4(hh,n).ravel()).reshape(N,N)
        s=0
        for ad in ads:
            V=ad@Z-Z@ad; s+=lam/2*np.sum(V*V)-np.sum(V*circ(c,W,V))
        TWZZ=np.sum(Z*circ(c,W,Z))
        r1=max(r1,abs(s-cas/2*(lam*np.sum(Z*Z)-TWZZ)))
        h2=h@h; r0=h2-np.trace(h2)/n*np.eye(n)
        DM=(n-3)/(2*(n-2))*(mu*np.sum(r0*r0)-np.sum(r0*What(r0)))
        r2=max(r2,abs(TWZZ-((n-1)/n*mu*np.sum(Z*Z)-DM)))
    print(f"n={n}: Casimir on Weyl_n = {cas:.9f} (4(n-1)={4*(n-1)}); |sum<K(A.Z),A.Z> - (c/2)(lam|Z|^2-T(W,Z,Z))| = {r1:.1e}; |T(W,Z,Z) - (beta mu|Z|^2 - Delta_M)| = {r2:.1e}  [random Weyl W, arbitrary lam, three eigenpairs]")
