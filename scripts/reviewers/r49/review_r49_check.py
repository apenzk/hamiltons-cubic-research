"""Reviewer 49: two robustness checks used in the report."""
import sys
import numpy as np
sys.path.insert(0, 'scripts/lib')
import review_r49_core as C

print("=== gradedness leaks at the padded W_CP2 (m = negative eigenspace) ===", flush=True)
for n in (8, 10, 12):
    W = C.embed(C.fox_cp2(4), 4, n, (0, 1, 2, 3))
    ev, V = np.linalg.eigh(W)
    mi = np.where(ev < -1e-10)[0]
    M = V[:, mi]                        # (N, dim m)
    Pm = M @ M.T
    Ph = np.eye(W.shape[0]) - Pm
    c = C.struct(n)                     # c[a,b,g]
    # bracket of two basis directions expressed in coordinates u,v: [u,v]_g = c[a,b,g] u_a v_b
    def leak(U1, U2, Pout):
        tot = 0.0
        for i in range(U1.shape[1]):
            for j in range(U2.shape[1]):
                br = np.einsum('abg,a,b->g', c, U1[:, i], U2[:, j])
                tot += np.sum((Pout @ br) ** 2)
        return tot
    Hb = V[:, [k for k in range(W.shape[0]) if k not in mi]]
    S = leak(M, M, Pm)
    hh = leak(Hb, Hb, Pm)
    hm = leak(Hb, M, Ph)
    print(f"  n={n:2d}: dim m={len(mi)}  S = |Pi_m[m,m]|^2 = {S:.3e}   "
          f"|Pi_m[h,h]|^2 = {hh:.4f}   |Pi_h[h,m]|^2 = {hm:.4f}  -> ungraded" , flush=True)

print("\n=== kernel of L_X: singular-value gap, so the dimension is not a tolerance artefact ===",
      flush=True)
for n, lbl, X in [(8, "padded W_CP2", C.embed(C.fox_cp2(4), 4, 8, (0, 1, 2, 3))),
                  (8, "S^4xS^4", C.normalize(C.sphere_product((4, 4))))]:
    B = C.weyl_basis(n)
    M = np.array([np.einsum('kij,ij->k', B, C.circ(n, X, E)) for E in B]).T
    s = np.linalg.svd(M, compute_uv=False)
    nz = int((s > s[0] * 1e-8).sum())
    print(f"  n={n} {lbl:14s} dim={B.shape[0]}  rank={nz}  ker={B.shape[0]-nz}  "
          f"s[rank-1]={s[nz-1]:.3e}  s[rank]={s[nz]:.3e}  ratio={s[nz-1]/max(s[nz],1e-300):.2e}",
          flush=True)
