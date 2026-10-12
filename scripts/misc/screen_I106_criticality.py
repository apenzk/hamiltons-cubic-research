"""Screens batches 15 to 19 of the m >= 3 derivation: the criticality system of G(2).

BATCH 15, two derived formulas, each checked against a direct computation.

(1) Batch 10's displayed form equals [A, C] for the Lagrange forms of a critical point of
    Phi = al tr(U^3) + be tr(U V^2) + <U,A> + <V,C>  on  (3/2)|U|^2 + (1/2)|V|^2 = T,
    namely  A = 3 mu U - 3 al U^2 - be V^2  and  C = mu V - be {U, V}  up to multiples of I.
    Since A and C are diagonal in one frame they commute, and [A, C] = 0 is the system.

(2) In an eigenframe of U, with K = [U, V], the first three terms of that form have (i, j) entry
    (u_i - u_j) V_ij * phi_k, where k is the index complementary to {i, j} and

        phi_k = 3 mu^2 - (1/2) be^2 |V|^2 + 3 mu (al + be) u_k + 3 al be u_k^2.

    The |U|^2 terms cancel, so phi is one quadratic evaluated at the three eigenvalues of U.

BATCH 16, the structure of the remaining term. Writing the diagonal of V as (a1, a2, a3) and its
off-diagonal entries as w_k, the entry opposite index k, and D_3 = u1 - u2, D_2 = u1 - u3,
D_1 = u2 - u3:

(3) (V K V)_12 = D_3 w_3 a1 a2 + w_1 w_2 (a1 D_2 - a2 D_1) + w_3 (w_1^2 D_1 - w_2^2 D_2 - w_3^2 D_3),
    so every term of equation k carries either w_k or the product of the other two.

(4) With w_1 = w_2 = 0 the equations for entries (1,3) and (2,3) hold identically, and the one for
    (1,2) reduces, using tr V = 0, to the single scalar condition

        3 al be u_3^2 + 3 mu (al + be) u_3 + 3 mu^2 = be^2 a_3^2,

    free of w_3 entirely.

(5) For U with distinct eigenvalues, U and V share an eigenvector exactly when at most one w_k is
    nonzero. So the criticality system says something new only where at least two are nonzero.

BATCH 17, the system paired with the commutator.

(6) Pairing [A, C] = 0 with K in the skew inner product gives one scalar identity,
    2 sum_k D_k^2 w_k^2 q(u_k) + be^2 tr((V K)^2) = 0, in which the fields no longer appear.
    It needs tracelessness, since batch 10's displayed form does.

(7) tr((V K)^2) takes both signs, so that identity closes nothing on its own.

BATCH 18, the second-order bound on the multiplier.

(8) The Jordan operator L(V) = (U V + V U)/2 on traceless symmetric matrices has top eigenvalue
    |U|/sqrt6, carried by the traceless diagonal directions, since the off-diagonal ones give
    -u_k/2 and 2|U|^2 - 3 u_k^2 = (u_i - u_j)^2 >= 0.

(9) At a constrained maximiser the multiplier satisfies the SHARP bound mu >= 2 beta |U|/sqrt6,
    the factor of two coming from {U,V} = 2 L V so that the trust-region multiplier is mu/2, and
    yet q is NOT positive at all three eigenvalues of U, which refutes batch 17's sign lever.

BATCH 19, the degenerate spectrum u = (t, t, -2t), where batch 18's bound is tight.

(10) The system there is (i) w1 w2 (a1 - a2) + w3 (w1^2 - w2^2) = 0, which carries no q because
     D_3 = 0, together with (ii) and (iii) scaled by D_1 = D_2 = 3t.

(11) w2*(ii) - w1*(iii) = be^2 a3 * (i), so (i) is redundant wherever a3 is nonzero.

(12) Eliminating w3 leaves (w1^2 - w2^2)(Q + be^2 S) = be^2 a3 (a2 w1^2 - a1 w2^2), S = w1^2 + w2^2.

(13) w1 = 0 forces w2 = 0 or w3 = 0, so two nonzero entries require w1 w2 nonzero.

Usage: python3 scripts/misc/screen_I106_criticality.py
"""

import numpy as np
import sympy as sp

rng = np.random.default_rng(11)
AL, BE = 15 / 4, 9 / 4


def sym0(r):
    """A random traceless symmetric 3x3."""
    M = r.normal(size=(3, 3))
    M = (M + M.T) / 2
    return M - np.trace(M) / 3 * np.eye(3)


