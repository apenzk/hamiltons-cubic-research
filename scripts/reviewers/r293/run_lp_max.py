import sys, time; sys.path.insert(0,'scripts/reviewers/r293'); sys.path.insert(0,'scripts/lib')
import numpy as np
from r293_lp import Relax

def proj(x):
    x = x - x.mean(); return x/np.linalg.norm(x)

def climb(R, kw, lam0, iters=400, seed=0, step0=0.35):
    rng = np.random.default_rng(seed)
    lam = proj(lam0); best = R.solve(lam, **kw)
    if best is None: best = -np.inf
    step = step0
    for i in range(iters):
        cand = proj(lam + step*rng.normal(size=lam.size))
        v = R.solve(cand, **kw)
        if v is not None and v > best:
            best, lam = v, cand
        elif i % 40 == 39:
            step *= 0.75
    return best, lam

CLASSES = (("A", dict(use_V=False,use_C=False)),
           ("B", dict(use_V=True, use_C=False)),
           ("C", dict(use_V=True, use_C=True)),
           ("A+C", dict(use_V=False,use_C=True)))

n = int(sys.argv[1]); nstart = int(sys.argv[2]); iters = int(sys.argv[3])
R = Relax(n); N = R.N
print(f"n={n} N={N} triples={R.K}", flush=True)
rng = np.random.default_rng(11)
starts = [rng.normal(size=N) for _ in range(nstart)]
# seeded starts: padded CP^2 spectrum and the sphere-product spectrum
import r293_d123 as r
from r293_points import catalogue
for nn,W,lbl in catalogue():
    if nn==n:
        starts.append(np.linalg.eigvalsh(W/np.linalg.norm(W)))
for tag,kw in CLASSES:
    t0=time.time(); best=-np.inf; arg=None
    for s,l0 in enumerate(starts):
        v,l = climb(R, kw, l0, iters=iters, seed=100+s)
        if v>best: best, arg = v, l
    print(f"  class {tag:4s} max theta = {best:.6f}   ({time.time()-t0:.1f}s, {len(starts)} starts)", flush=True)
    np.save(f"/tmp/r293_arg_{n}_{tag.replace('+','p')}.npy", arg if arg is not None else np.zeros(N))
