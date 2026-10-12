"""Driver: phase (a) at one n.  Usage: review_r21_run_a.py n [t ...]"""
import sys, time
import numpy as np
from review_r21_core import Setup, sphere_quad_max, unit
from review_r21_frontier import (A_SUP, B_SUP, maximize_A, maximize_B, AB,
                                 exact_alternate, cheap_alternate)

n = int(sys.argv[1])
ts = [float(x) for x in sys.argv[2:]] or [0.10, 0.25, 0.35, 0.45, 0.50, 0.577, 0.60, 0.65, 0.70, 0.75, 0.90]
t0 = time.time()
S = Setup(n)
rng = np.random.default_rng(20250821)

print(f"[{time.time()-t0:7.1f}s] --- sup A and sup B, independently ---", flush=True)
va, y1A = maximize_A(S, restarts=25, iters=200, seed=7)
print(f"  sup A  = {va:.12f}   (sqrt(5/6) = {A_SUP:.12f}, diff {va-A_SUP:+.2e})", flush=True)
vb, y2B = maximize_B(S, restarts=25, iters=200, seed=11)
print(f"  sup B  = {vb:.12f}   (2/3       = {B_SUP:.12f}, diff {vb-B_SUP:+.2e})", flush=True)

W1A = S.mat13(y1A); y2A = unit(S.q_ker(W1A))
aA, bA = AB(S, y1A, y2A)
print(f"  at the A-maximiser: A={aA:.12f}  B={bA:.3e}", flush=True)
K_B = S.matker(y2B); y1B = unit(S.q_13(K_B))
aB, bB = AB(S, y1B, y2B)
print(f"  at the B-maximiser: A={aB:.12f}  B={bB:.12f}", flush=True)
np.save(f"/tmp/r21_y1A_{n}.npy", y1A); np.save(f"/tmp/r21_y2A_{n}.npy", y2A)
np.save(f"/tmp/r21_y1B_{n}.npy", y1B); np.save(f"/tmp/r21_y2B_{n}.npy", y2B)

print(f"\n[{time.time()-t0:7.1f}s] --- first-order test at the A-maximiser ---", flush=True)
# dB in K-direction: P_ker Fbil(W1*,K*) must be parallel to K*; dB in W1-direction:
# P_13 Q(K*) must be parallel to W1*.
KA = S.matker(y2A)
gK = S.f_ker(W1A, KA)
gK_perp = gK - (gK @ y2A) * y2A
g1 = S.q_13(KA)
g1_perp = g1 - (g1 @ y1A) * y1A
print(f"  ||P_ker Fbil(W1*,K*)|| = {np.linalg.norm(gK):.6e} , component transverse to K*: {np.linalg.norm(gK_perp):.6e}")
print(f"  ||P_13  Q(K*)||        = {np.linalg.norm(g1):.6e} , component transverse to W1*: {np.linalg.norm(g1_perp):.6e}")
print(f"  => first-order dB at the A-corner: {'NONZERO -> B>0 for every t>0' if max(np.linalg.norm(gK_perp),np.linalg.norm(g1_perp))>1e-8 else 'vanishes (second order decides)'}", flush=True)

print(f"\n[{time.time()-t0:7.1f}s] --- alternating GLOBAL trust-region solves ---", flush=True)
print(f"  {'t':>6} {'A':>14} {'B':>14} {'A+tB':>14} {'-supA':>11}  seed", flush=True)
seeds = {}
seeds['A-corner'] = (y1A, y2A)
seeds['B-corner'] = (y1B, y2B)
for k in range(6):
    seeds[f'rand{k}'] = (unit(rng.normal(size=S.d13)), unit(rng.normal(size=S.dker)))
# mixed seeds: interpolate the A and B corners
for w in (0.3, 0.6):
    seeds[f'mix{w}'] = (unit((1-w)*y1A + w*y1B), unit((1-w)*y2A + w*y2B))

results = {}
for t in ts:
    best = (-9e9, None, None, None)
    for name, (s1, s2) in seeds.items():
        v, yy1, yy2, hist = exact_alternate(S, s1.copy(), s2.copy(), t, rounds=6)
        if v > best[0]:
            best = (v, yy1, yy2, name)
    v, yy1, yy2, name = best
    a, b = AB(S, yy1, yy2)
    results[t] = (a, b, v)
    print(f"  {t:>6.3f} {a:>14.10f} {b:>14.10f} {v:>14.10f} {v-A_SUP:>+11.3e}  {name}", flush=True)
    np.save(f"/tmp/r21_best_y1_{n}_{t}.npy", yy1); np.save(f"/tmp/r21_best_y2_{n}_{t}.npy", yy2)
print(f"[{time.time()-t0:7.1f}s] done", flush=True)