def run_batch15(trials=4000):
    worst_form, worst_phi = 0.0, 0.0
    for _ in range(trials):
        U, V = sym0(rng), sym0(rng)
        mu = rng.normal()

        A = 3 * mu * U - 3 * AL * U @ U - BE * V @ V
        C = mu * V - BE * (U @ V + V @ U)
        K = U @ V - V @ U
        displayed = (
            (3 * mu**2 + 1.5 * AL * BE * np.trace(U @ U) - 0.5 * BE**2 * np.trace(V @ V)) * K
            - 3 * mu * (AL + BE) * (U @ U @ V - V @ U @ U)
            + 3 * AL * BE * (U @ K @ U)
            - BE**2 * (V @ K @ V)
        )
        worst_form = max(worst_form, np.abs((A @ C - C @ A) - displayed).max())

        u, Q = np.linalg.eigh(U)
        Ve = Q.T @ V @ Q
        Du = np.diag(u)
        Ke = Du @ Ve - Ve @ Du
        first3 = (
            (3 * mu**2 + 1.5 * AL * BE * (u @ u) - 0.5 * BE**2 * np.trace(Ve @ Ve)) * Ke
            - 3 * mu * (AL + BE) * (np.diag(u**2) @ Ve - Ve @ np.diag(u**2))
            + 3 * AL * BE * (Du @ Ke @ Du)
        )
        for i in range(3):
            for j in range(3):
                if i == j:
                    continue
                k = 3 - i - j
                phi = (3 * mu**2 - 0.5 * BE**2 * np.trace(Ve @ Ve)
                       + 3 * mu * (AL + BE) * u[k] + 3 * AL * BE * u[k] ** 2)
                worst_phi = max(worst_phi, abs(first3[i, j] - (u[i] - u[j]) * Ve[i, j] * phi))
    return worst_form, worst_phi


def run_batch16():
    """Items 3 and 4, exactly, in sympy."""
    u1, u2, u3, mu, al, be = sp.symbols('u1 u2 u3 mu alpha beta')
    a1, a2, a3, w1, w2, w3 = sp.symbols('a1 a2 a3 w1 w2 w3')
    U = sp.diag(u1, u2, u3)
    V = sp.Matrix([[a1, w3, w2], [w3, a2, w1], [w2, w1, a3]])
    VKV = sp.expand(V * (U * V - V * U) * V)
    D3, D2, D1 = u1 - u2, u1 - u3, u2 - u3

    regrouped = (D3 * w3 * a1 * a2 + w1 * w2 * (a1 * D2 - a2 * D1)
                 + w3 * (w1**2 * D1 - w2**2 * D2 - w3**2 * D3))
    ok3 = sp.simplify(VKV[0, 1] - regrouped) == 0

    sub = {w1: 0, w2: 0}
    ok4a = (sp.simplify(VKV[0, 2].subs(sub)) == 0) and (sp.simplify(VKV[1, 2].subs(sub)) == 0)
    normsq = a1**2 + a2**2 + a3**2 + 2 * (w1**2 + w2**2 + w3**2)
    q3 = 3 * al * be * u3**2 + 3 * mu * (al + be) * u3 + 3 * mu**2 - sp.Rational(1, 2) * be**2 * normsq
    eq12 = sp.expand((D3 * w3 * q3 - be**2 * VKV[0, 1]).subs(sub))
    target = D3 * w3 * (3 * al * be * u3**2 + 3 * mu * (al + be) * u3 + 3 * mu**2 - be**2 * a3**2)
    # traceless V: substitute a1 + a2 + a3 = 0 by eliminating a2
    ok4b = sp.simplify((eq12 - target).subs({a2: -a1 - a3})) == 0
    return ok3, ok4a, ok4b


def run_batch16_item5(trials=20000):
    """Sharing an eigenvector against 'at most one w nonzero', for distinct eigenvalues of U."""
    bad = 0
    for _ in range(trials):
        ws = rng.normal(size=3) * (rng.random(3) < 0.5)
        a = rng.normal(size=3)
        a -= a.mean()
        V = np.array([[a[0], ws[2], ws[1]], [ws[2], a[1], ws[0]], [ws[1], ws[0], a[2]]])
        nonzero = int(sum(abs(w) > 1e-12 for w in ws))
        fixes = any(abs(V[k, i]) < 1e-12 and abs(V[k, j]) < 1e-12
                    for k, (i, j) in zip(range(3), [(1, 2), (0, 2), (0, 1)]))
        if fixes != (nonzero <= 1):
            bad += 1
    return bad


