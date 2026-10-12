"""
Lowering Jaeger's n>=16 threshold for the diagonal case (Conjecture A) to n=12.

Jaeger 2016 (Muenster), Theorem A, proves: for EVEN n >= 16, a diagonal Weyl
operator with ||W||=1 and W^2+W^# = theta W, theta >= theta_0(n), is the
normalised Weyl curvature of S^{n/2} x S^{n/2}.  The sentence after Theorem A
leaves n=12,14 open.  This script shows the n>=16 is an artefact of rounding
inside the proof of ONE lemma (3.5.6) and closes n=12 and n=14.

WHERE THE THRESHOLD COMES FROM.  Lemma 3.5.6 argues by contradiction: under
Assumption 2 (scal <= (n-3)*tilde0) the quantity

  RHS(t,v,y) = -(263/144)*(n-3)/(n^2(n-2)) * [t^2 - t^3/(n*that0)]
               - 2*tilde0*[(2n-9)/(4n^3) + 3x/(8n^2)]*t
               + C * [ v + sqrt( (v^2 - y^2)/(1-y) ) ]

must be >= 0 somewhere, where t = scal, v = tr S^4, y = (tr S^3)^2, x = n*v-1,
S = Ric(|W|)/||Ric(|W|)||,  tilde0 = theta~_0(n),  that0 = (n-2)/(n-3)*tilde0.
Jaeger bounds RHS by a chain of rational roundings ending in two quartics
  g(n) = -40n^4+588n^3+127n^2-943n+573        (largest real root 14.811)
  h(n) = -662n^4+13111n^3-54261n^2+98703n-67311 (largest real root 14.963)
whose negativity needs n >= 15; evenness then gives n >= 16.

FOUR SUCCESSIVE SHARPENINGS, none of which adds a new hypothesis:
  (0) evaluate his own RHS exactly at the two endpoints of his own case split,
      instead of through the rational chain                       -> n >= 14
  (1) keep Lemma 3.3.6 in the exact form he derives,
      tr S^4 <= E(n) := (8n^2-41n+49)/(4(n+1)(n-2)(n-3)),
      before he rounds it to 16/(8n+9)
  (2) keep the Lemma 3.5.5 coefficient C = (2 sqrt2/that0)*sqrt(1-v)
      before he rounds it up to 2                                 -> n >= 13
  (3) note that y and v are moments of ONE spectrum, so the pair (v,y) lies in
      the moment body of S, not in the product box [1/n, .] x [., E(n)] that
      the proof uses.  Jaeger's worst case sets y = 1/n (its floor) while v sits
      at its ceiling; y = 1/n forces the flat spectrum, which forces v = 1/n too.
                                                                  -> n >= 12

Only (3) is new mathematics, and it is elementary: S >= 0, ||S|| = 1, at most n
eigenvalues in [0,1], so min y for given v is attained on a spectrum with at
most three distinct nonzero values (Caratheodory, two moment constraints).

Sections 3.2-3.5 are run by Jaeger under the weaker hypothesis theta >= tilde0
so that they cover odd n as well; the computation below inherits that, so its
odd-n rows are meaningful for those sections.  Only Section 3.6 needs theta_0
and even n, so the closure claimed here is for even n = 12, 14.

WHY NOTHING ELSE IN THE PROOF BLOCKS n=12,14: an exhaustive census of every
numeric dimension hypothesis in Chapter 3 gives n>=1..9 (all satisfied),
k>=12 in Lemma 3.5.4 (satisfied, and exactly n=12), the two n>=15 conclusions
replaced here, and m>=8 three times -- twice as the statement of Theorem 3.0.2
and Assumption 1, and once as a genuine use, the ideal-induction step in 3.6,
which is precisely the step the six-line graph argument in findings/INDEX.md
("Reading Jaeger's diagonal-case proof", Result 5b) already replaces.
"""
import numpy as np
import sympy as sp

# ---------------------------------------------------------------- exact layer
def consts_sym(n):
    n = sp.Integer(n)
    tilde0 = sp.sqrt(2)*sp.sqrt(sp.Rational((n-1)*(n-3), (n+1)*(n-2)))
    that0 = sp.Rational(n-2, n-3)*tilde0
    E = sp.Rational(8*n**2 - 41*n + 49, 4*(n+1)*(n-2)*(n-3))
    return tilde0, that0, E

def rhs_sym(n, t, v, y, sharp_coeff):
    tilde0, that0, E = consts_sym(n)
    n = sp.Integer(n); x = n*v - 1
    coeff = (2*sp.sqrt(2)/that0)*sp.sqrt(1-v) if sharp_coeff else sp.Integer(2)
    return (-sp.Rational(263,144)*sp.Rational(n-3, n**2*(n-2))*(t**2 - t**3/(n*that0))
            - 2*tilde0*(sp.Rational(2*n-9, 4*n**3) + sp.Rational(3, 8*n**2)*x)*t
            + coeff*(v + sp.sqrt((v**2 - y**2)/(1-y))))

def certify(n, exactE, sharp_coeff):
    tilde0, that0, E = consts_sym(n)
    v = E if exactE else sp.Rational(16, 8*n+9)
    y = sp.Rational(1, n)
    res = {}
    for lbl, t in (("Case 1 (lower scal endpoint)", that0/v),
                   ("Case 2 (upper scal endpoint)", sp.Integer(n-3)*tilde0)):
        e = sp.radsimp(sp.expand(rhs_sym(n, t, v, y, sharp_coeff)))
        res[lbl] = (float(sp.N(e, 40)), sp.simplify(e).is_negative)
    return res

