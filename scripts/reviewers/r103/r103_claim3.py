"""Claim 3: is the Okumura extremiser ever feasible over the vertex class?

Own implementation. Two parts:
  (A) an ANALYTIC threshold, from the psi-block alone, that makes the omega side
      infeasible for every K in the vertex class once t exceeds an explicit number;
  (B) an adversarial numeric search maximising the majorization slack over K,
      instead of 6 random draws.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts/reviewers/r103'))
import r103_core as C
from itertools import combinations
from scipy.optimize import minimize, linprog

def okumura_max(N, s2):
    """argmax of p3 on {sum x = 0, sum x^2 = s2}: one big positive, N-1 equal negatives."""
    a = np.sqrt(s2/(N*(N-1)))
    x = np.full(N, -a); x[0] = (N-1)*a
    return x

def okumura_min(N, s2):
    return -okumura_max(N, s2)

def slack(x, v):
    xs = np.sort(x)[::-1]; vs = np.sort(v)[::-1]
    return float(np.min(np.cumsum(xs) - np.cumsum(vs)))

def dims(n):
    D = n*(n-1)//2
    N = n*(n+1)//2 - 1
    return D, N

print("=== (0) sanity: Okumura vector is the unconstrained extremiser ===")
rng = np.random.default_rng(5)
for N in (15, 20, 66, 77):
    s2 = 3.0
    best = -9e9
    for _ in range(4000):
        x = rng.standard_normal(N); x -= x.mean(); x *= np.sqrt(s2)/np.linalg.norm(x)
        best = max(best, np.sum(x**3))
    ok = np.sum(okumura_max(N, s2)**3)
    print(f" N={N}: random best p3={best:.6f}  Okumura p3={ok:.6f}  "
          f"closed form={(N-2)/np.sqrt(N*(N-1))*s2**1.5:.6f}")

print()
print("=== (A) ANALYTIC threshold: omega-side Okumura is infeasible for EVERY vertex K ===")
print(" mechanism: the psi-block of d is -spec(K|_1perp), a zero-sum vector of length n-1")
print("            with sum of squares t, so max(d) >= sqrt(t/((n-1)(n-2))).")
print("            omega*'s largest entry is b = sqrt(3/(N(N-1))). Infeasible once max(d) > b.")
print(f" {'n':>3} {'N':>4} {'b=sqrt(3/(N(N-1)))':>20} {'t threshold':>13}   verdict over t in [0.5,2]")
for n in (6, 8, 10, 12, 16, 20, 24):
    D, N = dims(n)
    b = np.sqrt(3.0/(N*(N-1)))
    t_thr = 3.0*(n-1)*(n-2)/(N*(N-1))
    print(f" {n:>3} {N:>4} {b:>20.6f} {t_thr:>13.6f}   "
          f"{'infeasible for all t>%.4f' % t_thr}")

print()
print(" numeric check of the bound max(d) >= sqrt(t/((n-1)(n-2))) over random vertex K:")
for n in (6, 8, 12):
    basis, prs = C.vertex_space_basis(n)
    worst = 9e9
    for _ in range(3000):
        c = rng.standard_normal(basis.shape[1])
        K = C.K_from_coords(c, basis, prs, n)
        t = np.linalg.norm(K)**2
        K = K*np.sqrt(1.0/t); t = 1.0
        dphi, d, nu = C.diagonals_from_K(K)
        worst = min(worst, d.max()/np.sqrt(t/((n-1)*(n-2))))
    print(f"  n={n}: min over 3000 draws of max(d)/sqrt(t/((n-1)(n-2))) = {worst:.4f}  (bound says >= 1)")

print()
print("=== (B) adversarial: maximise the majorization slack over K, per (n,t) cell ===")
print(" a positive max slack would make the Okumura vector feasible and refute Claim 3.")
def best_slack(n, t, side, nstart=40, seed=0):
    basis, prs = C.vertex_space_basis(n)
    D, N = dims(n)
    r = np.random.default_rng(seed)
    if side == 'omega':
        target = okumura_min(N, 3.0)
    else:
        target = okumura_max(D, 1.0)
    def negslack(c):
        K = C.K_from_coords(c, basis, prs, n)
        nk = np.linalg.norm(K)
        if nk < 1e-12: return 9e9
        K = K*np.sqrt(t)/nk
        dphi, d, nu = C.diagonals_from_K(K)
        v = d if side == 'omega' else dphi
        return -slack(target, v)
    bb = -9e9; barg = None
    for s in range(nstart):
        c0 = r.standard_normal(basis.shape[1])
        res = minimize(negslack, c0, method='Nelder-Mead',
                       options=dict(maxiter=4000, fatol=1e-10, xatol=1e-10))
        if -res.fun > bb: bb = -res.fun; barg = res.x
    return bb

rows = []
for n in (6, 8, 12):
    for t in (0.25, 0.5, 1.0, 1.5, 1.95, 2.0):
        so = best_slack(n, t, 'omega', nstart=25, seed=n*100+int(t*100))
        sm = best_slack(n, t, 'mu',    nstart=25, seed=n*100+int(t*100)+1)
        rows.append((n, t, so, sm))
        print(f"  n={n:>2} t={t:<5} best omega-slack={so:+.5f}  best mu-slack={sm:+.5f}  "
              f"{'FEASIBLE' if (so>=-1e-9 or sm>=-1e-9) else 'both infeasible'}")
