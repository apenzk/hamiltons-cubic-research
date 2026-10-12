"""Reviewer 57: the L_e matrix on Weyl_n, and the E(1/2) excess.

L_e v = 1/2(ev + ve) + e # v.  Assembled as one dense N^2 x N^2 kernel

     T[(e,f),(b,d)] = sum_a c[a,b,e] * (sum_c e_ac c[c,d,f])

so the whole map is a single GEMM; restricted to Weyl_n it gives the d x d
matrix whose 1/2-eigenspace is compared with the orbit tangent space.
At a critical point L_e W = W (eigenvalue 1) and the orbit sits at 1/2.
"""
import itertools
import numpy as np

from review_r57_core import Alg, Weyl


def Le_matrix(n, e):
    alg = Alg.get(n)
    w = Weyl.get(n)
    N, d = alg.N, w.dim
    c = alg.c
    P = np.einsum('ac,cdf->adf', e, c, optimize=True)             # N x N x N
    T = np.tensordot(c, P, axes=([0], [0]))                        # b,e,d,f
    T = np.transpose(T, (1, 3, 0, 2)).reshape(N * N, N * N)        # (e,f),(b,d)
    T = 0.5 * T
    F = w.basis_flat                                               # N^2 x d
    sharp_part = T @ F                                             # N^2 x d
    Fr = F.reshape(N, N, d)
    comm = 0.5 * (np.einsum('ij,jkd->ikd', e, Fr, optimize=True) +
                  np.einsum('ijd,jk->ikd', Fr, e, optimize=True)).reshape(N * N, d)
    return F.T @ (sharp_part + comm)


def orbit_dim(alg, W, tol=1e-8):
    n = alg.n
    rows = []
    for i, j in itertools.combinations(range(n), 2):
        A = np.zeros((n, n)); A[i, j] = 1.0; A[j, i] = -1.0
        ad = alg.ad(A)
        rows.append((ad @ W - W @ ad).ravel())
    M = np.array(rows).T
    s = np.linalg.svd(M, compute_uv=False)
    return int(np.sum(s > tol * max(1.0, s[0])))


def analyse(label, n, W):
    alg = Alg.get(n)
    th = alg.P(W)
    e = W / th
    M = Le_matrix(n, e)
    M = 0.5 * (M + M.T)
    ev = np.linalg.eigvalsh(M)
    w = Weyl.get(n)
    x = w.coords(W)
    LeW = M @ x
    gate = np.linalg.norm(LeW - x) / np.linalg.norm(x)
    half = int(np.sum(np.abs(ev - 0.5) < 1e-7))
    od = orbit_dim(alg, W)
    print(f"{label:<26} n={n:3d} theta={th:.6f}  ||L_e W - W||/||W||={gate:.2e}  "
          f"lam_max={ev[-1]:.6f}  dim E(1/2)={half}  orbit={od}  excess={half-od}",
          flush=True)
    return dict(theta=th, half=half, orbit=od, excess=half - od, lam_max=ev[-1])


if __name__ == "__main__":
    import sys
    from review_r57_points import (sphere_product, w_cp2, su_m_kahler, unit, orient,
                                   commutant_on_weyl, u_m_gens, block_sum)

    def cpm(n):
        gens, _ = u_m_gens(n)
        V, _ = commutant_on_weyl(n, gens)
        w = Weyl.get(n)
        return orient(w.alg, unit(w.from_coords(V[:, 0])))

    ns = [int(a) for a in sys.argv[1:]] or [6, 8, 10]
    print("-- gate: L_e W = W at a known critical point, and the orbit sits in E(1/2) --")
    for n in ns:
        analyse("S^{p}xS^{q} balanced", n, sphere_product(
            n, [list(range(n // 2)), list(range(n // 2, n))]))
    for n in ns:
        analyse(f"su({n//2}) Kaehler", n, su_m_kahler(n))
    for n in ns:
        analyse(f"CP^{n//2}", n, cpm(n))
    for n in ns:
        if n >= 8:
            analyse("padded W_CP2", n, w_cp2(n))
