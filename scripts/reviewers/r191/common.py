"""Shared exact-arithmetic scaffolding for reviewer 191.

Everything is a pair (re, im) of Fractions.  No floats anywhere.
"""
import json, os, itertools
from fractions import Fraction as F

HERE = os.path.dirname(os.path.abspath(__file__))
RUNS = os.path.abspath(os.path.join(HERE, "..", "..", "runs"))
C = json.load(open(os.path.join(RUNS, "n5_hw_cache.json")))
WT = [tuple(w) for w in C["weights"]]
MONO = list(itertools.combinations_with_replacement(range(35), 3))
MIDX = {m: i for i, m in enumerate(MONO)}
MW = [tuple(WT[a][k] + WT[b][k] + WT[c][k] for k in (0, 1)) for a, b, c in MONO]

Z = (F(0), F(0)); ONE = (F(1), F(0))
def cmul(x, y): return (x[0]*y[0] - x[1]*y[1], x[0]*y[1] + x[1]*y[0])
def cadd(x, y): return (x[0] + y[0], x[1] + y[1])
def csub(x, y): return (x[0] - y[0], x[1] - y[1])
def cconj(x):   return (x[0], -x[1])
def cinv(x):
    d = x[0]*x[0] + x[1]*x[1]; return (x[0]/d, -x[1]/d)
def cdiv(x, y): return cmul(x, cinv(y))
def gq(pr):
    (rn, rd), (inn, idd) = pr
    return (F(rn, rd), F(inn, idd))

T = C["wbasis_tensors"]
EC = {1: [[gq(z) for z in row] for row in C["E1C"]],
      2: [[gq(z) for z in row] for row in C["E2C"]]}
ALPHA = {1: (1, -1), 2: (0, 1)}

# ---- H, exactly as run_n5_evaluate.py builds it -------------------------
def build_H():
    H = {}
    for a in range(35):
        for b in range(35):
            if WT[a] != WT[b]: continue
            re = im = F(0)
            for i in range(5):
                for j in range(5):
                    for k in range(5):
                        for l in range(5):
                            x = gq(T[a][i][j][k][l]); y = gq(T[b][i][j][k][l])
                            re += x[0]*y[0] + x[1]*y[1]
                            im += x[1]*y[0] - x[0]*y[1]
            if (re, im) != Z: H[(a, b)] = (re, im)
    return H

def Hfull(H):
    return [[H.get((a, b), Z) for b in range(35)] for a in range(35)]

BYW = {}
for a in range(35): BYW.setdefault(WT[a], []).append(a)

def matmul(A, B, n=35):
    Ct = [[Z]*n for _ in range(n)]
    for i in range(n):
        Ai = A[i]; Ci = Ct[i]
        for k in range(n):
            a = Ai[k]
            if a == Z: continue
            Bk = B[k]
            for j in range(n):
                b = Bk[j]
                if b == Z: continue
                Ci[j] = cadd(Ci[j], cmul(a, b))
    return Ct

def dagger(A, n=35):
    return [[cconj(A[j][i]) for j in range(n)] for i in range(n)]

def inv_blockdiag(H, n=35):
    """Invert the weight-block-diagonal H exactly."""
    out = [[Z]*n for _ in range(n)]
    for mu, idxs in BYW.items():
        m = len(idxs)
        M = [[H.get((idxs[r], idxs[c]), Z) for c in range(m)] +
             [(F(1), F(0)) if c == r else Z for c in range(m)] for r in range(m)]
        for c in range(m):
            p = next(r for r in range(c, m) if M[r][c] != Z)
            M[c], M[p] = M[p], M[c]
            iv = cinv(M[c][c]); M[c] = [cmul(iv, z) for z in M[c]]
            for r in range(m):
                if r != c and M[r][c] != Z:
                    f = M[r][c]
                    M[r] = [csub(z, cmul(f, y)) for z, y in zip(M[r], M[c])]
        for r in range(m):
            for c in range(m):
                out[idxs[r]][idxs[c]] = M[r][m + c]
    return out

def raise_mono(idx, E):
    """E as a derivation on the monomial MONO[idx]; E[x][t] is input x -> output t."""
    a, b, c = MONO[idx]; out = {}
    for pos, x in enumerate((a, b, c)):
        rest = [y for j, y in enumerate((a, b, c)) if j != pos]
        Ex = E[x]
        for t in range(35):
            v = Ex[t]
            if v != Z:
                j = MIDX[tuple(sorted(rest + [t]))]
                out[j] = cadd(out.get(j, Z), v)
    return {k: v for k, v in out.items() if v != Z}

def multinom(t):
    m = {}
    for x in t: m[x] = m.get(x, 0) + 1
    r = 6
    for v in m.values():
        r //= (1 if v == 1 else (2 if v == 2 else 6))
    return r
