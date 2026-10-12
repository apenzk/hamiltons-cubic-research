"""Build the SO(3)-diagonal-invariant critical points in Weyl_6 (Jensen's point) and test the four claims there."""
import sys; sys.path.insert(0,'scripts/reviewers/r319')
import numpy as np, build, core
from scipy.optimize import least_squares

n = 6
A = build.Arena(n); N = A.N
Bs = core.weyl_basis(n); d = Bs.shape[0]
G = Bs.reshape(d, N*N)

# so(3) diagonal in so(3)+so(3) < so(6)
L = np.zeros((3, n, n))
for k, (i, j) in enumerate([(1,2),(2,0),(0,1)]):
    L[k][i,j] = 1.0; L[k][j,i] = -1.0
    L[k][i+3,j+3] = 1.0; L[k][j+3,i+3] = -1.0
_, Bso = core.so_basis(n)
gens = [np.array([0.5*np.sum(L[k]*Bso[a]) for a in range(N)]) for k in range(3)]

rows = []
for g in gens:
    M = A.ad(g)
    for t in range(d):
        Wt = Bs[t]
        rows.append((G @ (M @ Wt - Wt @ M).reshape(-1)))
Mm = np.array(rows).reshape(3*d, d) if False else np.array(rows)
# rows built wrong shape; rebuild properly: linear map on coefficient space
Lmaps = []
for g in gens:
    M = A.ad(g)
    T = np.zeros((d, d))
    for t in range(d):
        Wt = Bs[t]
        T[:, t] = G @ (M @ Wt - Wt @ M).reshape(-1)
    Lmaps.append(T)
Stack = np.vstack(Lmaps)
U, S, Vh = np.linalg.svd(Stack)
rk = int((S > S[0]*1e-10).sum())
inv = Vh[rk:]                          # (dinv, d)
print("dim Weyl_6 =", d, " dim so(3)_diag-invariants =", inv.shape[0], flush=True)

dinv = inv.shape[0]
def W_of(y):
    x = inv.T @ y
    return np.einsum('t,tij->ij', x, Bs)

def resid(y):
    W = W_of(y); nrm = np.sqrt(np.sum(W*W)); W = W/nrm
    th = A.P3(W); R = A.Q(W) - th*W
    return np.concatenate([inv @ (G @ R.reshape(-1)), [nrm-1.0]])

rng = np.random.default_rng(7)
found = []
for t in range(400):
    y0 = rng.normal(size=dinv)
    sol = least_squares(resid, y0, xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=3000)
    if np.linalg.norm(sol.fun) > 1e-11: continue
    W = W_of(sol.x); W = W/np.sqrt(np.sum(W*W))
    th = A.P3(W)
    if th <= 1e-8: continue
    if any(abs(th-f) < 1e-8 for f in found): continue
    found.append(th)
    ev = np.linalg.eigvalsh(W)
    rp = int((ev>1e-9).sum()); rm = int((ev<-1e-9).sum()); z = N-rp-rm
    bd = (2.0/n)*np.sqrt(rp*N/(N-rp)) if 0<rp<N else np.inf
    # support dimension
    idx = {p:a for a,p in enumerate(A.P)}
    def R(i,j,k,l):
        if i==j or k==l: return 0.0
        s=1.0
        if i>j: i,j=j,i; s=-s
        if k>l: k,l=l,k; s=-s
        return s*W[idx[(i,j)],idx[(k,l)]]
    Tm = np.array([[sum(R(i,j,k,l)*R(p,j,k,l) for j in range(n) for k in range(n) for l in range(n))
                    for p in range(n)] for i in range(n)])
    supp = int((np.linalg.eigvalsh(Tm)>1e-9).sum())
    np.save(f'scripts/reviewers/r319/jensen_theta{th:.6f}.npy', W)
    print(f"theta={th:.9f}  sqrt(6/5)={np.sqrt(1.2):.9f}  spectrum(unique)={np.round(np.unique(np.round(ev,9)),6)}"
          f"  mult={[int((np.abs(ev-u)<1e-9).sum()) for u in np.unique(np.round(ev,9))]}"
          f"  dimE+={rp} dimE-={rm} ker={z} supp={supp}"
          f"  post40={bd:.6f} {'HOLDS' if th<=bd+1e-9 else 'FAILS'}"
          f"  (n-1)|lmin|={(n-1)*abs(ev[0]):.6f}", flush=True)
print("DONE")
