"""Batch 30's three relations, and the control that shows tracelessness is load-bearing.

WHAT IS CHECKED.  Commuting each Lagrange equation of G(2) with the other variable
gives two identities of the matrix ring,

    mu K - beta {U, K} = [U, C],        K = [U, V],
    [V, A]             = 3 alpha {U, K} - 3 mu K,

with A = 3 mu U - 3 alpha U^2 - beta V^2 and C = mu V - beta {U, V} the Lagrange
forms of batch 10.  Eliminating {U, K} between them leaves

    3 (alpha - beta) mu K = 3 alpha [U, C] + beta [V, A].

In U's own eigenframe the first identity is diagonal, each off-diagonal entry
satisfying (mu + beta u_k) K_ij = [U, C]_ij with k the complementary index.

THE CONTROL.  That entrywise form uses tr U = 0, through u_i + u_j = -u_k.  The
last block runs it with the trace left free and REPORTS THE FAILURE, so a reader
can see the check is able to fail.  The frame-free identities take no such
hypothesis and hold there too, which the same block shows.

A and C are DEFINED here by the Lagrange forms rather than constrained, so what
is screened is the algebra of the identities and not criticality itself.
"""

import sympy as sp


def symmetric(n, prefix):
    M = sp.zeros(n, n)
    for i in range(n):
        for j in range(i, n):
            s = sp.Symbol(f"{prefix}{i}{j}")
            M[i, j] = s
            M[j, i] = s
    return M


def bracket(X, Y):
    return sp.expand(X * Y - Y * X)


def anti(X, Y):
    return sp.expand(X * Y + Y * X)


mu, alpha, beta = sp.symbols("mu alpha beta")


def frame_free():
    U, V = symmetric(3, "u"), symmetric(3, "v")
    K = bracket(U, V)
    A = sp.expand(3 * mu * U - 3 * alpha * U * U - beta * V * V)
    C = sp.expand(mu * V - beta * anti(U, V))
    r1 = sp.expand(mu * K - beta * anti(U, K) - bracket(U, C))
    r2 = sp.expand(bracket(V, A) - (3 * alpha * anti(U, K) - 3 * mu * K))
    r3 = sp.expand(3 * (alpha - beta) * mu * K - (3 * alpha * bracket(U, C) + beta * bracket(V, A)))
    zero = sp.zeros(3, 3)
    print("R1  mu K - beta {U,K} = [U,C]                    :", sp.simplify(r1) == zero)
    print("R2  [V,A] = 3 alpha {U,K} - 3 mu K               :", sp.simplify(r2) == zero)
    print("R3  3(alpha-beta) mu K = 3 alpha [U,C] + beta[V,A]:", sp.simplify(r3) == zero)


def entrywise(traceless):
    u1, u2 = sp.symbols("u1 u2")
    u3 = -u1 - u2 if traceless else sp.Symbol("u3")
    a1, a2, w1, w2, w3 = sp.symbols("a1 a2 w1 w2 w3")
    a3 = -a1 - a2
    U = sp.diag(u1, u2, u3)
    V = sp.Matrix([[a1, w3, w2], [w3, a2, w1], [w2, w1, a3]])
    C = sp.expand(mu * V - beta * anti(U, V))
    K, com = bracket(U, V), bracket(U, C)
    tag = "traceless" if traceless else "trace FREE (the control)"
    ok = []
    for (i, j, uk) in [(0, 1, u3), (0, 2, u2), (1, 2, u1)]:
        ok.append(sp.simplify(sp.expand((mu + beta * uk) * K[i, j] - com[i, j])) == 0)
    print(f"  (mu + beta u_k) K_ij = [U,C]_ij  with {tag}: {ok}")


