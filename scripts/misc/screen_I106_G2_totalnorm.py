# Falsifier screen for G(2) at FIXED TOTAL NORM 1.5|U|^2 + 0.5|V|^2 = T, the form the block problem poses.
# Phi = 3.75 tr U^3 + 2.25 tr(U V^2) + tr(U A) + tr(V C), A, C diagonal. General max: BFGS over (psi, U-dir, V-dir).
# Diagonal max: exhaustive grid over psi and the two circles, then refinement. Also r954's check at the witness fields.
import numpy as np
from scipy.optimize import minimize
rng = np.random.default_rng(23)
e1 = np.array([1, -1, 0]) / np.sqrt(2); e2 = np.array([1, 1, -2]) / np.sqrt(6)
basis = [np.diag(e1), np.diag(e2)]
for i, j in [(0, 1), (0, 2), (1, 2)]:
    E = np.zeros((3, 3)); E[i, j] = E[j, i] = 1 / np.sqrt(2); basis.append(E)
def mat(x): return sum(c * E for c, E in zip(x, basis))
def phi(U, V, A, C): return 3.75 * np.trace(U @ U @ U) + 2.25 * np.trace(U @ V @ V) + np.trace(U @ A) + np.trace(V @ C)
def norms(psi, T): return np.sqrt(T / 1.5) * np.cos(psi), np.sqrt(T / 0.5) * np.sin(psi)
def gen_max(A, C, T, starts=30):
    top = -1e9; best = None
    for s in range(starts):
        def f(x):
            p, q = norms(x[0], T); return -phi(mat(p * x[1:6] / np.linalg.norm(x[1:6])), mat(q * x[6:] / np.linalg.norm(x[6:])), A, C)
        r = minimize(f, np.concatenate([[rng.uniform(0, np.pi / 2)], rng.normal(size=10)]), method='BFGS')
        if -r.fun > top: top = -r.fun; best = r.x
    p, q = norms(best[0], T)
    return top, mat(p * best[1:6] / np.linalg.norm(best[1:6])), mat(q * best[6:] / np.linalg.norm(best[6:]))
th = np.linspace(0, 2 * np.pi, 721); circ = np.cos(th)[:, None] * e1 + np.sin(th)[:, None] * e2
def diag_max(a, c, T):
    top = -1e9; arg = None
    for psi in np.linspace(-np.pi / 2, np.pi / 2, 181):
        p, q = norms(psi, T); u = p * circ; v = q * circ
        G = 3.75 * (u ** 3).sum(1)[:, None] + (u @ a)[:, None] + (v @ c)[None, :] + 2.25 * (u @ (v ** 2).T)
        k = np.argmax(G)
        if G.flat[k] > top: top = G.flat[k]; arg = (psi, th[k // 721], th[k % 721])
    def dval(t):
        p, q = norms(t[0], T); u = p * (np.cos(t[1]) * e1 + np.sin(t[1]) * e2); v = q * (np.cos(t[2]) * e1 + np.sin(t[2]) * e2)
        return 3.75 * (u ** 3).sum() + u @ a + v @ c + 2.25 * u @ (v ** 2)
    ref = -minimize(lambda t: -dval(t), arg, method='Nelder-Mead', options={'xatol': 1e-10, 'fatol': 1e-12}).fun
    return max(top, ref)
a = 2 * np.array([1, -1, 0]) / np.sqrt(2); c = 5 * np.array([0, 1, -1]) / np.sqrt(2)
print("r954 check, witness fields at total norm 2: diagonal max =", round(diag_max(a, c, 2.0), 6), "(r954 reports 10.351; witness Phi 7.503)")
patterns = {'a,c opposite': (np.array([1, 0, -1]), np.array([-1, 0, 1])), 'a vs |c|': (np.array([1, 0, -1]), np.array([0, 1, -1])),
            'a vs c rotated': (np.array([1, -1, 0]), np.array([0, 1, -1])), 'c two-valued': (np.array([2, -1, -1]), np.array([-1, 2, -1]))}
rows = []
for name, (a0, c0) in patterns.items():
    for sa in (0.3, 1.0, 3.0):
        for sc in (0.3, 1.0, 3.0, 8.0):
            for T in (0.5, 2.0, 6.0):
                aa = sa * a0 / np.linalg.norm(a0); cc = sc * c0 / np.linalg.norm(c0)
                g, U, V = gen_max(np.diag(aa), np.diag(cc), T); d = diag_max(aa, cc, T)
                offd = max(np.abs(U - np.diag(np.diag(U))).max(), np.abs(V - np.diag(np.diag(V))).max())
                rows.append((g - d, offd, np.abs(U @ V - V @ U).max(), name, sa, sc, T))
rows.sort(key=lambda r: -r[0])
print(f"{len(rows)} conflict cases at fixed total norm. Largest (general - diagonal) gaps:")
for r in rows[:6]: print("  gap %+.3e  off-diagonal %.2e  commutator %.2e  %s  |a| %.2g |c| %.2g T %.2g" % r)
print("cases with an off-diagonal general maximiser (> 1e-3):", sum(1 for r in rows if r[1] > 1e-3))
