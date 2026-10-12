"""Reviewer 60, C6 part E: turn the numerical n_neg<=2 witnesses into EXACT ones.
The converged W has a large kernel K; {W' in Weyl_m : W' K = 0} is an exact linear subspace,
so any element of it has that kernel exactly and its spectrum can be read off with no residual."""
import sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
import numpy as np
from scipy.optimize import minimize
from review_r60_core import *
from review_r60_q import theta
from review_r60_c6c import weyl_frame, mk, feas

rng = np.random.default_rng(6065)


def kernel_locked(m, B, K):
    """orthonormal basis of {W in Weyl_m : W K = 0}, K an orthonormal D x k matrix"""
    D = K.shape[0]
    A = np.array([(X @ K).ravel() for X in B])           # len(B) x (D*k)
    u, s, vt = np.linalg.svd(A, full_matrices=True)
    r = int(np.sum(s > 1e-9 * max(s[0], 1.0)))
    out = []
    for row in vt[r:] if False else np.linalg.svd(A.T, full_matrices=True)[0][:, :0]:
        pass
    # nullspace of A^T acting on coefficient vectors: we need coeff c with A^T? -- careful:
    # W = sum c_k B_k, constraint sum_k c_k (B_k K) = 0  ->  A^T c = 0 with A as above (rows=k index)
    u2, s2, vt2 = np.linalg.svd(A.T @ A)
    r2 = int(np.sum(s2 > 1e-9 * max(s2[0], 1.0)))
    N = vt2[r2:]
    res = []
    for row in N:
        W = sum(row[k] * B[k] for k in range(len(B)))
        n = np.linalg.norm(W)
        if n > 1e-8:
            res.append(W / n)
    return res


def summarise(m, W, tag):
    lam, V = np.linalg.eigh(W); nrm = np.linalg.norm(W)
    ls = np.sort(lam) / nrm; o = np.argsort(lam)
    nneg = int(np.sum(ls < -1e-11))
    dimU = np.linalg.matrix_rank(np.hstack([vec_to_mat(m, V[:, a]) for a in o[:2]]), tol=1e-8)
    rN = np.linalg.matrix_rank(vec_to_mat(m, V[:, o[0]]), tol=1e-8)
    ric, bia, _ = is_weyl(m, W)
    print(f"    [{tag}] n_neg={nneg} dimU={dimU} rank(v_N)={rN} theta={theta(m, W/nrm):+.9f} "
          f"ric={ric:.1e} bia={bia:.1e}")
    print(f"      spectrum/|W| : {np.array2string(ls, precision=9, max_line_width=200)}")
    return nneg, dimU, rN


for m in [6, 8, 10, 12]:
    print(f"\n########## m={m} ##########")
    Bm = weyl_frame(m); B = weyl_basis(m); D = m*(m-1)//2
    hits = []
    for _ in range(120 if m <= 8 else 40):
        c = rng.standard_normal(Bm.shape[0])
        r = minimize(lambda c: feas(m, Bm, c), c, jac=True, method="L-BFGS-B",
                     options=dict(maxiter=8000, ftol=1e-20, gtol=1e-16))
        if r.fun > 1e-13:
            continue
        W = mk(m, Bm, r.x); W /= np.linalg.norm(W)
        lam, V = np.linalg.eigh(W)
        ker = V[:, np.abs(lam) < 1e-5]
        if ker.shape[1] == 0:
            continue
        fam = kernel_locked(m, B, ker)
        if not fam:
            continue
        # take the element of the exact family closest to the numerical W
        co = np.array([float(np.sum(W * X)) for X in fam])
        We = sum(co[k] * fam[k] for k in range(len(fam)))
        We /= np.linalg.norm(We)
        hits.append((ker.shape[1], len(fam), We))
    print(f"  {len(hits)} exact kernel-locked families built")
    seen = 0
    for kdim, fdim, We in hits:
        nneg, dimU, rN = summarise(m, We, f"kernel dim {kdim}, family dim {fdim}")
        seen += 1
        if seen >= 3:
            break
    good = [h for h in hits if True]
    # report the best theta among exact witnesses with n_neg==2 and dim U == m
    best = None
    for kdim, fdim, We in hits:
        lam, V = np.linalg.eigh(We); o = np.argsort(lam); ls = np.sort(lam)/np.linalg.norm(We)
        if int(np.sum(ls < -1e-11)) != 2:
            continue
        dU = np.linalg.matrix_rank(np.hstack([vec_to_mat(m, V[:, a]) for a in o[:2]]), tol=1e-8)
        if dU != m:
            continue
        th = theta(m, We/np.linalg.norm(We))
        if best is None or th > best[0]:
            best = (th, kdim, fdim, np.linalg.matrix_rank(vec_to_mat(m, V[:, o[0]]), tol=1e-8))
    print(f"  best EXACT full-support (dim U = {m}) n_neg=2 witness: "
          f"{'none' if best is None else f'theta={best[0]:+.9f} kerdim={best[1]} famdim={best[2]} rank(v_N)={best[3]}'}")
