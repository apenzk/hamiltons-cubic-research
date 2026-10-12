"""Reviewer 290 -- independent route. Nothing imported from scripts/."""
import numpy as np, itertools
from itertools import combinations

def kn(A,B):
    return (np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
            -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))

def weyl_part(R,n):
    g=np.eye(n); Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric)
    E=Ric-s/n*g
    return R-kn(E,g)/(n-2)-s/(2*n*(n-1))*kn(g,g)

def sym_curv(A,n):
    """symmetrise an arbitrary 4-tensor into an algebraic curvature tensor (Bianchi)"""
    R=A-A.transpose(1,0,2,3); R=R-R.transpose(0,1,3,2); R=R+R.transpose(2,3,0,1)
    R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
    return R

def Mmat(W,n):
    idx=list(combinations(range(n),2))
    return np.array([[W[i,j,k,l] for (k,l) in idx] for (i,j) in idx]), idx

def ring_basis(n):
    """orthonormal basis of S^2_0: first C(n,2) are phi_ij=(e_i o e_j)/sqrt2, then n-1 traceless diagonals."""
    B=[]; lab=[]
    for (i,j) in combinations(range(n),2):
        h=np.zeros((n,n)); h[i,j]=h[j,i]=1/np.sqrt(2); B.append(h); lab.append(('phi',i,j))
    # traceless diagonal: Gram-Schmidt on e_kk - e_{k+1,k+1}
    D=[]
    for k in range(n-1):
        d=np.zeros(n); d[:k+1]=1.0; d[k+1]=-(k+1.0)
        d/=np.linalg.norm(d)
        D.append(d)
    D=np.array(D)
    # verify orthonormal
    assert np.allclose(D@D.T,np.eye(n-1),atol=1e-12), D@D.T
    for k in range(n-1):
        B.append(np.diag(D[k])); lab.append(('psi',k,k))
    return B,lab

def ring_op(W,n,order='iklj'):
    B,lab=ring_basis(n); m=len(B)
    Op=np.zeros((m,m))
    for a,h in enumerate(B):
        Wh=np.einsum(order+',kl->ij',W,h)
        for b,hb in enumerate(B): Op[a,b]=np.sum(Wh*hb)
    return Op,B,lab

def theta_direct(W):
    al=np.einsum('tpsq,tpkl,sqkl->',W,W,W)
    be=np.einsum('tspq,tjpl,sjql->',W,W,W)
    return al/8+be/2, al, be

# ---------- test points ----------
def cp2(n):
    J=np.zeros((n,n)); J[0,1]=1;J[1,0]=-1;J[2,3]=1;J[3,2]=-1   # J[i,k]=<Je_i,e_k>
    d=np.eye(n)
    R=(np.einsum('ik,jl->ijkl',d,d)-np.einsum('il,jk->ijkl',d,d)
       +np.einsum('ik,jl->ijkl',J,J)-np.einsum('il,jk->ijkl',J,J)
       +2*np.einsum('ij,kl->ijkl',J,J))
    mask=np.zeros(n); mask[:4]=1
    R=R*np.einsum('i,j,k,l->ijkl',mask,mask,mask,mask)
    return R

def prod_sphere(p,q,n=None):
    n=p+q
    c1=1.0; c2=(p-1)/(q-1)   # Einstein
    d=np.eye(n)
    g1=np.zeros((n,n)); g1[:p,:p]=np.eye(p)
    g2=np.zeros((n,n)); g2[p:,p:]=np.eye(q)
    R=c1/2*kn(g1,g1)+c2/2*kn(g2,g2)
    return R

def prep(R,n,padded_weyl_first=None):
    if padded_weyl_first is not None:
        W=padded_weyl_first
    else:
        W=weyl_part(R,n)
    M,idx=Mmat(W,n); f=np.linalg.norm(M)
    W=W/f; M=M/f
    return W,M,idx

def report(name,W,n):
    M,idx=Mmat(W,n)
    mu=np.linalg.eigvalsh(M)
    Ring,B,lab=ring_op(W,n)
    om=np.linalg.eigvalsh(Ring)
    th,al,be=theta_direct(W)
    bi=1.5*np.sum(mu**3)-0.5*np.sum(om**3)
    print(f"{name:22s} n={n:2d} |M|={np.linalg.norm(M):.6f} sum mu={mu.sum():+.2e} sum mu2={np.sum(mu**2):.6f} "
          f"sum om={om.sum():+.2e} sum om2={np.sum(om**2):.6f}")
    print(f"{'':22s} theta_direct={th:.9f}  bispectral={bi:.9f}  diff={th-bi:+.2e}")
    return M,mu,Ring,om,th,B,lab,idx

