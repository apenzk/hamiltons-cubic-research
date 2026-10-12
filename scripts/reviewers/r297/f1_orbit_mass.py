"""F1: is g_gamma the squared norm of the orbit-tangent vector, and is the total 4(n-1)?"""
import sys; sys.path.insert(0, 'scripts/reviewers/r297')
import numpy as np, core297 as C

def report(lbl, n, W, weylq=True):
    W = W / np.linalg.norm(W)
    lam, g_comm, tang = C.g_vector(n, W)
    g_T = C.g_vector_via_T(n, W)
    # orbit tangent from the coordinate basis, span comparison
    OT = C.orbit_tangent(n, W)
    U = C.rowspace(OT); V = C.rowspace(tang)
    cos = np.linalg.svd(U @ V.T, compute_uv=False) if U.size and V.size else np.array([])
    th = C.Pval(n, W)
    res = np.linalg.norm(C.Qmap(n, W) - th * W)
    D = float(g_comm[lam > 1e-9].sum())
    print(f"{lbl:26s} n={n:2d} dimWeyl-member={C.in_weyl(n,W):.1e} crit-res={res:.1e}")
    print(f"    max|g_comm - g_T|   = {np.abs(g_comm-g_T).max():.3e}")
    print(f"    sum g               = {g_comm.sum():.9f}   4(n-1) = {4*(n-1)}   diff {g_comm.sum()-4*(n-1):+.2e}")
    print(f"    Delta (lam>0)       = {D:.6f}    dim orbit={U.shape[0]:3d} dim span{{[ad v_d,W]}}={V.shape[0]:3d}"
          f"  min princ. cos={cos.min() if cos.size else float('nan'):.6f}")
    # is every orbit tangent vector orthogonal to W?
    print(f"    max |<[ad x,W],W>|  = {np.abs(np.einsum('kij,ij->k',OT,W)).max():.2e}")
    return g_comm.sum()

print("=== critical, Weyl ===")
for blocks in ([3,3],[3,5],[4,4]):
    W,n = C.sphere_product(blocks); report(f"S^{blocks[0]}xS^{blocks[1]}", n, W)
W,n = C.cpm(3); report("CP^3", n, W)
W,n = C.cpm(2); report("CP^2 (n=4)", n, W)
W,n = C.c5_blowup(); report("C_5 blow-up", n, W)

print("\n=== NON-critical, still Weyl ===")
rng = np.random.default_rng(297)
for n in (6, 8):
    B = C.weyl(n)
    for t in range(2):
        co = rng.normal(size=B.shape[0])
        W = np.tensordot(co, B, axes=([0],[0]))
        report(f"random Weyl_{n} #{t}", n, W)

print("\n=== NON-Weyl symmetric elements of Sym^2(Lambda^2) ===")
for n in (5, 6, 7):
    N = n*(n-1)//2
    for t in range(2):
        M = rng.normal(size=(N,N)); W = 0.5*(M+M.T)
        report(f"random Sym^2 n={n} #{t}", n, W)

print("\n=== the algebraic reason the total is constant: tr(X^#) = -||X||^2 ? ===")
for n in (5,6,7,8):
    B = C.weyl(n)
    co = rng.normal(size=B.shape[0]); W = np.tensordot(co, B, axes=([0],[0])); W/=np.linalg.norm(W)
    N = n*(n-1)//2
    M = rng.normal(size=(N,N)); X = 0.5*(M+M.T); X/=np.linalg.norm(X)
    print(f"  n={n}: Weyl tr(W^#)={np.trace(C.sharp(n,W)):+.9f}   nonWeyl tr(X^#)={np.trace(C.sharp(n,X)):+.9f}")
