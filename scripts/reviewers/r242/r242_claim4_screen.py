"""r242, claim 4: the A2 screen exercises 1/n only, and a 1/(n-2) datum breaks it.

Three things are established here, all in exact arithmetic.

(A) THE HOLDOUT IS FORCED, NOT TESTED.  For the padded tensor of
    run_a2_rational_data.py, <S,S> and tr S are literally n-independent -- printed
    below at n = 4..12, identical at every n.  So <S~,S~> = <S,S> - (tr S)^2/n is
    a - b/n by one line of algebra, with a = <S,S> and b = (tr S)^2 fixed before
    any dimension is chosen.  The three "held out" dimensions confirm exact
    Fraction arithmetic; they carry no information about the certificate
    machinery's n-dependence.  Stronger still: the fit point n = 4 is the
    accidental dimension-4 identity W_iabc W_jabc = (|W|^2/4) delta_ij, so
    <S~,S~> vanishes there and b = 4a is forced -- one of the two fit points is a
    special value of the very identity being fitted.

(B) THE PLANT THE BRIEF ASKS FOR.  A datum with denominator n-2 -- the exact
    coefficient the Weyl decomposition divides by -- is fitted by a - b/n through
    n = 4,5 and through the A4 sample pair n = 12,14, and must MISS the holdout.

(C) THE MECHANISM PLANT.  Run the Weyl projector wp AT dimension n on a padded
    RAW tensor, so trace removal actually executes at dimension n instead of once
    at n = 4.  The resulting <S~,S~> is a genuine rational function of n whose
    denominator carries n-1 and n-2, and the two-parameter screen fails it.
    run_a2_rational_data.py never runs wp at any n but 4, so the n-1 and n-2
    thirds of its own derivation are never exercised.
"""
from fractions import Fraction as F
import random, sys, os

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                "..", "..", "runs"))

# ---- verbatim copy of wp from run_a2_rational_data.py (file under review, not edited) ----
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

rnd = random.Random(5)
N0 = 4
R0 = [[[[F(rnd.randint(-2,2)) for _ in range(N0)] for _ in range(N0)]
       for _ in range(N0)] for _ in range(N0)]
W0 = wp(R0, N0)

def pad4(T, n):
    out = [[[[F(0)]*n for _ in range(n)] for _ in range(n)] for _ in range(n)]
    for i in range(N0):
        for j in range(N0):
            for k in range(N0):
                for l in range(N0):
                    out[i][j][k][l] = T[i][j][k][l]
    return out

def S_of(W, n):
    rg = range(n)
    return [[sum(W[i][a][b][c]*W[j][a][b][c] for a in rg for b in rg for c in rg)
             for j in rg] for i in rg]

def parts(W, n):
    S = S_of(W, n); rg = range(n)
    ss = sum(S[i][j]*S[i][j] for i in rg for j in rg)
    tr = sum(S[i][i] for i in rg)
    return ss, tr, ss - tr*tr/F(n)

def fit_ab_over_n(p, q, v):
    """a - b/n through two dimensions p,q."""
    b = (v[q] - v[p]) / (F(1,p) - F(1,q))
    a = v[p] + b*F(1,p)
    return a, b

print("=" * 74)
print("(A)  THE PADDED SCREEN'S INPUTS ARE n-INDEPENDENT BY CONSTRUCTION")
print("=" * 74)
NS = list(range(4, 13))
pad_parts = {n: parts(pad4(W0, n), n) for n in NS}
print("      n      <S,S>            tr S        <S~,S~>")
for n in NS:
    ss, tr, st = pad_parts[n]
    print(f"    {n:3d}   {str(ss):16s} {str(tr):12s} {st}")
ss0, tr0, _ = pad_parts[4]
const = all(pad_parts[n][0] == ss0 and pad_parts[n][1] == tr0 for n in NS)
print(f"\n  <S,S> and tr S constant across n = 4..12: {const}")
assert const
padv = {n: pad_parts[n][2] for n in NS}
a, b = fit_ab_over_n(4, 5, padv)
print(f"  so <S~,S~> = {ss0} - ({tr0})^2/n identically; the fit recovers "
      f"a={a}, b={b}")
print(f"  b == 4a (forced by the dim-4 identity S = (|W|^2/4)g, <S~,S~>(4)=0): "
      f"{b == 4*a}")
