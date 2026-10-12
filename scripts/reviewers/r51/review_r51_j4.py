"""J4: does padding create degeneracy at high theta/theta_0?  Broad sweep."""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r51_core import *
from review_r51_j3 import full_Le

def measure(n, W, tol=1e-6):
    W = normalize(W)
    th, L, B, asym, leak = full_Le(n, W, verbose=False)
    ev = np.linalg.eigvalsh(L)
    orb = onb_rows(orbit_tangent(n, W)).shape[0]
    half = int(np.sum(np.abs(ev - 0.5) < tol))
    # verify orbit tangent really sits inside E(1/2)
    U = onb_rows(orbit_tangent(n, W))
    d = B.shape[0]; Bf = B.reshape(d, -1)
    co = U @ Bf.T
    resid = np.linalg.norm(co @ L - 0.5 * co) / max(np.linalg.norm(co), 1e-30)
    rest = np.sort(np.abs(ev - 0.5))
    gap = rest[half] if half < len(rest) else np.nan
    return th, orb, half, gap, resid

cases = []
for (p, q) in [(2,2),(2,3),(2,4),(2,5),(2,6),(2,8),(3,3),(3,4),(3,5),(4,4),
               (4,5),(4,6),(5,5),(5,6),(5,7),(6,6)]:
    n0 = p + q
    for n in (n0, n0+1, n0+2, n0+4):
        if n <= 14 and (n == n0 or n >= n0 + 1):
            cases.append((p, q, n0, n))

print(f"{'seed':>9} {'n0':>3} {'n':>3} {'theta':>11} {'th/th0':>8} {'orbit':>6} "
      f"{'dimE':>6} {'exc':>5} {'gap':>10} {'orb-in-E':>9}")
rows = []
for (p, q, n0, n) in cases:
    if n > 14: continue
    if n == 14 and dim_weyl(14) and (p+q) < 6: pass
    t0 = time.time()
    try:
        th, orb, half, gap, resid = measure(n, sphere_product_W((p,q), n))
    except Exception as ex:
        print(f"  S{p}xS{q} n={n}: FAILED {ex}"); continue
    r = th/theta0(n)
    flag = "" if half == orb else "  <-- DEGENERATE"
    print(f"{'S%dxS%d'%(p,q):>9} {n0:3d} {n:3d} {th:11.7f} {r:8.4f} {orb:6d} {half:6d} "
          f"{half-orb:5d} {gap:10.3e} {resid:9.1e}{flag}", flush=True)
    rows.append((p,q,n0,n,th,r,orb,half))

print()
print("== counterexample hunt: nondegenerate at n0, degenerate after padding ==")
by = {}
for (p,q,n0,n,th,r,orb,half) in rows:
    by[(p,q,n)] = (n0,th,r,orb,half)
best = None
for (p,q,n0,n,th,r,orb,half) in rows:
    if n == n0: continue
    nat = by.get((p,q,n0))
    if nat is None: continue
    if nat[4] == nat[3] and half != orb:
        print(f"  S^{p}xS^{q}: nondeg at n={n0} (orb {nat[3]}={nat[4]}), "
              f"DEGENERATE at n={n} (orb {orb}, dimE {half}, excess {half-orb}), "
              f"theta/theta0 = {r:.4f}")
        if best is None or r > best[0]:
            best = (r, p, q, n0, n)
if best:
    print(f"  highest-sitting such counterexample: S^{best[1]}xS^{best[2]} padded "
          f"{best[3]}->{best[4]} at {best[0]:.4f} theta_0")
else:
    print("  none found in this sweep")
