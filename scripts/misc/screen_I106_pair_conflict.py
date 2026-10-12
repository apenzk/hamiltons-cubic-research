# Falsifier screen for G(2), seconds: fields chosen so the orderings conflict (a and c in opposite orders,
# and a against |c|), across magnitudes and norm ratios. General max by BFGS restarts, diagonal max by grid.
import numpy as np
from scipy.optimize import minimize
rng = np.random.default_rng(17)
e1 = np.array([1, -1, 0]) / np.sqrt(2); e2 = np.array([1, 1, -2]) / np.sqrt(6)
basis = [np.diag(e1), np.diag(e2)]
for i, j in [(0, 1), (0, 2), (1, 2)]:
    E = np.zeros((3, 3)); E[i, j] = E[j, i] = 1 / np.sqrt(2); basis.append(E)
def mat(x): return sum(c * E for c, E in zip(x, basis))
def phi(U, V, A, C): return 3.75 * np.trace(U @ U @ U) + 2.25 * np.trace(U @ V @ V) + np.trace(U @ A) + np.trace(V @ C)
th = np.linspace(0, 2 * np.pi, 3601)
def diag_max(a, c, q):
    u = np.cos(th)[:, None] * e1 + np.sin(th)[:, None] * e2; v = q * u
    return (3.75 * (u ** 3).sum(1)[:, None] + (u @ a)[:, None] + (v @ c)[None, :] + 2.25 * (u @ (v ** 2).T)).max()
def gen_max(A, C, q, starts=24):
    top = -1e9; best = None
    for s in range(starts):
        f = lambda x: -phi(mat(x[:5] / np.linalg.norm(x[:5])), mat(q * x[5:] / np.linalg.norm(x[5:])), A, C)
        r = minimize(f, rng.normal(size=10), method='BFGS')
        if -r.fun > top: top = -r.fun; best = r.x
    return top, mat(best[:5] / np.linalg.norm(best[:5])), mat(q * best[5:] / np.linalg.norm(best[5:]))
patterns = {'a,c opposite': (np.array([1, 0, -1]), np.array([-1, 0, 1])),
            'a vs |c|': (np.array([1, 0, -1]), np.array([0, 1, -1])),
            'a vs c rotated': (np.array([1, -1, 0]), np.array([0, 1, -1])),
            'c two-valued': (np.array([2, -1, -1]), np.array([-1, 2, -1]))}
rows = []
for name, (a0, c0) in patterns.items():
    for sa in (0.1, 0.5, 1.0, 2.0, 5.0):
        for sc in (0.1, 0.5, 1.0, 2.0, 5.0):
            for q in (0.4, 1.0, 2.5):
                a = sa * a0 / np.linalg.norm(a0); c = sc * c0 / np.linalg.norm(c0)
                g, U, V = gen_max(np.diag(a), np.diag(c), q); d = diag_max(a, c, q)
                offd = max(np.abs(U - np.diag(np.diag(U))).max(), np.abs(V - np.diag(np.diag(V))).max())
                rows.append((g - d, offd, name, sa, sc, q))
rows.sort(key=lambda r: -r[0])
print(f"{len(rows)} conflict cases. Largest (general - diagonal grid) gaps:")
for r in rows[:6]: print("  gap %+.3e  general maximiser off-diagonal %.2e  %s  |a| %.2g |c| %.2g q %.2g" % r)
big = [r for r in rows if r[1] > 1e-3]
print(f"cases whose general maximiser is off-diagonal by more than 1e-3: {len(big)}")
for r in big[:6]: print("  gap %+.3e  off-diagonal %.2e  %s  |a| %.2g |c| %.2g q %.2g" % r)
