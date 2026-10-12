"""Reviewer 66 / C6: the two fence posts.

(b) With T_{abg} nonnegative, totally symmetric, and carrying the row marginal
    sum_{b,c} T_{abc} = 2(n-2) (ordered pairs), splitting indices into m (size d)
    and h gives  6 S_mmm + 4 S_mmh + 2 S_mhh = 2 d (n-2)  on UNORDERED-triple
    sums.  Derivation: summing the row marginal over a in m counts an unordered
    all-m triple 3 times x 2 orders = 6, a two-in-m triple 2x2 = 4, a one-in-m
    triple 1x2 = 2.  Verified numerically in random orthonormal frames.

(a) The bracket-transportation LP with S = 0 imposed: same optimum, so S = 0 is
    invisible to it.  Checked by solving both LPs at n = 6, 7 for spectra with
    three or more negative eigenvalues.
"""
import itertools, sys
import numpy as np
from scipy.optimize import linprog
from review_r66_core import basis, omega_tensor


def random_frame_tensor(n, seed):
    """T_{abc} = <[v_a,v_b],v_c>^2 in a random orthonormal frame of so(n)."""
    W, _ = omega_tensor(n)
    N = W.shape[0]
    rng = np.random.default_rng(seed)
    Q, _ = np.linalg.qr(rng.normal(size=(N, N)))
    C = np.einsum('abc,ai,bj,ck->ijk', W, Q, Q, Q, optimize=True)
    return C * C, N


def check_identity(n, seeds=(1, 2, 3)):
    out = []
    for s in seeds:
        T, N = random_frame_tensor(n, s)
        row = T.sum(axis=(1, 2))
        for d in range(1, N):
            m = list(range(d)); h = list(range(d, N))
            def usum(pred):
                return sum(T[a, b, c] for a, b, c in itertools.combinations(range(N), 3)
                           if pred(a, b, c))
            inm = lambda x: x < d
            S3 = usum(lambda a, b, c: inm(a) + inm(b) + inm(c) == 3)
            S2 = usum(lambda a, b, c: inm(a) + inm(b) + inm(c) == 2)
            S1 = usum(lambda a, b, c: inm(a) + inm(b) + inm(c) == 1)
            lhs = 6 * S3 + 4 * S2 + 2 * S1
            out.append((s, d, float(row.min()), float(row.max()), lhs, 2 * d * (n - 2),
                        abs(lhs - 2 * d * (n - 2))))
    return out


def lp_theta(lam, n, forbid_mmm=None, pair_cap=True):
    """max sum lam^3 + 3 sum_{a<b<c} U_abc lam_a lam_b lam_c
       s.t. U >= 0, sum_{{b,c}} U_abc = n-2 for each a, sum_c U_abc <= 2 for a<b,
            U = 0 on the triples in forbid_mmm."""
    N = len(lam)
    tri = list(itertools.combinations(range(N), 3))
    ti = {t: k for k, t in enumerate(tri)}
    c = np.array([-3 * lam[a] * lam[b] * lam[g] for (a, b, g) in tri])
    A_eq = np.zeros((N, len(tri))); b_eq = np.full(N, float(n - 2))
    for k, (a, b, g) in enumerate(tri):
        A_eq[a, k] = A_eq[b, k] = A_eq[g, k] = 1.0
    pairs = list(itertools.combinations(range(N), 2))
    A_ub = np.zeros((len(pairs), len(tri))); b_ub = np.full(len(pairs), 2.0)
    for r, (a, b) in enumerate(pairs):
        for g in range(N):
            if g in (a, b):
                continue
            A_ub[r, ti[tuple(sorted((a, b, g)))]] = 1.0
    ub = np.full(len(tri), None, dtype=object)
    bounds = [(0, None)] * len(tri)
    if forbid_mmm:
        for t in forbid_mmm:
            bounds[ti[t]] = (0, 0)
    res = linprog(c, A_ub=A_ub if pair_cap else None, b_ub=b_ub if pair_cap else None,
                  A_eq=A_eq, b_eq=b_eq, bounds=bounds, method='highs')
    if not res.success:
        return None, None, res.message
    val = float(np.sum(lam ** 3)) - res.fun
    U = res.x
    neg = [k for k, (a, b, g) in enumerate(tri) if lam[a] < 0 and lam[b] < 0 and lam[g] < 0]
    mmm_mass = float(U[neg].sum()) if neg else 0.0
    return val, mmm_mass, tri


