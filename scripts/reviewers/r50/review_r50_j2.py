"""J2: does the basis-free projector give a correct matrix-free L_e at n=14,
and is the full operator really infeasible there?"""
import sys, time, numpy as np
sys.path.insert(0, 'scripts/lib')
import review_r50_core as C
from review_r50_spec import le_matrix

n = 14
N = len(C.pairs_idx(n)[0])
rng = np.random.default_rng(7)

W = C.pad(C.sphere_product_W((6, 6)), 12, n); W = W / np.linalg.norm(W)
th = C.P(n, W); e = W / th

t0 = time.time(); B, rank = C.weyl_basis_vec(n); t_basis = time.time() - t0
print(f"dim Weyl_14 = {B.shape[0]} (formula {C.dim_weyl_formula(n)}), basis built in {t_basis:.1f}s")

t0 = time.time(); M, B2, asym = le_matrix(n, W, th); t_op = time.time() - t0
print(f"full L_e matrix ({M.shape[0]}x{M.shape[0]}) built in {t_op:.1f}s, asym={asym:.2e}")
t0 = time.time(); w = np.linalg.eigvalsh(M); t_eig = time.time() - t0
print(f"full eigensolve in {t_eig:.1f}s -> TOTAL {t_basis+t_op+t_eig:.1f}s")

print("\n-- matrix-free apply vs the full matrix, on random Weyl_14 directions --")
worst = 0.0; worstp = 0.0
for _ in range(5):
    c = rng.normal(size=B.shape[0]); c /= np.linalg.norm(c)
    X = C.vec2mat(N, B.T @ c)
    LX_free = C.weyl_project_free(n, C.circ(n, e, X))     # matrix-free route
    LX_unpr = C.circ(n, e, X)                             # unprojected
    LX_mat = C.vec2mat(N, B.T @ (M @ c))                  # full-matrix route
    worst = max(worst, np.linalg.norm(LX_free - LX_mat) / np.linalg.norm(LX_mat))
    worstp = max(worstp, np.linalg.norm(LX_unpr - LX_mat) / np.linalg.norm(LX_mat))
print(f"  matrix-free(with projector) vs full matrix : {worst:.2e}")
print(f"  unprojected e o X          vs full matrix : {worstp:.2e}  (L_e already preserves Weyl_n)")

print("\n-- cost of one matrix-free apply at n=14 --")
X = C.vec2mat(N, B.T @ rng.normal(size=B.shape[0]))
t0 = time.time()
for _ in range(10):
    C.weyl_project_free(n, C.circ(n, e, X))
print(f"  {(time.time()-t0)/10*1000:.1f} ms per apply; {B.shape[0]} applies would cost "
      f"{(time.time()-t0)/10*B.shape[0]:.1f}s -- so even a naive matvec-per-column build is cheap")
