"""r207: MULT re-derived from scratch -- the 24 blocks of Sym^3(Weyl_5).

Weyl_5 = V_(2,2) for B_2.  Its weights come from the Weyl character formula
(alternant / Weyl denominator, in DOUBLED exponents so everything stays
integral); the weights of Sym^3 are then all multiset sums of three of them,
and the irreducibles are peeled off highest weight first.  Nothing is imported.
"""
from itertools import combinations_with_replacement, product

WEYL = []                                   # W(B_2): signed permutations
for sw in (0,1):
    for s1, s2 in product((1,-1), repeat=2):
        WEYL.append((sw, s1, s2, s1*s2*(-1 if sw else 1)))
def act(w, v):
    sw, s1, s2, _ = w
    a, b = (v[1], v[0]) if sw else (v[0], v[1])
    return (s1*a, s2*b)
RHO2 = (3,1)                                 # 2*rho, doubled exponents

def alternant(mu2):
    P = {}
    for w in WEYL:
        k = act(w, mu2); P[k] = P.get(k,0) + w[3]
    return {k:c for k,c in P.items() if c}

def divide(N, D):
    N = dict(N); Q = {}
    dl = max(D, key=lambda k:(k[0],k[1])); dc = D[dl]
    while N:
        nl = max(N, key=lambda k:(k[0],k[1]))
        k = (nl[0]-dl[0], nl[1]-dl[1])
        assert N[nl] % dc == 0
        c = N[nl]//dc; Q[k] = Q.get(k,0)+c
        for dk, dv in D.items():
            kk = (dk[0]+k[0], dk[1]+k[1]); N[kk] = N.get(kk,0) - c*dv
            if N[kk] == 0: del N[kk]
    return Q

DEN = alternant(RHO2)
def weights(l1, l2):
    """weight multiplicities of V_(l1,l2), keys in ORDINARY (undoubled) coords."""
    num = alternant((2*l1+RHO2[0], 2*l2+RHO2[1]))
    q = divide(num, DEN)
    out = {}
    for (a,b), c in q.items():
        assert a % 2 == 0 and b % 2 == 0
        out[(a//2, b//2)] = c
    return out

def dimV(a,b): return (a-b+1)*(a+b+2)*(2*a+3)*(2*b+1)//6
for l in ((0,0),(1,0),(1,1),(2,2),(2,0)):
    assert sum(weights(*l).values()) == dimV(*l), l
print("Weyl character formula reproduces dim V for (0,0),(1,0),(1,1),(2,2),(2,0)")

W5 = weights(2,2)
assert sum(W5.values()) == 35
wl = [w for w, m in W5.items() for _ in range(m)]
print(f"Weyl_5 = V_(2,2): {len(wl)} weights, highest {max(wl)}")

sym3 = {}
for t in combinations_with_replacement(range(35), 3):
    k = (wl[t[0]][0]+wl[t[1]][0]+wl[t[2]][0], wl[t[0]][1]+wl[t[1]][1]+wl[t[2]][1])
    sym3[k] = sym3.get(k,0)+1
print(f"dim Sym^3(Weyl_5) = {sum(sym3.values())}  (7770)")

MULT = {}
rem = dict(sym3)
while any(v for v in rem.values()):
    hw = max((k for k,v in rem.items() if v > 0), key=lambda k:(k[0]+k[1], k[0]))
    assert hw[0] >= hw[1] >= 0, hw
    m = rem[hw]; MULT[hw] = m
    for w, c in weights(*hw).items():
        rem[w] = rem.get(w,0) - m*c
    assert all(v >= 0 for v in rem.values()), "peeling went negative"
REC = {(0,0):1,(1,0):1,(2,0):2,(3,0):2,(2,1):2,(2,2):4,(4,0):2,(3,1):2,
       (3,3):1,(5,0):1,(3,2):3,(6,0):1,(4,1):2,(4,4):2,(4,2):4,(4,3):2,
       (5,1):1,(5,2):2,(5,4):1,(5,3):1,(6,6):1,(6,2):1,(6,3):1,(6,4):1}
print(f"blocks {len(MULT)}, copies {sum(MULT.values())}, "
      f"sum m*dim V = {sum(m*dimV(*l) for l,m in MULT.items())}")
print(f"agrees with the file's MULT: {MULT == REC}")
if MULT != REC:
    for l in sorted(set(MULT)|set(REC)):
        if MULT.get(l) != REC.get(l): print(f"   {l}: mine {MULT.get(l)} vs file {REC.get(l)}")

EVEN = {l:m for l,m in MULT.items() if l[1] % 2 == 0}
ODD  = {l:m for l,m in MULT.items() if l[1] % 2 == 1}
FORMS = sum(m*(m+1)//2 for m in MULT.values())
ONK = sum((m-1)*m//2 for m in EVEN.values()) + sum(m*(m+1)//2 for m in ODD.values())
ANN = sum(EVEN.values())
print(f"\nblocks even/odd: {len(EVEN)}/{len(ODD)}")
print(f"invariant symmetric forms  {FORMS}")
print(f"  supported on K           {ONK}")
print(f"  vanishing on K x K       {ANN}")
print(f"  ONK + ANN = FORMS        {ONK+ANN == FORMS}")
print(f"sum of dim V over lambda_2-even blocks = "
      f"{sum(dimV(*l) for l in EVEN)}   (dim C measured 3570)")
