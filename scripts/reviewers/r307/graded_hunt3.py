"""Small-kick hunt with pool re-seeding: every graded point found becomes a new seed."""
import sys, time, numpy as np
sys.path.insert(0, 'scripts/reviewers/r307')
from core307 import *
from solve307 import block_basis
from cubic307 import cached_TQ
from sweep307 import make_fast, classify
from gn307 import gauss_newton

KICKS = (0.02, 0.035, 0.05, 0.07, 0.09, 0.12)

def hunt(n, p, rounds, per_round, seed=1, extra=()):
    B = block_basis(n, p); TQ = cached_TQ(n, p, B)
    resid, jac = make_fast(TQ); d = B.shape[0]
    W0 = sphere_product_W(n, p)
    print(f'  control |resid(S^{p}xS^{n-p})| = {np.abs(resid(np.einsum("aij,ij->a",B,W0))).max():.2e}'
          f'  dim={d}', flush=True)
    pool = [np.einsum('aij,ij->a', B, W0)]
    for X in extra:
        pool.append(np.einsum('aij,ij->a', B, X/np.linalg.norm(X)))
    found = {}
    rng = np.random.default_rng(seed)
    t0 = time.time()
    for rd in range(rounds):
        for t in range(per_round):
            base = pool[rng.integers(len(pool))]
            c = base + KICKS[rng.integers(len(KICKS))]*rng.normal(size=d)
            c /= np.linalg.norm(c)
            c, r = gauss_newton(resid, jac, c)
            if r > 1e-11:
                continue
            rec = classify(n, np.einsum('a,aij->ij', c, B))
            if rec['crit'] > 1e-10 or not rec['graded']:
                continue
            k = (round(rec['theta'], 7), rec['dimp'], round(rec['A2'], 7))
            if k not in found:
                found[k] = rec
                pool.append(c)
        print(f'  round {rd+1}/{rounds}: distinct graded {len(found)}  pool {len(pool)}'
              f'  ({time.time()-t0:.0f}s)', flush=True)
    return found, B


if __name__ == '__main__':
    n = int(sys.argv[1]); p = int(sys.argv[2])
    rounds = int(sys.argv[3]); per = int(sys.argv[4])
    seed = int(sys.argv[5]) if len(sys.argv) > 5 else 1
    extra = ()
    if n == 8 and p == 3:
        extra = (np.load('scripts/data/w_n8_nondiagonal_witness.npy'),)
    print(f'== n={n} pair so({p})+so({n-p})', flush=True)
    found, B = hunt(n, p, rounds, per, seed, extra)
    print(f"\n{'theta':>11}{'dim p':>7}{'#pos':>6}{'|A|^2':>12}{'|B|^2':>12}{'leak':>10}")
    for k in sorted(found, reverse=True):
        r = found[k]
        print(f"{r['theta']:>11.7f}{r['dimp']:>7}{r['npos']:>6}{r['A2']:>12.7f}"
              f"{1-r['A2']:>12.7f}{r['leak']:>10.1e}")
    a2 = np.array([r['A2'] for r in found.values()])
    th = np.array([r['theta'] for r in found.values()])
    if len(a2):
        print(f"\ndistinct graded points: {len(a2)}")
        print(f"|A|^2: min {a2.min():.7f}  max {a2.max():.7f}  spread {a2.max()-a2.min():.7f}"
              f"  = {100*(a2.max()-a2.min())/a2.mean():.2f}% of mean")
        print(f"theta: min {th.min():.7f}  max {th.max():.7f}   sqrt(3/2) = 1.2247449")
        print(f"theta > sqrt(3/2)? {(th > 1.2247449).sum()} of {len(th)}")
        np.save(f'scripts/reviewers/r307/gradedpts_n{n}_p{p}_s{seed}.npy',
                np.array([r['W'] for r in found.values()]))
