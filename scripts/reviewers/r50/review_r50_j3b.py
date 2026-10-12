"""J3, the deflation question: does E(1/2) EQUAL the orbit span, not merely match in
dimension?  Principal angles between the two subspaces at the two contested points."""
import sys, numpy as np
sys.path.insert(0, 'scripts/lib')
import review_r50_core as C
from review_r50_spec import le_matrix, orbit_dim

for (blocks, n0, n) in [((5, 5), 10, 12), ((6, 6), 12, 14), ((6, 7), 13, 14)]:
    N = len(C.pairs_idx(n)[0])
    W = C.pad(C.sphere_product_W(blocks), n0, n) if n0 != n else C.sphere_product_W(blocks)
    W = W / np.linalg.norm(W)
    th = C.P(n, W)
    U, _ = orbit_dim(n, W)                      # orthonormal rows in sym-coords
    M, B, _ = le_matrix(n, W, th)
    w, V = np.linalg.eigh(M)
    sel = np.abs(w - 0.5) < 1e-8
    E = (B.T @ V[:, sel]).T                     # E(1/2) in sym-coords
    E = C.orthonormalize_rows(E)
    cos = np.linalg.svd(U @ E.T, compute_uv=False)
    # the residual of W itself, and how far <W> sits from E(1/2)
    wv = C.mat2vec(N, W); wv /= np.linalg.norm(wv)
    print(f"S^{blocks[0]}xS^{blocks[1]} {n0}->{n}: dim orbit={U.shape[0]} dim E(1/2)={E.shape[0]} "
          f"principal cosines min={cos.min():.12f} max={cos.max():.12f}")
    print(f"    L_e eigenvalue on W = {float(np.dot(wv, C.mat2vec(N, C.circ(n, W/th, W)))):.12f} "
          f"(must be 1);  |proj of W onto E(1/2)| = {np.linalg.norm(E @ wv):.2e}")
