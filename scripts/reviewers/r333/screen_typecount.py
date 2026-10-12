"""SCREEN ONLY (r333). Value-type aggregation of the pinned system (A),(B),(C).

Rows derived by hand first (see report). Unknowns: type masses M_tau plus theta.
Question screened: is theta determined by these LINEAR rows alone, i.e. does every
nullspace vector have zero theta-component?  Two dependencies are predicted by hand
(both need tr W = 0), so the expected rank is 3d - 2.
"""
from fractions import Fraction as F
from itertools import combinations_with_replacement

def build(vals, mults, n):
    d = len(vals)
    types = [t for t in combinations_with_replacement(range(d), 3)
             if all(t.count(i) <= mults[i] for i in range(d))]
    A, rhs = [], []
    for xi in range(d):
        x, mx = vals[xi], mults[xi]
        for kind in (0, 1, 2):
            row = [F(0)] * (len(types) + 1)
            for j, t in enumerate(types):
                nx = t.count(xi)
                if nx == 0: continue
                S = sum(vals[i] for i in t)
                rest = list(t); rest.remove(xi)
                P = vals[rest[0]] * vals[rest[1]]
                row[j] = [F(nx), F(nx) * (S - x), 2 * F(nx) * P][kind]
            if kind == 2: row[-1] = F(-2) * x * mx
            A.append(row)
            rhs.append([F(n - 2) * mx, F(-2) * x * mx, F(-2) * x * x * mx][kind])
    return types, A, rhs

def rref(M):
    M = [r[:] for r in M]; nr, nc = len(M), len(M[0]); piv = []; r = 0
    for c in range(nc):
        p = next((i for i in range(r, nr) if M[i][c] != 0), None)
        if p is None: continue
        M[r], M[p] = M[p], M[r]
        pv = M[r][c]; M[r] = [v / pv for v in M[r]]
        for i in range(nr):
            if i != r and M[i][c] != 0:
                f = M[i][c]; M[i] = [a - f * b for a, b in zip(M[i], M[r])]
        piv.append(c); r += 1
        if r == nr: break
    return M, piv

def report(name, vals, mults, n):
    vals = [F(v) for v in vals]
    tr = sum(m * v for m, v in zip(mults, vals))
    types, A, rhs = build(vals, mults, n)
    nc = len(types) + 1; th = nc - 1
    R, piv = rref(A); free = [c for c in range(nc) if c not in piv]
    # nullspace theta-components
    tcomp = []
    for c in free:
        v = [F(0)] * nc; v[c] = F(1)
        for i, pc in enumerate(piv): v[pc] = -R[i][c]
        tcomp.append(v[th])
    _, pivA = rref([a + [b] for a, b in zip(A, rhs)])
    print(f"{name} d={len(vals)} mults={mults} trace={tr} types={len(types)} unk={nc} "
          f"eqs={len(A)} rank={len(piv)} nullity={nc-len(piv)} "
          f"consistent={nc not in pivA} theta_pinned_linearly={all(t==0 for t in tcomp)}")

report("torus n=6   ", [4, -1],                   [3, 12],       6)
report("torus n=8   ", [6, -1],                   [4, 24],       8)
report("S4xS4  n=8  ", [-3, 4],                   [16, 12],      8)
report("padded W_CP2", [2, -1, 0],                [1, 2, 12],    6)
report("CP^3   n=6  ", [-4, 1, 16],               [6, 8, 1],     6)
report("S3xS5  n=8  ", [-4, 3, 10],               [15, 10, 3],   8)
report("S5xS7  n=12 ", [-12, 10, 21],             [35, 21, 10], 12)
report("gen d=3 n=12", [-5, 1, 4],                [20, 30, 15], 12)   # trace 0
report("gen d=4 n=12", [1, 2, -3, F(-20,3)],      [30, 20, 10, 6], 12)
report("gen d=5 n=12", [1, 2, -3, 4, F(-13,3)],   [20, 15, 10, 6, 15], 12)
