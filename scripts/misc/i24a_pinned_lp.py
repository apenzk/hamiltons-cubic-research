#!/usr/bin/env python3
"""I24a: the pinned LP at a fixed spectrum, run control-first.

The three relations, quoted verbatim from reviews/DERIVE-t11.md line 7 rather than
paraphrased:

  (A)  sum_{b,c} T_abc = 2(n-2)
  (B)  sum_{b,c} lambda_b T_abc = -2 lambda_a
  (C)  sum_{b,c} lambda_b lambda_c T_abc = 2 lambda_a (theta - lambda_a)

Variables are T_abc >= 0 on unordered triples of DISTINCT indices, with total symmetry
and vanishing on repeated indices built into the parametrisation, plus theta. The
objective is max theta.

THE CONTROL RUNS FIRST AND CAN FAIL. At the balanced sphere product spectrum at n = 12
the answer is known: theta_0(12) = sqrt(2*11*10)/12 = 1.2360331. A mis-transcribed
relation returns a confident wrong number with no error anywhere, and the control is the
only thing that catches it.
"""
import itertools
import sys

import numpy as np
from scipy.optimize import linprog


def build(lams, n):
    """Rows of (A), (B), (C) over unordered distinct triples, plus the theta column."""
    N = len(lams)
    triples = list(itertools.combinations(range(N), 3))
    idx = {t: i for i, t in enumerate(triples)}
    nv = len(triples) + 1          # T's, then theta
    A_eq, b_eq = [], []
    for a in range(N):
        rA = np.zeros(nv); rB = np.zeros(nv); rC = np.zeros(nv)
        for (x, y, z) in triples:
            if a not in (x, y, z):
                continue
            others = [u for u in (x, y, z) if u != a]
            b_, c_ = others
            # sum over ORDERED (b,c) with b != c, both != a: each unordered pair twice
            rA[idx[(x, y, z)]] += 2
            rB[idx[(x, y, z)]] += 2 * (lams[b_] + lams[c_]) / 2 * 2 / 2
            rC[idx[(x, y, z)]] += 2 * lams[b_] * lams[c_]
        A_eq.append(rA); b_eq.append(2 * (n - 2))
        A_eq.append(rB); b_eq.append(-2 * lams[a])
        rC[-1] = -2 * lams[a]                       # move theta to the left
        A_eq.append(rC); b_eq.append(-2 * lams[a] ** 2)
    c = np.zeros(nv); c[-1] = -1.0                  # maximise theta
    bounds = [(0, None)] * len(triples) + [(None, None)]
    return c, np.array(A_eq), np.array(b_eq), bounds, len(triples)


def run(label, lams, n, expect=None):
    c, A_eq, b_eq, bounds, ntrip = build(lams, n)
    res = linprog(c, A_eq=A_eq, b_eq=b_eq, bounds=bounds, method="highs")
    print(f"{label}: {ntrip} triples, {A_eq.shape[0]} equalities -> {res.message}")
    if res.success:
        got = -res.fun
        print(f"  max theta = {got:.7f}")
        if expect is not None:
            ok = abs(got - expect) < 1e-4
            print(f"  CONTROL expects {expect:.7f}: {'PASS' if ok else 'FAIL'}")
            return ok
    return res.success


def main():
    n = 12
    N = n * (n - 1) // 2
    theta0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    # CONTROL: the balanced sphere product S^6 x S^6 at n = 12.
    p = 6
    Np = p * (p - 1) // 2
    lam_bal = np.array([1.0] * Np + [1.0] * Np + [0.0] * (p * p))
    lam_bal = lam_bal - lam_bal.mean()
    lam_bal = lam_bal / np.linalg.norm(lam_bal)
    ok = run("CONTROL balanced product", lam_bal, n, expect=theta0)
    if not ok:
        print("\nCONTROL FAILED -- the witness run is NOT reported. A mis-transcribed")
        print("relation returns a confident wrong number, and this is what catches it.")
        return 1
    print("\ncontrol passed; the witness run may be trusted\n")

    # THE WITNESS, quoted from reviews/DERIVE-t11.md section 5: n = 12, N = 66,
    # spectrum (-m)^30, (1.2m)^20, (0.375m)^16 with m = 1/sqrt(61.05), which is
    # exactly the unit-norm condition 30 + 20(1.44) + 16(0.140625) = 61.05.
    m = 1.0 / np.sqrt(61.05)
    lam_w = np.array([-m] * 30 + [1.2 * m] * 20 + [0.375 * m] * 16)
    assert len(lam_w) == N, len(lam_w)
    print(f"witness: unit norm {np.dot(lam_w, lam_w):.9f}, trace {lam_w.sum():+.6f}, "
          f"{len(set(np.round(lam_w, 12)))} distinct eigenvalues")
    run("WITNESS (30,20,16)", lam_w, n)
    print(f"\ntheta_0(12) = {theta0:.7f}")
    print("A maximum at or below theta_0 leaves the witness unrealisable in this class;")
    print("a maximum above it is the value the relaxation permits, NOT a realised point.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
