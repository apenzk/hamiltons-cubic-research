# REVIEW r1671: MW' for m >= 7 (J1 working note, batch 11)

Log: [agent_logs/r1671.log](../agent_logs/r1671.log). Brief: MW' batch 11, frozen at dispatch. Footing: analysis only; the symbolic checks below recompute identities the note states, and the one numeric run is a refutation screen.

**Verdict: CONFIRMED.** Every link of Steps 1 to 3 follows from the step above and the stated hypotheses, and MW' for m >= 7 follows. The gaps found are presentational: each is closed by a one-line argument, recorded below. The J1 and H consequence is PLAUSIBLE only because it rests on batch 3 and L273 (3), which lie outside the brief.

| step | verdict |
|---|---|
| Step 1 (a), gamma form and affinity in pi | CONFIRMED |
| Step 1 (b), R0 | CONFIRMED |
| Step 1 (c), R-half | CONFIRMED (gap G1, minor) |
| left-concave reduction | CONFIRMED (gap G2, minor) |
| Step 2, weighted column Cauchy-Schwarz | CONFIRMED (gap G3, minor) |
| Step 3, H_c | CONFIRMED (gap G4, minor) |
| Assembly, MW' for m >= 7 | CONFIRMED |
| Consequence, J1 and H on the torus slice for m >= 7 | PLAUSIBLE (conditional on givens outside the brief) |
| Lean fidelity, MWPrime.lean | CONFIRMED (compiles, four `sorry`, statements faithful) |

## Step 1 (a)

- Per entry, with sum_j q_j = 1 and 1 - rho = sum_j q_j(1 - q_j): q(1-q)(1+g(1-2q)) + kappa pi q^2(1-g^2) - beta q(1-q) - kappa pi q = q(1-q)(g(1-2q) + A(pi)) - kappa pi g^2 q^2, with A(pi) = 1 - beta - kappa pi = kappa pi/(n-1) - (n-2)/n. Checked symbolically (difference 0).
- F's maximum is entrywise, so the max form is equivalent to the all-gamma form. At fixed (q, gamma) both sides are affine in pi (A is affine, the right side linear), so the endpoints pi = 0 and pi = 1/2 suffice.
- The equality rows check: the uniform entry 1/n is light for pi <= 1/2, so nF(1/n, pi) = 2(n-1)^2/n^2 = kappa pi + beta(1 - 1/n). The point mass gives F(1, pi) = kappa pi with 1 - rho = 0.

## Step 1 (b), R0

- At pi = 0 the right side is 0 and the left side is linear in gamma_j, so the optimal gamma_j is the indicator of q_j <= 1/2. Both displayed terms follow.
- The identity 2q(1-q)(c-q) = -2(q-c)^2(1-c-q) - 2c(1-c)(q-c) holds (symbolic, difference 0).
- No entry above 1/2: the sum is -2 sum (q_j-c)^2 (1-c-q_j) <= 0 because q_j <= 1/2 <= 1-c. "Lemma A" is not quoted in the brief, but this case is self-contained.
- One entry a > 1/2: the entry is unique because the entries sum to 1. The others are at most 1-a, so 1-c-q_k >= a-c > 0. Cauchy-Schwarz on sum_{k != 1}(q_k - c) = c - a gives the bound -2(a-c)^3/(n-1) + 2c(1-c)(a-c) - ((n-2)/n) a(1-a). This equals -D(a) exactly (symbolic).
- Q(1/2) = -(n-2)^3/2 and Q(1) = -n^3+7n^2-10n+4 (symbolic). Q(1) = -20 at n = 6 and decreases in n. Q is convex, so Q <= 0 on [1/2, 1], and D = (a-1)Q/(n^2(n-1)) >= 0 there.

## Step 1 (c), R-half

- A(1/2) = -(n^3-3n^2+1)/n^3, and K~ = (n+1)(n-1)^2/n^3 = (n^3-n^2-n+1)/n^3 < 1.
- **G1 (minor).** "Light because K~ < 1" also needs (1-x)(1-2x) >= 2x on [0, 7/32]. At 7/32 this reads 225/512 >= 224/512, and the left side decreases while the right side increases. So it holds, with a margin of 1/512. The text elides this step. Also c = 1/n <= 7/32 needs n >= 5.
- The factorisation psi_L = lambda(x-c) + 2(x-c)^2(x-r) is exact (symbolic). r > 1 is equivalent to n^2-2n-1 > 0, true for n >= 3. psi_L'' = 12x - 4(2c+r) <= 4c - 4r < 0 on [0, c].
- One-variable reduction: y - c = -(x-c)/(n-1), and (n-1) psi_L(y) = -lambda(x-c) + (2/(n-1))(x-c)^2(y-r) is exact (symbolic). y <= c <= 7/32 is light. psi(c) = 0, so the hypothesis is chi(x) <= (2/(n-1))(x-c)^2(r-y).
- The range [c, 7/32] is immediate because r > 1 > y.
- On [7/32, 1/2], psi is at most its maximum over gamma in R, which is valid for any x. The difference equals (1-x) L_2/(4n^3(n-1)^2(n+1)) with L_2 cubic in x (symbolic). The four Bernstein coefficients of L_2 on [7/32, 1/2], recomputed in t = n-6, are degree-6 polynomials in t with all coefficients positive. For example, the last is 2t^6+58t^5+678t^4+4048t^3+12788t^2+19532t+10206. So L_2 > 0 there for n >= 6.
- On [1/2, 1]: 1-2x <= 0, so gamma = 0 is optimal. The difference is (x-1) L_1/(n^3(n-1)^2), with L_1 matching the stated polynomial exactly. L_1(1/2) = -(n^5-8n^4+17n^3-9n^2-5n+3)/2 and L_1(1) = -n^5+8n^4-13n^3+4n^2+4n-2. At n = 6 these are -729/2 and -50, and they are negative for n >= 6 (the n = 5 value L_1(1) = 368 is consistent with the stated failure). L_1 is convex, so L_1 < 0 and the difference is >= 0.

