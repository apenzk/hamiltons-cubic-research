"""Reviewer 67 -- C5: maximise bound (c) over the open band, and build sharper
valid bounds of the same kind (marginals + pair caps + S=0 only).

New bounds introduced here (all proved in reviews/REVIEW_r67.md):
  (d)  knapsack refinement: each block's mass is spent on its most valuable
       triples/pairs subject to BOTH the pair cap (<=2 each) and the marginal
       mass budget -- strictly sharper than the min of the two crude bounds.
  (e)  per-row refinement: the row marginal is an identity for EVERY index,
       so each positive index a can spend at most (n-2) of pair-mass.
  LP   the exact ceiling of the whole class: maximise theta over all totally
       symmetric T >= 0 with the row marginals, the pair caps and S=0.
"""
import numpy as np
from itertools import combinations
from scipy.optimize import minimize, linprog
from review_r67_core import *


# ---------------------------------------------------------------- spectra

def make_lam(x, d, N):
    neg = np.abs(x[:d]) + 1e-13
    pos = np.abs(x[d:]) + 1e-13
    neg = neg * (pos.sum() / neg.sum())
    lam = np.concatenate([-neg, pos])
    return lam / np.linalg.norm(lam)


def maximise(fn, n, N, d, nstart=25, seed=0, maxfev=20000):
    best = (-1e9, None)
    for k in range(nstart):
        x0 = np.random.default_rng(seed * 104729 + k).standard_normal(N)
        r = minimize(lambda x: -fn(make_lam(x, d, N), n, N), x0, method='Nelder-Mead',
                     options=dict(maxfev=maxfev, fatol=1e-13, xatol=1e-11))
        if -r.fun > best[0]:
            best = (-r.fun, make_lam(r.x, d, N))
    return best


# ---------------------------------------------------------------- knapsack helper

def knap(vals, cap, budget):
    """max sum w_i vals_i with 0<=w_i<=cap, sum w_i <= budget.  vals sorted desc, >=0."""
    tot, rem = 0.0, budget
    for v in vals:
        if rem <= 0 or v <= 0:
            break
        take = min(cap, rem)
        tot += take * v
        rem -= take
    return tot


def top_pair_products(vals, needed):
    """A list that DOMINATES the `needed` largest products v_b*v_g over unordered pairs.

    Enumerating only the top-k entries would UNDER-estimate the knapsack (a pair
    (1, k+1) can beat a pair (k-1, k)), and an under-estimated knapsack is not an
    upper bound.  So the truncated list is padded with copies of v_0*v_k, which
    dominates every pair that uses an index beyond the truncation."""
    v = np.sort(np.asarray(vals))[::-1]
    n = len(v)
    if n < 2:
        return np.array([0.0])
    k = 2
    while k < n and k * (k - 1) / 2 < needed:
        k += 1
    k = min(n, max(k, 2))
    p = [v[i] * v[j] for i, j in combinations(range(k), 2)]
    if k < n:
        p += [v[0] * v[k]] * int(np.ceil(needed) + 1)
    return np.sort(np.array(p))[::-1]


def top_triple_products(vals, needed):
    """Same domination trick for triples: pad with v_0*v_1*v_k."""
    v = np.sort(np.asarray(vals))[::-1]
    n = len(v)
    if n < 3:
        return np.array([0.0])
    k = 3
    while k < n and k * (k - 1) * (k - 2) / 6 < needed:
        k += 1
    k = min(n, max(k, 3))
    p = [v[i] * v[j] * v[l] for i, j, l in combinations(range(k), 3)]
    if k < n:
        p += [v[0] * v[1] * v[k]] * int(np.ceil(needed) + 1)
    return np.sort(np.array(p))[::-1]


# ---------------------------------------------------------------- bound (d)/(e)

