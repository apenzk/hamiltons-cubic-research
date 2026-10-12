"""The 41 cubic forms P_i(W) = <W^3, u_i>, in real coordinates on Weyl_5.

Reviewer 182's route needs these and nothing else from the highest-weight side:
the 14 x 36 system is <P_i conj(P_j), J_b> = <F_5, J_b>, an apolarity pairing of
a product of two explicit cubics against an explicit invariant sextic.  No copy
of any V_lambda is generated and no adapted basis exists.

Each u_i sits in a single weight space of Sym^3, so P_i has at most 234
monomials.  The pairing <W^3, u_i> is taken with the INVARIANT inner product --
run_n5_inner_product.py builds it, and reviewer 183 proved it invariant and
unique up to scale.  Its normalisation must match the one F_5 is carried in, or
powers of 4 leak into the SDP (reviewer 183).

Check: P_i is the cubic form of a highest-weight vector, so as a polynomial it
is annihilated by both raising operators acting as derivations on W.
A TRAP, recorded by reviewer 190: torus covariance passes for BOTH the plain and
the multiplicity-weighted conventions, since the weighting is diagonal within
each weight space.  A weight check cannot audit this.  What discriminates is
that the trivial block's P_1 must be an SO(5)-INVARIANT cubic -- the plain
contraction gives 144*tr(M^3) exactly and the weighted one is invariant at no
sample.
"""
from fractions import Fraction as F
import importlib.util, sys, os, json, time

d = os.path.dirname(os.path.abspath(__file__))
CACHE = os.path.join(d, "n5_hw_cache.json")
if not os.path.exists(CACHE):
    print("cache absent; run run_n5_highest_weight.py first to build it")
    sys.exit(1)

C = json.load(open(CACHE))
print(f"cache: {len(C['weights'])} weight labels, "
      f"{sum(len(v['vecs']) for v in C['hw'].values())} highest-weight vectors")

class G:
    __slots__ = ("r", "i")
    def __init__(s, r=0, i=0): s.r = F(r); s.i = F(i)
    def __add__(s, o): o = mk(o); return G(s.r+o.r, s.i+o.i)
    def __sub__(s, o): o = mk(o); return G(s.r-o.r, s.i-o.i)
    def __mul__(s, o):
        o = mk(o); return G(s.r*o.r - s.i*o.i, s.r*o.i + s.i*o.r)
    __rmul__ = __mul__
    def conj(s): return G(s.r, -s.i)
    def __bool__(s): return bool(s.r) or bool(s.i)
    def __repr__(s): return f"({s.r}{'+' if s.i>=0 else '-'}{abs(s.i)}i)"
def mk(x): return x if isinstance(x, G) else G(x)
def fromjson(p): return G(F(p[0][0], p[0][1]), F(p[1][0], p[1][1]))

from itertools import combinations_with_replacement
MONO = list(combinations_with_replacement(range(35), 3))
print(f"Sym^3 monomials: {len(MONO)} (7770: {len(MONO)==7770})")

hw = {}
for key, v in C["hw"].items():
    lam = tuple(int(x) for x in key.split(","))
    cols = v["cols"]
    hw[lam] = [{cols[j]: fromjson(x) for j, x in enumerate(vec) if fromjson(x)}
               for vec in v["vecs"]]
tot = sum(len(v) for v in hw.values())
print(f"loaded {tot} highest-weight vectors across {len(hw)} blocks (41: {tot==41})")

sizes = sorted((len(u) for vs in hw.values() for u in vs), reverse=True)
print(f"  support sizes: largest {sizes[0]}, smallest {sizes[-1]}, "
      f"mean {sum(sizes)/len(sizes):.0f}")
print(f"  all within the 234 bound (the largest Sym^3 weight space): "
      f"{sizes[0] <= 234}")
# The docstring promised a raising-operator check and the script ran none
# (reviewer 186).  Here it is, from the cache alone: each u_i is a highest-weight
# vector, so both raising operators annihilate it.
E1 = [[fromjson(x) for x in row] for row in C["E1C"]]
E2 = [[fromjson(x) for x in row] for row in C["E2C"]]
MIDX = {m: i for i, m in enumerate(MONO)}

def raise_vec(vec, EC):
    out = {}
    for idx, co in vec.items():
        a, b, c = MONO[idx]
        for pos, x in enumerate((a, b, c)):
            rest = [y for j, y in enumerate((a, b, c)) if j != pos]
            for t in range(35):
                if EC[x][t]:
                    j = MIDX[tuple(sorted(rest + [t]))]
                    out[j] = out.get(j, G()) + co*EC[x][t]
    return {k: v for k, v in out.items() if v}

killed = sum(1 for vs in hw.values() for u in vs
             if not raise_vec(u, E1) and not raise_vec(u, E2))
print(f"\n  both raising operators annihilate u_i: {killed}/{tot}")

# THIS CHECK IS CIRCULAR and reviewer 188 is right about it: raise_vec applies
# the same E1C, E2C that nullspace_G used to DEFINE the u_i, so the only failure
# it can register is an arithmetic bug inside that nullspace.  A wrong root
# vector or a wrong Cartan propagates identically into both sides and is
# invisible here.  The conclusion is independently true -- 188 rebuilt the block
# table from characters with no pipeline code and sandwiched the 41 -- but this
# is not what establishes it.
#
# The teeth were also blunter than the check: perturbing across all 7770
# monomials almost always lands at a DIFFERENT weight, which is raised
# nontrivially for that reason alone, so 36/36 was near-certain by construction.
# A tooth that means something perturbs INSIDE the lambda-weight space.
import random
random.seed(9)
WT = {tuple(w) for w in C["weights"]}
wt_of = lambda idx: tuple(sum(C["weights"][a][k] for a in MONO[idx]) for k in (0, 1))
teeth = trials = 0
for lam, vs in hw.items():
    for u in vs[:2]:
        same = [m for m in range(len(MONO)) if wt_of(m) == lam and m not in u]
        if not same: continue
        pert = dict(u); pert[random.choice(same)] = G(1)
        trials += 1
        if raise_vec(pert, E1) or raise_vec(pert, E2): teeth += 1
print(f"  perturbed WITHIN the weight space, survives a raising operator: "
      f"{teeth}/{trials}   <- a tooth that is not automatic")
