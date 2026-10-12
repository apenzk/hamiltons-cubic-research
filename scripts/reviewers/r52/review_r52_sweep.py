"""R52 M4: can any multi-block sphere product get S near 0?
Sweeps block partitions to large n; uses the exact vertex solution so criticality
is analytic, and cross-checks against the full Q at moderate n."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time, itertools
import numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
import review_r52_core as K

LOG = _os.path.join(_ROOT, 'agent_logs/review_r52_multiblock.log')
def log(m):
    line = f"[{time.strftime('%H:%M:%S')}] {m}"
    print(line, flush=True)
    open(LOG, 'a').write(line + '\n')


def vertex_diag(n, parts):
    prs, idx = K.pairs_of(n)
    which = {}; s = 0
    for bi, q in enumerate(parts):
        for i in range(s, s + q): which[i] = bi
        s += q
    lam = np.zeros(len(prs))
    for a, (i, j) in enumerate(prs):
        if which[i] == which[j]:
            na = parts[which[i]]; lam[a] = (n - na) / ((n - 1) * (na - 1))
        else:
            lam[a] = -1.0 / (n - 1)
    return lam / np.linalg.norm(lam), which


def diag_theta_resid(n, lam, which):
    """criticality residual using the diagonal Q formula (cheap)."""
    prs, idx = K.pairs_of(n)
    L = np.zeros((n, n))
    for a, (i, j) in enumerate(prs):
        L[i, j] = L[j, i] = lam[a]
    Qd = np.array([lam[a] ** 2 + sum(L[i, k] * L[j, k] for k in range(n) if k not in (i, j))
                   for a, (i, j) in enumerate(prs)])
    th = float(lam @ Qd)
    return th, float(np.max(np.abs(Qd - th * lam)))


def slacks(n, lam, parts, th):
    W = np.diag(lam)
    Sst = K.slack_structural(n, W)
    Sth = K.slack_theta_formula(n, W, th)
    e3 = sum(np.prod(c) for c in itertools.combinations(parts, 3))
    return Sst, Sth, 3.0 * e3


if __name__ == '__main__':
    log("PHASE 5b: multi-block sweep for S near 0")
    log(f"{'parts':>22} {'n':>3} {'theta':>10} {'th/th0':>7} {'res':>8} "
        f"{'S_struct':>10} {'3e3':>8} {'S_theta':>10}")
    cases = []
    # (2,2,m) family, the smallest S_theta seen so far
    for m in range(2, 31):
        cases.append((2, 2, m))
    # many 2-blocks
    for k in range(3, 11):
        cases.append(tuple([2] * k))
    # equal blocks
    for p in (3, 4, 5, 6, 7, 8):
        for k in (3, 4, 5):
            if p * k <= 34:
                cases.append(tuple([p] * k))
    # one tiny + two big, and other unbalanced shapes
    for m in (5, 8, 12, 16, 20):
        cases.append((2, m, m)); cases.append((2, 2, 2, m)); cases.append((3, 3, m))
        cases.append((2, 3, m)); cases.append((m, m, m))
    seen = set(); best = []
    for parts in cases:
        parts = tuple(sorted(parts))
        if parts in seen: continue
        seen.add(parts)
        n = sum(parts)
        if n > 34: continue
        lam, which = vertex_diag(n, parts)
        th, res = diag_theta_resid(n, lam, which)
        Sst, Sth, e3 = slacks(n, lam, parts, th)
        log(f"{str(parts):>22} {n:3d} {th:10.6f} {th/K.theta0(n):7.4f} {res:8.1e} "
            f"{Sst:10.1f} {e3:8.1f} {Sth:10.6f}")
        best.append((Sth, parts, n, th))
    best.sort()
    log("  smallest S_theta found:")
    for Sth, parts, n, th in best[:8]:
        log(f"    {str(parts):>22} n={n} theta/theta0={th/K.theta0(n):.4f} S_theta={Sth:.6f}")
    log(f"  min S_struct over all multi-block cases: {min(3*sum(np.prod(c) for c in itertools.combinations(p,3)) for _,p,_,_ in best):.1f}")
    # cross-check three of them against the full Q and the full structural slack
    log("  cross-check with full Q:")
    for parts in [(2, 2, 6), (3, 3, 3), (2, 4, 4)]:
        n = sum(parts)
        lam, _ = vertex_diag(n, parts)
        W = np.diag(lam)
        th = K.P_val(n, W)
        log(f"    {parts}: full-Q theta={th:.9f} resid={np.linalg.norm(K.Q(n,W)-th*W):.1e} "
            f"|Ric|={np.abs(K.ricci(n,W)).max():.1e}")
    log("PHASE 5b done")
