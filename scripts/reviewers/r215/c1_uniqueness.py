"""r215: is (2,2,0,0,0,0) pinned by the dimension 1638, or does something else
share it?  At n=5 a dimension check could NOT separate [2,2] from [2,1], both 35,
and only the Casimir did.  The same trap at n=12 would be fatal."""
from itertools import product
from fractions import Fraction as F
R = 6
POS = []
for i in range(R):
    for j in range(i+1, R):
        a=[0]*R; a[i]=1; a[j]=-1; POS.append(tuple(a))
        b=[0]*R; b[i]=1; b[j]=1;  POS.append(tuple(b))
RHO = tuple(F(R-1-k) for k in range(R))
def ip(u,v): return sum(F(x)*F(y) for x,y in zip(u,v))
def wdim(l):
    n=d=F(1)
    for a in POS:
        n*=ip([x+y for x,y in zip(l,RHO)],a); d*=ip(RHO,a)
    return n/d
hits = []
B = 6
for l in product(range(0, B+1), repeat=R):
    if any(l[k] < l[k+1] for k in range(R-1)): continue
    for last in ({l[R-1], -l[R-1]} if l[R-1] else {0}):
        lam = l[:R-1] + (last,)
        if wdim(lam) == 1638: hits.append(lam)
print(f"dominant D_6 weights with entries in [-{B},{B}] and Weyl dimension 1638:")
for h in hits:
    print("  ", h, " casimir", ip(h, [x+2*y for x,y in zip(h,RHO)]))
print("count:", len(hits))
# and the Casimir of the Weyl module by the classical so(n) formula
n = 12; lam = (2,2,0,0,0,0)
c = sum(lam[i]*(lam[i] + n - 2*(i+1)) for i in range(R))
print(f"sum lambda_i(lambda_i + n - 2i) = {c}; <lam,lam+2rho> = "
      f"{ip(lam,[x+2*y for x,y in zip(lam,RHO)])}")
