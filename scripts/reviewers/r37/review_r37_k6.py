"""K6: does the chain really collapse to one grant?
  (a) Lemma A: sharp_bilin(I_n,V) = -V for V in Weyl_n
  (b) sharp_bilin(I_q,V) on the (pp,mix) block -- is the 'grading' companion free?
  (c) reassemble L_e V from the three pieces and check it lands on zero
  (d) the X_q (x) R^p companion is the p<->q relabelling, nothing new
  (e) dimension-uniqueness: is X(p)q a subset sum of the other block pieces?
"""
import sys; sys.path.insert(0, 'scripts/lib')
import numpy as np, sympy as sp
from review_r37_core import *
from review_r37_k1 import mask_ppmix, support_in_weyl

print("(a) Lemma A: sharp_bilin(I_n,V) = -V on Weyl_n")
rng=np.random.default_rng(6)
for n in (5,6,7,8,9,10):
    A=struct_A(n); B=weyl_basis(n)
    V=expand(B, rng.normal(size=B.shape[0]))
    S=sharp_bilin(np.eye(A.shape[0]), V, A)
    print(f"   n={n}: |sb(I_n,V)+V|/|V| = {np.linalg.norm(S+V)/np.linalg.norm(V):.2e}")

print()
print("(b,c) pieces of L_e on the (pp,mix)-supported subspace of Weyl_n, and reassembly")
for (p,q) in [(3,4),(4,4),(4,5),(3,5),(5,5),(3,6)]:
    n=p+q; A=struct_A(n); B=weyl_basis(n); N=A.shape[0]
    W=W_pq(p,q); theta=ip(Qop(W,A),W)/ip(W,W); e=W/theta
    ev=np.diag(e); k=kinds(p,q)
    Aval=ev[k==0][0]; eta=ev[k==1][0]; Bval=ev[k==2][0]
    mask=mask_ppmix(p,q); Bs,_=support_in_weyl(B,mask)
    V=expand(Bs, rng.normal(size=Bs.shape[0]))
    nv=np.linalg.norm(V)
    jord=0.5*(e@V+V@e)
    cj=ip(jord,V)/ip(V,V); rj=np.linalg.norm(jord-cj*V)/nv
    Sp=sharp_bilin(I_block(p,q,'p'),V,A); cp=ip(Sp,V)/ip(V,V); rp=np.linalg.norm(Sp-cp*V)/nv
    Sq=sharp_bilin(I_block(p,q,'q'),V,A); cq=ip(Sq,V)/ip(V,V); rq=np.linalg.norm(Sq-cq*V)/nv
    Sn=sharp_bilin(np.eye(N),V,A); cn=ip(Sn,V)/ip(V,V); rn=np.linalg.norm(Sn-cn*V)/nv
    total=cj+eta*cn+(Aval-eta)*cp+(Bval-eta)*cq
    Le=circ(e,V,A)
    print(f"  ({p},{q}): e-values A={Aval:.6f} eta={eta:.6f} B={Bval:.6f}   half(eV+Ve)={cj:+.6f}(r {rj:.0e})  sb(I_n)={cn:+.6f}(r {rn:.0e})  sb(I_p)={cp:+.6f}(r {rp:.0e})  sb(I_q)={cq:+.6f}(r {rq:.0e})")
    print(f"           reassembled coefficient {total:+.3e}   direct |L_e V|/|V| {np.linalg.norm(Le)/nv:.2e}   check 1/2(A+eta) = {0.5*(Aval+eta):.6f}", flush=True)

print()
print("(e) symbolic: is X(p)q a subset sum of {C(p,3)q, X(p)q, pq}?")
p=sp.symbols('p', positive=True, integer=True)
X=p*(p**2-4)/3; L3=p*(p-1)*(p-2)/6; Vv=p
print("   C(p,3)+p = X(p)? ->", sp.solve(sp.Eq(L3+Vv, X), p))
print("   C(p,3)   = X(p)? ->", sp.solve(sp.Eq(L3, X), p))
print("   p        = X(p)? ->", sp.solve(sp.Eq(Vv, X), p))
print("   total check C(p,3)+X(p)+p =", sp.simplify(L3+X+Vv), " vs C(p,2)*p =", sp.simplify(p*(p-1)/2*p))
