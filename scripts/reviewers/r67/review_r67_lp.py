"""Reviewer 67 -- C5: the exact ceiling of the whole class of bounds (a)/(b)/(c)/(d)/(e).

Every one of those bounds is derived from exactly three facts about T:
  T >= 0 totally symmetric, vanishing when two indices coincide;
  row marginal   sum_{b,g} T_abg = 2(n-2)   for every a;
  pair cap       sum_g T_abg <= 2           for every a != b;
  isotropy       T = 0 on triples inside m  (S_mmm = 0).
So the LP
      max_T  theta(lam,T)  subject to those constraints
is a LOWER barrier for every bound in the class: no such bound can be smaller
than the LP value at any (lam, d) for which the LP is feasible.
"""
import numpy as np, sys
from itertools import combinations
from scipy.optimize import linprog, minimize
from review_r67_core import theta0


def build_lp(N, n, d):
    tris = list(combinations(range(N), 3))
    nv = len(tris)
    mset = set(range(d))
    ub = np.array([0.0 if {a, b, g} <= mset else 2.0 for (a, b, g) in tris])
    Aeq = np.zeros((N, nv))
    for i, (a, b, g) in enumerate(tris):
        Aeq[a, i] = 1.0; Aeq[b, i] = 1.0; Aeq[g, i] = 1.0
    prs = list(combinations(range(N), 2))
    pidx = {p: i for i, p in enumerate(prs)}
    Aub = np.zeros((len(prs), nv))
    for i, (a, b, g) in enumerate(tris):
        Aub[pidx[(a, b)], i] = 1.0; Aub[pidx[(a, g)], i] = 1.0; Aub[pidx[(b, g)], i] = 1.0
    return tris, ub, Aeq, np.full(N, float(n - 2)), Aub, np.full(len(prs), 2.0)


def lp_value(lam, n, d, pre):
    tris, ub, Aeq, beq, Aub, bub = pre
    obj = np.array([-3.0 * lam[a] * lam[b] * lam[g] for (a, b, g) in tris])
    res = linprog(obj, A_ub=Aub, b_ub=bub, A_eq=Aeq, b_eq=beq,
                  bounds=list(zip(np.zeros_like(ub), ub)), method='highs')
    if not res.success:
        return None
    return float(np.sum(lam ** 3) - res.fun)


def structured_lam(par, P, d, N):
    a = np.abs(par[:4]) + 1e-13
    b = np.abs(par[4:6]) + 1e-13
    pos = np.concatenate([a[:3][:P], np.full(max(P - 3, 0), a[3])])[:P]
    neg = np.concatenate([[b[0]], np.full(max(d - 1, 0), b[1])])[:d]
    neg = neg * (pos.sum() / neg.sum())
    lam = np.concatenate([-neg, pos, np.zeros(N - d - P)])
    return lam / np.linalg.norm(lam)


if __name__ == "__main__":
    n = int(sys.argv[1])
    N = n * (n - 1) // 2
    cap = (n * n) // 4
    tgt = max(np.sqrt(1.5), theta0(n))
    print(f"n={n} N={N} cap={cap} target={tgt:.6f}  #triples={N*(N-1)*(N-2)//6}", flush=True)
    overall = (-1e9, None, None)
    ds = [d for d in range(3, cap)]
    if len(sys.argv) > 2:
        ds = [int(x) for x in sys.argv[2].split(',')]
    for d in ds:
        pre = build_lp(N, n, d)
        best = (-1e9, None, None)
        for P in sorted(set([1, 2, 3, 4, 5, 6, 8, min(12, N - d), N - d])):
            if not (1 <= P <= N - d):
                continue
            for k in range(6):
                x0 = np.random.default_rng(9173 * d + 41 * P + k).standard_normal(6)
                r = minimize(lambda x: -(lp_value(structured_lam(x, P, d, N), n, d, pre) or -1e9),
                             x0, method='Nelder-Mead',
                             options=dict(maxfev=120, fatol=1e-9, xatol=1e-7))
                v = -r.fun
                if v > best[0]:
                    best = (v, P, structured_lam(r.x, P, d, N))
        print(f"  d={d:3d}  LP ceiling max = {best[0]:9.5f}   (P={best[1]})", flush=True)
        if best[0] > overall[0]:
            overall = (best[0], d, best[2])
    print(f"n={n}  LP CLASS CEILING >= {overall[0]:.6f} at d={overall[1]}, target {tgt:.6f}, ratio {overall[0]/tgt:.3f}")
    print(f"  witness spectrum (top 10): {np.array2string(np.sort(overall[2])[::-1][:10], precision=6)}")
    print(f"  witness spectrum (bottom 5): {np.array2string(np.sort(overall[2])[:5], precision=6)}")
