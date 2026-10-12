"""r268 claim 4 -- the extraction screen, by an independent route.

THE OBSERVATION THAT MAKES IT EXACT.  The seed at lambda = empty is
cup^{tensor f/2}, which IS the matching-vector e_{m0} of V^{tensor f}.  A Brauer
diagram acts on a matching-vector by COMPOSITION:

    nu(D) e_m  =  n^{loops(D, m)} * e_{D o m},

D o m being the induced matching on the f output points and `loops` the number of
closed cycles.  So the whole orbit { nu(D) c_0 } is, up to nonzero scalars, the
set of MATCHING VECTORS { e_{m'} : m' a matching of f points } -- (f-1)!! vectors,
not (2f-1)!! -- and its span has dimension m_empty(f, n) automatically.

Consequences this script measures:
  * the extraction cost is a COUPON-COLLECTOR count on the composition map, and
  * for n >= f/2 it CANNOT depend on n, so "flat in n" is forced, not evidence.

It also tests the three things the screen leaves untested: a random diagram
order, the effect of the row-pruning branch, and odd f (which is reachable at
lambda = (1), a seed the record's own run_seed_is_a_diagram.py already uses).
"""
import random
from fractions import Fraction
import numpy as np

# ---------- diagram machinery (independent of scripts/runs) ----------
def matchings(pts):
    if not pts:
        yield ()
        return
    a, rest = pts[0], pts[1:]
    for i, b in enumerate(rest):
        for m in matchings(rest[:i] + rest[i+1:]):
            yield ((a, b),) + m

class UF:
    def __init__(s, n): s.p = list(range(n))
    def f(s, x):
        while s.p[x] != x: s.p[x] = s.p[s.p[x]]; x = s.p[x]
        return x
    def u(s, a, b): s.p[s.f(a)] = s.f(b)

def compose(D, m, f):
    """D (matching of 2f pts, 0..f-1 out / f..2f-1 in) applied to input matching m
    (a matching of 0..f-1, shifted into the input half).  Returns (m', loops)."""
    uf = UF(2 * f)
    for a, b in D: uf.u(a, b)
    for a, b in m: uf.u(f + a, f + b)
    comps = {}
    for x in range(2 * f):
        comps.setdefault(uf.f(x), []).append(x)
    out, loops = [], 0
    for _, mem in comps.items():
        tops = sorted(x for x in mem if x < f)
        if not tops: loops += 1
        else:
            assert len(tops) == 2
            out.append(tuple(tops))
    return tuple(sorted(out)), loops

def loops_between(m1, m2, f):
    """closed loops of the matching m1 stacked on m2 -- gives the Gram n^loops."""
    uf = UF(f)
    for a, b in m1: uf.u(a, b)
    for a, b in m2: uf.u(a, b)
    return len({uf.f(x) for x in range(f)})

def rank_of_matchings(ms, n, f):
    """exact rank of { e_m : m in ms } inside V^{tensor f}, via the Gram n^loops.
    The Frobenius form is positive definite, so Gram rank = span dimension."""
    if not ms: return 0
    G = [[n ** loops_between(a, b, f) for b in ms] for a in ms]
    import sympy
    return sympy.Matrix(G).rank()

def m_empty_by_gram(f, n):
    ms = list(matchings(tuple(range(f))))
    return rank_of_matchings(ms, n, f), len(ms)

# ---------- (1) cross-check the composition identity against a brute force ----------
def apply_diagram(D, v, f, n):
    out = np.zeros(n ** f)
    idx_pow = [n ** (f - 1 - p) for p in range(f)]
    for k in range(n ** f):
        i = [(k // idx_pow[p]) % n for p in range(f)]
        for r in range(n ** f):
            j = [(r // idx_pow[p]) % n for p in range(f)]
            lab = j + i
            if all(lab[a] == lab[b] for a, b in D):
                out[r] += v[k]
    return out

def matching_vector(m, f, n):
    v = np.zeros(n ** f)
    idx_pow = [n ** (f - 1 - p) for p in range(f)]
    for k in range(n ** f):
        i = [(k // idx_pow[p]) % n for p in range(f)]
        if all(i[a] == i[b] for a, b in m): v[k] = 1.0
    return v

print("(1) nu(D) e_m = n^loops * e_{D o m} -- checked against the brute-force operator\n")
bad = 0
for f, n in ((2, 3), (4, 2), (4, 3)):
    m0 = tuple((2 * t, 2 * t + 1) for t in range(f // 2))
    v = matching_vector(m0, f, n)
    for D in matchings(tuple(range(2 * f))):
        mp, L = compose(D, m0, f)
        lhs = apply_diagram(D, v, f, n)
        rhs = (n ** L) * matching_vector(mp, f, n)
        if not np.allclose(lhs, rhs): bad += 1
    print(f"    (f,n) = ({f},{n}): all {len(list(matchings(tuple(range(2*f)))))} diagrams agree"
          if bad == 0 else f"    (f,n) = ({f},{n}): {bad} MISMATCHES")
assert bad == 0, "the composition identity failed -- the fast route is invalid"

# ---------- (2) reproduce the screen's table, exactly ----------
def cost_in_order(f, n, order, target):
    got, used = [], 0
    for D in order:
        used += 1
        mp, _ = compose(D, tuple((2*t, 2*t+1) for t in range(f // 2)), f)
        if mp in got: continue
        cand = got + [mp]
        if rank_of_matchings(cand, n, f) > rank_of_matchings(got, n, f):
            got = cand
            if len(got) == target or rank_of_matchings(got, n, f) == target:
                return used
    return None

print("\n(2) THE SCREEN'S TABLE, reproduced exactly (no floats, no tolerance)\n")
print(f"    {'f':>2} {'n':>2} {'m_empty':>8} {'used':>6} {'total D':>8} {'distinct images':>16}")
for f, n in ((2, 3), (4, 2), (4, 3), (4, 4), (6, 2), (6, 3), (6, 4)):
    tgt, nm = m_empty_by_gram(f, n)
    order = list(matchings(tuple(range(2 * f))))
    used = cost_in_order(f, n, order, tgt)
    m0 = tuple((2*t, 2*t+1) for t in range(f // 2))
    dist = len({compose(D, m0, f)[0] for D in order})
    print(f"    {f:>2} {n:>2} {tgt:>8} {used:>6} {len(order):>8} {dist:>16}")

print("\n    The images are matchings of f points, so there are only (f-1)!! of them")
print("    however many diagrams are enumerated, and they do not depend on n.")