def bound_d(lam, n, N=None, tol=1e-12):
    st = spectral_stats(lam, tol)
    N = len(lam) if N is None else N
    d = st['d']
    pos, neg = st['pos'], np.abs(st['neg'])
    # ---- (+++): mass budget S_hhh <= (n-2)(2N-3d)/6, each triple <= 2
    Sh = (n - 2) * (2 * N - 3 * d) / 6.0
    tri = top_triple_products(pos, np.ceil(Sh / 2) + 2)
    ppp_mass = 3.0 * knap(tri, 2.0, Sh)
    ppp = min(st['h3'] * (st['s'] ** 2 - st['u']), ppp_mass)
    # ---- (+--): mass budget S_mmh <= d(n-2)/2, each m-pair <= 2
    Sm = d * (n - 2) / 2.0
    prs = top_pair_products(neg, np.ceil(Sm / 2) + 2) if d >= 2 else np.array([0.0])
    pmm_mass = 3.0 * st['lam1'] * knap(prs, 2.0, Sm)
    pmm = min(3 * st['lam1'] * (st['s'] ** 2 - st['v']), pmm_mass)
    return st['cube'] + ppp + pmm


def bound_e(lam, n, N=None, tol=1e-12):
    """(d) plus the per-row refinement: every index a obeys sum_{b<g} T_abg <= n-2."""
    st = spectral_stats(lam, tol)
    N = len(lam) if N is None else N
    d = st['d']
    pos, neg = st['pos'], np.abs(st['neg'])
    Sh = (n - 2) * (2 * N - 3 * d) / 6.0
    tri = top_triple_products(pos, np.ceil(Sh / 2) + 2)
    ppp_mass = 3.0 * knap(tri, 2.0, Sh)
    # per-row for (+++): 3(+++) = sum_a lam_a * sum_{b<g} T_abg lam_b lam_g,
    #                    sum_{b<g} T_abg <= n-2, each term <= 2
    ppp_row = 0.0
    ps = np.sort(pos)[::-1]
    for i, la in enumerate(ps):
        rest = np.delete(ps, i)
        pr = top_pair_products(rest, np.ceil((n - 2) / 2) + 2)
        ppp_row += la * knap(pr, 2.0, n - 2)
    ppp = min(st['h3'] * (st['s'] ** 2 - st['u']), ppp_mass, ppp_row)
    Sm = d * (n - 2) / 2.0
    prs = top_pair_products(neg, np.ceil(Sm / 2) + 2) if d >= 2 else np.array([0.0])
    pmm_mass = 3.0 * st['lam1'] * knap(prs, 2.0, Sm)
    # per-row for (+--): 3(+--) = 3 sum_{a>0} lam_a sum_{b<g in m} T_abg |l_b||l_g|
    prs2 = top_pair_products(neg, np.ceil((n - 2) / 2) + 2) if d >= 2 else np.array([0.0])
    pmm_row = 3.0 * st['s'] * knap(prs2, 2.0, n - 2)
    pmm = min(3 * st['lam1'] * (st['s'] ** 2 - st['v']), pmm_mass, pmm_row)
    return st['cube'] + ppp + pmm


# ---------------------------------------------------------------- the class ceiling: LP

def lp_ceiling(lam, n, d, tol=1e-12):
    """max theta over all T >= 0 totally symmetric with
       sum_{triples ni a} t = n-2 (row marginal),  sum_{triples sup {a,b}} t <= 2 (pair cap),
       t = 0 on triples inside m.   Returns (value, status)."""
    N = len(lam)
    tris = list(combinations(range(N), 3))
    idx = {t: i for i, t in enumerate(tris)}
    nv = len(tris)
    mset = set(np.where(lam < -tol)[0].tolist())
    obj = np.array([-3.0 * lam[a] * lam[b] * lam[g] for (a, b, g) in tris])
    ub = np.array([0.0 if {a, b, g} <= mset else 2.0 for (a, b, g) in tris])
    # row equalities
    rowsA = np.zeros((N, nv)); 
    for i, (a, b, g) in enumerate(tris):
        rowsA[a, i] = 1; rowsA[b, i] = 1; rowsA[g, i] = 1
    rowb = np.full(N, float(n - 2))
    # pair caps
    prs = list(combinations(range(N), 2))
    A2 = np.zeros((len(prs), nv))
    pidx = {p: i for i, p in enumerate(prs)}
    for i, (a, b, g) in enumerate(tris):
        A2[pidx[(a, b)], i] = 1; A2[pidx[(a, g)], i] = 1; A2[pidx[(b, g)], i] = 1
    res = linprog(obj, A_ub=A2, b_ub=np.full(len(prs), 2.0), A_eq=rowsA, b_eq=rowb,
                  bounds=[(0, u) for u in ub], method='highs')
    if not res.success:
        return None, res.message
    return float(np.sum(lam ** 3) - res.fun), 'ok'



