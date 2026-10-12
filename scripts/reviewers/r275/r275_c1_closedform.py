"""r275 claim 1, closed form: everything about the witness, derived rather than measured.

Padded W_{CP^2} is supported on a 3-plane of so(n) whose restricted structure
tensor is a single totally antisymmetric entry kappa = sqrt2, and on that plane
W = diag(2,-1,-1)/sqrt6.  For a 3-plane with one structure constant kappa,
   (W#)_{aa} = kappa^2 lambda_b lambda_c        (a,b,c distinct)
and W# is diagonal in the same frame.  Everything follows in three lines.
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from r275_geo import Geo, cp_m, pad

g = Geo(4)
W = cp_m(g, 2)
ev, V = np.linalg.eigh(W)
idx = [i for i in range(g.N) if abs(ev[i]) > 1e-9]
B = V[:, idx]
c3 = np.einsum('abg,ap,bq,gr->pqr', g.c, B, B, B)
eps = np.zeros((3, 3, 3))
for p, q, r in ((0,1,2),(1,2,0),(2,0,1)):
    eps[p, q, r] = 1.0; eps[p, r, q] = -1.0
kap = c3[0, 1, 2]
print(f"  support of W_CP2 is a 3-plane; restricted eigenvalues {np.round(ev[idx],12)}")
print(f"  (2,-1,-1)/sqrt6 = {2/np.sqrt(6):.12f}, {-1/np.sqrt(6):.12f}")
print(f"  restricted structure tensor is kappa * epsilon with kappa = {kap:.15f}"
      f"  (sqrt2 = {np.sqrt(2):.15f}),  deviation {np.abs(c3 - kap*eps).max():.1e}")

lam = np.array([2, -1, -1]) / np.sqrt(6)
k2 = kap ** 2
sharp_diag = np.array([k2 * lam[1] * lam[2], k2 * lam[0] * lam[2], k2 * lam[0] * lam[1]])
print(f"\n  predicted W# eigenvalues kappa^2 lambda_b lambda_c : {np.round(sharp_diag,12)}"
      f"   (1/3, -2/3, -2/3)")
print(f"  measured                                          : "
      f"{np.round([e for e in np.linalg.eigvalsh(g.sharp(W)) if abs(e)>1e-9],12)}")
print(f"\n  tr(W^3)   = sum lambda^3 = 6/6^(3/2) = 1/sqrt6 = {1/np.sqrt(6):.12f}"
      f"   measured {np.trace(W@W@W):.12f}")
print(f"  tr(W#)    = 1/3 - 2/3 - 2/3 = -1                 measured {np.trace(g.sharp(W)):.12f}")
print(f"  ||W#||_F  = sqrt(1/9+4/9+4/9) = 1                measured {np.linalg.norm(g.sharp(W)):.12f}")
print(f"  <W#,W>    = (2/3+2/3+2/3)/sqrt6 = 2/sqrt6 = {2/np.sqrt(6):.12f}"
      f"   measured {np.sum(g.sharp(W)*W):.12f}")
print(f"  theta     = 1/sqrt6 + 2/sqrt6 = 3/sqrt6 = sqrt(3/2) = {np.sqrt(1.5):.12f}"
      f"   measured {g.theta(W):.12f}")
print(f"  F         = 1 + 1/sqrt6 = {1+1/np.sqrt(6):.12f}")
print(f"  cos(phi)  = 2/sqrt6 = sqrt(2/3) = {np.sqrt(2/3):.12f}")
print("\n  and padding changes none of it (zero rows and columns carry no trace and no bracket):")
for n in (6, 8, 10, 12, 14, 16):
    gg = Geo(n); P = gg.proj_weyl(pad(g, W, gg)); P /= np.linalg.norm(P)
    print(f"    n={n:>3}  theta={gg.theta(P):.12f}  F={np.trace(P@P@P)+np.linalg.norm(gg.sharp(P)):.12f}")
