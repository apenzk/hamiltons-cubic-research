"""Search for critical points at n=6,7 and test the repair 'full support + S=0 => graded'."""
import numpy as np, time, sys
from review_r47_core import *
from review_r47_t3 import support_rank

n = int(sys.argv[1]) if len(sys.argv)>1 else 6
budget = float(sys.argv[2]) if len(sys.argv)>2 else 180.0
g = Geom(n); Bas = g.weyl_basis()
dW = Bas.shape[0]
print(f"n={n} dim Weyl={dW}", flush=True)
Bmat = Bas.reshape(dW,-1)

def proj(M):
    c = Bmat @ M.ravel()
    return (c @ Bmat).reshape(g.N,g.N)

rng = np.random.default_rng(4747)
found = []
t0=time.time(); tries=0; conv=0
while time.time()-t0 < budget:
    tries += 1
    c = rng.normal(size=dW); W = (c@Bmat).reshape(g.N,g.N); W/= np.linalg.norm(W)
    ok=False
    for it in range(400):
        QW = proj(g.Q(W))
        nq = np.linalg.norm(QW)
        if nq < 1e-12: break
        Wn = QW/nq
        if np.linalg.norm(Wn-W) < 1e-13: W=Wn; ok=True; break
        W = Wn
    if not ok: continue
    th,res = crit_residual(g,W)
    if res > 1e-11 or th < 1e-6: continue
    conv += 1
    st = struct_sums(g,W); sup = support_rank(g,W)
    found.append((th, st['S'], st['leak'], st['dim_m'], sup, W.copy()))

print(f"tries={tries} converged={conv} in {time.time()-t0:.0f}s", flush=True)
if found:
    ths = np.array([f[0] for f in found]); Ss=np.array([f[1] for f in found])
    lks = np.array([f[2] for f in found]); dms=np.array([f[3] for f in found])
    sups= np.array([f[4] for f in found])
    print(f" theta range [{ths.min():.6f},{ths.max():.6f}]")
    print(f" S range [{Ss.min():.3e},{Ss.max():.3e}]   leak range [{lks.min():.3e},{lks.max():.3e}]")
    print(f" dim m range [{dms.min()},{dms.max()}]   support range [{sups.min()},{sups.max()}]")
    tolS = 1e-10
    z = [f for f in found if f[1] < tolS]
    print(f" points with S < {tolS}: {len(z)}")
    for f in z[:20]:
        print(f"   theta={f[0]:.9f} S={f[1]:.2e} leak={f[2]:.4f} dim_m={f[3]} supp={f[4]}"
              f" -> {'GRADED' if f[2]<1e-10 else 'UNGRADED with S=0'}")
    zl = [f for f in found if f[2] < 1e-10]
    print(f" points with leak < 1e-10 (h a subalgebra): {len(zl)}, of which S=0: {sum(1 for f in zl if f[1]<tolS)}")
    # full-support + S=0 => graded ?
    bad = [f for f in found if f[1]<tolS and f[2]>1e-10 and f[4]==n]
    print(f" FULL-SUPPORT ungraded points with S=0: {len(bad)}")
    for f in bad[:10]:
        print(f"   theta={f[0]:.9f} S={f[1]:.2e} leak={f[2]:.4f} dim_m={f[3]}")
        np.save(f"agent_logs/review_r47_fullsupport_S0_ungraded_n{n}_th{f[0]:.6f}.npy", f[5])
