"""r275 claim 3(c): is the extrapolation of max F(n) to ~1.44 defensible, or could
the sequence approach sqrt3 = 1.7321?

Three families fitted to the same five points:
   (i)   geometric increments      a_inf = a_N + d_N r/(1-r)      (the plan's fit)
   (ii)  power law                 a_n = L - c n^{-p}             (L, c, p free)
   (iii) power law with L pinned at sqrt3, only c, p free
The question is whether the data can separate them.
"""
import numpy as np
from scipy.optimize import curve_fit




def report(a, tag):
    ns = 6.0 + 2.0 * np.arange(len(a))
    print(f"\n=== {tag}:  " + "  ".join(f"n={int(n)}:{v:.6f}" for n, v in zip(ns, a)))
    d = np.diff(a)
    print("    increments", np.array2string(d, precision=6),
          "  ratios", np.array2string(d[1:] / d[:-1], precision=4))
    r = float(np.mean(d[1:] / d[:-1]))
    print(f"    (i)   geometric, mean ratio r={r:.4f}  ->  limit "
          f"{a[-1] + d[-1]*r/(1-r):.6f}")
    f = lambda n, L, c, p: L - c * n ** (-p)
    try:
        po, _ = curve_fit(f, ns, a, p0=[1.44, 0.5, 2.0], maxfev=200000)
        res = np.sqrt(np.mean((f(ns, *po) - a) ** 2))
        print(f"    (ii)  free power law   L={po[0]:.6f}  c={po[1]:.4f}  p={po[2]:.4f}"
              f"   rms residual {res:.2e}")
    except Exception as e:
        print("    (ii)  failed", e)
    g = lambda n, c, p: np.sqrt(3.0) - c * n ** (-p)
    po2, _ = curve_fit(g, ns, a, p0=[0.35, 0.07], maxfev=200000)
    res2 = np.sqrt(np.mean((g(ns, *po2) - a) ** 2))
    print(f"    (iii) L pinned at sqrt3   c={po2[0]:.6f}  p={po2[1]:.6f}"
          f"   rms residual {res2:.2e}")
    print(f"          its predictions: " +
          "  ".join(f"n={int(n)}:{v:.6f}" for n, v in zip(ns, g(ns, *po2))))
    for N in (20, 50, 100, 1000):
        print(f"          fit (iii) at n={N:>4}: {g(float(N), *po2):.6f}", end="")
    print()


if __name__ == "__main__":
    import sys
    report(np.array([1.4128, 1.4205, 1.4257, 1.4294, 1.4320]), "the plan's own numbers (run_m_falsifier.py)")
    if len(sys.argv) > 1:
        report(np.array([float(x) for x in sys.argv[1:]]), "r275's independent optimiser")
