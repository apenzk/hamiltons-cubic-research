#!/usr/bin/env python3
"""Reviewer 13 helper: multiblock sphere-product critical points via the vertex
(block) system, embedded and verified against the full Q, then fed to the sharp
(II)-side bound evaluator. Probes the delta^2=0 ungraded stratum at n=12..16."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import importlib.util
import itertools

import numpy as np
from scipy.optimize import least_squares

spec = importlib.util.spec_from_file_location(
    "r13", _os.path.join(_ROOT, "scripts/review_r13_independent.py"))
r13 = importlib.util.module_from_spec(spec)
spec.loader.exec_module(r13)


def multiblock_point(blocks):
    """solve the block-symmetric vertex system for S^{n1} x ... x S^{nk}."""
    k = len(blocks)
    n = sum(blocks)
    idx = [(a, b) for a in range(k) for b in range(a, k)]

    def unpack(z):
        w = np.zeros((k, k))
        for t, (a, b) in enumerate(idx):
            w[a, b] = w[b, a] = z[t]
        return w, z[len(idx)]

    def F(z):
        w, th = unpack(z)
        res = []
        # row sums (Weyl condition), one per block
        for a in range(k):
            res.append((blocks[a] - 1) * w[a, a]
                       + sum(blocks[b] * w[a, b] for b in range(k) if b != a))
        # criticality per pair-class
        for (a, b) in idx:
            if a == b and blocks[a] < 2:
                res.append(w[a, a])
                continue
            s = 0.0
            for c in range(k):
                cnt = blocks[c] - (1 if c == a else 0) - (1 if c == b else 0)
                s += cnt * w[a, c] * w[b, c]
            res.append(w[a, b] ** 2 + s - th * w[a, b])
        # unit norm: sum over pairs
        nrm = 0.0
        for (a, b) in idx:
            if a == b:
                nrm += blocks[a] * (blocks[a] - 1) / 2 * w[a, a] ** 2
            else:
                nrm += blocks[a] * blocks[b] * w[a, b] ** 2
        res.append(nrm - 1.0)
        return np.array(res)

    best = {}
    for seed in range(60):
        z0 = np.concatenate([r13.RNG.standard_normal(len(idx)) * 0.3, [1.0]])
        sol = least_squares(F, z0, method='lm', xtol=1e-15, ftol=1e-15)
        r = np.linalg.norm(F(sol.x))
        if r < 1e-12:
            w, th = unpack(sol.x)
            if th < 0:
                w, th = -w, -th
            if th < 1e-8:
                continue
            key = (round(th, 8),) + tuple(np.round(np.sort(w.ravel()), 6))
            if key not in best:
                best[key] = (w, th)
    return best


def embed(core, blocks, w):
    n = core.n
    starts = np.cumsum([0] + list(blocks))
    blk = np.zeros(n, int)
    for a in range(len(blocks)):
        blk[starts[a]:starts[a + 1]] = a
    M = np.zeros((core.N, core.N))
    for t, (i, j) in enumerate(core.pairs):
        M[t, t] = w[blk[i], blk[j]]
    return M


if __name__ == "__main__":
    r13.log("MULTIBLOCK start (vertex-system route)")
    cases = [(12, (2, 2, 8)), (12, (2, 3, 7)), (12, (3, 4, 5)), (12, (4, 4, 4)),
             (12, (2, 5, 5)), (12, (2, 2, 2, 6)), (12, (3, 3, 3, 3)),
             (14, (2, 2, 10)), (14, (2, 6, 6)), (16, (2, 2, 12)),
             (16, (2, 7, 7)), (16, (4, 6, 6)), (16, (2, 2, 2, 10))]
    best_rhs = 0.0
    for n, blocks in cases:
        core = r13.Core(n)
        sols = multiblock_point(blocks)
        for key, (w, th) in sorted(sols.items()):
            if np.min(np.abs([w[a, a] for a in range(len(blocks))]
                             + [w[a, b] for a in range(len(blocks))
                                for b in range(a + 1, len(blocks))])) < 1e-8:
                continue          # skip degenerate sub-product solutions
            W = embed(core, blocks, w)
            res = np.linalg.norm(core.Q(W) - th * W)
            if res > 1e-10:
                continue
            ev = r13.evaluate_point(core, W, th)
            tag = f"S{'xS'.join(map(str, blocks))} n={n}"
            r13.log("  " + r13.fmt_point(tag, ev))
            if not ev.get('graded') and ev['rhs'] > best_rhs:
                best_rhs = ev['rhs']
    r13.log(f"MULTIBLOCK done: max ungraded RHS = {best_rhs:.6f} "
            f"(sqrt(3/2)={np.sqrt(1.5):.6f})")
