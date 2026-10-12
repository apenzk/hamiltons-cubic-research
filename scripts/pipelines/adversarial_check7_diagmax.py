"""
Reviewer 7 -- Tasks 2 and 3: independent global maximization of
    Theta(Lambda) = sqrt(2) * (sum_{i!=j} Lambda_ij^3 + tr(Lambda^3)) / ||Lambda||_F^3
over the constrained set {Lambda : hollow, symmetric, Lambda @ 1 = 0}, a linear
subspace of dimension n(n-3)/2, built with an own basis (SVD null space of the
row-sum constraint operator) -- no import from any reviewed script.

Independent gradient-based optimizer (own analytic gradient, verified against
finite differences before use) with many random restarts, at n=4..20 (even)
and n=5..15 (odd), compared against the closed-form conjectured values

    theta0(n)       = sqrt(2*(n-1)*(n-2)) / n                          (even n)
    theta0_tilde(n) = sqrt(2*(n-1)*(n-3) / ((n+1)*(n-2)))              (odd n)

Also builds the S^p x S^q sphere-product Lambda directly (own construction from
the Weyl row-sum-zero condition, not imported) as ground truth, and clusters
all converged critical values found by the optimizer to check whether sphere
products are the *only* attractors (task 3's headline claim).
"""
import itertools
import time

import numpy as np
from scipy.optimize import minimize


# ---------------------------------------------------------------------------
# Basis construction for the constrained subspace
# ---------------------------------------------------------------------------
def make_subspace_basis(n):
    """Return (pairs, ri, ci, B) where B is an orthonormal basis (N x d) for
    the null space of the row-sum constraint operator C: R^N -> R^n (N =
    n(n-1)/2, d = n(n-3)/2), acting on the pair-vector representation y_k =
    Lambda_{pairs[k]}."""
    pairs = list(itertools.combinations(range(n), 2))
    N = len(pairs)
    ri = np.array([p[0] for p in pairs])
    ci = np.array([p[1] for p in pairs])
    C = np.zeros((n, N))
    for k, (i, j) in enumerate(pairs):
        C[i, k] = 1.0
        C[j, k] = 1.0
    # Null space of C via SVD.
    U, S, Vt = np.linalg.svd(C, full_matrices=True)
    rank = np.sum(S > 1e-10 * S[0])
    B = Vt[rank:, :].T  # N x d, orthonormal columns spanning null(C)
    d_expected = n * (n - 3) // 2
    assert B.shape[1] == d_expected, (B.shape, d_expected, rank)
    return pairs, ri, ci, B


def y_to_matrix(y, n, ri, ci):
    L = np.zeros((n, n))
    L[ri, ci] = y
    L[ci, ri] = y
    return L


# ---------------------------------------------------------------------------
# Theta and its gradient, in x-coordinates (y = B x)
# ---------------------------------------------------------------------------
class ThetaProblem:
    def __init__(self, n):
        self.n = n
        self.pairs, self.ri, self.ci, self.B = make_subspace_basis(n)
        self.N = len(self.pairs)
        self.d = self.B.shape[1]

    def theta_and_grad(self, x):
        y = self.B @ x
        n, ri, ci = self.n, self.ri, self.ci
        L = y_to_matrix(y, n, ri, ci)
        L2 = L @ L
        L3 = L2 @ L
        r2 = float(y @ y)
        r = np.sqrt(r2)
        g = 2.0 * np.sum(y ** 3) + np.trace(L3)
        theta = g / (2.0 * r ** 3)

        dgdy = 6.0 * (y ** 2 + L2[ri, ci])
        dtheta_dy = dgdy / (2.0 * r ** 3) - 3.0 * g * y / (2.0 * r ** 5)
        dtheta_dx = self.B.T @ dtheta_dy
        return theta, dtheta_dx

    def neg_theta_and_grad(self, x):
        th, g = self.theta_and_grad(x)
        return -th, -g


