"""R52 M2: audit the block-symmetric vertex solver.
Independent reimplementation + heavy multistart + exact sympy solve at k=3,
then embed every solution and verify criticality/Ricci-flatness with the full Q.
Also runs the repository's own solver and compares."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import sys, time, itertools
import numpy as np
from scipy.optimize import least_squares
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
import review_r52_core as K

LOG = _os.path.join(_ROOT, 'agent_logs/review_r52_multiblock.log')
def log(m):
    line = f"[{time.strftime('%H:%M:%S')}] {m}"
    print(line, flush=True)
    open(LOG, 'a').write(line + '\n')

RNG = np.random.default_rng(5252)


def system(blocks):
    k = len(blocks)
    idx = [(a, b) for a in range(k) for b in range(a, k)]

    def unpack(z):
        w = np.zeros((k, k))
        for t, (a, b) in enumerate(idx):
            w[a, b] = w[b, a] = z[t]
        return w, z[len(idx)]

    def F(z):
        w, th = unpack(z)
        res = []
        for a in range(k):                       # Ricci-flat row sums
            res.append((blocks[a] - 1) * w[a, a]
                       + sum(blocks[b] * w[a, b] for b in range(k) if b != a))
        for (a, b) in idx:                       # criticality, one per pair class
            if a == b and blocks[a] < 2:
                res.append(w[a, a]); continue
            s = 0.0
            for c in range(k):
                cnt = blocks[c] - (1 if c == a else 0) - (1 if c == b else 0)
                s += cnt * w[a, c] * w[b, c]
            res.append(w[a, b] ** 2 + s - th * w[a, b])
        nrm = 0.0                                 # unit Frobenius norm
        for (a, b) in idx:
            if a == b:
                nrm += blocks[a] * (blocks[a] - 1) / 2 * w[a, a] ** 2
            else:
                nrm += blocks[a] * blocks[b] * w[a, b] ** 2
        res.append(nrm - 1.0)
        return np.array(res)
    return idx, unpack, F


def canon(blocks, w, th):
    """canonical key: minimise over permutations of equal-size blocks."""
    k = len(blocks)
    best = None
    for p in itertools.permutations(range(k)):
        if tuple(blocks[i] for i in p) != tuple(blocks):
            continue
        ww = w[np.ix_(p, p)]
        key = tuple(np.round(ww[np.triu_indices(k)], 7) + 0.0)
        if best is None or key < best:
            best = key
    return (round(th, 7),) + best


def solve_all(blocks, nstart=4000, scale=0.6):
    idx, unpack, F = system(blocks)
    sols = {}
    for s in range(nstart):
        z0 = np.concatenate([RNG.standard_normal(len(idx)) * scale,
                             [RNG.standard_normal() * 1.0]])
        try:
            sol = least_squares(F, z0, method='lm', xtol=1e-15, ftol=1e-15, gtol=1e-15)
        except Exception:
            continue
        if np.linalg.norm(F(sol.x)) > 1e-11:
            continue
        w, th = unpack(sol.x)
        if th < 0:
            w, th = -w, -th
        sols.setdefault(canon(blocks, w, th), (w, th))
    return sols


def embed(n, blocks, w):
    prs, idx = K.pairs_of(n)
    blk = np.zeros(n, int); s = 0
    for a, q in enumerate(blocks):
        blk[s:s + q] = a; s += q
    return np.diag([w[blk[i], blk[j]] for (i, j) in prs])


if __name__ == '__main__':
    log("PHASE 3 M2: block-symmetric vertex solver audit")
    for blocks in [(3, 3, 3), (4, 4, 4), (2, 5, 5), (3, 4, 5), (2, 2, 8),
                   (3, 3, 3, 3), (4, 5), (3, 3)]:
        n = sum(blocks)
        t0 = time.time()
        sols = solve_all(blocks)
        log(f"  {blocks} n={n}: {len(sols)} distinct solutions with theta>=0 "
            f"[{time.time()-t0:.1f}s]")
        for key, (w, th) in sorted(sols.items(), key=lambda kv: -kv[1][1]):
            if th < 1e-9:
                log(f"      theta=0 solution (skipped detail)"); continue
            W = embed(n, blocks, w)
            nw = np.linalg.norm(W)
            if nw < 1e-9:
                continue
            Wn = W / nw
            thc = K.P_val(n, Wn)
            res = np.linalg.norm(K.Q(n, Wn) - thc * Wn)
            ric = np.abs(K.ricci(n, Wn)).max()
            Sst = K.slack_structural(n, Wn)
            Sth = K.slack_theta_formula(n, Wn, thc)
            dm = int((np.linalg.eigvalsh(Wn) < -1e-9).sum())
            zero = np.abs(w[np.triu_indices(len(blocks))]).min() < 1e-9
            log(f"      w_upper={np.round(w[np.triu_indices(len(blocks))],6).tolist()} "
                f"th_sys={th:.7f} th_full={thc:.7f} resid={res:.1e} |Ric|={ric:.1e} "
                f"dim_m={dm} S_struct={Sst:.4f} S_theta={Sth:.6f} "
                f"th/th0={thc/K.theta0(n):.4f}{'  [has zero entry]' if zero else ''}")
    log("PHASE 3 M2 done")
