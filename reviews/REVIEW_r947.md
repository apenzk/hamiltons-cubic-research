# Gate 2 review r947, Lemma L225 (the per-block cubic)

Brief: [BRIEF_L225.md](BRIEF_L225.md). Claim: [findings/second-order.md](../findings/second-order.md) lines 933-951. Log: [agent_logs/review-r947.log](../agent_logs/review-r947.log).

| Item | Topic | Verdict | Reason |
|---|---|---|---|
| 1 | Step 1, entry bound | CONFIRMED | Cauchy-Schwarz over the other k-1 entries gives k lambda_i^2 <= k-1 at every k. k >= 2 enters only to make c > 0, and sqrt((k-1)/k) = (k-1)/c holds for k >= 2. |
| 2 | Step 2, tangent cubic | CONFIRMED | (x-a)(x+b)^2 = x^3+(2b-a)x^2+(b^2-2ab)x-ab^2 is right. k a b^2 = k(k-1)/c^3 = 1/c = b, so the sum reads Sigma lambda^3 + b - a <= 0 and the constant is a-b = (k-2)/c. |
| 3 | Step 3, equality | CONFIRMED | Each term is nonpositive, so a zero sum forces each factor to vanish. m(k-1) = k-m gives mk = k, so m = 1. The converse power sums are right. |
| 4 | Step 4, matrix statement | PLAUSIBLE | The body is right, including M^0 = 0 through the factor abs(M^0). The heading drops M^0 = 0, which is an equality case at every k, and "one positive eigenvalue and one of multiplicity k-1" needs the simple eigenvalue to be the positive one. tr(M^0)^3 also parses as (tr M^0)^3 = 0. See the corrections below. |
| 5 | The k=3 identity | CONFIRMED | Both power sums, the identity (kernel-checked by ring), the factor 2 against the discriminant and 1-54e_3^2 = 2(1/2-27e_3^2) all hold. The identity is the square of the two-sided bound, and its zero set includes the negative spectrum (-2,1,1)/sqrt6 (screen). |
| 6 | Attribution | PLAUSIBLE | Case-Tyrrell prove the squared, two-sided form, (tr A^3)^2 <= (n-2)^2/(n(n-1)) abs(A)^6 (p. 1, Prop 2.2, n >= 3), with equality at an eigenspace of dimension >= n-1 of either sign. The one-sided equality case with a positive simple eigenvalue, and k = 2, are one-line refinements that the block presents as theirs. The tangent cubic is a different route from the lambda-method, and L178 step 5 is correctly identified. The bound is also older: it is the classical sample-skewness bound abs(g_1) <= (n-2)/sqrt(n-1) (Wilkins 1944, Kirby 1974), with g_1 = sqrt(k) Sigma lambda^3. |
| 7 | Lean against the block | CONFIRMED | The build succeeds, and all six declarations depend only on propext, Classical.choice and Quot.sound. c is pinned by 0 < c and c^2 = k(k-1), and the k = 2 example shows the hypotheses can be met. three_by_three types the polynomial only, so the power-sum substitution stays in prose. |
| 8 | Gate 1 and What it gives | PLAUSIBLE | (a)-(c) are true. The first clause of (d) is true. Its gloss that the vanishing of the 2x2 traceless cubic is "behind L224" has no support in L224, whose step 3 kills odd terms by the swap parity and the character epsilon_j epsilon_k. "Rigid" is empty at k = 2, where every point attains equality. The closing paragraph matches plan.md and routes.md. |
| 9 | Counterexample hunt | CONFIRMED | None exists, because steps 1-3 are a complete proof. A screen on constructed vectors at k = 2..7 stayed below the bound and hit it at the equality vector. The screen is not evidence. |

## Proposed corrections

1. **Heading (item 4).** Replace "with equality exactly at one positive eigenvalue and one of multiplicity $k-1$" by "with equality exactly at $M^0=0$ and at a simple positive eigenvalue with a negative eigenvalue of multiplicity $k-1$".
2. **Notation (item 4).** In the heading, the statement and step 4, write $\mathop{\mathrm{tr}}\big((M^0)^3\big)$ for $\mathop{\mathrm{tr}}(M^0)^3$. As printed, the latter reads as $(\mathop{\mathrm{tr}}M^0)^3=0$.
3. **Attribution (item 6).** Replace "the norm form of their Proposition 2.2" by "the one-sided norm form of their Proposition 2.2, which they state squared, $(\mathop{\mathrm{tr}}\mathring A^3)^2\le\frac{(n-2)^2}{n(n-1)}\lvert\mathring A\rvert^6$ at $n\ge3$, with equality at an eigenspace of dimension at least $n-1$ of either sign. The sign of the equality case and $k=2$ are read off here". Also add: "The vector form is the classical bound on sample skewness, $\lvert g_1\rvert\le\frac{n-2}{\sqrt{n-1}}$ (Wilkins 1944, Kirby 1974, surveyed in Cox, Stata Journal 10(3), 2010), since $g_1=\sqrt k\sum\lambda_i^3$ on the unit trace-free sphere."
4. **Gate 1 (d) (item 8).** Replace "which agrees with the vanishing of the traceless cubic on $2\times2$ blocks behind L224" by "consistent with L224's step 3, where every term of $P$ cubic in the swap-odd and $V_{jk}$ parts vanishes by parity".
5. **What it gives (item 8).** Replace "A sharp, rigid bound" by "A sharp bound, rigid at $k\ge3$".
6. **Kernel-check scope (item 7, minor).** Replace "Kernel-checked in" by "The vector statement is kernel-checked in". The block's own Lean paragraph already says the spectral step stays in prose.
7. **The k=3 identity (item 5, minor).** After "which is the bound squared", add "in its two-sided form $\lvert\sum\lambda^3\rvert\le\frac1{\sqrt6}$, whose zero set includes the negative spectrum $(-2,1,1)/\sqrt6$".

## Screens

Screens only, never evidence: random unit trace-free vectors at k = 2..7, the equality vector's three power sums, and the k = 3 identity at one rational point. The Lean module builds, and `#print axioms` on each of the six declarations returns propext, Classical.choice and Quot.sound.
