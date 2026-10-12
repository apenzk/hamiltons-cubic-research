"""
Reviewer 7, Task 1: independently verify the coordinate-diagonal reduction
    Theta(Lambda) = sqrt(2) * ( sum_{i!=j} Lambda_ij^3 + tr(Lambda^3) ) / ||Lambda||_F^3
equals P(W)/||W||^3 in this repo's own convention, for a coordinate-diagonal
Weyl operator W built from a hollow symmetric row-sum-zero matrix Lambda.

Cross-checked against scripts/curvature_operator.py's Q_op (the machinery
already validated by multiple prior reviewers), without assuming any of the
normalization constants claimed in the task -- all derived/checked here.

Written from scratch; the only import from the repo is Q_op/Lambda2 itself,
exactly as instructed ("cross-check against the validated Q_op machinery").
"""
import numpy as np
import itertools
import sys
import os

sys.path.insert(0, 'scripts/lib')
from curvature_operator import Lambda2, Q_op  # noqa: E402


def random_hollow_symmetric_weyl(n, rng):
    """Build a random hollow symmetric matrix with zero row sums (own construction,
    independent of any optimizer machinery): draw a random symmetric hollow matrix,
    then project onto the row-sum-zero subspace by an explicit iterative doubly-stochastic-
    style correction (simple, transparent, not reused from anywhere)."""
    A = rng.normal(size=(n, n))
    A = (A + A.T) / 2
    np.fill_diagonal(A, 0.0)
    # Project onto {Lambda : Lambda 1 = 0, symmetric, hollow} via explicit least squares.
    pairs = list(itertools.combinations(range(n), 2))
    N = len(pairs)
    y = np.array([A[i, j] for (i, j) in pairs])
    C = np.zeros((n, N))
    for k, (i, j) in enumerate(pairs):
        C[i, k] = 1.0
        C[j, k] = 1.0
    # Null-space projection: y_proj = y - C^T (C C^T)^+ C y
    CCt = C @ C.T
    correction = C.T @ np.linalg.pinv(CCt) @ (C @ y)
    y_proj = y - correction
    L = np.zeros((n, n))
    for k, (i, j) in enumerate(pairs):
        L[i, j] = y_proj[k]
        L[j, i] = y_proj[k]
    return L


def build_diagonal_W(L2, Lambda):
    n = L2.n
    N = L2.N
    M = np.zeros((N, N))
    for k, (i, j) in enumerate(L2.pairs):
        M[k, k] = Lambda[i, j]
    return M


def own_ricci_from_diagonal(Lambda):
    """Own hand-derived Ricci contraction formula for coordinate-diagonal W:
    Ric_jj = sum_{i != j} Lambda_ij (row sum), off-diagonal Ric entries are zero.
    Re-derived independently (not copied) from Ric_{jl} = sum_i M[(i,j),(i,l)]
    on the sparse coordinate-diagonal M -- verified below against a direct
    4-index contraction built from L2's own pair-index bookkeeping."""
    return np.diag(Lambda.sum(axis=1))


def direct_4index_ricci(L2, Mop):
    """Fully independent direct contraction Ric_{jl} = sum_i R_{ijil}, built by
    reading R_{abcd} off Mop via L2's pair index with the correct antisymmetric
    sign convention for reordering (a,b)->pair. No shortcuts, no reuse of the
    'own_ricci_from_diagonal' hand formula -- this is the check on that formula."""
    n = L2.n
    idx = L2.idx

    def R(a, b, c, d):
        # antisymmetric in (a,b) and in (c,d); zero if a==b or c==d
        if a == b or c == d:
            return 0.0
        sab = 1.0
        if a > b:
            a, b = b, a
            sab = -1.0
        scd = 1.0
        if c > d:
            c, d = d, c
            scd = -1.0
        return sab * scd * Mop[idx[(a, b)], idx[(c, d)]]

    Ric = np.zeros((n, n))
    for j in range(n):
        for l in range(n):
            s = 0.0
            for i in range(n):
                s += R(i, j, i, l)
            Ric[j, l] = s
    return Ric


