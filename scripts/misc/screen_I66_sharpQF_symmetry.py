"""Screen for I66's `sharpQF_diagOp`: WHICH weights the corrected closed form holds at.

The record corrected the closed form to `sharpQF (diagOp w) (phi a b) = sum_{d not in {a,b}}
w_ad * w_bd` (r999, r1000), and the docstring in SharpDiag.lean says it holds "at every symmetric
weight, with no hollowness and no row-sum hypothesis". The Lean statement binds only `hab : a != b`.
This asks whether symmetry is a hypothesis of the theorem or a remark about it.

The derivation says it is a hypothesis. `diagOp w (phi i j)` carries `w_ji` at `(j,i)` and `-w_ij`
at `(i,j)`, so at an asymmetric `w` it is neither skew nor a multiple of `phi i j`, and the
mechanism the proof runs on, each basis direction keeping its own weight through both applications
of `R`, has nothing to act on. The screen holds that against the record's own definitions.

TWO CONTROLS RUN FIRST AND ARE ASSERTED, because a reimplementation that has not reproduced a known
value is evidence about itself and nothing else:

  1. `sharpQF` of the IDENTITY operator on `phi_ab` is `n - 2`, the record's `id# = (n-2) id`, at
     n = 3, 4, 5, 6.
  2. The separating witness SharpDiag.lean carries, n = 3, hollow symmetric with w_01 = -5,
     w_02 = 2, w_12 = 3, returns 6.

Control 1 earned its place on the first run of this file. `phi(i,i)` was built by two sequential
assignments to the same entry, leaving `-E_ii` where the Lean definition `single j i 1 -
single i j 1` gives the zero matrix, and every value came out 1/2 too large. The control caught it
before any conclusion was drawn; control 2 passed throughout, so the disagreement alone would have
read as a finding about the record.

Definitions transcribed from lean/HamiltonsCubic/Base/WeylReal.lean and Base/Families.lean:
  inner2 X Y  = (1/2) tr(X^T Y)
  br X Y      = XY - YX
  phi i j     = single j i 1 - single i j 1
  sharpQF R n = -(1/4) sum_{i,j} inner2 (br eta (R (br eta (R (phi i j))))) (phi i j)
  diagOp w    = Hadamard product by w

Seconds.
"""

import numpy as np


def phi(n, i, j):
    M = np.zeros((n, n))
    M[j, i] += 1.0
    M[i, j] -= 1.0
    return M


def br(X, Y):
    return X @ Y - Y @ X


def inner2(X, Y):
    return 0.5 * np.trace(X.T @ Y)


def sharpQF(R, eta, n):
    s = 0.0
    for i in range(n):
        for j in range(n):
            s += inner2(br(eta, R(br(eta, R(phi(n, i, j))))), phi(n, i, j))
    return -0.25 * s


def diagOp(w):
    return lambda X: w * X


def claimed(w, a, b, n):
    return sum(w[a, d] * w[b, d] for d in range(n) if d not in (a, b))


TOL = 1e-8


def controls():
    for n in (3, 4, 5, 6):
        v = sharpQF(lambda X: X, phi(n, 0, 1), n)
        assert abs(v - (n - 2)) < TOL, f"control 1 failed at n={n}: {v} vs {n - 2}"
    print("control 1 OK: sharpQF(identity) = n-2 at n = 3, 4, 5, 6")

    w = np.zeros((3, 3))
    w[0, 1] = w[1, 0] = -5.0
    w[0, 2] = w[2, 0] = 2.0
    w[1, 2] = w[2, 1] = 3.0
    v = sharpQF(diagOp(w), phi(3, 0, 1), 3)
    assert abs(v - 6.0) < TOL, f"control 2 failed: {v} vs 6"
    print("control 2 OK: the record's separating witness returns 6")


def symmetric_regime(rng):
    bad = 0
    total = 0
    for n in (4, 5, 6):
        for hollow in (True, False):
            for _ in range(8):
                w = rng.standard_normal((n, n))
                w = (w + w.T) / 2
                if hollow:
                    np.fill_diagonal(w, 0.0)
                for (a, b) in ((0, 1), (1, 3), (2, 3)):
                    total += 1
                    if abs(sharpQF(diagOp(w), phi(n, a, b), n) - claimed(w, a, b, n)) > TOL:
                        bad += 1
    assert bad == 0, f"the closed form failed at {bad} of {total} SYMMETRIC weights"
    print(f"symmetric weights: {total}/{total} agree, hollow and non-hollow alike")
    return total


def asymmetric_regime(rng):
    bad = 0
    total = 0
    worst = 0.0
    for n in (4, 5, 6):
        for _ in range(8):
            w = rng.standard_normal((n, n))
            for (a, b) in ((0, 1), (1, 3), (2, 3)):
                total += 1
                gap = abs(sharpQF(diagOp(w), phi(n, a, b), n) - claimed(w, a, b, n))
                worst = max(worst, gap)
                if gap > TOL:
                    bad += 1
    assert bad == total, f"the closed form survived {total - bad} ASYMMETRIC weights"
    print(f"asymmetric weights: {bad}/{total} disagree, largest gap {worst:.6f}")


def main():
    rng = np.random.default_rng(7)
    controls()
    symmetric_regime(rng)
    asymmetric_regime(rng)
    print("\nSymmetry of w is a HYPOTHESIS of sharpQF_diagOp, and the Lean binder must carry it.")


if __name__ == "__main__":
    main()
