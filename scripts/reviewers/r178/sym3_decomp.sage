# r178 independent recomputation, from the definition Weyl_5 = V_{(2,2)} of so(5)=B2.
B2 = WeylCharacterRing("B2", style="coroots")
V = B2(0,4)   # coroot label (0,4) == partition (2,2)
assert V.degree() == 35
def c2(l): return l[0]*(l[0]+3) + l[1]*(l[1]+1)
def c4(l):
    e1,e2 = l[0]+Integer(3)/2, l[1]+Integer(1)/2
    return e1^4 + e2^4
S3 = V.symmetric_power(3)
raw = list(S3.monomial_coefficients().items())
blocks = sorted([((Integer(k[0]),Integer(k[1])), m, B2(k).degree()) for k,m in raw],
                key=lambda t: (-t[0][0], -t[0][1]))
tot=0; totmult=0; unk=0
print("lam      mult  dim    c2   lam2even")
for lam,m,dim in blocks:
    tot += m*dim; totmult += m; unk += m*(m+1)//2
    print("%-8s %d    %-5d %-4s %s" % (str(lam), m, dim, c2(lam), lam[1]%2==0))
print("blocks=%d  sum m*dim=%d (Sym^3 dim %d)  sum m=%d  unknowns=%d"
      % (len(blocks), tot, binomial(37,3), totmult, unk))
m1 = [(l,dim) for l,m,dim in blocks if m==1]
print("mult-1 blocks (%d): %s  dimsum=%d" % (len(m1), sorted([l for l,_ in m1]), sum(x for _,x in m1)))
ev = [(l,m,dim) for l,m,dim in blocks if l[1]%2==0]
print("even blocks: %d, dim sum = %d" % (len(ev), sum(dim for _,_,dim in ev)))
surv = {l:(m-1 if l[1]%2==0 else m) for l,m,dim in blocks}
surv = {l:m for l,m in surv.items() if m>0}
from collections import Counter
print("surviving shape (size,count):", sorted(Counter(surv.values()).items(), reverse=True))
print("surviving total mult =", sum(surv.values()), " unknowns =", sum(m*(m+1)//2 for m in surv.values()))
print("mult-1 blocks that DIE (lam2 even):", sorted([l for l,m,_ in blocks if m==1 and l[1]%2==0]))
c2map = {}
for l,_,_ in blocks: c2map.setdefault(c2(l),[]).append(l)
print("distinct c2:", len(c2map), " collisions:", {k:v for k,v in c2map.items() if len(v)>1})
print("distinct (c2,c4):", len(set((c2(l),c4(l)) for l,_,_ in blocks)))
print("--- dim Sym^d(Weyl_5)^{SO(5)}, d=2..6 ---")
for dd in range(2,7):
    md = V.symmetric_power(dd).monomial_coefficients()
    triv = sum(m for k,m in md.items() if (Integer(k[0]),Integer(k[1]))==(0,0))
    print(dd, triv, " sumcheck:", sum(m*B2(k).degree() for k,m in md.items()), "==", binomial(34+dd,dd))
