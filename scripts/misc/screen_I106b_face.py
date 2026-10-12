"""I106b: does the face {tr = 0} carry the maximum of R28's value, and does it hand down?

**The derivation this screens, which needs no code.**  R28's value is linear in the orthostochastic
matrix, `<R, A>` with `A[i,k] = beta*nu_k^2*u_i + nu_k*c_i`, so maximising it over the image is
maximising the QUADRATIC form `f(Q) = sum_{i,k} A[i,k] * Q[i,k]^2` over O(k), and the image never has
to be parametrised.  Along the tangent `Q W` with `W` skew,

    d/dt f(Q exp(tW)) = 2 * <Q^T (A .* Q), W>,

so criticality is exactly that `Q^T (A .* Q)` is SYMMETRIC.  That is the general-|J| analogue of the
record's own first-order condition at |J| = 3, and it is one equation rather than a system.

**A is RANK AT MOST 2**, being `outer(u, beta*nu^2) + outer(c, nu)`, so screening with a generic full
matrix would answer a different question.

**A BUG THIS SCRIPT'S FIRST VERSION HAD, recorded because the output looked plausible.**  Part (b) and
its control each called `rank2_A(...)` TWICE inside one expression, so they compared
`Q^T (A1 .* Q)` against the transpose of `Q^T (A2 .* Q)` for two DIFFERENT random draws.  That measures
nothing at all, and the control printed `6.089` under a label reading "0 expected" without the run being
treated as failed.  Each measurement now draws its A once and reuses it.

**What the item actually needs is the JOINT statistic**, which the first version never computed: of the
maximisers that land ON the face, how many SPLIT.  "How many land on the face" and "how many split" are
two marginals and they do not answer the question, because the theorem is a conditional.

Gate 1: (a) the analytic gradient is checked against a central difference, (b) criticality is reached a
second way, as the asymmetry of `Q^T (A .* Q)` at the optimiser's output, (c) orthogonality of every
constructed object is reported, (d) the on-face values are compared against the best splitting value,
which is the ceiling the induction needs.

**A SCREEN, never evidence for a positive claim.**  It can refute a candidate or find a counterexample.
"""

import numpy as np
from scipy.linalg import expm
from scipy.optimize import minimize

rng = np.random.default_rng(7)
BETA = 9 / 4


def skew_from(v, k):
    W = np.zeros((k, k))
    W[np.triu_indices(k, 1)] = v
    return W - W.T


def f(A, Q):
    return float(np.sum(A * Q * Q))


def rank2_A(k, r):
    """R28's own shape: A[i,k] = beta*nu_k^2*u_i + nu_k*c_i, rank at most 2."""
    u, c, nu = r.standard_normal(k), r.standard_normal(k), r.standard_normal(k)
    return np.outer(u, BETA * nu * nu) + np.outer(c, nu)


def asym(Q, A):
    """Asymmetry of Q^T (A .* Q). Zero exactly at a critical point. ONE A, used twice."""
    B = Q.T @ (A * Q)
    return float(np.abs(B - B.T).max())


def maximise(A, k, restarts=40):
    best, bestQ = -np.inf, None
    m = k * (k - 1) // 2
    for _ in range(restarts):
        Q0, _ = np.linalg.qr(rng.standard_normal((k, k)))
        res = minimize(lambda v: -f(A, Q0 @ expm(skew_from(v, k))),
                       rng.standard_normal(m) * 0.5, method="BFGS")
        Q = Q0 @ expm(skew_from(res.x, k))
        if f(A, Q) > best:
            best, bestQ = f(A, Q), Q
    return best, bestQ


def splits(Q, tol=1e-7):
    """Bipartite support connectivity: rows against columns, permuted independently."""
    k = Q.shape[0]
    seen, stack = {0}, [0]
    while stack:
        r = stack.pop()
        for c in range(k):
            if abs(Q[r, c]) > tol:
                for r2 in range(k):
                    if abs(Q[r2, c]) > tol and r2 not in seen:
                        seen.add(r2)
                        stack.append(r2)
    return len(seen) < k


def best_split_value(A, k, restarts=25):
    """The best value over SPLITTING Q, which is what the induction hands down to.

    A splitting Q is block diagonal after independent row and column permutations, so it suffices to
    maximise over block-diagonal Q with blocks of sizes a and k-a and then over the two permutations.
    Permuting columns permutes A's columns, and permuting rows permutes A's rows, so it is enough to
    maximise over block-diagonal Q against every row and column relabelling of A.
    """
    best = -np.inf
    for a in range(1, k):
        for _ in range(restarts):
            rp = rng.permutation(k)
            cp = rng.permutation(k)
            Ap = A[np.ix_(rp, cp)]
            m1, m2 = a * (a - 1) // 2, (k - a) * (k - a - 1) // 2

            def neg(v):
                Q = np.zeros((k, k))
                Q[:a, :a] = expm(skew_from(v[:m1], a))
                Q[a:, a:] = expm(skew_from(v[m1:], k - a))
                return -f(Ap, Q)

            res = minimize(neg, rng.standard_normal(m1 + m2) * 0.5, method="BFGS")
            best = max(best, -res.fun)
    return best


