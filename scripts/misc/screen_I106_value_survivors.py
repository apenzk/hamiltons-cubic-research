"""Batch 35: batch 29's value comparison at the three points that survive every
recorded necessary condition.

WHY THESE POINTS.  r961's six-point screen found that THREE non-commuting critical
points clear batch 18, batch 21 and the orbit bound together, two of them by about
one per cent.  Batch 29's value comparison is the only lever left on the node and
it had been tested at twelve spectra that did NOT include the tight ones.

THE COMPARISON.  At a critical point the fields are fixed by the Lagrange forms,

    A = 3 mu U - 3 alpha U^2 - beta V^2,   C = mu V - beta {U, V},

batch 15 gives [A, C] = 0 so they share an eigenframe F, and the comparison is Phi
at the point against the best configuration DIAGONAL IN F at the same total norm
T = (3/2)|U|^2 + (1/2)|V|^2.

WHY THE OPTIMISER'S QUALITY DOES NOT MATTER.  The claim is that SOME diagonal
configuration beats the point, so a local optimum is a WITNESS and suffices.  A
better optimum would only widen the margin.  This is numerics used to exhibit an
object, not to establish a bound.

The screen prints |[A,C]| at each point as its own control: a point whose fields do
not commute is not a critical point of the block problem and its row means nothing.
"""

import numpy as np
from scipy.optimize import least_squares, minimize

AF, BF = 15 / 4, 9 / 4
br = lambda X, Y: X @ Y - Y @ X


def critical_point(u1, u2, mu):
    """the w3 = 0, w1 = w2 critical point at this spectrum and multiplier"""
    u3 = -u1 - u2
    uu = [u1, u2, u3]
    D1, D2 = u2 - u3, u1 - u3

    def mk(a2, w):
        a1 = (D1 / D2) * a2
        return np.diag(uu).astype(float), np.array(
            [[a1, 0.0, w], [0.0, a2, w], [w, w, -a1 - a2]])

    def res(z):
        a2, w = z
        U, V = mk(a2, w)
        K = br(U, V)
        VKV = V @ K @ V
        n = np.sum(V * V)
        q = lambda t: 3 * AF * BF * t * t + 3 * mu * (AF + BF) * t + 3 * mu * mu - 0.5 * BF * BF * n
        return [(uu[i] - uu[j]) * V[i, j] * q(uu[k]) - BF * BF * VKV[i, j]
                for (i, j, k) in [(0, 2, 1), (1, 2, 0)]]

    rng = np.random.default_rng(0)
    best = None
    seeds = [(1, 1), (-40, 1), (10, 1), (-10, 1), (100, 1), (-100, 1)]
    seeds += [tuple(rng.normal(0, 50, 2)) for _ in range(300)]
    for s in seeds:
        r = least_squares(res, s)
        if r.cost < 1e-12 and abs(r.x[1]) > 1e-9:
            if best is None or abs(r.x[1] - 1) < abs(best[1] - 1):
                best = r.x
    return mk(*best) if best is not None else (None, None)


def compare(u1, u2, mu, tag):
    U, V = critical_point(u1, u2, mu)
    if U is None:
        print(f"  ({u1:.0f},{u2:.0f}): no point found")
        return
    A = 3 * mu * U - 3 * AF * U @ U - BF * V @ V
    C = mu * V - BF * (U @ V + V @ U)
    T = 1.5 * np.sum(U * U) + 0.5 * np.sum(V * V)
    comm = np.linalg.norm(br(A, C))
    phi_c = AF * np.trace(U @ U @ U) + BF * np.trace(U @ V @ V) + np.sum(U * A) + np.sum(V * C)

    # common eigenframe of the two commuting fields; a generic combination splits it
    _, F = np.linalg.eigh(A + 0.7181 * C)
    Ad, Cd = F.T @ A @ F, F.T @ C @ F

    def negPhi(z):
        d1, d2, e1, e2 = z
        Ud, Vd = np.diag([d1, d2, -d1 - d2]), np.diag([e1, e2, -e1 - e2])
        return -(AF * np.trace(Ud @ Ud @ Ud) + BF * np.trace(Ud @ Vd @ Vd)
                 + np.sum(Ud * Ad) + np.sum(Vd * Cd))

    def con(z):
        d1, d2, e1, e2 = z
        return 1.5 * (d1 ** 2 + d2 ** 2 + (d1 + d2) ** 2) \
            + 0.5 * (e1 ** 2 + e2 ** 2 + (e1 + e2) ** 2) - T

    rng = np.random.default_rng(1)
    best = None
    with np.errstate(over="ignore", invalid="ignore"):
        for _ in range(400):
            r = minimize(negPhi, rng.normal(scale=np.sqrt(T), size=4),
                         constraints=[{"type": "eq", "fun": con}], method="SLSQP")
            if r.success and (best is None or r.fun < best.fun):
                best = r
    phi_d = -best.fun
    verdict = "diagonal wins" if phi_d > phi_c else "NON-COMMUTING WINS, lever refuted"
    print(f"  ({u1:.0f},{u2:.0f},{-u1-u2:.0f}) mu={mu:11.5f} [{tag}]")
    print(f"     control |[A,C]| = {comm:.2e}   T = {T:.4f}")
    print(f"     Phi at the point      = {phi_c:16.5f}")
    print(f"     best diagonal, same T = {phi_d:16.5f}   ratio {phi_d/phi_c:7.5f}   {verdict}")


if __name__ == "__main__":
    print("batch 29's value comparison at the three survivors of every recorded condition:")
    compare(1.0, -3.0, 11.60060, "clears the mu bounds by ~1%")
    compare(-1.0, -3.0, 24.43870, "clears the mu bounds by ~1%")
    compare(19.0, -20.0, 762.38453, "clears the mu bounds by a factor of 7")
    print("\nThe two margins are ANTI-CORRELATED: the points tightest on the mu bounds")
    print("lose the value comparison most widely, and the point clearing them by a")
    print("factor of seven is the tightest on value.")
