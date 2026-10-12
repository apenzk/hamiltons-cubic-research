import json
from collections import Counter
here="scripts/reviewers/r177/"
dec=json.load(open(here+"decomp_B2.json"))
B={tuple(l):m for l,m,d in dec}; D={tuple(l):d for l,m,d in dec}
c2=lambda l: l[0]*(l[0]+3)+l[1]*(l[1]+1)
print("blocks",len(B),"sum m =",sum(B.values()),"unknowns",sum(m*(m+1)//2 for m in B.values()))
even=[l for l in B if l[1]%2==0]
print("lam2 even:",len(even),"dim sum",sum(D[l] for l in even))
surv={l:(B[l]-1 if l in even else B[l]) for l in B}
surv={l:m for l,m in surv.items() if m>0}
sh=Counter(surv.values())
print("surviving mult",sum(surv.values()),"unknowns",sum(m*(m+1)//2 for m in surv.values()),
      "shape 3x3=%d 2x2=%d 1x1=%d"%(sh[3],sh[2],sh[1]))
dead=sorted(l for l in even if B[l]==1)
print("die outright:",dead)
coll={}
for l in B: coll.setdefault(c2(l),[]).append(l)
for c,ls in sorted(coll.items()):
    if len(ls)>1:
        live=[l for l in ls if l not in dead]
        print("  c2=%d %s -> live %s"%(c,sorted(ls),sorted(live)))
