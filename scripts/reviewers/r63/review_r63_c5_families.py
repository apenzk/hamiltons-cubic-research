"""Reviewer 63 -- structured adversarial families for C5, and the k-monotonicity claim."""
import sys, itertools, numpy as np
sys.path.insert(0, 'scripts/lib')[0])
from review_r63_G import G_closed
from scipy.optimize import minimize

T = np.sqrt(1.5)

def norm(p, b, c):
    v = np.concatenate([p, [-b, -c]]); n = np.linalg.norm(v)
    return v[:len(p)]/n, b/n, c/n

def fam(name, gen, grid):
    best = (-9, None)
    for g in grid:
        try: p, b, c = gen(*g)
        except Exception: continue
        if min(list(p)+[b, c]) < 0: continue
        if b + c <= 0 or p.sum() <= 0: continue
        p, b, c = norm(p*(b+c)/p.sum(), b, c)
        v = G_closed(p, b, c)
        if v > best[0]: best = (v, g)
    print('  %-42s max G = %.12f  excess %+.3e  at %s' % (name, best[0], best[0]-T, np.round(best[1], 5)))

if __name__ == '__main__':
    print('TARGET sqrt(3/2) = %.12f' % T)
    print('--- structured families (b,c and shape swept) ---')
    bs = np.linspace(0.02, 0.99, 34)
    rs = np.linspace(0.0, 1.0, 21)          # c = r*b
    # one dominant + (k-1) equal tiny, k large
    for k in (2, 3, 5, 10, 16, 24):
        fam('dust k=%d  (lam1=1, rest=eps)' % k,
            lambda b, r, e, k=k: (np.concatenate([[1.0], np.full(k-1, e)]), b, r*b),
            [(b, r, e) for b in bs for r in rs for e in (1e-1, 1e-2, 1e-3, 1e-4, 1e-6)])
    # all positives equal
    for k in (1, 2, 3, 5, 8, 14):
        fam('equal positives k=%d' % k,
            lambda b, r, k=k: (np.ones(k), b, r*b),
            [(b, r) for b in bs for r in rs])
    # geometric decay
    for k in (3, 6, 11):
        fam('geometric k=%d' % k,
            lambda b, r, q, k=k: (q**np.arange(k), b, r*b),
            [(b, r, q) for b in bs for r in rs for q in (0.1, 0.3, 0.5, 0.7, 0.9, 0.99)])
    # two-scale: j big equal + (k-j) small equal
    for (k, j) in ((4, 2), (6, 2), (6, 3), (10, 3), (12, 6)):
        fam('two-scale k=%d j=%d' % (k, j),
            lambda b, r, e, k=k, j=j: (np.concatenate([np.ones(j), np.full(k-j, e)]), b, r*b),
            [(b, r, e) for b in bs for r in rs for e in (1e-1, 0.3, 0.5, 1e-2, 1e-4)])
    print('--- b >> c and b = c extremes at k = 1..6 (SLSQP with r = c/b pinned) ---')
    for r in (1.0, 0.5, 0.1, 0.01, 1e-4):
        best = (-9, None)
        for k in range(1, 7):
            for _ in range(40):
                rng = np.random.default_rng()
                p = rng.random(k)**rng.uniform(.2, 4)
                b = rng.random()*0.8+0.05; c = r*b
                p = p*(b+c)/p.sum(); p, b, c = norm(p, b, c)
                def f(x, k=k, r=r):
                    pp = np.abs(x[:k]); bb = abs(x[k]); cc = r*bb
                    n = np.linalg.norm(np.concatenate([pp, [bb, cc]]))
                    if n == 0: return 1e9
                    pp, bb, cc = pp/n, bb/n, cc/n
                    pen = 1e3*abs(pp.sum()-bb-cc)
                    return -G_closed(pp, bb, cc) + pen
                res = minimize(f, np.concatenate([p, [b]]), method='Nelder-Mead',
                               options={'maxiter':6000, 'fatol':1e-14, 'xatol':1e-12})
                if -res.fun > best[0]: best = (-res.fun, k)
        print('  c/b = %-7g  max G = %.12f  excess %+.3e  (k=%d)' % (r, best[0], best[0]-T, best[1]))
    print('--- the reported "max G by k" table: random sampling reproduction ---')
    rng = np.random.default_rng(0)
    for k in range(1, 8):
        m = -9
        for _ in range(700):
            p = rng.random(k)**rng.uniform(0.3, 3)
            b, c = np.sort(rng.random(2)+1e-3)[::-1]
            p = p*(b+c)/p.sum(); p, b, c = norm(p, b, c)
            m = max(m, G_closed(p, b, c))
        print('  k=%d  700 random draws -> max %.6f   |  true sup (SLSQP/limit) = %.9f' % (k, m, T))
