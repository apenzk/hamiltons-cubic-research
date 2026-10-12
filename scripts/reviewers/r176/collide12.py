import json, collections
labels = json.load(open("labels.json"))
rho = [5,4,3,2,1,0]   # so(12), e-coordinates
def cas(lam):
    l = (lam+[0]*6)[:6]
    return sum(x*x + 2*x*r for x,r in zip(l,rho))
byc = collections.defaultdict(list)
for lam,m in labels: byc[cas(lam)].append((lam,m))
print("71 stable blocks at n=12; distinct quadratic Casimir values:", len(byc))
coll = {c:v for c,v in byc.items() if len(v)>1}
print("COLLISIONS:", len(coll), "values merging", sum(len(v) for v in coll.values()), "blocks")
for c in sorted(coll): print("  c=%-4d %s" % (c, coll[c]))
