"""Reviewer 60, C6 part F: (1) an EXACT rational two-4-plane witness with theta > 0 at m=6,8,
refuting C6's 'each summand has theta<=0 so the sum does';
(2) how exact are the m=10 full-support n_neg<=2 candidates?"""
import sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
import numpy as np
from scipy.optimize import minimize
from review_r60_core import *
from review_r60_q import theta
from review_r60_c5 import W4_padded
from review_r60_c6a import W4_general

rng = np.random.default_rng(6066)
np.set_printoptions(linewidth=220)

print("=== 1. EXACT theta>0 two-4-plane witnesses (rational frames) ===")
def frame_from_rows(m, rows):
    F = np.array(rows, dtype=float).T
    return np.linalg.qr(F)[0]

# m=6: plane A = span(e0,e1,e2,e3); plane B = a rational 4-plane meeting A in a 2-plane, tilted
cands = []
for m in [6, 8]:
    A = np.eye(m)[:, :4]
    best = None
    for _ in range(20000):
        # rational-ish tilt of the second 4-plane
        M = rng.integers(-3, 4, size=(m, 4)).astype(float)
        if np.linalg.matrix_rank(M) < 4:
            continue
        B = np.linalg.qr(M)[0]
        q1, r1, q2, r2 = [np.round(v, 2) for v in rng.uniform(0.05, 1.0, 4)]
        s = float(np.round(rng.uniform(0.2, 3.0), 2))
        W = W4_general(m, A, q1, r1) + s * W4_general(m, B, q2, r2)
        lam, V = np.linalg.eigh(W); nrm = np.linalg.norm(W)
        if nrm < 1e-8: continue
        ls = np.sort(lam) / nrm
        nneg = int(np.sum(ls < -1e-10))
        if nneg > 2: continue
        o = np.argsort(lam)
        dU = np.linalg.matrix_rank(np.hstack([vec_to_mat(m, V[:, a]) for a in o[:2]]), tol=1e-8)
        th = theta(m, W / nrm)
        if dU == m and (best is None or th > best[0]):
            best = (th, nneg, dU, M.astype(int).tolist(), (q1, r1, q2, r2, s), W, ls)
    if best is None:
        print(f"  m={m}: none found"); continue
    th, nneg, dU, Mi, pars, W, ls = best
    ric, bia, sy = is_weyl(m, W)
    print(f"\n  m={m}  theta = {th:+.9f}   n_neg={nneg}   dim U={dU}={m}   (q1,r1,q2,r2,s)={pars}")
    print(f"    second 4-plane spanned by the integer columns {Mi}")
    print(f"    Ricci residual {ric:.2e}, Bianchi residual {bia:.2e}, symmetry {sy:.2e}")
    print(f"    normalised spectrum: {np.round(ls, 8)}")

print("\n=== 2. how exact are the m=10 full-support n_neg<=2 candidates? ===")
from review_r60_c6c import weyl_frame, mk, feas
for m in [8, 10]:
    Bm = weyl_frame(m)
    bestrec = None
    for _ in range(60):
        c = rng.standard_normal(Bm.shape[0])
        for it in range(4):
            r = minimize(lambda c: feas(m, Bm, c), c, jac=True, method="L-BFGS-B",
                         options=dict(maxiter=20000, ftol=0.0, gtol=0.0))
            c = r.x
        W = mk(m, Bm, c); W /= np.linalg.norm(W)
        lam, V = np.linalg.eigh(W); o = np.argsort(lam)
        extra = np.sort(lam)[2:]
        worst = extra.min()
        dU = np.linalg.matrix_rank(np.hstack([vec_to_mat(m, V[:, a]) for a in o[:2]]), tol=1e-8)
        if dU == m and (bestrec is None or worst > bestrec[0]):
            bestrec = (worst, r.fun, np.sort(lam), dU)
    worst, resid, ls, dU = bestrec
    print(f"\n  m={m}: best full-support candidate, dim U={dU}")
    print(f"    penalty residual   : {resid:.3e}")
    print(f"    most negative of the eigenvalues BEYOND the top two: {worst:.3e}")
    print(f"    (an exact witness needs this to be 0; ~1e-8 means an asymptotic near-miss)")
    print(f"    spectrum: {np.array2string(ls, precision=10)}")

# 3. the padded witnesses, for contrast: their extra eigenvalues are EXACTLY zero
print("\n=== 3. contrast: the exact padded two-4-plane witnesses ===")
for m, pl2 in [(6, (2,3,4,5)), (8, (4,5,6,7))]:
    W = W4_padded(m, (0,1,2,3), 0.5, 0.5) + W4_padded(m, pl2, 0.5, 0.5)
    lam = np.sort(np.linalg.eigvalsh(W))
    print(f"  m={m}: most negative beyond the top two = {lam[2]:.3e}   (theta={theta(m,W):+.9f})")
