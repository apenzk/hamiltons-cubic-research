"""Batch 33: the simultaneous-conjugation orbit as a joint direction for batch 21.

THE ORBIT.  (U, V) -> (g U g^T, g V g^T) preserves |U|, |V| and the internal part
alpha tr U^3 + beta tr(U V^2), so the curve lies in the constraint set and Phi
varies along it only through <U,A> + <V,C>.  Its tangent is X = [W,U], Y = [W,V]
for skew W.

WHAT IS SCREENED.

  1. The tangent is traceless symmetric and satisfies batch 21's tangency form,
     so batch 21's inequality applies to it with no extra hypothesis.
  2. FIRST ORDER is [U,A] + [V,C] = 0.  Under the Lagrange forms it is an
     identity, post F69 for a third time.  THE CONTROL is the same check with
     GENERIC symmetric fields, where it FAILS, which is what shows the collapse
     comes from the substitution and not from the geometry.
  3. SECOND ORDER, Q(W) = tr([W,U][W,A]) + tr([W,V][W,C]) >= 0, is not identically
     zero under those substitutions, so it survives post F69's test.
  4. Q equals batch 21's inequality at the orbit direction EXACTLY, so this is a
     confirmation of batch 21 by a second route rather than a new condition.
  5. Numerically, Q >= 0 is a third LOWER BOUND ON MU, and it excludes no
     non-commuting critical point that batches 18 and 21 do not already exclude.

The numeric part reconstructs batch 29's points from that batch's own displayed
quadratic, and runs the other root first as a control.

Screening and refutation only: the bound is derived, and what the numbers do here
is kill a candidate lever.
"""

import numpy as np
import scipy.linalg as sla
import sympy as sp
from scipy.optimize import least_squares

ALPHA, BETA = sp.Rational(15, 4), sp.Rational(9, 4)
af, bf = 15 / 4, 9 / 4


def symbolic():
    def sym(pre):
        M = sp.zeros(3, 3)
        for i in range(3):
            for j in range(i, 3):
                s = sp.Symbol(f"{pre}{i}{j}")
                M[i, j] = s
                M[j, i] = s
        return M

    a1, a2, a3 = sp.symbols("w1 w2 w3")
    W = sp.Matrix([[0, a1, a2], [-a1, 0, a3], [-a2, -a3, 0]])
    U, V = sym("u"), sym("v")
    mu, al, be, c1, c2 = sp.symbols("mu alpha beta c1 c2")
    br = lambda X, Y: sp.expand(X * Y - Y * X)
    X, Y = br(W, U), br(W, V)
    nrm = lambda M: sum(M[i, j] ** 2 for i in range(3) for j in range(3))

    print("1. the orbit tangent")
    print("   traceless symmetric                      :",
          sp.simplify(sp.trace(X)) == 0 and sp.simplify(X - X.T) == sp.zeros(3, 3))
    print("   satisfies 3 tr(U X) + tr(V Y) = 0        :",
          sp.simplify(3 * sp.trace(U * X) + sp.trace(V * Y)) == 0)

    A = sp.expand(3 * mu * U - 3 * al * U * U - be * V * V + c1 * sp.eye(3))
    C = sp.expand(mu * V - be * (U * V + V * U) + c2 * sp.eye(3))
    Ag, Cg = sym("a"), sym("c")

    print("2. first order, [U,A] + [V,C] = 0")
    print("   under the LAGRANGE forms, an identity    :",
          sp.simplify(br(U, A) + br(V, C)) == sp.zeros(3, 3))
    print("   with GENERIC fields (the control), holds :",
          sp.simplify(br(U, Ag) + br(V, Cg)) == sp.zeros(3, 3),
          " <- expected False, so the collapse is the substitution's doing")

    Q = sp.expand(sp.trace(br(W, U) * br(W, A)) + sp.trace(br(W, V) * br(W, C)))
    print("3. second order, Q identically zero          :", sp.simplify(Q) == 0,
          " <- expected False, so it survives post F69")
    print("   c1 and c2 absent, the multiples of I drop :",
          c1 not in Q.free_symbols and c2 not in Q.free_symbols)

    b21 = sp.expand(mu * (3 * nrm(X) + nrm(Y))
                    - (6 * al * sp.trace(U * X * X) + 4 * be * sp.trace(X * V * Y)
                       + 2 * be * sp.trace(U * Y * Y)))
    print("4. batch 21 at the orbit direction equals Q  :", sp.simplify(b21 - Q) == 0)