def run_batch17():
    """The pairing of the system with K, exact, under tracelessness."""
    u1, u2, mu, al, be = sp.symbols('u1 u2 mu alpha beta')
    a1, a2, w1, w2, w3 = sp.symbols('a1 a2 w1 w2 w3')
    u3, a3 = -u1 - u2, -a1 - a2
    U = sp.diag(u1, u2, u3)
    V = sp.Matrix([[a1, w3, w2], [w3, a2, w1], [w2, w1, a3]])
    K = U * V - V * U
    normsq = a1**2 + a2**2 + a3**2 + 2 * (w1**2 + w2**2 + w3**2)

    def q(t):
        return 3 * al * be * t**2 + 3 * mu * (al + be) * t + 3 * mu**2 - sp.Rational(1, 2) * be**2 * normsq

    A = 3 * mu * U - 3 * al * U * U - be * V * V
    C = mu * V - be * (U * V + V * U)
    M = A * C - C * A
    D3, D2, D1 = u1 - u2, u1 - u3, u2 - u3
    paired = sp.expand(-sp.trace(M * K))
    claim = sp.expand(2 * (D3**2 * w3**2 * q(u3) + D2**2 * w2**2 * q(u2) + D1**2 * w1**2 * q(u1))
                      + be**2 * sp.trace((V * K) * (V * K)))
    return sp.simplify(paired - claim) == 0


def run_batch17_sign(trials=200000):
    """tr((V K)^2) is not signed, so the paired identity closes nothing on its own."""
    lo, hi = np.inf, -np.inf
    for _ in range(trials):
        V, U = sym0(rng), sym0(rng)
        S = V @ (U @ V - V @ U)
        t = float(np.trace(S @ S))
        lo, hi = min(lo, t), max(hi, t)
    return lo, hi


def run_batch18():
    """Items 8 and 9. Its own generator, so the printed numbers do not depend on the
    draws the earlier items consume."""
    from scipy.optimize import minimize
    r = np.random.default_rng(23)
    Bs = [np.diag([1.0, -1.0, 0.0])/np.sqrt(2), np.diag([1.0, 1.0, -2.0])/np.sqrt(6)]
    for i, j in [(0, 1), (0, 2), (1, 2)]:
        E = np.zeros((3, 3)); E[i, j] = E[j, i] = 1/np.sqrt(2); Bs.append(E)

    def jordan_max(U):
        M = np.zeros((5, 5))
        for b, Eb in enumerate(Bs):
            img = 0.5*(U @ Eb + Eb @ U)
            for a, Ea in enumerate(Bs):
                M[a, b] = np.sum(Ea*img)
        return np.linalg.eigvalsh(M).max()

    worst, worst2 = 0.0, np.inf
    for _ in range(20000):
        u = r.normal(size=3); u -= u.mean()
        worst = max(worst, abs(jordan_max(np.diag(u)) - np.linalg.norm(u)/np.sqrt(6)))
        worst2 = min(worst2, np.linalg.norm(u)/np.sqrt(6) + u.min()/2)

    def unpack(x):
        return (sum(x[i]*Bs[i] for i in range(5)), sum(x[5+i]*Bs[i] for i in range(5)))

    def negPhi(x, A, C, T):
        U, V = unpack(x)
        s = np.sqrt(T/(1.5*np.sum(U*U) + 0.5*np.sum(V*V)))
        U, V = s*U, s*V
        return -(AL*np.trace(U@U@U) + BE*np.trace(U@V@V) + np.sum(U*A) + np.sum(V*C))

    bad_mu = qneg = noncomm = 0
    ratios = []
    for _ in range(10):
        a = r.normal(size=3); a -= a.mean()
        c = r.normal(size=3); c -= c.mean()
        A, C = np.diag(a), np.diag(c)
        T = r.choice([1.0, 4.0])
        bv, best = -np.inf, None
        for _ in range(120):
            res = minimize(negPhi, r.normal(size=10), args=(A, C, T), method="Nelder-Mead",
                           options={"maxiter": 6000, "xatol": 1e-11, "fatol": 1e-13})
            if -res.fun > bv:
                bv, best = -res.fun, res.x
        U, V = unpack(best)
        s = np.sqrt(T/(1.5*np.sum(U*U) + 0.5*np.sum(V*V))); U, V = s*U, s*V
        mu = np.sum((BE*(U@V + V@U) + C)*V)/np.sum(V*V)
        if mu < 2*BE*jordan_max(U) - 1e-6:
            bad_mu += 1
        ratios.append(mu/(BE*jordan_max(U)))
        u = np.linalg.eigvalsh(U)
        q = [3*AL*BE*t**2 + 3*mu*(AL+BE)*t + 3*mu**2 - 0.5*BE**2*np.sum(V*V) for t in u]
        if min(q) < 0:
            qneg += 1
        if np.abs(U@V - V@U).max() > 1e-6:
            noncomm += 1
    return worst, worst2, bad_mu, qneg, noncomm, min(ratios), max(ratios)


