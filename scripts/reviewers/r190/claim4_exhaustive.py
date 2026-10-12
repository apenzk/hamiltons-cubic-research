"""Claim 4, decided exhaustively instead of by sampling.

The worst cross-pair count depends only on the 6-vertex multigraph, never on which
slot of W an edge lands in.  And the slot freedom is tiny: W is antisymmetric in
(0,1), antisymmetric in (2,3) and symmetric under swapping the pairs, so the 4! slot
permutations at a vertex collapse to 4!/8 = 3 classes, differing at worst by a sign.
So the whole cap-C family is covered by

    (multigraphs with maxcut <= C, up to isomorphism)  x  3^6 slot assignments,

and the rank of that family is computable outright.  Isomorphism is safe to quotient
by because the six W's are the same tensor.
"""
import os, sys, time
from itertools import combinations, permutations, product
import numpy as np

d = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(d, "..", "r179"))
import weyl_invariants as WI

NV, DEG, PP = 6, 4, 100003
SPLITS = [frozenset(c) for c in combinations(range(NV), 3) if 0 in c]
PAIRS = list(combinations(range(NV), 2))

# ---------- enumerate 4-regular loopless multigraphs on 6 labelled vertices ----------
def enum_graphs():
    out = []
    deg = [0]*NV
    mult = {}
    def rec(k):
        if k == len(PAIRS):
            if all(x == DEG for x in deg): out.append(dict(mult))
            return
        u, v = PAIRS[k]
        hi = min(DEG - deg[u], DEG - deg[v])
        # prune: remaining capacity of u must be fillable by later pairs touching u
        for m in range(hi, -1, -1):
            deg[u] += m; deg[v] += m; mult[(u, v)] = m
            rem_u = sum(1 for (a, b) in PAIRS[k+1:] if a == u or b == u)
            if deg[u] == DEG or rem_u > 0:
                rec(k+1)
            deg[u] -= m; deg[v] -= m; del mult[(u, v)]
    rec(0)
    return out

def maxcut(mult):
    return max(sum(m for (u, v), m in mult.items() if ((u in S) != (v in S)))
               for S in SPLITS)

def canon(mult):
    best = None
    for perm in permutations(range(NV)):
        key = tuple(mult.get(tuple(sorted((perm[u], perm[v]))), 0) for (u, v) in PAIRS)
        if best is None or key < best: best = key
    return best

t0 = time.time()
GR = enum_graphs()
print(f"labelled 4-regular loopless multigraphs on 6 vertices: {len(GR)}  [{time.time()-t0:.0f}s]")
classes = {}
for g in GR:
    classes.setdefault(canon(g), g)
print(f"isomorphism classes: {len(classes)}")
from collections import Counter
mc = Counter(maxcut(g) for g in classes.values())
print(f"maxcut over the classes: {dict(sorted(mc.items()))}")

# ---------- the three slot classes at a vertex ----------
H = set()
base = (0, 1, 2, 3)
gens = [(1, 0, 2, 3), (0, 1, 3, 2), (2, 3, 0, 1)]
frontier = [base]; H.add(base)
while frontier:
    x = frontier.pop()
    for gperm in gens:
        y = tuple(x[gperm[i]] for i in range(4))
        if y not in H: H.add(y); frontier.append(y)
print(f"index symmetry group of W on its four slots: order {len(H)}")
reps, seen = [], set()
for pmt in permutations(range(4)):
    if pmt in seen: continue
    reps.append(pmt)
    for h in H: seen.add(tuple(pmt[h[i]] for i in range(4)))
print(f"slot classes per vertex: {len(reps)}  -> {len(reps)**NV} assignments per graph")

# ---------- build a matching from (graph, slot assignment) ----------
def matchings(mult, assign):
    inc = {v: [] for v in range(NV)}
    edges = []
    for (u, v), m in mult.items():
        for _ in range(m):
            e = len(edges); edges.append((u, v))
            inc[u].append(e); inc[v].append(e)
    slot_of = {}
    for v in range(NV):
        pmt = reps[assign[v]]
        for pos, e in enumerate(inc[v]):
            slot_of[(e, v)] = 4*v + pmt[pos]
    return [(slot_of[(e, u)], slot_of[(e, v)]) for e, (u, v) in enumerate(edges)]

# ---------- evaluation ----------
NPTS = 30
rng = np.random.default_rng(555)
PTS = [WI.random_weyl(5, PP, rng) for _ in range(NPTS)]

class Reducer:
    def __init__(s): s.rows = []; s.piv = []
    def add(s, v):
        v = [x % PP for x in v]
        for p, r in zip(s.piv, s.rows):
            if v[p]:
                f = v[p]; v = [(a - f*b) % PP for a, b in zip(v, r)]
        nz = next((i for i, x in enumerate(v) if x), None)
        if nz is None: return False
        inv = pow(v[nz], PP-2, PP); v = [x*inv % PP for x in v]
        s.rows.append(v); s.piv.append(nz); return True
    def rank(s): return len(s.rows)

CAPS = [8, 10, 12]
for CAP in CAPS:
    red = Reducer(); n_g = n_d = 0
    t0 = time.time()
    for key, g in classes.items():
        if maxcut(g) > CAP: continue
        n_g += 1
        for assign in product(range(len(reps)), repeat=NV):
            m = matchings(g, assign)
            if any(a//4 == b//4 for a, b in m):   # a self-pairing: value 0 anyway
                continue
            col = [WI.eval_diagram(W, m, NV, PP) % PP for W in PTS]
            n_d += 1
            red.add(col)
            if red.rank() >= 14: break
        if red.rank() >= 14: break
    print(f"CAP {CAP:2d}: {n_g} iso classes, {n_d} diagrams evaluated, "
          f"RANK {red.rank()}  [{time.time()-t0:.0f}s]", flush=True)
