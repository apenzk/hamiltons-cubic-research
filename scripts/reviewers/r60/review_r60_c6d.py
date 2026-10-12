"""Reviewer 60, C6 part D: CERTIFY a full-support 2-negative Weyl_m witness with a STRICT
interior SDP -- max lambda_min of G on {y,z}^perp.  Strictly positive => robust witness."""
import sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
import numpy as np, cvxpy as cp
from scipy.optimize import minimize
from review_r60_core import *
from review_r60_q import theta
from review_r60_c6c import weyl_frame, mk, feas

rng = np.random.default_rng(6064)


def find_raw(m, Bm, tries=200):
    """penalised search for W in Weyl_m with n_neg<=2; return the best few"""
    out = []
    for _ in range(tries):
        c = rng.standard_normal(Bm.shape[0])
        r = minimize(lambda c: feas(m, Bm, c), c, jac=True, method="L-BFGS-B",
                     options=dict(maxiter=6000, ftol=1e-20, gtol=1e-16))
        if r.fun < 1e-13:
            W = mk(m, Bm, r.x); W /= np.linalg.norm(W)
            out.append((r.fun, W))
    out.sort(key=lambda t: t[0])
    return out


def certify(m, B, y, z, b, c_):
    """max lambda_min(G) on {y,z}^perp over W in Weyl_m with Wy=-b y, Wz=-c z, |W|_F<=1."""
    D = y.shape[0]
    P = np.linalg.qr(np.column_stack([y, z]))[0]
    Qp = np.eye(D) - P @ P.T
    u, s, vt = np.linalg.svd(Qp); K = u[:, :D-2]          # orthonormal basis of {y,z}^perp
    co = cp.Variable(len(B))
    W = sum(co[k] * B[k] for k in range(len(B)))
    t = cp.Variable()
    G = W + b * np.outer(y, y) + c_ * np.outer(z, z)
    cons = [W @ y == -b * y, W @ z == -c_ * z,
            K.T @ G @ K >> t * np.eye(D - 2),
            cp.norm(co, 2) <= 1.0]
    pr = cp.Problem(cp.Maximize(t), cons)
    pr.solve(solver=cp.SCS, eps=1e-10, max_iters=400000)
    if co.value is None:
        return pr.status, None, None
    Wv = sum(co.value[k] * B[k] for k in range(len(B)))
    return pr.status, float(t.value), Wv


for m in [6, 8, 10, 12]:
    print(f"\n########## m={m} ##########")
    Bm = weyl_frame(m); B = weyl_basis(m)
    raw = find_raw(m, Bm, tries=(200 if m <= 8 else 60))
    print(f"  penalised search: {len(raw)} starts reached residual < 1e-13")
    if not raw:
        print("  -> nothing found; stratum may be empty or very thin here")
        continue
    done = 0
    for resid, W in raw:
        lam, V = np.linalg.eigh(W); o = np.argsort(lam)
        y, z = V[:, o[0]], V[:, o[1]]
        b, c_ = -lam[o[0]], -lam[o[1]]
        if c_ <= 1e-6:
            continue
        dimU = np.linalg.matrix_rank(np.hstack([vec_to_mat(m, V[:, a]) for a in o[:2]]), tol=1e-7)
        if dimU < m:
            continue
        st, tval, Wc = certify(m, B, y, z, b, c_)
        if Wc is None:
            print(f"  SDP status {st}")
            continue
        lam2, V2 = np.linalg.eigh(Wc); nrm = np.linalg.norm(Wc)
        lam2s = np.sort(lam2) / nrm
        o2 = np.argsort(lam2)
        d2 = np.linalg.matrix_rank(np.hstack([vec_to_mat(m, V2[:, a]) for a in o2[:2]]), tol=1e-7)
        ric, bia, sy = is_weyl(m, Wc)
        nneg = int(np.sum(lam2s < -1e-9))
        print(f"  CERTIFIED  strict margin t = {tval:+.3e}   -> n_neg={nneg} dim U={d2} "
              f"rank(v_N)={np.linalg.matrix_rank(vec_to_mat(m, V2[:, o2[0]]), tol=1e-7)} "
              f"theta={theta(m, Wc/nrm):+.6f} ric={ric:.1e} bia={bia:.1e}")
        print(f"    normalised eigenvalues: {np.round(lam2s, 6)}")
        done += 1
        if done >= 2:
            break
