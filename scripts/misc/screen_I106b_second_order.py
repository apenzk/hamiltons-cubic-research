#!/usr/bin/env python3
"""Reproduce the three second-order figures in the I106b working note.

The note (reviews/2026-09-17-I106b-face.md, block of 2026-09-21) tabulates half the second
variation of f(Q) = <A, Q o Q> over O(5) at three points, and until now emitted them from nothing.
A number its own script cannot reproduce is not a number, so this is that script.

It also reproduces what r1048 and r1049 derived and the parent confirmed independently: at a
PERMUTATION the second variation is diagonal in the elementary skew basis, with the entry along
E_ab equal to the change in assignment value under the transposition (a b).  That is why the two
permutation rows of the table are automatic rather than controls.

Witness (beta, nu, u, c, Q) is r1043's, reviews/REVIEW_r1043.md section 1, to twenty digits.
Run: python3 scripts/misc/screen_I106b_second_order.py
"""
import itertools
import numpy as np
from scipy.linalg import expm

BETA = 1.0
NU = np.array([0.0, 1.0, -1.0730005703177699767, 0.5836238129143659775, -0.7617495618959574845])
U = np.array([-0.2851088669233858098, -0.4284747344351851934, -0.0973756367260459615,
              0.4692057127774182067, 0.3417535253071987580])
C = np.array([-0.0076747257258022922, -0.4576072484143468650, 0.3559045209716415579,
              -0.0979183038345809117, 0.2072957570030885110])
Q_WITNESS = np.array([
    [0.0, 0.3708536103913555688, -0.6455680744943662175, -0.3333600600127459413, -0.5784293658188798278],
    [0.3359332542439948809, 0.0, -0.5896845045222959788, -0.1163419014082557667, 0.7251796989685008299],
    [-0.5767105380746792444, -0.3892942545812732253, 0.0, -0.7013872554214502938, 0.1546313569622604631],
    [-0.4541737386991793340, 0.8078893344536610210, 0.1594303043517675158, 0.0, 0.3400338459717399893],
    [0.5901525387920168976, 0.2413139164775378696, 0.4583623287032143343, -0.6191862000217506178, 0.0],
])
K = 5


def amat():
    """A_{ik} = u_i (beta nu_k^2) + c_i nu_k, the item's rank-two weight matrix."""
    return np.outer(U, BETA * NU ** 2) + np.outer(C, NU)


def value(A, Q):
    return float(np.sum(A * (Q * Q)))


def skew_basis():
    for a, b in itertools.combinations(range(K), 2):
        E = np.zeros((K, K))
        E[a, b], E[b, a] = 1.0, -1.0
        yield (a, b), E


def half_f2_closed(A, Q, Om):
    """Half the second variation, by the note's closed form.

    (1/2) f''(0) = <A, (Q Om) o (Q Om)> + tr(S Om^2),  S = Q^T (A o Q).
    """
    S = Q.T @ (A * Q)
    QOm = Q @ Om
    return float(np.sum(A * (QOm * QOm)) + np.trace(S @ (Om @ Om)))


def half_f2_findiff(A, Q, Om, h=1e-3):
    g = lambda t: value(A, Q @ expm(t * Om))
    return 0.5 * (-g(2 * h) + 16 * g(h) - 30 * g(0) + 16 * g(-h) - g(-2 * h)) / (12 * h * h)


def perm_matrix(s):
    P = np.zeros((K, K))
    for j, i in enumerate(s):
        P[i, j] = 1.0
    return P


def quadratic_form(A, Q):
    """The second variation as a matrix in the elementary skew basis, by polarisation."""
    basis = [E for _, E in skew_basis()]
    n = len(basis)
    H = np.zeros((n, n))
    for i in range(n):
        for j in range(n):
            H[i, j] = 0.5 * (half_f2_closed(A, Q, basis[i] + basis[j])
                             - half_f2_closed(A, Q, basis[i])
                             - half_f2_closed(A, Q, basis[j]))
    for i in range(n):
        H[i, i] = half_f2_closed(A, Q, basis[i])
    return H


def main():
    A = amat()

    # Gate 1(b): the closed form against fourth-order finite differences, at a random direction.
    rng = np.random.default_rng(0)
    R = rng.normal(size=(K, K))
    Om = R - R.T
    print(f"closed form vs finite differences at a random skew direction: "
          f"{half_f2_closed(A, Q_WITNESS, Om):.6f} vs {half_f2_findiff(A, Q_WITNESS, Om):.6f}")

    # The criticality screen: S symmetric at the witness.
    S = Q_WITNESS.T @ (A * Q_WITNESS)
    print(f"witness criticality, max |S - S^T| = {np.abs(S - S.T).max():.2e}")

    # The three rows of the note's table.
    best = max(itertools.permutations(range(K)), key=lambda s: value(A, perm_matrix(s)))
    derangements = [s for s in itertools.permutations(range(K))
                    if all(s[j] != j for j in range(K))]
    best_zd = max(derangements, key=lambda s: value(A, perm_matrix(s)))
    rows = [
        (f"global permutation maximiser {best}", perm_matrix(best)),
        ("r1043's k = 5 witness", Q_WITNESS),
        (f"best zero-diagonal permutation {best_zd}", perm_matrix(best_zd)),
    ]
    print(f"\n{'point':48s} {'value':>9s} {'max over E_ab':>14s} {'top eigenvalue':>15s}")
    for label, Q in rows:
        over_basis = max(half_f2_closed(A, Q, E) for _, E in skew_basis())
        top = float(np.linalg.eigvalsh(quadratic_form(A, Q)).max())
        print(f"{label:48s} {value(A, Q):9.4f} {over_basis:14.4f} {top:15.4f}")

    # Why the two permutation rows carry no information: the form is diagonal there, and its
    # diagonal is the transposition gain, so the row says only "no single swap improves it".
    print("\nAt a permutation the form is diagonal and equals the transposition gain:")
    for label, s in (("global maximiser", best), ("best zero-diagonal", best_zd)):
        P = perm_matrix(s)
        H = quadratic_form(A, P)
        offdiag = float(np.abs(H - np.diag(np.diag(H))).max())
        err = 0.0
        for idx, ((a, b), E) in enumerate(skew_basis()):
            s2 = list(s)
            s2[a], s2[b] = s2[b], s2[a]
            gain = value(A, perm_matrix(s2)) - value(A, P)
            err = max(err, abs(H[idx, idx] - gain))
        print(f"  {label:20s} max off-diagonal {offdiag:.2e}, "
              f"max |diagonal - transposition gain| {err:.2e}")


if __name__ == "__main__":
    main()
