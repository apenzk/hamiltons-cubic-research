"""
B2 probe: is the DIAGONAL case SOS-certifiable, and at what degree?

The full n=12 problem needs a degree-4 SOS in 1638 variables -- a Gram matrix of
~1.34e6 rows, out of reach without the isotypic decomposition of Sym^2(W_n).  And
the usual escape of debugging at small n is closed there, because the statement is
FALSE below n=12, so no certificate exists to find.

The diagonal locus has neither problem: dim n(n-3)/2 (54 at n=12), and the
diagonal statement is TRUE at every even n, so small n is a legitimate testbed.

Over V_n = {Lambda symmetric, hollow, Lambda 1 = 0} with an orthonormal basis
(so ||Lambda||_F = ||x||),  Theta(x) = sqrt2 (sum_{i!=j} Lambda_ij^3 + tr Lambda^3),
and the claim is  max_{||x||=1} Theta = theta0(n) = sqrt(2(n-1)(n-2))/n.

Rather than test feasibility at theta0 -- which a buggy encoding can always
satisfy -- we SOLVE for the best bound the method gives:

    minimise t   s.t.   t - Theta(x) - (a + b||x||^2)(1 - ||x||^2)  is SOS (degree 4).

t* is then the degree-4 SOS upper bound on max Theta.  t* = theta0(n) means the
certificate is exact; t* > theta0(n) is a quantified failure and the degree must
rise.  The encoding is validated by comparing t* against theta0(n) and against the
true maximum found by direct ascent.

COST, measured: the SDP is 0.0s at n=4, 0.8s at n=6, 106s at n=8, and did not
finish at n=10 within ~16 minutes (Gram 666x666, 82251 coefficient constraints);
n=10 is dropped from the sweep for that reason.  n=12 (Gram 1540x1540, 424270
constraints) is well out of reach this way, so carrying the probe to the target
dimension requires the symmetry reduction, not more patience.

CAVEAT: the diagonal statement holds at every even n, so it does NOT see the
n = 6 + 2 sqrt 7 crossover -- S^4(alpha) is not diagonal and does not live here.
A certificate here tests machinery and degree, not the mechanism the full
conjecture needs, and does not satisfy plan.md's sanity filter.
"""
import numpy as np, itertools, cvxpy as cp, time
from scipy.linalg import null_space

def basis(n):
    pairs = [(i, j) for i in range(n) for j in range(i+1, n)]
    A = np.zeros((n, len(pairs)))
    for k, (i, j) in enumerate(pairs):
        A[i, k] = A[j, k] = 1.0
    Z = null_space(A)
    B = np.zeros((Z.shape[1], n, n))
    for t in range(Z.shape[1]):
        for k, (i, j) in enumerate(pairs):
            B[t, i, j] = B[t, j, i] = Z[k, t]
    G = np.einsum('aij,bij->ab', B, B)
    L = np.linalg.cholesky(np.linalg.inv(G))
    return np.einsum('ab,bij->aij', L.T, B)

def cubic_tensor(n):
    B = basis(n)
    t1 = np.einsum('kij,lij,mij->klm', B, B, B)
    t2 = np.einsum('kij,ljp,mpi->klm', B, B, B)
    return np.sqrt(2.0)*(t1 + t2), B

theta0 = lambda n: np.sqrt(2.0*(n-1)*(n-2))/n

def theta_of(x, T):
    return float(np.einsum('klm,k,l,m->', T, x, x, x))

def true_max(T, d, restarts=400, seed=3):
    """Direct projected ascent on the sphere, as ground truth for the SOS bound."""
    rng = np.random.default_rng(seed); best = -np.inf
    for _ in range(restarts):
        x = rng.standard_normal(d); x /= np.linalg.norm(x)
        for _ in range(3000):
            g = 3*np.einsum('klm,l,m->k', T, x, x)
            x_new = g/np.linalg.norm(g)
            if np.linalg.norm(x_new - x) < 1e-14: x = x_new; break
            x = x_new
        best = max(best, theta_of(x, T))
    return best

def sos_bound(n, deg_half=2, solver=cp.SCS):
    T, _ = cubic_tensor(n); d = T.shape[0]
    mons = []
    for k in range(deg_half+1):
        mons += [tuple(sorted(c)) for c in itertools.combinations_with_replacement(range(d), k)]
    N = len(mons)
    prod = {}
    for u, mu in enumerate(mons):
        for v, mv in enumerate(mons):
            prod.setdefault(tuple(sorted(mu+mv)), []).append((u, v))
    # coefficients of Theta(x)
    cub = {}
    for k in range(d):
        for l in range(k, d):
            for m in range(l, d):
                mult = 6 if len({k,l,m}) == 3 else (3 if len({k,l,m}) == 2 else 1)
                c = mult*T[k,l,m]
                if abs(c) > 1e-13: cub[(k,l,m)] = c
    G = cp.Variable((N, N), PSD=True); t = cp.Variable(); a = cp.Variable(); b = cp.Variable()
    cons = []
    for key, cells in prod.items():
        lhs = cp.sum([G[u, v] for (u, v) in cells])
        deg = len(key)
        if   deg == 0: rhs = t - a
        elif deg == 2 and key[0] == key[1]: rhs = a - b
        elif deg == 3: rhs = -cub.get(key, 0.0)
        elif deg == 4 and len(set(key)) == 1: rhs = b
        elif deg == 4 and len(set(key)) == 2 and key[0]==key[1] and key[2]==key[3]: rhs = 2*b
        else: rhs = 0.0
        cons.append(lhs == rhs)
    prob = cp.Problem(cp.Minimize(t), cons)
    prob.solve(solver=solver, verbose=False, max_iters=50000, eps=1e-9)
    return d, N, len(prod), prob.status, (t.value if t.value is not None else np.nan)

print("degree-4 SOS bound on the diagonal maximum, against ground truth\n")
print(f"{'n':>3} {'dim':>4} {'Gram':>6} {'cons':>7} {'status':>10} "
      f"{'SOS bound t*':>13} {'theta0(n)':>11} {'true max':>10} {'t*-theta0':>11}")
print("-"*90)
for n in (4, 6, 8):
    print(f"  n={n}: building...", flush=True)
    t_start = time.time()
    d, N, nc, st, tv = sos_bound(n)
    print(f"    SDP done in {time.time()-t_start:.1f}s -> {st}", flush=True)
    T, _ = cubic_tensor(n)
    tm = true_max(T, d, restarts=120)
    th = theta0(n)
    print(f"{n:>3} {d:>4} {N:>6} {nc:>7} {st:>10} {tv:>13.6f} {th:>11.6f} {tm:>10.6f} "
          f"{tv-th:>+11.2e}", flush=True)
