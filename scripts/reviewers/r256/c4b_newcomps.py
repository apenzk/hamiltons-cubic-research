"""Claim 4 against the REVISED constants, COMPS = [(0,1),(1,2),(0,2)].

With distinct-index components every covariant of the form (scalar) x g reads
identically zero, which is the point of r255's repair: such covariants ARE the
zero map into V_(2).  So the adversarial D must be built traceless, i.e. as a
genuine nonzero covariant into the target.  Family: s^a Y^k with
Y^k = X^k - tr(X^k)/n delta, s = |W|^2, X = W.W.
"""
import sys, os, ast
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from fractions import Fraction as F
from common import samples, rank_exact, mat_WW

COMPS = ast.literal_eval(os.environ.get("R256_COMPS", "[(0,1),(1,2),(0,2)]"))
SAMPLES, SEED = 4, 0

def matmul(A, B, n):
    return [[sum(A[i][t]*B[t][j] for t in range(n)) for j in range(n)]
            for i in range(n)]

def tl(M, n):
    t = sum(M[i][i] for i in range(n))
    return [[M[i][j] - F(t, n)*(i == j) for j in range(n)] for i in range(n)]

def family(W, n, kmax, amax):
    X = mat_WW(W, n)
    s = sum(W[a][b][c][d]**2 for a in range(n) for b in range(n)
            for c in range(n) for d in range(n))
    P = [[F(1) if i == j else F(0) for j in range(n)] for i in range(n)]
    pows = []
    for k in range(1, kmax + 1):
        P = matmul(P, X, n); pows.append((k, tl(P, n)))
    return [(f"s^{a} Y^{k}", [[s**a * M[i][j] for j in range(n)] for i in range(n)])
            for a in range(amax + 1) for (k, M) in pows]

def kernel_vector(rows, ncol):
    M = [r[:] for r in rows]; m = len(M); piv = []; r = 0
    for c in range(ncol):
        pr = next((t for t in range(r, m) if M[t][c] != 0), None)
        if pr is None: continue
        M[r], M[pr] = M[pr], M[r]
        iv = M[r][c]; M[r] = [x/iv for x in M[r]]
        for t in range(m):
            if t != r and M[t][c] != 0:
                f0 = M[t][c]; M[t] = [x - f0*y for x, y in zip(M[t], M[r])]
        piv.append(c); r += 1
        if r == m: break
    free = [c for c in range(ncol) if c not in piv]
    if not free: return None
    fc = free[0]; x = [F(0)]*ncol; x[fc] = F(1)
    for i, c in enumerate(piv): x[c] = -M[i][fc]
    return x

print(f"components under test: {COMPS}")
for n in (5, 6):
    kmax, amax = n - 1, 3
    Ws = samples(n, SAMPLES, SEED)
    fams = [family(W, n, kmax, amax) for W in Ws]
    labels = [l for l, _ in fams[0]]; N = len(labels)
    big = [[M[i][j] for _, M in fm] for fm in fams for i in range(n) for j in range(n)]
    print(f"n={n}: TRACELESS family {labels[0]} .. {labels[-1]} ({N} covariants), "
          f"independent as functions: rank {rank_exact(big)} of {N}")
    cond = [[M[i][j] for _, M in fm] for fm in fams for (i, j) in COMPS]
    x = kernel_vector(cond, N)
    assert x is not None, "no kernel -- family too small"
    def D_of(fm):
        return [[sum(x[t]*fm[t][1][i][j] for t in range(N)) for j in range(n)]
                for i in range(n)]
    print(f"       {len(cond)} conditions, {N} unknowns; D uses "
          f"{sum(1 for c in x if c != 0)} members")
    print(f"       D traceless on every sample:  "
          f"{all(sum(D_of(fm)[i][i] for i in range(n)) == 0 for fm in fams)}")
    print(f"       D vanishes at all {len(cond)} reads: "
          f"{all(D_of(fm)[i][j] == 0 for fm in fams for (i, j) in COMPS)}")
    print(f"       D nonzero as a covariant:     "
          f"{any(D_of(fm)[i][j] != 0 for fm in fams for i in range(n) for j in range(n))}")
    def rank_at(comps, seed):
        Ws2 = samples(n, SAMPLES, seed)
        fs = [family(W, n, kmax, amax) for W in Ws2]
        rows = []
        for fm, W in zip(fs, Ws2):
            A = tl(mat_WW(W, n), n)
            Dm = [[sum(x[t]*fm[t][1][i][j] for t in range(N)) for j in range(n)]
                  for i in range(n)]
            for (i, j) in comps:
                rows.append([A[i][j], A[i][j] + Dm[i][j]])
        return rank_exact(rows)
    print(f"       rank of (Y^1, Y^1+D), both nonzero maps into V_(2):")
    print(f"         at the file's components, seed 0 : {rank_at(COMPS, 0)}   (true rank 2)")
    print(f"         with (0,3),(1,3) added           : {rank_at(COMPS+[(0,3),(1,3)], 0)}")
    print(f"         at seed 1                        : {rank_at(COMPS, 1)}")
