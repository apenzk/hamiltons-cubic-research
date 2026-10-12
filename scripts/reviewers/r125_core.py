"""Reviewer 125 -- verify claims 1,2 and attack claim 3."""
import numpy as np, sys
from r125_lib import struct, sharp, Q, to_tensor, from_tensor, weyl_basis, project

np.set_printoptions(precision=6, suppress=True)

def Jmat(m):
    n=2*m; J=np.zeros((n,n))
    for k in range(m): J[2*k,2*k+1]=1.0; J[2*k+1,2*k]=-1.0
    return J

def fs_tensor(m):
    """Fubini-Study algebraic curvature tensor, const holomorphic sect curv."""
    n=2*m; J=Jmat(m); d=np.eye(n)
    R=(np.einsum('ik,jl->ijkl',d,d)-np.einsum('il,jk->ijkl',d,d)
       +np.einsum('ik,jl->ijkl',J,J)-np.einsum('il,jk->ijkl',J,J)
       +2*np.einsum('ij,kl->ijkl',J,J))
    return R

def sphere_prod(p,q):
    """Weyl part of curvature of S^p x S^q with unit-ish radii (built as sum of two
    constant-curvature blocks)."""
    n=p+q; d=np.eye(n)
    A=np.zeros((n,n)); A[:p,:p]=np.eye(p)
    B=np.zeros((n,n)); B[p:,p:]=np.eye(q)
    def cc(P): return np.einsum('ik,jl->ijkl',P,P)-np.einsum('il,jk->ijkl',P,P)
    # radii chosen so scalar curvatures balance -> Einstein; Weyl proj kills the rest anyway
    return cc(A)/max(p-1,1)+cc(B)/max(q-1,1)

def norm_weyl(Rt, basis, pos):
    M=from_tensor(Rt,pos); M=project(M,basis)
    return M/np.linalg.norm(M)

def crit_iterate(M0,c,basis,steps=4000,tol=1e-14):
    """Fixed-point / gradient ascent for Q(W)=lambda W on the unit sphere of Weyl."""
    M=M0.copy(); M/=np.linalg.norm(M)
    for it in range(steps):
        G=project(Q(M,c),basis)
        lam=np.sum(G*M)
        r=G-lam*M
        if np.linalg.norm(r)<tol: break
        M=M+0.15*r; M/=np.linalg.norm(M)
    G=project(Q(M,c),basis); lam=np.sum(G*M)
    return M, lam, np.linalg.norm(G-lam*M)

def diagnostics(M,c,pos,n,label,vmode='top'):
    W=to_tensor(M,pos,n)
    lam=np.sum(M*project(Q(M,c),BASIS[n]))
    Qm=Q(M,c)
    resid=np.linalg.norm(Qm-lam*M)
    K=np.zeros((n,n))
    for (a,b),k in pos.items():
        K[a,b]=M[k,k]; K[b,a]=M[k,k]
    t=np.sum(K**2)
    ev,evec=np.linalg.eigh(K)
    v = evec[:,-1] if vmode=='top' else (evec[:,0] if vmode=='bot' else vmode)
    if isinstance(vmode,np.ndarray): v=vmode/np.linalg.norm(vmode)
    muK=v@K@v
    # A^a, B^ab
    A=np.einsum('apaq->apq',W.transpose(0,1,2,3).reshape(n,n,n,n)) if False else None
    A=np.zeros((n,n,n)); B=np.zeros((n,n,n,n))
    for a in range(n):
        for b in range(n):
            B[a,b]=W[a,:,b,:]
        A[a]=W[a,:,a,:]
    # R_ab
    Rab=np.zeros((n,n))
    for (a,b),k in pos.items():
        r=np.sum(M[k,:]**2)-M[k,k]**2
        Rab[a,b]=r; Rab[b,a]=r
    # vertex equation check (claim 1)
    sh=sharp(M,c)
    v1=max(abs(K[a,b]**2+Rab[a,b]+sh[k,k]-lam*K[a,b]) for (a,b),k in pos.items())
    # sharp formula (claim 2 part 1)
    v2=0.0
    for (a,b),k in pos.items():
        pred=np.sum(A[a]*A[b])-np.trace(B[a,b]@B[a,b])
        v2=max(v2,abs(pred-sh[k,k]))
    # pairing
    G=np.einsum('a,apq->pq',v,A)
    Goff=G-np.diag(np.diag(G))
    dgerr=np.linalg.norm(np.diag(G)-muK*v)
    term_G=np.sum(G**2)
    term_R=v@Rab@v
    term_K=v@(K**2)@v
    term_B=sum(v[a]*v[b]*np.trace(B[a,b]@B[a,b]) for a in range(n) for b in range(n))
    bracket=term_K-term_B
    lhs=lam*muK; rhs=term_G+term_R+bracket
    # Laplacian split of the bracket
    Dt=np.array([np.sum(A[a]**2) for a in range(n)])
    diagpart=-np.sum(v**2*Dt)
    offpart=bracket-diagpart
    print(f"--- {label}  n={n} vmode={vmode if isinstance(vmode,str) else 'custom'}")
    print(f"    lambda={lam:.9f}  crit resid={resid:.3e}  t={t:.6f}  muK={muK:.9f}")
    print(f"    eig(K) min={ev[0]:.6f} max={ev[-1]:.6f}")
    print(f"    [C1] vertex-eq max err     = {v1:.3e}")
    print(f"    [C2] sharp-formula max err = {v2:.3e}")
    print(f"    [C2] diag(G)-muK*v         = {dgerr:.3e}")
    print(f"    [C2] pairing lhs={lhs:.9f} rhs={rhs:.9f} err={abs(lhs-rhs):.3e}")
    print(f"    muK^2={muK**2:.9f}   ||G_off||^2={np.sum(Goff**2):.9f}")
    print(f"    v'Rv={term_R:.9f}   bracket={bracket:.9f}  (diagpart={diagpart:.9f} offpart={offpart:.9f})")
    print(f"    lam*muK - muK^2 = {lhs-muK**2:+.9f}    [needs <=0 for lambda<=muK]")
    print(f"    lambda vs muK_max: lambda={lam:.6f} muK_max={ev[-1]:.6f} -> bound {'HOLDS' if lam<=ev[-1]+1e-9 else 'FAILS'}")
    return dict(lam=lam,muK=muK,ev=ev,termR=term_R,bracket=bracket,Goff=np.sum(Goff**2),
                diagpart=diagpart,offpart=offpart,t=t,K=K,W=W,M=M)

BASIS={}
def setup(n):
    b,pr,pos,N,c=weyl_basis(n)
    BASIS[n]=b
    return b,pr,pos,N,c

if __name__=='__main__':
    for m in (3,4):
        n=2*m
        b,pr,pos,N,c=setup(n)
        M=norm_weyl(fs_tensor(m),b,pos)
        # fix sign so lambda>0
        if np.sum(M*project(Q(M,c),b))<0: M=-M
        diagnostics(M,c,pos,n,f"CP^{m}",'top')
        diagnostics(M,c,pos,n,f"CP^{m}",'bot')
