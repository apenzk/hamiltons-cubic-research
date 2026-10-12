"""r216, claim 4b, part 1.  Weyl_12 explicitly, in a weight basis, with the six
simple raising operators as SPARSE matrices.

run_n12_weights.py's docstring says the n=5 module route cannot transfer because
it would need "66 generators of size 1638x1638 -- 177 million entries before any
arithmetic".  A highest-weight computation needs SIX operators, not 66, it needs
them only on one weight space at a time, and they are sparse.  This file builds
them, so the cost of the route can be measured rather than assumed.

Model.  V = C^12 with the hyperbolic form g(f_a, f_{-a}) = 1, a = 1..6, so the
weight of f_a is sign(a) e_{|a|} and so(12) is the matrices X with
g(Xu,v) + g(u,Xv) = 0.  Simple raising operators for D_6:
    E_i = X_{e_i - e_{i+1}} : f_{i+1} -> f_i,   f_{-i} -> -f_{-i-1}   (i = 1..5)
    E_6 = X_{e_5 + e_6}     : f_{-6} -> f_5,    f_{-5} -> -f_6
Sym^2(Lambda^2 V) has dimension 2211; the wedge to Lambda^4 cuts it to the GL
Schur functor S_(2,2) (1716), and the Ricci contraction cuts that to 1638.
Everything is done one WEIGHT SPACE AT A TIME, so no 2211x2211 object exists.
"""
from fractions import Fraction as F
from itertools import combinations
from collections import defaultdict
import pickle, os, sys, time

IDX = [1,2,3,4,5,6,-1,-2,-3,-4,-5,-6]
POSN = {a: k for k, a in enumerate(IDX)}
R = 6
def wt1(a):
    v = [0]*R; v[abs(a)-1] = 1 if a > 0 else -1; return tuple(v)

# ---- simple raising operators on V, as dict a -> {b: coeff} ----
Ev = []
for i in range(1, 6):
    Ev.append({i+1: {i: 1}, -i: {-(i+1): -1}})
Ev.append({-6: {5: 1}, -5: {6: -1}})
assert len(Ev) == 6

def check_so(X):
    """g(Xu,v) + g(u,Xv) = 0 for all basis u,v."""
    def g(a, b): return 1 if a == -b else 0
    for u in IDX:
        for v in IDX:
            s = sum(c*g(b, v) for b, c in X.get(u, {}).items()) \
              + sum(c*g(u, b) for b, c in X.get(v, {}).items())
            assert s == 0, (X, u, v, s)
for X in Ev: check_so(X)
print("the six simple raising operators lie in so(12)")

# ---- Lambda^2 basis ----
L2 = [(a, b) for a, b in combinations(IDX, 2)]
L2i = {p: k for k, p in enumerate(L2)}
assert len(L2) == 66
def wt2(p): return tuple(x+y for x, y in zip(wt1(p[0]), wt1(p[1])))

def norm2(a, b):
    """f_a ^ f_b in the ordered basis, as (key, sign) or None."""
    if a == b: return None
    return ((a, b), 1) if POSN[a] < POSN[b] else ((b, a), -1)

def act_L2(X, p):
    """X acting on the Lambda^2 basis element p, as a dict."""
    out = defaultdict(int)
    a, b = p
    for c, co in X.get(a, {}).items():
        r = norm2(c, b)
        if r: out[r[0]] += co*r[1]
    for c, co in X.get(b, {}).items():
        r = norm2(a, c)
        if r: out[r[0]] += co*r[1]
    return {k: v for k, v in out.items() if v}

# ---- Sym^2(Lambda^2) basis, graded by weight ----
S2 = [(p, q) for p, q in combinations(L2, 2)] + [(p, p) for p in L2]
S2 = [tuple(sorted(m, key=lambda p: L2i[p])) for m in S2]
S2 = sorted(set(S2), key=lambda m: (L2i[m[0]], L2i[m[1]]))
assert len(S2) == 2211
def wtS2(m): return tuple(x+y for x, y in zip(wt2(m[0]), wt2(m[1])))
BYW = defaultdict(list)
for m in S2: BYW[wtS2(m)].append(m)
print(f"Sym^2(Lambda^2 V): {len(S2)} monomials over {len(BYW)} weights, "
      f"largest weight space {max(len(v) for v in BYW.values())}")

def act_S2(X, m):
    out = defaultdict(int)
    p, q = m
    for r, c in act_L2(X, p).items():
        k = tuple(sorted((r, q), key=lambda z: L2i[z])); out[k] += c
    for r, c in act_L2(X, q).items():
        k = tuple(sorted((p, r), key=lambda z: L2i[z])); out[k] += c
    return {k: v for k, v in out.items() if v}

# ---- the two cutting maps ----
def wedge4(m):
    """monomial P*Q -> P ^ Q in Lambda^4, as (key, sign) or None."""
    a, b = m[0]; c, d = m[1]
    s = [a, b, c, d]
    if len(set(s)) < 4: return None
    sg = 1
    for i in range(4):
        for j in range(i+1, 4):
            if POSN[s[i]] > POSN[s[j]]: sg = -sg
    return (tuple(sorted(s, key=lambda z: POSN[z])), sg)

def P2(p, x, y):
    a, b = p
    return (1 if (x == a and y == b) else 0) - (1 if (x == b and y == a) else 0)

def ric(m):
    """monomial P*Q -> Ric_{yz} = sum_x [P_{xy} Q_{-x,z} + Q_{xy} P_{-x,z}]."""
    p, q = m
    out = defaultdict(int)
    for (u, v) in ((p, q), (q, p)):
        a, b = u
        # x = a gives +delta_{y,b} * v_{-a,z};  x = b gives -delta_{y,a} * v_{-b,z}
        for (y, xx, sg) in ((b, a, 1), (a, b, -1)):
            for z in IDX:
                c = P2(v, -xx, z)
                if c: out[(y, z)] += sg*c
    return {k: v for k, v in out.items() if v}

