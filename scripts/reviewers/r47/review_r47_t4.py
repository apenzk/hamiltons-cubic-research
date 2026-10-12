"""T4: Morse-Bott nondegeneracy at padded W_CP2, and continuity of S as a function."""
import numpy as np, time, sys
from review_r47_core import *
from review_r47_t3 import cp_m, support_rank

g4,W4 = cp_m(2)
print(f"W_CP2 native: theta={crit_residual(g4,W4)[0]:.12f}", flush=True)

ns = [int(x) for x in sys.argv[1:]] or [8,10,12]
for n in ns:
    t0=time.time()
    g = Geom(n); W = pad(g4,g,W4)
    th,res = crit_residual(g,W); e = W/th
    Bas = g.weyl_basis()
    L = Le_matrix(g, e, Bas)
    sym = np.abs(L-L.T).max()
    L = (L+L.T)/2
    ev = np.linalg.eigvalsh(L)
    n_half = int(np.sum(np.abs(ev-0.5)<1e-8))
    n_one  = int(np.sum(np.abs(ev-1.0)<1e-8))
    od = orbit_dim(g,W)
    print(f" n={n}: dimWeyl={Bas.shape[0]} theta={th:.12f} res={res:.1e} symerr={sym:.1e} "
          f"tr(L)={np.trace(L):.2e} | dim E(1/2)={n_half} orbit={od} "
          f"{'NONDEGENERATE' if n_half==od else 'DEGENERATE excess '+str(n_half-od)} "
          f"| dim E(1)={n_one} | [{time.time()-t0:.0f}s]", flush=True)
    ux = sorted(set(np.round(ev,9)))
    print(f"   distinct L_e eigenvalues: {ux}", flush=True)
