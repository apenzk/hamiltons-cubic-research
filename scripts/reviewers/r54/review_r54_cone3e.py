"""K3: the cubic tangent cone, reduced to 20 variables and solved.

Three measured collapses, in order.
  1.  T vanishes identically on E(1/2)^3, so the quadratic obstruction is vacuous.
  2.  Psi vanishes on the whole 40-dimensional orbit subspace O.
  3.  Psi(o + x) = Psi(x) for every o in O -- the third-order obstruction depends only
      on the excess component.  (dPsi|_o is 4.6e-14 on all of E(1/2).)

So the tangent cone is  O  (+)  { x in excess : Psi(x) = 0 },  and the whole question
is whether the homogeneous cubic system Psi(x) = 0 -- 60 equations in 20 unknowns --
has a nonzero real solution.  That is a search over a 19-sphere, done here to high
precision with an analytic Jacobian.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time
import numpy as np
from scipy.optimize import least_squares
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))

SCR = 'scratchpad'
d = np.load(f'{SCR}/r54_cone3.npz')
C, Qo, Exc, K, th = d['C'], d['Qo'], d['Exc'], d['K'], float(d['th'])
r = C.shape[1]
Cbar = np.einsum('de,eij->dij', K, C, optimize=True)
T4 = -(1.0/th)*np.einsum('dli,djk->lijk', C, Cbar, optimize=True)
T4 = (T4 + T4.transpose(0, 1, 3, 2))/2.0
PsiE = lambda v: np.einsum('lijk,i,j,k->l', T4, v, v, v, optimize=True)
nO, nE = Qo.shape[1], Exc.shape[1]
rng = np.random.default_rng(161803)

print("--- the two collapses, measured ---")
o = Qo @ rng.normal(size=nO); x = Exc @ rng.normal(size=nE); x /= np.linalg.norm(x)
print(f"  |Psi(o)|                 = {np.linalg.norm(PsiE(o)):.2e}   (|o| = {np.linalg.norm(o):.3f})")
diffs = [np.linalg.norm(PsiE(lam*o + x) - PsiE(x)) for lam in (0.5, 1, 2, 5, 20)]
print(f"  |Psi(lam o + x)-Psi(x)|  = {['%.1e' % t for t in diffs]}  against |Psi(x)| = "
      f"{np.linalg.norm(PsiE(x)):.4f}")
worst = 0.0
for _ in range(300):
    oo = Qo @ rng.normal(size=nO); xx = Exc @ rng.normal(size=nE); xx /= np.linalg.norm(xx)
    worst = max(worst, np.linalg.norm(PsiE(oo + xx) - PsiE(xx)))
print(f"  worst over 300 random (o,x) pairs: {worst:.2e}")

# reduced cubic in the 20 excess coordinates
T = np.einsum('lijk,ia,jb,kc->labc', T4, Exc, Exc, Exc, optimize=True)   # (60,20,20,20)
f = lambda z: np.einsum('labc,a,b,c->l', T, z, z, z, optimize=True)
def jac(z):
    return (np.einsum('labc,b,c->la', T, z, z, optimize=True)
            + np.einsum('labc,a,c->lb', T, z, z, optimize=True)
            + np.einsum('labc,a,b->lc', T, z, z, optimize=True))
zt = rng.normal(size=nE)
print(f"  reduced tensor check: {np.linalg.norm(f(zt) - PsiE(Exc @ zt))/np.linalg.norm(f(zt)):.2e}")

print("\n--- minimise |Psi(x)| over the unit 19-sphere of excess directions ---")
def resid(z):
    return np.append(f(z), np.dot(z, z) - 1.0)
def rjac(z):
    return np.vstack([jac(z), 2*z])
best = np.inf; bz = None; mins = []
t0 = time.time()
for s in range(4000):
    z0 = rng.normal(size=nE); z0 /= np.linalg.norm(z0)
    sol = least_squares(resid, z0, jac=rjac, xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=2000)
    v = float(np.linalg.norm(sol.fun))
    mins.append(v)
    if v < best:
        best, bz = v, sol.x.copy()
mins = np.array(mins)
print(f"4000 starts in {time.time()-t0:.0f}s")
print(f"  MIN |Psi| on the unit sphere = {best:.8e}")
print(f"  distribution of local minima: 1st percentile {np.percentile(mins,1):.4e}, "
      f"median {np.median(mins):.4f}, max {mins.max():.4f}")
print(f"  number of starts landing below 1e-2: {(mins < 1e-2).sum()}; below 1e-6: {(mins < 1e-6).sum()}")
print(f"  |Psi| at the minimiser = {np.linalg.norm(f(bz)):.8e}, |x| = {np.linalg.norm(bz):.10f}")
sv = np.linalg.svd(jac(bz), compute_uv=False)
print(f"  singular values of dPsi at the minimiser: max {sv[0]:.4f}, min {sv[-1]:.4e}")
np.save(f'{SCR}/r54_cone3e_best.npy', bz)
MDEOF_GUARD = None
