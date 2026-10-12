"""T9: max theta over the FULL pinned system, with the spectrum free.

WHY THIS AND NOT THE EARLIER RUN.  run_bilinear_spectrum_max.py built only (A) row mass
and (C) criticality -- relation (B), the per-row identity A(W) = 2W, is ABSENT from it.
That is the same omission Reviewer 326 caught in post 41, where restoring (B) collapsed a
marginal LP to the exact theta at every maximal torus.  So that run's 1.590427 says nothing
about the pinned class and this one supersedes it.

THE SYSTEM, at a fixed spectrum lambda (trace-free, unit norm), over T >= 0 supported on
distinct triples:
    (A)  sum_{b<c} T_abc = n-2                    for every a
    (B)  sum_{b<c} (lam_b + lam_c) T_abc = -2 lam_a   for every a
    (C)  sum_{b<c} lam_b lam_c T_abc = lam_a(theta - lam_a)  for every a
theta enters (C) linearly, so max theta at fixed lambda is an LP.  Outer: Nelder-Mead over
the spectrum.  Reported against the true maximum at that n -- sqrt(3/2) at n=6, since
padded W_CP2 beats the balanced product below n=12.
"""
import sys, os, time
import numpy as np
from itertools import combinations
from scipy.optimize import linprog, minimize
from scipy.sparse import coo_matrix

def lp_max_theta(ev, n, use_B=True):
    N = len(ev)
    tri = list(combinations(range(N), 3))
    pos = {t: i for i, t in enumerate(tri)}
    nv = len(tri)
    byk = [[] for _ in range(N)]
    for t in tri:
        for k in t:
            byk[k].append(t)
    r, c, d, beq = [], [], [], []
    row = 0
    for k in range(N):                                   # (A)
        for t in byk[k]:
            r.append(row); c.append(pos[t]); d.append(1.0)
        beq.append(n - 2.0); row += 1
    if use_B:
        for k in range(N):                               # (B)
            for t in byk[k]:
                a, b = [x for x in t if x != k]
                r.append(row); c.append(pos[t]); d.append(ev[a] + ev[b])
            beq.append(-2.0 * ev[k]); row += 1
    for k in range(N):                                   # (C), theta is variable nv
        for t in byk[k]:
            a, b = [x for x in t if x != k]
            r.append(row); c.append(pos[t]); d.append(ev[a] * ev[b])
        r.append(row); c.append(nv); d.append(-ev[k])
        beq.append(-ev[k] ** 2); row += 1
    Aeq = coo_matrix((d, (r, c)), shape=(row, nv + 1)).tocsr()
    obj = np.zeros(nv + 1); obj[nv] = -1.0
    res = linprog(obj, A_eq=Aeq, b_eq=np.array(beq),
                  bounds=[(0, None)] * nv + [(None, None)], method='highs')
    return (-res.fun) if res.status == 0 else None


def norm_spec(x):
    x = x - x.mean()
    nx = np.linalg.norm(x)
    return np.sort(x / nx) if nx > 1e-12 else None


if __name__ == '__main__':
    n = int(sys.argv[1]) if len(sys.argv) > 1 else 6
    trials = int(sys.argv[2]) if len(sys.argv) > 2 else 40
    N = n * (n - 1) // 2
    th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    TRUE = np.sqrt(1.5) if n < 12 else th0
    print(f"PID {os.getpid()} | n={n} N={N} vars={len(list(combinations(range(N),3)))} "
          f"| theta_0={th0:.9f}  true max={TRUE:.9f}", flush=True)
    rng = np.random.default_rng(0); best = (-1e9, None); t0 = time.time()
    for t in range(trials):
        x0 = rng.standard_normal(N)
        def neg(x):
            ev = norm_spec(x)
            if ev is None: return 1e3
            v = lp_max_theta(ev, n, use_B=True)
            return 1e3 if v is None else -v
        r = minimize(neg, x0, method='Nelder-Mead',
                     options=dict(maxfev=700, xatol=1e-6, fatol=1e-9))
        if -r.fun > best[0]: best = (-r.fun, norm_spec(r.x))
        if t % 8 == 7:
            print(f"  trial {t+1:3d}: best {best[0]:.9f}  (true max {TRUE:.9f})  "
                  f"[{time.time()-t0:.0f}s]", flush=True)
    print(f"RESULT n={n}: full pinned max theta = {best[0]:.9f} | true max = {TRUE:.9f} | "
          f"{'WITHIN' if best[0] <= TRUE + 1e-6 else 'overshoots by %.6f' % (best[0]-TRUE)}",
          flush=True)
    print("  spectrum:", np.array2string(best[1], precision=6), flush=True)
    print("DONE", flush=True)
