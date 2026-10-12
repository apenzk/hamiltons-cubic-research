"""r242, claim 4 addendum: what denominator the trace-removal machinery ACTUALLY
produces, exhibited in closed form.

<W(n), W(n)> for W(n) = wp(padded raw tensor, n) is degree 1 in the two
coefficients 1/(n-2) and sc/(2n(n-1)) that A2's ingredient 3 names, so its
denominator divides n^2 (n-1)^2 (n-2)^2 and its numerator has degree <= 6.  That
is 13 unknowns; 15 exact sample dimensions over-determine it.  The reconstructed closed form comes out
(869n - 2767) / (24(n-2)): the 1/n and 1/(2n(n-1)) parts cancel and the
Weyl-decomposition coefficient 1/(n-2) survives alone.  That is the brief's
planted 1/(n-2) datum, produced by the machinery instead of by hand, and the
shipped screen's a - b/n misses every one of the fifteen held-out dimensions.
"""
from fractions import Fraction as F
import random, sympy as sp

def wp(R, n):
    rg = range(n)
    B = [[[[F(1,4)*(R[i][j][k][l]-R[j][i][k][l]-R[i][j][l][k]+R[j][i][l][k])
            for l in rg] for k in rg] for j in rg] for i in rg]
    B = [[[[F(1,2)*(B[i][j][k][l]+B[k][l][i][j]) for l in rg] for k in rg]
          for j in rg] for i in rg]
    B = [[[[B[i][j][k][l]-F(1,3)*(B[i][j][k][l]+B[i][k][l][j]+B[i][l][j][k])
            for l in rg] for k in rg] for j in rg] for i in rg]
    Ric = [[sum(B[i][k][j][k] for k in rg) for j in rg] for i in rg]
    sc = sum(Ric[i][i] for i in rg)
    E = [[Ric[i][j]-F(sc,n)*(i==j) for j in rg] for i in rg]
    g = [[F(1) if a==b else F(0) for b in rg] for a in rg]
    def KN(P,Q,i,j,k,l):
        return P[i][k]*Q[j][l]+P[j][l]*Q[i][k]-P[i][l]*Q[j][k]-P[j][k]*Q[i][l]
    W = [[[[B[i][j][k][l]-F(1,n-2)*KN(E,g,i,j,k,l)
            -F(sc,2*n*(n-1))*KN(g,g,i,j,k,l) for l in rg] for k in rg]
          for j in rg] for i in rg]
    return [[[[F(1,2)*(W[i][j][k][l]+W[k][l][i][j]) for l in rg] for k in rg]
             for j in rg] for i in rg]

rnd = random.Random(5); N0 = 4
R0 = [[[[F(rnd.randint(-2,2)) for _ in range(N0)] for _ in range(N0)]
       for _ in range(N0)] for _ in range(N0)]

def pad(n):
    out = [[[[F(0)]*n for _ in range(n)] for _ in range(n)] for _ in range(n)]
    for i in range(N0):
        for j in range(N0):
            for k in range(N0):
                for l in range(N0):
                    out[i][j][k][l] = R0[i][j][k][l]
    return out

NS = list(range(4, 21))
q = {}
for n in NS:
    W = wp(pad(n), n); rg = range(n)
    q[n] = sum(W[i][j][k][l]*W[i][j][k][l]
               for i in rg for j in rg for k in rg for l in rg)
    print(f"    n={n:3d}  <W,W> = {q[n]}", flush=True)

nv = sp.Symbol('n')
D = nv**2*(nv-1)**2*(nv-2)**2
cs = sp.symbols('c0:7')
P = sum(cs[k]*nv**k for k in range(7))
eqs = [sp.Eq(P.subs(nv, n), sp.Rational(q[n]) * sp.Integer(n**2*(n-1)**2*(n-2)**2))
       for n in NS[:9]]
sol = sp.solve(eqs, cs, dict=True)
assert sol, "no degree-6 numerator over n^2(n-1)^2(n-2)^2"
Pn = sp.simplify(P.subs(sol[0]))
f = sp.cancel(Pn / D)
print(f"\n  reconstructed  <W,W>(n) = {sp.factor(sp.numer(f))} / {sp.factor(sp.denom(f))}")
ok = all(sp.Rational(q[n]) == f.subs(nv, n) for n in NS)
print(f"  reproduces ALL {len(NS)} sampled dimensions (8 of them held out): {ok}")
assert ok
den = sp.factor(sp.denom(f))
print(f"\n  denominator factors: {den}")
print(f"  roots of the denominator: {sorted(sp.solve(sp.denom(f), nv))}")
# the point of contact with the shipped screen: fit a - b/n and watch it miss
b = (sp.Rational(q[5]) - sp.Rational(q[4])) / (sp.Rational(1,4) - sp.Rational(1,5))
a = sp.Rational(q[4]) + b*sp.Rational(1,4)
miss = [n for n in NS if n not in (4, 5) and sp.Rational(q[n]) != a - b/sp.Integer(n)]
print(f"\n  the shipped screen's own form a - b/n, fitted at n=4,5 (a={a}, b={b}),")
print(f"  misses this datum at n = {miss}")
assert len(miss) == len(NS) - 2

print("\n  A2 ingredient 3 in the flesh: the coefficient 1/(n-2) survives into the")
print("  answer -- the 1/n and 1/(2n(n-1)) parts cancel here, leaving a denominator")
print("  whose only root is 2.  This is exactly the planted 1/(n-2) datum the brief")
print("  asks for, produced by the machinery rather than by hand, and the shipped")
print("  screen never meets it: wp is evaluated at n = 4 and at no other dimension.")
