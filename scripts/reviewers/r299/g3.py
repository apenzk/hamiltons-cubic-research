import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np, core, points, le, g123

def analyse(nm, W, n):
    theta = core.P(n, W)
    Lm, th, B, Bf = le.Lmat(n, W, theta)
    Lp, Uc, w = le.restrict_perp(Lm, Bf, W)
    Lp = 0.5*(Lp+Lp.T)
    ev, evec = np.linalg.eigh(Lp)
    lmax = ev[-1]
    mult = int((np.abs(ev - lmax) < 1e-8).sum())
    Etop = evec[:, np.abs(ev-lmax) < 1e-8]         # coords in the e-perp basis Uc
    # V in the same coordinates
    rows, s, nA = g123.HA_span(n, W, True, True)   # (r, N*N)
    Vc = (rows @ Bf.T)                              # (r, d) coords in weyl basis
    Vc = Vc @ Uc                                    # (r, d-1) coords in e-perp
    # orthonormalise
    u_, s_, vt_ = np.linalg.svd(Vc, full_matrices=False)
    Vb = vt_[s_ > 1e-9]                             # (r, d-1) orthonormal rows
    M = Vb @ Etop
    cos = np.linalg.svd(M, compute_uv=False)
    evV = np.linalg.eigvalsh(Vb @ Lp @ Vb.T)
    # spectrum multiplicities of L_e on e-perp
    uq = {}
    for x in np.round(ev, 8):
        uq[x] = uq.get(x, 0) + 1
    top = sorted(uq.items())[-4:]
    print(f"== {nm} n={n} dim(e-perp)={Lp.shape[0]} lam_max={lmax:.9f} mult={mult} dimV={Vb.shape[0]}")
    print(f"   top spectrum (val,mult): {top}")
    print(f"   principal cosines(V, E_top): {np.round(cos,6)}   -> dim(V cap E_top)={int((cos>1-1e-8).sum())}")
    print(f"   spec(L_e|V): min={evV[0]:.6f} max={evV[-1]:.6f} mean={evV.mean():.6f} "
          f"#>1/2={(evV>0.5+1e-9).sum()} #=1/2={(np.abs(evV-0.5)<1e-9).sum()}")
    print(f"   spec(L_e|V) rounded: {sorted(set(np.round(evV,6)))}")
    return ev, evV, Vb, Lp

if __name__ == "__main__":
    for nm, W, n in [("S^3xS^5",)+points.sphere_product([3,5]),
                     ("CP^4",)+points.cpm(4),
                     ("C5blowup",)+points.c5_blowup()]:
        analyse(nm, W, n)
