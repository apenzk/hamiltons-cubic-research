"""Does the coupling source survive at the configuration the Gram bound ADMITS?

The recorded attempt on I104's x -> kappa_i link was abandoned on the argument that at the chain's
failing point the ENTIRE kappa bound is 0.0066, below the 0.020 deficit, so driving kappa to zero
could not close it.  That point is N_i = 0.268, t = 0.196, which the Gram bound EXCLUDES.  This
screens the same comparison at the configuration that survives.

Gate 1: (a) reproduces the recorded 0.0066 at the excluded point before anything else, which is the
control that this kappa formula is the recorded one, (b) the surviving configuration's u is the one
the Gram bound pins, taken from the admission boundary rather than assumed, (c) the comparison is
asserted in both directions rather than printed.
"""
import numpy as np

TH, S3 = np.sqrt(1.5), np.sqrt(3.0)


def kappa_max(u, t):
    """the recorded lossy coupling bound, kappa_i <= (u_i/sqrt3)(t - u_i^2)"""
    return u / S3 * (t - u * u)


def u_lo(Ni, tau):
    return (TH - 2 * tau / Ni) / S3


print("=" * 80)
print("the kappa source, at the EXCLUDED point and at the SURVIVING one")
print("=" * 80)

# --- control: the excluded point, and the attempt's own 0.0066 ---
Ni_x, t_x, u_x = 0.268, 1 - 3 * 0.268, 0.41
k_x = kappa_max(u_x, t_x)
print(f"\nEXCLUDED  N_i={Ni_x}, t={t_x:.3f}, u={u_x}")
print(f"  entire kappa bound = {k_x:.6f}   against a deficit of 0.020")
assert abs(k_x - 0.0066) < 5e-4, f"the recorded 0.0066 does not reproduce: {k_x:.6f}"
assert k_x < 0.020, "at the excluded point kappa cannot close the deficit, which is the recorded claim"
print("  reproduces the record's 0.0066, and kappa < deficit there  (asserted)")

# --- the surviving configuration, with u pinned by the Gram bound ---
Ni_s, tau_s = 0.218, 0.5 * 0.218 ** 1.5
t_s = 1 - 3 * Ni_s
lo = u_lo(Ni_s, tau_s)
hi = min(np.sqrt(t_s), np.sqrt(5 * t_s / 9))
deficit = 0.014793
print(f"\nSURVIVES  N_i={Ni_s}, t={t_s:.3f}, tau={tau_s:.4f}")
print(f"  Gram-pinned u interval = [{lo:.6f}, {hi:.6f}], width {hi-lo:.6f}")
k_lo, k_hi = kappa_max(lo, t_s), kappa_max(hi, t_s)
print(f"  entire kappa bound over that interval = [{min(k_lo,k_hi):.6f}, {max(k_lo,k_hi):.6f}]")
print(f"  against a deficit of {deficit:.6f}")
ratio = min(k_lo, k_hi) / deficit
print(f"  smallest kappa is {ratio:.2f} times the deficit")

assert min(k_lo, k_hi) > deficit, \
    f"kappa {min(k_lo,k_hi):.6f} does not exceed the deficit {deficit:.6f}, the source is dead"
print("\n  kappa EXCEEDS the deficit at the surviving configuration  (asserted)")
print("  so the ordering FLIPS between the two configurations  (asserted)")

print("\n" + "=" * 80)
print("The attempt's killer argument was made at the point the Gram bound excludes.")
print("Where the chain actually fails, the coupling source is large enough to close it,")
print("so the x -> kappa_i link is live rather than spent. THIS CLOSES NOTHING by itself:")
print("it says the source has the magnitude, not that any of it is recoverable.")
print("=" * 80)

# ---- VALIDATION of r987's ceiling, rebuilt rather than adopted ----------------------
# r987 refutes the link as a closer: with every factor at its own extreme the gain ceiling
# is 0.0090 against a 0.0148 deficit.  A refutation retires a route, so it carries the
# heavier burden and is rebuilt here from the definitions rather than taken on its report.
print("\n" + "=" * 80)
print("VALIDATION of r987's gain ceiling, rebuilt from the definitions")
print("=" * 80)

u_max = 0.438432                       # the Gram bound's top, from the interval above
deficit = 0.014793

# |x| <= ||K||/sqrt3 on a pairing plane: with x+y+z=0, y^2+z^2 >= (y+z)^2/2 = x^2/2,
# so ||K||^2 = 2(x^2+y^2+z^2) >= 3x^2.
c_max = u_max / S3
print(f"\n  |c_a| <= u/sqrt3                        = {c_max:.7f}")
assert abs(c_max - 0.2531288) < 1e-6, "the projection-coefficient cap does not reproduce"

# the component/projection inversion r987 derived: x2+x3 = (9/10)(c2+c3) - (3/5)c1
sx_max = (9 / 10) * 2 * c_max + (3 / 5) * c_max
print(f"  |x2 + x3| <= (9/10)*2*|c| + (3/5)*|c|   = {sx_max:.7f}   (factor 2.4)")
assert abs(sx_max - 2.4 * c_max) < 1e-12, "the 2.4 does not come out of 9/10*2 + 3/5"

q_max = sx_max ** 2 / 18
print(f"  (x2+x3)^2 / 18                          = {q_max:.7f}")
assert q_max < 1 - u_max ** 2, "the channel norm must fit inside the r budget"

# max(mu - x) over unit q-hat, at (x,y,z) = (-1/2, 1/2, 0)
xh, yh, zh = -0.5, 0.5, 0.0
assert abs(2 * (xh ** 2 + yh ** 2 + zh ** 2) - 1) < 1e-12, "that witness is not unit"
mu_minus_x = max(xh, yh, zh) - xh
print(f"  max(mu - x) at (-1/2, 1/2, 0)           = {mu_minus_x:.7f}")
assert abs(mu_minus_x - 1.0) < 1e-12

gain = mu_minus_x * q_max * u_max
print(f"\n  gain ceiling = (mu-x) * (x2+x3)^2/18 * ||q||  = {gain:.7f}")
print(f"  deficit                                       = {deficit:.7f}")
print(f"  the ceiling reaches {100 * gain / deficit:.1f} percent of the deficit,"
      f" short by a factor {deficit / gain:.2f}")

assert abs(gain - 0.0089895) < 5e-6, f"r987's 0.0090 does not reproduce: {gain:.7f}"
assert gain < deficit, "if the gain exceeded the deficit the route would NOT be retired"
print("\n  r987's ceiling REPRODUCES, and it is below the deficit  (asserted)")
print("  every factor is at its own extreme, so the true joint maximum is SMALLER,")
print("  and the sign condition and the scope only reduce it further.")
print("\n  SO THE LINK IS REAL, USABLE IN THE RIGHT DIRECTION, AND TOO SMALL.")
