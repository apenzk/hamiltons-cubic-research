import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r51_core import *

print("== dim Weyl_n ==")
for n in range(4, 12):
    B = weyl_basis(n)
    print(f"  n={n:2d} basis dim {B.shape[0]:5d} formula {dim_weyl(n):5d} "
          f"{'OK' if B.shape[0]==dim_weyl(n) else 'MISMATCH'}")

print("== basis really lies in Weyl (Alt, Ricci) ==")
for n in (6, 8):
    B = weyl_basis(n)
    a = max(np.abs(alt_part(n, b)).max() for b in B[:20])
    r = max(np.abs(ricci_of(n, b)).max() for b in B[:20])
    print(f"  n={n} max|Alt|={a:.2e} max|Ric|={r:.2e}")

print("== trilinear symmetry of <X o Y, Z> ==")
rng = np.random.default_rng(0)
for n in (5, 6, 7):
    P, idx, sgn = pairs_of(n); N = len(P)
    X, Y, Z = [0.5*(M+M.T) for M in rng.normal(size=(3, N, N))]
    v = [float(np.tensordot(circ(n,X,Y),Z)), float(np.tensordot(circ(n,Y,Z),X)),
         float(np.tensordot(circ(n,Z,X),Y))]
    print(f"  n={n} spread {max(v)-min(v):.2e} of {v[0]:.6f}")

print("== tr(L_x) = 0 on Weyl_n ==")
for n in (5, 6, 7):
    B = weyl_basis(n)
    X = normalize(sum(rng.normal()*b for b in B))
    tr = sum(float(np.tensordot(b, circ(n, X, b))) for b in B)
    print(f"  n={n} dim={B.shape[0]:4d} tr(L_X)={tr:.3e}")

print("== L_e W = W at critical points ==")
for blocks, n in (((3,3),6), ((4,4),8), ((5,5),10), ((6,6),12), ((6,6),14), ((3,3),10)):
    W = normalize(sphere_product_W(blocks, n))
    Q = Qop(n, W)
    th = float(np.tensordot(W, Q))
    res = np.abs(Q - th*W).max()
    e = W/th
    err = np.abs(circ(n, e, W) - W).max()
    print(f"  blocks={blocks} n={n:2d} theta={th:.9f} theta0={theta0(n):.9f} "
          f"ratio={th/theta0(n):.4f} |Q-thW|={res:.1e} |L_e W - W|={err:.1e}")

print("== padded point stays in Weyl ==")
for blocks, n in (((6,6),14), ((5,5),12)):
    W = normalize(sphere_product_W(blocks, n))
    print(f"  blocks={blocks} n={n}: |Alt|={np.abs(alt_part(n,W)).max():.1e} "
          f"|Ric|={np.abs(ricci_of(n,W)).max():.1e} "
          f"|W-Pw W|={np.abs(W-weyl_project(n,W)).max():.1e}")
