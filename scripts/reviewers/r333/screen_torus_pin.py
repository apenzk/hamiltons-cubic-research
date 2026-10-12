"""SCREEN ONLY (r333). Confirms the hand computation at the maximal torus, n=6.

Types over values (h,m)=(4,-1), mults (3,12).  Hand result being screened:
the linear rows have a 1-dimensional nullspace
  (M_hhh, M_hhm, M_hmm, M_mmm ; theta) = (1, -3, 3, -1 ; 25/4),
the true point is (0,0,12,8 ; 5), and T>=0 pins t=0 because M_hhh and M_hhm
move in opposite directions along it.  So positivity, not the contraction
identity, is what returns theta = 5.
"""
from fractions import Fraction as F
h, m, mh, mm, n = F(4), F(-1), 3, 12, 6
T = [(h,h,h),(h,h,m),(h,m,m),(m,m,m)]
def nx(t,x): return sum(1 for v in t if v==x)
def rows(x,mx):
    out=[]
    for k in range(3):
        r=[]
        for t in T:
            c=nx(t,x)
            if c==0: r.append(F(0)); continue
            S=sum(t); rest=list(t); rest.remove(x); P=rest[0]*rest[1]
            r.append([F(c), F(c)*(S-x), 2*F(c)*P][k])
        r.append(F(-2)*x*mx if k==2 else F(0))
        out.append((r,[F(n-2)*mx, F(-2)*x*mx, F(-2)*x*x*mx][k]))
    return out
E = rows(h,mh)+rows(m,mm)
true=[F(0),F(0),F(12),F(8),F(5)]
null=[F(1),F(-3),F(3),F(-1),F(25,4)]
print("true point residuals:", [sum(a*b for a,b in zip(r,true))-c for r,c in E])
print("null direction residuals:", [sum(a*b for a,b in zip(r,null)) for r,c in E])
print("theta along the free direction: 5 + (25/4) t ; T>=0 needs t>=0 (M_hhh) and t<=0 (M_hhm) -> t=0")