def run_batch19():
    """Items 10 to 13, exactly, on the spectrum (t, t, -2t)."""
    t, mu, al, be = sp.symbols('t mu alpha beta')
    a1, a2, w1, w2, w3 = sp.symbols('a1 a2 w1 w2 w3')
    a3 = -a1 - a2
    U = sp.diag(t, t, -2*t)
    V = sp.Matrix([[a1, w3, w2], [w3, a2, w1], [w2, w1, a3]])
    VKV = sp.expand(V * (U * V - V * U) * V)
    normsq = a1**2 + a2**2 + a3**2 + 2*(w1**2 + w2**2 + w3**2)
    Qe = 3*al*be*t**2 + 3*mu*(al + be)*t + 3*mu**2 - sp.Rational(1, 2)*be**2*normsq
    S = w1**2 + w2**2
    Q = sp.Symbol('Q')

    i_ = w1*w2*(a1 - a2) + w3*(w1**2 - w2**2)
    ii_ = w1*(Q - be**2*(a2*a3 - S)) - be**2*a3*w2*w3
    iii_ = w2*(Q - be**2*(a1*a3 - S)) - be**2*a3*w1*w3

    ok10 = (sp.simplify(sp.expand(0*w3*Qe - be**2*VKV[0, 1]) + 3*be**2*t*i_) == 0
            and sp.simplify(sp.expand((3*t)*w1*Qe - be**2*VKV[1, 2]) - 3*t*ii_.subs(Q, Qe)) == 0
            and sp.simplify(sp.expand((3*t)*w2*Qe - be**2*VKV[0, 2]) - 3*t*iii_.subs(Q, Qe)) == 0)
    ok11 = sp.simplify(sp.expand(w2*ii_ - w1*iii_) - be**2*a3*i_) == 0
    w3sol = sp.solve(iii_, w3)[0]
    reduced = sp.expand(ii_.subs(w3, w3sol)*w1)
    claim = (w1**2 - w2**2)*(Q + be**2*S) - be**2*a3*(a2*w1**2 - a1*w2**2)
    ok12 = sp.simplify(reduced - claim) == 0
    ok13 = sp.simplify(i_.subs({w1: 0}) + w2**2*w3) == 0
    return ok10, ok11, ok12, ok13


if __name__ == "__main__":
    f, p = run_batch15()
    print(f"(1) batch 10's displayed form against [A, C], worst entry gap over 4000 draws: {f:.3e}")
    print(f"(2) the phi_k factorisation in U's eigenframe, worst gap: {p:.3e}")
    ok3, ok4a, ok4b = run_batch16()
    print(f"(3) the regrouping of (V K V)_12, exact in sympy: {ok3}")
    print(f"(4) at w1 = w2 = 0 the other two entries vanish: {ok4a}; "
          f"equation (1,2) reduces to the stated scalar condition: {ok4b}")
    print(f"(5) 'shares an eigenvector' against 'at most one w nonzero', "
          f"mismatches in 20000: {run_batch16_item5()}")
    print(f"(6) the pairing with K, exact in sympy under tracelessness: {run_batch17()}")
    lo, hi = run_batch17_sign()
    print(f"(7) tr((V K)^2) over 200000 traceless symmetric pairs: min {lo:.4f}, max {hi:.4f}, "
          f"so it is not signed")
    w, w2, bad_mu, qneg, noncomm, rlo, rhi = run_batch18()
    print(f"(8) |lambda_max(L_U) - |U|/sqrt6| over 20000 draws: {w:.3e}; "
          f"min of |U|/sqrt6 + u_min/2: {w2:.3e}")
    print(f"(9) at 10 constrained maximisers: mu below the SHARP 2*beta*lambda_max in {bad_mu}, "
          f"ratio mu/(beta*lambda_max) in [{rlo:.4f}, {rhi:.4f}], "
          f"some q(u_k) < 0 in {qneg}, non-commuting in {noncomm}")
    ok10, ok11, ok12, ok13 = run_batch19()
    print(f"(10) the degenerate system matches batch 16's: {ok10}")
    print(f"(11) (i) is redundant off a3 = 0: {ok11}")
    print(f"(12) eliminating w3 leaves the single stated equation: {ok12}")
    print(f"(13) w1 = 0 forces w2 w3 = 0 through (i): {ok13}")
