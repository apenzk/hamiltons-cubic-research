# Screen of a candidate claim, seconds: max of Phi(U,V) = 3.75 tr U^3 + 2.25 tr(U V^2) + tr(U A) + tr(V C)
# over traceless symmetric U, V with |U| = 1, |V| = q, A and C diagonal, is attained at diagonal U and V.
# Diagonal maximum by an exhaustive angle grid, general maximum by BFGS restarts on the 5-spheres.
import numpy as np
from scipy.optimize import minimize
rng = np.random.default_rng(3)
e1 = np.array([1, -1, 0]) / np.sqrt(2); e2 = np.array([1, 1, -2]) / np.sqrt(6)
basis = [np.diag(e1), np.diag(e2)]
for i, j in [(0, 1), (0, 2), (1, 2)]:
    E = np.zeros((3, 3)); E[i, j] = E[j, i] = 1 / np.sqrt(2); basis.append(E)
def mat(x): return sum(c * E for c, E in zip(x, basis))
def phi(U, V, A, C): return 3.75 * np.trace(U @ U @ U) + 2.25 * np.trace(U @ V @ V) + np.trace(U @ A) + np.trace(V @ C)
th = np.linspace(0, 2 * np.pi, 2401)
def diag_max(a, c, q):
    u = np.cos(th)[:, None] * e1 + np.sin(th)[:, None] * e2; v = q * u
    t1 = 3.75 * (u ** 3).sum(1) + u @ a; t2 = v @ c
    cross = 2.25 * (u @ (v ** 2).T)
    return (t1[:, None] + t2[None, :] + cross).max()
def gen_max(A, C, q, starts=16):
    top = -1e9; best = None
    for s in range(starts):
        def f(x):
            U = mat(x[:5] / np.linalg.norm(x[:5])); V = mat(q * x[5:] / np.linalg.norm(x[5:]))
            return -phi(U, V, A, C)
        r = minimize(f, rng.normal(size=10), method='BFGS')
        if -r.fun > top: top = -r.fun; best = r.x
    U = mat(best[:5] / np.linalg.norm(best[:5])); V = mat(q * best[5:] / np.linalg.norm(best[5:]))
    return top, U, V
rows = []
for trial in range(60):
    scale = 10 ** rng.uniform(-1.5, 1.0); q = 10 ** rng.uniform(-0.5, 0.5)
    a = rng.normal(size=3); a -= a.mean(); c = rng.normal(size=3); c -= c.mean()
    g, U, V = gen_max(scale * np.diag(a), scale * np.diag(c), q); d = diag_max(scale * a, scale * c, q)
    offd = max(np.abs(U - np.diag(np.diag(U))).max(), np.abs(V - np.diag(np.diag(V))).max())
    rows.append((g - d, offd, np.abs(U @ V - V @ U).max(), scale, q, trial))
rows.sort(reverse=True)
print("60 cases. Largest (general - diagonal grid) gaps, with the general maximiser's off-diagonal size and commutator:")
for r in rows[:5]: print("  gap %+.3e  offdiag %.2e  commutator %.2e  scale %.3g  q %.3g  trial %d" % r)
print("smallest gap %+.3e (a negative gap is grid resolution against the continuous optimum)" % rows[-1][0])
