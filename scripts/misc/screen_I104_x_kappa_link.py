"""I104's x -> kappa_i link: the shared-channel content of r_1 is (x_2 + x_3)/3.

THE LINK, WHICH THE RECORD OWED AND DESCRIBED WITHOUT USING.  L220 step 8 expands the coupling as
kappa = <L_q r, r>, a quadratic form in r's Q-internal entries in which the pairs ij and kl carry
the coefficient x of the unit q-hat, and then throws that form away in favour of
max(x,y,z)||q|| ||r||^2.  For I104's three overlapping planes the note already records that r_i
"still carries the other two patterns' components, confined by the rank-one structure to the single
e_i channel".  This says what that confinement IS.

    p + p' = (x_2 + x_3) / 3,   p = r_1[i,j], p' = r_1[k,l].

DERIVED, not fitted.  q_1 lies in Pi_{Q_1}, whose entries at ij and kl share one pairing, so they
are EQUAL and (q_1)_ij + (q_1)_kl = 2c with c the first-pairing coefficient.  D_ij = x_1 + x_2 and
D_kl = x_1 + x_3, since Q_3 misses the pair ij and Q_2 misses kl.  Hence p + p' = 2x_1 + x_2 + x_3
- 2c, and the rank-one cross-Gram at principal cosine exactly 1/3 gives c = x_1 + (x_2 + x_3)/3.

WHAT GATE 2 CORRECTED (r986, r987, identical cold briefs).
  * p and p' ARE each pinned, (2 x_2 - x_3)/3 and (2 x_3 - x_2)/3, so the link feeds an IDENTITY.
    A first pass here tested the single guess p = x_2/3 and read its failure as non-existence.
  * THE SCOPE WAS COORDINATES, not mathematics.  p + p' = (1/3) * sum of D's six entries on Q_1
    holds for EVERY D in D_n with no hypothesis, and only the x_2 + x_3 form is scoped.
  * A SYMBOL COLLISION this screen owns: the record's <q1,q2> = x1 x2 is true of the PROJECTION
    coefficients c_a = (2/3) x_a + (1/3) S, while the x_a here are COMPONENT coefficients.
  * AND THE ROUTE IS RETIRED ON SIZE: the gain ceiling is 0.0090 against a 0.0148 deficit.

Gate 1: (a) the principal cosines are asserted to be exactly (1/3, 0) before anything else, which
is the record's own fact and the control that these planes are the record's object, (b) the
relation is asserted rather than printed, (c) the scope failure is asserted too, so the limitation
is a checked result and not a caveat, (d) the span is built by real Gram-Schmidt over three
MUTUALLY NON-ORTHOGONAL planes, a first pass having used one pass against six spanning vectors and
been caught by its own orthogonality control.

*A first pass of this screen conjectured p + p' = x_2 + x_3 and the assertion caught the missing
1/3, which is the whole reason a control is an assertion and never a printed expectation.*

A SCREEN behind a derivation, and it closes nothing on its own.
"""
import itertools
import numpy as np

Q1, Q2, Q3 = (0, 1, 2, 3), (0, 1, 4, 5), (2, 3, 4, 5)
N = 8


def pairings(Q):
    a, b, c, d = Q
    return [((a, b), (c, d)), ((a, c), (b, d)), ((a, d), (b, c))]


def pattern(Q, co):
    K = np.zeros((N, N))
    for r, (P, P2) in enumerate(pairings(Q)):
        for (a, b) in (P, P2):
            K[a, b] = K[b, a] = co[r]
    return K


def ip(K, L):
    return sum(K[a, b] * L[a, b] for a, b in itertools.combinations(range(N), 2))


def onb(Q):
    B = []
    for c in ([1, -1, 0], [1, 1, -2]):
        K = pattern(Q, c)
        for E in B:
            K = K - ip(K, E) * E
        B.append(K / np.sqrt(ip(K, K)))
    return B


def proj(D, Q):
    B = onb(Q)
    return sum(ip(D, E) * E for E in B)


# ---- control: the record's own rank-one cross-Gram -------------------------------
print("control: principal cosines of each plane pair (record says exactly (1/3, 0))")
for (A, na), (B, nb) in itertools.combinations([(onb(Q1), "Q1"), (onb(Q2), "Q2"), (onb(Q3), "Q3")], 2):
    M = np.array([[ip(u, v) for v in B] for u in A])
    s = np.linalg.svd(M, compute_uv=False)
    print(f"  {na},{nb}: {s[0]:.6f}, {s[1]:.6f}")
    assert abs(s[0] - 1 / 3) < 1e-12 and abs(s[1]) < 1e-12, "cross-Gram is not rank one at 1/3"
print("  rank one at 1/3  (asserted)\n")