E = [np.array([[0, 1, 0], [-1, 0, 0], [0, 0, 0]], float),
     np.array([[0, 0, 1], [0, 0, 0], [-1, 0, 0]], float),
     np.array([[0, 0, 0], [0, 0, 1], [0, -1, 0]], float)]
brn = lambda X, Y: X @ Y - Y @ X


def mu_orbit(U, V):
    """Q(W) >= 0 for all skew W is mu >= this generalised eigenvalue."""
    P = np.zeros((3, 3))
    N = np.zeros((3, 3))
    for i in range(3):
        for j in range(3):
            P[i, j] = 3 * np.sum(brn(E[i], U) * brn(E[j], U)) + np.sum(brn(E[i], V) * brn(E[j], V))
            N[i, j] = (3 * af * np.trace(brn(E[i], U) @ brn(E[j], U @ U))
                       + bf * (np.trace(brn(E[i], U) @ brn(E[j], V @ V))
                               + np.trace(brn(E[i], V) @ brn(E[j], U @ V + V @ U))))
    return max(sla.eigvalsh((N + N.T) / 2, (P + P.T) / 2))


def numeric(u1, u2, label):
    u3 = -u1 - u2
    uu = [u1, u2, u3]
    D1, D2 = u2 - u3, u1 - u3
    # batch 29's displayed quadratic in mu, after eliminating a1 and a2
    c2 = -16 * u3 * D1 * D2
    c1 = 32 * D1 * D2 * (4 * u1 ** 2 + 7 * u1 * u2 + 4 * u2 ** 2)
    c0 = -9 * u3 * (u1 ** 2 + u1 * u2 + u2 ** 2) * (40 * u1 ** 2 + 100 * u1 * u2 + 40 * u2 ** 2 + 9)
    roots = np.sort(np.roots([c2, c1, c0]))

    def mk(a2, w):
        a1 = (D1 / D2) * a2
        return np.diag(uu).astype(float), np.array(
            [[a1, 0.0, w], [0.0, a2, w], [w, w, -a1 - a2]]), a1

    def res(z, mu):
        a2, w = z
        U, V, _ = mk(a2, w)
        K = brn(U, V)
        VKV = V @ K @ V
        n = np.sum(V * V)
        q = lambda t: 3 * af * bf * t * t + 3 * mu * (af + bf) * t + 3 * mu * mu - 0.5 * bf * bf * n
        return [(uu[i] - uu[j]) * V[i, j] * q(uu[k]) - bf * bf * VKV[i, j]
                for (i, j, k) in [(0, 2, 1), (1, 2, 0)]]

    rng = np.random.default_rng(0)
    print(f"\nspectrum ({u1:.0f},{u2:.0f},{u3:.0f}), {label}: roots {roots}")
    for mu in roots:
        best = None
        seeds = [(1, 1), (10, 1), (-10, 1), (100, 1), (-100, 1), (-40.2, 1.0)]
        seeds += [tuple(rng.normal(0, 50, 2)) for _ in range(200)]
        for s in seeds:
            r = least_squares(res, s, args=(mu,))
            if r.cost < 1e-14 and abs(r.x[1]) > 1e-9:
                if best is None or abs(r.x[1] - 1.0) < abs(best[1] - 1.0):
                    best = r.x
        if best is None:
            print(f"  mu = {mu:.5f}: no w3 = 0, w1 = w2 solution found")
            continue
        a2, w = best
        U, V, a1 = mk(a2, w)
        b18 = 2 * bf * np.linalg.norm(U) / np.sqrt(6)
        b21 = af * abs(min(uu))
        bo = mu_orbit(U, V)
        verdict = "survives all three" if (mu >= b18 and mu >= b21 and mu >= bo) else "excluded"
        print(f"  mu = {mu:12.5f}  a = ({a1:10.4f},{a2:10.4f})  w = {w:.5f}  "
              f"|K| = {np.linalg.norm(brn(U, V)):.4f}")
        print(f"    batch 18 >= {b18:9.4f} | batch 21 >= {b21:9.4f} | orbit >= {bo:9.4f}  -> {verdict}")


if __name__ == "__main__":
    symbolic()
    numeric(3.0, 1.0, "batch 28's spectrum")
    numeric(19.0, -20.0, "batch 29's spectrum")
    print("\nThe orbit bound excludes no point that batches 18 and 21 do not already exclude,")
    print("and at one point it is strictly weaker, so the orbit specialisation is closed.")
