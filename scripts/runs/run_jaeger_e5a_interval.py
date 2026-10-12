"""
E5a: discharge the last numerical step in the n=12 diagonal-case closure by
INTERVAL ARITHMETIC, making Lemma 1 machine-checked end to end.

What remains after E5 is one-dimensional.  The certified supporting line
    phi(v) = (7/10) v + 8647/38000   <=   tr S^3            (E5, exact)
is fed into Jaeger's RHS, and we must show

    max_{v in [10/81, 709/4680]}  max_cases RHS(v, phi(v)^2)  <  0,

the lower limit being where the scal-interval [that0/v, (n-3)*tilde0] becomes
nonempty ((n-2)/(n-3)^2 = 10/81 at n=12); below it Assumption 2 is already
contradicted.  E5 checked eleven exact points plus numerical monotonicity.  Here
the whole interval is covered by validated enclosures instead: mpmath's interval
type evaluates RHS on subintervals, and the claim is discharged when the UPPER
end of every enclosure is negative.  Subdivision is adaptive, so the certificate
is a finite list of subintervals with a proven negative upper bound on each.
"""
from mpmath import iv, mp

iv.dps = 40
mp.dps = 40

N = 12
T0  = iv.sqrt(2) * iv.sqrt(iv.mpf(11*9) / iv.mpf(13*10))     # tilde theta_0(12)
TH0 = (iv.mpf(10)/9) * T0                                     # hat  theta_0(12)
T_HI = iv.mpf(N-3) * T0
A, C = iv.mpf(7)/10, iv.mpf(8647)/38000                       # the E5 certificate
VLO, VHI = iv.mpf(10)/81, iv.mpf(709)/4680

def rhs_enclosure(v):
    """Interval enclosure of max-over-cases RHS(v, phi(v)^2) for v an interval."""
    phi = A*v + C
    y = phi**2
    x = N*v - 1
    coeff = (2*iv.sqrt(2)/TH0) * iv.sqrt(1 - v)
    pos = coeff * (v + iv.sqrt((v**2 - y**2)/(1 - y)))
    out = None
    for t in (TH0/v, T_HI):
        e = (-(iv.mpf(263)/144)*(iv.mpf(N-3)/(N**2*(N-2)))*(t**2 - t**3/(N*TH0))
             - 2*T0*(iv.mpf(2*N-9)/(4*N**3) + (iv.mpf(3)/(8*N**2))*x)*t + pos)
        out = e if out is None else iv.mpf([min(out.a, e.a), max(out.b, e.b)])
    return out

def verify(lo, hi, depth=0, maxdepth=60):
    """Return (ok, nboxes, worst_upper) for the claim RHS < 0 on [lo, hi]."""
    box = iv.mpf([lo, hi])
    enc = rhs_enclosure(box)
    if enc.b < 0:
        return True, 1, enc.b
    if depth >= maxdepth:
        return False, 1, enc.b
    mid = (lo + hi) / 2
    ok1, n1, w1 = verify(lo, mid, depth+1, maxdepth)
    ok2, n2, w2 = verify(mid, hi, depth+1, maxdepth)
    return ok1 and ok2, n1 + n2, max(w1, w2)

print("E5a -- validated interval-arithmetic verification at n = 12")
print(f"  range: v in [{iv.mpf(10)/81}, {iv.mpf(709)/4680}]")
print(f"         = [{float(VLO.a):.10f}, {float(VHI.b):.10f}]")
print(f"  certificate: tr S^3 >= (7/10) v + 8647/38000   (exact, from E5)\n")

ok, nboxes, worst = verify(VLO.a, VHI.b)
print(f"  subintervals needed: {nboxes}")
print(f"  worst upper bound over all enclosures: {float(worst):+.8f}")
print(f"\n  VERDICT: {'PROVED -- RHS < 0 on the whole range' if ok else 'NOT proved'}")
if ok:
    print("  Lemma 3.5.6 holds at n = 12; with the exhaustive Chapter 3 dimension")
    print("  census, Jaeger's Theorem A extends to even n = 12 and n = 14.")
