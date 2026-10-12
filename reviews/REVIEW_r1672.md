# REVIEW r1672: MW' for m >= 7 (J1 working note, batch 11)

Cold adversarial Gate 2 review. Log: [agent_logs/r1672.log](../agent_logs/r1672.log). Brief: frozen batch 11 of [2026-09-27-I117-J1.md](2026-09-27-I117-J1.md). Analysis only. The sympy identities below are exact symbolic checks. The random screens are refutation screens and carry no weight as evidence.

**Verdict: CONFIRMED.** Every link from Step 1 to MW' follows from the stated hypotheses. There are three expository gaps and one sentence that rests on a result outside the brief. None of them changes a conclusion.

| step | verdict |
|---|---|
| 1(a) reduction to pi = 0, 1/2 | CONFIRMED |
| 1(b) R0 | CONFIRMED (one step left implicit, G1) |
| 1(c) R-half | CONFIRMED (attribution caveat, G2) |
| 2 column Cauchy-Schwarz | CONFIRMED |
| 3 H_c | CONFIRMED ("exactly" in the equality remark is unproved, G3) |
| assembly, MW' for m >= 7 | CONFIRMED. The J1 consequence is CONFIRMED given the batch 3/7/9 premises. The "H at every torus-invariant point" sentence is PLAUSIBLE: it rests on L273 (3), which is outside the brief (G4) |
| Lean fidelity | CONFIRMED: all four statements are faithful and none is vacuous. The file compiles with 4 `sorry` warnings only |

## Step 1(a)

- Write the maximum in F with gamma explicit and use sum q = 1 to turn kappa pi into kappa pi sum q_j and beta(1 - rho) into beta sum q_j(1 - q_j). Then (R) minus its right side is sum q_j(1-q_j)[1 + gamma_j(1-2q_j) - beta - kappa pi] - kappa pi sum gamma_j^2 q_j^2.
- The bracket constant 1 - beta - kappa pi equals -(n-2)/n + kappa pi/(n-1), which is A(pi) exactly (sympy: A(1/2) matches the stated -(n^3-3n^2+1)/n^3).
- At fixed (q, gamma) both sides are affine in pi. The max form is "for all gamma", so the reduction to the two endpoints is valid.
- beta is correct. The uniform entry has unconstrained optimum (n-1)(n-2)/(2n kappa pi) >= 1 at pi <= 1/2 (144/70 at n = 6), so gamma = 1 and nF(1/n) = 2(n-1)^2/n^2. F(1, pi) = kappa pi. Both equalities hold.

## Step 1(b), R0

- The optimal gamma is right: the gamma coefficient is q(1-q)(1-2q), and at pi = 0 there is no quadratic penalty. The per-entry forms 2q(1-q)(c-q) and -(n-2)/n q(1-q) are right.
- The identity 2q(1-q)(c-q) = -2(q-c)^2(1-c-q) - 2c(1-c)(q-c) checks (sympy residual 0).
- With no entry above 1/2, every 1-c-q_j > 0 and the linear part sums to 0.
- At most one entry exceeds 1/2, since the entries sum to 1.
- **G1 (gap in the text, the conclusion stands).** The bound -D(a) needs one more step than "Lemma A's Cauchy-Schwarz". The weights must be bounded below first: 1-c-q_k >= a-c > 0 from q_k <= 1-a. Only then does Cauchy-Schwarz on sum_{k != 1}(q_k - c) = c - a apply over the n-1 entries. I checked that -(n-2)/n a(1-a) + 2c(1-c)(a-c) - 2(a-c)^3/(n-1) equals -D(a) exactly (sympy residual 0). So D is the stated function, provided the weight step is the one intended. The note should state that step.
- The quadratic factor Q is convex. Q(1/2) = -(n-2)^3/2 and Q(1) = -n^3+7n^2-10n+4. In t = n-6, -Q(1) = t^3+11t^2+34t+20 > 0. With a-1 <= 0 this gives D >= 0 on [1/2, 1].

## Step 1(c), R-half

