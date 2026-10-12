"""G1: second-order optimality is L_e <= 1/2 on W^perp.  Does S > 0 force a
violation, and how does the margin trade off against theta?

At a critical point Q(W) = theta W, the constrained Hessian of P on the unit
sphere is 6 theta (L_e - 1/2 Id) with e = W/theta, L_e = e o (.).  So a maximizer
must have lam_max(L_e | W^perp) <= 1/2, with equality on the orbit tangent.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import sys, itertools
import numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import alt_mop, delta2_and_grad

CACHE = {}
def setup(n):
    if n in CACHE: return CACHE[n]
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n); alt_idx = build_alt_indices(L2)
    sym = []
    for a in range(N):
        for b in range(a, N):
            M = np.zeros((N, N)); M[a, b] = M[b, a] = 1.0
            sym.append(M/np.linalg.norm(M))
    rows = [np.concatenate([ricci_from_mop(L2, M).ravel(), alt_mop(M, alt_idx).ravel()])
            for M in sym]
    A = np.array(rows).T
    U, s, Vt = np.linalg.svd(A, full_matrices=True)
    ker = Vt[int(np.sum(s > 1e-9*s[0])):]
    B = [sum(v[k]*sym[k] for k in range(len(sym))) for v in ker]
    B = [M/np.linalg.norm(M) for M in B]
    CACHE[n] = (N, c, L2, alt_idx, B)
    return CACHE[n]

def slack(L2, W, c, alt_idx, th):
    ev, V = np.linalg.eigh(W); neg = ev < 0
    Wm = (V[:, neg]*(-ev[neg])) @ V[:, neg].T
    d2 = delta2_and_grad(W, alt_idx)[0]
    ric = ricci_from_mop(L2, Wm)
    return float(np.sum(ric*ric)) + 6*d2 - th*float(np.trace(Wm)) - float(np.trace(Wm@Wm))

def analyse(name, n, W):
    N, c, L2, alt_idx, B = setup(n)
    W = W/np.linalg.norm(W)
    QW = Q_full(W, c); th = float(np.sum(W*QW))
    res = np.linalg.norm(QW - th*W)
    if res > 1e-7: return None
    e = W/th
    circ = lambda X, Y: 0.5*(Q_full(X+Y, c) - Q_full(X, c) - Q_full(Y, c))
    img = [circ(e, b) for b in B]
    M = np.array([[np.sum(B[i]*img[j]) for j in range(len(B))] for i in range(len(B))])
    M = 0.5*(M+M.T)
    # restrict to W^perp inside the Weyl space
    wv = np.array([np.sum(W*b) for b in B]); wv /= np.linalg.norm(wv)
    Pp = np.eye(len(B)) - np.outer(wv, wv)
    ev = np.linalg.eigvalsh(Pp @ M @ Pp)
    lam = float(np.sort(ev)[-2]) if abs(ev[-1]-1) < 1e-6 else float(ev[-1])
    S = slack(L2, W, c, alt_idx, th)
    return dict(name=name, n=n, theta=th, S=S, lam=lam, res=res)

def sphere_multi(n, parts):
    """Vertex solution: w_aa = (n-n_a)/((n-1)(n_a-1)) inside block a,
    w_ab = -1/(n-1) across blocks (theta drops out under normalisation)."""
    N = n*(n-1)//2; prs = list(itertools.combinations(range(n), 2))
    blk = []; s = 0
    for q in parts: blk.append(list(range(s, s+q))); s += q
    which = {i: bi for bi, b in enumerate(blk) for i in b}
    lam = np.zeros(N)
    for a, (i, j) in enumerate(prs):
        bi, bj = which[i], which[j]
        if bi == bj:
            na = len(blk[bi]); lam[a] = (n - na)/((n-1)*(na-1))
        else:
            lam[a] = -1.0/(n-1)
    return np.diag(lam)

rows = []
for (n, parts, nm) in [(8, (4,4), "S4xS4"), (8, (3,5), "S3xS5"),
                       (9, (3,3,3), "(S3)^3"), (12, (4,4,4), "(S4)^3"),
                       (10, (5,5), "S5xS5"), (12, (6,6), "S6xS6"),
                       (12, (3,3,3,3), "(S3)^4"), (12, (2,5,5), "S2xS5xS5")]:
    r = analyse(nm, n, sphere_multi(n, parts))
    if r: rows.append(r)

print(f"{'point':>12} {'n':>3} {'theta':>10} {'slack S':>10} {'lam_max':>10} {'margin':>9}")
for r in sorted(rows, key=lambda d: -d['theta']):
    print(f"{r['name']:>12} {r['n']:3d} {r['theta']:10.6f} {r['S']:10.6f} "
          f"{r['lam']:10.6f} {0.5-r['lam']:9.6f}")

# ---- decoupled test: the subalgebra family, where gradedness varies with no block count ----
from p5_casimir_family import (projector, casimir_operator, h_adjoint, h_so3_in_so5,
                               su3_structure_constants, so_k_structure_constants,
                               h_so_p_so_q)
print("\ndecoupled population (subalgebra family):")
print(f"{'point':>24} {'n':>3} {'theta':>10} {'slack S':>10} {'lam_max':>10} {'margin':>9}")
cases = [("su(3) adjoint", 8, h_adjoint(su3_structure_constants())),
         ("so(5) adjoint", 10, h_adjoint(so_k_structure_constants(5))),
         ("so(3) irred in so(5)", 5, h_so3_in_so5()),
         ("so(4)+so(4) balanced", 8, h_so_p_so_q(8, 4)),
         ("so(5)+so(5) balanced", 10, h_so_p_so_q(10, 5))]
for nm, n, gens in cases:
    N, c, L2, alt_idx, B = setup(n)
    Pi, r = projector(gens, n)
    W = casimir_operator(Pi, r, N)
    out = analyse(nm, n, W)
    if out is None:
        print(f"{nm:>24} {n:3d}   (not critical -- excluded)")
    else:
        print(f"{nm:>24} {n:3d} {out['theta']:10.6f} {out['S']:10.6f} "
              f"{out['lam']:10.6f} {0.5-out['lam']:9.6f}")
