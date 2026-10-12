"""R52: cross-checks for the slack question outside the block family.
(a) W_CP2 padded: does S_struct = 0 while S_theta = 0 too?
(b) does S_theta = 0 <=> S_struct = 0 anywhere it can be tested?"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import sys, time
import numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
import review_r52_core as K

LOG = _os.path.join(_ROOT, 'agent_logs/review_r52_multiblock.log')
def log(m):
    line = f"[{time.strftime('%H:%M:%S')}] {m}"
    print(line, flush=True)
    open(LOG, 'a').write(line + '\n')


def cp2_padded(n):
    """self-dual Weyl operator of CP^2 on Lambda^2(R^4), zero-padded into Lambda^2(R^n)."""
    prs, idx = K.pairs_of(n)
    N = len(prs)
    def v(pairs_signs):
        u = np.zeros(N)
        for (i, j), s in pairs_signs:
            u[idx[(min(i, j), max(i, j))]] += s * (1 if i < j else -1)
        return u / np.linalg.norm(u)
    o1 = v([((0, 1), 1), ((2, 3), 1)])
    o2 = v([((0, 2), 1), ((3, 1), 1)])
    o3 = v([((0, 3), 1), ((1, 2), 1)])
    W = (2 * np.outer(o1, o1) - np.outer(o2, o2) - np.outer(o3, o3)) / np.sqrt(6)
    return W


def cpm(n, m):
    """W_{CP^m} inside R^{2m} padded to R^n: Kaehler form J, W = a(J J^T) + b*(...)
    built instead as the Weyl part of the Fubini-Study curvature operator."""
    return None


def report(name, n, W):
    W = W / np.linalg.norm(W)
    th = K.P_val(n, W)
    res = np.linalg.norm(K.Q(n, W) - th * W)
    Sst = K.slack_structural(n, W)
    Sad = K.slack_repo_adjoint(n, W)
    Sth = K.slack_theta_formula(n, W, th)
    dm = int((np.linalg.eigvalsh(W) < -1e-9).sum())
    log(f"  {name:>22} n={n:3d} th={th:.9f} th/th0={th/K.theta0(n):.4f} res={res:.1e} "
        f"|Ric|={np.abs(K.ricci(n,W)).max():.1e} |Alt|={np.abs(K.alt(n,W)).max():.1e} "
        f"dim_m={dm} S_struct={Sst:.6f} S_adj={Sad:.4f} S_theta={Sth:.6f}")


if __name__ == '__main__':
    log("PHASE 6: cross-checks outside the block family")
    for n in (4, 6, 8, 10):
        report(f"W_CP2 padded", n, cp2_padded(n))
    # padded S^3 x S^3 (b_padded_s3s3's point), my own construction
    def vertex_pad(n0, parts, n):
        prs0, idx0 = K.pairs_of(n0); prs, idx = K.pairs_of(n)
        which = {}; s = 0
        for bi, q in enumerate(parts):
            for i in range(s, s + q): which[i] = bi
            s += q
        N = len(prs); W = np.zeros((N, N))
        for a, (i, j) in enumerate(prs0):
            if which[i] == which[j]:
                na = parts[which[i]]; val = (n0 - na) / ((n0 - 1) * (na - 1))
            else:
                val = -1.0 / (n0 - 1)
            t = idx[(i, j)]; W[t, t] = val
        return W
    for n in (6, 8, 10, 12):
        report("S^3xS^3 padded", n, vertex_pad(6, (3, 3), n))
    log("PHASE 6 done")