- **Light entries.** At x = 7/32, (1-x)(1-2x) = 450/1024 >= 448/1024 = 2x. The left side decreases and the right side increases in x, and K~ = (n+1)(n-1)^2/n^3 < 1. So x <= 7/32 is light for every n. Since c <= 1/6 < 7/32, psi = psi_L on [0, c].
- **The cubic.** psi_L = lambda(x-c) + 2(x-c)^2(x-r) checks (sympy residual 0). r > 1 is equivalent to n^2-2n-1 > 0. psi_L'' = 12x-8c-4r <= 4c-4r < 0 on [0, c].
- **Left-concave reduction: the proof as written is correct.**
  - A nonempty J forces a nonempty I, since not all entries can exceed 1/n.
  - It also forces z < c: z = c would give y_j >= c, contradicting y_j < c. So theta_j = (c-y_j)/(c-z) lies in (0, 1].
  - y_j >= 0 because q_j <= 1.
  - The two linear constraints give (n-1) sum theta_j = n-k exactly. I verified this: (n-1)Theta(z-c) = (n-k)(z-c).
  - Summing the hypothesis and the concavity bounds over J therefore leaves [(n-1)Theta - (n-k)](f(c)-f(z)) = 0, and Jensen on I closes it.
- **G2 (attribution only).** Cirtoaje's LCF theorem, as I recall it, places the n-1 equal variables on the non-convex side. Here they sit on the concave side, so the "(This is Cirtoaje's left-concave-function theorem)" remark may be misattributed. I have not verified this against the source. The self-contained proof carries the step either way.
- **One-variable reduction.** y - c = -(x-c)/(n-1), and y <= c <= 7/32 is light. The stated (n-1)psi(y) and chi-condition follow.
- **The three ranges:**
  - [c, 7/32]: chi <= 0 <= 2/(n-1)(x-c)^2(r-y), since r > 1 >= y.
  - [7/32, 1/2]: the bound by the unconstrained maximum (gamma over all of R) is valid. The difference is (1-x)L_2/(4n^3(n-1)^2(n+1)) with L_2 = 4n^6x^3 - 8n^6x^2 + 9n^6x - n^6 - 28n^5x - 8n^4x^2 + 16n^4x + 12n^4 - 8n^3x^2 + 52n^3x - 8n^3 - 24n^2 - 8n^2x - 8nx + 4x + 4 (sympy). I recomputed its degree-3 Bernstein coefficients on [7/32, 1/2] in t = n-6. All four are polynomials in t with strictly positive coefficients (constant terms 5143/8192, 613/512, 13/8, 2). Screen: L_2 goes negative at n = 5 (min about -156), consistent with R-half failing there.
  - [1/2, 1]: gamma = 0 is optimal, and the difference is (x-1)L_1/(n^3(n-1)^2) with the stated L_1 (sympy residual 0). The endpoint values are as stated. In t, -2L_1(1/2) = t^5+22t^4+185t^3+729t^2+1291t+729 and -L_1(1) = t^5+22t^4+181t^3+662t^2+920t+50, both > 0. L_1 is convex, so L_1 < 0 on the range.
- Screen (refutation only): (R) itself, 10^5 random (q, pi) at n = 6 and 7. Maximum excess about 1e-16.

## Step 2

- beta is decreasing in pi, and beta(1/2) = (n-1)^2/n^2 > 0.
- Rows with pi_i = 0 have w_ij = 0 for all j. They contribute nothing on either side and enter T_j with weight 0.
- The column sums sum_i w_ij = pi_j follow from symmetry.
- Cauchy-Schwarz per column is valid with positive weights beta_i/pi_i over the rows with pi_i > 0.
- Applying (R) row by row needs n = m-1 off-diagonal slots, n >= 6 (m >= 7) and pi_i <= 1/2. The last follows from pi_i = sum_{j != i} w_ji <= sum_{j != i} pi_j = 1 - pi_i.
- The resulting reduction to sum pi_i beta_i - sum pi_j^2/T_j <= kappa(1-2s) is correct.