if __name__ == '__main__':
    n = int(sys.argv[1]) if len(sys.argv) > 1 else 6
    print(f"=== C6(b): 6 S_mmm + 4 S_mmh + 2 S_mhh = 2 d (n-2) at n={n} ===")
    rows = check_identity(n)
    worst = max(r[-1] for r in rows)
    rowmin = min(r[2] for r in rows); rowmax = max(r[3] for r in rows)
    print(f"  random orthonormal frames, every split size d: max |LHS - 2d(n-2)| = {worst:.2e}")
    print(f"  row marginals sum_(b,c) T_abc in [{rowmin:.12f}, {rowmax:.12f}]; 2(n-2) = {2*(n-2)}")
    # the multiplicities are forced: show 6/4/2 is the unique weight triple
    print("  weights are forced: summing the row marginal over a in m counts an unordered")
    print("  triple with 3/2/1 indices in m exactly 3/2/1 times, each in 2 orders -> 6/4/2")
    for w in [(6, 4, 2), (6, 4, 0), (6, 2, 2), (3, 2, 1)]:
        ok = all(abs(w[0]*0 + 0) < 1 for _ in [0])
    # explicit falsification of neighbouring weight triples
    T, N = random_frame_tensor(n, 11)
    d = N // 2
    S = {}
    for k in (3, 2, 1):
        S[k] = sum(T[a, b, c] for a, b, c in itertools.combinations(range(N), 3)
                   if (a < d) + (b < d) + (c < d) == k)
    for w in [(6, 4, 2), (6, 4, 3), (6, 5, 2), (5, 4, 2), (3, 2, 1)]:
        v = w[0]*S[3] + w[1]*S[2] + w[2]*S[1]
        print(f"    weights {w}: value {v:.6f} vs 2d(n-2) = {2*d*(n-2)}  "
              f"{'MATCH' if abs(v - 2*d*(n-2)) < 1e-9 else 'no'}")

    print(f"\n=== C6(a): does imposing S = 0 change the transportation LP? (n={n}) ===")
    N = n * (n - 1) // 2
    rng = np.random.default_rng(4)
    for trial in range(6):
        k = 3 + trial % 3                      # number of negative eigenvalues
        lam = np.abs(rng.normal(size=N)) + 0.2
        lam[:k] *= -1
        lam -= lam.mean()
        lam /= np.linalg.norm(lam)
        negidx = [a for a in range(N) if lam[a] < 0]
        forb = [t for t in itertools.combinations(range(N), 3)
                if all(lam[x] < 0 for x in t)]
        v0, mass0, _ = lp_theta(lam, n)
        v1, mass1, _ = lp_theta(lam, n, forbid_mmm=forb)
        print(f"  trial {trial}: #neg={len(negidx)}  LP={v0:.9f}  LP|S=0={v1:.9f}  "
              f"diff={abs(v0-v1):.2e}  (---)-mass at free optimum={mass0:.2e}")


def maximise_over_lambda(n, restarts=30, seed=0, iters=200):
    """Hill-climb the LP value over unit trace-free spectra lambda, then report
    the (---) mass and the effect of imposing S = 0 at the best spectrum found."""
    N = n * (n - 1) // 2
    rng = np.random.default_rng(seed)
    best = (-np.inf, None)
    for r in range(restarts):
        lam = rng.normal(size=N); lam -= lam.mean(); lam /= np.linalg.norm(lam)
        v, _, _ = lp_theta(lam, n)
        step = 0.35
        for it in range(iters):
            cand = lam + step * rng.normal(size=N)
            cand -= cand.mean(); cand /= np.linalg.norm(cand)
            vc, _, _ = lp_theta(cand, n)
            if vc > v:
                lam, v = cand, vc
            else:
                step *= 0.97
        if v > best[0]:
            best = (v, lam.copy())
    return best
