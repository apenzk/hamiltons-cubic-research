"""Reviewer 60, C4: try to BUILD a Weyl_m tensor whose minority-side eigenvector is
nondegenerate, at m=6 and m=8.  Exact SDP feasibility for fixed x, plus a nonlinear hunt."""
import sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
import numpy as np, cvxpy as cp
from review_r60_core import *
from review_r60_c3 import block_x, collapse

rng = np.random.default_rng(604)


def weyl_param(m):
    B = weyl_basis(m)
    return B


def sdp_one_sided(m, B, xhat, sign=+1, verbose=False):
    """Is there W in Weyl_m with W xhat = sign*xhat and exactly one eigenvalue of that sign?
    sign=+1: W <= xhat xhat^T   (one positive).  sign=-1: W >= -xhat xhat^T (one negative)."""
    D = xhat.shape[0]
    c = cp.Variable(len(B))
    W = sum(c[k] * B[k] for k in range(len(B)))
    P = np.outer(xhat, xhat)
    cons = [W @ xhat == sign * xhat]
    cons += [(P - W if sign > 0 else W + P) >> 0]
    prob = cp.Problem(cp.Minimize(cp.sum_squares(c) * 0), cons)
    try:
        prob.solve(solver=cp.SCS, eps=1e-9, max_iters=200000, verbose=verbose)
    except Exception as e:
        return "error", None
    if prob.status in ("infeasible", "infeasible_inaccurate"):
        return prob.status, None
    if c.value is None:
        return prob.status, None
    Wv = sum(c.value[k] * B[k] for k in range(len(B)))
    return prob.status, Wv


def report(m, B, x, tag, sign=+1):
    xv = mat_to_vec(m, x); xv = xv / np.linalg.norm(xv)
    st, Wv = sdp_one_sided(m, B, xv, sign)
    line = f"  m={m} sign={sign:+d} rank(x)={np.linalg.matrix_rank(x):2d} {tag:44s} -> {st}"
    if Wv is not None:
        ev = np.linalg.eigvalsh(Wv)
        ric, bia, sy = is_weyl(m, Wv)
        npos = int(np.sum(ev > 1e-6 * max(1, abs(ev).max())))
        nneg = int(np.sum(ev < -1e-6 * max(1, abs(ev).max())))
        line += (f"  |W|={np.linalg.norm(Wv):.4f} (npos,nneg)=({npos},{nneg}) "
                 f"ric={ric:.1e} bia={bia:.1e} eigatx={xv @ Wv @ xv:+.4f}")
    print(line)
    return st, Wv


for m in [6, 8]:
    print(f"\n=== m={m}: exact SDP feasibility, fixed minority eigenvector ===")
    B = weyl_param(m)
    print(f"  dim Weyl_{m} = {len(B)}")
    # (i) CONTROL: x = complex structure on a 4-plane (degenerate) -- should be FEASIBLE
    xc = np.zeros((m, m)); xc[0,1]=1; xc[1,0]=-1; xc[2,3]=1; xc[3,2]=-1
    report(m, B, xc, "CONTROL: cx structure on a 4-plane (degenerate)", sign=-1)
    report(m, B, xc, "CONTROL: cx structure on a 4-plane (degenerate)", sign=+1)
    # (ii) nondegenerate x, every multiplicity pattern + random
    from review_r60_c3 import partitions
    for part in partitions(m // 2):
        al = np.sort(rng.uniform(0.5, 3.0, len(part)))[::-1]
        x = block_x(m, part, al)
        G = np.linalg.qr(rng.standard_normal((m, m)))[0]; x = G @ x @ G.T
        report(m, B, x, f"nondegenerate, pattern {part}", sign=+1)
        report(m, B, x, f"nondegenerate, pattern {part}", sign=-1)
    # (iii) x a complex structure on all of R^m (nondegenerate, most symmetric)
    xJ = np.zeros((m, m))
    for j in range(m // 2):
        xJ[2*j, 2*j+1] = 1; xJ[2*j+1, 2*j] = -1
    report(m, B, xJ, "nondegenerate: complex structure on R^m", sign=+1)
    report(m, B, xJ, "nondegenerate: complex structure on R^m", sign=-1)
    # (iv) random nondegenerate draws
    hits = 0
    for t in range(8):
        x = rng.standard_normal((m, m)); x = x - x.T
        st, Wv = report(m, B, x, f"random nondegenerate #{t}", sign=+1)
        if Wv is not None and np.linalg.norm(Wv) > 1e-6:
            hits += 1
    print(f"  random nondegenerate hits with |W|>1e-6: {hits}/8")
