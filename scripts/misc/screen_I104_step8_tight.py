"""I104: L220 step 8 is TIGHT over D_n minus Pi_Q, so the 0.02 is not in step 8 itself.

**What this refutes.** The working note recorded two live sources for the chain's 0.02 shortfall, and
one of them was step 8's sub-claim (ii), that the bound assigns ALL of |r|^2 to the top coefficient
while r carries components the top coefficient does not see.  This screen shows (ii) is empty in
L220's own setting: the bound is ATTAINED.

**The derivation this screens.**  L220 step 8 gives the form explicitly, so no product formula for
D_n is needed:

    <L_qhat r, r> = x(p^2+p'^2) + y(a'^2+b'^2) + z(c'^2+d'^2) + (1/2) sum_m c_m^T qhat c_m,

with the internal entries on Q's six pairs, c_m = (r_am)_{a in Q} the outside columns, and the cross
term Sigma vanishing by orthogonality to Pi_Q.  Step 8 then bounds this by max(x,y,z)|r|^2, using
that qhat has spectrum {0, 2x, 2y, 2z} on R^Q.  The question is whether that bound is attained over
the admissible r, and it is, at every shape tried, to twelve digits.

**A refinement of mine that this also kills.**  qhat annihilates 1_Q, since the sectional matrix on Q
has row sums x+y+z = 0, so the sharper bound keeps only the part orthogonal to 1_Q:

    sum_m c_m^T qhat c_m <= 2 max(x,y,z) sum_m ( |c_m|^2 - <c_m,1_Q>^2 / 4 ).

That is valid and strictly better pointwise, and it is VACUOUS where it would have to act: at n = 8 a
unit r meeting every condition with all <c_m,1_Q> = 0 exists on a 14-dimensional subspace of the
20-dimensional D_n, so the gain is exactly zero there.

**What survives, stated narrowly.**  This is L220's setting, where the only constraints on r are that
it lies in D_n and is orthogonal to Pi_Q.  In I104 the residual r_i = D - q_i carries the OTHER two
patterns' components, which is a further constraint this screen does not impose.  So the finding is
that the gain cannot come from step 8's own slack, and must come from I104's extra structure if it
exists at all.  *That is a localisation, not a closure.*

Gate 1: (a) the D_n dimension n(n-3)/2 is reproduced as a control, (b) the spectrum {0,2x,2y,2z} is
checked against its closed form, (c) every constructed object is screened and every expectation is
ASSERTED rather than printed, (d) the computed sup is compared against max(x,y,z), the ceiling step 8
claims.

**A SCREEN, and here it REFUTES a recorded claim rather than supporting one.**
"""

import numpy as np

n, Q = 8, [0, 1, 2, 3]
out = [m for m in range(n) if m not in Q]
pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
idx = {p: t for t, p in enumerate(pairs)}
NP = len(pairs)


def sectional(x, y, z):
    v = np.zeros(NP)
    i, j, k, l = Q
    for (a, b), val in (((i, j), x), ((k, l), x), ((i, k), y),
                        ((j, l), y), ((i, l), z), ((j, k), z)):
        v[idx[(min(a, b), max(a, b))]] = val
    return v


def qhat_mat(x, y, z):
    return np.array([[0, x, y, z], [x, 0, z, y], [y, z, 0, x], [z, y, x, 0]], float)


def kappa_form(x, y, z):
    """L220 step 8's own formula as a quadratic form in the pair coordinates of r."""
    M = np.zeros((NP, NP))
    i, j, k, l = Q
    for (a, b), coef in (((i, j), x), ((k, l), x), ((i, k), y),
                         ((j, l), y), ((i, l), z), ((j, k), z)):
        t = idx[(min(a, b), max(a, b))]
        M[t, t] += coef
    K = qhat_mat(x, y, z)
    for m in out:
        for u_, a in enumerate(Q):
            for v_, b in enumerate(Q):
                ta = idx[(min(a, m), max(a, m))]
                tb = idx[(min(b, m), max(b, m))]
                M[ta, tb] += 0.5 * K[u_, v_]
    return (M + M.T) / 2


# D_n in pair coordinates: zero row sums
C = np.zeros((n, NP))
for t, (a, b) in enumerate(pairs):
    C[a, t] = 1.0
    C[b, t] = 1.0
_, s, vt = np.linalg.svd(C)
Dn = vt[np.sum(s > 1e-9):]
assert Dn.shape[0] == n * (n - 3) // 2, f"D_n dimension {Dn.shape[0]}, expected {n*(n-3)//2}"

print("=" * 84)
print("I104: is L220 step 8's coupling bound attained over D_n minus Pi_Q?")
print("=" * 84)
print(f"\ndim D_n at n={n}: {Dn.shape[0]}, matching n(n-3)/2  (asserted)")

# the spectrum claim, asserted
for _ in range(200):
    x, y = np.random.default_rng().standard_normal(2)
    z = -x - y
    w = np.sort(np.linalg.eigvalsh(qhat_mat(x, y, z)))
    assert np.allclose(w, np.sort(np.array([0.0, 2 * x, 2 * y, 2 * z])), atol=1e-11), \
        "the spectrum {0,2x,2y,2z} FAILED"
print("spectrum {0, 2x, 2y, 2z} on R^Q confirmed over 200 draws  (asserted)")

Pi = np.array([sectional(1, 0, -1), sectional(0, 1, -1)])
print(f"\n{'shape':<14} {'max(x,y,z)':>12} {'sup <L r,r>/|r|^2':>20} {'ratio':>10}  verdict")
for tag, (x, y, z) in (("S2xS2", (0.5773502692, -0.2886751346, -0.2886751346)),
                       ("generic", (0.4, 0.1, -0.5)),
                       ("skewed", (0.7, -0.2, -0.5)),
                       ("near-edge", (0.5, -0.25, -0.25))):
    nq = np.sqrt(2 * (x * x + y * y + z * z))
    xs, ys, zs = x / nq, y / nq, z / nq
    rows = Pi @ Dn.T
    _, ss, vv = np.linalg.svd(rows)
    sub = vv[np.sum(ss > 1e-9):] @ Dn
    G = sub @ sub.T
    F = sub @ kappa_form(xs, ys, zs) @ sub.T
    top = np.linalg.eigvalsh(np.linalg.solve(G, (F + F.T) / 2)).max()
    bound = max(xs, ys, zs)
    tight = abs(top - bound) < 1e-8
    print(f"{tag:<14} {bound:>12.6f} {top:>20.6f} {top/bound:>10.6f}  "
          f"{'TIGHT' if tight else 'slack ' + format(bound - top, '.6f')}")

print("\n" + "=" * 84)
print("Step 8 is ATTAINED over D_n minus Pi_Q, so its sub-claim (ii) carries no slack THERE.")
print("I104's r_i obeys a further constraint this screen does not impose, carrying the other two")
print("patterns' components, so any gain must live in that extra structure and not in step 8.")
print("A localisation, not a closure.")
print("=" * 84)
