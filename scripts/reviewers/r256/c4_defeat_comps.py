"""Claim 4.  An adversarial pair of independent covariants that the file's fixed
COMPS = [(0,0),(0,1),(1,2)] and seed = 0 report as rank 1.

Construction.  s = |W|^2 is a scalar covariant and X = W.W is a 2-index
covariant, so every  s^a (X^k)_ij  is a genuine O(n)-covariant with two free
indices.  Take the family {s^a (X^k)_ij : k = 0..n-1, a = 0..2}: that is 3n
functions, and the file's test supplies only 3 components x 4 samples = 12
linear conditions.  For n >= 5 the conditions cannot exhaust the family, so a
NONZERO covariant D exists that vanishes at every one of the twelve
(component, sample) pairs the file looks at.

Then A = X_ij and B = X_ij + D are two independent covariants whose component
matrix, at the file's own constants, has rank 1.
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from fractions import Fraction as F
from common import samples, rank_exact, mat_WW

import ast
COMPS = ast.literal_eval(os.environ.get("R256_COMPS", "[(0,0),(0,1),(1,2)]"))
SAMPLES = 4                            # the file's constant
SEED = 0                               # the file's constant

def matmul(A, B, n):
    return [[sum(A[i][t]*B[t][j] for t in range(n)) for j in range(n)]
            for i in range(n)]

def family(W, n, kmax, amax):
    """[(label, matrix)] for s^a (X^k)_ij."""
    X = mat_WW(W, n)
    s = sum(W[a][b][c][d]**2 for a in range(n) for b in range(n)
            for c in range(n) for d in range(n))
    P = [[F(1) if i == j else F(0) for j in range(n)] for i in range(n)]
    pows = [P]
    for _ in range(kmax):
        P = matmul(P, X, n); pows.append(P)
    out = []
    for a in range(amax + 1):
        sa = s**a
        for k, Pk in enumerate(pows):
            out.append((f"s^{a} X^{k}",
                        [[sa*Pk[i][j] for j in range(n)] for i in range(n)]))
    return out

def kernel_vector(rows):
    """one nonzero exact solution of rows . x = 0, or None."""
    m = len(rows); ncol = len(rows[0])
    M = [r[:] for r in rows]; piv = []
    r = 0
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
    fc = free[0]
    x = [F(0)]*ncol; x[fc] = F(1)
    for i, c in enumerate(piv):
        x[c] = -M[i][fc]
    return x

for n in (5, 6):
    kmax, amax = n - 1, 2
    Ws = samples(n, SAMPLES, SEED)
    fams = [family(W, n, kmax, amax) for W in Ws]
    labels = [lab for lab, _ in fams[0]]
    N = len(labels)

    # (a) the family really is independent as a family of covariants
    big = []
    for fm in fams:
        for i in range(n):
            for j in range(n):
                big.append([M[i][j] for _, M in fm])
    print(f"n={n}: family {labels[0]} .. {labels[-1]}  ({N} covariants), "
          f"rank over all n^2 components x {SAMPLES} samples = {rank_exact(big)}")

    # (b) the twelve conditions the file's test imposes
    cond = []
    for fm in fams:
        for (i, j) in COMPS:
            cond.append([M[i][j] for _, M in fm])
    x = kernel_vector(cond)
    assert x is not None
    supp = [(labels[t], x[t]) for t in range(N) if x[t] != 0]
    print(f"       {len(cond)} conditions, {N} unknowns -> D = "
          + " + ".join(f"({c}) {l}" for l, c in supp))

    def D_of(fm):
        return [[sum(x[t]*fm[t][1][i][j] for t in range(N)) for j in range(n)]
                for i in range(n)]

    zero_at_comps = all(D_of(fm)[i][j] == 0 for fm in fams for (i, j) in COMPS)
    nonzero_fn = any(D_of(fm)[i][j] != 0 for fm in fams
                     for i in range(n) for j in range(n))
    print(f"       D vanishes at all {len(cond)} (component, sample) pairs: {zero_at_comps}")
    print(f"       D is a NONZERO covariant somewhere else:               {nonzero_fn}")

    # (c) the adversarial pair, ranked with the file's own procedure
    def comp_rank(comps, sample_ws):
        rows = []
        for fm, W in zip(sample_ws, Ws):
            A = mat_WW(W, n); Dm = D_of(fm)
            B = [[A[i][j] + Dm[i][j] for j in range(n)] for i in range(n)]
            for (i, j) in comps:
                rows.append([A[i][j], B[i][j]])
        return rank_exact(rows)

    r_file = comp_rank(COMPS, fams)
    r_more = comp_rank(COMPS + [(2, 3), (0, 0)], fams)
    print(f"       rank of (A, A+D) at the FILE's components  = {r_file}   "
          f"(true rank 2)")
    print(f"       rank with extra components added           = {r_more}")

    # (d) a different seed, same covariants
    Ws2 = samples(n, SAMPLES, 1)
    fams2 = [family(W, n, kmax, amax) for W in Ws2]
    rows = []
    for fm, W in zip(fams2, Ws2):
        A = mat_WW(W, n)
        Dm = [[sum(x[t]*fm[t][1][i][j] for t in range(N)) for j in range(n)]
              for i in range(n)]
        for (i, j) in COMPS:
            rows.append([A[i][j], A[i][j] + Dm[i][j]])
    print(f"       rank of the SAME pair at seed 1            = {rank_exact(rows)}")
