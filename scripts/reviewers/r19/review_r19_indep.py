"""Reviewer 19: independent re-derivation of the Remark-4.18 subdivision structure.

Nothing here reuses p0_* except the primitives (structure constants, Q_full,
Weyl basis, fox_point).  Every downstream quantity is recomputed from scratch.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from run_unconstrained_search import build_weyl_basis
from p0_tubular_hessian import fox_point, F_matrix, orbit_dim

SQ32 = np.sqrt(1.5)
R23 = np.sqrt(2.0/3.0)


def log(msg):
    print(f"[{time.strftime('%H:%M:%S')}] {msg}", flush=True)
    with open(_os.path.join(_ROOT, 'agent_logs/review_r19.log'), 'a') as f:
        f.write(f"{time.strftime('%H:%M:%SZ')} {msg}\n")


def setup(n):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    u, th, res = fox_point(n, L2, Eflat, c)
    return dict(n=n, idx=idx, c=c, L2=L2, Eflat=Eflat, D=D, u=u, th=th, res=res, Nl=u.shape[0])


def tri(A, B, C, c):
    """Symmetric trilinear form with tri(W,W,W)=P(W)=<W,Q(W)>."""
    return float(np.sum(C * ((Q_full(A + B, c) - Q_full(A - B, c)) / 4.0)))


def check_symmetry(c, Nl, Eflat, rng):
    """tri must be fully symmetric; verify on random Weyl triples."""
    worst = 0.0
    for _ in range(6):
        Ws = []
        for _ in range(3):
            y = rng.normal(size=Eflat.shape[0])
            W = (Eflat.T @ y).reshape(Nl, Nl); W = 0.5*(W+W.T); W /= np.linalg.norm(W)
            Ws.append(W)
        A, B, C = Ws
        vals = [tri(A,B,C,c), tri(B,A,C,c), tri(C,A,B,c), tri(A,C,B,c), tri(B,C,A,c), tri(C,B,A,c)]
        worst = max(worst, max(vals)-min(vals))
    return worst


if __name__ == "__main__":
    ns = [int(x) for x in sys.argv[1:]] or [10]
    for n in ns:
        t = time.time()
        S = setup(n)
        c, Eflat, u, Nl, D = S['c'], S['Eflat'], S['u'], S['Nl'], S['D']
        log(f"n={n} dimWeyl={D} theta(u)={S['th']:.9f} crit-res={S['res']:.2e} ({time.time()-t:.1f}s)")
        rng = np.random.default_rng(1234)
        sym = check_symmetry(c, Nl, Eflat, rng)
        log(f"n={n} trilinear-symmetry max spread over 6 random triples: {sym:.2e}")
        t = time.time()
        M = F_matrix(u, c, Eflat)
        ev, V = np.linalg.eigh(M)
        r = ev / SQ32
        log(f"n={n} F_matrix built in {time.time()-t:.1f}s; asym={np.linalg.norm(M-M.T):.1e}")
        # group spectrum
        groups = []
        lo = 0
        while lo < len(r):
            hi = lo
            while hi+1 < len(r) and abs(r[hi+1]-r[lo]) < 1e-7:
                hi += 1
            groups.append((r[lo], hi-lo+1))
            lo = hi+1
        log(f"n={n} spec(F_u)/theta*: " + "  ".join(f"{g:+.6f}x{m}" for g,m in groups))
        od, _ = orbit_dim(u, n, S['L2'], Eflat)
        log(f"n={n} orbit dim = {od}")
        np.save(f"scratchpad/r19_F_{n}.npy", M)
        np.save(f"scratchpad/r19_Eflat_{n}.npy", Eflat)
        np.save(f"scratchpad/r19_u_{n}.npy", u)
