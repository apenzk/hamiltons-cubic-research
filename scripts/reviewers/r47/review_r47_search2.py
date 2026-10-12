"""Levenberg-Marquardt search for critical points; test 'full support + S=0 => graded'."""
import numpy as np, time, sys
from scipy.optimize import least_squares
from review_r47_core import *
from review_r47_t3 import support_rank

n = int(sys.argv[1]) if len(sys.argv)>1 else 6
budget = float(sys.argv[2]) if len(sys.argv)>2 else 120.0
g = Geom(n); Bas = g.weyl_basis(); dW = Bas.shape[0]
Bmat = Bas.reshape(dW,-1)
print(f"n={n} dim Weyl={dW}", flush=True)

def W_of(c):
    W = (c@Bmat).reshape(g.N,g.N)
    return W/np.linalg.norm(W)
def resid(c):
    W = W_of(c); QW = g.Q(W)
    th = float((QW*W).sum())
    return Bmat @ (QW - th*W).ravel()

rng = np.random.default_rng(4747)
found=[]; t0=time.time(); tries=0
while time.time()-t0 < budget:
    tries += 1
    c0 = rng.normal(size=dW)
    sol = least_squares(resid, c0, method='lm', xtol=1e-14, ftol=1e-14, gtol=1e-14, max_nfev=4000)
    W = W_of(sol.x); th,res = crit_residual(g,W)
    if res>1e-10 or th<1e-4: continue
    st = struct_sums(g,W); sup=support_rank(g,W)
    found.append((th,st['S'],st['leak'],st['dim_m'],sup,W.copy()))
print(f"tries={tries} converged={len(found)} in {time.time()-t0:.0f}s", flush=True)
if found:
    a=np.array([[f[0],f[1],f[2],f[3],f[4]] for f in found])
    print(f" theta [{a[:,0].min():.6f},{a[:,0].max():.6f}]  S [{a[:,1].min():.3e},{a[:,1].max():.3e}]")
    print(f" leak [{a[:,2].min():.3e},{a[:,2].max():.3e}]  dim_m [{a[:,3].min():.0f},{a[:,3].max():.0f}]"
          f"  support [{a[:,4].min():.0f},{a[:,4].max():.0f}]")
    nS0 = int((a[:,1]<1e-10).sum()); nL0=int((a[:,2]<1e-10).sum())
    print(f" S=0 count: {nS0}   leak=0 count: {nL0}   graded (both): {int(((a[:,1]<1e-10)&(a[:,2]<1e-10)).sum())}")
    bad=[f for f in found if f[1]<1e-10 and f[2]>1e-10 and f[4]==n]
    print(f" FULL-SUPPORT ungraded with S=0: {len(bad)}")
    for f in bad[:8]:
        print(f"   theta={f[0]:.9f} S={f[1]:.2e} leak={f[2]:.4f} dim_m={f[3]} supp={f[4]}")
        np.save(f"agent_logs/review_r47_fullsupp_S0_ungraded_n{n}_th{f[0]:.6f}.npy", f[5])
    # partial-support points found by search
    ps=[f for f in found if f[4]<n]
    print(f" partial-support points found: {len(ps)} (of {len(found)})")
    for f in ps[:8]:
        print(f"   theta={f[0]:.9f} S={f[1]:.2e} leak={f[2]:.4f} supp={f[4]}")
