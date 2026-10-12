"""Hunt for GRADED critical points on a fixed symmetric pair, and measure the spread of
||A||^2 = sum_{lam>0} lam^2 across them.  A point counts as graded only if its own strictly
positive eigenspace p and strictly negative eigenspace m satisfy [p,p]<p, [p,m]<m, [m,m]<p
and ker W = 0."""
import sys, time, numpy as np
sys.path.insert(0, 'scripts/reviewers/r307')
from core307 import *
from solve307 import block_basis
from cubic307 import cached_TQ
from sweep307 import make_fast, classify
from gn307 import gauss_newton


def hunt(n, p, nstarts, seed=1, kicks=(0.2, 0.5, 0.8, 1.2, 2.0), extra_seeds=()):
    B = block_basis(n, p)
    TQ = cached_TQ(n, p, B)
    resid, jac = make_fast(TQ)
    d = B.shape[0]
    W0 = sphere_product_W(n, p)
    c0 = np.einsum('aij,ij->a', B, W0)
    print(f'  control |resid(S^{p}xS^{n-p})| = {np.abs(resid(c0)).max():.2e}  dim={d}', flush=True)
    seeds = [c0] + [np.einsum('aij,ij->a', B, X/np.linalg.norm(X)) for X in extra_seeds]
    rng = np.random.default_rng(seed)
    rows, t0 = [], time.time()
    for t in range(nstarts):
        base = seeds[t % len(seeds)]
        k = kicks[(t // len(seeds)) % len(kicks)]
        c = base + k*rng.normal(size=d)
        c /= np.linalg.norm(c)
        c, r = gauss_newton(resid, jac, c)
        if r > 1e-11:
            continue
        rec = classify(n, np.einsum('a,aij->ij', c, B))
        if rec['crit'] > 1e-10:
            continue
        rows.append(rec)
        if (t+1) % 200 == 0:
            g = [x for x in rows if x['graded']]
            print(f'    {t+1}/{nstarts} solved={len(rows)} graded={len(g)} ({time.time()-t0:.0f}s)',
                  flush=True)
    return rows, B


def summarize(rows, label):
    g = [r for r in rows if r['graded']]
    print(f'\n### {label}: solved {len(rows)}, graded {len(g)}')
    seen = {}
    for r in sorted(g, key=lambda r: -r['theta']):
        k = (round(r['theta'], 7), r['dimp'], round(r['A2'], 7))
        seen[k] = seen.get(k, 0) + 1
    print(f"{'theta':>11}{'dim p':>7}{'#pos eig':>10}{'|A|^2':>12}{'mult':>6}")
    for k in sorted(seen, reverse=True):
        th, dp, a2 = k
        r = next(x for x in g if round(x['theta'],7)==th and round(x['A2'],7)==a2)
        print(f"{th:>11.6f}{dp:>7}{r['npos']:>10}{a2:>12.6f}{seen[k]:>6}")
    return g


if __name__ == '__main__':
    n = int(sys.argv[1]); p = int(sys.argv[2]); ns = int(sys.argv[3])
    seed = int(sys.argv[4]) if len(sys.argv) > 4 else 1
    extra = ()
    if n == 8 and p == 3:
        extra = (np.load('scripts/data/w_n8_nondiagonal_witness.npy'),)
    print(f'== n={n} pair so({p})+so({n-p})', flush=True)
    rows, B = hunt(n, p, ns, seed, extra_seeds=extra)
    g = summarize(rows, f'n={n} p={p}')
    if g:
        a2 = np.array([r['A2'] for r in g]); th = np.array([r['theta'] for r in g])
        print(f"\n|A|^2 over graded points: min {a2.min():.6f} max {a2.max():.6f} "
              f"spread {a2.max()-a2.min():.6f}  ({100*(a2.max()-a2.min())/a2.mean():.2f}% of mean)")
        print(f"theta: min {th.min():.6f} max {th.max():.6f}   sqrt(3/2)=1.224745")
        np.save(f'scripts/reviewers/r307/graded_n{n}_p{p}_s{seed}.npy',
                np.array([r['W'] for r in g]))
