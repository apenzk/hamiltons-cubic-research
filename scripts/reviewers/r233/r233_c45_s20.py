"""r233 claims 4 and 5: the S^2_0 restriction and p_2 = 3/4."""
import numpy as np, itertools, importlib.util as il, io, contextlib, sys
sys.path.insert(0, 'scripts/lib')
exec(open('scripts/reviewers/r233/r233_c2_signs.py').read().split('print("=== S^p')[0])
def load(path,name):
    sp=il.spec_from_file_location(name,path); m=il.module_from_spec(sp)
    with contextlib.redirect_stdout(io.StringIO()): sp.loader.exec_module(m)
    return m
sk  = load("scripts/runs/run_secondkind_sign.py","sk")
cat = load("scripts/runs/run_bispectral_catalogue.py","cat")

def ring_raw(W, order='iklj'):
    """Li's operator on FULL Sym^2 -- no projector, unlike run_secondkind_sign.ring."""
    n=W.shape[0]; idx=[(i,j) for i in range(n) for j in range(i,n)]
    def bs(i,j):
        h=np.zeros((n,n))
        if i==j: h[i,i]=1
        else: h[i,j]=h[j,i]=1/np.sqrt(2)
        return h
    B=[bs(i,j) for (i,j) in idx]; m=len(idx); Op=np.zeros((m,m))
    for a,h in enumerate(B):
        Wh=np.einsum(order+',kl->ij',W,h)
        for b,hb in enumerate(B): Op[a,b]=np.sum(Wh*hb)
    return Op, np.array([np.trace(bs(i,j)) for (i,j) in idx])/np.sqrt(n)

def unit4(W): return W/np.sqrt(np.einsum('ijkl,ijkl->',W,W))

pts = ([(f"S^{p}xS^{q}", unit4(cat.sphere_product(p,q))) for (p,q) in [(3,3),(4,4),(5,5),(6,6),(5,7),(4,8)]]
     + [("CP^2", unit4(cat.cpm(2))), ("CP^2 pad n=6", unit4(cat.cpm(2,6))), ("CP^3", unit4(cat.cpm(3))),
        ("CP^4", unit4(cat.cpm(4))), ("CP^2 pad n=12", unit4(cat.cpm(2,12)))]
     + [(f"S^{m}xS^{m}", unit4(cat.sphere_product(m,m))) for m in (7,8,12)])

print("=== CLAIM 4: drop-the-nearest-zero at every catalogued point ===")
print(f"{'point':16s} {'n':>3} {'|dropped|':>10} {'2nd smallest |w|':>17} {'#|w|<1e-9':>10} {'p_2(S^2_0)':>11} {'-min w':>9}")
for lbl,W in pts:
    n=W.shape[0]
    om=np.linalg.eigvalsh(sk.ring(W,'iklj'))
    z=int(np.argmin(np.abs(om))); dropped=om[z]
    rest=np.delete(om,z)
    print(f"{lbl:16s} {n:>3} {abs(dropped):>10.2e} {np.sort(np.abs(rest))[0]:>17.6f} "
          f"{int((np.abs(om)<1e-9).sum()):>10} {(rest**2).sum():>11.6f} {-rest.min():>9.6f}")

print("\n=== CLAIM 4: is the assert able to fire?  ring() already sandwiches with P = I - gg^T ===")
for lbl, R in [("round S^6 (Ric = 5g, NOT Ricci-flat)", R_sphere_product(6,0) if False else None)]:
    pass
def R_round(n):
    R=np.zeros((n,n,n,n))
    for i in range(n):
        for j in range(n):
            for k in range(n):
                for l in range(n): R[i,j,k,l]=(i==k)*(j==l)-(i==l)*(j==k)
    return R
rng=np.random.default_rng(233)
def sym_acr(n):
    A=rng.standard_normal((n,n,n,n))
    R=A-A.transpose(1,0,2,3); R=R-R.transpose(0,1,3,2); R=R+R.transpose(2,3,0,1)
    return R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
tests=[("round S^6 (Ric = 5g)",R_round(6)),("round S^12 (Ric = 11g)",R_round(12)),
       ("random algebraic curvature n=6",sym_acr(6)),("random algebraic curvature n=8",sym_acr(8))]
for lbl,R in tests:
    n=R.shape[0]
    ric=np.abs(np.einsum('ikjk->ij',R)).max()
    om=np.linalg.eigvalsh(sk.ring(R,'iklj'))
    z=int(np.argmin(np.abs(om)))
    fires = not (abs(om[z]) < 1e-9)
    Op,gv=ring_raw(R,'iklj')
    print(f"  {lbl:34s} n={n:2d} |Ric|={ric:8.3f}  min|eig of ring()|={abs(om[z]):.2e}  assert fires: {fires}")
    print(f"      but on the UNPROJECTED operator: |ring(g)| = {np.linalg.norm(Op@gv):.6f}  (= |Ric|/sqrt(n) up to sign)")

print("\n=== CLAIM 5: p_2 = 3/4, both index orders, both signs of W ===")
print("  (a) the two orders are related by W_ikjl = -W_iklj, so ring flips sign exactly:")
for lbl,W in pts[:4]:
    A=sk.ring(W,'iklj'); B=sk.ring(W,'ikjl')
    print(f"      {lbl:14s} |ring(iklj)+ring(ikjl)| = {np.abs(A+B).max():.2e}   ->  p_2 identical, p_3 negated")
print("  (b) p_2 is even in W, so 5ba3fbd cannot move it:")
for (p,q) in [(3,3),(4,4),(6,6),(5,7)]:
    n=p+q
    Wnew=unit4(cat.sphere_product(p,q)); Wold=-Wnew
    f=lambda W: (np.linalg.eigvalsh(sk.ring(W,'iklj'))**2).sum()
    g3=lambda W: (np.linalg.eigvalsh(sk.ring(W,'iklj'))**3).sum()
    print(f"      S^{p}xS^{q}: p_2(new)={f(Wnew):.9f} p_2(old)={f(Wold):.9f} | p_3(new)={g3(Wnew):+.6f} p_3(old)={g3(Wold):+.6f}")
print("  (c) on FULL Sym^2 p_2 = (3/4)|R|^2 for every algebraic curvature tensor;")
print("      on S^2_0 it needs Ricci-flatness.  a = <ghat,ring ghat>, v = P ring ghat:")
print(f"      {'tensor':34s} {'(3/4)|R|^2':>11} {'p_2 full':>10} {'p_2 S^2_0':>10} {'a^2+2|v|^2':>11}")
for lbl,R in tests+[("S^6xS^6 Weyl (Ricci-flat)",cat.sphere_product(6,6)),("CP^2 Weyl (Ricci-flat)",cat.cpm(2))]:
    n=R.shape[0]
    Op,gv=ring_raw(R,'iklj')
    full=(np.linalg.eigvalsh(Op)**2).sum()
    tgt=0.75*np.einsum('ijkl,ijkl->',R,R)
    om=np.linalg.eigvalsh(sk.ring(R,'iklj')); z=int(np.argmin(np.abs(om)))
    s20=(np.delete(om,z)**2).sum()
    a=gv@Op@gv; v=Op@gv-a*gv
    print(f"      {lbl:34s} {tgt:>11.6f} {full:>10.6f} {s20:>10.6f} {a**2+2*(v@v):>11.6f}")
