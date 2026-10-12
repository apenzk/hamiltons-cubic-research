"""Reviewer 63 -- C6: the four refuted closing attempts.

(a) lam_1 <= sqrt(u) bound; (b),(c) uniform duals -- INDEPENDENT feasibility check;
(d) merge-induction.
"""
import sys, itertools, numpy as np
sys.path.insert(0, 'scripts/lib')[0])
from scipy.optimize import linprog, minimize_scalar, minimize
from review_r63_G import G_closed, G, tables, LP_full

TARGET = np.sqrt(1.5)

# ---------------------------------------------------------------- (a)
def attempt_a():
    """Bound  min(lam1<=sqrt u) route:  su - b^3 - c^3 + 6 sqrt(u) bc  (b=c slice + full 2d)."""
    def f(bc):
        """The C3 chain  theta <= lam_1 (s^2 + 6 b c) - b^3 - c^3  with lam_1 <= sqrt(u)."""
        b, c = bc
        if b < 0 or c < 0: return 1e9
        u = 1 - b*b - c*c
        if u < 0: return 1e9
        s = b + c
        return -(np.sqrt(u)*(s*s + 6*b*c) - b**3 - c**3)
    best = (1e9, None)
    for _ in range(1500):
        x0 = np.random.rand(2)
        r = minimize(f, x0, method='Nelder-Mead',
                     options={'xatol':1e-12,'fatol':1e-14,'maxiter':5000})
        if r.fun < best[0]: best = (r.fun, r.x)
    return -best[0], best[1]

# ---------------------------------------------------------------- (b),(c) dual feasibility
def dual_check(lam_pos, b, c, kind):
    """Is the proposed dual (y=0, z as stated) FEASIBLE for the LP whose value is G?

    Primal (for G):  max 3 sum_t T_t w_t  s.t.  sum_{t containing pair p} T_t <= 2, T>=0
    Dual:            min 2 sum_p z_p      s.t.  z_{ab}+z_{ag}+z_{bg} >= 3 lam_a lam_b lam_g,
                                                z >= 0.
    We check every triple of the FULL support (positives + the two negatives).
    """
    lam = np.concatenate([np.asarray(lam_pos, float), [-c, -b]])   # index n-2 = -c, n-1 = -b
    n = len(lam); P = list(range(n-2)); l1 = max(lam_pos)
    z = {}
    for (a, bb) in itertools.combinations(range(n), 2):
        if a in P and bb in P:
            z[(a, bb)] = (1.5 if kind == 'b' else 1.0)*l1*lam[a]*lam[bb]
        elif (a, bb) == (n-2, n-1):
            z[(a, bb)] = 3*l1*b*c
        else:
            z[(a, bb)] = 0.0
    worst = np.inf; worst_t = None
    for t in itertools.combinations(range(n), 3):
        a, bb, g = t
        rhs = 3*lam[a]*lam[bb]*lam[g]
        lhs = z[(a, bb)] + z[(a, g)] + z[(bb, g)]
        if lhs - rhs < worst: worst, worst_t = lhs - rhs, t
    val = 2*sum(z.values())
    dualval = float(np.sum(lam**3)) + val
    return worst, worst_t, dualval, min(z.values())

def stated_value(lam_pos, b, c, kind):
    l1 = max(lam_pos); lam = np.concatenate([lam_pos, [-c, -b]])
    pairsum = sum(lam_pos[i]*lam_pos[j] for i, j in itertools.combinations(range(len(lam_pos)), 2))
    if kind == 'b':
        return float(np.sum(lam**3)) + 3*l1*pairsum + 6*l1*b*c
    return float(np.sum(lam**3)) + 2*l1*pairsum + 6*l1*b*c

# ---------------------------------------------------------------- (d) merge induction
def merge_test(rng, ntrial=200):
    dec = 0; tot = 0; worst = 0.0
    for _ in range(ntrial):
        k = rng.integers(3, 7)
        p = rng.random(k)**rng.uniform(0.3, 3)
        b, c = np.sort(rng.random(2)+1e-3)[::-1]
        p = p*(b+c)/p.sum()
        v = np.concatenate([p, [-b, -c]]); v /= np.linalg.norm(v)
        p = v[:k]; b = -v[-2]; c = -v[-1]
        g0 = G_closed(p, b, c)
        for i, j in itertools.combinations(range(k), 2):
            q = [p[t] for t in range(k) if t not in (i, j)] + [p[i]+p[j]]
            q = np.array(q); w = np.concatenate([q, [-b, -c]]); nrm = np.linalg.norm(w)
            g1 = G_closed(q/nrm, b/nrm, c/nrm)
            tot += 1
            if g1 < g0 - 1e-12:
                dec += 1; worst = max(worst, g0-g1)
    return dec, tot, worst

if __name__ == '__main__':
    np.random.seed(3); rng = np.random.default_rng(3)
    print('=== C6(a) ===')
    v, x = attempt_a()
    print('  max of  sqrt(u)(s^2+6bc) - b^3 - c^3 = %.6f  at b=%.6f c=%.6f  (claim 1.5688 at b=c=0.5465)'%(v, x[0], x[1]))

    print('=== C6(b),(c) dual feasibility (INDEPENDENT) ===')
    for kind, lbl in (('b','z=1.5*lam1*lam_a*lam_b'), ('c','z=lam1*lam_a*lam_b')):
        infeas = 0; nex = 0; mx = 0.0; worst_gap = np.inf; ndraw = 8000; mismatch = 0.0
        for _ in range(ndraw):
            k = rng.integers(1, 8)
            p = rng.random(k)**rng.uniform(0.3, 3)
            b, c = np.sort(rng.random(2)+1e-3)[::-1]
            p = p*(b+c)/p.sum()
            v = np.concatenate([p, [-b, -c]]); v /= np.linalg.norm(v)
            p = v[:k]; b = -v[-2]; c = -v[-1]
            w, wt, dv, zmin = dual_check(p, b, c, kind)
            if w < -1e-12: infeas += 1
            worst_gap = min(worst_gap, w)
            sv = stated_value(p, b, c, kind)
            mismatch = max(mismatch, abs(sv-dv))
            if sv > TARGET + 1e-12:
                nex += 1; mx = max(mx, sv)
            # sanity: dual value must dominate G whenever feasible
            if w >= -1e-12:
                assert dv >= G_closed(p, b, c) - 1e-9, (dv, G_closed(p,b,c))
        print('  (%s) %s : infeasible draws %d/%d (worst slack %.3e); stated value == dual value to %.1e'
              %(kind, lbl, infeas, ndraw, worst_gap, mismatch))
        print('       exceedances of sqrt(3/2): %d/%d, max %.6f'%(nex, ndraw, mx))

    print('=== C6(d) merge induction ===')
    dec, tot, worst = merge_test(rng, 120)
    print('  single merges that DECREASE G: %d of %d (worst drop %.4f)'%(dec, tot, worst))
