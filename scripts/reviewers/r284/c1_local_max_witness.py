"""r284 -- does a Plucker-obstructed critical point pass the second-order test?

D2's stated repair (findings/diagonality.md) is "a second-order argument at the
maximiser": an implication running from maximality to the ABSENCE of a
Plucker-obstructed eigenspace.  This script tests whether local second-order data
can carry such an implication, by measuring both quantities at the one catalogued
non-diagonalisable critical point:

  * the Hessian of P on the unit sphere of Weyl_n is 6*theta*(L_e - 1/2 Id) with
    e = W/theta, so LOCAL MAXIMALITY is  max spec(L_e | W^perp) <= 1/2 ;
  * the Plucker obstruction is  min ||omega ^ omega|| > 0  over the unit sphere of
    some eigenspace of W, with (omega^omega)_{ijkl} = w_ij w_kl + w_ik w_lj + w_il w_jk.

If padded W_{CP^2} is a (degenerate) local maximum AND carries an obstructed
eigenspace, then no purely local second-order test can exclude obstructed
eigenspaces at a maximiser -- the local data at this point is indistinguishable
from that of a maximiser.
"""
import numpy as np, sys, itertools
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, adj, weyl_basis, Q, circ, orbit_tangent
from b_cp2_nondegenerate import padded_cp2
from b_cpm_closed_form import W_cpm


def le_spectrum(n, W, B):
    """Spectrum of L_e = e o (.) on Weyl_n, e = W/theta, and on W^perp."""
    th = float(np.tensordot(W, Q(n, W)))
    e = W / th
    D = len(B)
    Bf = B.reshape(D, -1)
    M = np.zeros((D, D))
    for k in range(D):
        M[:, k] = Bf @ circ(n, e, B[k]).ravel()
    M = 0.5 * (M + M.T)
    w = np.linalg.eigvalsh(M)
    # restrict to W^perp
    c = Bf @ W.ravel()
    c = c / np.linalg.norm(c)
    Pp = np.eye(D) - np.outer(c, c)
    wp = np.linalg.eigvalsh(Pp @ M @ Pp)
    return th, w, wp, c, M


def wedge_norm(w, n):
    """|| omega ^ omega ||, omega a skew n x n matrix."""
    tot = 0.0
    for i, j, k, l in itertools.combinations(range(n), 4):
        v = w[i, j] * w[k, l] + w[i, k] * w[l, j] + w[i, l] * w[j, k]
        tot += v * v
    return np.sqrt(tot)


def to_skew(vec, pairs, n):
    w = np.zeros((n, n))
    for a, (i, j) in enumerate(pairs):
        w[i, j] = vec[a]; w[j, i] = -vec[a]
    return w


def plucker_min(W, n, tol=1e-8, tries=60, seed=0):
    """For each eigenspace of W, min ||omega^omega|| over its unit sphere."""
    pairs, idx = pair_index(n)
    ev, V = np.linalg.eigh(W)
    groups, cur = [], [0]
    for a in range(1, len(ev)):
        if abs(ev[a] - ev[cur[-1]]) < 1e-9:
            cur.append(a)
        else:
            groups.append(cur); cur = [a]
    groups.append(cur)
    out = []
    rng = np.random.default_rng(seed)
    for g in groups:
        U = V[:, g]
        d = len(g)
        if d == 1:
            x = U[:, 0]
            out.append((ev[g[0]], d, wedge_norm(to_skew(x, pairs, n), n)))
            continue
        best = np.inf
        for _ in range(tries):
            c = rng.normal(size=d); c /= np.linalg.norm(c)
            step = 0.3
            f = wedge_norm(to_skew(U @ c, pairs, n), n)
            for _ in range(600):
                c2 = c + step * rng.normal(size=d)
                c2 /= np.linalg.norm(c2)
                f2 = wedge_norm(to_skew(U @ c2, pairs, n), n)
                if f2 < f: c, f = c2, f2
                else: step *= 0.99
            best = min(best, f)
        out.append((ev[g[0]], d, best))
    return out


if __name__ == "__main__":
    for n in (8, 12):
        W, B = padded_cp2(n)
        th, w, wp, c, M = le_spectrum(n, W, B)
        res = np.linalg.norm(Q(n, W) - th * W)
        print(f"n={n}  dim Weyl={len(B)}  theta={th:.12f}  (sqrt(3/2)={np.sqrt(1.5):.12f})"
              f"  criticality residual={res:.2e}", flush=True)
        print(f"   L_e spectrum on Weyl:   max={w[-1]:.12f}   (e itself has L_e e = e, eigenvalue 1)")
        print(f"   L_e spectrum on W^perp: max={wp[-1]:.12f}   -> Hessian max = {6*th*(wp[-1]-0.5):+.3e}")
        print(f"   count of L_e|W^perp eigenvalues > 1/2 + 1e-8: "
              f"{int((wp > 0.5 + 1e-8).sum())}, at 1/2 +- 1e-8: {int((abs(wp-0.5)<1e-8).sum())}")
        pm = plucker_min(W, n)
        for lam, d, m in pm:
            print(f"   eigenvalue {lam:+.6f} (dim {d}): min ||w^w|| = {m:.6f}")
        print(flush=True)