def companion():
    """Batch 31: the A-side eigenframe form, and the field-only identity it gives.

    Reading [V, A] = 3 alpha {U, K} - 3 mu K in U's eigenframe gives
    3 (mu + alpha u_k) K_ij = -[V, A]_ij, beside batch 30's
    (mu + beta u_k) K_ij = [U, C]_ij.  Both field commutators are entrywise
    proportional to K, so K eliminates between them and leaves

        3 (mu + alpha u_k) [U, C]_ij + (mu + beta u_k) [V, A]_ij = 0,

    a relation in the fields and U's spectrum with the commutator gone.  It needs
    only the two Lagrange equations, not maximality.
    """
    u1, u2 = sp.symbols("u1 u2")
    u3 = -u1 - u2
    a1, a2, w1, w2, w3 = sp.symbols("a1 a2 w1 w2 w3")
    a3 = -a1 - a2
    U = sp.diag(u1, u2, u3)
    V = sp.Matrix([[a1, w3, w2], [w3, a2, w1], [w2, w1, a3]])
    A = sp.expand(3 * mu * U - 3 * alpha * U * U - beta * V * V)
    C = sp.expand(mu * V - beta * anti(U, V))
    K, UC, VA = bracket(U, V), bracket(U, C), bracket(V, A)
    entries = [(0, 1, u3), (0, 2, u2), (1, 2, u1)]
    side = [sp.simplify(sp.expand(3 * (mu + alpha * uk) * K[i, j] + VA[i, j])) == 0
            for (i, j, uk) in entries]
    joint = [sp.simplify(sp.expand(3 * (mu + alpha * uk) * UC[i, j]
                                   + (mu + beta * uk) * VA[i, j])) == 0
             for (i, j, uk) in entries]
    print("  3 (mu + alpha u_k) K_ij = -[V,A]_ij                        :", side)
    print("  3 (mu + alpha u_k) [U,C]_ij + (mu + beta u_k) [V,A]_ij = 0 :", joint)

    # One external block: the fields collapse to polynomials in it, so [A, C] = 0
    # holds frame-free rather than through the shared frame.
    kappa, lam = sp.symbols("kappa lam")
    Xc = sp.diag(*sp.symbols("x1 x2 x3"))
    Cc, Ac = kappa * Xc, 4 * Xc * Xc + lam * Xc
    Uf = sp.Matrix(3, 3, lambda i, j: sp.Symbol(f"U{min(i, j)}{max(i, j)}"))
    print("  one external block, [A, C] = 0 frame-free                  :",
          sp.simplify(bracket(Ac, Cc)) == sp.zeros(3, 3))
    print("  one external block, [U + (2/3) Xc, kappa Xc] = kappa [U, Xc]:",
          sp.simplify(bracket(sp.expand(Uf + sp.Rational(2, 3) * Xc), Cc)
                      - kappa * bracket(Uf, Xc)) == sp.zeros(3, 3))


def vacuous_lever():
    """Batch 32: the obvious maximality input is an identity, not a constraint.

    Batch 7 attains its inner supremum at U commuting with beta V^2 + A, which
    reads as second-order information about a maximiser.  Substituting the A
    Lagrange form shows criticality alone forces it, since A already contains
    -beta V^2 and U commutes with 3 mu U - 3 alpha U^2:

        [U, beta V^2 + A] = beta [U, V^2] + [U, A] = beta {V,K} - beta {V,K} = 0.

    The multiple of I that the Lagrange form carries is kept here, so the check
    cannot pass by dropping it.
    """
    U, V = symmetric(3, "u"), symmetric(3, "v")
    c = sp.Symbol("c")
    K = bracket(U, V)
    A = sp.expand(3 * mu * U - 3 * alpha * U * U - beta * V * V + c * sp.eye(3))
    print("  [U, V^2] = {V, K}                                 :",
          sp.simplify(bracket(U, V * V) - sp.expand(V * K + K * V)) == sp.zeros(3, 3))
    print("  [U, A] = -beta {V, K}                             :",
          sp.simplify(bracket(U, A) + beta * sp.expand(V * K + K * V)) == sp.zeros(3, 3))
    print("  [U, beta V^2 + A] = 0 at EVERY critical point     :",
          sp.simplify(bracket(U, beta * V * V + A)) == sp.zeros(3, 3))
    print("  so batch 7's maximiser condition carries no information beyond criticality")


if __name__ == "__main__":
    frame_free()
    print("entrywise form, in U's eigenframe:")
    entrywise(True)
    entrywise(False)
    print("batch 31, the companion relations:")
    companion()
    print("batch 32, the vacuous maximality lever:")
    vacuous_lever()
    print("the control is expected to read [False, False, False]: the entrywise")
    print("form carries tr U = 0 inside it, while R1 to R3 above do not.")
