"""F3: can Delta ever certify failure of the second-order condition?

Tests, in order of severity:
 (a) at every critical point: orbit tangent sits at exactly 1/2, and P is EXACTLY
     constant along the orbit -- so no variational statement of ANY order can be
     violated by the directions Delta measures.
 (b) the third-order (fusion-rule) condition on the SAME subspace, which is the one
     place a "version on a subspace" could bite: T(z,z,z) on the orbit tangent.
 (c) does Delta > 0 correlate with, or cause, mult(1/2)?  ("piles directions up")
 (d) the sweep: solve criticality from many starts and ask for a point with
     Delta > 0 and lambda_max(L_e|e-perp) <= 1/2.
"""
import sys, numpy as np
sys.path.insert(0, 'scripts/reviewers/r298')
import r298_core as C
from scipy.linalg import expm
from scipy.optimize import least_squares

def c5(sizes=(2,)*5, diag=4.0, adjv=-2.0, nonadj=1.0):
    k=len(sizes); n=sum(sizes); P=C.pairs(n)
    G=[[1 if (abs(a-b)%k in (1,k-1)) else 0 for b in range(k)] for a in range(k)]
    lab=[]
    for bi,b in enumerate(sizes): lab+=[bi]*b
    W=np.zeros((len(P),len(P)))
    for a,(i,j) in enumerate(P):
        A_,B_=lab[i],lab[j]
        W[a,a]=diag if A_==B_ else (adjv if G[A_][B_] else nonadj)
    return W/np.linalg.norm(W), n

def ortho_basis(V, tol=1e-9):
    F=V.reshape(V.shape[0],-1)
    u,s,vt=np.linalg.svd(F,full_matrices=False)
    r=int((s>tol*max(1.0,s[0])).sum())
    return vt[:r]

def full_audit(n, W, lbl, B=None):
    W=W/np.linalg.norm(W)
    B=C.weyl_basis(n) if B is None else B
    th=float(np.sum(W*C.Qf(n,W)))
    lam=np.linalg.eigvalsh(W)
    D,tot,_=C.Delta(n,W)
    # L_e on Weyl_n
    out=np.array([C.circ_f(n,W,X) for X in B])/th
    M=np.einsum('kij,lij->kl',out,B); M=0.5*(M+M.T)
    w=np.einsum('kij,ij->k',B,W)
    # orthonormal basis of e-perp inside Weyl_n
    Pm=np.eye(len(B))-np.outer(w,w)/(w@w)
    u,s,vt=np.linalg.svd(Pm); E=vt[:len(B)-1]
    Mp=E@M@E.T; ev=np.linalg.eigvalsh(0.5*(Mp+Mp.T))
    lmax=ev[-1]; mult_half=int(np.sum(np.abs(ev-0.5)<1e-8))
    OT=C.orbit_tangent(n,W); ob=ortho_basis(OT)
    dimO=ob.shape[0]
    dev=0.0
    for z in ob.reshape(dimO,W.shape[0],W.shape[0]):
        dev=max(dev,np.linalg.norm(C.circ_f(n,W,z)/th-0.5*z))
    print(f"  {lbl:26s} n={n:2d} th={th:+.6f} dimm={int((lam<-1e-9).sum()):3d} "
          f"ker={int((abs(lam)<=1e-9).sum()):3d} Delta={D:8.4f}/{tot:5.1f} dimO={dimO:3d} "
          f"mult(1/2)={mult_half:3d} lmax(e-perp)={lmax:+.8f} orb_dev={dev:.1e}")
    return dict(theta=th,Delta=D,dimO=dimO,mult=mult_half,lmax=lmax,dimm=int((lam<-1e-9).sum()))

pts=[]
print("=== (a)(c) catalogued critical points: Delta, dim orbit, mult(1/2), lambda_max ===")
for blocks in ([3,3],[3,5],[5,5]):
    n=sum(blocks); pts.append(full_audit(n,C.sphere_product(blocks),"S^"+"xS^".join(map(str,blocks))))
for m in (2,3,4): pts.append(full_audit(2*m,C.cpm(m),f"CP^{m}"))
pts.append(full_audit(8,C.pad(4,8,C.cpm(2)),"CP^2 padded n=8"))
Wc,nc=c5(); pts.append(full_audit(nc,Wc,"C_5 blow-up (Delta=12)"))

print("\n=== (a) P is EXACTLY constant on the orbit: P(g.W) - P(W) at random g in SO(n) ===")
rng=np.random.default_rng(3)
for n,W,lbl in ((6,C.sphere_product([3,3]),"S^3xS^3"),(10,Wc,"C_5 blow-up")):
    N=n*(n-1)//2
    worst=0.0
    for t in range(5):
        A=rng.normal(size=(n,n)); A=A-A.T; g=expm(A)
        # Lambda^2(g) in the phi basis
        ph=C.phi(n); L=np.einsum('aij,ik,jl,bkl->ab',ph,g,g,ph)*0.5
        Wg=L@W@L.T
        worst=max(worst,abs(C.Pval(n,Wg)/np.linalg.norm(Wg)**3-C.Pval(n,W)/np.linalg.norm(W)**3))
    print(f"  {lbl:16s} max |P(g.W)-P(W)| over 5 random g = {worst:.3e}")

print("\n=== (b) third order on the orbit tangent: T(z,z,z) = <z o z, z> ===")
for n,W,lbl in ((6,C.sphere_product([3,3]),"S^3xS^3"),(6,C.cpm(3),"CP^3"),(10,Wc,"C_5 blow-up")):
    W=W/np.linalg.norm(W)
    ob=ortho_basis(C.orbit_tangent(n,W)); r=ob.shape[0]
    zs=ob.reshape(r,W.shape[0],W.shape[0])
    worst=0.0
    for t in range(30):
        co=rng.normal(size=r); z=np.einsum('k,kij->ij',co,zs); z/=np.linalg.norm(z)
        worst=max(worst,abs(float(np.sum(C.circ_f(n,z,z)*z))))
    print(f"  {lbl:16s} dim orbit {r:3d}   max |T(z,z,z)| over 30 random orbit z = {worst:.3e}")
