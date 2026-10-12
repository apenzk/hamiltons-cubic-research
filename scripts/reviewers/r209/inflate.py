"""r209, claim 1: CAN sampling raise the rank above the abstract cap?

Real and imaginary parts are an isomorphism onto the real span of the Hermitian
matrices, so the coordinate map cannot inflate anything BY ITSELF.  The bound
rank(sampled) <= rank(abstract) needs each sampled row to be the coefficient
vector of the invariant sextic attached to the unknown Gram, and THAT needs the
copies of a block to be identified equivariantly.  This file exhibits the
failure that breaks it, in the smallest setting that has room for it.

Model: G = S_3 permuting the coordinates of R^3, cubics = Sym^3(R^3), paired by
the invariant form <u,v> = sum_m mult(m) u_m v_m.
  isotypic multiplicities 3 (trivial), 1 (sign), 3 (standard)  -> sum m^2 = 19
  dim (Sym^6 R^3)^{S_3} = 7 monomial orbits                    -> the cap
Copies come from the matrix-coefficient projectors E_t = (d/|G|) sum_g
rho(g^{-1})_{0t} g, one word list per block, so g.R_i[t] = sum_s rho(g)_{st}
R_i[s] and B_ij = sum_{ts} f_it (Q^{-1})_{ts} f_js is invariant.  Giving ONE
copy its own position list -- exactly what run_n5_adapted.py forbids -- leaves a
well-formed 19-column sampled matrix whose rank EXCEEDS the cap.
"""
from fractions import Fraction as F
from itertools import permutations, combinations_with_replacement
import random

V = 3
MON3 = list(combinations_with_replacement(range(V), 3))
IDX3 = {m: i for i, m in enumerate(MON3)}
N = len(MON3)
GRP = list(permutations(range(V)))
def act(g, m): return tuple(sorted(g[i] for i in m))
def ginv(g): return tuple(g.index(i) for i in range(V))
def sgn(g):
    s = 1
    for i in range(V):
        for j in range(i+1, V):
            if g[i] > g[j]: s = -s
    return s
def mult(m):
    k = {}
    for i in m: k[i] = k.get(i, 0) + 1
    r = 6
    for v in k.values(): r //= (1, 1, 2, 6)[v]
    return r
MULT = [F(mult(m)) for m in MON3]
def IP(u, v): return sum(MULT[k]*u[k]*v[k] for k in range(N))
def gact(g, u):
    out = [F(0)]*N
    for j, m in enumerate(MON3): out[IDX3[act(g, m)]] = u[j]
    return out
# the invariant form is invariant
_t = [F(random.Random(1).randint(-5, 5)) for _ in range(N)]
assert all(IP(gact(g, _t), gact(g, _t)) == IP(_t, _t) for g in GRP)

# standard 2-dim irrep in the basis B0 = e0-e1, B1 = e0+e1-2e2
BB = [[F(1), F(-1), F(0)], [F(1), F(1), F(-2)]]
def rho(g):
    out = []
    for r in BB:
        v = [r[ginv(g)[i]] for i in range(V)]
        n0 = sum(x*x for x in BB[0]); n1 = sum(x*x for x in BB[1])
        out.append([sum(v[i]*BB[0][i] for i in range(V))/n0,
                    sum(v[i]*BB[1][i] for i in range(V))/n1])
    return [[out[b][a] for b in range(2)] for a in range(2)]   # columns = images
def mm(A, B):
    return [[sum(A[i][k]*B[k][j] for k in range(len(B))) for j in range(len(B[0]))]
            for i in range(len(A))]
for g in GRP:
    for h in GRP:
        assert mm(rho(g), rho(h)) == rho(tuple(g[h[i]] for i in range(V)))

def proj(coef):
    M = [[F(0)]*N for _ in range(N)]
    for g in GRP:
        c = coef(g)
        if not c: continue
        for j in range(N): M[IDX3[act(g, MON3[j])]][j] += c
    return M
def apply(M, v): return [sum(M[i][j]*v[j] for j in range(N)) for i in range(N)]
def rank_rows(rows):
    R = [list(r) for r in rows]; r = 0
    n = len(R[0]) if R else 0
    for c in range(n):
        pv = next((t for t in range(r, len(R)) if R[t][c]), None)
        if pv is None: continue
        R[r], R[pv] = R[pv], R[r]
        p = R[r][c]; R[r] = [x/p for x in R[r]]
        for t in range(len(R)):
            if t != r and R[t][c]:
                f0 = R[t][c]; R[t] = [x - f0*y for x, y in zip(R[t], R[r])]
        r += 1
    return r
def colspace(M):
    keep = []
    for j in range(N):
        c = [M[i][j] for i in range(N)]
        if rank_rows(keep + [c]) > len(keep): keep.append(c)
    return keep