## Left-concave reduction

- The "matching" closes with equality. Put theta_j = (c-y_j)/(c-z). Then (c-z) sum_J theta_j = kc - (k-1+(n-k)z)/(n-1), so (n-1) sum_J theta_j = n-k exactly. The coefficient of f(z) is then n-k-(n-1) sum theta_j = 0, and that of f(c) is kn - (n-1)(k - sum theta) = k + (n-k) = n. Recomputed by hand.
- z <= y_j < c holds as written: (n-1) y_j = 1 - q_j >= (n-k)z + (k-1)c >= (n-1)z.
- **G2 (minor).** The edge cases go unstated, and all are trivial. k = 0 forces the uniform row (equality). k >= 1 forces k <= n-1, so I is nonempty. z = c would force y_j in [c, c), which is empty, so z < c whenever k >= 1 and theta_j is well defined.

## Step 2

- beta is decreasing in pi, with beta(1/2) = (n-1)^2/n^2 > 0 (hand check).
- sum_i beta_i pi_i rho_i = sum_j sum_i (beta_i/pi_i) w_ij^2. The column Cauchy-Schwarz uses sum_i w_ij = pi_j, and restricting the denominator to the support only strengthens it. The reduction to sum pi beta - sum pi_j^2/T_j <= kappa(1-2s) is correct.
- **G3 (minor).** The unstated conventions all hold. Rows with pi_i = 0 have w_ij = 0 and contribute 0 to MW', to the left side and to T_j. T_j > 0 whenever pi_j > 0, since pi_j <= 1/2 < 1. w_jj = 0 is what makes T_j sum over i != j. The row of q_ij over j != i is a probability vector on n = m-1 points, and pi_i <= 1/2 follows from symmetry.

## Step 3, H_c

- The substitution is correct. b_0 c' = n kappa/(n-1), b_0 - kappa = 2(n-1)/n^3, 2 kappa - b_0 c' = 2(n+1)(n-1)(n-2)/n^3, and T_j = (B-g_j)/b_0. Dividing by b_0 gives H_c.
- Denominators are positive: 1 - c' pi_i >= (n-1)/(2n) > 0, and B - g_j > 0 because some i != j has pi_i > 0.
- Titu applies to the terms with pi_j > 0. The identity sum_j pi_j^2 (B - g_j) = sum_i pi_i phi(pi_i) is correct.
- **G4 (minor).** c'^2 s < 1 uses s <= 1/2, which is unstated and follows from s <= max_i pi_i <= 1/2. c'^2/2 < 1 is equivalent to n >= 3. Concavity in t transfers to pi because t is affine.
- The tangent step uses sum_i pi_i (pi_i - s) = 0.
- The final polynomial identity n^2 s(1-c's) - (1+(n+1)(n-2)s)(1-s) = (1-2s)((n+1)s-1) holds (hand expansion). 1/(n+1) <= s <= 1/2 closes the argument.
- Equality at the edge checks: both sides equal (n-1)/(2n).

## Assembly and consequence

- MW' in the Lean form, with gamma per ordered pair, is the left side of MW with its w^2 term moved over. MW' is therefore at least as strong as MW. The Steps compose exactly as written with n = m-1 slots per row and pi_i <= 1/2, for n >= 6 (Step 1 needs n >= 6, Step 3 needs n >= 3).
- J1 and H on the torus slice for m >= 7 additionally rest on batch 3 (J1 <= J1*b) and on L273 (3). The brief supplies neither, so this reviewer cannot check them. That part is PLAUSIBLE, conditional on those givens.

## Lean fidelity

- [MWPrime.lean](/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d3790d3b-3383-4c5d-9548-46ea15965c86/scratchpad/lean/MWPrime.lean) compiles with `lake env lean`, with four `sorry` warnings and no errors.
- **row_chord**: the gamma form of (R), with n >= 6, p in [0, 1/2] and q on Fin n. It is equivalent to the max form and has the same quantifiers.
- **left_concave**: faithful, with n >= 2 so that n-1 is nonzero.
- **Hc**: faithful, with n >= 3, p on Fin (n+1), p <= 1/2 and sum 1. The x/0 = 0 convention cannot bite, since B - g_j > 0.
- **MWprime**: faithful to MW' with gamma per ordered pair, with m = n+1 >= 7. The rows with pi_i = 0 read 0/0 = 0 and contribute 0, which matches. Every hypothesis the proof uses is present or derivable: pi_i <= 1/2 follows from hsym and hdiag.
- No declaration is weaker than its claim, stronger than it, or vacuous. The hypotheses are satisfiable, for example by the uniform w.

## Screen (refutation only)

- MW' at the optimal gamma, 2 x 10^4 random sparse symmetric w at m = 7 and 8: maximum of LHS - RHS was 0.0. No violation was found. This is a screen and is not evidence for the claim.