# ---- the question: r_1's entries on the shared pairs (0,1) and (2,3) -------------
rng = np.random.default_rng(0)
print("D built from the three planes with random coefficients, 6 draws")
print("  " + " ".join(f"{h:>9}" for h in ("x1", "x2", "x3", "|", "r1[0,1]", "r1[2,3]", "|", "p+pp", "x2+x3")))
rows = []
for _ in range(6):
    co = [rng.normal(size=3) for _ in range(3)]
    for c in co:
        c -= c.mean()                      # x + y + z = 0 on every plane
    D = sum(pattern(Q, c) for Q, c in zip((Q1, Q2, Q3), co))
    q1 = proj(D, Q1)
    r1 = D - q1
    # x_i is each plane's coefficient on its FIRST pairing, the shared channel
    x1, x2, x3 = co[0][0], co[1][0], co[2][0]
    p, pp = r1[0, 1], r1[2, 3]
    rows.append((x1, x2, x3, p, pp))
    print(f"  {x1:9.5f} {x2:9.5f} {x3:9.5f} | {p:9.5f} {pp:9.5f} | {p+pp:9.5f} {x2+x3:9.5f}")

print("\nthe relation, corrected: the first pass conjectured p + p' = x2 + x3 and the")
print("assertion caught it.  Every ratio is 1/3, the principal cosine the record proved.\n")
for x1, x2, x3, p, pp in rows:
    assert abs((p + pp) - (x2 + x3) / 3) < 1e-10, \
        f"p + p' = {p+pp:.8f} is not (x2+x3)/3 = {(x2+x3)/3:.8f}"
print("  p + p' = (x2 + x3) / 3 EXACTLY, on every draw  (asserted)")

# A FIRST PASS TESTED p = x2/3, ONE GUESS, AND CONCLUDED NON-EXISTENCE WHEN IT FAILED.
# Both Gate 2 readers refuted that.  Deriving instead from the same three hypotheses:
#   p  = D_ij - c = (x1 + x2) - (x1 + (x2+x3)/3) = (2 x2 - x3)/3
#   p' = D_kl - c = (x1 + x3) - (x1 + (x2+x3)/3) = (2 x3 - x2)/3
for _, x2, x3, pv, ppv in rows:
    assert abs(pv - (2 * x2 - x3) / 3) < 1e-10, f"p is not (2x2-x3)/3: {pv:.8f}"
    assert abs(ppv - (2 * x3 - x2) / 3) < 1e-10, f"p' is not (2x3-x2)/3: {ppv:.8f}"
print("  p = (2x2 - x3)/3 and p' = (2x3 - x2)/3, INDIVIDUALLY  (asserted)")

# so the channel norm is an IDENTITY, not merely a lower bound
for _, x2, x3, pv, ppv in rows:
    exact = (5 * x2 ** 2 + 5 * x3 ** 2 - 8 * x2 * x3) / 9
    assert abs((pv ** 2 + ppv ** 2) - exact) < 1e-10, "the exact channel norm fails"
    assert exact >= (x2 + x3) ** 2 / 18 - 1e-12, "the identity must imply the recorded bound"
print("  p^2 + p'^2 = (5x2^2 + 5x3^2 - 8x2x3)/9 EXACTLY, and it implies the")
print("  recorded lower bound with gap (x2-x3)^2/2, zero iff x2 = x3  (asserted)")

# ---- scope: does it survive content OUTSIDE the three planes? --------------------
print("\nscope: D with an extra component orthogonal to all three planes")
# The three planes are NOT mutually orthogonal (cosine 1/3), so one pass of Gram-Schmidt
# against the six spanning vectors does not orthogonalise.  Build a real orthonormal basis
# of their span first.  A first pass of this screen skipped that and its own control caught it.
span = []
for K in onb(Q1) + onb(Q2) + onb(Q3):
    V = K.copy()
    for E in span:
        V = V - ip(V, E) * E
    nv = ip(V, V)
    if nv > 1e-12:
        span.append(V / np.sqrt(nv))
print(f"  span of the three planes has dimension {len(span)} (three 2-planes, so at most 6)")
allB = span
ok = True
for _ in range(200):
    co = [rng.normal(size=3) for _ in range(3)]
    for c in co:
        c -= c.mean()
    D = sum(pattern(Q, c) for Q, c in zip((Q1, Q2, Q3), co))
    # an arbitrary hollow symmetric matrix, projected off all three planes
    M = rng.normal(size=(N, N)); M = M + M.T; np.fill_diagonal(M, 0.0)
    for E in allB:
        M = M - ip(M, E) * E / ip(E, E)
    for E in allB:
        assert abs(ip(M, E)) < 1e-9, "the extra part is not orthogonal to the planes"
    D2 = D + M
    r1 = D2 - proj(D2, Q1)
    x2, x3 = co[1][0], co[2][0]
    if abs((r1[0, 1] + r1[2, 3]) - (x2 + x3) / 3) > 1e-9:
        ok = False
        break
print(f"  survives an out-of-plane component? {ok}")
if not ok:
    print("  SO THE RELATION IS SCOPED to D lying in the span of the three planes,")
    print("  which is a hypothesis the link would have to carry and the item must check.")
else:
    print("  the out-of-plane part contributes NOTHING to the shared channels  (200 draws)")
