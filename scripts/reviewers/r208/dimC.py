import sys, os, time, numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib208 as L

t = time.time()
N = 4200
U = L.orbit(N, seed=208)
print(f"orbit sample {U.shape} in {time.time()-t:.1f}s", flush=True)
t = time.time()
C = L.Cone(U)
print(f"eigh done in {time.time()-t:.1f}s", flush=True)
w = C.spec
print("dim C (rel tol 1e-9):", C.dimC, " record says 3570")
for tol in (1e-6, 1e-8, 1e-10, 1e-12):
    print(f"   tol {tol:g}: {(w > tol*w.max()).sum()}")
print("rho(w0) =", C.rho(L.w0))
rng = np.random.default_rng(11)
print("rho at 5 random points:", [round(C.rho(rng.standard_normal(35)), 6) for _ in range(5)])
np.save("/tmp/r208_U.npy", U)
