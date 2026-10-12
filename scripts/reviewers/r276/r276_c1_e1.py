"""r276 Claim 1: is padded W_{CP^2} circ-INDECOMPOSABLE at n=12?

dim E(1) of L_e (e = W/theta) restricted to Weyl_n: every circ-summand of a
circ-splitting lies in E(1), so dim E(1) = 1 proves no nontrivial splitting exists.
"""
import sys; sys.path.insert(0, 'scripts/reviewers/r276')
import numpy as np, time
from r276_core import Geom, theta0, padded_cp2, sphere_product, weyl_basis

def sharp_bilin(g, A, Bs):
    """A # B for a stack Bs of symmetric matrices: -1/4 tr(ad_a A ad_b B + a<->b)."""
    PA = np.einsum('amn,np->amp', g.ad, A, optimize=True)          # ad_a A
    PB = np.einsum('amn,knp->kamp', g.ad, Bs, optimize=True)       # ad_a B_k
    T1 = -0.25*np.einsum('amp,kbpm->kab', PA, PB, optimize=True)
    return T1 + np.transpose(T1, (0, 2, 1))

for n in (6, 8, 12):
    t = time.time(); g = Geom(n); Bs = weyl_basis(g); D = len(Bs)
    print(f"n={n}  dim Weyl = {D}  (formula {(n+2)*(n+1)*n*(n-3)//12})", flush=True)
    for name, W in (("padded CP2", padded_cp2(g)), ("S^m x S^m", sphere_product(g)),):
        W = W/np.linalg.norm(W); th = g.theta(W); e = W/th
        L = 0.5*(e@Bs + Bs@e) + sharp_bilin(g, e, Bs)          # L_e(B_k)
        Mat = np.einsum('kab,lab->lk', L, Bs, optimize=True)     # matrix in the ONB
        ev = np.linalg.eigvalsh(0.5*(Mat+Mat.T))
        print(f"   {name:11s} theta={th:.6f}  lam_max={ev[-1]:.6f}  "
              f"dim E(1)={int(np.sum(np.abs(ev-1)<1e-8))}  dim E(1/2)={int(np.sum(np.abs(ev-0.5)<1e-8))}",
              flush=True)
    print(f"   ({time.time()-t:.0f}s)", flush=True)
