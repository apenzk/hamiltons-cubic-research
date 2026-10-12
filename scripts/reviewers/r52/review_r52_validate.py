"""Reviewer 52 phase 1: gatekeeper validation of the independent machinery."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time
import numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
import review_r52_core as K

RNG = np.random.default_rng(52)
LOG = _os.path.join(_ROOT, 'agent_logs/review_r52_multiblock.log')
def log(m):
    line = f"[{time.strftime('%H:%M:%S')}] {m}"
    print(line, flush=True)
    with open(LOG, 'a') as f:
        f.write(line + '\n')


def sphere_multi_vertex(n, parts):
    """w_aa = (n-n_a)/((n-1)(n_a-1)) inside block a, w_ab = -1/(n-1) across."""
    prs, idx = K.pairs_of(n)
    which = {}
    s = 0
    for bi, q in enumerate(parts):
        for i in range(s, s + q):
            which[i] = bi
        s += q
    lam = np.zeros(len(prs))
    for a, (i, j) in enumerate(prs):
        if which[i] == which[j]:
            na = parts[which[i]]
            lam[a] = (n - na) / ((n - 1) * (na - 1))
        else:
            lam[a] = -1.0 / (n - 1)
    return np.diag(lam)


if __name__ == '__main__':
    log("PHASE 1 validate: start")
    # 1. structure constants totally antisymmetric
    for n in (5, 6, 7):
        c = K.cstruct(n)
        a1 = np.abs(c + c.transpose(1, 0, 2)).max()
        a2 = np.abs(c - c.transpose(1, 2, 0)).max()
        log(f"  n={n} c antisym: swap12 {a1:.1e}  cyclic {a2:.1e}")
    # 2. dim Weyl_n
    for n in range(4, 13):
        t = time.time()
        d = K.weyl_basis(n, True).shape[0]
        log(f"  dim Weyl_{n} = {d} (formula {K.dim_weyl_formula(n)}) "
            f"{'OK' if d == K.dim_weyl_formula(n) else 'MISMATCH'} [{time.time()-t:.1f}s]")
    # 3. diagonal sharp formula
    n = 6
    prs, idx = K.pairs_of(n)
    lam = RNG.standard_normal(len(prs))
    W = np.diag(lam)
    Sh = K.sharp(n, W)
    err = 0.0
    for a, (i, j) in enumerate(prs):
        pred = sum(lam[idx[(min(i, k), max(i, k))]] * lam[idx[(min(j, k), max(j, k))]]
                   for k in range(n) if k not in (i, j))
        err = max(err, abs(Sh[a, a] - pred))
    off = np.abs(Sh - np.diag(np.diag(Sh))).max()
    log(f"  diagonal # formula n=6: diag err {err:.1e}, offdiag {off:.1e}")
    # 4. polarization consistency and trilinear symmetry
    n = 6
    B = K.weyl_basis(n)
    X, Y, Z = [sum(v[k] * B[k] for k in range(len(B)))
               for v in RNG.standard_normal((3, len(B)))]
    pol = 0.5 * (K.Q(n, X + Y) - K.Q(n, X) - K.Q(n, Y))
    log(f"  circ == polarization: {np.abs(pol - K.circ(n, X, Y)).max():.1e}")
    T = lambda A, Bm, C: float(np.tensordot(A, K.circ(n, Bm, C)))
    vals = [T(X, Y, Z), T(Y, X, Z), T(Z, Y, X), T(X, Z, Y), T(Y, Z, X), T(Z, X, Y)]
    log(f"  trilinear symmetry spread: {max(vals)-min(vals):.2e} (value {vals[0]:.6f})")
    # 5. known critical point + L_e W = W
    for (n, parts) in ((6, (3, 3)), (8, (4, 4)), (10, (5, 5)), (9, (4, 5))):
        W = sphere_multi_vertex(n, parts)
        W = W / np.linalg.norm(W)
        th = K.P_val(n, W)
        res = np.linalg.norm(K.Q(n, W) - th * W)
        ric = np.abs(K.ricci(n, W)).max()
        bia = np.abs(K.alt(n, W)).max()
        e = W / th
        LW = K.circ(n, e, W)
        log(f"  S^{parts[0]}xS^{parts[1]} n={n}: theta={th:.9f} theta0={K.theta0(n):.9f} "
            f"resid={res:.1e} |Ric|={ric:.1e} |Alt|={bia:.1e} |L_eW-W|={np.linalg.norm(LW-W):.1e}")
    # 6. tr(L_x) = 0
    for n in (6, 8):
        B = K.weyl_basis(n)
        x = sum(v * b for v, b in zip(RNG.standard_normal(len(B)), B))
        M = K.Le_matrix(n, x)
        log(f"  n={n} tr(L_x) on Weyl_n = {np.trace(M):.2e}  (|x|={np.linalg.norm(x):.3f}), "
            f"sym err {np.abs(M-M.T).max():.1e}")
    # 7. Killing constant tr(L_x^2) = kappa |x|^2, kappa=(2n-1)(n-1)/4
    for n in (6, 8):
        B = K.weyl_basis(n)
        x = sum(v * b for v, b in zip(RNG.standard_normal(len(B)), B))
        x = x / np.linalg.norm(x)
        M = K.Le_matrix(n, x)
        log(f"  n={n} tr(L_x^2)={np.trace(M@M):.6f} vs (2n-1)(n-1)/4={(2*n-1)*(n-1)/4:.6f}")
    log("PHASE 1 validate: done")
