import numpy as np, core, fam
np.set_printoptions(precision=6, suppress=True)

def report(name, n, W, wl):
    W = W/np.linalg.norm(W)
    d = wl.dist(W)
    res, th = fam.crit_res(W, wl.c)
    ev, V = np.linalg.eigh(W)
    lmin, lmax = ev[0], ev[-1]
    slack = lmin + (n-2)*lmax - th
    # D(v) for v in E_min via structure constants in the eigenbasis
    tol = 1e-8*max(1.0, abs(ev).max())
    mmask = np.abs(ev-lmin) < tol
    idx = np.where(mmask)[0]
    Ds=[]
    C = wl.c
    for t in idx[:min(len(idx),4)]:
        v = V[:,t]
        Cv = np.einsum('k,kab->ab', v, C)
        Cve = V.T @ Cv @ V
        Lam = np.outer(ev,ev) - lmin*lmax
        Ds.append(0.5*float(np.sum(Lam*Cve**2)))
    Ds=np.array(Ds)
    print(f"{name:34s} n={n:2d} dW={d:.2e} res={res:.2e} th={th:+.6f} "
          f"lmin={lmin:+.6f} lmax={lmax:+.6f} slack={slack:+.9f} "
          f"D={Ds.min():+.3e}..{Ds.max():+.3e} D/|lmin|-slack={ (Ds.mean()/abs(lmin)-slack) if lmin<0 else float('nan'):+.2e}")
    return dict(name=name,n=n,dW=d,res=res,th=th,lmin=lmin,lmax=lmax,slack=slack,D=Ds)

for n in [5,6,8,10,12]:
    wl = core.Weyl(n)
    print(f"--- n={n}  N={wl.N} dimWeyl={wl.dim()} ---")
    # sphere products
    for p in range(2, n//2+1):
        q=n-p
        gens = fam.so_block(n, list(range(p))) + fam.so_block(n, list(range(p,n)))
        if not gens: continue
        W = fam.W_from_subalgebra(n, gens, wl)
        report(f"S^{p}xS^{q} (so({p})+so({q}))", n, W, wl)
    if n%2==0:
        W = fam.W_from_subalgebra(n, fam.u_m(n), wl); report("u(n/2)  [CP^{n/2}]", n, W, wl)
    W = fam.W_from_subalgebra(n, fam.torus(n), wl); report("maximal torus so(2)^k", n, W, wl)
    if n==8:
        W = fam.W_from_subalgebra(8, fam.ad_su3_in_so8(), wl); report("ad(su(3)) in so(8)", 8, W, wl)
    # padded CP^2
    W = fam.pad(fam.W_cp2(), n); report("padded W_CP2", n, W, wl)
    # diagonal Weyl: random hollow zero-row-sum
    rng=np.random.default_rng(7)
    A=rng.normal(size=(n,n)); A=(A+A.T)/2; np.fill_diagonal(A,0)
    # project onto zero-row-sum hollow symmetric
    for _ in range(200):
        r=A.sum(axis=1); A = A - (np.add.outer(r,r))/(n-2) + r.sum()/((n-1)*(n-2)); np.fill_diagonal(A,0)
    report("random diagonal Weyl", n, fam.diagonal_weyl(n,A), wl)

print("--- n=4 control ---")
wl4=core.Weyl(4)
report("W_CP2 (n=4)", 4, fam.W_cp2(), wl4)
gens=fam.so_block(4,[0,1])+fam.so_block(4,[2,3])
report("so(2)+so(2) (n=4)", 4, fam.W_from_subalgebra(4,gens,wl4), wl4)
