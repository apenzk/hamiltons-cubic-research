"""Claim 2b: 'the largest weight multiplicity inside any of the 24 blocks is
14, in V(6,3) and V(6,4)' -- that number prices the pairing metric.

Freudenthal's recursion for B_2, exact in Fractions.  Positive roots
e1-e2, e2, e1, e1+e2; rho = (3/2, 1/2); simple roots alpha1 = (1,-1),
alpha2 = (0,1).  Cross-checked against the Weyl dimension formula per block.
"""
from fractions import Fraction as F
from collections import Counter

POS = [(1, -1), (0, 1), (1, 0), (1, 1)]
RHO = (F(3, 2), F(1, 2))
def ip(a, b): return a[0]*b[0] + a[1]*b[1]
def add(a, b): return (a[0]+b[0], a[1]+b[1])
def dominant(mu):
    a, b = abs(mu[0]), abs(mu[1])
    return (max(a, b), min(a, b))
def dimB2(l): return (l[0]-l[1]+1)*(l[0]+l[1]+2)*(2*l[0]+3)*(2*l[1]+1)//6

def weight_mults(lam):
    lr = add(lam, RHO); n2 = ip(lr, lr)
    cand = []
    for i in range(0, 4*lam[0] + 4*lam[1] + 4):
        for j in range(0, 4*lam[0] + 4*lam[1] + 4):
            mu = (lam[0]-i, lam[1]+i-j)
            if mu[0] >= mu[1] >= 0: cand.append((i+j, mu))
    cand.sort()
    m = {}
    for h, mu in cand:
        if mu in m: continue
        if mu == lam: m[mu] = 1; continue
        s = F(0)
        for al in POS:
            k = 1
            while True:
                nu = add(mu, (k*al[0], k*al[1]))
                d = dominant(nu)
                if d not in m:
                    # nu is above lam in height and not a weight -> stop
                    if ip(add(nu, RHO), add(nu, RHO)) > n2: break
                    k += 1
                    if k > 4*(lam[0]+lam[1]+2): break
                    continue
                s += m[d] * ip(nu, al)
                k += 1
                if k > 4*(lam[0]+lam[1]+2): break
        mr = add(mu, RHO); den = n2 - ip(mr, mr)
        if den == 0: m[mu] = 0; continue
        val = 2*s/den
        assert val.denominator == 1, (lam, mu, val)
        m[mu] = int(val)
    # W-saturate: orbit of each dominant weight under signed permutations
    full = Counter()
    for mu, c in m.items():
        if c == 0: continue
        orb = set()
        for p in ((0, 1), (1, 0)):
            for s0 in (1, -1):
                for s1 in (1, -1):
                    v = (mu[p[0]], mu[p[1]])
                    orb.add((s0*v[0], s1*v[1]))
        for w in orb: full[w] = c
    return full

BLOCKS = [(4,2),(2,2),(3,2),(5,2),(4,3),(4,4),(4,1),(3,1),(4,0),(2,1),(3,0),(2,0),
          (0,0),(1,0),(3,3),(5,0),(5,1),(5,3),(6,0),(5,4),(6,2),(6,3),(6,4),(6,6)]
print(f"{'lambda':>8} {'dim':>5} {'sum m':>6} {'ok':>3} {'max mult':>9}")
best = []
for lam in BLOCKS:
    fm = weight_mults(lam)
    tot = sum(fm.values()); mx = max(fm.values())
    best.append((mx, lam))
    print(f"{str(lam):>8} {dimB2(lam):>5} {tot:>6} {'OK' if tot == dimB2(lam) else '!!':>3} {mx:>9}")
best.sort(reverse=True)
print(f"\nlargest weight multiplicity over the 24 blocks: {best[0][0]}")
print(f"attained in: {[l for m, l in best if m == best[0][0]]}")
print(f"top five: {best[:5]}")
