# Falsifier screen for G(2) at fixed total norm on the common-eigenvector stratum, in batch 12's remaining regime:
# d_A, d_C, c~ > 0 with c~ large, so flipping v2 is costly. Variables (u2, p, v2, r, phi, chi) with
# T = 2.25 u2^2 + 3 p^2 + 0.75 v2^2 + r^2. General max over phases vs max with phases in {0, pi} (all diagonal pairs).
import numpy as np
from scipy.optimize import minimize
rng = np.random.default_rng(61)
alpha, beta = 15 / 4, 9 / 4
def value(z, fld, T, phases=None):
    u2, p, v2, r = z[:4]
    s = np.sqrt(T / (2.25 * u2 ** 2 + 3 * p ** 2 + 0.75 * v2 ** 2 + r ** 2 + 1e-300))
    u2, p, v2, r = u2 * s, abs(p) * s, v2 * s, abs(r) * s
    A1, A2, A3, C1, C2, C3 = fld
    dA, dC = (A1 - A3) / 2, (C1 - C3) / 2
    t1, t2 = (z[4], z[5]) if phases is None else phases
    S = alpha * (0.75 * u2 ** 3 - 3 * u2 * p ** 2) + beta * u2 * (0.75 * v2 ** 2 - r ** 2) + (A2 - (A1 + A3) / 2) * u2 + (C2 - (C1 + C3) / 2) * v2
    g = -2 * beta * p * v2 * r * np.cos(t1 - t2) + 2 * p * dA * np.cos(t1) + 2 * r * dC * np.cos(t2)
    return S + g
def best(fld, T, restarts=40):
    gen = -1e9; dia = -1e9
    for k in range(restarts):
        z0 = rng.normal(size=6)
        r = minimize(lambda z: -value(z, fld, T), z0, method='Nelder-Mead', options={'maxiter': 4000, 'xatol': 1e-9, 'fatol': 1e-12})
        gen = max(gen, -r.fun)
        for ph in [(0, 0), (0, np.pi), (np.pi, 0), (np.pi, np.pi)]:
            rr = minimize(lambda z: -value(z, fld, T, ph), z0[:4], method='Nelder-Mead', options={'maxiter': 4000, 'xatol': 1e-9, 'fatol': 1e-12})
            dia = max(dia, -rr.fun)
    return gen, dia
rows = []
for dA in (0.3, 1.0, 3.0):
    for dC in (0.3, 1.0, 3.0):
        for ct in (1.0, 4.0, 12.0):
            for T in (0.5, 2.0):
                a_mean = rng.normal(); c_mean = rng.normal()
                A1, A3 = a_mean + dA, a_mean - dA; C1, C3 = c_mean + dC, c_mean - dC
                A2 = rng.normal(); C2 = (C1 + C3) / 2 + ct
                g, d = best((A1, A2, A3, C1, C2, C3), T)
                rows.append((g - d, dA, dC, ct, T))
rows.sort(key=lambda r: -r[0])
print(f"{len(rows)} cases in the remaining regime at fixed total norm. Largest (phase-free max - diagonal max) gaps:")
for r in rows[:6]: print("  gap %+.3e  d_A %.2g d_C %.2g c~ %.2g T %.2g" % r)
