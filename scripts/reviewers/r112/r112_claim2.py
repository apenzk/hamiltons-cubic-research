"""Claim 2: the cap refinement, its cancellation, saturation, and whether a
better bound on Q_gamma exists.  Includes the EXACT transportation LP for
min Q_gamma, which is the best any marginal-based bound can do."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts/reviewers/r112'))
import r112_core as K
from scipy.optimize import linprog

rng = np.random.default_rng(2112)


def data(n, M):
    c = K.struct(n)
    lam, V = np.linalg.eigh(M)
    ce = np.einsum('abg,ax,by,gz->xyz', c, V, V, V, optimize=True)
    T = ce ** 2
    R = T.sum(axis=2)
    Q = np.einsum('gab,a,b->g', T, lam, lam)
    g = 2 * (R @ lam ** 2) - 2 * Q
    return lam, T, R, Q, g


def lp_minQ(lam, Rrow, rho):
    """min lam^T A lam over A >= 0 symmetric with row sums Rrow (exact
    transportation LP: the best bound obtainable from T's marginals alone)."""
    m = len(lam)
    iu = [(i, j) for i in range(m) for j in range(i, m)]
    cost = np.array([lam[i] * lam[j] * (2 if i != j else 1) for i, j in iu])
    Aeq = np.zeros((m, len(iu)))
    for k, (i, j) in enumerate(iu):
        Aeq[i, k] += 1.0
        if i != j:
            Aeq[j, k] += 1.0
    r = linprog(cost, A_eq=Aeq, b_eq=Rrow, bounds=[(0, None)] * len(iu),
                method='highs')
    return r.fun if r.success else np.nan


def run(n, M, tag, do_lp=True):
    lam, T, R, Q, g = data(n, M)
    lo, hi = lam[0], lam[-1]
    rho = 2 * (n - 2)
    uni = rho * (hi - lo) ** 2
    # the recorded refinement, per gamma
    m2 = (lo + hi) * (-2 * lam) - rho * lo * hi          # <= sum lam^2 R_gamma
    ref = 2 * m2 - 2 * (rho * lo * hi)
    # exact-LP version of the same two steps, still using only marginals
    if do_lp:
        lpQ = np.array([lp_minQ(lam, R[gm], rho) for gm in range(len(lam))])
        ref_lp = 2 * m2 - 2 * lpQ
    else:
        lpQ = ref_lp = np.full(len(lam), np.nan)
    print(f"{tag:>16} n={n:2d} lam[{lo:+.4f},{hi:+.4f}] "
          f"max_g={g.max():9.4f} uniform={uni:9.4f} slack={uni-g.max():9.4f} "
          f"maxref={ref.max():9.4f} ref/uni={ref.max()/uni:7.4f} "
          f"maxrefLP={np.nanmax(ref_lp):9.4f} refLP/uni={np.nanmax(ref_lp)/uni:7.4f} "
          f"valid={(g<=ref+1e-9).all()}/{(g<=ref_lp+1e-9).all() if do_lp else '-'}")
    return dict(uni=uni, maxg=g.max(), ref=ref.max(), reflp=np.nanmax(ref_lp))


if __name__ == '__main__':
    print("--- balanced sphere products (the maximiser) ---")
    for n in (6, 8, 10):
        run(n, K.sphere_product(n, n // 2), 'S^kxS^k')
    print("--- padded CP^2 ---")
    for n in (6, 8):
        run(n, K.cp2(n), 'CP2 padded')
    print("--- unbalanced products ---")
    for n, k in ((8, 3), (10, 4), (12, 5)):
        run(n, K.sphere_product(n, k), f'S^{k}xS^{n-k}')
    print("--- random Weyl points ---")
    for n in (6, 8):
        B = K.weyl_basis(n)
        for r in range(3):
            v = rng.standard_normal(B.shape[0])
            M = np.einsum('d,dij->ij', v, B); M /= np.linalg.norm(M)
            run(n, M, f'random#{r}')
