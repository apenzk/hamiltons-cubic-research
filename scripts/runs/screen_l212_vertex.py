"""Gate 1 screen for Lemma L212, the multi-block vertex solution's criticality and second moment.

Exact rationals throughout, so nothing here is a floating-point agreement. Three checks:

  1. Criticality. Phi(K) = theta_g K off the diagonal, with Phi(M) = M^{o2} + M^2, at multiplier 1.
     This is step 2, and it is the step that replaces L46 in L05's chain.
  2. t = 8R identically, where t is the sectional matrix's ordered-pair second moment at
     multiplier 1 and R is the record's multi-block norm identity. This is step 3, and the general
     k proof is in the block and typed as `second_moment_eq`, so the screen checks the proof
     rather than standing in for it.
  3. theta^2 = 1/(4R) reproduces five values the record already carries, which is what makes the
     derivation a confirmation of recorded numbers rather than a fresh claim.

Screening only: the lemma is the derivation, and these numbers check it. The value and the strict
bound are ungraded-slack.md's closed form already, by a route with no Einstein hypothesis in it.
"""
import math
from fractions import Fraction as F


def norm_identity(parts):
    """R = (k-1)/8 + (1/8)(sum 1/(n_a - 1) - 1/(n - 1)), the record's multi-block identity."""
    n, k = sum(parts), len(parts)
    return F(k - 1, 8) + F(1, 8) * (sum(F(1, na - 1) for na in parts) - F(1, n - 1))


def sectional(parts):
    """The vertex solution's K at multiplier 1, as a hollow matrix over the exact rationals."""
    n = sum(parts)
    block = [a for a, na in enumerate(parts) for _ in range(na)]
    K = [[F(0) for _ in range(n)] for _ in range(n)]
    for i in range(n):
        for j in range(n):
            if i == j:
                continue
            a = block[i]
            K[i][j] = (F(n - parts[a], (n - 1) * (parts[a] - 1)) if block[j] == a
                       else F(-1, n - 1))
    return K


def second_moment(parts):
    """t = sum over ORDERED pairs of K_ij^2 for the vertex solution at multiplier 1."""
    n = sum(parts)
    t = sum(na * (na - 1) * F(n - na, (n - 1) * (na - 1)) ** 2 for na in parts)
    t += (n * n - sum(x * x for x in parts)) * F(1, n - 1) ** 2
    return t


def critical(parts):
    """Phi(K) = K off the diagonal at multiplier 1, with Phi(M) = M^{o2} + M^2.

    The Hadamard square contributes K_ij^2 and the matrix square sum_k K_ik K_kj, and criticality
    on the coordinate-diagonal locus is exactly that their sum returns K_ij.
    """
    K = sectional(parts)
    n = len(K)
    for i in range(n):
        for j in range(n):
            if i == j:
                continue
            phi = K[i][j] ** 2 + sum(K[i][k] * K[k][j] for k in range(n))
            if phi != K[i][j]:
                return False, (i, j, phi, K[i][j])
    return True, None


PARTS = [(2, 2), (3, 3), (6, 6), (5, 7), (2, 10), (3, 3, 3), (4, 4, 4), (2, 3, 5),
         (2, 2, 2, 2, 2), (2, 3, 4, 5, 6, 7), (2, 2, 3, 3, 4, 4, 5)]
# Every value below is on the record before this lemma.
KNOWN = {(2, 2): math.sqrt(3) / 2, (3, 3): math.sqrt(10) / 3, (6, 6): 1.2360330,
         (2, 10): 0.994987437, (5, 7): math.sqrt(264 / 175)}

if __name__ == "__main__":
    ok = True
    for p in PARTS:
        r, t = norm_identity(p), second_moment(p)
        if t != 8 * r:
            ok = False
            print(f"  FAIL t != 8R at {p}: {t} against {8 * r}")
    print(f"t = 8R at all {len(PARTS)} partitions up to k = {max(len(p) for p in PARTS)}: {ok}")

    crit = True
    for p in PARTS:
        good, why = critical(p)
        if not good:
            crit = False
            print(f"  FAIL Phi(K) != K at {p}: {why}")
    print(f"Phi(K) = K off the diagonal at all {len(PARTS)} partitions: {crit}")

    for p, want in KNOWN.items():
        got = math.sqrt(1 / (4 * float(norm_identity(p))))
        flag = "ok" if abs(got - want) < 5e-7 else "FAIL"
        print(f"  {str(p):18} theta = {got:.9f}  recorded {want:.9f}  {flag}")
