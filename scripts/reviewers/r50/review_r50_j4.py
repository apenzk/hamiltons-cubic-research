"""J3/J4: exhaustive sweep of padded critical points into a fixed ambient n.

Every sphere product S^p x S^q with p,q >= 2 and n0 = p+q <= n, plus the padded
Fox / W_CP2 point, padded into n and settled by a FULL eigensolve of L_e.
Reports theta/theta_0(n), orbit dim, dim E(1/2), and the off-orbit gap to 1/2.
"""
import sys, time, numpy as np
sys.path.insert(0, 'scripts/lib')
import review_r50_core as C
from review_r50_spec import le_matrix, orbit_dim


def W_cp2():
    """Weyl operator of CP^2 in dim 4: 0 on Lambda^-, (-1,-1,2)/sqrt6 on Lambda^+."""
    n = 4
    pairs, idx = C.pairs_idx(n)
    N = len(pairs)

    def biv(i, j, k, l, s):
        v = np.zeros(N)
        v[idx[(i, j)]] += 1 / np.sqrt(2)
        v[idx[(k, l)]] += s / np.sqrt(2)
        return v
    om = [biv(0, 1, 2, 3, +1), biv(0, 2, 1, 3, -1), biv(0, 3, 1, 2, +1)]
    lam = np.array([-1.0, -1.0, 2.0]) / np.sqrt(6)
    return sum(l * np.outer(v, v) for l, v in zip(lam, om))


def run(n, tol=1e-8, extra_blocks=()):
    seeds = []
    for n0 in range(4, n + 1):
        for p in range(2, n0 // 2 + 1):
            q = n0 - p
            if q >= p:
                seeds.append((f"S^{p}xS^{q}", n0, C.sphere_product_W((p, q))))
    for bl in extra_blocks:
        seeds.append(("x".join(f"S^{b}" for b in bl), sum(bl), C.sphere_product_W(bl)))
    seeds.append(("W_CP2(Fox)", 4, W_cp2()))
    rows = []
    th0 = C.theta0(n)
    for (name, n0, W0) in seeds:
        t0 = time.time()
        W = C.pad(W0, n0, n) if n0 != n else W0
        W = W / np.linalg.norm(W)
        th = C.P(n, W)
        res = np.linalg.norm(C.Q(n, W) - th * W)
        U, _ = orbit_dim(n, W)
        orb = U.shape[0]
        M, B, asym = le_matrix(n, W, th)
        w = np.linalg.eigvalsh(M)
        dd = np.sort(np.abs(w - 0.5))
        dimE = int((dd < tol).sum())
        gap = dd[dimE] if dimE < len(dd) else float('nan')
        rows.append((name, n0, th, th / th0, orb, dimE, gap, res, time.time() - t0))
        print(f"{name:>12} {n0:3d}->{n:2d} th={th:.9f} r={th/th0:.6f} orb={orb:3d} "
              f"E12={dimE:3d} {'ND' if dimE==orb else 'DEG+%d' % (dimE-orb):>7} "
              f"gap={gap:.4e} res={res:.1e} {time.time()-t0:.1f}s", flush=True)
    rows.sort(key=lambda r: -r[3])
    print(f"\n=== n={n}, sorted by theta/theta_0 (theta_0={th0:.9f}) ===")
    print(f"{'seed':>12} {'n0':>3} {'theta':>13} {'th/th0':>9} {'orbit':>6} {'dimE':>5} {'verdict':>9} {'gap':>11}")
    for (name, n0, th, r, orb, dimE, gap, res, t) in rows:
        print(f"{name:>12} {n0:3d} {th:13.9f} {r:9.6f} {orb:6d} {dimE:5d} "
              f"{'NONDEG' if dimE==orb else 'DEG+%d'%(dimE-orb):>9} {gap:11.4e}")
    return rows


if __name__ == "__main__":
    n = int(sys.argv[1])
    run(n)   # 3-block seeds dropped: the naive block formula is NOT critical (res ~ 3e-1)