def check_gradient(n=6, seed=0):
    prob = ThetaProblem(n)
    rng = np.random.default_rng(seed)
    x0 = rng.normal(size=prob.d)
    th0, g0 = prob.theta_and_grad(x0)
    eps = 1e-6
    g_fd = np.zeros(prob.d)
    for k in range(prob.d):
        xp = x0.copy(); xp[k] += eps
        xm = x0.copy(); xm[k] -= eps
        thp, _ = prob.theta_and_grad(xp)
        thm, _ = prob.theta_and_grad(xm)
        g_fd[k] = (thp - thm) / (2 * eps)
    err = np.max(np.abs(g_fd - g0))
    print(f"  gradient check n={n}: max|analytic - finite-diff| = {err:.3e} "
          f"(relative to |grad|~{np.max(np.abs(g0)):.3e})")
    assert err < 1e-5, "analytic gradient does not match finite differences!"


# ---------------------------------------------------------------------------
# Ground-truth sphere-product construction (own derivation, no import)
# ---------------------------------------------------------------------------
def sphere_product_lambda(n, p):
    """Weyl vertex matrix of S^p x S^q (q=n-p), built from the row-sum-zero
    two-block-plus-cross-term ansatz: within-P entries = a, within-Q entries
    = b, cross entries = c=-1, solved from (p-1)a + q*c = 0, (q-1)b + p*c = 0.
    (c=-1, not +1: this is the branch giving positive Theta / matching the
    positive theta0(n); the other sign is just the global sign-flip of Lambda,
    which flips Theta's sign since Theta is odd under Lambda -> -Lambda, and
    equally valid as a matrix but represents the *minimizer* not maximizer.)"""
    q = n - p
    c = -1.0
    a = -q * c / (p - 1) if p > 1 else 0.0
    b = -p * c / (q - 1) if q > 1 else 0.0
    L = np.zeros((n, n))
    idxP = list(range(p))
    idxQ = list(range(p, n))
    for i in idxP:
        for j in idxP:
            if i != j:
                L[i, j] = a
    for i in idxQ:
        for j in idxQ:
            if i != j:
                L[i, j] = b
    for i in idxP:
        for j in idxQ:
            L[i, j] = c
            L[j, i] = c
    return L


def theta_of_matrix(L):
    off_sum = np.sum(L ** 3)
    trace_cube = np.trace(L @ L @ L)
    normL = np.linalg.norm(L, "fro")
    return np.sqrt(2) * (off_sum + trace_cube) / normL ** 3


def theta0_even(n):
    return np.sqrt(2 * (n - 1) * (n - 2)) / n


def theta0_tilde_odd(n):
    return np.sqrt(2 * (n - 1) * (n - 3) / ((n + 1) * (n - 2)))


def is_two_block(L, n, tol=1e-6):
    """Detect whether L is, up to permutation of indices AND overall scale,
    a two-block sphere-product-type matrix S^p x S^{n-p}. Permutation of
    indices is an orthogonal (in fact permutation) conjugation, so it leaves
    the eigenvalue SPECTRUM of L invariant -- this sidesteps ever having to
    find the actual permutation/partition (which a naive row-sum-based
    matching can get wrong when the two blocks are balanced, p=q, since
    p- and q-block rows can then have near-identical or exactly-tied row
    signatures). So: normalize L to unit Frobenius norm, and for every
    candidate split p=2..n-2, compare L's *sorted eigenvalue spectrum*
    against the reference S^p x S^{n-p} matrix's sorted spectrum (also
    normalized), allowing an overall sign flip (Theta is odd under
    Lambda -> -Lambda, but eigenvalue-spectrum comparison should not
    itself depend on picking the correct signed branch)."""
    Ln = L / np.linalg.norm(L, "fro")
    ev_L = np.sort(np.linalg.eigvalsh(Ln))
    best_resid = np.inf
    best_p = None
    for p in range(2, n - 1):
        ref = sphere_product_lambda(n, p)
        refn = ref / np.linalg.norm(ref, "fro")
        ev_ref = np.sort(np.linalg.eigvalsh(refn))
        resid = min(np.max(np.abs(ev_L - ev_ref)),
                    np.max(np.abs(ev_L + ev_ref[::-1])))
        if resid < best_resid:
            best_resid = resid
            best_p = p
    return best_resid < tol, best_p, best_resid


