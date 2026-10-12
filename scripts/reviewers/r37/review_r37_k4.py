"""K4: attack the Schur argument for sharp_bilin(I_p, .).
  (1) numerical O(p)xO(q)-equivariance, including det=-1 components
  (2) does it map Weyl_n into Weyl_n?
  (3) is it self-adjoint?
  (4) multiplicity of the relevant type in the AMBIENT space, if Weyl is not preserved
"""
import sys; sys.path.insert(0, 'scripts/lib')
import numpy as np
from scipy.linalg import block_diag
from review_r37_core import *

rng=np.random.default_rng(37)
print("(1) equivariance of V -> sharp_bilin(I_p,V) under O(p)xO(q), and invariance of I_p")
for (p,q) in [(3,4),(4,4),(4,5),(5,5),(3,5)]:
    n=p+q; A=struct_A(n); N=A.shape[0]; Ip=I_block(p,q,'p')
    worst_eq=0.0; worst_Ip=0.0; worst_full=0.0
    for dp in (1,-1):
        for dq in (1,-1):
            g=block_diag(rand_O(p,rng,det=dp), rand_O(q,rng,det=dq))
            rho=lambda2(g)
            worst_Ip=max(worst_Ip, np.linalg.norm(rho@Ip@rho.T-Ip))
            R=rng.normal(size=(N,N)); V=R+R.T
            lhs=sharp_bilin(Ip, rho@V@rho.T, A)
            rhs=rho@sharp_bilin(Ip,V,A)@rho.T
            worst_eq=max(worst_eq, np.linalg.norm(lhs-rhs)/np.linalg.norm(rhs))
    # also: full O(n)-equivariance of the bilinear map itself
    for _ in range(3):
        g=rand_O(n,rng); rho=lambda2(g)
        R=rng.normal(size=(N,N)); V=R+R.T; R2=rng.normal(size=(N,N)); U=R2+R2.T
        lhs=sharp_bilin(rho@U@rho.T, rho@V@rho.T, A)
        rhs=rho@sharp_bilin(U,V,A)@rho.T
        worst_full=max(worst_full, np.linalg.norm(lhs-rhs)/np.linalg.norm(rhs))
    print(f"   ({p},{q}): |rho I_p rho^T - I_p| {worst_Ip:.1e}   equivariance rel err {worst_eq:.1e}   full O(n) bilinear equivariance {worst_full:.1e}", flush=True)

print()
print("(2) does V -> sharp_bilin(I_p,V) map Weyl_n into Weyl_n?  (V random in Weyl_n)")
print("    also reported: is I_p an algebraic curvature op (Bianchi)? its Ricci?")
for (p,q) in [(3,4),(4,4),(4,5),(3,5),(5,5)]:
    n=p+q; A=struct_A(n); B=weyl_basis(n); N=A.shape[0]; Ip=I_block(p,q,'p')
    V=expand(B, rng.normal(size=B.shape[0]))
    S=sharp_bilin(Ip,V,A)
    proj=expand(B, coords(B,S))
    out=np.linalg.norm(S-proj)/np.linalg.norm(S)
    # split the leak: Bianchi part vs Ricci part
    P,idx=pair_index(n)
    def bianchi_norm(M):
        from itertools import combinations
        return np.sqrt(sum((tensor_entry(M,idx,i,j,k,l)-tensor_entry(M,idx,i,k,j,l)+tensor_entry(M,idx,i,l,j,k))**2
                       for (i,j,k,l) in combinations(range(n),4)))
    def ric_norm(M):
        return np.sqrt(sum(sum(tensor_entry(M,idx,i,j,k,j) for j in range(n))**2 for i in range(n) for k in range(n)))
    print(f"   ({p},{q}): leak out of Weyl_n {out:.2e}   Bianchi(S) {bianchi_norm(S):.2e}  Ric(S) {ric_norm(S):.2e}  |S| {np.linalg.norm(S):.2f}")
    print(f"            I_p: Bianchi {bianchi_norm(Ip):.2e}  Ric {ric_norm(Ip):.2e}   (I_p in Weyl_n? {np.linalg.norm(Ip-expand(B,coords(B,Ip)))/np.linalg.norm(Ip):.2e} rel)", flush=True)

print()
print("(3) self-adjointness of sharp_bilin(I_p,.) on Sym^2(Lambda^2)")
for (p,q) in [(3,4),(4,4),(4,5)]:
    n=p+q; A=struct_A(n); N=A.shape[0]; Ip=I_block(p,q,'p')
    w=0.0
    for _ in range(5):
        R=rng.normal(size=(N,N)); U=R+R.T; R=rng.normal(size=(N,N)); V=R+R.T
        w=max(w, abs(ip(sharp_bilin(Ip,U,A),V)-ip(U,sharp_bilin(Ip,V,A)))/abs(ip(U,V)+1e-30))
    print(f"   ({p},{q}): max |<sb(Ip,U),V>-<U,sb(Ip,V)>|/|<U,V>| = {w:.1e}")
