"""F4, the diagonal half: hunt {critical, S = 0, Delta > 0} for theta above 0.671.

WHY THIS SEARCH IS OVER GRAPHS AND WHY IT NEEDS CRITICALITY.  On the diagonal
locus both of the target's hypotheses are combinatorial conditions on one weighted
graph M (symmetric, hollow, M1 = 0, sum_{a<b} M_ab^2 = 1):

    S = 0        <=>  the negative graph {M_ab < 0} is triangle-free
    Delta > 0    <=>  some POSITIVE edge joins two NON-twin vertices,
                      by the closed form in scripts/lib/b_defect_diagonal.py

and criticality is the equation of findings/diagonal-half.md, an n x n system:

    M o M + M^2 = theta M + diag(s),   s_i = sum_j M_ij^2,   theta = <MoM + M^2, M>/2.

CRITICALITY CANNOT BE DROPPED, and this run does not try.  Perturbing one
within-block entry of the balanced sphere product breaks twin-ness while leaving
the negative graph complete bipartite, so it stays in {S = 0, Delta > 0} while
theta moves continuously: the criticality-free supremum over that set is
theta_0(n) itself, approached and not attained.  Any bound proved without
criticality is therefore false.

WHAT IS SEARCHED.  Triangle-free graphs on n vertices as the intended negative
support -- structured ones (blow-ups of C_5, C_7, the Petersen and Grotzsch
graphs, complete bipartite and its subgraphs, triangle-free circulants) and random
maximal triangle-free graphs -- each seeded and solved to criticality, the solution
kept only if its OWN negative graph is still triangle-free.
"""
import sys, time, itertools
import numpy as np
from scipy.optimize import least_squares
sys.path.insert(0, 'scripts/lib')
from b_defect_diagonal import delta_closed

TOL = 1e-9


def theta_of(M):
    return 0.5 * (float((M ** 3).sum()) + float(np.trace(M @ M @ M)))


def resid(x, n, iu):
    M = np.zeros((n, n)); M[iu] = x; M = M + M.T
    th = theta_of(M)
    E = M * M + M @ M - th * M
    off = E[iu]                                   # diag(s) touches the diagonal only
    return np.concatenate([off, M.sum(axis=1), [float((M ** 2).sum()) - 2.0]])


def triangle_free(A):
    return not np.any(np.diag(A @ A @ A) > 0.5)


def solve_from(A, n, iu, rng, scale=1.0):
    """Seed negative on the edges of A, positive off, then solve criticality."""
    M0 = np.where(A > 0, -1.0, 0.30) * (1.0 + 0.25 * rng.normal(size=(n, n)))
    M0 = np.triu(M0, 1); M0 = M0 + M0.T
    M0 = M0 - M0.mean()
    np.fill_diagonal(M0, 0.0)
    r = M0.sum(axis=1); V = r.sum() / (2 * n - 2); v = (r - V) / (n - 2)
    M0 = M0 - v[:, None] - v[None, :]; np.fill_diagonal(M0, 0.0)
    M0 = scale * M0 / np.sqrt((M0 ** 2).sum() / 2.0)
    sol = least_squares(resid, M0[iu], args=(n, iu), xtol=1e-14, ftol=1e-14,
                        gtol=1e-14, max_nfev=4000)
    M = np.zeros((n, n)); M[iu] = sol.x; M = M + M.T
    return M, float(np.abs(sol.fun).max())


def report(M):
    n = M.shape[0]
    neg = (M < -TOL).astype(float)
    return dict(theta=theta_of(M), tri_free=triangle_free(neg),
                delta=delta_closed(M), rows=len(set(map(tuple, np.round(M, 7)))),
                norm=float((M ** 2).sum() / 2.0))


# ---------- the graph library ----------

def blow_up(G, sizes):
    k = len(sizes); n = sum(sizes)
    lab = sum(([i] * sizes[i] for i in range(k)), [])
    A = np.zeros((n, n))
    for a in range(n):
        for b in range(n):
            if a != b and G[lab[a]][lab[b]]:
                A[a, b] = 1.0
    return A


def cycle(k):
    G = [[0] * k for _ in range(k)]
    for a in range(k):
        G[a][(a + 1) % k] = G[(a + 1) % k][a] = 1
    return G


def petersen():
    E = [(0,1),(1,2),(2,3),(3,4),(4,0),(5,7),(7,9),(9,6),(6,8),(8,5),
         (0,5),(1,6),(2,7),(3,8),(4,9)]
    A = np.zeros((10, 10))
    for i, j in E:
        A[i, j] = A[j, i] = 1.0
    return A