BLOCKS = {}
for name, chi in (("triv", lambda g: F(1)), ("sign", lambda g: F(sgn(g)))):
    BLOCKS[name] = [[v] for v in colspace(proj(lambda g: chi(g)/6))]
E = [proj(lambda g, t=t: F(2, 6)*rho(ginv(g))[0][t]) for t in range(2)]
BLOCKS["std"] = [[apply(E[0], v), apply(E[1], v)] for v in colspace(E[0])]
print("multiplicities:", {k: len(v) for k, v in BLOCKS.items()},
      "positions:", {k: len(v[0]) for k, v in BLOCKS.items()})
assert [len(BLOCKS[k]) for k in ("triv", "sign", "std")] == [3, 1, 3]

# EQUIVARIANCE, the property everything downstream rests on
eq = 0
for i, cp in enumerate(BLOCKS["std"]):
    for g in GRP:
        for t in range(2):
            lhs = gact(g, cp[t])
            rhs = [sum(rho(g)[s][t]*cp[s][k] for s in range(2)) for k in range(N)]
            eq += (lhs == rhs)
print(f"  copies equivariant: {eq}/{3*6*2}")
assert eq == 36

MON6 = list(combinations_with_replacement(range(V), 6))
CAP = len({min(tuple(sorted(g[i] for i in m)) for g in GRP) for m in MON6})
NUNK = sum(len(v)**2 for v in BLOCKS.values())
print(f"unknowns sum m^2 = {NUNK};  dim (Sym^6 R^3)^S3 = {CAP}")

def cube(w):
    out = [F(1)]*N
    for j, m in enumerate(MON3):
        c = F(1)
        for i in m: c *= w[i]
        out[j] = c
    return out
def inv2(Q):
    k = len(Q)
    A = [list(Q[i]) + [F(1) if j == i else F(0) for j in range(k)] for i in range(k)]
    for c in range(k):
        pv = next(t for t in range(c, k) if A[t][c])
        A[c], A[pv] = A[pv], A[c]
        p = A[c][c]; A[c] = [x/p for x in A[c]]
        for t in range(k):
            if t != c and A[t][c]:
                f0 = A[t][c]; A[t] = [x - f0*y for x, y in zip(A[t], A[c])]
    return [r[k:] for r in A]

def rows_for(blocks, pts):
    QI = {}
    for name, cps in blocks.items():
        np_ = len(cps[0])
        Q = [[IP(cps[0][t], cps[0][s]) for s in range(np_)] for t in range(np_)]
        QI[name] = inv2(Q)
    out = []
    for w in pts:
        c3 = cube(w); row = []
        for name in ("triv", "sign", "std"):
            cps = blocks[name]; m = len(cps); np_ = len(cps[0])
            f = [[IP(c3, cps[i][t]) for t in range(np_)] for i in range(m)]
            B = [[sum(f[i][t]*QI[name][t][s]*f[j][s] for t in range(np_)
                      for s in range(np_)) for j in range(m)] for i in range(m)]
            for i in range(m):
                row.append(B[i][i])
                for j in range(i+1, m): row.append(B[i][j])
            for i in range(m):
                for j in range(i+1, m): row.append(B[i][j] - B[j][i])
        out.append(row)
    return out

rnd = random.Random(7)
PTS = [[F(rnd.randint(-6, 6)) for _ in range(V)] for _ in range(40)]
def invariance(blocks):
    ok = tot = 0
    for w in PTS[:6]:
        r = rows_for(blocks, [w])[0]
        for g in GRP:
            tot += 1
            ok += (rows_for(blocks, [[w[ginv(g)[i]] for i in range(V)]])[0] == r)
    return ok, tot

R = rows_for(BLOCKS, PTS); ok, tot = invariance(BLOCKS)
print(f"\nHONEST: unknowns {len(R[0])}, B invariant {ok}/{tot}, "
      f"sampled rank {rank_rows([list(c) for c in zip(*R)])} vs cap {CAP}")

BAD = {k: [list(c) for c in v] for k, v in BLOCKS.items()}
BAD["std"][1] = [BAD["std"][1][1], BAD["std"][1][0]]
R = rows_for(BAD, PTS); ok, tot = invariance(BAD)
print(f"\nCORRUPT (copy 1 of the standard block gets its own position list):")
print(f"  unknowns {len(R[0])}, B invariant {ok}/{tot}, "
      f"sampled rank {rank_rows([list(c) for c in zip(*R)])} vs cap {CAP}")

for tag, bl in (("honest", BLOCKS), ("corrupt", BAD)):
    hs = []
    for t in range(2):
        cps = bl["std"]
        h = [[IP(cps[i][t], cps[j][t]) for j in range(3)] for i in range(3)]
        q = h[0][0]
        hs.append([[x/q for x in r] for r in h])
    print(f"  multi-probe Schur check ({tag}): h agrees across positions: {hs[0] == hs[1]}")
