"""Is  T(E(1/2), E(1/2), E(1/2)) = 0  a general fact at critical points?

If it is, the SECOND-order obstruction to a critical branch is vacuous at every
critical point, degenerate or not, and no second-order argument can decide openness.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys
import numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r54_core import (P, Q, circ, weyl_basis, Le_matrix, orbit_tangent, onb_rows)
from review_r54_k1k2 import blowup_W, cycle

def sphere_W(blocks):
    from review_r54_core import pairs_of
    n = sum(blocks); ps, idx = pairs_of(n)
    lab = []
    for bi, b in enumerate(blocks): lab += [bi]*b
    W = np.zeros((len(ps), len(ps)))
    for a, (i, j) in enumerate(ps):
        if lab[i] == lab[j]:
            p = blocks[lab[i]]; W[a, a] = 1.0/(p*(p-1))
        else:
            p, q = blocks[lab[i]], blocks[lab[j]]; W[a, a] = -1.0/(p*q)
    return W

def check(name, W, n, rng):
    W = W/np.linalg.norm(W)
    th = P(n, W)
    res = np.linalg.norm(Q(n, W) - th*W)
    B = weyl_basis(n)
    M = Le_matrix(n, W/th, B)
    ev, V = np.linalg.eigh(M)
    H = V[:, np.abs(ev - 0.5) < 1e-8]
    X = np.einsum('dk,dmn->kmn', H, B)
    r = H.shape[1]
    if r == 0:
        print(f"{name:>26} n={n:2d} theta={th:.6f} dim E(1/2)=0")
        return
    vals = []
    for _ in range(12):
        a, b, c = [rng.normal(size=r) for _ in range(3)]
        Y = [np.einsum('k,kmn->mn', z, X) for z in (a, b, c)]
        sc = np.prod([np.linalg.norm(y) for y in Y])
        vals.append(abs(float(np.tensordot(Y[0], circ(n, Y[1], Y[2]))))/sc)
    orb = onb_rows(orbit_tangent(n, W)).shape[0]
    lam = np.sort(np.linalg.eigvalsh(M - np.outer(*(2*[np.einsum('dmn,mn->d', B, W)/np.linalg.norm(np.einsum('dmn,mn->d', B, W))]))*1e9))
    print(f"{name:>26} n={n:2d} theta={th:.6f} resid={res:.0e} dimE(1/2)={r:4d} orbit={orb:3d} "
          f"excess={r-orb:4d}  max |T|/(|x||y||z|) on E(1/2)^3 = {max(vals):.2e}")

if __name__ == "__main__":
    rng = np.random.default_rng(9)
    W, n, _ = blowup_W([2]*5, cycle(5), 4.0, -2.0, 1.0)
    check("C_5 blow-up (2,2,2,2,2)", W, n, rng)
    for blocks in [(3,3), (4,4), (3,5)]:
        check(f"sphere product {blocks}", sphere_W(blocks), sum(blocks), rng)
    # true multi-block critical points: w_ab = -th/(n-1), w_aa = th(n-n_a)/((n-1)(n_a-1))
    from review_r54_core import pairs_of
    def multiblock_W(blocks):
        n = sum(blocks); ps, idx = pairs_of(n)
        lab = []
        for bi, b in enumerate(blocks): lab += [bi]*b
        Wf = np.zeros((len(ps), len(ps)))
        for a, (i, j) in enumerate(ps):
            if lab[i] == lab[j]:
                na = blocks[lab[i]]; Wf[a, a] = (n - na)/((n-1)*(na-1))
            else:
                Wf[a, a] = -1.0/(n-1)
        return Wf
    for blocks in [(3,3,3), (2,2,4), (2,3,3), (2,2,2,2), (4,4,4), (3,3,3,3)]:
        check(f"multiblock {blocks}", multiblock_W(blocks), sum(blocks), rng)
    # a random critical point found by descent, for a non-structured control
    from scipy.optimize import least_squares
    from review_r54_correct import make_resid
    for n in (8, 9):
        B = weyl_basis(n); resid, jacf = make_resid(n, B)
        for s in range(2):
            c0 = rng.normal(size=len(B)); c0 /= np.linalg.norm(c0)
            sol = least_squares(resid, c0, jac=jacf, method='lm', xtol=1e-15, ftol=1e-15,
                                gtol=1e-15, max_nfev=300)
            if np.linalg.norm(resid(sol.x)) > 1e-9: continue
            Wr = np.einsum('d,dij->ij', sol.x, B)
            if P(n, Wr) < 0: Wr = -Wr
            if P(n, Wr) < 1e-6: continue
            check(f"random critical n={n} #{s}", Wr, n, rng)
