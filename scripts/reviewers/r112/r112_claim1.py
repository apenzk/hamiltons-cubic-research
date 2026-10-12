"""Claim 1: the Q decomposition, its two constraints, and whether they are definitional."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts/reviewers/r112'))
import r112_core as K

rng = np.random.default_rng(112)

def report(n, M, tag):
    c = K.struct(n)
    lam, V = np.linalg.eigh(M)
    # structure constants in the EIGENBASIS of M
    ce = np.einsum('abg,ax,by,gz->xyz', c, V, V, V, optimize=True)
    T = ce ** 2                              # T[g,a,b], totally symmetric
    R = T.sum(axis=2)                        # R[g,a]
    rho = R.sum(axis=0)                      # row marginal
    Q = np.einsum('gab,a,b->g', T, lam, lam)
    # g_gamma from its own definition ||[ad(v_g), M]||^2, ad in the eigenbasis
    ad = np.transpose(ce, (0, 2, 1))         # ad[g][b,a] = <[v_g,v_a],v_b>
    Me = np.diag(lam)
    g_def = np.array([np.sum((A @ Me - Me @ A) ** 2) for A in ad])
    g_dec = 2 * (R @ (lam ** 2)) - 2 * Q
    perrow = R @ lam + 2 * lam               # per-row identity residual
    th = K.theta(n, M)
    sharpM = K.sharp(n, M)
    out = dict(
        tag=tag, n=n, theta=th,
        rho_err=float(np.max(np.abs(rho - 2 * (n - 2)))),
        g_id=float(np.max(np.abs(g_def - g_dec))),
        perrow=float(np.max(np.abs(perrow))),
        c1=float(Q.sum() + 2 * np.sum(M * M)),
        c2=float(lam @ Q - 2 * np.sum(sharpM * M)),
        sum_g=float(g_def.sum()), sum_g_exp=4.0 * (n - 1),
        sum_lg=float(lam @ g_def), sum_lg_exp=-4.0 * th,
    )
    return out

pts = []
for n in (5, 6, 7, 8):
    B = K.weyl_basis(n)
    for r in range(2):
        v = rng.standard_normal(B.shape[0])
        M = np.einsum('d,dij->ij', v, B); M /= np.linalg.norm(M)
        pts.append((n, M, f'random#{r}'))
    if n % 2 == 0:
        pts.append((n, K.sphere_product(n, n // 2), 'S^kxS^k'))
        pts.append((n, K.cp2(n), 'CP2 padded'))

print(f"{'pt':>14} {'n':>2} {'rho-2(n-2)':>11} {'g id':>10} {'perrow':>10} "
      f"{'sumQ+2|W|^2':>12} {'sum lQ-2<W#,W>':>15} {'sum g-4(n-1)':>13} {'sum lg+4th':>11}")
for n, M, tag in pts:
    o = report(n, M, tag)
    print(f"{o['tag']:>14} {n:>2} {o['rho_err']:11.2e} {o['g_id']:10.2e} {o['perrow']:10.2e} "
          f"{o['c1']:12.2e} {o['c2']:15.2e} {o['sum_g']-o['sum_g_exp']:13.2e} "
          f"{o['sum_lg']-o['sum_lg_exp']:11.2e}")
