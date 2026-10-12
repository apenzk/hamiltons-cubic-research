"""Reviewer 53, phase 1: validation gates before any claim is attacked.

  (a) dim Weyl_n against n(n+1)(n+2)(n-3)/12
  (b) total symmetry of T(X,Y,Z) = <X, Y o Z>
  (c) tr(L_x) = 0 on Weyl_n for arbitrary x
  (d) L_e W = W at a known critical point (balanced two-block sphere product)
  (e) Ricci / Bianchi / criticality of the balanced sphere product, theta = theta_0(n)
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys
import time

import numpy as np

sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r53_core import (Le_matrix, Npairs, Pval, Qop, alt, circ, dim_weyl,
                             dim_weyl_formula, orbit_tangent, onb_rows, pairs_of,
                             ricci, theta0, weyl_basis)

LOG = _os.path.join(_ROOT, 'agent_logs/review_r53_multiblock.log')


def log(msg):
    line = f"[{time.strftime('%H:%M:%S')}] {msg}"
    print(line, flush=True)
    with open(LOG, 'a') as f:
        f.write(line + '\n')


def two_block_W(p, q):
    """Weyl operator of S^p x S^q, coordinate-diagonal, from the vertex values
    w_aa = (n-n_a)/((n-1)(n_a-1)) inside block a, w_ab = -1/(n-1) across."""
    n = p + q
    prs, idx = pairs_of(n)
    lab = [0] * p + [1] * q
    sz = (p, q)
    lam = np.zeros(len(prs))
    for a, (i, j) in enumerate(prs):
        if lab[i] == lab[j]:
            na = sz[lab[i]]
            lam[a] = (n - na) / ((n - 1) * (na - 1))
        else:
            lam[a] = -1.0 / (n - 1)
    return np.diag(lam)


def main():
    log("PHASE 1 validation: dim Weyl / trilinear symmetry / tr L_x / L_e W = W")

    # (a) dim Weyl_n
    for n in range(4, 13):
        t0 = time.time()
        d = dim_weyl(n)
        f = dim_weyl_formula(n)
        log(f"  dim Weyl_{n} = {d} (formula {f}) {'OK' if d == f else 'MISMATCH'}"
            f"  [{time.time()-t0:.1f}s]")

    # (b) trilinear symmetry at n=6
    n = 6
    rng = np.random.default_rng(53)
    B = weyl_basis(n)
    N = Npairs(n)
    worst = 0.0
    for _ in range(5):
        X, Y, Z = [sum(rng.normal() * b for b in B) for _ in range(3)]
        vals = [float(np.sum(X * circ(n, Y, Z))),
                float(np.sum(Y * circ(n, X, Z))),
                float(np.sum(Z * circ(n, X, Y)))]
        worst = max(worst, max(vals) - min(vals))
    log(f"  trilinear symmetry of <X, YoZ> at n=6: spread {worst:.3e}")

    # symmetry on general (non-Weyl) symmetric operators too
    worst2 = 0.0
    for _ in range(3):
        Ms = [rng.normal(size=(N, N)) for _ in range(3)]
        Ms = [0.5 * (M + M.T) for M in Ms]
        X, Y, Z = Ms
        vals = [float(np.sum(X * circ(n, Y, Z))),
                float(np.sum(Y * circ(n, X, Z))),
                float(np.sum(Z * circ(n, X, Y)))]
        worst2 = max(worst2, max(vals) - min(vals))
    log(f"  trilinear symmetry on all of Sym^2 at n=6: spread {worst2:.3e}")

    # (c) tr(L_x) = 0 on Weyl_n
    for n in (6, 8):
        B = weyl_basis(n)
        N = Npairs(n)
        rngl = np.random.default_rng(7)
        x = sum(rngl.normal() * b for b in B)
        M = Le_matrix(n, x, B)
        log(f"  tr(L_x) on Weyl_{n} (random Weyl x): {np.trace(M):.3e}"
            f"   dim={B.shape[0]}")

    # (d)+(e) balanced sphere products
    log("  balanced two-block sphere products:")
    for (p, q) in [(3, 3), (4, 4), (5, 5), (4, 5), (3, 5), (6, 6)]:
        n = p + q
        W = two_block_W(p, q)
        rn = np.linalg.norm(ricci(n, W))
        an = np.linalg.norm(alt(n, W))
        Wn = W / np.linalg.norm(W)
        th = Pval(n, Wn)
        res = np.linalg.norm(Qop(n, Wn) - th * Wn)
        e = Wn / th
        LeW = circ(n, e, Wn)
        d1 = np.linalg.norm(LeW - Wn)
        log(f"    S^{p}xS^{q} n={n}: |Ric|={rn:.2e} |Alt|={an:.2e} theta={th:.9f} "
            f"theta_0={theta0(n):.9f} resid={res:.2e} |L_e W - W|={d1:.2e}")

    # dim E(1/2) vs orbit at S^4 x S^4  (known nondegenerate)
    n = 8
    W = two_block_W(4, 4)
    W = W / np.linalg.norm(W)
    th = Pval(n, W)
    B = weyl_basis(n)
    M = Le_matrix(n, W / th, B)
    ev = np.linalg.eigvalsh(M)
    dimE = int((np.abs(ev - 0.5) < 1e-8).sum())
    orb = onb_rows(orbit_tangent(n, W)).shape[0]
    log(f"  S^4xS^4 n=8: dim E(1/2)={dimE}  orbit={orb}  "
        f"{'nondegenerate' if dimE == orb else 'DEGENERATE'}")
    log("PHASE 1 validation done")


if __name__ == '__main__':
    main()
