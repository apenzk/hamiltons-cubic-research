"""r242, claim 2: a BASIS CHOICE is not a field operation, and its determinant is
a denominator A2 never names.

A2's four ingredients are all closed under +,-,*,/ , so field closure applies to
them.  Expressing a covariant in a SPANNING SET is not among them: the diagram
spanning set is linearly dependent (plan section 2 item 1 uses the completed
blocks' NULLITIES as its check), so the solve first picks a maximal independent
subset S and then inverts the Gram of S.  Every datum then carries det Gram_S(n)
in its denominator.  Picking S is a case distinction on whether a polynomial in n
vanishes, which no amount of field closure supplies.

This file exhibits det Gram_S(n) on the smallest honest instance in this problem:
the three-term decomposition of an algebraic curvature tensor,

    B  =  W  +  KN(E,g)/(n-2)  +  scal * KN(g,g)/(2n(n-1)),

whose spanning triple {B, KN(E,g), KN(g,g)} is exactly the shape of the solve
plan section 2 describes.  Every Gram entry is computed exactly at n = 4..20,
each is reconstructed as a polynomial in n from a subset of the dimensions and
CONFIRMED on the rest, and the determinant is then factored and its roots
located.  The point is where the roots may live: nothing in ingredients 1-4
constrains them, and A5's checklist as A2 writes it does not contain this
polynomial at all.
"""
from fractions import Fraction as F
import random, sympy as sp

rnd = random.Random(5); N0 = 4
R0 = [[[[F(rnd.randint(-2,2)) for _ in range(N0)] for _ in range(N0)]
       for _ in range(N0)] for _ in range(N0)]

def pieces(n):
    """B (padded, curvature-symmetric), KN(E,g), KN(g,g) at dimension n."""
    rg = range(n)
    R = [[[[F(0)]*n for _ in rg] for _ in rg] for _ in rg]
    for i in range(N0):
        for j in range(N0):
            for k in range(N0):
                for l in range(N0):
                    R[i][j][k][l] = R0[i][j][k][l]
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
    def KN(P,Q):
        return [[[[P[i][k]*Q[j][l]+P[j][l]*Q[i][k]-P[i][l]*Q[j][k]-P[j][k]*Q[i][l]
                   for l in rg] for k in rg] for j in rg] for i in rg]
    return [B, KN(E,g), KN(g,g)]

def dot(A, C, n):
    rg = range(n)
    return sum(A[i][j][k][l]*C[i][j][k][l]
               for i in rg for j in rg for k in rg for l in rg)

NS = list(range(4, 21))
GR = {}
for n in NS:
    P = pieces(n)
    GR[n] = [[dot(P[a], P[b], n) for b in range(3)] for a in range(3)]
    print(f"    n={n:3d}  Gram = {[[str(x) for x in r] for r in GR[n]]}", flush=True)

nv = sp.Symbol('n')

def reconstruct(a, b, dmax=6):
    """exact polynomial in n through the first dmax+1 dimensions; confirmed on
    every remaining one, or reported as not polynomial of that degree."""
    for d in range(dmax + 1):
        pts = NS[:d+1]
        expr = sp.Integer(0)
        for i, xi in enumerate(pts):
            t = sp.Rational(GR[xi][a][b])
            for j, xj in enumerate(pts):
                if i != j:
                    t *= (nv - xj) / sp.Integer(xi - xj)
            expr += t
        expr = sp.expand(expr)
        if all(sp.Rational(GR[x][a][b]) == expr.subs(nv, x) for x in NS):
            return sp.factor(expr), d
    return None, None

M = sp.zeros(3, 3)
print("\n  Gram entries as exact functions of n (fitted low, confirmed on the rest):")
for a in range(3):
    for b in range(a, 3):
        e, d = reconstruct(a, b)
        assert e is not None, f"entry ({a},{b}) is not polynomial of degree <= 6"
        print(f"    G[{a}][{b}] = {e}     (degree {d}, confirmed at all "
              f"{len(NS)} dimensions)")
        M[a, b] = e; M[b, a] = e

det = sp.factor(sp.expand(M.det()))
print(f"\n  det Gram_S(n) = {det}")
roots = sp.solve(sp.Eq(sp.expand(M.det()), 0), nv)
rr = sorted([sp.nsimplify(r) for r in roots if r.is_real], key=lambda r: float(r))
print(f"  real roots: {[str(r) + '  ~ ' + f'{float(r):.6f}' for r in rr]}")
big = [r for r in rr if float(r) >= 12]
print(f"  real roots in [12, infinity): {[f'{float(r):.6f}' for r in big]}")

print(f"""
  WHAT THIS SHOWS.  det Gram_S is a polynomial in n produced by nothing but a
  CHOICE -- which members of a dependent spanning set to solve against.  It is
  the denominator of every coordinate the solve returns, and it carries a factor
  869n - 2767 that is none of n, n-1, n-2 or a Casimir difference: it is built
  from the input tensor's own numbers, not from the machinery's coefficients.
  A2's ingredient list has no slot for it and A5's checklist, as A2 writes it,
  does not contain it.

  WHERE ITS ROOTS CAN BE.  det Gram_S is the determinant of a Gram of REAL
  tensors, so it is >= 0 wherever the covariants exist; Cauchy-Schwarz pins this
  instance's root below n = 4.  So the danger is not an arbitrary root -- it is a
  DIMENSION-DEPENDENT SYZYGY, a linear relation among the chosen covariants that
  holds at one n and fails at the next.  This problem is known to have them:
  plan.md item A1 records that the SO(n) invariant count drops 92 -> 89 between
  n = 12 and n = 13, and that "the degree-6 mechanism admits identities valid to
  n = 12 and violated at 13".  A1's stability theorem fixes the DIMENSION at 89
  on [12, infinity); it does not fix which 89 diagrams are independent there, and
  a subset chosen at n = 12 may degenerate at some larger n.

  THE OBLIGATION, STATED POSITIVELY.  Route A needs a uniformity lemma -- one
  independent subset S, one basis of each multiplicity space, valid at every
  n >= 12 at once -- or, equivalently, det Gram_S(n) added to A5's Sturm list as
  one more polynomial to certify root-free on [12, infinity).  Field closure
  supplies neither, because picking S is a case distinction on the vanishing of a
  polynomial rather than a field operation.""")