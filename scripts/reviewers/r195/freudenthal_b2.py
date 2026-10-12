"""Weight multiplicities of the B2 irreps that occur in Sym^3(W_5).

Coordinates are the orthogonal e-basis the pipeline already uses: the code's
ALPHA = [(1,-1),(0,1)] are the simple roots e1-e2 and e2, so a weight label
(a,b) in run_n5_highest_weight.py IS the e-basis vector a e1 + b e2.

Freudenthal:  (|l+rho|^2 - |mu+rho|^2) m(mu)
                 = 2 sum_{alpha>0} sum_{k>=1} m(mu + k alpha) <mu + k alpha, alpha>
"""
from fractions import Fraction as Fr

POS = [(1, -1), (0, 1), (1, 0), (1, 1)]          # e1-e2, e2, e1, e1+e2
RHO = (Fr(3, 2), Fr(1, 2))
def ip(x, y): return x[0]*y[0] + x[1]*y[1]
def add(x, y): return (x[0]+y[0], x[1]+y[1])

def dimB2(l):
    return (l[0]-l[1]+1)*(l[0]+l[1]+2)*(2*l[0]+3)*(2*l[1]+1)//6

def dominant(mu):
    return mu[0] >= mu[1] >= 0

def to_dominant(mu):
    a, b = abs(mu[0]), abs(mu[1])
    return (max(a, b), min(a, b))

def weights_of(lam):
    """all weights mu <= lam in the root lattice, inside the convex hull."""
    out = set()
    stack = [lam]
    seen = {lam}
    while stack:
        mu = stack.pop()
        out.add(mu)
        for a in POS:
            nu = (mu[0]-a[0], mu[1]-a[1])
            if nu in seen: continue
            # keep only what is <= lam and inside the Weyl-orbit hull
            d = to_dominant(nu)
            if d[0] > lam[0] or d[0]+d[1] > lam[0]+lam[1]: continue
            seen.add(nu); stack.append(nu)
    return out

def mults(lam):
    lr = add(lam, RHO)
    n2 = ip(lr, lr)
    W = weights_of(lam)
    # process in decreasing height so mu + k alpha is always known first
    order = sorted(W, key=lambda m: -(ip(m, (1, 1))*1000 + m[0]))
    order = sorted(W, key=lambda m: -( (lam[0]-m[0]) + (lam[1]-m[1]) ) )
    m = {}
    # height = number of simple-root steps down from lam, in the e-basis:
    # lam - mu = c1(1,-1) + c2(0,1) => c1 = lam0-mu0, c2 = (lam1-mu1)+c1
    def ht(mu):
        c1 = lam[0]-mu[0]; c2 = (lam[1]-mu[1]) + c1
        return c1 + c2
    order = sorted(W, key=ht)
    for mu in order:
        if mu == lam:
            m[mu] = 1; continue
        # Weyl symmetry: if the dominant conjugate is already known, reuse it
        d = to_dominant(mu)
        if d in m and d != mu:
            m[mu] = m[d]; continue
        s = 0
        for a in POS:
            k = 1
            while True:
                nu = (mu[0]+k*a[0], mu[1]+k*a[1])
                dn = to_dominant(nu)
                if dn not in m and nu not in m:
                    if ht(nu) < 0: break
                    # outside the diagram
                    if dn[0] > lam[0] or dn[0]+dn[1] > lam[0]+lam[1]: break
                    k += 1; continue
                mv = m.get(nu, m.get(dn, 0))
                if mv == 0 and k > 2*(lam[0]+lam[1]+2): break
                s += mv*ip(nu, a)
                k += 1
                if k > 4*(lam[0]+lam[1]+2): break
        mr = add(mu, RHO)
        den = n2 - ip(mr, mr)
        if den == 0:
            raise RuntimeError(f"zero denominator at {mu}")
        val = Fr(2*s, 1)/den
        assert val.denominator == 1 and val >= 0, (mu, val)
        m[mu] = int(val)
    return m

BLOCKS = [(4,2),(2,2),(3,2),(5,2),(4,3),(4,4),(4,1),(3,1),(4,0),(2,1),(3,0),(2,0),
          (0,0),(1,0),(3,3),(5,0),(5,1),(5,3),(6,0),(5,4),(6,2),(6,3),(6,4),(6,6)]

if __name__ == "__main__":
    worst = (0, None, None)
    for lam in sorted(BLOCKS):
        m = mults(lam)
        d = sum(m.values())
        ok = (d == dimB2(lam))
        mx = max(m.values()); at = max(m, key=lambda k: m[k])
        print(f"lambda={lam}  dim {dimB2(lam):4d}  sum of mults {d:4d}  match {ok}"
              f"   max weight mult {mx:3d} at {at}   #weights {len(m)}")
        if mx > worst[0]: worst = (mx, lam, at)
    print(f"\nWIDEST weight space over all 24 blocks: {worst[0]} in V{worst[1]} at weight {worst[2]}")
