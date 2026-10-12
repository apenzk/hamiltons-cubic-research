"""Shared carrier: an exact random Weyl tensor, copied verbatim from the file
under review (scripts/runs/run_component_independence.py) so that every sample
below is the SAME tensor the validation draws."""
from fractions import Fraction as F
import random

def weyl_exact(n, rnd):
    rg = range(n)
    R = [[[[F(rnd.randint(-3, 3)) for _ in rg] for _ in rg] for _ in rg] for _ in rg]
    B = [[[[F(1,4)*(R[a][b][c][d]-R[b][a][c][d]-R[a][b][d][c]+R[b][a][d][c])
            for d in rg] for c in rg] for b in rg] for a in rg]
    B = [[[[F(1,2)*(B[a][b][c][d]+B[c][d][a][b]) for d in rg] for c in rg]
          for b in rg] for a in rg]
    B = [[[[B[a][b][c][d]-F(1,3)*(B[a][b][c][d]+B[a][c][d][b]+B[a][d][b][c])
            for d in rg] for c in rg] for b in rg] for a in rg]
    Ric = [[sum(B[a][k][b][k] for k in rg) for b in rg] for a in rg]
    sc = sum(Ric[a][a] for a in rg)
    E = [[Ric[a][b] - F(sc, n)*(a == b) for b in rg] for a in rg]
    g = [[F(1) if a == b else F(0) for b in rg] for a in rg]
    def KN(P, Q, a, b, c, d):
        return (P[a][c]*Q[b][d] + P[b][d]*Q[a][c]
                - P[a][d]*Q[b][c] - P[b][c]*Q[a][d])
    W = [[[[B[a][b][c][d] - F(1,n-2)*KN(E,g,a,b,c,d)
            - F(sc,2*n*(n-1))*KN(g,g,a,b,c,d) for d in rg] for c in rg]
          for b in rg] for a in rg]
    return [[[[F(1,2)*(W[a][b][c][d]+W[c][d][a][b]) for d in rg] for c in rg]
             for b in rg] for a in rg]

def samples(n, k, seed=0):
    rnd = random.Random(seed)
    return [weyl_exact(n, rnd) for _ in range(k)]

def rank_exact(rows):
    M = [r[:] for r in rows]
    if not M: return 0
    ncol = len(M[0]); rank = 0
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

# --- the validation's covariants, as FULL matrices (the file reads one entry) --
def mat_WW(W, n):
    return [[sum(W[i][a][b][c]*W[j][a][b][c] for a in range(n)
                 for b in range(n) for c in range(n)) for j in range(n)]
            for i in range(n)]

def mat_swapped(W, n):
    return [[sum(W[a][i][b][c]*W[a][j][b][c] for a in range(n)
                 for b in range(n) for c in range(n)) for j in range(n)]
            for i in range(n)]

def mat_q_delta(W, n):
    q = sum(W[a][b][c][d]**2 for a in range(n) for b in range(n)
            for c in range(n) for d in range(n))
    return [[q if i == j else F(0) for j in range(n)] for i in range(n)]

def mat_sum(*mats):
    n = len(mats[0])
    return [[sum(M[i][j] for M in mats) for j in range(n)] for i in range(n)]
