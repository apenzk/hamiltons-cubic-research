"""r275 claim 5: is the n=12 sign flip in Nienhaus Theorem 4.17 structural or technical?

Reconstructed from the proof text (references/nienhaus-2023-second-best-einstein,
L4698-L4790), with the only change being the cap c on f:

  f(phi) = cos^3 + 3 cos sin^2 alpha + sin^3 gamma,   alpha = sqrt(2/3)<Q(W),W_CP2>,
                                                     gamma = sqrt(2/3) P(W).
  Nienhaus bounds gamma by minimising  g_c(phi) = (c - cos^3 - 3 alpha cos sin^2)/sin^3
  over phi, where c is an a priori cap on f.  He takes c = 1, justified by
  "f <= 1 on [0,pi]" -- which says exactly that W_CP2 is the global maximiser.
  The closing estimate is  g1(alpha) = (3/4)(3 alpha - 1) + (sqrt3/4) gamma_max - alpha,
  required NEGATIVE for alpha < 1/3, and Theorem 4.14 delivers alpha <= 1/3 with the
  endpoint attained.
"""
import numpy as np
import sympy as sp

def kstar(alpha, c):
    """the minimiser cos(phi_0):  (1-alpha)k^2 - c k + alpha = 0, root in (0,1)."""
    A, B, C = 1 - alpha, -c, alpha
    disc = B * B - 4 * A * C
    if disc < 0:
        return None
    return (-B - np.sqrt(disc)) / (2 * A)

def gamma_max(alpha, c):
    k = kstar(alpha, c)
    if k is None or not (0 < k < 1):
        return np.nan
    return (c + k ** 3 * (3 * alpha - 1) - 3 * alpha * k) / (1 - k * k) ** 1.5

def g1(alpha, c):
    return 0.75 * (3 * alpha - 1) + (np.sqrt(3) / 4) * gamma_max(alpha, c) - alpha

def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n

print("== the stationarity equation, derived symbolically ==")
k, a, c = sp.symbols('k alpha c', positive=True)
g = (c + k ** 3 * (3 * a - 1) - 3 * a * k) / (1 - k ** 2) ** sp.Rational(3, 2)
stat = sp.simplify(sp.numer(sp.together(sp.diff(g, k))))
print("   d/dk numerator  =", sp.factor(sp.simplify(stat / (1 - k**2)**sp.Rational(1,2))),
      "   (paper: (1-alpha)k^2 - c k + alpha = 0)")

print("\n== gamma_max at c=1: closed form check against (1+alpha)sqrt(1-2alpha) ==")
for al in (0.05, 0.15, 0.25, 1 / 3):
    print(f"   alpha={al:.5f}   gamma_max(c=1)={gamma_max(al,1.0):.9f}"
          f"   (1+a)sqrt(1-2a)={(1+al)*np.sqrt(max(1-2*al,0)):.9f}"
          f"   sqrt(1-2a(1+a))={np.sqrt(max(1-2*al*(1+al),0)):.9f}")

print("\n== the closing estimate at the binding endpoint alpha = 1/3 ==")
print(f"   {'n':>4} {'theta_0(n)':>12} {'c=sqrt(2/3)theta_0':>20} {'gamma_max':>12} {'g1(1/3)':>12}  verdict")
for n in (10, 11, 11.2915026, 12, 14, 16, 20, 100):
    t0 = theta0(n)
    cc = max(1.0, np.sqrt(2 / 3) * t0)     # f <= 1 holds while W_CP2 is the maximiser
    print(f"   {n:>4} {t0:>12.9f} {np.sqrt(2/3)*t0:>20.9f} {gamma_max(1/3,cc):>12.9f}"
          f" {g1(1/3,cc):>+12.9f}  {'FAILS (needs <0)' if g1(1/3,cc)>=0 else 'ok'}")

print("\n   at c=1 exactly:  g1(1/3) =", g1(1 / 3, 1.0),
      "   and gamma_max(1/3,1) =", gamma_max(1 / 3, 1.0), " vs 4/(3 sqrt3) =", 4 / (3 * np.sqrt(3)))
print("   so the sign of the closing estimate at alpha=1/3 is EXACTLY sign(c-1),")
print("   and c > 1  <=>  sqrt(2/3) Theta > 1  <=>  Theta > sqrt(3/2) = P(W_CP2),")
print("   i.e. exactly the statement that W_CP2 has stopped being the global maximiser.")
print("   theta_0(n) = sqrt(3/2) at n = 6 + 2 sqrt7 =", 6 + 2 * np.sqrt(7),
      "-- the same crossover route M's link (c) uses.")

print("\n== how wide is the failure window in alpha? ==")
for n in (12, 14, 16, 20, 100):
    cc = np.sqrt(2 / 3) * theta0(n)
    al = np.linspace(0.0, 1 / 3, 20001)
    v = np.array([g1(x, cc) for x in al])
    bad = al[v >= 0]
    lo = bad.min() if bad.size else np.nan
    print(f"   n={n:>4}  c={cc:.9f}   g1>=0 on alpha in [{lo:.6f}, 0.333333]"
          f"   width {1/3-lo:.6f}   max g1 {v.max():+.6f}")
