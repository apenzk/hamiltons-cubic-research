# r178: largest weight space of Sym^3(Weyl_5); c2 distinct-value count at n=5.
import itertools
B2 = WeylCharacterRing("B2")
V = B2(2,2)
assert V.degree()==35
wm = {tuple(Integer(c) for c in k.to_vector()): Integer(m) for k,m in V.weight_multiplicities().items()}
print("Weyl_5 distinct weights:", len(wm), "sum:", sum(wm.values()))
def adams(d): return {tuple(d*c for c in w): m for w,m in wm.items()}
def mul(A,B):
    C={}
    for wa,ma in A.items():
        for wb,mb in B.items():
            k=(wa[0]+wb[0], wa[1]+wb[1]); C[k]=C.get(k,0)+ma*mb
    return C
p1=wm; p2=adams(2); p3=adams(3)
A=mul(mul(p1,p1),p1); Bb=mul(p1,p2)
c={}
for w,m in A.items(): c[w]=c.get(w,0)+m
for w,m in Bb.items(): c[w]=c.get(w,0)+3*m
for w,m in p3.items(): c[w]=c.get(w,0)+2*m
c={w:m//6 for w,m in c.items() if m}
print("Sym^3 total dim:", sum(c.values()), "== 7770:", sum(c.values())==7770)
mx=max(c.values())
print("largest weight space:", mx, "attained at:", [w for w,m in c.items() if m==mx])
print("mult at (0,0):", c.get((0,0)))
# independent cross-check of the block table by Racah on B2
rho=(Integer(3)/2, Integer(1)/2)
Wel=[]
for p in itertools.permutations(range(2)):
    sp = 1 if p==(0,1) else -1
    for s in itertools.product([1,-1],repeat=2):
        Wel.append((tuple(s[i]*rho[p[i]] for i in range(2)), sp*(s[0]*s[1])))
res={}
for mu in sorted([w for w in c if w[0]>=w[1]>=0], key=lambda t:(-t[0],-t[1])):
    mr=(mu[0]+rho[0], mu[1]+rho[1])
    n=0
    for wr,sg in Wel:
        k=(mr[0]-wr[0], mr[1]-wr[1])
        if k[0] in ZZ and k[1] in ZZ:
            v=c.get((Integer(k[0]),Integer(k[1])))
            if v: n+=sg*v
    if n: res[mu]=n
print("Racah blocks:", len(res), "sum m =", sum(res.values()),
      "sum m*dim =", sum(m*B2(mu).degree() for mu,m in res.items()))
c2=lambda l: l[0]*(l[0]+3)+l[1]*(l[1]+1)
vals=sorted(c2(l) for l in res)
print("c2 values:", vals)
print("DISTINCT c2 values:", len(set(vals)), " (record says 22)")
