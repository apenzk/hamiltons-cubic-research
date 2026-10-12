"""r213: a wider hunt -- 3000 ascents, the spectrum of critical values, and a
second-order check at the maximiser."""
import numpy as np, importlib.util, os, collections
sp = importlib.util.spec_from_file_location("h", os.path.join(os.path.dirname(os.path.abspath(__file__)), "hunt_f5_negative.py"))
h = importlib.util.module_from_spec(sp); sp.loader.exec_module(h)
rng = np.random.default_rng(777)
LIM = 1.0/np.sqrt(6.0)
vals = []
best = -1e18; bx = None
for k in range(3000):
    x0 = rng.normal(size=35)
    sign = 1 if k % 2 else -1
    x, v = h.ascend(x0, sign, iters=3000)
    vals.append(v)
    if v > best: best, bx = v, x
vals = np.array(vals)
print(f"3000 ascents.  max {best:.13f}   1/sqrt(6) = {LIM:.13f}")
print(f"  excess over 1/sqrt(6): {best-LIM:.3e}   (positive by more than 1e-9 would refute)")
print(f"  F_5/|W|^6 at the best point: {1.5-9*best*best:.6e}")
lv = np.round(vals, 9)
c = collections.Counter(lv)
print("  distinct critical values found (top 12 by value):")
for v, n in sorted(c.items(), reverse=True)[:12]:
    print(f"     {v:+.9f}   x{n}   F_5/|W|^6 = {1.5-9*v*v:+.6e}")
# second-order: Hessian of tr(W^3) - lambda|W|^2 restricted to the tangent space
x = bx/np.linalg.norm(bx)
M = (x @ h.BAS).reshape(25,25)
H = np.zeros((35,35))
for i in range(35):
    Bi = h.BAS[i].reshape(25,25)
    G = 3.0*(Bi@M + M@Bi)
    H[i] = h.BAS @ G.reshape(-1)
lam = h.t3(x)*3.0/1.0   # <x, grad> = 3 t3 ; on the sphere grad = lam x with lam = 3 t3
g = h.grad_t3(x); lam = g @ x
Q = H - lam*np.eye(35)
# tangent space
U, s, Vt = np.linalg.svd(x.reshape(1,-1)); T = Vt[1:]
ev = np.linalg.eigvalsh(T @ Q @ T.T)
print(f"  constrained Hessian eigenvalues at the maximiser: max {ev.max():.3e}, min {ev.min():.3e}")
print(f"  (all <= 0 means a genuine local maximum; count > 1e-8: {int((ev>1e-8).sum())})")
