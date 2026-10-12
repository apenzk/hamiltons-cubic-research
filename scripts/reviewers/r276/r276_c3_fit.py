"""r276 Claim 3(c): does the measured max of F extrapolate to ~1.44, or could it reach sqrt(3)?"""
import numpy as np
from scipy.optimize import curve_fit, brentq

ns = np.array([6., 8., 10., 12., 14., 16.])
Fs = np.array([1.412822, 1.420489, 1.425703, 1.429351, 1.432024, 1.434059])   # r276, independent optimiser
print("increments and their ratios")
d = np.diff(Fs)
print("   d  =", np.round(d, 6))
print("   d_k/d_{k-1} =", np.round(d[1:]/d[:-1], 4))

print("\nAitken delta^2 (limit of a geometric tail), on consecutive triples")
for i in range(len(Fs)-2):
    a, b, c = Fs[i:i+3]
    print(f"   n={int(ns[i]):2d}..{int(ns[i+2]):2d}:  {a - (b-a)**2/(c-2*b+a):.6f}")

print("\nleast-squares fits  F(n) = Finf - A n^-q")
def m(n, Finf, A, q): return Finf - A*n**(-q)
p, _ = curve_fit(m, ns, Fs, p0=[1.44, 1., 2.], maxfev=200000)
print(f"   free q :  Finf={p[0]:.6f}  A={p[1]:.4f}  q={p[2]:.4f}   resid={np.abs(m(ns,*p)-Fs).max():.2e}")
for q in (1., 1.5, 2., 3.):
    def mq(n, Finf, A, q=q): return Finf - A*n**(-q)
    pq, _ = curve_fit(mq, ns, Fs, p0=[1.44, 1.], maxfev=200000)
    print(f"   q={q:<4}:  Finf={pq[0]:.6f}  A={pq[1]:.4f}   resid={np.abs(mq(ns,*pq)-Fs).max():.2e}")

print("\nwhat sqrt(3) would demand")
S3 = np.sqrt(3.)
for q in (0.5, 1., 2.):
    A = (S3 - Fs[-1]) * ns[-1]**q
    print(f"   with Finf=sqrt3 and exponent q={q}: A={A:.4f}, so F(6) would be "
          f"{S3 - A*6.0**(-q):.6f} against the measured {Fs[0]:.6f}")
def mfix(n, A, q): return S3 - A*n**(-q)
pf, _ = curve_fit(mfix, ns, Fs, p0=[1., 1.], maxfev=200000)
print(f"   best fit with Finf FIXED at sqrt3: A={pf[0]:.4f} q={pf[1]:.4f}, "
      f"max resid {np.abs(mfix(ns,*pf)-Fs).max():.2e}  (free-Finf resid {np.abs(m(ns,*p)-Fs).max():.2e})")
print(f"   ratio of residuals: {np.abs(mfix(ns,*pf)-Fs).max()/np.abs(m(ns,*p)-Fs).max():.1f}x worse")
