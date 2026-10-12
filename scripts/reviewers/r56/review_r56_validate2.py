import numpy as np, sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
from review_r56_core import *
print("=== gate 3 (redone): criticality and L_e W = W ===")
for n in (6, 8, 10, 12):
    idx, pos, N, c = struct(n)
    m = n // 2
    W = sphere_product(n, (m, n - m), idx)
    th, res = theta_res(W, c)
    e = W / th
    LeW = bil(e, W, c)
    print(f"  n={n:3d} S^{m}xS^{n-m}: theta={th:.9f}  theta_0={theta0(n):.9f}  "
          f"ratio={th/theta0(n):.6f} res={res:.1e} |L_eW-W|={np.linalg.norm(LeW-W):.1e} "
          f"|Ric|={np.linalg.norm(ricci(W,idx,n)):.1e} |Bianchi|={np.linalg.norm(bianchi(W,idx,n)):.1e}")
