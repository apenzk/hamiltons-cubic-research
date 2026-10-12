"""Reviewer 60, C6 part B: interrogate the high-theta two-4-plane points.
Is the m=8 theta=1.2238 point a genuine full-support witness or a degenerate limit?"""
import sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
import numpy as np
from scipy.optimize import minimize
from review_r60_core import *
from review_r60_q import theta
from review_r60_c6a import W4_general, stats

rng = np.random.default_rng(6062)


def build(m, p):
    a = p[:4*m].reshape(m, 4); b = p[4*m:8*m].reshape(m, 4)
    F1 = np.linalg.qr(a)[0]; F2 = np.linalg.qr(b)[0]
    q1, r1, q2, r2, s = np.exp(p[8*m:8*m+5])
    return W4_general(m, F1, q1, r1) + s * W4_general(m, F2, q2, r2)


def full_report(m, W, tag):
    lam, V = np.linalg.eigh(W); nrm = np.linalg.norm(W)
    ln = np.sort(lam) / nrm
    o = np.argsort(lam)
    r1 = np.linalg.matrix_rank(vec_to_mat(m, V[:, o[0]]), tol=1e-8)
    r2 = np.linalg.matrix_rank(vec_to_mat(m, V[:, o[1]]), tol=1e-8)
    dimU = np.linalg.matrix_rank(np.hstack([vec_to_mat(m, V[:, a]) for a in o[:2]]), tol=1e-8)
    supp = np.linalg.matrix_rank(sum(np.outer(v, v) for v in
                                     [vec_to_mat(m, V[:, a]).ravel() for a in o]), tol=1e-8)
    ric, bia, _ = is_weyl(m, W)
    print(f"  [{tag}] m={m} theta={theta(m,W):+.9f}  |W|={nrm:.6f} ric={ric:.1e} bia={bia:.1e}")
    print(f"    normalised eigenvalues < -1e-12 : {ln[ln < -1e-12]}")
    print(f"    two most negative               : {ln[0]:+.8f}, {ln[1]:+.8f}   ratio={ln[1]/ln[0]:.3e}")
    print(f"    rank(v_N)={r1} rank(v_(N-1))={r2}  dim U={dimU}")


print("=== maximise theta over the two-4-plane family, hard, with polishing ===")
for m in [6, 8, 10, 12]:
    recs = []
    for start in range(60):
        p0 = np.concatenate([rng.standard_normal(8*m), rng.standard_normal(5)*0.5])
        f = lambda p: -theta(m, build(m, p))
        r = minimize(f, p0, method="Nelder-Mead",
                     options=dict(maxiter=20000, maxfev=20000, fatol=1e-14, xatol=1e-12))
        r = minimize(f, r.x, method="Powell", options=dict(maxiter=20000, maxfev=20000))
        W = build(m, r.x)
        nneg, dimU, th, wl = stats(m, W)
        recs.append((th, dimU, nneg, W))
    recs.sort(key=lambda t: -t[0])
    print(f"\n m={m}: top 3 by theta")
    for th, dimU, nneg, W in recs[:3]:
        full_report(m, W, f"theta={th:+.6f} dimU={dimU} nneg={nneg}")
    # best with dimU == m specifically
    fs = [t for t in recs if t[1] == m]
    if fs:
        th, dimU, nneg, W = fs[0]
        print(f"  best FULL-SUPPORT (dimU={m}) point:")
        full_report(m, W, "full support")
    else:
        print(f"  no full-support (dimU={m}) point found in this family")
    print(f"  sqrt(3/2) = {np.sqrt(1.5):.9f}   theta_0({m}) = {(m-1)/m*np.sqrt(2*(m-2)/(m-1)):.9f}")