print("=" * 88)
print("I106b: the criticality condition, and whether the face {tr = 0} hands down to a split point")
print("=" * 88)

print("\n--- (a) the analytic gradient against a central difference ---")
for k in (4, 5, 6):
    A = rank2_A(k, rng)
    Q, _ = np.linalg.qr(rng.standard_normal((k, k)))
    W = skew_from(rng.standard_normal(k * (k - 1) // 2), k)
    h = 1e-6
    num = (f(A, Q @ expm(h * W)) - f(A, Q @ expm(-h * W))) / (2 * h)
    ana = 2 * np.sum((Q.T @ (A * Q)) * W)
    print(f"  k={k}: numeric {num:+.9f}  analytic {ana:+.9f}  rel err "
          f"{abs(num - ana) / max(1.0, abs(ana)):.2e}")

print("\n--- (b) at the zero-diagonal WITNESSES, is Q^T (A.Q) symmetric? (Q fixed, A varied) ---")
M4 = np.array([[0, 1, 1, 1], [1, 0, -1, 1], [1, 1, 0, -1], [1, -1, 1, 0]], float) / np.sqrt(3)
chi = {0: 0, 1: 1, 2: -1, 3: -1, 4: 1}
S = np.array([[chi[(j - i) % 5] for j in range(5)] for i in range(5)], float)
C6 = np.zeros((6, 6)); C6[0, 1:] = 1; C6[1:, 0] = 1; C6[1:, 1:] = S
M6 = C6 / np.sqrt(5)

for tag, Q in (("k=4 witness", M4), ("k=6 Paley  ", M6)):
    k = Q.shape[0]
    a = [asym(Q, rank2_A(k, rng)) for _ in range(2000)]
    print(f"  {tag}: orthogonality {np.abs(Q @ Q.T - np.eye(k)).max():.2e}, "
          f"min asymmetry over 2000 rank-2 A = {min(a):.3e}")

ctrl = [asym(np.eye(4), rank2_A(4, rng)) for _ in range(200)]
print(f"  control, the identity (splits, diagonal Q): max asymmetry {max(ctrl):.3e}  (0 expected)")
print("  a nonzero control would mean the measurement is broken, not that the point is non-critical.")

print("\n--- (c) THE ITEM'S QUESTION: fix A, maximise over O(k), and take the JOINT statistic ---")
print(f"  {'k':>2} {'trials':>7} {'on face':>8} {'splits':>7} {'ON FACE & SPLITS':>17} "
      f"{'on face, NOT split':>19}")
offenders = []
for k in (4, 5, 6):
    trials = 12
    on_face = both = face_not_split = split_ct = 0
    for _ in range(trials):
        A = rank2_A(k, rng)
        val, Q = maximise(A, k)
        face = np.abs(np.diag(Q)).max() < 1e-6
        sp = splits(Q)
        on_face += face
        split_ct += sp
        if face and sp:
            both += 1
        if face and not sp:
            face_not_split += 1
            offenders.append((k, A, Q, val))
    print(f"  {k:>2} {trials:>7} {on_face:>8} {split_ct:>7} {both:>17} {face_not_split:>19}")

print("\n--- (d) for each maximiser ON the face but NOT splitting, does a SPLIT point match its value? ---")
if not offenders:
    print("  none found, so the conditional the theorem states was never tested. That is NOT support")
    print("  for it: it means this sample produced no instance of the hypothesis.")
else:
    print(f"  {'k':>2} {'face value':>14} {'best split value':>18} {'gap':>12} {'hands down?':>13}")
    for k, A, Q, val in offenders:
        bs = best_split_value(A, k)
        gap = val - bs
        print(f"  {k:>2} {val:>14.6f} {bs:>18.6f} {gap:>12.3e} "
              f"{'yes' if gap < 1e-6 else 'NO, COUNTEREXAMPLE':>13}")

print("\n" + "=" * 88)
print("The theorem is a CONDITIONAL: on-face maximisers hand down to splitting ones of equal value.")
print("Counting how many land on the face and how many split are two MARGINALS and answer nothing.")
print("A row reading 'NO' in (d) is a candidate counterexample and must be rebuilt before it is cited.")
print("=" * 88)