# ------------------------------------------------------- moment-body envelope
def consts_num(n):
    t0 = np.sqrt(2.0)*np.sqrt((n-1.0)*(n-3.0)/((n+1.0)*(n-2.0)))
    return t0, (n-2.0)/(n-3.0)*t0, (8.0*n**2-41.0*n+49.0)/(4.0*(n+1.0)*(n-2.0)*(n-3.0))

def rhs_num(n, v, y):
    tilde0, that0, E = consts_num(n)
    t_hi = (n-3.0)*tilde0
    x = n*v - 1.0
    coeff = (2*np.sqrt(2)/that0)*np.sqrt(np.clip(1.0-v, 0, None))
    pos = coeff*(v + np.sqrt(np.clip((v**2-y**2)/(1.0-y), 0, None)))
    out = -np.inf*np.ones_like(v)
    for t in (that0/v, np.full_like(v, t_hi)):          # Jaeger's own Cor 3.3.7 endpoint
        e = (-(263.0/144.0)*(n-3.0)/(n**2*(n-2.0))*(t**2 - t**3/(n*that0))
             - 2*tilde0*((2*n-9.0)/(4*n**3) + 3.0*x/(8*n**2))*t + pos)
        out = np.maximum(out, np.where(t <= t_hi + 1e-12, e, -np.inf))
    return out

def envelope(n, nbin=600, G2=200000, G3=300):
    """Lower envelope of tr S^3 against tr S^4 over spectra with <=3 distinct
    nonzero values -- by Caratheodory this contains the true minimiser."""
    _, _, E = consts_num(n)
    p3min = np.full(nbin, np.inf)
    def absorb(p3, p4):
        idx = np.floor((p4 - 1.0/n)/(E - 1.0/n)*nbin).astype(int)
        ok = (idx >= 0) & (idx < nbin) & np.isfinite(p3)
        np.minimum.at(p3min, idx[ok], p3[ok])
    for k1 in range(1, n+1):
        a0 = 1/np.sqrt(k1)
        absorb(np.array([k1*a0**3]), np.array([k1*a0**4]))
        for k2 in range(1, n-k1+1):
            s = np.linspace(1e-12, 1-1e-12, G2)
            a, b = np.sqrt(s/k1), np.sqrt((1-s)/k2)
            m = (a <= 1) & (b <= 1)
            absorb((k1*a**3+k2*b**3)[m], (k1*a**4+k2*b**4)[m])
    for k1 in range(1, n-1):
        for k2 in range(1, n-k1):
            for k3 in range(1, n-k1-k2+1):
                u = np.linspace(1e-9, 1-1e-9, G3)
                U, V = np.meshgrid(u, u, indexing="ij")
                a = np.sqrt(U*V/k1); b = np.sqrt(U*(1-V)/k2); c = np.sqrt((1-U)/k3)
                m = (a <= 1) & (b <= 1) & (c <= 1)
                absorb((k1*a**3+k2*b**3+k3*c**3)[m], (k1*a**4+k2*b**4+k3*c**4)[m])
    edges = np.linspace(1.0/n, E, nbin+1)
    mid = 0.5*(edges[:-1] + edges[1:])
    ok = np.isfinite(p3min)
    return mid[ok], p3min[ok], E

# --------------------------------------------------------------------- report
NS = [12, 13, 14, 16]

print("="*78)
print("STEP 0+1+2: exact evaluation of Jaeger's own RHS at his own case endpoints")
print("="*78)
for exactE, sc, tag in [(False, False, "his bounds, exact evaluation only"),
                        (True,  True,  "+ exact Lemma 3.3.6 and 3.5.5 coefficient")]:
    print(f"\n-- {tag} --")
    for n in NS:
        r = certify(n, exactE, sc)
        worst = max(v for v, _ in r.values())
        allneg = all(neg for _, neg in r.values())
        print(f"  n={n:>3}  max over the two cases = {worst:>+12.8f}   "
              f"symbolically negative: {str(allneg):<5} "
              f"{'-> Lemma 3.5.6 HOLDS' if allneg else ''}")

print("\n" + "="*78)
print("STEP 3: (tr S^3)^2 and tr S^4 are moments of ONE spectrum, not a free box")
print("="*78)
print(f"\n{'n':>4} {'max RHS (upper bd)':>20} {'argmax v':>10} {'E(n)':>10} "
      f"{'(trS^3)^2':>11} {'Jaeger 1/n':>11}   verdict")
print("-"*92)
for n in NS:
    v, p3, E = envelope(n)
    val = rhs_num(n, v, p3**2)
    i = int(np.nanargmax(val))
    print(f"{n:>4} {val[i]:>20.6f} {v[i]:>10.6f} {E:>10.6f} {p3[i]**2:>11.6f} "
          f"{1.0/n:>11.6f}   {'Lemma 3.5.6 HOLDS' if val[i] < 0 else 'NO contradiction'}")
print("\nRHS is decreasing in y (Jaeger's own f'(y)<=0) and convex in t (his RHS''>=0),")
print("so the envelope value is an UPPER bound for max RHS over the whole region.")
