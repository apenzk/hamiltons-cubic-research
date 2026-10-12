"""
Falsifier hunt for Conjecture A beyond n=12: projected gradient ascent of P on the
unit sphere of the full Weyl space W_n (dim 3080 at n=14), approved by the user on
2026-09-14 as a bounded run. A value above Theta_n at a converged critical point
would refute Conjecture A; finding none is a floor on M(n), never a proof.

Reuses the validated fast path of lib/run_unconstrained_search_n12.py (Q_fast,
gradient_ascent_fast, cluster_by_value) and lib/run_unconstrained_search.py's
basis and diagonalisability search, unchanged. n is a parameter here.

Two seed families, because random draws on the sphere miss structured subfamilies:
  random     x0 ~ N(0, I) in Weyl coordinates
  support-k  a random symmetric operator on Lambda^2 supported on the pairs of the
             first k indices (k cycles through 5..n-3), projected onto W_n, then
             mixed with 5% isotropic noise

Usage (from the repo root):
  PYTHONPATH=scripts/lib python3 scripts/runs/hunt_maximiser_n14.py control
  PYTHONPATH=scripts/lib python3 scripts/runs/hunt_maximiser_n14.py <random|support> N RESTARTS SEED
"""
import sys
import time

import numpy as np

from weyl import build_structure_constants
from run_unconstrained_search import build_weyl_basis, cluster_by_value, search_diagonalization, CP2_VALUE
from run_unconstrained_search_n12 import build_Cflat, gradient_ascent_fast


def theta(n):
    if n % 2 == 0:
        return np.sqrt(2 * (n - 1) * (n - 2)) / n
    return np.sqrt(2 * (n - 1) * (n - 3) / ((n + 1) * (n - 2)))


def sphere_product(n, p):
    q = n - p
    return np.sqrt(2 * (n - 1) * (p - 1) * (q - 1) / ((n - 2) * p * q))


def seeds(kind, n, idx, N, Eflat, D, restarts, rng):
    if kind == "random":
        for _ in range(restarts):
            yield "random", rng.normal(size=D)
        return
    G = Eflat @ Eflat.T
    L = np.linalg.cholesky(G)
    pairs = list(idx)
    ks = list(range(5, n - 2))
    for r in range(restarts):
        k = ks[r % len(ks)]
        A = np.zeros((N, N))
        inside = [a for a in range(N) if pairs is not None and max(pairs[a]) < k]
        if not inside:
            raise RuntimeError("pair index map not understood; refusing to seed")
        M = rng.normal(size=(len(inside), len(inside)))
        A[np.ix_(inside, inside)] = M + M.T
        b = Eflat @ A.reshape(-1)
        x = np.linalg.solve(L.T, np.linalg.solve(L, b))
        x /= np.linalg.norm(x)
        yield f"support-{k}", x + 0.05 * rng.normal(size=D) / np.sqrt(D)


def run(kind, n, restarts, seed):
    Th = theta(n)
    known = {f"S{p}xS{n-p}": sphere_product(n, p) for p in range(2, n // 2 + 1)}
    known["sqrt(3/2)"] = CP2_VALUE
    print(f"n={n} Theta_n={Th:.9f} kind={kind} restarts={restarts} seed={seed}", flush=True)
    print("known:", ", ".join(f"{k}={v:.6f}" for k, v in known.items()), flush=True)
    t0 = time.time()
    idx, pos, N, c = build_structure_constants(n)
    Cflat_mp = build_Cflat(c)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    print(f"basis D={D} N={N} built in {time.time()-t0:.1f}s", flush=True)
    rng = np.random.default_rng(seed)
    results = []
    t1 = time.time()
    for r, (label, x0) in enumerate(seeds(kind, n, idx, N, Eflat, D, restarts, rng)):
        x, P, resid, iters = gradient_ascent_fast(x0, Eflat, Cflat_mp, N, D, max_iter=600)
        results.append(dict(P=P, x=x, residual=resid, iters=iters, label=label))
        flag = "  ABOVE THETA" if P > Th + 1e-6 and resid < 1e-5 else ""
        print(f"restart {r+1}/{restarts} {label}: P={P:.9f} resid={resid:.1e} iters={iters} ({time.time()-t1:.0f}s){flag}", flush=True)
    clusters, bad = cluster_by_value(results)
    print(f"\n{len(clusters)} clusters, {len(bad)} unconverged (resid>=1e-5)")
    top_bad = max((b["P"] for b in bad), default=float("nan"))
    print(f"largest P among unconverged: {top_bad:.9f}")
    above = False
    for cl in clusters:
        members = cl if isinstance(cl, list) else cl.get("members", [])
        Pv = np.mean([m["P"] for m in members]) if members else float("nan")
        near = min(known.items(), key=lambda kv: abs(kv[1] - Pv))
        print(f"cluster P={Pv:.9f} count={len(members)} nearest {near[0]}={near[1]:.9f} (diff {Pv-near[1]:+.1e})")
        if Pv > Th + 1e-6:
            above = True
            amb = members[0]["x"] @ Eflat
            W = amb.reshape(N, N)
            W = 0.5 * (W + W.T)
            print("  diagonalisability search on this cluster:", search_diagonalization(W, idx, N, n), flush=True)
    print(f"total {time.time()-t0:.0f}s")
    print("DONE RESULT: a converged critical value ABOVE Theta_n, check it before anything else" if above
          else f"DONE RESULT: nothing above Theta_n={Th:.6f} in {restarts} restarts (a floor, not a proof)")


def control():
    n = 8
    run("random", n, 12, 0)


if __name__ == "__main__":
    if sys.argv[1] == "control":
        control()
    else:
        run(sys.argv[1], int(sys.argv[2]), int(sys.argv[3]), int(sys.argv[4]))