# ---------------------------------------------------------------- band search

def structured_lam(par, P, d, N):
    """3 free top positives + (P-3) equal ones; 1 free top negative + (d-1) equal.
    par = 6 raw numbers.  Returns a unit traceless spectrum with exactly d negatives."""
    a = np.abs(par[:4]) + 1e-13          # top3 + bulk positive level
    b = np.abs(par[4:6]) + 1e-13         # top negative + bulk negative level
    pos = np.concatenate([a[:3][:P], np.full(max(P - 3, 0), a[3])])[:P]
    neg = np.concatenate([[b[0]], np.full(max(d - 1, 0), b[1])])[:d]
    neg = neg * (pos.sum() / neg.sum())
    lam = np.concatenate([-neg, pos, np.zeros(N - d - P)])
    return lam / np.linalg.norm(lam)


def band_max(fn, n, N, d, nstart=14, seed=0):
    best = (-1e9, None)
    Ps = sorted(set([1, 2, 3, 4, 5, 6, 8, 12, 20, N - d] + list(range(1, min(9, N - d) + 1))))
    Ps = [P for P in Ps if 1 <= P <= N - d]
    for P in Ps:
        for k in range(nstart):
            x0 = np.random.default_rng(seed * 7907 + 131 * P + k).standard_normal(6)
            r = minimize(lambda x: -fn(structured_lam(x, P, d, N), n, N), x0,
                         method='Nelder-Mead', options=dict(maxfev=1500, fatol=1e-13, xatol=1e-11))
            if -r.fun > best[0]:
                best = (-r.fun, structured_lam(r.x, P, d, N))
    # full-dimensional polish from the structured optimum
    lam0 = best[1]
    x0 = np.concatenate([np.abs(lam0[lam0 < 0]), lam0[lam0 >= 0]])
    r = minimize(lambda x: -fn(make_lam(x, d, N), n, N), x0, method='Nelder-Mead',
                 options=dict(maxfev=12000, fatol=1e-13, xatol=1e-11))
    if -r.fun > best[0]:
        best = (-r.fun, make_lam(r.x, d, N))
    return best


if __name__ == "__main__":
    import sys
    which = sys.argv[1]
    if which == 'band':
        n = int(sys.argv[2])
        N = n * (n - 1) // 2
        cap = (n * n) // 4
        tgt = max(np.sqrt(1.5), theta0(n))
        print(f"n={n} N={N} cap=floor(n^2/4)={cap} target={tgt:.6f}", flush=True)
        best = {k: (-1e9, None, None) for k in 'cde'}
        dlist = [int(x) for x in sys.argv[3].split(',')] if len(sys.argv) > 3 else list(range(3, cap))
        for d in dlist:
            line = f"  d={d:3d}"
            for key, fn in [('c', bound_c), ('d', bound_d), ('e', bound_e)]:
                v, l = band_max(fn, n, N, d, seed=d + 17 * n)
                line += f"  {key}={v:9.4f}"
                if v > best[key][0]:
                    best[key] = (v, d, l)
            print(line, flush=True)
        print(f"n={n} SUMMARY target={tgt:.6f}")
        for key in 'cde':
            v, d, l = best[key]
            print(f"   bound({key}): max={v:9.4f} at d={d:3d}  ratio {v/tgt:8.2f}")
            print(f"      argmax spectrum (nonzero): {np.array2string(np.sort(l)[::-1][:8], precision=5)} ... d={d}")
