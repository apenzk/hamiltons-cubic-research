"""D2 under (i) rotations inside degenerate eigenspaces, (ii) lam_g = 0."""
import sys; sys.path.insert(0,'scripts/reviewers/r293'); sys.path.insert(0,'scripts/lib')
import numpy as np, r293_d123 as r
from r293_points import catalogue
from scipy.stats import ortho_group

def quantities_with_basis(n, W, V):
    P = r.phi(n)
    v = np.einsum('ag,gij->aij', V.T, P)
    br = np.einsum('aik,bkj->abij', v, v) - np.einsum('bik,akj->abij', v, v)
    T = (0.5*np.einsum('abij,gij->abg', br, v))**2
    lam = np.diag(V.T @ W @ V)
    R = T.sum(axis=2)
    return lam, np.einsum('ga,a->g', R, lam**2), np.einsum('gab,ab->g', T, (lam[:,None]-lam[None,:])**2), np.einsum('gab,a,b->g', T, lam, lam)

rng = np.random.default_rng(3)
print("D2 residual under RANDOM rotations inside each degenerate eigenspace")
for n,W,lbl in catalogue():
    W = W/np.linalg.norm(W); th,res = r.crit_res(n,W)
    lam0, V0 = np.linalg.eigh(W)
    worst = 0.0; worst0 = 0.0
    for trial in range(5):
        V = V0.copy(); i = 0
        while i < len(lam0):
            j = i
            while j+1 < len(lam0) and abs(lam0[j+1]-lam0[i]) < 1e-9: j += 1
            k = j-i+1
            if k > 1:
                Qr = ortho_group.rvs(k, random_state=rng)
                V[:, i:j+1] = V[:, i:j+1] @ Qr
            i = j+1
        lam, M2, gg, Qg = quantities_with_basis(n, W, V)
        nz = np.abs(lam) > 1e-9
        worst = max(worst, np.abs(M2[nz]/(2*lam[nz]) + lam[nz] - gg[nz]/(4*lam[nz]) - th).max())
        z = ~nz
        if z.sum():
            worst0 = max(worst0, np.abs(M2[z] - gg[z]/2).max())
    print(f"  {lbl:20s} n={n:2d}  max|D2 res| over rotated bases = {worst:.2e}"
          f"   |M2 - g/2| on ker = {worst0:.2e}" if (np.abs(lam0)<=1e-9).sum() else
          f"  {lbl:20s} n={n:2d}  max|D2 res| over rotated bases = {worst:.2e}   (no kernel)")
