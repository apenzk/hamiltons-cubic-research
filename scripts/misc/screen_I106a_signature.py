"""The three "survivors" are NOT local maxima: batch 21 is violated at all three.

**This is the parent's INDEPENDENT VALIDATION of [r973]'s refutation**, and it shares no code
with that reviewer: the points are built by this repository's own `critical_point`, the tangent
basis by this repository's own Gram-Schmidt, and the form by batch 21's expression as written in
[I106Criticality.lean].  r973 rebuilt the points from `[A,C]=0` polished to `1e-52` and reached
the same signatures by three further routes, including direct evaluation of Phi along a
constraint-preserving great circle, which RISES on both sides.

**The defect this exposes is in the question, not the arithmetic.**  `screen_I106a_excess.py`
computed exactly these eigenvalues, one line above where it stopped, and asked only how many were
ZERO.  `dim ker H = 0` was right and was reported as "the second variation is nondegenerate, so
no null direction exists".  A nondegenerate INDEFINITE form has an eight-dimensional null cone,
so the conclusion never followed, and the sign that would have shown it was already in hand.
*The eigenvalues were computed, the kernel was counted, and the signature was never asked for.*

What batch 21 requires at a local maximum is `H <= 0` on the WHOLE tangent space.  A single
positive eigenvalue refutes that.  There are three, three and two.

**Why the record's table did not catch it.**  The record's "clears batch 21" column tests the
threshold `mu >= alpha*|u_min|` (11.25, 11.25, 75), which is a CONSEQUENCE of batch 21 at one
direction rather than batch 21 itself.  The three points clear the surrogate and fail the
condition, so the column is strictly weaker than its heading claims.

Gate 1: (a) reproduces `screen_I106a_excess.py`'s tangent dimension 9 and `dim ker H = 0` on the
same code path, so the basis is the one already trusted; (b) reached a second way by r973 through
three independent routes; (c) the objects are screened, the tangent dimension being the control;
(d) compared against the ceiling that batch 21 asserts, `lambda_max <= 0`, which fails by a wide
margin rather than marginally.
"""

import sys
import numpy as np

sys.path.insert(0, 'scripts/misc')
from screen_I106_value_survivors import critical_point, AF, BF

tr = np.trace


def pair_ip(a, b):
    """The metric the constraint T = (3/2)|U|^2 + (1/2)|V|^2 induces on pairs."""
    return 3 * tr(a[0] @ b[0]) + tr(a[1] @ b[1])


def sym_basis():
    """An orthonormal basis of the traceless symmetric 3x3 matrices, dimension 5."""
    E = [np.diag([1, -1, 0.0]) / np.sqrt(2), np.diag([1, 1, -2.0]) / np.sqrt(6)]
    for i, j in [(0, 1), (0, 2), (1, 2)]:
        M = np.zeros((3, 3))
        M[i, j] = M[j, i] = 1 / np.sqrt(2)
        E.append(M)
    return E


def tangent_basis(U, V):
    """A genuine orthonormal basis of the 9-dimensional tangent space.

    The pair space is 10-dimensional and the tangency 3tr(U X) + tr(V Y) = 0 removes ONE.
    Projecting all 10 and keeping them manufactures a null direction, which is the bug
    screen_I106a_excess.py records against its own first version.
    """
    E = sym_basis()
    pairs = ([(M, np.zeros((3, 3))) for M in E] + [(np.zeros((3, 3)), M) for M in E])
    g = (3 * U, V)
    gn = pair_ip(g, g)
    proj = [(P[0] - pair_ip(P, g) / gn * g[0], P[1] - pair_ip(P, g) / gn * g[1]) for P in pairs]
    basis = []
    for P in proj:
        Q = (P[0].copy(), P[1].copy())
        for B in basis:
            co = pair_ip(Q, B)
            Q = (Q[0] - co * B[0], Q[1] - co * B[1])
        nn = np.sqrt(pair_ip(Q, Q))
        if nn > 1e-7:
            basis.append((Q[0] / nn, Q[1] / nn))
    return basis


SURV = [(1, -3, 11.60060, "(1,-3,2)"),
        (-1, -3, 24.43870, "(-1,-3,4)"),
        (19, -20, 762.38453, "(19,-20,1)")]

print("=" * 86)
print("batch 21 at the three survivors: H <= 0 on the whole tangent space is REQUIRED")
print("=" * 86)
print(f"\n{'spectrum':<12} {'tan dim':>8} {'neg':>4} {'zero':>5} {'POS':>4} "
      f"{'lambda_max':>12} {'sigma_min/rho':>14} {'batch 21':>10}")

violated = 0
for u1, u2, mu, tag in SURV:
    U, V = critical_point(u1, u2, mu)[:2]
    basis = tangent_basis(U, V)

    def H(X, Y):
        return (6 * AF * tr(U @ X @ X) + 4 * BF * tr(X @ V @ Y) + 2 * BF * tr(U @ Y @ Y)
                - mu * (3 * tr(X @ X) + tr(Y @ Y)))

    n = len(basis)
    Mat = np.zeros((n, n))
    for i in range(n):
        for j in range(n):
            Xi, Yi = basis[i]
            Xj, Yj = basis[j]
            Mat[i, j] = 0.5 * (H(Xi + Xj, Yi + Yj) - H(Xi, Yi) - H(Xj, Yj))

    w = np.linalg.eigvalsh((Mat + Mat.T) / 2)
    rho = np.abs(w).max()
    neg = int((w < -1e-8 * rho).sum())
    zer = int((np.abs(w) <= 1e-8 * rho).sum())
    pos = int((w > 1e-8 * rho).sum())
    ok = "holds" if pos == 0 else "VIOLATED"
    violated += (pos > 0)
    print(f"{tag:<12} {n:>8} {neg:>4} {zer:>5} {pos:>4} {w.max():>12.4f} "
          f"{np.abs(w).min() / rho:>14.2e} {ok:>10}")

print(f"\ntangent dimension 9 at every point is the control that the basis is right.")
print(f"batch 21 VIOLATED at {violated} of {len(SURV)} points.")
print("\nSo these are critical points that are NOT local maxima, and the record's claim that they")
print("'clear batch 18, batch 21 and batch 33's orbit bound together' is false for batch 21.")
print("The third point's sigma_min/rho near 1e-8 also makes ANY kernel count there")
print("threshold-dependent, which is r973's separate warning and is independent of the signature.")
print("=" * 86)
