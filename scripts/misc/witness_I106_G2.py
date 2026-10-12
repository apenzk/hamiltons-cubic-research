# Witness check for the G(2) refutation, seconds: one conflict case, general maximiser printed with its value,
# diagonal supremum computed twice (fine grid on the torus and continuous refinement from every grid local maximum).
import numpy as np
from scipy.optimize import minimize
rng = np.random.default_rng(99)
e1 = np.array([1, -1, 0]) / np.sqrt(2); e2 = np.array([1, 1, -2]) / np.sqrt(6)
basis = [np.diag(e1), np.diag(e2)]
for i, j in [(0, 1), (0, 2), (1, 2)]:
    E = np.zeros((3, 3)); E[i, j] = E[j, i] = 1 / np.sqrt(2); basis.append(E)
def mat(x): return sum(c * E for c, E in zip(x, basis))
def phi(U, V, A, C): return 3.75 * np.trace(U @ U @ U) + 2.25 * np.trace(U @ V @ V) + np.trace(U @ A) + np.trace(V @ C)
a = 2 * np.array([1, -1, 0]) / np.sqrt(2); c = 5 * np.array([0, 1, -1]) / np.sqrt(2); q = 1.0
A = np.diag(a); C = np.diag(c)
best = -1e9
for s in range(200):
    f = lambda x: -phi(mat(x[:5] / np.linalg.norm(x[:5])), mat(q * x[5:] / np.linalg.norm(x[5:])), A, C)
    r = minimize(f, rng.normal(size=10), method='BFGS', options={'gtol': 1e-12})
    if -r.fun > best: best = -r.fun; xb = r.x
U = mat(xb[:5] / np.linalg.norm(xb[:5])); V = mat(q * xb[5:] / np.linalg.norm(xb[5:]))
print("general maximiser value", repr(phi(U, V, A, C)), "| |U|", np.linalg.norm(U), "|V|", np.linalg.norm(V), "| tr U", np.trace(U), "tr V", np.trace(V))
np.set_printoptions(precision=6, suppress=True)
print("U =\n", U, "\nV =\n", V, "\ncommutator max", np.abs(U @ V - V @ U).max())
def dval(t1, t2):
    u = np.cos(t1) * e1 + np.sin(t1) * e2; v = q * (np.cos(t2) * e1 + np.sin(t2) * e2)
    return 3.75 * (u ** 3).sum() + u @ a + v @ c + 2.25 * u @ (v ** 2)
th = np.linspace(0, 2 * np.pi, 4001)
u = np.cos(th)[:, None] * e1 + np.sin(th)[:, None] * e2; v = q * u
G = 3.75 * (u ** 3).sum(1)[:, None] + (u @ a)[:, None] + (v @ c)[None, :] + 2.25 * (u @ (v ** 2).T)
print("diagonal supremum, grid 4001^2:", repr(G.max()))
refined = max(-minimize(lambda t: -dval(*t), [th[i], th[j]], method='Nelder-Mead', options={'xatol': 1e-12, 'fatol': 1e-14}).fun
              for i, j in zip(*np.unravel_index(np.argsort(G, axis=None)[-400:], G.shape)))
print("diagonal supremum, refined from the 400 best grid points:", repr(refined))
# Lipschitz bound on the grid error: |grad dval| <= L on the torus, grid step h, error <= L*h/sqrt(2)
h = th[1] - th[0]; L = 3 * 3.75 + np.linalg.norm(a) + q * np.linalg.norm(c) + 2.25 * 3 * q ** 2
print("grid error bound L*h:", L * h, "| gap general - max(grid, refined):", phi(U, V, A, C) - max(G.max(), refined))