# ---- kernel, one weight space at a time ----
def nullspace(rows, ncol):
    """exact nullspace of the matrix whose rows are dicts col->value."""
    M = [[F(0)]*ncol for _ in rows]
    for i, r in enumerate(rows):
        for j, v in r.items(): M[i][j] = F(v)
    piv = []
    r = 0
    for c in range(ncol):
        pr = None
        for i in range(r, len(M)):
            if M[i][c]: pr = i; break
        if pr is None: continue
        M[r], M[pr] = M[pr], M[r]
        iv = M[r][c]
        M[r] = [x/iv for x in M[r]]
        for i in range(len(M)):
            if i != r and M[i][c]:
                f = M[i][c]
                M[i] = [x - f*y for x, y in zip(M[i], M[r])]
        piv.append(c); r += 1
        if r == len(M): break
    free = [c for c in range(ncol) if c not in set(piv)]
    basis = []
    for fc in free:
        v = [F(0)]*ncol; v[fc] = F(1)
        for i, c in enumerate(piv): v[c] = -M[i][fc]
        basis.append(v)
    return basis

t0 = time.time()
WEYL = {}          # weight -> list of vectors, each a dict monomial->Fraction
for w, mons in BYW.items():
    ncol = len(mons)
    ci = {m: k for k, m in enumerate(mons)}
    rows = defaultdict(dict)
    for m in mons:
        r = wedge4(m)
        if r: rows[("w",)+r[0]][ci[m]] = r[1]
        for k, v in ric(m).items(): rows[("r",)+k][ci[m]] = v
    ns = nullspace(list(rows.values()), ncol)
    if ns: WEYL[w] = [{mons[j]: x for j, x in enumerate(v) if x} for v in ns]

dim = sum(len(v) for v in WEYL.values())
print(f"\ndim Weyl_12 from the explicit construction: {dim}   [{time.time()-t0:.0f}s]")
assert dim == 1638, dim
mults = defaultdict(int)
for w, v in WEYL.items(): mults[len(v)] += 1
print(f"  weight multiplicities seen (multiplicity: how many weights): {dict(sorted(mults.items()))}")
print(f"  multiplicity of the zero weight: {len(WEYL[(0,)*R])}")
print(f"  distinct weights: {len(WEYL)}")

# ---- the six raising operators on the weight basis ----
def solve_in(target_basis, vec):
    """coordinates of vec (a dict on S2 monomials) in the given Weyl weight basis."""
    if not vec: return [F(0)]*len(target_basis)
    cols = sorted({m for b in target_basis for m in b} | set(vec), key=lambda m: (L2i[m[0]], L2i[m[1]]))
    ci = {m: k for k, m in enumerate(cols)}
    n = len(target_basis)
    M = [[F(b.get(m, 0)) for b in target_basis] + [F(vec.get(m, 0))] for m in cols]
    r = 0; piv = []
    for c in range(n):
        pr = None
        for i in range(r, len(M)):
            if M[i][c]: pr = i; break
        assert pr is not None
        M[r], M[pr] = M[pr], M[r]
        iv = M[r][c]; M[r] = [x/iv for x in M[r]]
        for i in range(len(M)):
            if i != r and M[i][c]:
                f = M[i][c]; M[i] = [x - f*y for x, y in zip(M[i], M[r])]
        piv.append(c); r += 1
    sol = [F(0)]*n
    for i, c in enumerate(piv): sol[c] = M[i][-1]
    for i in range(r, len(M)):
        assert M[i][-1] == 0, "the image left the Weyl module -- not a submodule"
    return sol

ALPHA = [tuple((1 if k == i else 0) - (1 if k == i+1 else 0) for k in range(R)) for i in range(5)]
ALPHA.append(tuple(1 if k in (4, 5) else 0 for k in range(R)))
t1 = time.time()
E = [defaultdict(dict) for _ in range(6)]     # E[i][weight] = matrix rows as dict
nnz = [0]*6
for w, basis in WEYL.items():
    for i in range(6):
        tw = tuple(a+b for a, b in zip(w, ALPHA[i]))
        tb = WEYL.get(tw)
        cols = []
        for b in basis:
            img = defaultdict(F)
            for m, c in b.items():
                for k, v in act_S2(Ev[i], m).items(): img[k] += c*v
            img = {k: v for k, v in img.items() if v}
            if not img: cols.append([F(0)]*(len(tb) if tb else 0)); continue
            assert tb is not None, "raising landed on a weight the module does not carry"
            cols.append(solve_in(tb, img))
        if tb is not None:
            E[i][w] = cols
            nnz[i] += sum(1 for c in cols for x in c if x)
print(f"\nthe six simple raising operators, weight block by weight block "
      f"[{time.time()-t1:.0f}s]")
print(f"  nonzeros in E_i on the 1638-dim weight basis: {nnz}")
print(f"  total {sum(nnz)} nonzeros in all six, against 6*1638^2 = {6*1638*1638:,} dense")
print(f"  density {sum(nnz)/(6*1638*1638):.5f}")

with open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "weyl12.pkl"), "wb") as f:
    pickle.dump({"WEYL": {w: len(v) for w, v in WEYL.items()},
                 "E": {i: {w: [[str(x) for x in c] for c in E[i][w]] for w in E[i]} for i in range(6)},
                 "ALPHA": ALPHA}, f)
print("  cached")