print(f"  every dimension 4..12 predicted by the 2-point fit: "
      f"{all(padv[n] == a - b/F(n) for n in NS)}")
print("  VERDICT: the holdout is an identity, not a test.  It exercises 1/n and")
print("  nothing else: wp is called once, at n = 4, so the 1/(n-2) and 1/(2n(n-1))")
print("  coefficients inside it are evaluated at n = 4 and never at any other n.")

print()
print("=" * 74)
print("(B)  PLANTED DATUM WITH DENOMINATOR n-2 -- the screen must MISS it")
print("=" * 74)
A, Bp = F(709, 48), F(502681, 2304)      # same scale as the real datum
plant2 = {n: A - Bp/F(n-2) for n in NS}
for p, q in [(4, 5), (5, 6), (12, 14)]:
    if p not in plant2 or q not in plant2:
        plant2[p] = A - Bp/F(p-2); plant2[q] = A - Bp/F(q-2)
    fa, fb = fit_ab_over_n(p, q, plant2)
    hold = [n for n in NS if n not in (p, q)]
    miss = [n for n in hold if plant2[n] != fa - fb/F(n)]
    print(f"    fit a-b/n at n={p},{q}: a={fa}, b={fb}")
    print(f"      misses at n = {miss}   (holdout {hold})")
    assert len(miss) == len(hold), "a 1/(n-2) datum slipped through the a-b/n screen"
print("  a - b/n fitted at ANY two points misses EVERY held-out point of a")
print("  1/(n-2) datum.  The screen therefore has teeth -- but it was never")
print("  pointed at one, so two thirds of A2's denominator claim is untested.")

print()
print("=" * 74)
print("(C)  MECHANISM PLANT: run wp AT dimension n, so trace removal executes there")
print("=" * 74)
raw = {n: pad4(R0, n) for n in NS}
mech = {}
for n in NS:
    Wn = wp(raw[n], n)
    ss, tr, st = parts(Wn, n)
    mech[n] = st
    print(f"    n={n:3d}  <S~,S~> = {st}")
ma, mb = fit_ab_over_n(4, 5, mech)
mmiss = [n for n in NS if n not in (4, 5) and mech[n] != ma - mb/F(n)]
print(f"\n  a-b/n fitted at n=4,5 misses at n = {mmiss}")
assert mmiss, "the mechanism plant is 1/n after all"
ma2, mb2 = fit_ab_over_n(12, 14, {**mech, 14: parts(wp(pad4(R0, 14), 14), 14)[2]})
print(f"  a-b/n fitted at the A4 sample pair n=12,14 misses at n = "
      f"{[n for n in NS if n not in (12,14) and mech[n] != ma2 - mb2/F(n)]}")

# identify the denominator: clear n^k (n-1)^a (n-2)^b and test polynomiality
def is_poly(vals, ns, deg):
    """exact Lagrange fit of degree deg through the first deg+1 points, then
    check it reproduces the rest."""
    pts = ns[:deg+1]
    def L(x):
        tot = F(0)
        for i, xi in enumerate(pts):
            t = vals[xi]
            for j, xj in enumerate(pts):
                if i != j:
                    t *= F(x - xj, xi - xj)
            tot += t
        return tot
    return all(L(x) == vals[x] for x in ns)

print("\n  clearing denominators D(n) and testing whether n -> D(n)*<S~,S~> is a")
print("  polynomial (exact Lagrange through the low points, checked on the rest):")
cands = [("n", lambda n: F(n)),
         ("n^2", lambda n: F(n)**2),
         ("n*(n-2)", lambda n: F(n*(n-2))),
         ("n*(n-1)*(n-2)", lambda n: F(n*(n-1)*(n-2))),
         ("n^2*(n-1)^2*(n-2)^2", lambda n: F(n**2*(n-1)**2*(n-2)**2))]
NM = [n for n in NS if n >= 5]          # n=4 is the degenerate identity point
for name, D in cands:
    cleared = {n: mech[n]*D(n) for n in NM}
    dmax = len(NM) - 3
    found = next((d for d in range(0, dmax+1) if is_poly(cleared, NM, d)), None)
    print(f"    D = {name:22s} -> polynomial of degree {found}"
          if found is not None else
          f"    D = {name:22s} -> NOT a polynomial of degree <= {dmax}")
print("\n  CONCLUSION.  The machinery's real n-dependence is not a - b/n.  The")
print("  screen as shipped can only ever see the 1/n third of its own claim.")