def grotzsch():
    A = np.zeros((11, 11))
    for i, j in [(0,1),(1,2),(2,3),(3,4),(4,0)]:
        A[i, j] = A[j, i] = 1.0
    for i in range(5):
        A[5 + i, (i + 1) % 5] = A[(i + 1) % 5, 5 + i] = 1.0
        A[5 + i, (i + 4) % 5] = A[(i + 4) % 5, 5 + i] = 1.0
        A[10, 5 + i] = A[5 + i, 10] = 1.0
    return A


def circulants(n):
    out = []
    for r in range(1, n // 2 + 1):
        for S in itertools.chain.from_iterable(
                itertools.combinations(range(1, n // 2 + 1), r) for r in (1, 2, 3)):
            A = np.zeros((n, n))
            for a in range(n):
                for d in S:
                    A[a, (a + d) % n] = A[(a + d) % n, a] = 1.0
            if triangle_free(A) and A.sum() > 0:
                out.append((f"circ{S}", A))
        break
    return out


def random_maximal_tf(n, rng, tries=200):
    A = np.zeros((n, n))
    e = [(a, b) for a in range(n) for b in range(a + 1, n)]
    rng.shuffle(e)
    for a, b in e:
        A[a, b] = A[b, a] = 1.0
        if not triangle_free(A):
            A[a, b] = A[b, a] = 0.0
    return A


def pad(A, n):
    B = np.zeros((n, n)); k = A.shape[0]; B[:k, :k] = A
    return B


def library(n, rng, n_random=60):
    L = []
    for k in (5, 7, 9, 11):
        if k > n:
            continue
        for sizes in _partitions(n, k):
            L.append((f"C_{k} blow-up {sizes}", blow_up(cycle(k), sizes)))
    if n >= 10:
        L.append(("Petersen padded", pad(petersen(), n)))
    if n >= 11:
        L.append(("Grotzsch padded", pad(grotzsch(), n)))
    L += circulants(n)
    for p in range(1, n // 2 + 1):
        A = np.zeros((n, n)); A[:p, p:] = 1.0; A[p:, :p] = 1.0
        L.append((f"K_{p},{n-p}", A))
    for t in range(n_random):
        L.append((f"random maximal TF #{t}", random_maximal_tf(n, rng)))
    return L


def _partitions(n, k, cap=6):
    """Up to `cap` size vectors of length k summing to n, each part >= 1."""
    out, base = [], [n // k] * k
    for i in range(n - sum(base)):
        base[i] += 1
    out.append(tuple(base))
    if k >= 2:
        for shift in range(1, min(cap, n // k)):
            v = list(base)
            if v[0] - shift >= 1:
                v[0] -= shift; v[-1] += shift
                out.append(tuple(v))
    return out[:cap]


def main(n=12, seeds=4, budget=900.0):
    rng = np.random.default_rng(7)
    iu = np.triu_indices(n, 1)
    t0 = time.time()
    hits, best = [], None
    lib = library(n, rng)
    print(f"n = {n}: {len(lib)} triangle-free seed graphs, {seeds} seeds each,"
          f" budget {budget:.0f}s", flush=True)
    for gi, (lbl, A) in enumerate(lib):
        if time.time() - t0 > budget:
            print(f"  budget reached after {gi} graphs", flush=True); break
        for s in range(seeds):
            M, res = solve_from(A, n, iu, rng)
            if res > 1e-9:
                continue
            r = report(M)
            if abs(r['norm'] - 1.0) > 1e-7 or not r['tri_free']:
                continue
            if r['delta'] <= 1e-7:
                continue                       # Delta = 0: a block product, not the target
            hits.append((r['theta'], lbl, r['delta'], r['rows']))
            if best is None or r['theta'] > best[0]:
                best = (r['theta'], lbl, r['delta'], r['rows'])
                print(f"  new best  theta={r['theta']:.6f}  Delta={r['delta']:8.4f}"
                      f"  rows={r['rows']:2d}  [{lbl}]", flush=True)
    print(f"\n=== F4, diagonal half, n = {n} ===", flush=True)
    print(f"  critical points found with S = 0 and Delta > 0: {len(hits)}", flush=True)
    if hits:
        hits.sort(reverse=True)
        print("  top ten by theta:", flush=True)
        for th, lbl, D, rw in hits[:10]:
            print(f"    theta={th:.6f}  Delta={D:9.4f}  distinct rows={rw:2d}  {lbl}",
                  flush=True)
        print(f"\n  CEILING on this run: theta = {hits[0][0]:.6f}", flush=True)
        print(f"  recorded ceiling (C_5 blow-up, n=10):  0.670820", flush=True)
        print(f"  the target threshold sqrt(3/2)      =  1.224745", flush=True)
        print(f"  a witness above the threshold would KILL V1: "
              f"{'FOUND' if hits[0][0] > 1.224745 else 'none found'}", flush=True)
    print(f"  elapsed {time.time()-t0:.0f}s", flush=True)


if __name__ == '__main__':
    main(n=int(sys.argv[1]) if len(sys.argv) > 1 else 12)
