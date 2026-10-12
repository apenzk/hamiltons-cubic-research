"""Claims 1 and 2: the two diagonals, and whether t=2 forces coordinate-diagonality."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts/reviewers/r103'))
import r103_core as C
from itertools import combinations
from scipy.linalg import null_space

def majorization_slack(x, v):
    """min_j ( sum_{k<=j} x^down_k - sum_{k<=j} v^down_k ); >=0 means x majorizes v."""
    xs = np.sort(np.asarray(x))[::-1]; vs = np.sort(np.asarray(v))[::-1]
    return float(np.min(np.cumsum(xs) - np.cumsum(vs))), float(np.sum(xs) - np.sum(vs))

print("=== CLAIM 1 ===")
rng = np.random.default_rng(2027)
for n in (5, 6, 7, 8):
    for trial in range(3):
        W = C.weyl_from_random(n, rng)
        M = C.M_of(W, n); W = W/np.linalg.norm(M); M = M/np.linalg.norm(M)
        K = C.vertex_matrix(W, n)
        prs = list(combinations(range(n), 2))
        # (a) diag M in the phi-basis of Lambda^2 equals K
        dM = np.diag(M)
        dK = np.array([K[i, j] for i, j in prs])
        e_a = np.abs(dM - dK).max()
        # (d) K 1 = 0
        e_rows = np.abs(K.sum(1)).max()
        # (b) psi-block of ringW is -K restricted to 1-perp
        P = null_space(np.ones((1, n)))
        Kr = P.T @ K @ P
        evals, evecs = np.linalg.eigh(Kr)
        psi = (P @ evecs).T                    # (n-1) x n, orthonormal, in 1-perp
        RW = C.ringW_matrix(W, n, psi_vecs=psi)
        D = len(prs)
        psiblock = RW[D:, D:]
        e_b = np.abs(psiblock + np.diag(evals)).max()
        # (c) sum d^2 = 3/2 ||K||_F^2
        d = np.diag(RW)
        t = np.linalg.norm(K)**2
        e_c = abs(np.sum(d**2) - 1.5*t)
        e_cphi = abs(np.sum(d[:D]**2) - 0.5*t)
        # (e) Schur-Horn omega > d and mu > d_phi
        om = np.linalg.eigvalsh(RW); mu = np.linalg.eigvalsh(M)
        s_om, _ = majorization_slack(om, d)
        s_mu, _ = majorization_slack(mu, d[:D])
        if trial == 0:
            print(f" n={n}: |diagM-K|={e_a:.1e} |K1|={e_rows:.1e} |psiblock+K|1perp|={e_b:.1e} "
                  f"|sum d^2 - 3t/2|={e_c:.1e} |sum dphi^2 - t/2|={e_cphi:.1e} "
                  f"SH_om_slack={s_om:+.4f} SH_mu_slack={s_mu:+.4f} t={t:.4f}")

print()
print("=== CLAIM 2: t=2 <=> coordinate-diagonal, and the forcing ===")
# (i) t <= 2 always, with equality iff M is diagonal in the coordinate 2-plane basis
rng = np.random.default_rng(99)
worst = 0.0
for n in (5, 6, 7, 8):
    ts = []
    for _ in range(200):
        W = C.weyl_from_random(n, rng)
        M = C.M_of(W, n); M = M/np.linalg.norm(M); W = W/np.linalg.norm(C.M_of(W, n))
        K = C.vertex_matrix(W, n)
        t = np.linalg.norm(K)**2
        offdiag2 = np.linalg.norm(M)**2 - np.sum(np.diag(M)**2)
        ts.append((t, abs(t/2 + offdiag2 - 1.0)))
    tmax = max(x[0] for x in ts); ident = max(x[1] for x in ts)
    print(f" n={n}: max t over 200 random = {tmax:.4f} (bound 2); "
          f"identity |t/2 + ||offdiag M||^2 - 1| max = {ident:.1e}")

print()
print(" t=2 forcing, on the sphere-product (a coordinate-diagonal W):")
def balanced_vertex(m):
    n = 2*m; a = 1.0/np.sqrt((m-1)*(2*m-1)); b = -(m-1)*a/m
    K = np.full((n, n), b); K[:m,:m] = a; K[m:,m:] = a; np.fill_diagonal(K, 0.0); return K
for m in (3, 4, 6):
    n = 2*m
    K = balanced_vertex(m); W = C.weyl_from_vertex(K)
    M = C.M_of(W, n); W = W/np.linalg.norm(M); M = M/np.linalg.norm(M)
    K = C.vertex_matrix(W, n)
    P = null_space(np.ones((1, n))); Kr = P.T @ K @ P
    ev, evec = np.linalg.eigh(Kr); psi = (P @ evec).T
    RW = C.ringW_matrix(W, n, psi_vecs=psi)
    d = np.diag(RW); om = np.linalg.eigvalsh(RW); mu = np.linalg.eigvalsh(M)
    Dm = n*(n-1)//2
    print(f"  n={n}: t={np.linalg.norm(K)**2:.6f} sum_d2={np.sum(d**2):.6f} sum_om2={np.sum(om**2):.6f} "
          f"|sort(om)-sort(d)|={np.abs(np.sort(om)-np.sort(d)).max():.1e} "
          f"|sort(mu)-sort(dphi)|={np.abs(np.sort(mu)-np.sort(d[:Dm])).max():.1e}")
