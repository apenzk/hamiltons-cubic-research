"""Reviewer 44 -- branch obstruction at an arbitrary padded S=0 critical point."""
import numpy as np, sys, time
from scipy.optimize import minimize
sys.path.insert(0, 'scripts/lib')
from review_r44_core import *
from review_r44_branch import setup, make_funcs, log
from review_r44_catalogue import cpm_W
import review_r44_branch as br

def run_point(Wsmall, n0, n, label, nstart=150, seed=3):
    # reuse setup by faking the embed source
    W = embed(Wsmall, n0, n) if n > n0 else Wsmall.copy()
    W = W / np.linalg.norm(W)
    B = weyl_basis(n)
    th = float(np.tensordot(W, Qop(W, n)))
    from review_r44_padded import Le_matrix
    M = Le_matrix(W / th, n, B)
    ev, U = np.linalg.eigh(M)
    sel = np.abs(ev - 0.5) < 1e-8
    Kb = U[:, sel]
    Ob, _ = orbit_tangent_basis(W, n)
    ObB, _ = np.linalg.qr(B.T @ Ob)
    et, Ut = np.linalg.eigh(Kb @ Kb.T - ObB @ ObB.T)
    Tb = Ut[:, et > 0.5]
    lam = th * (2 * ev - 1.0)
    inv = np.where(np.abs(lam) > 1e-8, 1.0 / np.where(np.abs(lam) > 1e-8, lam, 1.0), 0.0)
    G = (U * inv) @ U.T
    Qc, Phi, Psi1 = make_funcs(n, B, Kb, G, th)
    d = Tb.shape[1]
    S, _ = slack_S(W, n)
    log(f'[branch2 {label} n0={n0} n={n}] theta={th:.9f} S={S:+.2e} orbit={ObB.shape[1]} '
        f'E(1/2)={int(sel.sum())} dimT={d}')
    if d == 0:
        log('   nondegenerate, nothing to test'); return
    rng = np.random.default_rng(seed)
    def f(x):
        c = Tb @ (x / np.linalg.norm(x))
        return float(np.sum(Phi(c) ** 2))
    best = []
    for s in range(nstart):
        x0 = rng.standard_normal(d)
        r = minimize(f, x0, method='Nelder-Mead',
                     options=dict(maxiter=6000, xatol=1e-12, fatol=1e-18))
        best.append((r.fun, r.x / np.linalg.norm(r.x)))
    best.sort(key=lambda t: t[0])
    zeros = [x for v, x in best if v < 1e-16]
    bv = [np.linalg.norm(Phi(Tb[:, j])) for j in range(d)]
    log(f'   |Phi| on T basis: min={min(bv):.4f} max={max(bv):.4f}; '
        f'global min |Phi|^2 = {best[0][0]:.3e}; zeros found {len(zeros)}/{nstart}')
    if zeros:
        psis = [Psi1(Tb @ z) for z in zeros[:150]]
        log(f'   Psi_1 on zero cone: min={min(psis):.9f} max={max(psis):.9f}')
    else:
        log('   NO second-order zero in T -> no branch leaves, degeneracy is harmless')

if __name__ == '__main__':
    from review_r44_core import sphere_product_W
    run_point(sphere_product_W((2, 2)), 4, 8, 'S2xS2->8')
    run_point(sphere_product_W((2, 4)), 6, 10, 'S2xS4->10')
    run_point(sphere_product_W((2, 2)), 4, 6, 'S2xS2->6')
