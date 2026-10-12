"""I104: the Gram route on the three overlapping four-set pattern planes is EXHAUSTED.

THE GEOMETRY.  Q1 = {i,j,k,l}, Q2 = {i,j,m,p}, Q3 = Q1 sym-diff Q2 = {k,l,m,p}.
Pi_Q is the plane of sectional matrices supported on Q, carrying x, y, z on the
three pairings with x + y + z = 0, unit when 2(x^2+y^2+z^2) = 1.

Two planes share exactly ONE matrix entry: ij for (Q1,Q2), kl for (Q1,Q3), mp for
(Q2,Q3).  So <q1,q2> = x1 x2 factors through one linear functional on each plane:
the cross-Gram has RANK ONE, and the principal cosines are exactly (1/3, 0) rather
than "at most 1/3".

WHAT THAT GIVES, AND WHY IT CLOSES THE ROUTE.  Writing q_i = alpha_i e_i + beta_i f_i
with e the shared channel and f orthogonal to everything else,

    sum u_i^2 <= lambda_max(G_e) * t,   G_e = unit diagonal, off-diagonals +-1/3.

THE PARITY CONSTRAINT.  The three cosines are x1x2, x1x3, x2x3, whose product is
(x1x2x3)^2 >= 0, so an EVEN number are negative.  The odd patterns would give
lambda_max = 4/3, and they are geometrically impossible; every admissible pattern
gives 5/3.  The parity constraint works against the bound rather than for it.

So sum u_i^2 <= (5/3) t, ATTAINED, which is exactly the (1 + 2/3) t that the
tau-positive note already screened as insufficient by 0.02.  The note's twice-stated
recommendation, that a Gram treatment should close the gap, is therefore refuted,
and the remaining gain must come from the coupling bound kappa_i instead.

Screening and refutation of a candidate route, which is what numerics are for.
"""

import itertools

import numpy as np

Q1, Q2, Q3 = (0, 1, 2, 3), (0, 1, 4, 5), (2, 3, 4, 5)


def pairings(Q):
    a, b, c, d = Q
    return [((a, b), (c, d)), ((a, c), (b, d)), ((a, d), (b, c))]


def pattern(Q, co, n=8):
    K = np.zeros((n, n))
    for r, (P, P2) in enumerate(pairings(Q)):
        for (a, b) in (P, P2):
            K[a, b] = K[b, a] = co[r]
    return K


def ip(K, L):
    return sum(K[a, b] * L[a, b] for a, b in itertools.combinations(range(8), 2))


def onb(Q):
    """orthonormal basis of the 2-plane {x + y + z = 0} of patterns on Q"""
    B = []
    for c in ([1, -1, 0], [1, 1, -2]):
        K = pattern(Q, c)
        for E in B:
            K = K - ip(K, E) * E
        B.append(K / np.sqrt(ip(K, K)))
    return B


def principal_cosines():
    print("1. the cross-Gram of each pair of planes")
    for (Ba, na), (Bb, nb) in itertools.combinations(
            [(onb(Q1), "Q1"), (onb(Q2), "Q2"), (onb(Q3), "Q3")], 2):
        M = np.array([[ip(u, v) for v in Bb] for u in Ba])
        s = np.linalg.svd(M, compute_uv=False)
        print(f"   {na},{nb}: principal cosines {np.round(s, 12)}  "
              f"rank {np.linalg.matrix_rank(M, tol=1e-12)}  <- exactly (1/3, 0)")


def spectrum_over_signs():
    print("2. lambda_max(G_e) over every sign pattern, and the parity constraint")
    for signs in itertools.product([1, -1], repeat=3):
        a, b, c = (s / 3 for s in signs)
        ev = np.sort(np.linalg.eigvalsh(np.array([[1, a, b], [a, 1, c], [b, c, 1]])))
        neg = sum(1 for s in signs if s < 0)
        mark = "admissible" if neg % 2 == 0 else "IMPOSSIBLE (odd)"
        print(f"   signs {signs}  negatives {neg}  lambda_max {ev[-1]:.6f}  {mark}")
    print("   only the even patterns occur, and every one of them gives 5/3")


def attainment():
    a = b = c = 1 / 3
    G = np.array([[1, a, b], [a, 1, c], [b, c, 1]])
    ev, V = np.linalg.eigh(G)
    cvec = V[:, -1]
    normD2 = cvec @ G @ cvec
    alpha = G @ cvec
    print("3. attainment")
    print(f"   ||D||^2 = {normD2:.6f}, sum alpha_i^2 = {alpha @ alpha:.6f}, "
          f"ratio = {(alpha @ alpha) / normD2:.6f}, lambda_max = {ev[-1]:.6f}")
    print("   the ratio equals lambda_max, so (5/3) t is attained and cannot be improved")


if __name__ == "__main__":
    principal_cosines()
    spectrum_over_signs()
    attainment()
    print("\nThe Gram route yields exactly the note's (1 + 2/3) t, so it is exhausted,")
    print("and the 0.02 shortfall must be closed from the coupling bound kappa_i instead.")
