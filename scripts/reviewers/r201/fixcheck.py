"""r201: the two-line check that separates every arithmetic sabotage the
Hermitian assert lets through.  Each variant reimplements gp/gpmul exactly as
the corresponding plant patches run_n5_assemble.py."""
from fractions import Fraction as F
P = 1000033
IMOD = next(x for x in range(2, P) if pow(x, 2, P) == P - 1)

def mkgp(kind):
    def gp(x):
        a, b = x
        ai = a.numerator * pow(a.denominator % P, P-2, P) % P
        bi = b.numerator * pow(b.denominator % P, P-2, P) % P
        if kind == "collapse": return ((ai + bi*IMOD) % P, 0)
        if kind == "swap":     return (bi, ai)
        return (ai, bi)
    return gp

def mkmul(kind):
    if kind == "split":  return lambda u, v: ((u[0]*v[0] + u[1]*v[1]) % P, (u[0]*v[1] + u[1]*v[0]) % P)
    if kind == "noncomm":return lambda u, v: ((u[0]*v[0] - u[1]*v[1]) % P, (u[0]*v[1] - u[1]*v[0]) % P)
    return lambda u, v: ((u[0]*v[0] - u[1]*v[1]) % P, (u[0]*v[1] + u[1]*v[0]) % P)

def cmul(x, y): return (x[0]*y[0] - x[1]*y[1], x[0]*y[1] + x[1]*y[0])

VAR = [("shipped", "ok", "ok"), ("S1 i^2 = +1", "ok", "split"),
       ("S4 collapse", "collapse", "ok"), ("S5 non-commutative", "ok", "noncomm"),
       ("S7 gp swaps re/im", "swap", "ok")]
SAMPLE = [((F(3),F(0)), (F(0),F(5))), ((F(2,3),F(0)), (F(7),F(0))),
          ((F(0),F(-4)), (F(0),F(9))), ((F(5,8),F(0)), (F(0),F(11,4)))]
print(f"{'variant':22s} {'i^2 = -1':10s} {'gp keeps i':12s} {'gp is a ring map':18s}")
for name, gk, mk in VAR:
    gp, mul = mkgp(gk), mkmul(mk)
    t1 = mul((0, 1), (0, 1)) == (P-1, 0)
    t3 = gp((F(1), F(0))) == (1, 0) and gp((F(0), F(1))) == (0, 1)
    t2 = all(mul(gp(x), gp(y)) == gp(cmul(x, y)) for x, y in SAMPLE)
    print(f"{name:22s} {str(t1):10s} {str(t3):12s} {str(t2):18s}  "
          f"{'PASSES ALL' if t1 and t2 and t3 else 'CAUGHT'}")
