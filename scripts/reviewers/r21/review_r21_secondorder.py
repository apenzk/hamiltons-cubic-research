"""Reviewer 21: the exact second-order bifurcation threshold of the joint frontier.

At the A-maximiser (W1*, K*) both A and B are critical (dA = 0 because it is a
max; dB = 0 measured), and B = 0.  So the corner stays the maximiser of A + tB
exactly while the quadratic form t*Hess(B) - (-Hess(A)) stays negative
semidefinite on the tangent space of S(V13) x S(ker).  The threshold

    t* = min { t > 0 : lambda_max( t Hess(B) + Hess(A) ) > 0 }

is the exact t at which B leaves 0 -- computed here rather than sampled on a
grid of six weights.
"""
import sys, time
import numpy as np
from review_r21_core import Setup, unit
from review_r21_frontier import A_SUP, maximize_A, AB

n = int(sys.argv[1])
t0 = time.time()
S = Setup(n)
try:
    y1 = np.load(f"/tmp/r21_y1A_{n}.npy"); y2 = np.load(f"/tmp/r21_y2A_{n}.npy")
    print("  (loaded cached A-maximiser)", flush=True)
except Exception:
    va, y1 = maximize_A(S, restarts=25, iters=200, seed=7)
    y2 = unit(S.q_ker(S.mat13(y1)))
W1, K = S.mat13(y1), S.matker(y2)
a, b = AB(S, y1, y2)
print(f"[{time.time()-t0:6.1f}s] A-maximiser: A={a:.12f} B={b:.3e}", flush=True)

G13 = S.block_fast(K, S.V13, S.V13)        # T(x_i, x_j, K*)
print(f"[{time.time()-t0:6.1f}s] G13 built", flush=True)
Gmix = S.block_fast(W1, S.Vker, S.V13)     # [i,j] = T(W1*, x_j, y_i)
print(f"[{time.time()-t0:6.1f}s] Gmix built", flush=True)
Gker = S.block_fast(W1, S.Vker, S.Vker)    # T(W1*, y_i, y_j)
print(f"[{time.time()-t0:6.1f}s] Gker built", flush=True)
Gmix2 = S.block_fast(K, S.V13, S.Vker)     # [i,j] = T(x_i, K*, y_j)
print(f"[{time.time()-t0:6.1f}s] Gmix2 built", flush=True)
G13 = 0.5 * (G13 + G13.T); Gker = 0.5 * (Gker + Gker.T)

d1, dk = S.d13, S.dker
HA = np.zeros((d1 + dk, d1 + dk))
HA[:d1, :d1] = G13 - a * np.eye(d1)
HA[d1:, :d1] = Gmix
HA[:d1, d1:] = Gmix.T
HA[d1:, d1:] = -0.5 * a * np.eye(dk)
HB = np.zeros((d1 + dk, d1 + dk))
HB[:d1, d1:] = Gmix2
HB[d1:, :d1] = Gmix2.T
HB[d1:, d1:] = Gker

# tangent space: x perp y1 in V13-coords, y perp y2 in ker-coords
def tangent_basis(v):
    d = len(v)
    Q, _ = np.linalg.qr(np.column_stack([v, np.eye(d)]))
    return Q[:, 1:d]
T1 = tangent_basis(y1); Tk = tangent_basis(y2)
Tb = np.zeros((d1 + dk, T1.shape[1] + Tk.shape[1]))
Tb[:d1, :T1.shape[1]] = T1
Tb[d1:, T1.shape[1]:] = Tk
HAt = Tb.T @ HA @ Tb; HBt = Tb.T @ HB @ Tb
HAt = 0.5*(HAt+HAt.T); HBt = 0.5*(HBt+HBt.T)
print(f"[{time.time()-t0:6.1f}s] tangent dim {HAt.shape[0]}", flush=True)

wA = np.linalg.eigvalsh(HAt)
print(f"  Hess(A) on the tangent: max eig {wA[-1]:+.6e}  min eig {wA[0]:+.6e}"
      f"   -> {'PSD-negative (a genuine max)' if wA[-1] < 1e-9 else 'NOT a local max!'}", flush=True)
nflat = int(np.sum(wA > -1e-9))
print(f"  flat directions of A (|eig| < 1e-9): {nflat}", flush=True)

# H_B on the flat directions of A
wA_all, VA = np.linalg.eigh(HAt)
flat = VA[:, wA_all > -1e-9]
if flat.shape[1]:
    Bflat = flat.T @ HBt @ flat
    wf = np.linalg.eigvalsh(0.5*(Bflat+Bflat.T))
    print(f"  Hess(B) restricted to A's flat directions: max eig {wf[-1]:+.6e}, min {wf[0]:+.6e}", flush=True)
    if wf[-1] > 1e-9:
        print("  *** B grows at second order along a direction where A is flat -> t* = 0 ***", flush=True)

wB = np.linalg.eigvalsh(HBt)
print(f"  Hess(B) on the tangent: max eig {wB[-1]:+.6e}  min eig {wB[0]:+.6e}", flush=True)

def lam_max(t):
    return float(np.linalg.eigvalsh(t * HBt + HAt)[-1])

print("  lambda_max(t Hess(B) + Hess(A)) :", flush=True)
for t in (0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.577, 0.6, 0.65, 0.7, 0.75, 0.8, 0.9, 1.0, 1.5, 2.0):
    print(f"    t={t:5.3f}  {lam_max(t):+.8e}", flush=True)
lo, hi = 0.0, 2.0
if lam_max(hi) <= 1e-10:
    hi = 20.0
if lam_max(hi) > 1e-10:
    for _ in range(80):
        mid = 0.5 * (lo + hi)
        if lam_max(mid) > 1e-10:
            hi = mid
        else:
            lo = mid
    print(f"\n  *** exact second-order threshold t* = {0.5*(lo+hi):.9f} ***", flush=True)
    tstar = 0.5*(lo+hi)
    s2 = tstar**2/(1+tstar**2)
    print(f"      -> s^2 = {s2:.9f},  alpha = 1/3 - s^2/3 = {1/3 - s2/3:.9f}", flush=True)
print(f"[{time.time()-t0:6.1f}s] done", flush=True)