def main():
    rng = np.random.default_rng(12345)
    print("=== Task 1: verifying the coordinate-diagonal reduction, from scratch ===\n")

    for n in [5, 6, 7, 8]:
        L2 = Lambda2(n)
        Lam = random_hollow_symmetric_weyl(n, rng)
        rowsum_resid = np.max(np.abs(Lam.sum(axis=1)))
        W = build_diagonal_W(L2, Lam)

        Q = Q_op(L2, W)

        # --- (a) (W^2)_ij = Lambda_ij^2 (Hadamard square) ---
        W2 = W @ W
        max_err_W2 = 0.0
        for k, (i, j) in enumerate(L2.pairs):
            max_err_W2 = max(max_err_W2, abs(W2[k, k] - Lam[i, j] ** 2))

        # --- (b) (W^#)_ij = (Lambda^2)_{ij} (ordinary matrix square) ---
        Wsharp = Q - W2
        Lam2 = Lam @ Lam
        max_err_Wsharp = 0.0
        for k, (i, j) in enumerate(L2.pairs):
            max_err_Wsharp = max(max_err_Wsharp, abs(Wsharp[k, k] - Lam2[i, j]))

        # --- (c) Weyl <=> zero row sums: direct 4-index Ricci contraction ---
        Ric_direct = direct_4index_ricci(L2, W)
        Ric_hand = own_ricci_from_diagonal(Lam)
        ricci_formula_err = np.max(np.abs(Ric_direct - Ric_hand))
        # Since Lam was built with (near) zero row sums, Ricci should be (near) 0 too.
        ricci_flat_resid = np.max(np.abs(Ric_direct))

        # --- (d) Theta(Lambda) vs P(W)/||W||^3 ---
        Wvec = np.array([W[k, k] for k in range(L2.N)])
        normW = np.linalg.norm(Wvec)
        # <W, Q(W)> is the Hilbert-Schmidt/Frobenius inner product of the two
        # N x N operators = trace(W @ Q(W)). Since W is diagonal this equals
        # sum_k W[k,k] * Q[k,k] -- NOT the quadratic form Wvec @ Q @ Wvec
        # (that would be <Wvec, Q Wvec> in R^N, a different, wrong, contraction).
        off_diag_Q = np.max(np.abs(Q - np.diag(np.diag(Q))))
        PW = float(np.sum(Wvec * np.diag(Q)))  # trace(W @ Q(W))
        pw_over_normcubed = PW / normW ** 3

        off_sum = np.sum(Lam ** 3) - np.sum(np.diag(Lam) ** 3)  # sum_{i!=j} Lambda_ij^3 (diag is 0 anyway)
        trace_cube = np.trace(Lam @ Lam @ Lam)
        normLam = np.linalg.norm(Lam, "fro")
        Theta = np.sqrt(2) * (off_sum + trace_cube) / normLam ** 3

        print(f"n={n}:")
        print(f"  row-sum residual of test Lambda:      {rowsum_resid:.3e}")
        print(f"  (W^2)_ij == Lambda_ij^2  max err:      {max_err_W2:.3e}")
        print(f"  (W^#)_ij == (Lambda^2)_ij max err:     {max_err_Wsharp:.3e}")
        print(f"  Ricci: direct-4-index vs hand-formula: {ricci_formula_err:.3e}")
        print(f"  Ricci-flatness residual (should be ~0 since row sums ~0): {ricci_flat_resid:.3e}")
        print(f"  ||Lambda||_F / ||W||_F ratio (expect sqrt2={np.sqrt(2):.6f}): {normLam/normW:.6f}")
        print(f"  max off-diagonal |Q| (should be ~0, Q stays diagonal on diagonal input): {off_diag_Q:.3e}")
        print(f"  P(W)/||W||^3 :   {pw_over_normcubed:.12f}")
        print(f"  Theta(Lambda) :  {Theta:.12f}")
        print(f"  |difference|:    {abs(pw_over_normcubed - Theta):.3e}")
        print()

    # --- (e) also check the converse: nonzero row sums => genuinely nonzero Ricci ---
    print("=== sanity: nonzero-row-sum Lambda gives genuinely nonzero Ricci (not Weyl) ===")
    n = 6
    L2 = Lambda2(n)
    A = rng.normal(size=(n, n))
    A = (A + A.T) / 2
    np.fill_diagonal(A, 0.0)
    W = build_diagonal_W(L2, A)
    Ric_direct = direct_4index_ricci(L2, W)
    print(f"row sums of A: {A.sum(axis=1)}")
    print(f"max|Ric|: {np.max(np.abs(Ric_direct)):.6f}  (should be clearly nonzero)")
    print(f"Ric == diag(rowsums)? max err = {np.max(np.abs(Ric_direct - np.diag(A.sum(axis=1)))):.3e}")


if __name__ == "__main__":
    main()
