import json, collections
labels = json.load(open("labels.json"))
def ell(lam, rho):
    l=(lam+[0]*len(rho))[:len(rho)]
    return [x+r for x,r in zip(l,rho)]
def report(name, labs, rho, degs):
    print("=== %s: %d blocks, rank %d, Z(U) generators in degrees %s ===" % (name,len(labs),len(rho),degs))
    for k in range(1,len(degs)+1):
        use=degs[:k]
        sig={}
        for lam,m in labs:
            L=ell(lam,rho)
            key=tuple(sum(x**d for x in L) for d in use)
            sig.setdefault(key,[]).append(lam)
        merged=sum(len(v) for v in sig.values() if len(v)>1)
        print("   Casimirs of degree %-18s -> %2d classes, %2d blocks still merged" % (str(use), len(sig), merged))
        if merged==0: break
    else:
        # add Pfaffian
        sig={}
        for lam,m in labs:
            L=ell(lam,rho)
            key=tuple(sum(x**d for x in L) for d in degs)+(1,)
            sig.setdefault(key,[]).append(lam)
    return
# n=5, so(5): rank 2, degrees 2,4
n5=[[2,2],[4,1],[5,0],[4,3],[5,4],[6,2]]
print("=== n=5 colliding pairs under (c2,c4) ===")
rho5=[1.5,0.5]
for lam in [[3,3],[4,1],[5,0],[4,3],[5,4],[6,2]]:
    L=ell(lam,rho5); print("  ",lam,"p2=",sum(x**2 for x in L),"p4=",sum(x**4 for x in L))
print()
rho12=[5,4,3,2,1,0]
report("n=12 (so(12), 71 stable O(12) blocks)", labels, rho12, [2,4,6,8,10])
# does the Pfaffian matter? check remaining merges after p2..p10
sig={}
for lam,m in labels:
    L=ell(lam,rho12); sig.setdefault(tuple(sum(x**d for x in L) for d in [2,4,6,8,10]),[]).append(lam)
print("\nafter p2..p10:", len(sig), "classes;", sum(len(v) for v in sig.values() if len(v)>1), "merged")
for k,v in sig.items():
    if len(v)>1: print("   still merged:", v)
