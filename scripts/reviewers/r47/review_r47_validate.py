import numpy as np, time
from review_r47_core import *

rng = np.random.default_rng(47)
print("=== gate 1: dim Weyl_n ===")
for n in (4,5,6,7,8):
    g = Geom(n)
    Bas = g.weyl_basis()
    th = n*(n+1)*(n+2)*(n-3)//12
    print(f" n={n}: dim={Bas.shape[0]} theory={th} ok={Bas.shape[0]==th}")

print("=== gate 2: Id^# = (n-2) Id, Q(Id)=(n-1)Id, kappa ===")
for n in (4,6,8):
    g = Geom(n); I = np.eye(g.N)
    s = g.sharp(I); print(f" n={n}: max|Id^#-(n-2)Id|={np.abs(s-(n-2)*I).max():.2e}",
                          f" max|Q(Id)-(n-1)Id|={np.abs(g.Q(I)-(n-1)*I).max():.2e}")
    st = struct_sums(g, -I)   # all of Lambda^2 as m
    print(f"        total sum c^2 = {st['total']:.6f}  kappa*N = {2*(n-2)*g.N}")

print("=== gate 3: trilinear symmetry ===")
for n in (5,6):
    g = Geom(n)
    for _ in range(3):
        Xs = [rng.normal(size=(g.N,g.N)) for _ in range(3)]
        Xs = [(x+x.T)/2 for x in Xs]
        X,Y,Z = Xs
        a = (g.B(X,Y)*Z).sum(); b = (X*g.B(Y,Z)).sum(); c=(g.B(X,Z)*Y).sum()
        print(f" n={n}: |<B(X,Y),Z>-<X,B(Y,Z)>|={abs(a-b):.2e} |..-<B(X,Z),Y>|={abs(a-c):.2e}")

print("=== gate 4: sphere products are critical, theta_0 ===")
for (p,q) in ((3,3),(4,4),(3,5),(5,5),(6,6)):
    n=p+q; g=Geom(n); W=sphere_product(g,p,q)
    th,res = crit_residual(g,W)
    ric = np.abs(g.ricci(W)).max(); bi = np.abs(g.bianchi(W)).max()
    print(f" S^{p}xS^{q} n={n}: theta={th:.12f} theta_0={theta0(n):.12f} res={res:.2e} |Ric|={ric:.2e} |Bianchi|={bi:.2e}")

print("=== gate 5: L_e W = W, tr(L_e)=0 on Weyl ===")
for (p,q) in ((3,3),(4,4)):
    n=p+q; g=Geom(n); W=sphere_product(g,p,q); th,_=crit_residual(g,W); e=W/th
    print(f" S^{p}xS^{q}: |L_e W - W| = {np.linalg.norm(g.B(e,W)-W):.2e}")
    Bas = g.weyl_basis()
    L = np.array([[ (g.B(e,V)*U).sum() for V in Bas] for U in Bas])
    print(f"   trace L_e on Weyl_{n} = {np.trace(L):.2e}   sym err={np.abs(L-L.T).max():.2e}")
    ev = np.linalg.eigvalsh((L+L.T)/2)
    print(f"   eig(1/2) count = {int(np.sum(np.abs(ev-0.5)<1e-8))} ")
