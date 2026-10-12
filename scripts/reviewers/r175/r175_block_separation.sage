# r175: the 24-block table at n=5, its Casimir eigenvalues, and what separates them.
R = WeylCharacterRing("B2", style="coroots")
E = WeylCharacterRing("B2")          # e-coordinate labels
W = E(2,2)
print("dim Weyl_5 =", W.degree())
S3 = W.symmetric_power(3)
blocks = sorted([((Integer(m[0]), Integer(m[1])), c, E(m).degree()) for m, c in S3], key=lambda t: -t[2])
print("dim Sym^3 =", sum(c*d for _,c,d in blocks), " blocks:", len(blocks),
      " sum mult:", sum(c for _,c,_ in blocks),
      " unknowns:", sum(c*(c+1)//2 for _,c,_ in blocks))

def c2(a,b): return a*a+3*a+b*b+b                       # <lam, lam+2rho>, <e_i,e_j>=delta
def p4(a,b): return (2*a+3)**4 + (2*b+1)**4             # W-invariant of degree 4 at 2(lam+rho)
def p2(a,b): return (2*a+3)**2 + (2*b+1)**2

tab = [((a,b), m, d, c2(a,b)) for (a,b),m,d in blocks]
print("eigenvalues sorted:", sorted(t[3] for t in tab))
print("distinct:", len(set(t[3] for t in tab)))
from collections import defaultdict
coll = defaultdict(list)
for lab,m,d,c in tab: coll[c].append((lab,m,d))
print("collisions:")
for c,v in sorted(coll.items()):
    if len(v) > 1:
        print("  c =", c, v, " fused eigenspace dim =", sum(m*d for _,m,d in v),
              " p4 values =", [p4(*lab) for lab,_,_ in v],
              " dims differ =", len(set(d for _,_,d in v))==len(v))
print("p2 = 4c+10 identity holds:", all(p2(a,b)==4*c2(a,b)+10 for (a,b),_,_,_ in tab))
# is (c2,p4) a complete separator over the 24 blocks?
sig = set((c2(*lab), p4(*lab)) for lab,_,_,_ in tab)
print("(c2,p4) distinct over 24 blocks:", len(sig))
