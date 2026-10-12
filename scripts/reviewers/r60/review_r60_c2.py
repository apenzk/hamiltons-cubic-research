"""Reviewer 60, C2: is N_v = 2 v(x)v - ad(v)^2 PSD with ker = v^perp cap z(v)?
And does N_x = N_y + N_z really follow for rank-3 signature (1,2)?"""
import sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
import numpy as np
from review_r60_core import *

rng = np.random.default_rng(602)

print("--- N_v spectrum and kernel ---")
for m in [4, 5, 6, 7, 8]:
    D = m * (m - 1) // 2
    for trial in range(3):
        v = rng.standard_normal((m, m)); v = v - v.T
        N = N_of(m, v)
        ev = np.linalg.eigvalsh(N)
        # is ad(v)^2 negative semidefinite? (ad(v) skew wrt the invariant inner product)
        A = ad_of(m, v)
        skewerr = np.abs(A + A.T).max()
        # predicted kernel: v^perp cap z(v)
        vv = mat_to_vec(m, v)
        Z = np.vstack([A, vv[None, :]])            # ad(v)u=0 and <u,v>=0
        kdim_pred = D - np.linalg.matrix_rank(Z, tol=1e-9)
        kdim = int(np.sum(np.abs(ev) < 1e-9 * max(1, abs(ev).max())))
        if trial == 0:
            print(f"m={m} lam_min(N_v)={ev[0]:+.3e}  |ad(v)+ad(v)^T|={skewerr:.1e} "
                  f"dim ker N_v={kdim} predicted={kdim_pred}")
        assert ev[0] > -1e-9 * max(1, abs(ev).max())
        assert kdim == kdim_pred

print("\n--- N_x = N_y + N_z for a rank-3 signature (1,2) Weyl tensor (if one exists) ---")
# build a rank-3 Weyl tensor by projecting: search m=4 where they are known to exist
for m in [4]:
    B = weyl_basis(m)
    # W4 family from C5: self-dual 2-forms
    def sd(m):
        # self-dual basis on R^4
        w = []
        for (a, b) in [((0,1),(2,3)), ((0,2),(3,1)), ((0,3),(1,2))]:
            X = phi(m,*a) + phi(m,*b)
            w.append(X / np.sqrt(ip(X, X)))
        return w
    W1, W2, W3 = sd(4)
    q, r = 0.3, 0.5
    vecs = [mat_to_vec(4, X) for X in (W1, W2, W3)]
    W = (-(q + r) * np.outer(vecs[0], vecs[0]) + q * np.outer(vecs[1], vecs[1])
         + r * np.outer(vecs[2], vecs[2]))
    print("  ric,bianchi,sym err:", ["%.1e" % e for e in is_weyl(4, W)])
    lam, V = np.linalg.eigh(W)
    print("  spectrum:", np.round(lam, 6))
    pos = [a for a in range(len(lam)) if lam[a] > 1e-10]
    neg = [a for a in range(len(lam)) if lam[a] < -1e-10]
    print("  n_pos,n_neg =", len(pos), len(neg))
    if len(neg) == 1 and len(pos) == 2:
        x = vec_to_mat(4, np.sqrt(-lam[neg[0]]) * V[:, neg[0]])
        ys = [vec_to_mat(4, np.sqrt(lam[a]) * V[:, a]) for a in pos]
        Nx = N_of(4, x); Nsum = sum(N_of(4, y) for y in ys)
        # signature (2,1): the identity reads N_x = N_y + N_z with roles swapped in sign
        print("  |N_x - (N_y+N_z)| =", np.abs(Nx - Nsum).max())
