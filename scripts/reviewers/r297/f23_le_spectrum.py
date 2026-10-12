"""F2 and F3: L_e on the orbit tangent, and lambda_max(L_e | Weyl_n cap W-perp)."""
import sys; sys.path.insert(0, 'scripts/reviewers/r297')
import numpy as np, core297 as C

def analyse(lbl, n, W, full=True):
    W = W / np.linalg.norm(W)
    th = C.Pval(n, W); res = np.linalg.norm(C.Qmap(n, W) - th * W)
    D, tot, lam = C.Delta(n, W)
    OT = C.orbit_tangent(n, W); U = C.rowspace(OT)          # (k, N*N) orthonormal
    k = U.shape[0]
    # F2: is every orbit direction an eigenvector of L_e with eigenvalue 1/2?
    Ub = U.reshape(k, W.shape[0], W.shape[0])
    img = np.array([C.L_W(n, W, Ub[i]) for i in range(k)]) / th
    Gr = np.einsum('kij,lij->kl', img, Ub)                  # <L_e u_k, u_l>
    resid = np.linalg.norm(img.reshape(k, -1) - 0.5 * U, axis=1)
    ev = np.linalg.eigvalsh(0.5 * (Gr + Gr.T))
    print(f"{lbl:24s} n={n:2d} theta={th:9.6f} crit-res={res:.1e} Delta={D:8.4f}/{tot:.0f} dim orbit={k:3d}")
    print(f"    L_e on orbit tangent: eig in [{ev.min():.9f}, {ev.max():.9f}]  "
          f"max||L_e u - u/2|| = {resid.max():.2e}")
    if full:
        sp, M, w, Uc = C.le_spectrum_perp(n, W, th)
        above = sp[sp > 0.5 + 1e-8]
        print(f"    spec(L_e | Weyl cap W-perp): lambda_max = {sp.max():.9f}   "
              f"#{{lam > 1/2}} = {len(above)}  mult(1/2) = {int(np.sum(np.abs(sp-0.5)<1e-8))}")
        print(f"    ==> second-order condition (Lemma 24) {'FAILS' if sp.max()>0.5+1e-8 else 'holds'}"
              f"   (excess = {sp.max()-0.5:+.9f})")
    return th, D

print("=== catalogued critical points ===")
for blocks in ([3,5],[4,4],[3,3]):
    W,n = C.sphere_product(blocks); analyse(f"S^{blocks[0]}xS^{blocks[1]}", n, W)
W,n = C.cpm(2); analyse("CP^2 (n=4)", n, W)
W,n = C.cpm(3); analyse("CP^3 (n=6)", n, W)
W,n = C.c5_blowup(); analyse("C_5 blow-up (n=10)", n, W)

print("\n=== F2 stress: does it need criticality?  does it need Weyl? ===")
rng = np.random.default_rng(2970)
for n in (6,):
    B = C.weyl(n)
    for t in range(2):
        co = rng.normal(size=B.shape[0]); W = np.tensordot(co, B, axes=([0],[0]))
        analyse(f"random Weyl_{n} (noncrit) #{t}", n, W, full=False)
    N = n*(n-1)//2
    for t in range(1):
        Mx = rng.normal(size=(N,N)); W = 0.5*(Mx+Mx.T)
        analyse(f"random Sym^2 n={n} #{t}", n, W, full=False)
