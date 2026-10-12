"""r68: C1 (two marginal identities, with multiplicities) and C2 (gamma = 2 S_mhh)."""
import sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
import numpy as np
import review_r68_core as R

rng = np.random.default_rng(68)

def mu_direct(n, V, m, C):
    """mu = sum_{a,b in m} ||[e_a,e_b]||^2, computed from brackets, not from T."""
    tot = 0.0
    for a in m:
        for b in m:
            br = np.einsum('pqr,p,q->r', C, V[:, a], V[:, b])
            tot += float(br @ br)
    return tot

def X_direct(n, V, m, h, C):
    tot = 0.0
    for a in m:
        for b in h:
            br = np.einsum('pqr,p,q->r', C, V[:, a], V[:, b])
            tot += float(br @ br)
    return tot

print("=== C1: 6Smmm+4Smmh+2Smhh = 2d(n-2) and 6Shhh+4Smhh+2Smmh = 2(N-d)(n-2) ===")
print("   also C2: gamma := 2(n-2)d - 2mu  vs  2 S_mhh - 6 S_mmm")
for n in [5, 6, 7, 8]:
    C = R.struct(n)
    N = n * (n - 1) // 2
    cases = [('cp2', R.padded_cp2(n)), ('sphere', R.sphere_product(n, n // 2))]
    for k in range(4):
        A = rng.normal(size=(N, N)); A = (A + A.T) / 2
        A -= np.trace(A) / N * np.eye(N)      # traceless, generic (NOT a Weyl operator)
        cases.append(('rand%d' % k, A / np.linalg.norm(A)))
    for name, W in cases:
        a = R.analyse(n, W, C)
        S, d = a['S'], a['d']
        i1 = 6*S['mmm'] + 4*S['mmh'] + 2*S['mhh']
        i2 = 6*S['hhh'] + 4*S['mhh'] + 2*S['mmh']
        mu = mu_direct(n, a['V'], a['m'], C)
        Xm = X_direct(n, a['V'], a['m'], a['h'], C)
        gamma = 2*(n-2)*d - 2*mu
        print(f"n={n} {name:7s} d={d:3d} | id1 {i1:12.6f} vs {2*d*(n-2):12.6f} err {abs(i1-2*d*(n-2)):.2e}"
              f" | id2 {i2:12.6f} vs {2*(N-d)*(n-2):12.6f} err {abs(i2-2*(N-d)*(n-2)):.2e}"
              f" | mu {mu:10.5f} vs 6Smmm+2Smmh {6*S['mmm']+2*S['mmh']:10.5f}"
              f" | X {Xm:10.5f} vs 2Smmh+2Smhh {2*S['mmh']+2*S['mhh']:10.5f}"
              f" | mu+X {mu+Xm:10.5f} vs 2d(n-2) {2*d*(n-2):10.5f}"
              f" | gamma {gamma:10.5f} vs 2Smhh {2*S['mhh']:10.5f} vs 2Smhh-6Smmm {2*S['mhh']-6*S['mmm']:10.5f}")

print()
print("=== pair cap: max ||[X,Y]||^2 over orthonormal pairs in so(n) ===")
from scipy.optimize import minimize
for n in [4, 5, 6, 7, 8, 9, 10]:
    C = R.struct(n)
    N = n * (n - 1) // 2
    best = 0.0
    for trial in range(40):
        z0 = rng.normal(size=2 * N)
        def neg(z):
            x, y = z[:N], z[N:]
            x = x / np.linalg.norm(x)
            y = y - (y @ x) * x
            y = y / np.linalg.norm(y)
            br = np.einsum('pqr,p,q->r', C, x, y)
            return -float(br @ br)
        r = minimize(neg, z0, method='Nelder-Mead',
                     options=dict(maxiter=20000, maxfev=20000, fatol=1e-12, xatol=1e-10))
        best = max(best, -r.fun)
    print(f"n={n}: max ||[X,Y]||^2 = {best:.9f}  (cap claimed 2)")
