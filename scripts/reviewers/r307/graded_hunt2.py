"""Sign-biased hunt: start from W = A (+) B with A positive definite on the p-block and B
negative definite on the m-block, projected onto the block-diagonal Weyl subspace."""
import sys, time, numpy as np
sys.path.insert(0, 'scripts/reviewers/r307')
from core307 import *
from solve307 import block_basis
from cubic307 import cached_TQ
from sweep307 import make_fast, classify
from gn307 import gauss_newton


def hunt(n, p, nstarts, seed=1, verbose=True):
    B = block_basis(n, p)
    TQ = cached_TQ(n, p, B)
    resid, jac = make_fast(TQ)
    d = B.shape[0]
    ip, im = pm_index(n, p)
    N = B.shape[1]
    W0 = sphere_product_W(n, p)
    c0 = np.einsum('aij,ij->a', B, W0)
    if verbose:
        print(f'  control |resid| = {np.abs(resid(c0)).max():.2e}  dim={d}', flush=True)
    rng = np.random.default_rng(seed)
    rows, t0 = [], time.time()
    nsign = 0
    for t in range(nstarts):
        # random start with the graded sign pattern
        a = rng.normal(size=(len(ip), len(ip))); a = a @ a.T
        b = rng.normal(size=(len(im), len(im))); b = b @ b.T
        sc = rng.uniform(0.3, 3.0)
        Ws = np.zeros((N, N))
        Ws[np.ix_(ip, ip)] = a/np.linalg.norm(a)
        Ws[np.ix_(im, im)] = -sc*b/np.linalg.norm(b)
        c = np.einsum('aij,ij->a', B, Ws)
        c /= np.linalg.norm(c)
        c, r = gauss_newton(resid, jac, c)
        if r > 1e-11:
            continue
        rec = classify(n, np.einsum('a,aij->ij', c, B))
        if rec['crit'] > 1e-10:
            continue
        rows.append(rec)
        if rec['graded']:
            nsign += 1
        if verbose and (t+1) % 100 == 0:
            print(f'    {t+1}/{nstarts} solved={len(rows)} graded={nsign} '
                  f'({time.time()-t0:.0f}s)', flush=True)
    return rows, B


if __name__ == '__main__':
    n = int(sys.argv[1]); p = int(sys.argv[2]); ns = int(sys.argv[3])
    seed = int(sys.argv[4]) if len(sys.argv) > 4 else 1
    print(f'== n={n} pair so({p})+so({n-p})', flush=True)
    rows, B = hunt(n, p, ns, seed)
    g = [r for r in rows if r['graded']]
    print(f'\nsolved {len(rows)}, graded {len(g)}')
    seen = {}
    for r in g:
        k = (round(r['theta'], 7), r['dimp'], round(r['A2'], 7), r['npos'])
        seen[k] = seen.get(k, 0) + 1
    print(f"{'theta':>11}{'dim p':>7}{'#pos':>6}{'|A|^2':>12}{'mult':>6}")
    for k in sorted(seen, reverse=True):
        print(f"{k[0]:>11.6f}{k[1]:>7}{k[3]:>6}{k[2]:>12.6f}{seen[k]:>6}")
    if g:
        a2 = np.array([r['A2'] for r in g]); th = np.array([r['theta'] for r in g])
        print(f"\n|A|^2 graded: min {a2.min():.6f} max {a2.max():.6f} spread {a2.max()-a2.min():.6f}")
        print(f"theta graded: min {th.min():.6f} max {th.max():.6f}  sqrt(3/2)=1.224745")
        np.save(f'scripts/reviewers/r307/graded2_n{n}_p{p}_s{seed}.npy',
                np.array([r['W'] for r in g]))
