"""r242, claim 5: A2 proves MEMBERSHIP in Q(n) and supplies no DEGREE BOUND, and
A4's four-point fit is not determined without one.

Two separate questions hide behind "is the deferral to A5 sound?".

  Q1 -- does A4 need the denominators nonzero AT ITS SAMPLE POINTS n=12,14,16,18?
        Yes, trivially: a datum whose denominator vanishes at a sample point does
        not exist there and the solve returns nothing.  But this is already
        discharged WITHOUT A5, for the denominators A2 names: n, n-1, n-2 are
        nonzero at every n >= 12, and A2's own text says the Casimir differences
        are nonzero at every INTEGER n >= 12 by the separation theorem.  Integer
        nonvanishing is exactly what the sample points need; the REAL-interval
        statement is what only A5 supplies, and only the CONCLUSION needs it.
        So the deferral is sound for the fit.

  Q2 -- is membership in Q(n) enough to make the fit a finite problem?
        No.  A rational function p/q with deg p = d1, deg q = d2 has d1+d2+1 free
        parameters, so it is determined only by at least that many samples.  A2
        bounds NOTHING: the monomial theorem gives numerator degree <= 6 for a
        DIAGRAM pairing, but the certificate entries are block projections of
        those, carrying n, n-1, n-2, the Casimir differences and (r242 claim 2)
        the basis-choice determinant in their denominators.  Four samples are
        enough for d1+d2 <= 3 and for nothing beyond.

This file makes Q2 concrete: two rational functions of small degree, agreeing
EXACTLY at n = 12, 14, 16, 18, differing everywhere else.  Both are legal members
of Q(n) under A2's derivation; only a degree bound could tell them apart, and A2
proves no degree bound.
"""
import sympy as sp

n = sp.Symbol('n')
SAMPLES = [12, 14, 16, 18]

# f: the kind of entry A2's ingredients predict -- a small numerator over the
# trace-removal denominators.
f = (3*n + 5) / (n*(n-2))

# the Wilkinson-style ambiguity: any multiple of prod (n - n_k) over any
# denominator vanishing nowhere on the samples leaves the sampled values alone.
W = sp.prod([n - k for k in SAMPLES])
g = sp.together(f + W / (n*(n-2)*(n-1)*(n-3)))

print("  f(n) =", sp.simplify(f))
print("  g(n) =", sp.cancel(g))
print()
print("      n      f(n)              g(n)            equal")
for k in SAMPLES + [20, 22, 24, 13]:
    fv, gv = sp.Rational(f.subs(n, k)), sp.Rational(sp.cancel(g).subs(n, k))
    tag = "  <- A4 sample" if k in SAMPLES else ""
    print(f"    {k:3d}   {str(fv):16s}  {str(gv):16s}  {fv == gv}{tag}")

agree = all(sp.Rational(f.subs(n, k)) == sp.Rational(sp.cancel(g).subs(n, k))
            for k in SAMPLES)
differ = [k for k in (20, 22, 24, 13) if
          sp.Rational(f.subs(n, k)) != sp.Rational(sp.cancel(g).subs(n, k))]
print(f"\n  agree at all four A4 sample points: {agree}")
print(f"  differ at n = {differ}")
assert agree and differ

num, den = sp.fraction(sp.cancel(g))
print(f"\n  g has numerator degree {sp.degree(num, n)} and denominator degree "
      f"{sp.degree(den, n)} -- {sp.degree(num,n)+sp.degree(den,n)+1} parameters, "
      f"against 4 samples.")

print("""
  READ.  Both f and g are in Q(n), both are consistent with every word of A2's
  derivation, and A4's four sample dimensions cannot separate them.  Membership
  in a field is not finiteness: the fit becomes a finite problem only once the
  numerator and denominator degrees are BOUNDED, and A2 bounds neither.

  WHAT SAVES A4 ANYWAY, AND WHAT IT COSTS.  A4's second half -- verify
  mu_n(B(n)) = G_{mu,n} as an identity in n in the Brauer ring -- is a check, not
  a fit, so a wrong guess is REJECTED rather than believed.  The four-point fit
  is therefore a heuristic proposal followed by a proof, which is sound.  What it
  is not is a determination: with no degree bound there is no bound on how many
  proposals must be tried, and no guarantee that four samples ever produce the
  right one.  Deriving the degree bound is A2's natural next obligation -- the
  monomial theorem already caps the diagram numerators at n^6, and the
  denominators are explicit once claim 2's missing ingredients are added to the
  list.

  ONE PLACE A2 IS STRICTER THAN IT NEEDS TO BE.  A2 requires every denominator
  ROOT-FREE on the real interval [12, infinity).  The theorem being proved is
  about even integers n >= 12, and Sturm isolates real roots as well as counting
  them, so a denominator with a root at, say, 13.7 does not sink A5: it splits
  [12, infinity) at the isolated roots and the sign check runs on each piece.
  The obligation is SIGN-CONSTANCY on the subintervals carrying the even
  integers, which is weaker than root-freeness and decidable by the same
  machinery.""")
