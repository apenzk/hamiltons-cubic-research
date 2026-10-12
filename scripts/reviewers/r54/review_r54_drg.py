"""K4: blow-ups of named triangle-free non-bipartite graphs, via association schemes.

For a distance-regular graph on k vertices with distance classes R_1..R_s and equal
blocks of size m, the block matrix w is constant on classes: w_aa = d, w_ab = x_h for
(a,b) in R_h.  Q stays in that algebra, with

    Q_aa = (m-1) d^2 + m sum_i v_i x_i^2
    Q_h  = x_h^2 + 2(m-1) d x_h + m sum_{i,j>=1} p^h_{ij} x_i x_j
    Ric  = (m-1) d + m sum_i v_i x_i
    |W|^2 = k C(m,2) d^2 + sum_i (k v_i / 2) m^2 x_i^2
    P     = k C(m,2) d Q_aa + sum_i (k v_i / 2) m^2 x_i Q_h .

The negative graph is the union of the classes with x_h < 0 (plus all of every block
when d < 0); S = 0 iff that union graph is triangle-free and d >= 0.
"""
import itertools, sys
from math import comb
import numpy as np
from scipy.optimize import least_squares


def distance_classes(adjacency):
    k = len(adjacency)
    INF = 10**6
    D = np.full((k, k), INF, int)
    for i in range(k):
        D[i, i] = 0
        frontier = [i]; dist = 0
        seen = {i}
        while frontier:
            dist += 1
            nxt = []
            for u in frontier:
                for v in range(k):
                    if adjacency[u][v] and v not in seen:
                        seen.add(v); D[i, v] = dist; nxt.append(v)
            frontier = nxt
    return D


def scheme(adjacency):
    """distance classes and intersection numbers; verifies distance-regularity."""
    k = len(adjacency)
    D = distance_classes(adjacency)
    s = int(D[D < 10**6].max())
    v = [int((D[0] == h).sum()) for h in range(s+1)]
    for a in range(k):
        for h in range(s+1):
            if int((D[a] == h).sum()) != v[h]:
                return None, None, None, "not distance-regular (valencies vary)"
    p = np.zeros((s+1, s+1, s+1), int)
    for h in range(1, s+1):
        reps = [(a, b) for a in range(k) for b in range(k) if D[a, b] == h]
        first = None
        for (a, b) in reps:
            M = np.zeros((s+1, s+1), int)
            for c in range(k):
                if c == a or c == b: continue
                M[D[a, c], D[b, c]] += 1
            if first is None:
                first = M; p[h] = M
            elif not np.array_equal(first, M):
                return None, None, None, f"not distance-regular (p^{h} varies)"
    return D, v, p, "ok"


