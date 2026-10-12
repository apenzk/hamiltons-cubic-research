"""Reviewer 25, randomised / systematic hunt for a subalgebra h subset so(n)
satisfying (F1)-(F3) with dim h > n(n-2)/4."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, itertools, time; sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
import numpy as np
import review_r25_core as R, review_r25_tests as T, review_r25_subalgebras as S, review_r25_fix as F

def close_under_bracket(n, seeds, maxdim=None):
    V = [X.flatten() for X in seeds]
    A = np.array(V)
    def rank_basis(A):
        U, s, Vt = np.linalg.svd(A, full_matrices=False)
        k = int((s > 1e-8*max(s[0],1e-12)).sum())
        return Vt[:k]
    B = rank_basis(A)
    for _ in range(30):
        mats = [b.reshape(n,n) for b in B]
        new = list(B)
        for X, Y in itertools.combinations(mats, 2):
            new.append((X@Y - Y@X).flatten())
        B2 = rank_basis(np.array(new))
        if B2.shape[0] == B.shape[0]:
            break
        B = B2
        if maxdim and B.shape[0] > maxdim:
            break
    return [b.reshape(n,n) for b in B]

def normaliser_extras(n, gens, tries=400, seed=0):
    """look for O(n) elements normalising h among signed permutation matrices."""
    out = []
    idxs = list(range(n))
    rng = np.random.default_rng(seed)
    seen = set()
    for _ in range(tries):
        p = rng.permutation(n)
        sgn = rng.choice([-1.0, 1.0], size=n)
        g = np.zeros((n,n))
        for i in range(n):
            g[p[i], i] = sgn[i]
        key = tuple(p) + tuple(sgn)
        if key in seen: continue
        seen.add(key)
        if F.normalizes(gens, g) < 1e-8:
            out.append(g)
        if len(out) > 12: break
    return out

def report(nm, n, gens, extra):
    d = T.analyse(nm, n, gens, extra)
    if 'skip' in d: return None
    ok = (d['F1h']==1 and d['F1m']==1 and d['F2']==1 and d['F3']==0)
    d['member'] = ok
    return d

if __name__ == "__main__":
    rng = np.random.default_rng(12345)
    found = {}
    t0 = time.time()
    for n in range(5, 10):
        N = n*(n-1)//2
        cap = n*(n-2)/4
        seen_dims = {}
        for trial in range(400):
            k = rng.integers(1, 4)
            seeds = []
            for _ in range(k):
                X = rng.normal(size=(n,n)); X = X - X.T
                # sparsify to hit real subalgebras more often
                mask = rng.random((n,n)) < 0.5
                X = X * (mask | mask.T)
                X = X - X.T
                seeds.append(X)
            gens = close_under_bracket(n, seeds, maxdim=N)
            r = len(gens)
            if r == 0 or r >= N: continue
            key = (n, r)
            if seen_dims.get(key, 0) > 3: continue
            seen_dims[key] = seen_dims.get(key, 0) + 1
            ex = normaliser_extras(n, gens, tries=120, seed=trial)
            d = report(f"rand-n{n}-r{r}", n, gens, ex)
            if d and d['member']:
                print(f"MEMBER n={n} r={r} cap={cap} theta={d['theta']:.6f} pred={d['theta_pred']:.6f} "
                      f"resid={d['crit_resid']:.1e} Smmm={d['Smmm']:.3f}/{d['Smmm_pred']:.3f} "
                      f"VIOLATES={r>cap}", flush=True)
                found.setdefault((n,r), d)
        print(f"n={n} done, dims seen: {sorted(set(kk[1] for kk in seen_dims))} ({time.time()-t0:.0f}s)", flush=True)
    print("members found:", sorted(found.keys()))
