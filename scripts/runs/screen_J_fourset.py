"""
Screen of inequality (J) from reviews/2026-09-14-I100-derivation.md, batch 2.

(J): for every unit diagonal d in D_n whose largest four-set eigenvalue e(d)
     exceeds Theta_n/2,   P(d) < 3 e(d) - 4 e(d)^3 / Theta_n^2.

A SCREEN, not evidence for (J): multistart constrained ascent of the violation
P(d) - g(e) over the unit sphere of D_n = {K symmetric, hollow, K 1 = 0},
Sum_{i<j} K_ij^2 = 1, with e measured on the four-set {0,1,2,3} during the
ascent and the true e(d) = max over all four-sets and pairings checked after.
g(e) = 3e - 4e^3/Theta^2 is decreasing for e > Theta/2, so a violation found
with the four-set e survives only if e_max equals it, which is checked.

Conventions (checked by the positive controls below, never assumed):
  P(d) = (Sum_{i!=j} K_ij^3 + tr K^3) / 2      at Sum_{i<j} K_ij^2 = 1,
  from adversarial_check7_diagmax.py's Theta(Lambda) at ||Lambda||_F^2 = 2;
  e = sqrt(E)/2, E = A^2+B^2+C^2-AB-BC-CA, A = K_ij+K_kl, B = K_ik+K_jl,
  C = K_il+K_jk  (Lemma L121).
Controls: balanced S^k x S^k gives Theta_n; padded S^2 x S^2 gives P = e = sqrt3/2.

Usage: python3 screen_J_fourset.py N RESTARTS SEED
"""
import itertools
import sys
import time

import numpy as np
from scipy.optimize import minimize


def theta(n):
    if n % 2 == 0:
        return np.sqrt(2 * (n - 1) * (n - 2)) / n
    return np.sqrt(2 * (n - 1) * (n - 3) / ((n + 1) * (n - 2)))


def basis(n):
    pairs = list(itertools.combinations(range(n), 2))
    C = np.zeros((n, len(pairs)))
    for k, (i, j) in enumerate(pairs):
        C[i, k] = C[j, k] = 1.0
    _, s, vt = np.linalg.svd(C, full_matrices=True)
    r = int(np.sum(s > 1e-10 * s[0]))
    B = vt[r:].T
    assert B.shape[1] == n * (n - 3) // 2
    return pairs, B


def to_K(y, n, pairs):
    K = np.zeros((n, n))
    for k, (i, j) in enumerate(pairs):
        K[i, j] = K[j, i] = y[k]
    return K


def P_of(K):
    off = K - np.diag(np.diag(K))
    return 0.5 * (np.sum(off ** 3) + np.trace(K @ K @ K))


def e_fourset(K, q):
    i, j, k, l = q
    A, B, C = K[i, j] + K[k, l], K[i, k] + K[j, l], K[i, l] + K[j, k]
    E = A * A + B * B + C * C - A * B - B * C - C * A
    return 0.5 * np.sqrt(max(E, 0.0))


def e_max(K):
    n = K.shape[0]
    return max(e_fourset(K, q) for q in itertools.combinations(range(n), 4))


def controls(n, pairs):
    Th = theta(n)
    out = []
    if n % 2 == 0:
        k = n // 2
        K = np.zeros((n, n))
        for i in range(n):
            for j in range(n):
                if i != j:
                    K[i, j] = 1.0 if (i < k) == (j < k) else -(k - 1) / k
        K /= np.sqrt(np.sum(np.triu(K, 1) ** 2))
        assert np.allclose(K.sum(1), 0)
        out.append(("balanced product", P_of(K), Th, e_max(K)))
    K = np.zeros((n, n))
    c = 1 / np.sqrt(12)
    for (i, j), v in {(0, 1): 2 * c, (2, 3): 2 * c, (0, 2): -c, (0, 3): -c, (1, 2): -c, (1, 3): -c}.items():
        K[i, j] = K[j, i] = v
    assert np.allclose(K.sum(1), 0)
    out.append(("padded S2xS2", P_of(K), np.sqrt(3) / 2, e_max(K)))
    return out


def main():
    n, restarts, seed = int(sys.argv[1]), int(sys.argv[2]), int(sys.argv[3])
    Th = theta(n)
    pairs, B = basis(n)
    for name, val, want, e in controls(n, pairs):
        print(f"control {name}: P={val:.9f} expected {want:.9f} e_max={e:.6f}", flush=True)
        assert abs(val - want) < 1e-9, name
    q0 = (0, 1, 2, 3)

    def unpack(x):
        y = B @ x
        return to_K(y / np.sqrt(np.sum(y ** 2)), n, pairs)

    def neg_violation(x):
        K = unpack(x)
        e = e_fourset(K, q0)
        return -(P_of(K) - (3 * e - 4 * e ** 3 / Th ** 2))

    cons = [{"type": "ineq", "fun": lambda x: e_fourset(unpack(x), q0) - Th / 2}]
    rng = np.random.default_rng(seed)
    best = None
    t0 = time.time()
    for r in range(restarts):
        x0 = rng.normal(size=B.shape[1])
        res = minimize(neg_violation, x0, method="SLSQP", constraints=cons, options={"maxiter": 500, "ftol": 1e-12})
        K = unpack(res.x)
        e4, em, p = e_fourset(K, q0), e_max(K), P_of(K)
        if e4 < Th / 2 - 1e-9:
            continue
        viol = p - (3 * em - 4 * em ** 3 / Th ** 2)
        if best is None or viol > best[0]:
            best = (viol, p, e4, em, K)
        if r % 20 == 0:
            print(f"restart {r}: best violation {best[0] if best else float('nan'):+.6f} ({time.time()-t0:.0f}s)", flush=True)
    viol, p, e4, em, K = best
    print(f"n={n} Theta={Th:.6f} restarts={restarts}")
    print(f"max of P(d) - g(e_max) over e>Theta/2: {viol:+.9f}  (P={p:.9f}, e_fourset={e4:.9f}, e_max={em:.9f})")
    print("VERDICT: (J) VIOLATED at the best point" if viol >= 0 else "VERDICT: no violation found (a floor on the true maximum, not a proof)")
    np.set_printoptions(precision=4, suppress=True, linewidth=200)
    print(K[:6, :6])


if __name__ == "__main__":
    main()
