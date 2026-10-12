"""Anchors the proved `DiagCubicFormula` to a value the record carries independently of it.

`diagCubicFormula` proves `Pcubic (diagOp w) = diagP w` in Lean, so the kernel already settles that
equality. What the kernel cannot settle is whether `Pcubic`, `diagOp` and `diagP` as the layer
DEFINES them are the objects the record means. This runs the chain out to a published number: at a
unit-norm sphere product `S^{p-1} x S^{q-1}` the record's value is
`thetaSplit p q = sqrt(2(p+q-1)(p-1)(q-1)/((p+q-2)pq))`, Nienhaus Proposition 2.25, which no part
of the Lean proof uses.

THREE CONTROLS RUN FIRST AND ARE ASSERTED:

  1. `sharpQF` of the IDENTITY operator on `phi_ab` is `n - 2`, the record's `id# = (n-2) id`.
  2. `sharpOp` of the identity operator returns `(n-2) X` on skew `X`, the record's `sharpOp_id`.
     This is the control on `sharpBil` and `sharpOp`, which control 1 does not reach.
  3. `normSq (diagOp w) = 1` exactly when `tr(w^2) = 2`, the normalisation `diagOp_normSq` states.

Then, at each split, three numbers that agree pairwise or the assertion fails:
  Pcubic(diagOp w) from the operator definitions, diagP w from the weighted-graph form, and
  thetaSplit(p, q).

Definitions transcribed from lean/HamiltonsCubic/Base/WeylReal.lean and Base/Families.lean.
About a minute.
"""

import numpy as np

TOL = 1e-8


def phi(n, i, j):
    M = np.zeros((n, n))
    M[j, i] += 1.0
    M[i, j] -= 1.0
    return M


def br(X, Y):
    return X @ Y - Y @ X


def inner2(X, Y):
    return 0.5 * np.trace(X.T @ Y)


def basis(n):
    return [(i, j, phi(n, i, j)) for i in range(n) for j in range(n)]


def sharpQF(R, eta, B):
    return -0.25 * sum(inner2(br(eta, R(br(eta, R(P)))), P) for _, _, P in B)


def sharpBil(R, X, Y, B):
    return 0.5 * (sharpQF(R, X + Y, B) - sharpQF(R, X, B) - sharpQF(R, Y, B))


def sharpOp(R, X, B):
    return 0.5 * sum(sharpBil(R, X, P, B) * P for _, _, P in B)


def innerOp(R, S, B):
    return 0.5 * sum(inner2(R(P), S(P)) for _, _, P in B)


def trCube(R, B):
    return innerOp(lambda X: R(R(X)), R, B)


def sharpPair(R, B):
    return innerOp(R, lambda X: sharpOp(R, X, B), B)


def Pcubic(R, B):
    return trCube(R, B) + sharpPair(R, B)


def normSq(R, B):
    return innerOp(R, R, B)


def diagOp(w):
    return lambda X: w * X


def diagP(w):
    return 0.5 * (np.sum(w ** 3) + np.trace(w @ w @ w))


def sphere_weight(n, p):
    """`sphereWeight S` at `S = {0, ..., p-1}`, so `q = n - p`."""
    q = n - p
    w = np.zeros((n, n))
    for a in range(n):
        for b in range(n):
            if a == b:
                continue
            if a < p:
                w[a, b] = q / (p - 1) if b < p else -1.0
            else:
                w[a, b] = -1.0 if b < p else p / (q - 1)
    return w


def theta_split(p, q):
    return np.sqrt(2 * (p + q - 1) * (p - 1) * (q - 1) / ((p + q - 2) * p * q))


def controls():
    for n in (3, 4, 5, 6):
        B = basis(n)
        v = sharpQF(lambda X: X, phi(n, 0, 1), B)
        assert abs(v - (n - 2)) < TOL, f"control 1 failed at n={n}: {v} vs {n - 2}"
    print("control 1 OK: sharpQF(identity) = n-2 at n = 3, 4, 5, 6")

    rng = np.random.default_rng(3)
    for n in (4, 5, 6):
        B = basis(n)
        A = rng.standard_normal((n, n))
        X = A - A.T
        got = sharpOp(lambda Z: Z, X, B)
        assert np.max(np.abs(got - (n - 2) * X)) < TOL, f"control 2 failed at n={n}"
    print("control 2 OK: sharpOp(identity) = (n-2)*id on skew matrices at n = 4, 5, 6")

    for n, p in ((6, 3), (7, 3)):
        B = basis(n)
        w = sphere_weight(n, p)
        t = np.sqrt(2.0 / np.trace(w @ w))
        assert abs(normSq(diagOp(t * w), B) - 1.0) < TOL, f"control 3 failed at n={n}, p={p}"
    print("control 3 OK: normSq(diagOp w) = 1 exactly when tr(w^2) = 2")


def main():
    controls()
    print()
    print(f"{'n':>3} {'p':>3} {'q':>3} {'Pcubic':>14} {'diagP':>14} {'thetaSplit':>14}")
    for n in (4, 5, 6, 7, 8):
        B = basis(n)
        for p in range(2, n - 1):
            q = n - p
            w0 = sphere_weight(n, p)
            t = np.sqrt(2.0 / np.trace(w0 @ w0))
            w = t * w0
            pc = Pcubic(diagOp(w), B)
            dp = diagP(w)
            ts = theta_split(p, q)
            print(f"{n:>3} {p:>3} {q:>3} {pc:>14.9f} {dp:>14.9f} {ts:>14.9f}")
            assert abs(pc - dp) < TOL, f"Pcubic and diagP disagree at n={n}, p={p}"
            assert abs(pc - ts) < TOL, f"the chain misses the record's value at n={n}, p={p}"
    print("\nEvery split: Pcubic = diagP = thetaSplit, to 1e-8.")


if __name__ == "__main__":
    main()
