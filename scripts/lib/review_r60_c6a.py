"""Reviewer 60, C6 part A: is theta <= 0 really forced for the two-4-plane construction?
Broad sweep over (q,r) per summand and over the relative position of the two 4-planes."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from review_r60_core import *
from review_r60_q import theta
from review_r60_c5 import W4_padded, selfdual

TOL = 1e-9
rng = np.random.default_rng(606)


def W4_general(m, F, q, r):
    """F: m x 4 orthonormal frame spanning the 4-plane; W4(q,r) transported onto it."""
    w = selfdual(4, (0, 1, 2, 3))
    v = [mat_to_vec(m, F @ X @ F.T) for X in w]
    nrms = [np.linalg.norm(u) for u in v]
    v = [u / n for u, n in zip(v, nrms)]
    return (-(q + r) * np.outer(v[0], v[0]) + q * np.outer(v[1], v[1]) + r * np.outer(v[2], v[2]))


def stats(m, W):
    lam, V = np.linalg.eigh(W)
    sc = max(1.0, abs(lam).max())
    nneg = int(np.sum(lam < -TOL * sc))
    o = np.argsort(lam)
    dimU = np.linalg.matrix_rank(np.hstack([vec_to_mat(m, V[:, a]) for a in o[:2]]), tol=1e-8)
    return nneg, dimU, theta(m, W), is_weyl(m, W)


print("=== random 4-planes in general position, random (q_i, r_i) > 0 ===")
best = {}
for m in [5, 6, 7, 8, 9, 10]:
    bt = -9.0; brec = None
    for trial in range(4000):
        F1 = np.linalg.qr(rng.standard_normal((m, 4)))[0]
        F2 = np.linalg.qr(rng.standard_normal((m, 4)))[0]
        q1, r1, q2, r2 = rng.uniform(0.02, 1.0, 4)
        s = rng.choice([1.0, rng.uniform(0.1, 3.0)])
        W = W4_general(m, F1, q1, r1) + s * W4_general(m, F2, q2, r2)
        if np.linalg.norm(W) < 1e-8: continue
        nneg, dimU, th, wl = stats(m, W)
        if nneg <= 2 and th > bt:
            bt = th; brec = (nneg, dimU, th, max(wl[0], wl[1]))
    print(f"  m={m}: best theta over n_neg<=2 draws = {bt:+.6f}   (n_neg,dimU,theta,weylerr)={brec}")
    best[m] = bt

print("\n=== local optimisation: maximise theta over (frames, q, r) with n_neg<=2 ===")
from scipy.optimize import minimize

def build(m, p):
    a = p[:4*m].reshape(m, 4); b = p[4*m:8*m].reshape(m, 4)
    F1 = np.linalg.qr(a)[0]; F2 = np.linalg.qr(b)[0]
    q1, r1, q2, r2, s = np.exp(p[8*m:8*m+5])
    return W4_general(m, F1, q1, r1) + s * W4_general(m, F2, q2, r2)

for m in [6, 8, 10]:
    bt = -9.0; bw = None
    for start in range(30):
        p0 = np.concatenate([rng.standard_normal(8*m), rng.standard_normal(5)*0.5])
        f = lambda p: -theta(m, build(m, p))
        res = minimize(f, p0, method="Nelder-Mead",
                       options=dict(maxiter=6000, maxfev=6000, fatol=1e-12, xatol=1e-10))
        W = build(m, res.x)
        nneg, dimU, th, wl = stats(m, W)
        if nneg <= 2 and th > bt:
            bt = th; bw = (nneg, dimU, th, max(wl[0], wl[1]))
    print(f"  m={m}: best theta with n_neg<=2 = {bt:+.6f}  (n_neg,dimU,theta,weylerr)={bw}")
