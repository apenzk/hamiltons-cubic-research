import json, collections
from itertools import combinations
labels=json.load(open("labels.json")); rho=[5,4,3,2,1,0]
def dimD6(lam):
    l=[x+r for x,r in zip((lam+[0]*6)[:6],rho)]
    num=1; den=1
    for i,j in combinations(range(6),2):
        num*= (l[i]-l[j])*(l[i]+l[j]); den*=(rho[i]-rho[j])*(rho[i]+rho[j])
    return num//den
byc=collections.defaultdict(list)
for lam,m in labels: byc[sum(x*x+2*x*r for x,r in zip((lam+[0]*6)[:6],rho))].append((lam,m,dimD6(lam)))
print("merged classes at n=12 with SO(12) dimensions (note: 6-row labels are O(12) blocks = two SO(12) halves)")
for c in sorted(byc):
    v=byc[c]
    if len(v)>1:
        dims=[x[2] for x in v]
        print("  c=%-4d n=%d  dims=%s  equal-dims: %s" % (c,len(v),dims,len(set(dims))<len(dims)))
allpairs=[(lam,dimD6(lam)) for lam,m in labels]
dd=collections.Counter(d for _,d in allpairs)
print("\nblocks sharing a dimension across all 71:", {k:v for k,v in dd.items() if v>1})