## Step 3, H_c

- The two constants b_0 - kappa = 2(n-1)/n^3 and 2kappa - b_0c' = 2(n+1)(n-1)(n-2)/n^3 check by hand. Dividing by b_0 = 2(n-1)/n gives H_c exactly.
- Every 1 - c'pi_i >= 1 - (n+1)/(2n) > 0.
- For Titu, B - g_j = sum_{i != j} g_i is positive whenever pi_j > 0: otherwise pi_j = 1 > 1/2. Terms with pi_j = 0 drop out.
- The rewrite as sum_i pi_i phi(pi_i) is correct, and so is the form of phi in t.
- s <= max pi <= 1/2 gives c'^2 s <= (n+1)^2/(2n^2) < 1 for n >= 3. Then (c'^2 s - 1)/t is concave for t > 0, and phi is concave on [0, 1/2].
- The tangent at pi = s, with s in [0, 1/2], gives sum pi_i phi(pi_i) <= phi(s).
- The final polynomial identity checks: n^2 s(1-c's) - (1+(n+1)(n-2)s)(1-s) = (n+3)s - 1 - 2(n+1)s^2 = (1-2s)((n+1)s-1). The bound s >= 1/(n+1) is Cauchy-Schwarz over m = n+1 vertices.
- **G3 (side remark).** "Equality holds exactly at the uniform point and at the edge": the argument shows equality AT those points. "Exactly" would need the equality cases of Titu and of the tangent step, which are not argued. The remark carries no weight in the proof.
- Screen (refutation only): H_c on random pi at n = 3, 6, 9. No violation, maximum -4e-5.

## Assembly

- Steps 1 to 3 give MW' for m >= 7 exactly as written. MW' implies MW, since the MW' left side is the maximum over unrestricted gamma.
- J1 <= J1*b <= PI + MW is taken from the premises, so J1 on the torus slice for m >= 7 follows given those premises.
- **G4.** "By L273 (3), H at every torus-invariant point for m >= 7" rests on L273, which the brief neither quotes nor lists as a given. I have not audited that sentence, so it is PLAUSIBLE.
- Screen (refutation only): MW' with the gamma maximum on 2x10^4 random symmetric w at m = 7 and 9. Maximum -0.048, with no violation.

## Lean fidelity

The file is [MWPrime.lean](/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d3790d3b-3383-4c5d-9548-46ea15965c86/scratchpad/lean/MWPrime.lean). `lake env lean` from lean/ reports only the 4 `sorry` warnings.

- **`row_chord`:** faithful. The summand equals q(1-q) + kappa p q^2 + gamma q(1-q)(1-2q) - kappa p gamma^2 q^2. Since F takes its maximum entry by entry, the explicit-gamma form for all gamma in [0,1]^n is equivalent to the max form. The hypotheses are n >= 6, p in [0, 1/2] and q a probability vector on Fin n.
- **`left_concave`:** faithful. It is stated for n >= 2, which is true by the proof above. It is more general than the use at n >= 6 but no stronger than what is proved.
- **`Hc`:** faithful. It covers n >= 3 and a probability vector on n+1 points with p_i <= 1/2. The Lean convention x/0 = 0 never triggers, because B - g_j > 0 whenever p_j > 0.
- **`MWprime`:** faithful and non-vacuous. The hypotheses are w symmetric, non-negative and zero-diagonal on Fin (n+1), total 1, n >= 6. Gamma is explicit per ordered pair. The term w(1-q)(1+gamma(1-2q)) + kappa w^2(1-gamma^2) equals pi_i times the per-entry F-form, because kappa pi_i^2 q^2 = kappa w^2. Rows with pi_i = 0 give 0 under x/0 = 0. The statement omits pi_i <= 1/2 because it follows from the hypotheses, which is correct.
- One proof obligation, not a fidelity defect: `MWprime` indexes row i over Fin (n+1) with a zero diagonal entry, while `row_chord` takes Fin n. The proof must drop the diagonal, which is harmless because F(0, pi) = 0.
