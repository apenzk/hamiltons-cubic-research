"""r68: the sharpest bound expressible in the (T, lam) language -- computed exactly by LP.

For a FIXED spectrum lam, theta is linear in T, and every structural fact the recorded
bounds use is a linear constraint on T:

    T_t >= 0                                        (nonnegativity)
    sum_{t ni a} T_t = n-2          for each a      (row marginal 2(n-2), ordered count)
    sum_{t sup {a,b}} T_t <= 2      for each a<b    (pair cap)
    T_t = 0 for t inside m                          (S_mmm = 0)

so max_T theta(T, lam) is an LP -- the exact supremum of theta over the relaxation the
bounds are derived from, i.e. the best bound ANY argument using only these facts can give.

Optionally adds the vector identity  sum_b ||[v_a,v_b]||^2 lam_b = -2 lam_a, which every
genuine Weyl operator satisfies and which is also linear in T:

    sum_{t ni a} T_t * (sum_{b in t, b != a} lam_b) = -2 lam_a.
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from itertools import combinations
from scipy.optimize import linprog
from scipy.sparse import lil_matrix, csr_matrix
import review_r68_core as R


def lp_sup(n, lam, use_vecid=False, tol=1e-12, verbose=False):
    N = len(lam)
    assert N == n*(n-1)//2
    m = set(np.where(lam < -tol)[0].tolist())
    tris = [t for t in combinations(range(N), 3) if not set(t) <= m]     # S_mmm = 0
    nt = len(tris)
    obj = np.array([-3.0*lam[a]*lam[b]*lam[g] for (a, b, g) in tris])    # maximise
    # equality: row marginals
    Aeq = lil_matrix((N + (N if use_vecid else 0), nt))
    beq = np.zeros(N + (N if use_vecid else 0))
    for j, t in enumerate(tris):
        for a in t:
            Aeq[a, j] += 1.0
    beq[:N] = n - 2
    if use_vecid:
        for j, t in enumerate(tris):
            st = lam[list(t)].sum()
            for a in t:
                Aeq[N + a, j] += (st - lam[a])
        beq[N:] = -2.0*lam
    # inequality: pair caps
    pairs = list(combinations(range(N), 2))
    pidx = {p: i for i, p in enumerate(pairs)}
    Aub = lil_matrix((len(pairs), nt))
    for j, t in enumerate(tris):
        for p in combinations(t, 2):
            Aub[pidx[p], j] += 1.0
    bub = 2.0*np.ones(len(pairs))
    res = linprog(obj, A_ub=csr_matrix(Aub), b_ub=bub, A_eq=csr_matrix(Aeq), b_eq=beq,
                  bounds=(0, None), method='highs')
    if not res.success:
        return None, res.message
    return float(np.sum(lam**3) - res.fun), res


if __name__ == '__main__':
    from review_r68_bounds import bounds
    from review_r68_c5_obstruction import W_sd_split
    ns = [int(a) for a in sys.argv[1:]] or [6]
    for n in ns:
        C = R.struct(n)
        N = n*(n-1)//2
        th0 = ((n-1)/n)*np.sqrt(2*(n-2)/(n-1))
        target = max(np.sqrt(1.5), th0)
        cases = [('padded CP^2', np.linalg.eigvalsh(R.padded_cp2(n))),
                 ('balanced sphere', np.linalg.eigvalsh(R.sphere_product(n, n//2))),
                 ('SD-split relaxation pt', np.linalg.eigvalsh(W_sd_split(n, 4)))]
        # plus the spectrum that maximises bound (c)
        try:
            from review_r68_c5_fast import build
            cases.append(('bound-(c) maximiser', build((0.2169, 0.4262), 1, 12, 15, N) if n == 8 else None))
        except Exception:
            pass
        for name, lam in cases:
            if lam is None:
                continue
            bd = bounds(lam, n)
            v0, _ = lp_sup(n, lam, use_vecid=False)
            v1, r1 = lp_sup(n, lam, use_vecid=True)
            print(f"n={n} {name:24s} theta_actual/---  bound(c)={bd['c']:9.4f}  "
                  f"LP sup (marginals+cap+S0) = {v0 if v0 is None else round(v0,6)}   "
                  f"LP sup (+ vector identity) = {v1 if v1 is None else round(v1,6)}   target={target:.6f}")
            sys.stdout.flush()
