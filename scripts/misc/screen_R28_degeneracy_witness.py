"""R28: validating r981's second-degeneracy witness, which is a GLOBAL maximiser.

**Why this exists.**  The parent applied r981's and r982's verdicts and recorded a VALIDATION DEBT in
the same commit, because unlike the earlier rounds it had not rebuilt their witnesses.  A correction
to the parent's own wording carries the heavier burden, and a verdict applied with no validation line
is a verdict taken on faith.  This discharges that debt for r981.

**What was claimed.**  The first-order relation

    (nu_i - nu_j) [ beta (nu_i + nu_j) Ut_ij + Ct_ij ] = 0

has TWO degeneracies, and the parent's note named one.  The outer factor gives nu_i = nu_j.  The inner
bracket gives nu_i + nu_j = 0, where the relation constrains Ct_ij alone and leaves Ut_ij FREE.  r981
claimed this is realised at a GLOBAL maximum rather than merely at a critical point, which is what
makes the negative half of the block-diagonal claim something other than a corner case.

**At |J| = 3 with traceless V it has a cleaner reading**: nu_i + nu_j = -nu_l, so the second
degeneracy is exactly ONE VANISHING EIGENVALUE OF V.  That is a condition on the node's own data.

Gate 1: (a) f(I) is compared against r981's reported 17, the control that the matrices were rebuilt
correctly, (b) global maximality is reached a second way, by ascent from 600 random starts, rather
than taken from the report, (c) symmetry, tracelessness and distinctness of nu are all asserted
rather than assumed, (d) the commutator is compared against 0, which is what "this is on the
commuting stratum" would require.

**A VALIDATION, not a screen for a new claim.  Every number here belongs to r981.**
"""

import numpy as np
from scipy.linalg import expm
from scipy.optimize import minimize

rng = np.random.default_rng(77)
BETA = 9 / 4

NU = np.array([1.0, -1.0, 0.0])
U = np.array([[10 / 3, 1.0, 0.0],
              [1.0, 10 / 3, 0.0],
              [0.0, 0.0, -20 / 3]])
C = np.diag([1.0, -1.0, 0.0])
A = BETA * NU * NU
B = NU

print("=" * 80)
print("Validating r981's second-degeneracy witness")
print("=" * 80)

assert np.abs(U - U.T).max() < 1e-12, "U is not symmetric"
assert np.abs(C - C.T).max() < 1e-12, "C is not symmetric"
assert abs(np.trace(U)) < 1e-12, "U is not traceless"
assert abs(np.trace(C)) < 1e-12, "C is not traceless"
assert abs(NU.sum()) < 1e-12, "nu is not traceless"
assert len(set(NU)) == 3, "nu is not pairwise distinct"
print("\nU and C symmetric and traceless, nu traceless and pairwise distinct  (asserted)")

M = (np.diag(A) @ U - U @ np.diag(A)) + (np.diag(B) @ C - C @ np.diag(B))
assert np.abs(M + M.T).max() < 1e-12, "M is not antisymmetric"
assert np.abs(M).max() < 1e-12, "P = I is not critical"
print(f"M = [A,Ut] + [B,Ct] at P = I: max|M| = {np.abs(M).max():.2e}, antisymmetric  (asserted)")

comm = U @ C - C @ U
assert np.abs(comm).max() > 1e-9, "the witness is on the commuting stratum"
print(f"\n[U,C] has max entry {np.abs(comm).max():.4f}, so the witness is OFF the commuting stratum")

assert abs(U[0, 2]) < 1e-12 and abs(U[1, 2]) < 1e-12, "Ut is not block diagonal"
assert abs(U[0, 1]) > 1e-12, "Ut is diagonal, which would make the witness vacuous"
assert np.abs(C - np.diag(np.diag(C))).max() < 1e-12, "Ct is not diagonal"
print("Ut is block diagonal and NOT diagonal, Ct is diagonal  (asserted)")


def f(P):
    return float(np.trace(np.diag(A) @ (P.T @ U @ P)) + np.trace(np.diag(B) @ (P.T @ C @ P)))


def skew(v):
    W = np.zeros((3, 3))
    W[np.triu_indices(3, 1)] = v
    return W - W.T


fI = f(np.eye(3))
best = -np.inf
for _ in range(600):
    Q0, _ = np.linalg.qr(rng.standard_normal((3, 3)))
    r = minimize(lambda v: -f(Q0 @ expm(skew(v))), rng.standard_normal(3) * 0.7, method="BFGS")
    best = max(best, -r.fun)

print(f"\nf(I) = {fI:.6f}   (r981 reports 17)")
print(f"global max over O(3) by ascent = {best:.6f}")
assert abs(fI - 17.0) < 1e-9, "f(I) does not match r981's reported value"
assert abs(best - fI) < 1e-6, "P = I is not the global maximiser"
print("f(I) matches r981 and is the global maximum  (asserted)")

print("\n" + "=" * 80)
print("VALIDATED in every part. The second degeneracy nu_i + nu_j = 0 is realised at a GLOBAL")
print("maximiser, off the commuting stratum, with nu pairwise distinct. So the negative half of")
print("the block-diagonal claim is not a corner case, and the parent's note named one degeneracy")
print("where the relation has two.")
print("=" * 80)
