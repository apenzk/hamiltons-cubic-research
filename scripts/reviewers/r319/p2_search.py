"""Random critical points in Weyl_6 and Weyl_8: test post-40's bound off the structured catalogue."""
import sys; sys.path.insert(0,'scripts/reviewers/r319')
import numpy as np, build, core
from scipy.optimize import least_squares

n = int(sys.argv[1]) if len(sys.argv)>1 else 6
ntr = int(sys.argv[2]) if len(sys.argv)>2 else 200
A = build.Arena(n); N = A.N
Bs = core.weyl_basis(n); d = Bs.shape[0]
print(f"n={n} N={N} dim Weyl={d}", flush=True)
# check Q preserves Weyl
rng = np.random.default_rng(3190+n)
G = Bs.reshape(d, N*N)
for _ in range(3):
    x = rng.normal(size=d); W = np.einsum('d,dij->ij', x, Bs)
    QW = A.Q(W); proj = np.einsum('d,dij->ij', G @ QW.reshape(-1), Bs)
    print("   Q preserves Weyl residual:", np.linalg.norm(QW-proj), flush=True)

def resid(x):
    W = np.einsum('d,dij->ij', x, Bs)
    nrm = np.sqrt(np.sum(W*W))
    W = W/nrm
    th = A.P3(W)
    R = A.Q(W) - th*W
    return np.concatenate([G @ R.reshape(-1), [nrm-1.0]])

rows=[]
for t in range(ntr):
    x0 = rng.normal(size=d); x0 /= np.linalg.norm(x0)
    sol = least_squares(resid, x0, xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=3000)
    if np.linalg.norm(sol.fun) > 1e-10: continue
    W = np.einsum('d,dij->ij', sol.x, Bs); W = W/np.sqrt(np.sum(W*W))
    th = A.P3(W)
    if th < 1e-6: continue
    ev = np.linalg.eigvalsh(W); tol=1e-9
    rp = int((ev>tol).sum()); rm=int((ev<-tol).sum()); z = N-rp-rm
    bound = (2.0/n)*np.sqrt(rp*N/(N-rp)) if 0<rp<N else np.inf
    lam = (n-1)*abs(ev[0])
    rows.append((th, rp, rm, z, bound, lam))
rows.sort(key=lambda r:-r[0])
seen=[]
for th,rp,rm,z,bound,lam in rows:
    if any(abs(th-s)<1e-7 for s in seen): continue
    seen.append(th)
    print(f"theta={th:.9f} dimE+={rp:3d} dimE-={rm:3d} ker={z:3d} post40={bound:.6f} {'OK ' if th<=bound+1e-9 else 'FAIL'}"
          f"  (n-1)|lmin|={lam:.6f} {'OK' if th<=lam+1e-9 else 'FAIL'}  ratio th/lam={th/lam:.6f}", flush=True)
print("classes:", len(seen), "of", len(rows), "converged")
print("DONE")
