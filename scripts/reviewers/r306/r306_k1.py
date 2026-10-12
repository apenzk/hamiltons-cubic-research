"""Builds the pool of CONNECTED diagonal critical points used by the K1 battery.

Run this first; it writes pool.pkl next to itself (gitignored, ~10 kB, seconds to rebuild).
"""
import sys, os, pickle
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r306_defs as R
from scipy.optimize import least_squares

rng = np.random.default_rng(30601)


def solve_critical(n, tries=30):
    bas = R.adm_basis(n); k = len(bas)
    build = lambda y: sum(y[i] * bas[i] for i in range(k))
    def resid(y):
        M = build(y); th = R.theta_diag(M); G = R.hollow(R.Phi(M)) - th * M
        return np.array([np.sum(b * G) for b in bas] + [np.sum(M * M) - 2.0])
    out = []
    for _ in range(tries):
        y0 = rng.normal(size=k); y0 = y0 / np.linalg.norm(y0) * np.sqrt(2)
        s = least_squares(resid, y0, xtol=1e-15, ftol=1e-15, gtol=1e-15)
        M = build(s.x)
        if np.max(np.abs(resid(s.x))) < 1e-11 and R.theta_diag(M) > 1e-6:
            out.append(M)
    return out


def comps(M, tol=1e-10):
    n = M.shape[0]; adj = np.abs(M) > tol; seen = -np.ones(n, int); c = 0
    for i in range(n):
        if seen[i] >= 0: continue
        st = [i]; seen[i] = c
        while st:
            v = st.pop()
            for w in range(n):
                if adj[v, w] and seen[w] < 0: seen[w] = c; st.append(w)
        c += 1
    return c, seen


def c5(m):
    n = 5 * m; blk = np.repeat(np.arange(5), m)
    def build(par):
        x, y, z = par; M = np.zeros((n, n))
        for a in range(n):
            for b in range(n):
                if a == b: continue
                d = min((blk[a] - blk[b]) % 5, (blk[b] - blk[a]) % 5)
                M[a, b] = x if d == 0 else (y if d == 1 else z)
        return M
    def resid(par):
        M = build(par); th = R.theta_diag(M); G = R.hollow(R.Phi(M)) - th * M
        r = [G[0, m], G[0, 2 * m], np.sum(M * M) - 2.0, M.sum(1)[0]]
        if m > 1: r.append(G[0, 1])
        return np.array(r)
    best = None
    for _ in range(300):
        s = least_squares(resid, rng.normal(size=3), xtol=1e-15, ftol=1e-15)
        M = build(s.x)
        if np.max(np.abs(resid(s.x))) < 1e-12 and R.theta_diag(M) > 1e-8:
            if best is None or R.theta_diag(M) > R.theta_diag(best): best = M
    return best


if __name__ == '__main__':
    pool = {}
    for (p, q) in [(2, 2), (2, 3), (3, 3), (2, 4), (3, 4), (4, 4)]:
        pool[f'S{p}xS{q}'] = R.sphere_product(p, q)
    pool['C5blowup2'] = c5(2)
    seen = set()
    for n in (5, 6, 7, 8):
        for M in solve_critical(n):
            if comps(M)[0] != 1: continue
            key = (n, round(R.theta_diag(M), 7))
            if key in seen: continue
            seen.add(key); pool[f'sol_n{n}_th{key[1]:.5f}'] = M
    print('POOL:')
    for k, M in pool.items():
        print(f'  {k:24s} n={M.shape[0]:2d} theta={R.theta_diag(M):.9f} '
              f'crit={np.abs(R.crit_residual(M)).max():.1e} comps={comps(M)[0]} '
              f'ker={int(np.sum(np.abs(np.linalg.eigvalsh(M)) < 1e-9))}')
    pickle.dump(pool, open(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'pool.pkl'), 'wb'))
