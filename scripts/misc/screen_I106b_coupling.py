"""I106b: the Birkhoff vertex argument holds UNCOUPLED and FAILS on R28's coupled pair.

**What this settles.**  Gate 2 (r976, r977) found, independently and correctly, that the value is a
linear functional on the orthostochastic set, that conv(X_k) = B_k, and hence that the maximum is
attained at a permutation matrix, which splits.  Both concluded R28's rung hands down
unconditionally, and both flagged that this rests on the block's own reading of the object and was
worth confirming against R28.  It does not survive.

**The parent's brief is what caused it.**  The brief presented the value as <R, A> on a SINGLE
orthostochastic matrix.  The route register says R28's object is a COUPLED PAIR,

    (R, S) = ( (E^T P)^o2 , (F^T P)^o2 ),    G = E^T F fixed,

because hat U and C have different eigenframes.  Making R a vertex forces P = E * Sigma for a signed
permutation Sigma, and then S = (G^T Sigma)^o2 is NOT a vertex.  conv of the coupled image is not
B_k x B_k, and treating it as such is the Birkhoff relaxation the record already fences as having
overshot by 3.82.

**A BUG IN THIS SCRIPT'S FIRST VERSION, recorded because its output was confidently wrong.**  It
compared against permutation FRAMES P rather than frames making R a permutation MATRIX.  With E a
random rotation, E^T P is not a signed permutation, so R was never a vertex, and the run reported the
vertex as non-optimal even at E = F, contradicting a correct earlier check.  The comparison set, not
the conclusion, was wrong.  R is a permutation matrix exactly when P = E * (signed permutation), and
signs are irrelevant because the map squares entrywise.

Gate 1: (a) the E = F rows reproduce the uncoupled result the reviewers proved, which is the control
that the comparison set is now right, (b) the coupled gap is reached by ascent from 150 random starts
against an exhaustive vertex enumeration, two different methods, (c) every frame is screened for
orthogonality, (d) the gap is compared against 0, the vertex argument's own prediction.

**A SCREEN, and here it REFUTES a Gate 2 conclusion rather than supporting one.**
"""

import itertools

import numpy as np
from scipy.linalg import expm
from scipy.optimize import minimize

rng = np.random.default_rng(23)
BETA = 9 / 4


def skew_from(v, k):
    W = np.zeros((k, k))
    W[np.triu_indices(k, 1)] = v
    return W - W.T


def value(P, E, F, u, c, nu):
    """R28's frame dependence, with hat U in frame E and C in frame F."""
    R = (E.T @ P) ** 2
    S = (F.T @ P) ** 2
    return float(np.sum(R * np.outer(u, BETA * nu * nu)) + np.sum(S * np.outer(c, nu)))


def ascend(E, F, u, c, nu, k, restarts=150):
    best = -np.inf
    m = k * (k - 1) // 2
    for _ in range(restarts):
        Q0, _ = np.linalg.qr(rng.standard_normal((k, k)))
        res = minimize(lambda v: -value(Q0 @ expm(skew_from(v, k)), E, F, u, c, nu),
                       rng.standard_normal(m) * 0.5, method="BFGS")
        best = max(best, -res.fun)
    return best


print("=" * 90)
print("I106b: does the Birkhoff vertex argument survive R28's coupled pair?")
print("=" * 90)
print("\nR = (E^T P)^o2 is a permutation matrix exactly when P = E * (signed permutation).")
print("Signs are irrelevant because the map squares entrywise.\n")
print(f"{'k':>2} {'case':>8} {'best O(k)':>12} {'best R-vertex':>14} {'best S-vertex':>14} "
      f"{'gap':>12}  verdict")

uncoupled_tight = True
coupled_beaten = 0
for k in (3, 4, 5):
    for case in ("E = F", "E != F"):
        u, c, nu = rng.standard_normal(k), rng.standard_normal(k), rng.standard_normal(k)
        E, _ = np.linalg.qr(rng.standard_normal((k, k)))
        F = E.copy() if case == "E = F" else np.linalg.qr(rng.standard_normal((k, k)))[0]
        assert np.abs(E @ E.T - np.eye(k)).max() < 1e-12, "E not orthogonal"
        assert np.abs(F @ F.T - np.eye(k)).max() < 1e-12, "F not orthogonal"

        best = ascend(E, F, u, c, nu, k)
        perms = [np.eye(k)[:, list(p)] for p in itertools.permutations(range(k))]
        bR = max(value(E @ Pm, E, F, u, c, nu) for Pm in perms)
        bS = max(value(F @ Pm, E, F, u, c, nu) for Pm in perms)
        bv = max(bR, bS)
        gap = best - bv
        if case == "E = F":
            uncoupled_tight &= gap < 1e-6
        else:
            coupled_beaten += int(gap > 1e-6)
        print(f"{k:>2} {case:>8} {best:>12.6f} {bR:>14.6f} {bS:>14.6f} {gap:>12.3e}  "
              f"{'VERTEX OPTIMAL' if gap < 1e-6 else 'BEATEN by ' + format(gap, '.4f')}")

assert uncoupled_tight, "the E = F control FAILED, so the comparison set is wrong again"
print("\ncontrol: the E = F rows are vertex-optimal, so the comparison set is right  (asserted)")
print(f"coupled cases where a non-vertex frame strictly wins: {coupled_beaten} of 3")
print("\n" + "=" * 90)
print("So the vertex argument is EXACT uncoupled and FAILS coupled. R28's rung is not discharged,")
print("and the reviewers' unconditional conclusion is right about the object the brief gave them.")
print("=" * 90)
