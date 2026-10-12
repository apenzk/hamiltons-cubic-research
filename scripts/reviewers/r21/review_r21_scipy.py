"""Reviewer 21 (a): a THIRD optimiser -- scipy L-BFGS-B on the unconstrained
parametrisation (normalise inside the objective) -- as a cross-check on the
alternating global trust-region solves.  Usage: n nstarts t ..."""
import sys, time
import numpy as np
from scipy.optimize import minimize
from review_r21_core import Setup, unit

n = int(sys.argv[1]); NS = int(sys.argv[2]); ts = [float(x) for x in sys.argv[3:]]
A_SUP = np.sqrt(5/6)
S = Setup(n).precompute()
d1, dk = S.d13, S.dker
rng = np.random.default_rng(777)
y1A = np.load(f"/tmp/r21_y1A_{n}.npy"); y2A = np.load(f"/tmp/r21_y2A_{n}.npy")
y2B = np.load(f"/tmp/r21_y2B_{n}.npy"); y1B = np.load(f"/tmp/r21_y1B_{n}.npy")

def fg(z, t):
    a1, a2 = z[:d1], z[d1:]
    n1, n2 = np.linalg.norm(a1), np.linalg.norm(a2)
    y1, y2 = a1/n1, a2/n2
    W1, K = S.mat13(y1), S.matker(y2)
    qk, q1 = S.q_ker(W1), S.q_13(K)
    fk = S.f_ker(W1, K); f1 = S.f_13(W1, K)
    A = float(qk @ y2); B = float(q1 @ y1)
    val = A + t*B
    g1 = 2*f1 + t*q1
    g2 = qk + 2*t*fk
    G1 = (g1 - (g1@y1)*y1)/n1
    G2 = (g2 - (g2@y2)*y2)/n2
    return -val, -np.concatenate([G1, G2])

print(f"  {'t':>8} {'best A+tB':>14} {'-supA':>11} {'A':>13} {'B':>13}", flush=True)
for t in ts:
    best = (-9e9, None)
    starts = [np.concatenate([y1A, y2A]), np.concatenate([y1B, y2B]),
              np.concatenate([y1A, y2B]), np.concatenate([y1B, y2A])]
    for _ in range(NS):
        starts.append(np.concatenate([rng.normal(size=d1), rng.normal(size=dk)]))
    for z0 in starts:
        r = minimize(fg, z0, args=(t,), jac=True, method='L-BFGS-B',
                     options=dict(maxiter=800, ftol=1e-16, gtol=1e-12))
        if -r.fun > best[0]:
            best = (-r.fun, r.x)
    z = best[1]; y1 = unit(z[:d1]); y2 = unit(z[d1:])
    W1, K = S.mat13(y1), S.matker(y2)
    A = float(S.q_ker(W1) @ y2); B = float(S.q_13(K) @ y1)
    print(f"  {t:>8.5f} {best[0]:>14.10f} {best[0]-A_SUP:>+11.2e} {A:>13.9f} {B:>13.9f}", flush=True)
