"""Is every two-eigenvalue critical Weyl operator a subalgebra Casimir?
Search over Grassmannian of E_+ at n=6."""
import sys; sys.path.insert(0,'scripts/reviewers/r319')
import numpy as np, build, core
from scipy.optimize import least_squares
from itertools import combinations

n = 6
A = build.Arena(n); N = A.N
quads = list(combinations(range(n),4))
idx = {p:a for a,p in enumerate(A.P)}
def Rt(W,i,j,k,l):
    if i==j or k==l: return 0.0
    s=1.0
    if i>j: i,j=j,i; s=-s
    if k>l: k,l=l,k; s=-s
    return s*W[idx[(i,j)],idx[(k,l)]]

def make_W(x, r):
    M = x.reshape(N, r)
    Qm, _ = np.linalg.qr(M)
    Pi = Qm @ Qm.T
    Wr = Pi - (r/N)*np.eye(N)
    nrm = np.sqrt(np.sum(Wr*Wr))
    return Wr/nrm, Qm

def resid(x, r):
    W, _ = make_W(x, r)
    th = A.P3(W)
    R = A.Q(W) - th*W
    out = [R[np.triu_indices(N)]]
    out.append(A.ricci(W).reshape(-1))
    out.append(np.array([Rt(W,i,j,k,l)+Rt(W,i,k,l,j)+Rt(W,i,l,j,k) for (i,j,k,l) in quads]))
    return np.concatenate(out)

def subalg_defect(Qm, r):
    P = Qm @ Qm.T
    ev, evec = np.linalg.eigh(np.eye(N)-P)
    mb = evec[:, ev>0.5].T
    c = A.c
    T = np.einsum('abc,ia,jb,kc->ijk', c, Qm.T, Qm.T, mb, optimize=True)
    return float(np.sum(T**2))

rng = np.random.default_rng(319)
found = []
for r in range(1, N):
    best = None
    for trial in range(60):
        x0 = rng.normal(size=N*r)
        sol = least_squares(resid, x0, args=(r,), xtol=1e-14, ftol=1e-14, gtol=1e-14, max_nfev=4000)
        rn = np.linalg.norm(sol.fun)
        if rn < 1e-9:
            W, Qm = make_W(sol.x, r)
            th = A.P3(W)
            d = subalg_defect(Qm, r)
            found.append((r, th, d))
            if best is None or d > best[2]:
                best = (r, th, d)
    if best:
        print(f"r={r:2d}  solutions={sum(1 for f in found if f[0]==r):3d}  theta={best[1]:.9f}  max subalgebra-defect={best[2]:.3e}", flush=True)
    else:
        print(f"r={r:2d}  no two-eigenvalue critical point found", flush=True)
print("DONE")
