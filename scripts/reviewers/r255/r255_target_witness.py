"""r255, claim 1: the premise "F_c(W) already lies in the target" is FALSE for
the very carriers the file validates on, and the failure is in the unsafe
direction -- the test reports INDEPENDENCE for a pair that is DEPENDENT in every
block of the target.

Setting: degree-2, two free legs.  The record's target is a single O(n)-block
V_lambda (r254: "m_lambda covariants into V_lambda, one family per block;
inequivalent O(n) irreps pair to zero -- independence is 71 separate questions").
With two free legs the blocks available are the trivial one (multiples of
delta_ij) and lambda = (2) (symmetric traceless).  Nothing else can occur in a
symmetric 2-tensor.

Everything exact over Fraction.  No thresholds.
"""
import sys, os, random
from fractions import Fraction as F
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "..", "runs"))
from run_component_independence import (weyl_exact, cov_ric_like, cov_swapped,
                                        cov_trace_g, component_rank, COMPS)

def full(cov, W, n):
    return [[cov(W, n, i, j) for j in range(n)] for i in range(n)]

def trace(T, n):
    return sum(T[i][i] for i in range(n))

def proj_traceless(T, n):          # P onto V_(2) = symmetric traceless
    S = [[F(1, 2)*(T[i][j]+T[j][i]) for j in range(n)] for i in range(n)]
    t = trace(S, n)
    return [[S[i][j] - (F(t, n) if i == j else F(0)) for j in range(n)]
            for i in range(n)]

def rank_exact(rows, ncol):
    M = [r[:] for r in rows]; rank = 0
    for c in range(ncol):
        pr = next((t for t in range(rank, len(M)) if M[t][c] != 0), None)
        if pr is None: continue
        M[rank], M[pr] = M[pr], M[rank]
        iv = M[rank][c]; M[rank] = [x/iv for x in M[rank]]
        for t in range(len(M)):
            if t != rank and M[t][c] != 0:
                f0 = M[t][c]; M[t] = [x - f0*y for x, y in zip(M[t], M[rank])]
        rank += 1
    return rank

# a covariant that is the SAME element of V_(2) as (W.W) but a different raw
# tensor: it differs by 17 |W|^2 delta, which the projector kills.
def cov_shifted(W, n, i, j):
    return cov_ric_like(W, n, i, j) + 17*cov_trace_g(W, n, i, j)

print("r255 / claim 1 -- does F_c(W) lie in the target?\n")
for n in (5, 6, 7):
    rnd = random.Random(0)
    W = weyl_exact(n, rnd)
    A = full(cov_ric_like, W, n)          # (W.W)_ij
    G = full(cov_trace_g, W, n)           # |W|^2 delta_ij
    q = sum(W[a][b][c][d]**2 for a in range(n) for b in range(n)
            for c in range(n) for d in range(n))
    trA = trace(A, n)
    PA = proj_traceless(A, n)
    PG = proj_traceless(G, n)
    print(f"  n={n}")
    print(f"    tr (W.W)          = {trA}   |W|^2 = {q}   equal: {trA == q}")
    print(f"    (W.W) traceless?  {all(PA[i][j]==A[i][j] for i in range(n) for j in range(n))}"
          f"   -> F_c(W) in V_(2)?  {trA == 0}")
    print(f"    P(|W|^2 delta) = 0 ?  "
          f"{all(PG[i][j]==0 for i in range(n) for j in range(n))}")
    print(f"    P(W.W) = 0 ?          "
          f"{all(PA[i][j]==0 for i in range(n) for j in range(n))}")

    # (a) the file's own test, on the pair it asserts rank 2 for
    r_file = component_rank([cov_ric_like, cov_trace_g], n, COMPS, 4)
    # (b) the same pair read INSIDE the target V_(2): project first
    rows = []
    rnd2 = random.Random(0)
    for _ in range(4):
        Ws = weyl_exact(n, rnd2)
        P1 = proj_traceless(full(cov_ric_like, Ws, n), n)
        P2 = proj_traceless(full(cov_trace_g, Ws, n), n)
        for (i, j) in COMPS:
            rows.append([P1[i][j], P2[i][j]])
    r_target = rank_exact(rows, 2)
    # (c) the same pair read in the TRIVIAL block (the trace)
    rows0 = []
    rnd3 = random.Random(0)
    for _ in range(4):
        Ws = weyl_exact(n, rnd3)
        rows0.append([trace(full(cov_ric_like, Ws, n), n),
                      trace(full(cov_trace_g, Ws, n), n)])
    r_triv = rank_exact(rows0, 2)
    # (d) two raw representatives of ONE covariant into V_(2)
    r_same = component_rank([cov_ric_like, cov_shifted], n, COMPS, 4)
    same_after_P = True
    rnd4 = random.Random(0)
    for _ in range(4):
        Ws = weyl_exact(n, rnd4)
        X = proj_traceless(full(cov_ric_like, Ws, n), n)
        Y = proj_traceless(full(cov_shifted, Ws, n), n)
        same_after_P &= all(X[i][j] == Y[i][j] for i in range(n) for j in range(n))
    print(f"    file's rank on ((W.W), |W|^2 g)          : {r_file}   (asserts 2)")
    print(f"    rank INSIDE the target V_(2)             : {r_target}")
    print(f"    rank in the trivial block (the trace)    : {r_triv}")
    print(f"    file's rank on ((W.W), (W.W)+17|W|^2 g)  : {r_same}"
          f"   same covariant into V_(2): {same_after_P}")
    print(f"    cov_swapped == cov_ric_like pointwise?   : "
          f"{all(cov_swapped(W,n,i,j)==cov_ric_like(W,n,i,j) for i in range(n) for j in range(n))}")
    print()
