"""Attack N8 step (ii)/(iv): is (e o X) really independent of the number of spare indices?

e o X is LINEAR in e, so compute it exactly for the three indicator epsilons
(PP-only, QQ-only, PQ-only) and reassemble the symbolic answer.
Universe: 2 core P + kp spare P, 2 core Q + kq spare Q.
"""
import sys, sympy as sp
from fractions import Fraction as F
sys.path.insert(0, 'scripts/lib')
from review_r33_n8 import pairs, c_full, X_support

ePP, eQQ, ePQ = sp.symbols('e_PP e_QQ e_PQ')

def block(i, j, p):
    if i < p and j < p: return 0
    if i >= p and j >= p: return 1
    return 2

def eox(p, q, epsv):
    """e o X with e diagonal given by epsv (list per plane).  Fractions."""
    n = p + q; D = n*(n-1)//2
    C = c_full(n)
    by_am = {}; by_rq = {}
    for (a, m, r), v in C.items():
        by_am.setdefault((a, m), []).append((r, v))
        by_rq.setdefault((r, m), []).append((a, v))   # c_{a m r}: for fixed (r,q) find b with c_{b r q}
    # c_{b r q}: key (r,q) -> (b, val)
    brq = {}
    for (b, r, qq), v in C.items(): brq.setdefault((r, qq), []).append((b, v))
    Xe = X_support(p, q)
    out = {}
    for (a, b), v in Xe.items():
        out[(a, b)] = out.get((a, b), F(0)) + (epsv[a] + epsv[b]) * v / 2
    T = {}
    for (qq, mm), xv in Xe.items():
        for a in range(D):
            for (r, v1) in by_am.get((a, mm), []):
                w = xv * v1 * epsv[r]
                if w == 0: continue
                for (b, v2) in brq.get((r, qq), []):
                    T[(a, b)] = T.get((a, b), F(0)) + w * v2
    for (a, b), v in T.items():
        out[(a, b)] = out.get((a, b), F(0)) - v/4
        out[(b, a)] = out.get((b, a), F(0)) - v/4
    return {k: v for k, v in out.items() if v != 0}

def symbolic_eox(p, q):
    n = p + q; P = pairs(n)
    res = {}
    for t, sym in enumerate([ePP, eQQ, ePQ]):
        epsv = [F(1) if block(i, j, p) == t else F(0) for (i, j) in P]
        r = eox(p, q, epsv)
        for k, v in r.items():
            res[k] = res.get(k, 0) + sp.Rational(v.numerator, v.denominator)*sym
    return {k: sp.expand(v) for k, v in res.items() if sp.expand(v) != 0}, P

def typ(P, p, a, b, core):
    """classify a plane pair by (block-type, in-core pattern) so results can be compared across universes."""
    def pl(x):
        i, j = P[x]
        f = tuple(sorted(('c' if u in core else 's', 'P' if u < p else 'Q') for u in (i, j)))
        return f
    return (pl(a), pl(b))

print("=== spare-index independence: symbolic (e o X), grouped by plane-pair type ===")
prev = None
for k in range(0, 5):
    p, q = 2+k, 2+k
    core = {0, 1, p, p+1}
    res, P = symbolic_eox(p, q)
    # group by type; collect the SET of values seen per type
    g = {}
    for (a, b), v in res.items():
        g.setdefault(typ(P, p, a, b, core), set()).add(sp.simplify(v))
    g = {t: sorted(map(str, s)) for t, s in g.items()}
    print(f"  kp=kq={k} (n={p+q}, D={len(P)}): {len(res)} nonzero entries, {len(g)} pair-types")
    if prev is not None:
        common = set(prev) & set(g)
        mismatch = [t for t in common if prev[t] != g[t]]
        newt = set(g) - set(prev)
        print(f"     vs previous: {len(common)} shared types, {len(mismatch)} MISMATCH, {len(newt)} new types")
        for t in mismatch[:5]:
            print("        MISMATCH", t, prev[t], "->", g[t])
    prev = g

print()
print("=== the entries, symbolically, at kp=kq=3 (n=10) ===")
p, q = 5, 5; core = {0, 1, p, p+1}
res, P = symbolic_eox(p, q)
Xe = X_support(p, q)
g = {}
for (a, b), v in res.items():
    g.setdefault(typ(P, p, a, b, core), set()).add(sp.simplify(v))
for t in sorted(g, key=str):
    print("   ", t, sorted(map(str, g[t])))
print()
print("support entries (must be mu*X):")
for (a, b), xv in sorted(Xe.items()):
    print("   ", P[a], P[b], "X=", xv, " (eoX)=", sp.simplify(res.get((a, b), 0)),
          " ratio=", sp.simplify(res.get((a, b), 0)/sp.Rational(xv.numerator, xv.denominator)))
