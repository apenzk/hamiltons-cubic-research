import json, collections, math
from fractions import Fraction
d = {tuple(json.loads(k)): v for k,v in json.load(open("/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/ea3d63f3-07ce-4bf2-a0fb-4a245ad3dc41/scratchpad/w12.json")).items()}
f = d
print("weights:", len(f), "dim:", sum(f.values()))
def conv(a,b):
    out = collections.defaultdict(int)
    for ka,va in a.items():
        for kb,vb in b.items():
            out[tuple(x+y for x,y in zip(ka,kb))] += va*vb
    return out
f2 = conv(f,f); print("f*f support:", len(f2), "total:", sum(f2.values()))
f3 = conv(f2,f); print("f*f*f support:", len(f3), "total:", sum(f3.values()))
# chi(x^2): weights doubled
g2 = {tuple(2*x for x in k): v for k,v in f.items()}
g3 = {tuple(3*x for x in k): v for k,v in f.items()}
p = conv(g2,f)
sym3 = {}
for k in f3:
    val = f3[k] + 3*p.get(k,0) + 2*g3.get(k,0)
    assert val % 6 == 0, (k,val)
    if val: sym3[k] = val//6
tot = sum(sym3.values())
print("dim Sym^3(Weyl_12) =", tot, " expected:", math.comb(1640,3), " match:", tot==math.comb(1640,3))
mx = max(sym3.values())
print("LARGEST weight space of Sym^3(Weyl_12):", mx, "at", [k for k,v in sym3.items() if v==mx])
print("distinct weights of Sym^3:", len(sym3))
top = sorted(sym3.values(), reverse=True)[:12]
print("top 12 weight-space dims:", top)
print("bytes for largest weight space (float64):", mx*8, "=", round(mx*8/1e6,2), "MB")
print("bytes for a DENSE Sym^3 vector:", tot*8/1e9, "GB")
# dominant weights of the 71 blocks are what one needs kernels in; report sizes at a few
for w in [(2,2,0,0,0,0),(4,2,0,0,0,0),(6,6,0,0,0,0),(0,0,0,0,0,0),(2,2,2,2,2,2),(4,4,4,0,0,0)]:
    print("  weight", w, "-> dim", sym3.get(w,0))
