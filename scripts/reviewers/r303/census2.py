"""Wider census: least-squares solves + power iteration on the idempotent map,
plus explicit sphere products and paddings."""
import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np
from scipy.optimize import least_squares
from diagcore import (V_basis, Phi, theta_of, proj_V, crit_residual,
                      crit_residual_strong, L_matrix, defect)
from find_crit import analyse
from core303 import sphere_product_M


def normalise(M):
    return M * np.sqrt(2.0 / np.sum(M * M))


def power(M0, B, iters=4000):
    M = normalise(M0)
    for _ in range(iters):
        X = proj_V(Phi(M), B)
        nr = np.sqrt(np.sum(X * X))
        if nr < 1e-14:
            return None
        M = normalise(X)
    return M


def refine(M0, B):
    def M_of(x):
        return normalise(np.einsum('k,kij->ij', x, B))

    def res(x):
        return np.einsum('kij,ij->k', B, crit_residual(M_of(x), B))
    x0 = np.einsum('kij,ij->k', B, M0)
    s = least_squares(res, x0, xtol=1e-15, ftol=1e-15, gtol=1e-15)
    M = M_of(s.x)
    return M, float(np.abs(crit_residual(M, B)).max())


def census(n, ns=200):
    B = V_basis(n)
    rng = np.random.default_rng(11)
    cands = []
    for seed in range(ns):
        r = np.random.default_rng(seed)
        M0 = normalise(np.einsum('k,kij->ij', r.normal(size=len(B)), B))
        cands.append(M0)
        Mp = power(M0, B)
        if Mp is not None:
            cands.append(Mp)
            cands.append(power(-M0, B))
    for p in range(2, n - 1):
        cands.append(sphere_product_M(p, n - p))
        for pad in range(1, min(4, n - 4)):
            if n - pad >= 5:
                Mp = np.zeros((n, n))
                sub = sphere_product_M(2, n - pad - 2)
                Mp[:n - pad, :n - pad] = sub
                cands.append(normalise(Mp))
    tab = {}
    for M0 in cands:
        if M0 is None:
            continue
        try:
            M, r = refine(M0, B)
        except Exception:
            continue
        if r > 1e-10:
            continue
        a = analyse(M, B)
        if a['theta'] < 1e-7:
            continue
        key = (round(a['theta'], 7), round(a['Delta'], 5), round(a['ratio'], 6), a['kerdim'])
        if key not in tab:
            tab[key] = (M, a, float(np.abs(crit_residual_strong(M)).max()))
    return B, tab


if __name__ == '__main__':
    n = int(sys.argv[1]); ns = int(sys.argv[2]) if len(sys.argv) > 2 else 150
    B, tab = census(n, ns)
    rows = sorted(tab.items(), key=lambda kv: -kv[1][1]['theta'])
    print(f"n={n}: {len(rows)} distinct theta>0 signatures")
    print(f"{'theta':>10} {'Delta':>10} {'lmax/th':>10} {'lmin/th':>9} {'ker':>3} {'strong':>8}  flag")
    hits = []
    for key, (M, a, st) in rows:
        flag = ''
        if a['Delta'] > 1e-7 and a['ratio'] <= 0.5 + 1e-9:
            flag = '<<<< PRIZE'; hits.append(M)
        if a['Delta'] <= 1e-7 and a['ratio'] > 0.5 + 1e-9:
            flag = 'Delta=0 but unstable'
        if st > 1e-9:
            flag += ' STRONGFAIL'
        print(f"{a['theta']:10.6f} {a['Delta']:10.5f} {a['ratio']:10.6f} "
              f"{a['lam_min']/a['theta']:9.4f} {a['kerdim']:3d} {st:8.1e}  {flag}")
    out = f"/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad"
    np.save(f"{out}/all_{n}.npy", np.array([v[0] for v in tab.values()]))
