"""F1: is g_gamma the squared norm of the orbit-tangent vector in direction v_gamma,
and is sum_gamma g_gamma = 4(n-1) on Weyl_n?  Tested at critical AND non-critical W,
inside AND outside Weyl_n."""
import sys, numpy as np
sys.path.insert(0, 'scripts/reviewers/r298')
import r298_core as C

def report(n, W, lbl):
    W = W / np.linalg.norm(W)
    lam, V = np.linalg.eigh(W)
    _, g = C.g_vector(n, W)
    # orbit tangent in the direction of each EIGENVECTOR v_gamma of W
    OT = C.orbit_tangent(n, W, basis=V.T)          # row gamma = [ad(v_gamma), W]
    nrm = np.einsum('kij,kij->k', OT, OT)          # Frobenius squared
    th = float(np.sum(W * C.Qop(n, W)))
    res = np.linalg.norm(C.project_weyl(n, C.Qop(n, W)) - th * W)
    inW = np.linalg.norm(W - C.project_weyl(n, W))
    print(f"  {lbl:26s} n={n:2d} theta={th:+9.6f} crit_res={res:8.2e} offWeyl={inW:8.2e}")
    print(f"     max|g - ||[ad(v),W]||_F^2| = {np.abs(g-nrm).max():.3e}"
          f"   (scale {np.abs(g).max():.4f})")
    print(f"     sum g = {g.sum():.9f}   4(n-1) = {4*(n-1)}   Delta = {g[lam>1e-9].sum():.6f}")
    return g, nrm

print("=== catalogued critical points ===")
for blocks in ([3,3],[3,5],[5,5]):
    n=sum(blocks); report(n, C.sphere_product(blocks), f"S^{blocks[0]}xS^{blocks[1]}")
for m in (2,3):
    report(2*m, C.cpm(m), f"CP^{m}")
report(8, C.pad(4,8,C.cpm(2)), "CP^2 padded n=8")

print("\n=== NON-critical Weyl tensors (random) ===")
rng=np.random.default_rng(7)
for n in (5,6,7):
    B=C.weyl_basis(n)
    for t in range(2):
        co=rng.normal(size=B.shape[0]); report(n, np.einsum('k,kij->ij',co,B), f"random Weyl #{t}")

print("\n=== OFF Weyl_n: generic symmetric operators on Lambda^2 ===")
for n in (5,6):
    N=n*(n-1)//2
    A=rng.normal(size=(N,N)); S=A+A.T
    report(n, S, "generic symmetric")

print("\n=== degenerate / structured: diagonal, rank one, W with big kernel ===")
n=6; N=15
D=np.diag(rng.normal(size=N)); report(n,D,"diagonal non-Weyl")
v=rng.normal(size=N); report(n,np.outer(v,v),"rank one non-Weyl")
