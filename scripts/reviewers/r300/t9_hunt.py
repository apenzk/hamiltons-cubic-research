"""Hunt: a critical point with Delta > 0 and lambda_max(L_e|e^perp) <= 1/2 would refute V3."""
import sys, time; sys.path.insert(0,'scripts/reviewers/r300')
import numpy as np, core300 as C
from scipy.optimize import least_squares

n = int(sys.argv[1]); nstart = int(sys.argv[2]); seed = int(sys.argv[3])
B = C.weyl_basis(n); D = len(B)
rng = np.random.default_rng(seed)

def Wof(x):
    x = x/np.linalg.norm(x)
    return np.einsum('k,kij->ij', x, B), x

def resid(x):
    W, xn = Wof(x)
    q = C.to_coords(n, C.Q(n, W))
    return q - float(xn@q)*xn

def jac(x):
    W, xn = Wof(x)
    M,_ = C.Le_matrix(n, W)
    q = C.to_coords(n, C.Q(n, W))
    th = float(xn@q)
    Pn = (np.eye(D)-np.outer(xn,xn))/np.linalg.norm(x)   # d(x/|x|)/dx
    dq = 2*M
    dth = (dq.T@xn + q)
    J = dq - th*np.eye(D) - np.outer(xn, dth)
    return J@Pn

found=[]; t0=time.time()
for it in range(nstart):
    x0 = rng.standard_normal(D)
    sol = least_squares(resid, x0/np.linalg.norm(x0), jac=jac, xtol=1e-14, ftol=1e-14, gtol=1e-14, max_nfev=200)
    W, xn = Wof(sol.x)
    r = float(np.linalg.norm(resid(sol.x)))
    if r > 1e-10: continue
    th = float(np.tensordot(W, C.Q(n, W)))
    if abs(th) < 1e-6: continue
    dpos, dtot = C.delta_defect(n, W)
    M,_ = C.Le_matrix(n, W/th)
    w = C.to_coords(n, W); w/=np.linalg.norm(w)
    Pp = np.eye(D)-np.outer(w,w)
    lam = float(np.linalg.eigvalsh(Pp@M@Pp)[-1])
    found.append((th, dpos, lam))
    if dpos > 1e-6 and lam <= 0.5 + 1e-9:
        print(f"*** COUNTEREXAMPLE CANDIDATE: theta={th} Delta={dpos} lam={lam}")
        np.save(f"scripts/reviewers/r300/ce_n{n}_{it}.npy", W)
    if (it+1) % 25 == 0:
        print(f"  [{time.time()-t0:6.0f}s] {it+1}/{nstart} starts, {len(found)} critical pts", flush=True)

f = np.array(found)
print(f"n={n}: {len(f)} critical points from {nstart} starts, {time.time()-t0:.0f}s")
if len(f):
    pos = f[f[:,1] > 1e-6]
    zer = f[f[:,1] <= 1e-6]
    print(f"  Delta>0 : {len(pos):4d} points, lambda_max in [{pos[:,2].min():.6f}, {pos[:,2].max():.6f}]" if len(pos) else "  Delta>0 : none")
    print(f"  Delta=0 : {len(zer):4d} points, lambda_max in [{zer[:,2].min():.6f}, {zer[:,2].max():.6f}]" if len(zer) else "  Delta=0 : none")
    bad = f[(f[:,1] > 1e-6) & (f[:,2] <= 0.5+1e-9)]
    print(f"  Delta>0 AND lambda_max<=1/2 : {len(bad)}   <<< {'REFUTES V3' if len(bad) else 'none, V3 survives'}")
    bad2 = f[(f[:,1] <= 1e-6) & (f[:,2] <= 0.5+1e-9)]
    print(f"  Delta=0 AND lambda_max<=1/2 : {len(bad2)} (thetas {np.round(bad2[:,0],6) if len(bad2) else []})")
