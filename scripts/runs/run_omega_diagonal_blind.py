"""Item 1(iv), first coupling attempt: NPW Prop 3.10 says the diagonal of Wring in the
{phi_ij, psi_k} basis is built from sectional curvatures -- for a Weyl tensor, the phi part
is exactly the vertex matrix K_ab = W_abab.  The diagonal of a symmetric operator is
majorized by its spectrum (Schur-Horn), so K constrains omega.  Question: how much?"""
import numpy as np, itertools
rng=np.random.default_rng(31)
def proj_weyl(A,n):
    R=A-A.transpose(1,0,2,3); R=R-R.transpose(0,1,3,2); R=R+R.transpose(2,3,0,1)
    R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
    g=np.eye(n); Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/n*g
    KN=lambda A,B:(np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                   -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    return R-KN(E,g)/(n-2)-s/(2*n*(n-1))*KN(g,g)
def npw_basis(n):
    """Prop 3.10: phi_ij = (e_i ox e_j + e_j ox e_i)/sqrt2 for i<j; psi_k for k=1..n-1."""
    B=[]
    for i in range(n):
        for j in range(i+1,n):
            h=np.zeros((n,n)); h[i,j]=h[j,i]=1/np.sqrt(2); B.append(('phi',(i,j),h))
    for k in range(n-1):
        h=np.zeros((n,n)); c=1/np.sqrt((n-k)*(n-k-1))
        h[k,k]=-(n-k-1)*c
        for l in range(k+1,n): h[l,l]=c
        B.append(('psi',(k,),h))
    return B
def ring_in_npw(W):
    n=W.shape[0]; B=npw_basis(n); m=len(B); Op=np.zeros((m,m))
    for a,(_,_,h) in enumerate(B):
        Wh=np.einsum('iklj,kl->ij',W,h)
        for b,(_,_,hb) in enumerate(B): Op[a,b]=np.sum(Wh*hb)
    return Op,B
def sphere_product(p,q,n):
    Lam=np.zeros((n,n)); b=1.0; a1=-q*b/(p-1); a2=-p*b/(q-1)
    for i in range(n):
        for j in range(n):
            if i==j: continue
            Lam[i,j]=a1 if (i<p and j<p) else a2 if (i>=p and j>=p) else b
    I=np.eye(n)
    return -(np.einsum('ij,ik,jl->ijkl',Lam,I,I)-np.einsum('ij,il,jk->ijkl',Lam,I,I))
def report(label,W):
    n=W.shape[0]; pr=list(itertools.combinations(range(n),2))
    M=np.array([[W[i,j,k,l] for (k,l) in pr] for (i,j) in pr]); nm=np.linalg.norm(M)
    W=W/nm; M=M/nm
    Op,B=ring_in_npw(W); d=np.diag(Op); om=np.linalg.eigvalsh(Op)
    # is the phi-diagonal the vertex matrix?
    Kd=np.array([W[i,j,i,j] for (_,idx,_) in B if _=='phi' for (i,j) in [idx]]) if False else \
       np.array([W[idx[0],idx[1],idx[0],idx[1]] for (t,idx,_) in B if t=='phi'])
    dphi=np.array([d[a] for a,(t,_,_) in enumerate(B) if t=='phi'])
    p3o=np.sum(om**3); p3d=np.sum(d**3); p3m=np.trace(M@M@M)
    N=len(om); okum=3**1.5*(N-2)/np.sqrt(N*(N-1))
    print(f"{label:22s} n={n:2d} | phi-diag == vertex K? maxdev {np.abs(dphi-Kd).max():.1e} | "
          f"sum d = {d.sum():+.2e} sum d^2 = {np.sum(d**2):.4f} (om^2=3) | "
          f"-p3(om)={-p3o:7.4f}  -p3(diag)={-p3d:7.4f}  ratio {p3d/p3o if abs(p3o)>1e-9 else float('nan'):6.3f} | Okumura {okum:6.3f} ({-p3o/okum:.3f})")
print("=== balanced sphere products (the maximiser) ===")
for m_ in [3,4,5,6]: report(f"S^{m_}xS^{m_}", sphere_product(m_,m_,2*m_))
print("=== unbalanced, and random ===")
report("S^3xS^5", sphere_product(3,5,8)); report("S^4xS^8", sphere_product(4,8,12))
for n in [6,8,10]:
    for t in range(2):
        report(f"random n={n} #{t}", proj_weyl(rng.standard_normal((n,n,n,n)),n))
