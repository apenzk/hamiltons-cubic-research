"""Claim 5: is dim^1.77, fitted to two abscissae spanning 1.28x and extrapolated 18.3x,
supportable as 'about 42 hours'?"""
from math import log, exp
d1, t1 = 27030, 578.6
d2, t2 = 34731, 901.0
t2b     = 894.1          # chirality partner, SAME dimension 34,731 -- a replicate, not a third abscissa
D       = 635220

span = d2/d1; reach = D/d2
p = log(t2/t1)/log(span)
print("measured span      : %.4fx  (%d -> %d)" % (span, d1, d2))
print("extrapolation reach: %.2fx  (%d -> %d)" % (reach, d2, D))
print("fitted exponent    : %.4f" % p)
print("prediction         : %.0f s = %.1f h" % (t2*reach**p, t2*reach**p/3600))
print("degrees of freedom in the fit: %d  (2 points, 2 parameters -> residual is identically zero)" % 0)
print("replicate spread at the single repeated size: %.2f%%  (%.1f vs %.1f)" % (100*abs(t2-t2b)/t2, t2, t2b))

print("\n-- sensitivity: perturb ONE of the two timings by eps and refit --")
print("%8s %10s %10s %12s" % ("eps", "t1'", "exponent", "hours"))
for eps in (-0.20, -0.10, -0.05, 0.0, 0.05, 0.10, 0.20):
    tt = t1*(1+eps)
    pp = log(t2/tt)/log(span)
    print("%7.0f%% %10.1f %10.3f %12.1f" % (100*eps, tt, pp, t2*reach**pp/3600))

print("\n-- what the answer is if the exponent is anything else --")
for q in (1.77, 2.0, 2.2, 2.5, 3.0):
    h = t2*reach**q/3600
    print("  exponent %.2f -> %10.1f h = %6.1f days" % (q, h, h/24))

print("\n-- statistical uncertainty from the replicate alone (sigma = %.4f in log) --" % (abs(log(t2/t2b))))
s = abs(log(t2/t2b))
dp = s*(2**0.5)/log(span)
print("  1-sigma on the exponent: %.4f ; on the prediction: x%.3f  -> %.1f h .. %.1f h"
      % (dp, reach**dp, t2*reach**(p-dp)/3600, t2*reach**(p+dp)/3600))
print("\n  So the STATISTICAL error is ~13%%.  The MODEL error is unbounded: two abscissae")
print("  cannot see curvature, and sparse-elimination cost curves upward with fill-in.")
