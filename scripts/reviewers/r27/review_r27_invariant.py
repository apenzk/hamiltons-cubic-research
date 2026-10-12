"""Reviewer 27: solve criticality inside the h-invariant part of the Weyl space, for any subalgebra h.
Used to hunt for further GRADED critical points that violate lambda_max <= 1/2."""
import sys
import numpy as np
from itertools import combinations
import review_r27_core as C, review_r27_points as PT, review_r27_measure as M


def invariant_basis(n, gens):
    """Orthonormal basis of {X in Weyl_n : [rho(g), X] = 0 for all g in h}."""
    B = C.weyl_basis(n)
    D = B.shape[0]
    pr, idx, c = C.struct(n)
    N = len(pr)
    rows = []
    for X in gens:
        v = np.array([X[i, j] for (i, j) in pr])
        rho = np.einsum('g,gmn->mn', v, C.Aops(n))         # action of X on Lambda^2
        Mt = np.einsum('kab,lab->kl', B, np.einsum('ap,lpq->laq', rho, B) - np.einsum('lpq,qb->lpb', B, rho))
        rows.append(Mt)
    A = np.vstack(rows)
    u, s, vt = np.linalg.svd(A)
    rk = int((s > 1e-9 * max(s.max(), 1)).sum())
    K = vt[rk:]
    return np.einsum('kd,dab->kab', K, B), K, B


def solve_in(n, gens, name, ntry=60):
    from scipy.optimize import least_squares
    Binv, K, B = invariant_basis(n, gens)
    d = Binv.shape[0]
    print('\n== %s (n=%d): dim Weyl^h = %d' % (name, n, d))
    if d == 0:
        return
    rng = np.random.default_rng(11)
    seen = []
    for t in range(ntry):
        c0 = rng.normal(size=d); c0 /= np.linalg.norm(c0)

        def res(co):
            W = np.einsum('k,kab->ab', co, Binv)
            QW = C.Q(n, W)
            th = float(np.trace(W @ QW))
            r = np.einsum('kab,ab->k', Binv, QW - th * W)
            return np.concatenate([r, [10 * (co @ co - 1)]])
        sol = least_squares(res, c0, xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=4000)
        if np.linalg.norm(sol.fun) > 1e-10:
            continue
        co = sol.x / np.linalg.norm(sol.x)
        W = np.einsum('k,kab->ab', co, Binv)
        th = float(np.trace(W @ C.Q(n, W)))
        if th < 0:
            W, th = -W, -th
        if th < 1e-8:
            continue
        if any(abs(th - s) < 1e-8 for s in seen):
            continue
        seen.append(th)
        o = M.analyse(n, W, name)
        S, neg, U, ev = M.gradedness(n, W)
        th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
        print('   theta=%.9f (th0=%.6f) res=%.1e Ric=%.1e Alt=%.1e S_mmm=%10.4f dim m=%3d lam_max=%.12f  %s'
              % (th, th0, o['res'], o['ric'], o['alt'], S, neg.shape[1], o['lam_max'],
                 ('GRADED ' + ('*** VIOLATES ***' if o['lam_max'] > 0.5 + 1e-8 else 'ok')) if S < 1e-7 else 'ungraded'))
        sys.stdout.flush()


def gens_um(m):
    g = []
    for a in range(m):
        for b in range(a + 1, m):
            X = np.zeros((2 * m, 2 * m))
            X[2 * a, 2 * b] = 1; X[2 * b, 2 * a] = -1
            X[2 * a + 1, 2 * b + 1] = 1; X[2 * b + 1, 2 * a + 1] = -1
            g.append(X)
            Y = np.zeros((2 * m, 2 * m))
            Y[2 * a, 2 * b + 1] = 1; Y[2 * b + 1, 2 * a] = -1
            Y[2 * a + 1, 2 * b] = -1; Y[2 * b, 2 * a + 1] = 1
            g.append(Y)
    for a in range(m):
        Z = np.zeros((2 * m, 2 * m))
        Z[2 * a, 2 * a + 1] = 1; Z[2 * a + 1, 2 * a] = -1
        g.append(Z)
    return g


def check_subalgebra(gens, tag):
    k = len(gens)
    V = np.array([g.ravel() for g in gens])
    ok = True
    for a in range(k):
        for b in range(k):
            cm = (gens[a] @ gens[b] - gens[b] @ gens[a]).ravel()
            r = np.linalg.lstsq(V.T, cm, rcond=None)
            if np.linalg.norm(V.T @ r[0] - cm) > 1e-9:
                ok = False
    print('%s: %d generators, closed under bracket: %s' % (tag, k, ok))
    return ok


if __name__ == '__main__':
    for m in [3, 4, 5]:
        g = gens_um(m)
        check_subalgebra(g, 'u(%d) in so(%d)' % (m, 2 * m))
        solve_in(2 * m, g, 'u(%d) in so(%d)' % (m, 2 * m))
    for (p, q) in [(2, 6), (2, 8), (3, 5)]:
        solve_in(p + q, PT.gens_so_direct_sum(p + q, [p, q]), 'so(%d)+so(%d)' % (p, q))