# ---------------------------------------------------------------------------
# Optimizer driver
# ---------------------------------------------------------------------------
def run_maximization(n, n_restarts, seed=0, tol_cluster=1e-4):
    prob = ThetaProblem(n)
    rng = np.random.default_rng(seed)
    values = []
    winners_L = []
    t0 = time.time()
    for r in range(n_restarts):
        x0 = rng.normal(size=prob.d)
        x0 /= np.linalg.norm(x0)
        res = minimize(prob.neg_theta_and_grad, x0, jac=True, method="L-BFGS-B",
                        options={"maxiter": 500, "ftol": 1e-16, "gtol": 1e-12})
        x = res.x
        th, grad = prob.theta_and_grad(x)
        y = prob.B @ x
        L = y_to_matrix(y, n, prob.ri, prob.ci)
        values.append(th)
        winners_L.append(L)
    elapsed = time.time() - t0

    values = np.array(values)
    # cluster
    order = np.argsort(-values)
    clusters = []  # list of (mean_value, count, representative_index)
    used = np.zeros(len(values), dtype=bool)
    for idx in order:
        if used[idx]:
            continue
        v = values[idx]
        members = np.where((~used) & (np.abs(values - v) < tol_cluster))[0]
        used[members] = True
        clusters.append((float(np.mean(values[members])), len(members), int(idx)))

    return prob, values, winners_L, clusters, elapsed


def run_power_iteration(n, n_restarts, seed=0, iters=300):
    """A second, structurally independent search method (not gradient-based,
    no line search): a fixed-point/power iteration on the critical-point map
    Lambda -> Proj( Lambda_ij^2 + (Lambda^2)_ij ), normalized each step. Near
    a genuine critical point Q(Lambda) = lambda*Lambda, so this map's fixed
    rays are exactly the critical points; iterating it is the direct
    nonlinear analogue of the power method for the leading eigenvector of a
    linear map, applied to this cubic map instead. Used here purely as an
    independent cross-check on the gradient-ascent clustering above -- if
    both a smooth local optimizer and a completely different fixed-point
    dynamical system converge to the same finite set of values, that is
    much stronger evidence than either method alone."""
    prob = ThetaProblem(n)
    rng = np.random.default_rng(seed)
    values = []
    for _ in range(n_restarts):
        x0 = rng.normal(size=prob.d)
        y = prob.B @ x0
        y = y / np.linalg.norm(y)
        for _ in range(iters):
            L = y_to_matrix(y, n, prob.ri, prob.ci)
            L2 = L @ L
            phi = y ** 2 + L2[prob.ri, prob.ci]
            phi_proj = prob.B @ (prob.B.T @ phi)
            nrm = np.linalg.norm(phi_proj)
            if nrm < 1e-14:
                break
            y = phi_proj / nrm
        L = y_to_matrix(y, n, prob.ri, prob.ci)
        values.append(theta_of_matrix(L))
    return np.array(values)


