"""K3: the cubic cone NEAR the orbit, exactly.

Psi vanishes on the whole 40-dimensional orbit subspace O, so dPsi|_o kills O for every
o in O.  Whether the cone {Psi = 0} is bigger than O near a ray o is therefore the
question of whether dPsi|_o has a kernel vector OUTSIDE O, i.e. whether the 60 x 20
matrix A(o) = dPsi|_o restricted to the excess drops rank.  If sigma_min(A(o)) is
bounded away from 0 over the unit sphere of O, the implicit function theorem puts the
cone exactly on O in a neighbourhood of every ray, and by homogeneity that settles the
whole small-excess-fraction regime that the far-field search cannot reach.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time
import numpy as np
from scipy.optimize import minimize
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))

SCR = 'scratchpad'
d = np.load(f'{SCR}/r54_cone3.npz')
C, H, Qo, Exc, K, th = d['C'], d['H'], d['Qo'], d['Exc'], d['K'], float(d['th'])
D, r = C.shape[0], C.shape[1]
Cbar = np.einsum('de,eij->dij', K, C, optimize=True)
T4 = -(1.0/th)*np.einsum('dli,djk->lijk', C, Cbar, optimize=True)
T4 = (T4 + T4.transpose(0, 1, 3, 2))/2.0
Psi = lambda v: np.einsum('lijk,i,j,k->l', T4, v, v, v, optimize=True)
def dPsi(v):
    return (np.einsum('lijk,j,k->li', T4, v, v, optimize=True)
            + np.einsum('lijk,i,k->lj', T4, v, v, optimize=True)
            + np.einsum('lijk,i,j->lk', T4, v, v, optimize=True))
nO, nE = Qo.shape[1], Exc.shape[1]
print(f"dim E(1/2)={r}, orbit={nO}, excess={nE}")

rng = np.random.default_rng(31415)
# sanity: dPsi|_o must annihilate O
o = Qo @ rng.normal(size=nO); o /= np.linalg.norm(o)
print(f"check dPsi|_o kills the orbit subspace: |dPsi(o) Qo| = {np.linalg.norm(dPsi(o) @ Qo):.2e}")
print(f"check Psi(o) = {np.linalg.norm(Psi(o)):.2e}")

def sigmin(z):
    o = Qo @ z
    n = np.linalg.norm(o)
    if n < 1e-12:
        return 0.0
    o = o/n
    A = dPsi(o) @ Exc                      # (60, 20)
    return float(np.linalg.svd(A, compute_uv=False)[-1])

vals = [sigmin(rng.normal(size=nO)) for _ in range(3000)]
print(f"sigma_min(A(o)) over 3000 random unit orbit rays: min={min(vals):.6f} "
      f"median={np.median(vals):.6f} max={max(vals):.6f}")
ranks = [np.linalg.matrix_rank(dPsi(Qo @ rng.normal(size=nO)) @ Exc, tol=1e-8) for _ in range(200)]
print(f"rank of A(o) over 200 random rays: min={min(ranks)} max={max(ranks)} (full = {nE})")

print("\nminimising sigma_min(A(o)) over the unit sphere of the orbit subspace")
best = np.inf; t0 = time.time()
for s in range(120):
    z0 = rng.normal(size=nO)
    res = minimize(sigmin, z0, method='Nelder-Mead',
                   options={'maxiter': 6000, 'xatol': 1e-10, 'fatol': 1e-12})
    if res.fun < best:
        best = float(res.fun); bz = res.x.copy()
print(f"120 Nelder-Mead runs in {time.time()-t0:.0f}s: min sigma_min = {best:.6e}")
A = dPsi(Qo @ bz / np.linalg.norm(Qo @ bz)) @ Exc
print(f"  singular values at the minimiser: {np.round(np.linalg.svd(A, compute_uv=False), 5)}")