np.set_printoptions(precision=6,suppress=True)
for n in [4,5,6,8,12]:
    R=cp2(n); W4=weyl_part(cp2(4),4)
    Wpad=np.zeros((n,)*4); Wpad[:4,:4,:4,:4]=W4
    M,idx=Mmat(Wpad,n); Wpad=Wpad/np.linalg.norm(M)
    report(f"padded CP2",Wpad,n)
for (p,q) in [(4,4),(6,6),(5,7)]:
    n=p+q; R=prod_sphere(p,q); W=weyl_part(R,n)
    M,idx=Mmat(W,n); W=W/np.linalg.norm(M)
    report(f"S^{p} x S^{q}",W,n)
    print("   theta_0 =",np.sqrt(2*(n-1)*(n-2)/n**2))

print("\n================ C2/C3/C4/C5 ================")
def rot_tensor(W,O):
    return np.einsum('ai,bj,ck,dl,abcd->ijkl',O,O,O,O,W,optimize=True)

def analyse(W,n,psi_diag=True,verbose=True,name=""):
    M,idx=Mmat(W,n); mu=np.linalg.eigvalsh(M)
    Ring,B,lab=ring_op(W,n); om=np.linalg.eigvalsh(Ring)
    th,_,_=theta_direct(W)
    K=np.diag(M).copy()
    N2=len(idx)
    d=np.diag(Ring)[N2:].copy()
    if psi_diag:
        blk=Ring[N2:,N2:]
        d=np.linalg.eigvalsh(blk)
    Kp=np.concatenate([np.diag(Ring)[:N2],d])
    # C1 check
    c1a=np.max(np.abs(np.diag(M)-np.array([W[i,j,i,j] for (i,j) in idx])))
    c1b=np.max(np.abs(np.diag(Ring)[:N2]-np.array([W[i,j,i,j] for (i,j) in idx])))
    Mp=mu.max(); m_=-om.min()
    p2K=np.sum(K**2); p3K=np.sum(K**3); p2Kp=np.sum(Kp**2); p3Kp=np.sum(Kp**3)
    bnd=1.5*(p3K+3*Mp*(1-p2K))-0.5*(p3Kp+3*m_*(p2Kp-3))
    pen=4.5*Mp*(1-p2K)+1.5*m_*(3-p2Kp)
    S1=(p3K+3*Mp*(1-p2K))-np.sum(mu**3)
    S2=np.sum(om**3)-(p3Kp+3*m_*(p2Kp-3))
    if verbose:
        print(f"{name:18s} n={n:2d} theta={th:.6f} Mp={Mp:.6f} m={m_:.6f}")
        print(f"   |M_off|^2={1-p2K:.6f}  |Ring_off|^2={3-p2Kp:.6f}   (psi block {'diagonalised' if psi_diag else 'as-is'})")
        print(f"   C1 residuals: M diag {c1a:.1e}, Ring phi-diag {c1b:.1e}")
        print(f"   bound={bnd:.6f}   bound-theta={bnd-th:.6f}   claimed slack (penalty terms)={pen:.6f}")
        print(f"   S1={S1:.6f} (>=0?) S2={S2:.6f} (>=0?)  1.5*S1+0.5*S2={1.5*S1+0.5*S2:.6f}")
        print(f"   dropped p3 terms: 1.5*(p3K-p3mu)={1.5*(p3K-np.sum(mu**3)):+.6f}  0.5*(p3om-p3Kp)={0.5*(np.sum(om**3)-p3Kp):+.6f}")
        # majorization check
        ok1=majorized(K,mu); ok2=majorized(Kp,om)
        print(f"   majorization K<mu: {ok1}   K'<om: {ok2}")
    return dict(th=th,bnd=bnd,pen=pen,S1=S1,S2=S2,offM=1-p2K,offR=3-p2Kp,Mp=Mp,m=m_)

def majorized(a,b,tol=1e-9):
    a=np.sort(a)[::-1]; b=np.sort(b)[::-1]
    if len(a)!=len(b): return f"LENGTH MISMATCH {len(a)} vs {len(b)}"
    cs=np.cumsum(a)-np.cumsum(b)
    return bool(np.all(cs<=tol) and abs(cs[-1])<tol)

for n in [4,6,8,12,16]:
    W4=weyl_part(cp2(4),4); Wp=np.zeros((n,)*4); Wp[:4,:4,:4,:4]=W4
    M,_=Mmat(Wp,n); Wp=Wp/np.linalg.norm(M)
    analyse(Wp,n,True,name="padded CP2")
for (p,q) in [(4,4),(6,6),(5,7)]:
    n=p+q; W=weyl_part(prod_sphere(p,q),n); M,_=Mmat(W,n); W=W/np.linalg.norm(M)
    analyse(W,n,True,name=f"S^{p}xS^{q}")
