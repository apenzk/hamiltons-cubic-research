"""Verify Li 2022 Theorem 1.8 on S^p x S^q, then read off p3(omega) for the Weyl part.

Thm 1.8: for Einstein (M_i, Ric = rho_i g_i), spec(Rring) = spec(Rring_1) U spec(Rring_2)
         U {0 with multiplicity n1*n2} U {-(n1 rho2 + n2 rho1)/(n1+n2), multiplicity 1}.
Sphere S^n(r) with curvature c=1/r^2: R = c (g o g)/... , Ric = c(n-1) g.
"""
import numpy as np, collections, itertools
def sphere_R(n,c):
    g=np.eye(n)
    return c*(np.einsum('ik,jl->ijkl',g,g)-np.einsum('il,jk->ijkl',g,g))
def block_product(R1,R2):
    n1,n2=R1.shape[0],R2.shape[0]; n=n1+n2; R=np.zeros((n,n,n,n))
    R[:n1,:n1,:n1,:n1]=R1; R[n1:,n1:,n1:,n1:]=R2; return R
def ring(R):
    n=R.shape[0]; idx=[(i,j) for i in range(n) for j in range(i,n)]
    def bs(i,j):
        h=np.zeros((n,n))
        if i==j: h[i,i]=1
        else: h[i,j]=h[j,i]=1/np.sqrt(2)
        return h
    B=[bs(i,j) for (i,j) in idx]; m=len(idx); Op=np.zeros((m,m))
    for a,h in enumerate(B):
        Rh=np.einsum('iklj,kl->ij',R,h)
        for b,hb in enumerate(B): Op[a,b]=np.sum(Rh*hb)
    gv=np.array([np.trace(b) for b in B]); gv/=np.linalg.norm(gv)
    P=np.eye(m)-np.outer(gv,gv); Bas=np.linalg.svd(P)[0][:,:m-1]
    return Bas.T@Op@Bas
def weyl_part(R):
    n=R.shape[0]; g=np.eye(n); Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/n*g
    KN=lambda A,B:(np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                   -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    return R-KN(E,g)/(n-2)-s/(2*n*(n-1))*KN(g,g)
print("=== Li Thm 1.8 on Einstein S^p x S^q (radii chosen so rho_1 = rho_2) ===")
for (p,q) in [(3,3),(4,4),(5,5),(6,6),(3,5),(4,8)]:
    c1=1.0; rho1=c1*(p-1); c2=rho1/(q-1); rho2=c2*(q-1)
    R=block_product(sphere_R(p,c1),sphere_R(q,c2)); n=p+q
    ev=np.sort(np.linalg.eigvalsh(ring(R)))
    ev1=np.sort(np.linalg.eigvalsh(ring(sphere_R(p,c1)))) if p>=3 else np.array([])
    ev2=np.sort(np.linalg.eigvalsh(ring(sphere_R(q,c2)))) if q>=3 else np.array([])
    extra=-(p*rho2+q*rho1)/(p+q)
    pred=np.sort(np.concatenate([ev1,ev2,np.zeros(p*q),[extra]]))
    ok=len(pred)==len(ev) and np.abs(pred-ev).max()<1e-9
    # now the Weyl part's second-kind cubic
    W=weyl_part(R); Rw=ring(W)
    M=np.array([[W[i,j,k,l] for (k,l) in itertools.combinations(range(n),2)] for (i,j) in itertools.combinations(range(n),2)])
    nm=np.linalg.norm(M)
    if nm>1e-12:
        Wn=W/nm; Rwn=ring(Wn); Mn=M/nm
        p3o=np.trace(Rwn@Rwn@Rwn); p3m=np.trace(Mn@Mn@Mn); th=1.5*p3m-0.5*p3o
        t0=np.sqrt(2*(n-1)*(n-2))/n
        print(f"S^{p}xS^{q}: Thm1.8 {'VERIFIED' if ok else 'FAILS'} (max dev {np.abs(pred-ev).max() if len(pred)==len(ev) else float('nan'):.1e}) | "
              f"p3(mu)={p3m:+.6f} p3(om)={p3o:+.6f} theta={th:+.6f} theta_0={t0:.6f} {'= theta_0' if abs(th-t0)<1e-9 else ''}")
    else:
        print(f"S^{p}xS^{q}: Thm1.8 {'VERIFIED' if ok else 'FAILS'} | Weyl part vanishes")
