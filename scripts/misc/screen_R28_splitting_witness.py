"""R28: a SPLITTING maximiser exists off the commuting stratum, so the equivalence is vertex-only.

**What this validates.**  [r979] refuted this parent's claim that R28's rung hands down exactly on
[U,C] = 0, by exhibiting a global maximiser at which both members of the coupled pair SPLIT while the
commutator is large.  A refutation of a claim the parent has already committed carries the heavier
burden, so it is reproduced here from r979's own matrices before being applied.

**Why the parent's first attempt to reproduce it FAILED, recorded because the failure was mine.**  A
search over 400 random (E, F, u, c) found no such maximiser and that was reported as 0 of 400.  It is
not evidence: r979 CONSTRUCTED a witness with a very particular shape, a 2x2 block beside an isolated
eigenvalue 10, and splitting maximisers are non-generic, so sampling cannot refute a construction.
The right test is to rebuild the stated matrices, which is what this does.

**The distinction that matters, and it is r979's.**  R28's rung consumes `Splits`, the record's
two-sided block condition, which is strictly WEAKER than being a vertex.  The equivalence
"vertex-optimal exactly on [U,C] = 0" is true.  The rung's version of it is false, because a pair can
split simultaneously off the commuting stratum.

Gate 1: (a) the commutator norm and the maximum are compared against r979's reported figures, 2.83
and 41.64730082, which is the control that the matrices were rebuilt correctly, (b) the maximum is
reached by ascent from 400 random starts rather than taken from the report, (c) splitting is tested
with the RECORD's two-sided definition, rows and columns permuted independently, not a one-index
reading, (d) vertex-ness is tested separately, since the whole point is that splitting does not imply
it.

**A SCREEN, reproducing a reviewer's refutation of a claim this parent committed.**
"""

import itertools

import numpy as np
from scipy.linalg import expm
from scipy.optimize import minimize

rng = np.random.default_rng(5)

BETA = 1.0
K = 3
U = np.diag([1.0, -1.0, 10.0])                        # diag(A, 10) with A = diag(1, -1)
C = np.array([[0., 1., 0.], [1., 0., 0.], [0., 0., 0.]])   # diag(B, 0), B the 2x2 swap
NU = np.array([0.5, 1.3, 2.0])                        # pairwise distinct, so degeneracy is not the cause


def value(P):
    return float(np.trace(BETA * np.diag(NU * NU) @ (P.T @ U @ P))
                 + np.trace(np.diag(NU) @ (P.T @ C @ P)))


def skew(v):
    W = np.zeros((K, K))
    W[np.triu_indices(K, 1)] = v
    return W - W.T


def splits(B, tol=1e-6):
    """The RECORD's definition: a proper nonempty row set and an equinumerous column set, chosen
    INDEPENDENTLY, with B vanishing on R x C^c and on R^c x C."""
    idxs = range(K)
    for sz in range(1, K):
        for rows in itertools.combinations(idxs, sz):
            for cols in itertools.combinations(idxs, sz):
                Rs, Cs = set(rows), set(cols)
                if all(abs(B[i, j]) <= tol for i in Rs for j in idxs if j not in Cs) and \
                   all(abs(B[i, j]) <= tol for i in idxs if i not in Rs for j in Cs):
                    return True, rows, cols
    return False, None, None


def is_permutation(B, tol=1e-6):
    return all(sum(abs(x) > tol for x in B[i]) == 1 and abs(max(abs(B[i])) - 1) < tol
               for i in range(K))


print("=" * 82)
print("R28: a splitting maximiser off the commuting stratum, from r979's own matrices")
print("=" * 82)

comm = float(np.linalg.norm(U @ C - C @ U))
print(f"\n|[U,C]|_F = {comm:.4f}   (r979 reports 2.83)")
assert abs(comm - 2.8284) < 1e-3, "the matrices were not rebuilt correctly"

best, bestP = -np.inf, None
for _ in range(400):
    Q0, _ = np.linalg.qr(rng.standard_normal((K, K)))
    res = minimize(lambda v: -value(Q0 @ expm(skew(v))), rng.standard_normal(3) * 0.6,
                   method="BFGS")
    if -res.fun > best:
        best, bestP = -res.fun, Q0 @ expm(skew(res.x))
print(f"global max over O(3) = {best:.8f}   (r979 reports 41.64730082)")
assert abs(best - 41.64730082) < 1e-6, "the maximum does not match r979's"

E = np.eye(K)                       # U is diagonal, so its eigenframe is the identity
_, F = np.linalg.eigh(C)
R = (E.T @ bestP) ** 2
S = (F.T @ bestP) ** 2

sR, rowsR, colsR = splits(R)
sS, rowsS, colsS = splits(S)
print(f"\nR splits: {sR}  rows {rowsR} cols {colsR}   R is a permutation: {is_permutation(R)}")
print(f"S splits: {sS}  rows {rowsS} cols {colsS}   S is a permutation: {is_permutation(S)}")
print(f"\nR =\n{np.round(R, 6)}\nS =\n{np.round(S, 6)}")

assert sR and sS, "the pair does not split, so the witness did not reproduce"
assert not is_permutation(R) and not is_permutation(S), "a member is a vertex after all"
assert comm > 1e-6, "the witness is on the commuting stratum"

print("\n" + "=" * 82)
print("REPRODUCED. Both members split, neither is a vertex, and the commutator is large.")
print("So 'the maximum splits exactly when [U,C] = 0' is TRUE for vertex-optimality and FALSE")
print("for `Splits`, which is what the rung consumes. The coupled hull is retired as a way to")
print("FINISH the rung, not as a way to ATTACK the node.")
print("=" * 82)
