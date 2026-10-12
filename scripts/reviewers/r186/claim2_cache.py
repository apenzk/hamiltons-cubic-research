"""Claim 2, r186: the 41 cubic forms' support, and whether the cache is faithful.

run_n5_cubic_forms.py READS the cache and reports support sizes.  Its docstring
promises a raising-operator check on the vectors; the script does not run one.
That check is run here, from the cache alone.
"""
import json, os
from fractions import Fraction as F
from itertools import combinations_with_replacement

d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
C = json.load(open(os.path.join(d, "n5_hw_cache.json")))
WWT = [tuple(w) for w in C["weights"]]
def g(p): return (F(p[0][0], p[0][1]), F(p[1][0], p[1][1]))
def gmul(x, y): return (x[0]*y[0] - x[1]*y[1], x[0]*y[1] + x[1]*y[0])
def gadd(x, y): return (x[0]+y[0], x[1]+y[1])
ZERO = (F(0), F(0))

MONO = list(combinations_with_replacement(range(35), 3))
MIDX = {m: i for i, m in enumerate(MONO)}
MW = [tuple(WWT[a][k]+WWT[b][k]+WWT[c][k] for k in (0, 1)) for a, b, c in MONO]
BYW = {}
for idx, w in enumerate(MW): BYW.setdefault(w, []).append(idx)
print(f"Sym^3 monomials {len(MONO)} (7770: {len(MONO)==7770}), "
      f"{len(BYW)} weight spaces")
mx = max(BYW, key=lambda k: len(BYW[k]))
print(f"  largest weight space: {len(BYW[mx])} at weight {mx}  (the 234 bound)")

hw = {}
for key, v in C["hw"].items():
    lam = tuple(int(x) for x in key.split(","))
    cols = v["cols"]
    hw[lam] = [{cols[j]: g(x) for j, x in enumerate(vec) if g(x) != ZERO}
               for vec in v["vecs"]]
tot = sum(len(v) for v in hw.values())
sizes = sorted((len(u) for vs in hw.values() for u in vs))
print(f"\n{tot} hw vectors in {len(hw)} blocks (41: {tot==41})")
print(f"  support sizes {sizes[0]}..{sizes[-1]}, mean {sum(sizes)/len(sizes):.1f}, "
      f"all <= 234: {sizes[-1] <= 234}")
print(f"  the record reports 1..195, mean 49: "
      f"{(sizes[0], sizes[-1], round(sum(sizes)/len(sizes))) == (1, 195, 49)}")

# every vector lives in ONE weight space, and that space's size caps its support
bad_w = 0; caps = []
for lam, vs in hw.items():
    for u in vs:
        ws = {MW[i] for i in u}
        if len(ws) != 1: bad_w += 1; continue
        w = ws.pop()
        caps.append((len(u), len(BYW[w])))
        if len(u) > len(BYW[w]): bad_w += 1
print(f"  each support lies in a single Sym^3 weight space, and within it: "
      f"{bad_w == 0}")
print(f"  support / weight-space size, largest five: "
      f"{sorted(caps, reverse=True)[:5]}")

# --- the check run_n5_cubic_forms.py promises and does not run ---
E1C = [[g(x) for x in row] for row in C["E1C"]]
E2C = [[g(x) for x in row] for row in C["E2C"]]
def raise_vec(u, EC):
    out = {}
    for idx, co in u.items():
        a, b, c = MONO[idx]
        for pos, x in enumerate((a, b, c)):
            rest = [y for j, y in enumerate((a, b, c)) if j != pos]
            for t in range(35):
                v = EC[x][t]
                if v != ZERO:
                    j = MIDX[tuple(sorted(rest + [t]))]
                    out[j] = gadd(out.get(j, ZERO), gmul(co, v))
    return {k: v for k, v in out.items() if v != ZERO}

print("\n=== E1 u = E2 u = 0 for every cached vector, exactly over Q(i) ===")
bad = 0
for lam in sorted(hw):
    for u in hw[lam]:
        if raise_vec(u, E1C) or raise_vec(u, E2C): bad += 1
print(f"  vectors annihilated by both raising operators: {tot-bad}/{tot}")

# teeth: the same test on perturbed vectors
import random
rnd = random.Random(186); rej = 0; trials = 0
for lam in sorted(hw):
    for u in hw[lam]:
        if len(u) < 2: continue
        trials += 1
        up = dict(u); k = rnd.choice(list(up)); up[k] = gadd(up[k], (F(1), F(0)))
        if raise_vec(up, E1C) or raise_vec(up, E2C): rej += 1
print(f"  teeth: one coefficient bumped by 1 -> rejected {rej}/{trials}")

# weight labels: does the cached lambda match the weight of the support?
badlab = 0
for lam, vs in hw.items():
    for u in vs:
        w = MW[next(iter(u))]
        if w != lam: badlab += 1
print(f"  cached block label == the support's weight, all {tot}: {badlab == 0}")