def main():
    print("=== gradient check ===")
    for n in [6, 7, 9]:
        check_gradient(n)
    print()

    print("=== ground-truth sphere-product closed-form cross-check ===")
    for n in [6, 8, 10, 12, 14, 16, 18, 20]:
        L = sphere_product_lambda(n, n // 2)
        th = theta_of_matrix(L)
        target = theta0_even(n)
        print(f"  n={n:3d} (even) balanced S^{n//2}xS^{n//2}: Theta={th:.15f}  "
              f"theta0(n)={target:.15f}  diff={abs(th-target):.3e}")
    for n in [5, 7, 9, 11, 13, 15]:
        p = (n - 1) // 2
        L = sphere_product_lambda(n, p)
        th = theta_of_matrix(L)
        target = theta0_tilde_odd(n)
        print(f"  n={n:3d} (odd)  S^{p}xS^{n-p}:            Theta={th:.15f}  "
              f"theta0~(n)={target:.15f}  diff={abs(th-target):.3e}")
    print()

    even_ns = [4, 6, 8, 10, 12, 14, 16, 18, 20]
    odd_ns = [5, 7, 9, 11, 13, 15]

    restarts_map = {}
    for n in even_ns + odd_ns:
        if n in (12, 14):
            restarts_map[n] = 1500
        else:
            restarts_map[n] = 800

    print("=== TASK 2: global maximization results ===")
    all_results = {}
    for n in even_ns:
        nrest = restarts_map[n]
        prob, values, winners_L, clusters, elapsed = run_maximization(n, nrest, seed=1000 + n)
        target = theta0_even(n)
        maxval = np.max(values)
        best_idx = int(np.argmax(values))
        L_best = winners_L[best_idx]
        two_block, p_detected, resid = is_two_block(L_best, n)
        frac_at_max = np.mean(np.abs(values - maxval) < 1e-4)
        print(f"n={n:3d} (even, {nrest} restarts, {elapsed:.1f}s): "
              f"max Theta found = {maxval:.15f}")
        print(f"    theta0({n}) predicted             = {target:.15f}")
        print(f"    |diff| = {abs(maxval-target):.3e}   "
              f"fraction of restarts reaching global max: {frac_at_max:.1%}")
        print(f"    best maximizer is two-block sphere-product type: {two_block} "
              f"(p={p_detected}, resid={resid:.2e})")
        all_results[n] = (prob, values, winners_L, clusters, target)

    for n in odd_ns:
        nrest = restarts_map[n]
        prob, values, winners_L, clusters, elapsed = run_maximization(n, nrest, seed=2000 + n)
        target = theta0_tilde_odd(n)
        maxval = np.max(values)
        best_idx = int(np.argmax(values))
        L_best = winners_L[best_idx]
        two_block, p_detected, resid = is_two_block(L_best, n)
        frac_at_max = np.mean(np.abs(values - maxval) < 1e-4)
        print(f"n={n:3d} (odd,  {nrest} restarts, {elapsed:.1f}s): "
              f"max Theta found = {maxval:.15f}")
        print(f"    theta0~({n}) predicted            = {target:.15f}")
        print(f"    |diff| = {abs(maxval-target):.3e}   "
              f"fraction of restarts reaching global max: {frac_at_max:.1%}")
        print(f"    best maximizer is two-block sphere-product type: {two_block} "
              f"(p={p_detected}, resid={resid:.2e})")
        all_results[n] = (prob, values, winners_L, clusters, target)

    print()
    print("=== TASK 3: catalogue of critical values at n=12 and n=14 ===")
    for n in (12, 14):
        prob, values, winners_L, clusters, target = all_results[n]
        print(f"\n--n={n}--  ({len(values)} restarts)")
        print(f"  number of distinct clusters found: {len(clusters)}")
        for meanval, count, ridx in sorted(clusters, key=lambda t: -t[1]):
            frac = count / len(values)
            # try to identify as S^p x S^{n-p}
            best_p, best_diff = None, np.inf
            for p in range(2, n - 1):
                Lref = sphere_product_lambda(n, p)
                thref = theta_of_matrix(Lref)
                if abs(thref - meanval) < best_diff:
                    best_diff = abs(thref - meanval)
                    best_p = p
            print(f"    value={meanval:.6f}  count={count:4d} ({frac:.1%})  "
                  f"nearest S^p x S^(n-p): p={best_p}, theta={theta_of_matrix(sphere_product_lambda(n, best_p)):.6f}, "
                  f"diff={best_diff:.2e}")

    print()
    print("=== TASK 3 cross-check: independent fixed-point/power-iteration search")
    print("    (a structurally different method: no gradient, no line search) ===")
    for n in (12, 14):
        pvals = run_power_iteration(n, 1000, seed=9000 + n)
        order = np.argsort(-pvals)
        pclusters = []
        used = np.zeros(len(pvals), dtype=bool)
        for idx in order:
            if used[idx]:
                continue
            v = pvals[idx]
            members = np.where((~used) & (np.abs(pvals - v) < 1e-4))[0]
            used[members] = True
            pclusters.append((float(np.mean(pvals[members])), len(members)))
        print(f"  n={n}: {len(pclusters)} distinct clusters found via power iteration "
              f"(1000 restarts):")
        for meanval, count in sorted(pclusters, key=lambda t: -t[1]):
            print(f"    value={meanval:.6f}  count={count:4d} ({count/len(pvals):.1%})")


if __name__ == "__main__":
    main()
