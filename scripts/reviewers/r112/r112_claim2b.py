"""Claim 2, the attack: the JOINT two-moment LP (the correct refinement --
both terms bounded together rather than separately), plus a check that the
'available and unused' constraint sum_a u_{ga} = -2 lam_g is implied."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts/reviewers/r112'))
import r112_core as K
from scipy.optimize import linprog

rng = np.random.default_rng(31415)


def joint_cap(lam, rho, lg):
    """max sum_{ab} (l_a-l_b)^2 A_ab  over A>=0 symmetric,
       sum A = rho,  sum_ab l_a A_ab = -2 l_gamma.
       This is g_gamma's exact bound from T's two marginal moments alone."""
    m = len(lam)
    iu = [(i, j) for i in range(m) for j in range(i, m)]
    obj = np.array([-(2.0 if i != j else 1.0) * (lam[i] - lam[j]) ** 2 for i, j in iu])
    m1 = np.array([(2.0 if i != j else 1.0) for i, j in iu])
    m2 = np.array([(lam[i] + lam[j]) if i != j else lam[i] for i, j in iu])
    r = linprog(obj, A_eq=np.vstack([m1, m2]), b_eq=[rho, -2 * lg],
                bounds=[(0, None)] * len(iu), method='highs')
    return -r.fun if r.success else np.nan


def run(n, M, tag):
    c = K.struct(n)
    lam, V = np.linalg.eigh(M)
    ce = np.einsum('abg,ax,by,gz->xyz', c, V, V, V, optimize=True)
    T = ce ** 2; R = T.sum(axis=2)
    Q = np.einsum('gab,a,b->g', T, lam, lam)
    g = 2 * (R @ lam ** 2) - 2 * Q
    rho = 2 * (n - 2); uni = rho * (lam[-1] - lam[0]) ** 2
    jc = np.array([joint_cap(lam, rho, lam[gm]) for gm in range(len(lam))])
    print(f"{tag:>16} n={n:2d} max_g={g.max():9.4f} uniform={uni:9.4f} "
          f"joint2mom={jc.max():9.4f} joint/uni={jc.max()/uni:7.4f} "
          f"joint/max_g={jc.max()/g.max():7.4f} valid={(g <= jc + 1e-9).all()}")


if __name__ == '__main__':
    for n in (6, 8, 10):
        run(n, K.sphere_product(n, n // 2), 'S^kxS^k')
    for n in (6, 8):
        run(n, K.cp2(n), 'CP2 padded')
    for n, k in ((8, 3), (10, 4), (12, 5)):
        run(n, K.sphere_product(n, k), f'S^{k}xS^{n-k}')
    for n in (6, 8):
        B = K.weyl_basis(n)
        for r in range(2):
            v = rng.standard_normal(B.shape[0])
            M = np.einsum('d,dij->ij', v, B); M /= np.linalg.norm(M)
            run(n, M, f'random#{r}')

    # the 'unused' constraint is implied: sum_a u_{ga} = sum_b lam_b R_{gb}
    print("\n-- is sum_a u_{g,a} = -2 lam_g extra information? --")
    n = 6; M = K.sphere_product(6, 3)
    c = K.struct(n); lam, V = np.linalg.eigh(M)
    ce = np.einsum('abg,ax,by,gz->xyz', c, V, V, V, optimize=True); T = ce ** 2
    R = T.sum(axis=2)
    u = np.einsum('gab,b->ga', T, lam)
    print("  max |sum_a u_ga - (lam . R_g.)| =", float(np.max(np.abs(u.sum(1) - R @ lam))))
    print("  max |sum_a u_ga + 2 lam_g|      =", float(np.max(np.abs(u.sum(1) + 2 * lam))))