def drg_solve(adjacency, m, starts=600, seed=0):
    k = len(adjacency)
    D, v, p, msg = scheme(adjacency)
    if D is None:
        return None, msg
    s = p.shape[0] - 1
    rng = np.random.default_rng(seed)

    def pieces(z):
        d = z[0]; x = z[1:1+s]
        Qaa = (m-1)*d**2 + m*sum(v[i]*x[i-1]**2 for i in range(1, s+1))
        Qh = []
        for h in range(1, s+1):
            t = x[h-1]**2 + 2*(m-1)*d*x[h-1]
            t += m*sum(p[h, i, j]*x[i-1]*x[j-1] for i in range(1, s+1) for j in range(1, s+1))
            Qh.append(t)
        Ric = (m-1)*d + m*sum(v[i]*x[i-1] for i in range(1, s+1))
        nsq = k*comb(m, 2)*d**2 + sum(k*v[i]/2*m**2*x[i-1]**2 for i in range(1, s+1))
        Praw = k*comb(m, 2)*d*Qaa + sum(k*v[i]/2*m**2*x[i-1]*Qh[i-1] for i in range(1, s+1))
        return d, x, Qaa, Qh, Ric, nsq, Praw

    def resid(z):
        d, x, Qaa, Qh, Ric, nsq, Praw = pieces(z[:-1])
        mu = z[-1]
        r = [Ric, Qaa - mu*d] + [Qh[i] - mu*x[i] for i in range(s)] + [nsq - 1.0]
        return np.array(r)

    sols = []
    for _ in range(starts):
        z0 = np.append(rng.normal(size=1+s), rng.normal()*2)
        sol = least_squares(resid, z0, xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=4000)
        if np.linalg.norm(sol.fun) > 1e-11: continue
        d, x, Qaa, Qh, Ric, nsq, Praw = pieces(sol.x[:-1])
        th = Praw / nsq**1.5
        if th < 0:
            d, x, th = -d, -x, -th
        if th < 1e-8: continue
        key = np.round(np.append(np.append(d, x), th), 7)
        if any(np.allclose(key, kk, atol=1e-5) for kk in sols_keys(sols)): continue
        # S = 0?  negative graph = union of classes with x_h < 0, plus blocks if d < 0
        negcls = [h for h in range(1, s+1) if x[h-1] < -1e-9]
        A2 = np.zeros((k, k), int)
        for h in negcls:
            A2[D == h] = 1
        tri_between = sum(1 for a, b, c in itertools.combinations(range(k), 3)
                          if A2[a, b] and A2[a, c] and A2[b, c])
        tri = tri_between * m**3
        if d < -1e-9:
            tri += k*comb(m, 3) + sum(comb(m, 2)*m*int(A2[a].sum()) for a in range(k))
        # merged?  all classes equal -> coarser
        distinct = len(set(np.round(np.append(d, x), 6)))
        sols.append((d, np.array(x), th, tri, negcls, distinct))
    return sols, "ok"


def sols_keys(sols):
    for d, x, th, tri, negcls, dist in sols:
        yield np.round(np.append(np.append(d, x), th), 7)


def cycle_adj(k):
    return [[1 if (a-b) % k in (1, k-1) else 0 for b in range(k)] for a in range(k)]


def kneser_adj(nn, kk):
    sets = list(itertools.combinations(range(nn), kk))
    return [[1 if not set(a) & set(b) else 0 for b in sets] for a in sets], sets


def theta0(n):
    return np.sqrt(2.0*(n-1)*(n-2))/n


if __name__ == "__main__":
    graphs = [("C_5", cycle_adj(5)), ("C_7", cycle_adj(7)), ("C_9", cycle_adj(9)),
              ("C_11", cycle_adj(11)), ("C_13", cycle_adj(13)),
              ("Petersen K(5,2)", kneser_adj(5, 2)[0]),
              ("odd graph K(7,3)", kneser_adj(7, 3)[0]),
              ("Kneser K(9,4)", kneser_adj(9, 4)[0])]
    print(f"{'graph':>18} {'k':>4} {'m':>5} {'n':>6} {'theta':>11} {'theta/theta_0':>14} "
          f"{'S=0?':>6} {'genuine':>8}")
    for name, A in graphs:
        k = len(A)
        for m in [2, 3, 5, 10, 40, 200, 2000]:
            sols, msg = drg_solve(A, m, starts=(400 if k <= 11 else 250), seed=k*m)
            if sols is None:
                print(f"{name:>18} {k:>4} {'-':>5} {'-':>6}  {msg}")
                break
            best = None
            for d, x, th, tri, negcls, distinct in sols:
                genuine = distinct == len(x) + 1
                if tri == 0 and genuine:
                    if best is None or th > best[2]:
                        best = (d, x, th, tri, negcls, distinct)
            allbest = max(sols, key=lambda t: t[2])
            n = k*m
            if best is not None:
                print(f"{name:>18} {k:>4} {m:>5} {n:>6} {best[2]:>11.7f} {best[2]/theta0(n):>14.7f} "
                      f"{'yes':>6} {'yes':>8}   (best overall {allbest[2]/theta0(n):.6f}, "
                      f"S={3*allbest[3]}, distinct={allbest[5]})")
            else:
                print(f"{name:>18} {k:>4} {m:>5} {n:>6} {'-':>11} {'-':>14} {'none':>6} {'-':>8}"
                      f"   (best overall {allbest[2]/theta0(n):.6f}, S={3*allbest[3]})")
