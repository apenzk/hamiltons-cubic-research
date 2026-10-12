"""I106b: R28's rung hands down EXACTLY on the stratum [U, C] = 0, the node's own target.

**What this settles.**  Gate 2 (r976, r977) proved conv(X_k) = B_k, so a linear functional on ONE
orthostochastic matrix peaks at a permutation matrix, which splits.  A previous screen
(screen_I106b_coupling.py) showed that argument fails on R28's COUPLED pair.  This one says where the
boundary between those two cases lies, and the answer is not arbitrary:

    G = E^T F is a signed permutation  <=>  U and C share an eigenframe  <=>  [U, C] = 0,

and vertex-optimality holds exactly there.  So the Birkhoff argument discharges the rung precisely on
the stratum [U, C] = 0, which second-order.md already names as the statement to aim at:

    "The statement to aim at is therefore [U, C] = 0 at every global maximum, which closes the
     |J| = 3 node outright rather than one stratum of it."

**So the rung and the node's target are the same problem.**  That is an equivalence rather than a
mismatch, and it is why the reviewers' result is worth more than "right about the wrong object": it
converts R28's remaining obligation into a statement the record was already trying to prove, and it
shows no separate face or tangency argument is needed once the commutator vanishes.

*It does NOT prove [U, C] = 0.  It says the rung needs nothing more.*

Gate 1: (a) the G = I rows reproduce the uncoupled vertex-optimality the reviewers proved, which is
the control that the comparison set is right, (b) the commutator is computed from U and C directly
rather than inferred from G, a second route to the same stratum, (c) every frame is asserted
orthogonal, (d) the gap is compared against 0, the vertex argument's own prediction.

**A SCREEN.  The equivalence it indicates is derived in the note; the numbers only locate it.**
"""

import itertools

import numpy as np
from scipy.linalg import expm
from scipy.optimize import minimize

rng = np.random.default_rng(31)
BETA = 9 / 4


def skew_from(v, k):
    W = np.zeros((k, k))
    W[np.triu_indices(k, 1)] = v
    return W - W.T


def value(P, E, F, u, c, nu):
    R = (E.T @ P) ** 2
    S = (F.T @ P) ** 2
    return float(np.sum(R * np.outer(u, BETA * nu * nu)) + np.sum(S * np.outer(c, nu)))


def best_over_group(E, F, u, c, nu, k, restarts=120):
    best = -np.inf
    m = k * (k - 1) // 2
    for _ in range(restarts):
        Q0, _ = np.linalg.qr(rng.standard_normal((k, k)))
        res = minimize(lambda v: -value(Q0 @ expm(skew_from(v, k)), E, F, u, c, nu),
                       rng.standard_normal(m) * 0.5, method="BFGS")
        best = max(best, -res.fun)
    return best


def best_vertex(E, F, u, c, nu, k):
    perms = [np.eye(k)[:, list(p)] for p in itertools.permutations(range(k))]
    return max(max(value(E @ Pm, E, F, u, c, nu) for Pm in perms),
               max(value(F @ Pm, E, F, u, c, nu) for Pm in perms))


print("=" * 88)
print("I106b: is vertex-optimality exactly the stratum [U, C] = 0 ?")
print("=" * 88)
print("\nG = E^T F is a signed permutation  <=>  U and C share an eigenframe  <=>  [U,C] = 0.\n")
print(f"{'k':>2} {'G':>22} {'|[U,C]|':>11} {'group - vertex':>16}  verdict")

rows = []
for k in (3, 4):
    for tag, make_F in (
            ("G = I exactly", lambda E, k=k: E.copy()),
            ("G = a permutation", lambda E, k=k: E @ np.eye(k)[:, list(rng.permutation(k))]),
            ("G = small rotation",
             lambda E, k=k: E @ expm(0.15 * skew_from(rng.standard_normal(k * (k - 1) // 2), k))),
            ("G = generic", lambda E, k=k: np.linalg.qr(rng.standard_normal((k, k)))[0])):
        u, c, nu = rng.standard_normal(k), rng.standard_normal(k), rng.standard_normal(k)
        E, _ = np.linalg.qr(rng.standard_normal((k, k)))
        F = make_F(E)
        assert np.abs(E @ E.T - np.eye(k)).max() < 1e-12, "E not orthogonal"
        assert np.abs(F @ F.T - np.eye(k)).max() < 1e-12, "F not orthogonal"
        U = E @ np.diag(u) @ E.T
        C = F @ np.diag(c) @ F.T
        comm = float(np.abs(U @ C - C @ U).max())
        gap = best_over_group(E, F, u, c, nu, k) - best_vertex(E, F, u, c, nu, k)
        commuting = comm < 1e-9
        optimal = gap < 1e-6
        rows.append((commuting, optimal))
        print(f"{k:>2} {tag:>22} {comm:>11.2e} {gap:>16.3e}  "
              f"{'VERTEX OPTIMAL' if optimal else 'beaten'}")

assert all(c == o for c, o in rows), "commuting and vertex-optimal DISAGREE on some row"
print("\ncommuting and vertex-optimal agree on every row  (asserted, not printed)")
print("\n" + "=" * 88)
print("So R28's rung hands down EXACTLY on [U,C] = 0, which the record already names as its target.")
print("The rung and the node's target are the same problem. This does not prove [U,C] = 0.")
print("=" * 88)
