"""Phase (a) global search: alternating GLOBAL trust-region solves, many seeds.
Usage: review_r21_run_a2.py n nseeds t ..."""
import sys, time
import numpy as np
from review_r21_core import Setup, sphere_quad_max, unit
from review_r21_frontier import A_SUP, B_SUP, AB, maximize_A, maximize_B

n = int(sys.argv[1]); nseed = int(sys.argv[2])
ts = [float(x) for x in sys.argv[3:]] or [0.3, 0.5, 0.577, 0.65, 0.684653197, 0.75]
t0 = time.time()
S = Setup(n)
rng = np.random.default_rng(31337 + n)
TSTAR = 0.75 * np.sqrt(5.0 / 6.0)

def load_or(fn, mk):
    try:
        return np.load(fn)
    except Exception:
        v = mk(); np.save(fn, v); return v

y1A = load_or(f"/tmp/r21_y1A_{n}.npy", lambda: maximize_A(S, restarts=25, iters=200, seed=7)[1])
y2A = load_or(f"/tmp/r21_y2A_{n}.npy", lambda: unit(S.q_ker(S.mat13(y1A))))
y2B = load_or(f"/tmp/r21_y2B_{n}.npy", lambda: maximize_B(S, restarts=25, iters=200, seed=11)[1])
y1B = load_or(f"/tmp/r21_y1B_{n}.npy", lambda: unit(S.q_13(S.matker(y2B))))
print(f"[{time.time()-t0:6.1f}s] corners loaded; A-corner A={AB(S,y1A,y2A)[0]:.9f}, B-corner B={AB(S,y1B,y2B)[1]:.9f}", flush=True)

# the natural competitor: W1* with K = top eigenvector of M_{W1*}
Mk0 = S.block_fast(S.mat13(y1A), S.Vker, S.Vker); Mk0 = 0.5*(Mk0+Mk0.T)
w0, V0 = np.linalg.eigh(Mk0)
print(f"  M_ker at W1*: lam_max={w0[-1]:.12f} (2/3={2/3:.12f})  <K*,M K*>={y2A@Mk0@y2A:.3e}"
      f"  ||M K*||={np.linalg.norm(Mk0@y2A):.3e}  <K*,v_top>={y2A@V0[:,-1]:.3e}", flush=True)
seeds = [("A-corner", y1A, y2A), ("B-corner", y1B, y2B),
         ("W1*/topB", y1A, V0[:, -1]), ("W1*/mixB", y1A, unit(0.7*y2A + 0.7*V0[:, -1])),
         ("W1*/2ndB", y1A, V0[:, -2])]
for k in range(nseed):
    seeds.append((f"rand{k}", unit(rng.normal(size=S.d13)), unit(rng.normal(size=S.dker))))
for w in (0.2, 0.4, 0.6, 0.8):
    seeds.append((f"mix{w}", unit((1-w)*y1A + w*y1B), unit((1-w)*y2A + w*y2B)))

def rounds(y1, y2, t, nr=7):
    for r in range(nr):
        W1 = S.mat13(y1)
        Mk = S.block_fast(W1, S.Vker, S.Vker); Mk = 0.5*(Mk+Mk.T)
        y2, _ = sphere_quad_max(t * Mk, S.q_ker(W1))
        K = S.matker(y2)
        M1 = S.block_fast(K, S.V13, S.V13); M1 = 0.5*(M1+M1.T)
        y1, _ = sphere_quad_max(M1, t * S.q_13(K))
    a, b = AB(S, y1, y2)
    return a + t*b, a, b, y1, y2

print(f"\n  {'t':>10} {'A':>13} {'B':>13} {'A+tB':>13} {'-supA':>11} {'-Vclosed':>11}  seed", flush=True)
for t in ts:
    Vclosed = max(A_SUP, 5.0/(16*t) + 2*t/3.0)
    best = (-9e9,)
    for name, s1, s2 in seeds:
        v, a, b, yy1, yy2 = rounds(s1.copy(), s2.copy(), t)
        if v > best[0]:
            best = (v, a, b, name, yy1, yy2)
    v, a, b, name = best[0], best[1], best[2], best[3]
    print(f"  {t:>10.7f} {a:>13.9f} {b:>13.9f} {v:>13.9f} {v-A_SUP:>+11.2e} {v-Vclosed:>+11.2e}  {name}", flush=True)
    np.save(f"/tmp/r21_g_y1_{n}_{t:.6f}.npy", best[4]); np.save(f"/tmp/r21_g_y2_{n}_{t:.6f}.npy", best[5])
print(f"[{time.time()-t0:6.1f}s] done", flush=True)
