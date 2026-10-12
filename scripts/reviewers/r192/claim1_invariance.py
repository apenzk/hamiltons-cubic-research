"""Claim 1: a test that DOES discriminate the Sym^3 metric conventions.

Reviewers 189/190 showed a weight check cannot separate the plain permanent
convention from a multiplicity-weighted one -- the weighting is diagonal inside
each weight space.  Invariance separates them, and here is the reason.  If A is
g-invariant and B(x_t,x_s) = c_t conj(c_s) A(x_t,x_s), then B is g-invariant iff
the diagonal map D: x_t -> c_t x_t is a module map.  A raising operator carries
x_{aab} to x_{abt}, monomials of different multiplicity pattern, so a c that
depends on the pattern makes D non-equivariant.  At most one convention (up to
overall scale) is invariant, and the test says which.

Condition tested, exactly, over Q(i):
    <X u, v> + <u, X v> = 0   for X = rho(A_pq), the ten real generators.
"""
import json, os, itertools, random
from fractions import Fraction as F
from math import factorial

HERE = os.path.dirname(os.path.abspath(__file__))
RUNS = os.path.join(HERE, "..", "..", "runs")
C = json.load(open(os.path.join(RUNS, "n5_hw_cache.json")))
Gc = json.load(open(os.path.join(HERE, "gens_cache.json")))["GC"]
T = C["wbasis_tensors"]

def gq(pr):
    (rn, rd), (inn, idd) = pr
    return (F(rn, rd), F(inn, idd))
Z = (F(0), F(0)); ONEC = (F(1), F(0))
def cadd(x, y): return (x[0]+y[0], x[1]+y[1])
def cmul(x, y): return (x[0]*y[0]-x[1]*y[1], x[0]*y[1]+x[1]*y[0])
def cconj(x): return (x[0], -x[1])
GC = [[[gq(x) for x in row] for row in M] for M in Gc]

H = [[Z]*35 for _ in range(35)]
for a in range(35):
    for b in range(35):
        re = im = F(0)
        for i in range(5):
            for j in range(5):
                for k in range(5):
                    for l in range(5):
                        x = gq(T[a][i][j][k][l]); y = gq(T[b][i][j][k][l])
                        re += x[0]*y[0]+x[1]*y[1]
                        im += x[1]*y[0]-x[0]*y[1]
        H[a][b] = (re, im)

# --- sanity: the 35-dim form itself must be invariant, else the test is void
bad = 0
for k in range(10):
    for a in range(35):
        for b in range(35):
            s = Z
            for t in range(35):
                if GC[k][a][t] != Z: s = cadd(s, cmul(GC[k][a][t], H[t][b]))
                if GC[k][b][t] != Z: s = cadd(s, cmul(cconj(GC[k][b][t]), H[a][t]))
            if s != Z: bad += 1
print(f"control -- the 35-dim Weyl-module Gram H is invariant: {bad == 0} "
      f"({bad} violations of {10*35*35})")

MONO = list(itertools.combinations_with_replacement(range(35), 3))
MIDX = {m: i for i, m in enumerate(MONO)}
def multinom(t):
    m = {}
    for x in t: m[x] = m.get(x, 0)+1
    r = 6
    for v in m.values(): r //= factorial(v)
    return r

_pc = {}
def perm3(t, s):
    v = _pc.get((t, s))
    if v is not None: return v
    tot = Z
    for p in itertools.permutations(range(3)):
        term = ONEC
        for i in range(3):
            e = H[t[i]][s[p[i]]]
            if e == Z: term = Z; break
            term = cmul(term, e)
        tot = cadd(tot, term)
    _pc[(t, s)] = tot
    return tot

def mkip(weight):
    def ipf(u, v):
        tot = Z
        for t, cu in u.items():
            for s, cv in v.items():
                p = perm3(MONO[t], MONO[s])
                if p == Z: continue
                w = weight(MONO[t], MONO[s])
                tot = cadd(tot, cmul(cmul(cu, cconj(cv)), (p[0]*w, p[1]*w)))
        return tot
    return ipf
CONV = [("plain permanent  (sym3_ip as shipped)", mkip(lambda t, s: F(1))),
        ("x multinom(t)*multinom(s)", mkip(lambda t, s: F(multinom(t)*multinom(s)))),
        ("/ multinom(t)*multinom(s)", mkip(lambda t, s: F(1, multinom(t)*multinom(s)))),
        ("x sqrt-free multinom(t) only", mkip(lambda t, s: F(multinom(t)))),
        ("x 6/multinom -- the tensor-subspace weight",
         mkip(lambda t, s: F(36, multinom(t)*multinom(s))))]

def act(vec, M):
    out = {}
    for idx, co in vec.items():
        a, b, c = MONO[idx]
        for pos, x in enumerate((a, b, c)):
            rest = [y for j, y in enumerate((a, b, c)) if j != pos]
            for t in range(35):
                if M[x][t] != Z:
                    j = MIDX[tuple(sorted(rest+[t]))]
                    out[j] = cadd(out.get(j, Z), cmul(co, M[x][t]))
    return {k: v for k, v in out.items() if v != Z}

random.seed(192)
# A live test set.  Most monomial pairs pair to zero for weight reasons and say
# nothing, so v is drawn from the SUPPORT of X u -- then <Xu,v> is nonzero and
# the identity has something to cancel.
pairs = []
for k in range(10):
    for _ in range(4):
        ti = random.randrange(len(MONO))
        img = act({ti: ONEC}, GC[k])
        for si in list(img)[:20]:
            pairs.append((k, ti, si))
print(f"live test set: {len(pairs)} (generator, u, v) triples")

for name, ipf in CONV:
    bad = tot = nz = 0
    for (k, ti, si) in pairs:
        M = GC[k]
        u = {ti: ONEC}; v = {si: ONEC}
        a = ipf(act(u, M), v); b = ipf(u, act(v, M))
        tot += 1
        if a != Z or b != Z: nz += 1
        if cadd(a, b) != Z: bad += 1
    print(f"  {name:42s} violations {bad:4d} of {tot} "
          f"({nz} live)")
