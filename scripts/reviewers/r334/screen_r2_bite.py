"""r334 screen: does R2's spectral condition actually cut? Two-eigenvalue family
W = Pi_h - (r/N) I at n=6 (N=15): scaled lam = (N-r) on r indices, -r on N-r indices.
R2 predicts lam_max <= (n-2)|lam_min|, i.e. (N-r)/r <= 4, i.e. r >= 3.
SCREEN only."""
import itertools, numpy as np
from scipy.optimize import linprog

n, N = 6, 15
tri = list(itertools.combinations(range(N), 3)); idx = {t: i for i, t in enumerate(tri)}
for r in list(range(1, 8)) + [11, 12, 13, 14]:
    lam = np.array([N - r]*r + [-r]*(N - r), float)
    rows, rhs = [], []
    nv = len(tri) + 1
    for a in range(N):
        rA = np.zeros(nv); rB = np.zeros(nv); rC = np.zeros(nv)
        for b, c in itertools.combinations([x for x in range(N) if x != a], 2):
            j = idx[tuple(sorted((a, b, c)))]
            rA[j] += 1.0; rB[j] += lam[b] + lam[c]; rC[j] += lam[b]*lam[c]
        rC[-1] -= lam[a]
        rows += [rA, rB, rC]; rhs += [n-2, -2*lam[a], -lam[a]**2]
    bounds = [(0, None)]*len(tri) + [(None, None)]
    res = {}
    for s, sg in (("min", 1.0), ("max", -1.0)):
        c = np.zeros(nv); c[-1] = sg
        o = linprog(c, A_eq=np.array(rows), b_eq=np.array(rhs), bounds=bounds, method="highs")
        res[s] = "INFEASIBLE" if o.status == 2 else (o.x[-1] if o.success else f"status{o.status}")
    ok = ((N - r)/r <= n - 2) and (r/(N - r) <= n - 2)   # both halves of R2
    print(f"r={r:2d} lam=({N-r},{-r}) lmax/|lmin|={(N-r)/r:8.4f} |lmin|/lmax={r/(N-r):7.4f} "
          f"R2(both <= {n-2})={'OK  ' if ok else 'VIOL'}  theta min={res['min']} max={res['max']}")
