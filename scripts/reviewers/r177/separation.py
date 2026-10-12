#!/usr/bin/env python3
"""r177: do the so(12) Casimirs separate the O(12)-blocks of Sym^3(Weyl_12)?"""
import json
from collections import defaultdict
here = "scripts/reviewers/r177/"
dec = json.load(open(here + "decomp_D6.json"))
rho = [5,4,3,2,1,0]
# collapse SO(12) constituents into O(12) blocks: lam and its lam_6-negation are one block
blocks = {}
for lam, m, d in dec:
    key = tuple(lam[:5] + [abs(lam[5])])
    if key in blocks:
        blocks[key][0] += m; blocks[key][1] += d
    else:
        blocks[key] = [m, d, lam[5] != 0]
print("SO(12) constituents:", len(dec), "  O(12) blocks:", len(blocks))
print("blocks that split under SO(12) (lam_6 != 0):", sum(1 for v in blocks.values() if v[2]))
tot = sum(m*d for m,d,_ in blocks.values())
print("sum m*dim over O-blocks:", tot)

rows = []
for key, (m, d, split) in blocks.items():
    l = [key[i] + rho[i] for i in range(6)]
    p = {k: sum(v**k for v in l) for k in (2,4,6,8,10)}
    pf = 1
    for v in l: pf *= v
    rows.append((key, m, d, split, tuple(p[k] for k in (2,4,6,8,10)), pf))

def collide(sel, name):
    g = defaultdict(list)
    for r in rows: g[tuple(r[4][i] for i in sel)].append(r[0])
    bad = {k: v for k, v in g.items() if len(v) > 1}
    print("%-28s distinct values %3d / %d   collisions: %d" % (name, len(g), len(rows), len(bad)))
    for k, v in bad.items(): print("      ", k, "->", v)
    return bad

collide((0,), "p2 alone (c2)")
collide((0,1), "p2,p4 (c2,c4)")
collide((0,1,2), "p2,p4,p6")
collide((0,1,2,3,4), "p2,p4,p6,p8,p10 (FIVE)")
# and with the Pfaffian added
g = defaultdict(list)
for r in rows: g[(r[4], abs(r[5]))].append(r[0])
print("five Casimirs + |Pfaffian|: distinct %d / %d" % (len(g), len(rows)))
# is e_6 = 0 for all blocks?  (the claimed premise)
nz = [r[0] for r in rows if r[5] != 0]
print("blocks with Pfaffian != 0 (i.e. lam_6 != 0):", len(nz), nz)
