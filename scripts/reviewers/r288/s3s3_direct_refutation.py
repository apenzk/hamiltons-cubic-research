"""Reviewer 288: S^3 x S^3 is not a local maximum -- shown WITHOUT the fourth-order
formula, by exhibiting an explicit curve on the unit sphere of Weyl_6 along which
P exceeds theta.  Ascends <Pi(z o z), B^+ Pi(z o z)> over the unit sphere of A(1/2),
then evaluates P(gamma(t)) at the optimal corrector w = B^+ b."""
import sys, numpy as np
sys.path.insert(0, 'scripts/reviewers/r288')
import r288_core as R, r288_run as X
np.random.seed(23)
st = X.analyse('S^3 x S^3', 6, R.sphereprod([3, 3]))
n, B, D, th, half, LW, wc, W = (st['n'], st['B'], st['D'], st['th'], st['half'],
                                st['LW'], st['wc'], st['W'])
M = lambda a: np.einsum('k,kij->ij', a, B)
crd = lambda Z: np.einsum('kij,ij->k', B, Z)
K = np.eye(D) - np.outer(wc, wc) / (wc @ wc)
for v in half:
    u = K @ v; nu = np.linalg.norm(u)
    if nu > 1e-9: K -= np.outer(u, u) / nu ** 2
Bop = K @ (th / 2 * np.eye(D) - LW) @ K
ew, EV = np.linalg.eigh(Bop); keep = ew > 1e-8
Bi = EV[:, keep] @ np.diag(1 / ew[keep]) @ EV[:, keep].T
def val(c):
    a = half.T @ c; a /= np.linalg.norm(a); Z = M(a)
    b = K @ crd(R.circ(n, Z, Z)); return float(b @ Bi @ b)
best, bc = -1, None
for _ in range(40):
    c = np.random.randn(len(half)); c /= np.linalg.norm(c); v = val(c); step = .3
    for _ in range(400):
        g = np.array([(val(c + np.eye(len(c))[k] * 1e-6)
                       - val(c - np.eye(len(c))[k] * 1e-6)) / 2e-6 for k in range(len(c))])
        c2 = c + step * g; c2 /= np.linalg.norm(c2); v2 = val(c2)
        if v2 > v: c, v = c2, v2
        else: step *= .5
        if step < 1e-12: break
    if v > best: best, bc = v, c
a = half.T @ bc; a /= np.linalg.norm(a); Z = M(a)
b = K @ crd(R.circ(n, Z, Z)); wopt = Bi @ b; Wm = M(wopt)
print(f"\n  max <b,B^+b> over A(1/2) = {best:.9f}   theta/2 = {th/2:.9f}")
print(f"  at the maximiser: T(z,z,z) = {R.T3(n,Z,Z,Z):.2e}, "
      f"||Proj_A(1/2)(z o z)|| = {np.linalg.norm(crd(R.circ(n,Z,Z)) @ half.T):.2e}"
      f"   (both zero: the sup over w is finite and attained)")
print(f"  predicted [t^4] = (3/4)*{best:.6f} - 3theta/8 = {0.75*best - 3*th/8:+.9f}")
for t in [.5, .3, .2, .1, .05, .02]:
    x = W + t * Z + .5 * t * t * Wm; g = x / np.linalg.norm(x)
    d = R.P(n, g) - th
    print(f"    t={t:5.3f}  P(gamma)-theta = {d:+.6e}   /t^4 = {d/t**4:+.6f}")
