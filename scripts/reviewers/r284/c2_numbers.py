"""r284 -- the six quoted numbers of D1's instrument table, recomputed.

Plucker minima 0.61 / 0.63 / 0.50 and frame-minimal off-diagonal masses
0.837 / 0.866 / 0.707 at CP^4, CP^5, padded W_CP2.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, Q
from b_cpm_closed_form import W_cpm
from b_cp2_nondegenerate import padded_cp2
from b_diagonality_split import off_diagonal_mass, min_off_diagonal_mass, rotate
sys.path.insert(0, 'scripts/reviewers/r284')
from c1_local_max_witness import plucker_min

def show(label, W, n):
    W = W / np.linalg.norm(W)
    th = float(np.tensordot(W, Q(n, W)))
    res = np.linalg.norm(Q(n, W) - th * W)
    print(f"{label}  n={n}  theta={th:.6f}  crit residual={res:.2e}")
    print(f"   constructor-frame off-diagonal mass = {off_diagonal_mass(W):.6f}"
          f"   max entry = {float(np.abs(W-np.diag(np.diag(W))).max()):.6f}")
    m = min_off_diagonal_mass(W, n, tries=12, iters=400, seed=3)
    print(f"   O(n)-descent best mass = {m:.6f}")
    for lam, d, p in plucker_min(W, n, tries=40):
        print(f"   eig {lam:+.6f} (dim {d}): min ||w^w|| = {p:.6f}")
    print(flush=True)

if __name__ == "__main__":
    W4, p4, i4 = W_cpm(4); show("CP^4       ", W4, 8)
    W5, p5, i5 = W_cpm(5); show("CP^5       ", W5, 10)
    Wc, B = padded_cp2(8); show("padded CP^2", Wc, 8)
    # positive control
    from review_r30_core import sphere_product_W
    Wsp, _ = sphere_product_W((3,3)); Wsp = Wsp/np.linalg.norm(Wsp)
    rng = np.random.default_rng(1); A = rng.normal(size=(6,6)); A = A - A.T
    R = np.linalg.qr(np.eye(6)+0.8*A)[0]; Wr = rotate(Wsp, 6, R)
    print(f"control rotated S^3xS^3: mass {off_diagonal_mass(Wr):.4f} -> "
          f"{min_off_diagonal_mass(Wr, 6, tries=12, iters=400, seed=3):.3e}")
    for lam, d, p in plucker_min(Wsp, 6, tries=40):
        print(f"   S^3xS^3 eig {lam:+.6f} (dim {d}): min ||w^w|| = {p:.6f}")
