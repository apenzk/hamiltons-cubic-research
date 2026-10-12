import json, collections
f = {tuple(json.loads(k)): v for k,v in json.load(open("w12.json")).items()}
def conv(a,b):
    out = collections.defaultdict(int)
    for ka,va in a.items():
        for kb,vb in b.items():
            out[tuple(x+y for x,y in zip(ka,kb))] += va*vb
    return out
f2 = conv(f,f); f3 = conv(f2,f)
g2 = {tuple(2*x for x in k): v for k,v in f.items()}
g3 = {tuple(3*x for x in k): v for k,v in f.items()}
p = conv(g2,f)
sym3 = {}
for k in f3:
    val = f3[k] + 3*p.get(k,0) + 2*g3.get(k,0)
    if val: sym3[k] = val//6
labels = json.load(open("labels.json"))
rows = []
for lam, m in labels:
    w = tuple((lam+[0]*6)[:6])
    rows.append((sym3.get(w,0), lam, m))
rows.sort(reverse=True)
print("71 blocks: highest weight -> dim of that weight space in Sym^3(Weyl_12)")
for d,lam,m in rows: print("  %9d   %-22s mult %d" % (d, lam, m))
print()
print("MAX over the 71 block weights:", rows[0][0], "=", round(rows[0][0]*8/1e6,2), "MB float64")
print("2nd:", rows[1][0], " median:", rows[len(rows)//2][0], " min:", rows[-1][0])
print("dim Sym^3 =", sum(sym3.values()), " ratio max_block_weightspace/dimSym3 =", round(sum(sym3.values())/rows[0][0]))
print("sum of all 71 block weight spaces:", sum(r[0] for r in rows), "=", round(sum(r[0] for r in rows)*8/1e6,1), "MB")
