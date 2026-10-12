# r1105: I73(c) section 7, the gap-weighted pair sum and its spectral corollary

Log: [agent_logs/r1105-I73c-sec7.log](../agent_logs/r1105-I73c-sec7.log). One of two Gate 2 reviewers of section 7 of [2026-09-23-I73c-summed-pairs.md](2026-09-23-I73c-summed-pairs.md) at 2854e98c, read with `git show`. Sections 1 to 6, L104 rows (A) and (B), and L125 are givens. Every computation below is a screen of seconds on objects constructed for it, run from scratch scripts importing the repository's own structure constants, sharp, circ and Weyl projector, and from [lib325.py](../scripts/reviewers/r325/lib325.py) for catalogue points.

**Verdict: the identity and the corollary are correct, and the Gram elimination is right with its coefficient counted once. One reach sentence is refuted: catalogued critical points do NOT all sit at tr W^3/theta at most 0.43. CP^3 sits at 0.5167 against the bound 0.6, and the maximal torus at n = 6 and n = 8 sits exactly ON the bound. The rest are gaps of writing: a skipped step in the M12 coefficient, a factor 2 between the ordered sum and the L235 combination, Cauchy-Schwarz constraints called quadratic that are affine, a stale screen docstring, and a Lean lemma that is a ring tautology.**

| # | claim | verdict |
|---|---|---|
| 1 | the G12 coefficients -c pq, +c p^2 and their cancellation | CONFIRMED, with a skipped step (F1) and unstated sign bookkeeping (F2) |
| 2 | the gap-weighted identity | CONFIRMED. The ordered sum is twice the L235 combination (F3). Row B needs no criticality, and the screen's docstring says the opposite (F4). Weight-zero pairs are harmless, and a basis-free trace form settles it (F5) |
| 3 | the corollary (n-1) tr W^3 <= (n-3) theta and its equivalent form | CONFIRMED |
| 4 | the reach claims and the record search | REFUTED in one sentence: "every catalogued critical point sits far inside it, at tr W^3/theta <= 0.43" is false (F6). n = 5 empty and n = 6, 7, 8 non-empty CONFIRMED. No prior statement found in the record (F7) |
| 5 | the Fourier-Motzkin paragraph | CONFIRMED, with one correction: the Cauchy-Schwarz constraints are affine in G12, not quadratic (F8) |
| 6 | the Lean statements | PLAUSIBLE: three statements are the note's arithmetic, and gram_free is a ring identity in free variables that says nothing about G12 (F9) |

## Claim 1, the Gram elimination

- **Null direction.** Solving section 3's rows gives G23 = (p g - eps2 s2)/q, G13 = (-eps1 s1 - p g)/(p+q), G11 = (s1 eps3 - q g)/(p+q), G22 = (s2 eps3 - (p+q) g)/q with g = G12. The g-coefficients are -z_a z_b/(q(p+q)) with z = (eps2-eps3, eps3-eps1, eps1-eps2), and at (1,2) this is +1. Confirmed by hand and by the script.
- **Derivative.** d|Ric e^2|^2/dg = -(sum_a eps_a^2 z_a)^2/(q(p+q)), and sum_a eps_a^2 z_a is minus the Vandermonde, -pq(p+q). So the derivative is -p^2 q(p+q). Confirmed.
- **N_ab.** The G_ab coefficient of -1/2 N_ab is -1/2(1/6 - 1/(n-2)) = -c. On both weight vectors sum w_ab z_a z_b = 0 (p(-q)(p+q) + (p+q)(pq) = 0, and (p+q)pq + q(p+q)(-p) = 0), so N contributes nothing. Confirmed.
- **M12, counted once.** In F(e;P_a,P_b) the M12 coefficient is [L_a]_1[L_b]_2 + [L_a]_2[L_b]_1 (the M12 and M21 terms), which is -l_a l_b(2 sigma - eps_a - eps_b) with sigma = eps1+eps2+eps3. On a weight vector with sum w l_a l_b = 0 the sigma part drops and what remains is sum w l_a l_b(eps_a+eps_b), the note's expression, counted once. It evaluates to 1/(p(p+q)) and -1/(q(p+q)). The |Ric e^2|^2 coefficient inside Phi/(8(n-2)) + 3/8 Omega is 1/(2(n-2)) - 1/12 = -c, so in S it is +c, and the G12 coefficients are c/(p(p+q)) times -p^2 q(p+q) = -c pq and -c/(q(p+q)) times the same = +c p^2. p times the first plus q times the second is zero. Confirmed.
- **The script doubles.** [screen_I73c_gram_elim.py](../scripts/misc/screen_I73c_gram_elim.py) symmetrises over (a,b),(b,a) and then adds C(1,2)+C(2,1), so it prints 2/(p(p+q)) and G12 coefficients -pq(n-8)/(6(n-2)), that is 2c. Its docstring says so, and zeros and ratios are unaffected. The note's c is the correct one.
- **F1 (skipped step).** The note writes the weighted M12 coefficient as sum w l_a l_b(eps_a+eps_b) without saying this holds only on weights that already kill M22. Repair: "the M12 coefficient of F(e;P_a,P_b) is -l_a l_b(2 sigma - eps_a - eps_b), and on weights with sum w l_a l_b = 0 this sums to sum w l_a l_b(eps_a+eps_b)".
- **F2 (sign bookkeeping).** "Combine to 1/(2(n-2)) - 1/12" is the coefficient inside the subtracted corrections, and it enters S with the opposite sign. The final coefficients are right, and one clause saying where the sign flips would let a reader check them.

## Claim 2, the identity

- **Each piece, re-derived by hand.** With ordered sums, sum w = 2N E2 and sum_{alpha,beta} f(eps_alpha)h(eps_beta) tr(Psi_alpha^2 Psi_beta^2) = <Ric f(e), Ric h(e)>, so sum w g = 2(n-1) tr Ric(e^2) - 0 = 4(n-1)E2. sum w sum_gamma T = 4(n-2)E2 - 2 m110 = 4(n-1)E2 by row B. Then sum w|h|^2 = 2(n-1)E2, sum w ||N4||^2 = (2N - 4(n-1))E2/6, and sum w ||X||^2 = (n-1)E2[(n+2)/3 - 2/(n-2)] = (n-1)(n^2-10)E2/(3(n-2)). The unprojected piece: sum (x-y)^2(x+y) over ordered pairs is 2N E3, giving N/2 E3, and the T part is -1/4(2 m201 - 2 m111) with m201 = -2E3 by row B, giving +E2. Phi: 2 M02 - 2 M11 = 24E3 - 2(12E3 - 4E2) = 8E2. Omega: 2(n-4)(n-5)/9 E3 - 2(12E3 - 4E2)/9 = 2/9[(n-1)(n-8)E3 + 4E2]. The E3 coefficient is N/2 - (n-1)(n-8)/12 = (n-1)(n+4)/6, and the E2 coefficient is (-n^3+n^2+14n-24)/(6(n-2)) = -(n+4)(n-3)/6. All confirmed.
- **The facts used.** Screened at three random non-critical unit Weyl tensors at each of n = 5, 6, 7 (criticality residual 0.43 to 0.75): row A to 4e-14, row B to 4e-15, and m111/(2<W,W^#>) = 1.000000. <e,e^#> = E2 - E3 is P(W) = theta read at e = W/theta and uses only theta != 0.
- **Row B needs no criticality.** It is Boehm-Wilking's W#I = -W, as [bounds.md](../findings/bounds.md) already records (the "(B) is a Weyl identity" passages). The identity therefore holds at every unit W with theta != 0, and the hypothesis P(W) > 0 is harmless but not needed.
- **Direct screen reproduced.** [screen_I73c_gapweighted.py](../scripts/misc/screen_I73c_gapweighted.py) prints residuals at most 6.2e-15 at the six critical objects and 5.7e-14 at the random non-critical control, as the note says.
- **F3 (factor 2).** The note says p times the first L235 inequality plus q times the second "is" sum_{alpha,beta}(eps_alpha-eps_beta)^2 s_{alpha beta} over ordered eigenpairs. It is half of it: p^2 S12 + (p+q)^2 S13 + q^2 S23 counts each unordered class pair once, and the ordered sum counts it twice. The pieces are computed on ordered sums (sum w = 2N E2), so the Proposition is right as stated, and only the sentence joining it to L235 is off by 2. The inequality direction is unaffected.
- **F4 (stale docstring).** The screen's docstring says the identity "needs criticality (rows B, C), so a random Weyl tensor is the control that must FAIL". Row C is not used, row B needs no criticality, and the script's own output shows the control passing. The note reads the output correctly. The docstring should be corrected to say that the control checks the identity off the critical set.
- **F5 (weight-zero pairs, and a basis-free form).** The per-pair formulas of section 2 are used only where the weight is nonzero, i.e. at eps_alpha != eps_beta, which are orthonormal pairs with alpha != beta. Diagonal and same-eigenspace pairs carry weight 0 in both the direct sum and the closed-form sums, so including them is harmless. Summed over a degenerate eigenspace, s is quadratic in psi_alpha tensor psi_alpha and so depends only on the eigenprojections. More cleanly, with D = ad_e^2 on Sym^2(Lambda^2), Y -> e^2Y + Ye^2 - 2eYe, which has eigenvalue (eps_alpha-eps_beta)^2 on psi_alpha (.) psi_beta, **the ordered gap-weighted sum is tr over W_n of (pi D pi)(L_e - 1/2)**. Screened at a random W at n = 6: -26245.454079838 both ways, pi D pi positive semidefinite, and |pi D pi W| = 5e-13. This form mentions no basis.

## Claim 3, the corollary

- L125 gives <Y,L_eY> <= 1/2||Y||^2 + 1/2<W,Y>^2 for every Y in W_n. At X = pi(psi_alpha (.) psi_beta), <W,X> = <W,Y0> = <psi_alpha, W psi_beta> = 0 for every alpha != beta, whatever the eigenvalues. So s_{alpha beta} <= 0 at every such pair, and X != 0 is not needed (X = 0 gives s = 0). Nonnegative weights and (n+4)/6 > 0 give (n-1)E3 <= (n-3)E2, and multiplying by theta^3 > 0 gives (n-1) tr W^3 <= (n-3) theta.
- **Equivalent form.** theta = tr W^3 + <W,W^#> turns it into 2 tr W^3 <= (n-3)<W,W^#>. Confirmed.
- In the trace form of F5 the corollary is L24 traced against the positive semidefinite operator pi D pi, which annihilates W. That is a one-line proof of the same statement.

## Claim 4, the reach

- **n = 5 is empty.** <W,W^#>/tr W^3 = 2.000000 at three random W in W_5, matching the record's statement that the cubic invariant is unique at n <= 5. The corollary then reads tr W^3 >= 0, that is theta >= 0, automatic at a maximiser. Confirmed.
- **n = 6, 7, 8 are not empty.** Confirmed. The quoted 1.05, 2.20, 2.32 are sample maxima, not suprema: 300 random unit W at n = 6 reach 108, since P can be arbitrarily small and positive while tr W^3 is not. The sentence should say "reach at least".
- **F6 (REFUTED): "Every catalogued critical point sits far inside it, at tr W^3/theta <= 0.43".** The note's screen covers six objects. Screened here (criticality residual at most 2e-15 each):

| point | n | theta | tr W^3/theta | bound (n-3)/(n-1) |
|---|---|---|---|---|
| CP^3 | 6 | 1.054093 | 0.5167 | 0.6000 |
| CP^4 | 8 | 0.986013 | 0.5810 | 0.7143 |
| S^2 x S^5 | 7 | 0.979796 | 0.5167 | 0.6667 |
| S^2 x S^6 | 8 | 0.986013 | 0.5810 | 0.7143 |
| ad su(3) | 8 | 0.836660 | 0.2143 | 0.7143 |
| maximal torus | 6 | 0.645497 | 0.6000 | 0.6000 |
| maximal torus | 8 | 0.540062 | 0.7143 | 0.7143 |

  CP^3 and CP^4 are catalogued ([INDEX-values.md](../findings/INDEX-values.md), the 1.054093 and 0.986013 rows), and CP^3 shares theta_0(6) with S^3 x S^3. **The maximal torus is a critical point on which the inequality holds with EQUALITY at n = 6 and n = 8**, so the gap-weighted sum vanishes there. This does not contradict the corollary: the torus is not a maximiser. It does show that the bound is attained on the critical set. Correction: "Every critical point screened satisfies it. The catalogued symmetric points sit at tr W^3/theta up to 0.58 (CP^4, S^2 x S^6 at n = 8), and the maximal torus attains equality at n = 6, 8."
- **F7 (record search).** I searched [findings/](../findings/) for (n-3)/(n-1), (n-3)theta, (n-3)<W,W^#>, bounds of tr W^3 by theta or P, and the Fox trace-identity section of [second-order.md](../findings/second-order.md). I found no prior statement of this inequality or an equivalent. The nearest relatives are Fox's tr L_x = 0 and tr(L_xL_y) = kappa<x,y>, which are equalities at every W and carry no second-order content, and the g_k = sum (lambda_a-lambda_b)^2 T_{k a b} moments of [bounds.md](../findings/bounds.md), which weight T and not the Hessian. The corollary is implied by L24/L125 alone, through the trace of F5. That is what the note derives, and I found no other recorded result that implies it.

## Claim 5, Fourier-Motzkin

- With c > 0 (n > 8), the first inequality reads A1 - c pq g <= 0, a lower bound on g, and the second reads A2 + c p^2 g <= 0, an upper bound. Eliminating g against the interval [L, U] gives: the pair itself, which is p A1 + q A2 <= 0, the gap-weighted condition; the first at g = U; the second at g = L; and L <= U. That is four conditions, with the orientation stated, reversed for n < 8. At n = 8 both are g-free and there is nothing to eliminate. Confirmed.
- The listed linear ends reproduce from the solved Gram: G23 >= 0 gives g >= eps2 s2/p, G13 >= 0 gives g <= -eps1 s1/p, G11 >= 4m1^2/n gives g <= (s1 eps3 - 4(p+q)m1^2/n)/q, and G22 >= 4m2^2/n gives g <= (s2 eps3 - 4q m2^2/n)/(p+q). Confirmed.
- **F8 (correction).** "The Cauchy-Schwarz constraints adding quadratic ones" is wrong in kind. G moves along the rank-one direction -zz^T, so G_aa G_bb - G_ab^2 has t^2 coefficient z_a^2 z_b^2 - (z_a z_b)^2 = 0, and by the matrix determinant lemma every principal minor of G is affine in G12. So the whole feasible set of G12 is an interval with linear ends. Each "endpoint inequality" is then a finite conjunction, one inequality per candidate end, and each is linear in tau.

## Claim 6, Lean

- gap_norm_sum is the note's summed norm, with N = n(n-1)/2 written out. gap_sum_collapse is the note's final display term by term, and its first term (N/2)E3 + E2 matches. spectral_corollary is the arithmetic from the sum being <= 0 at E2 = theta^-2 and E3 = t theta^-3 to (n-1)t <= (n-3)theta, under n > -4 and theta > 0. It does not type L125 or the link to maximisers, and the header says so.
- **F9.** gram_free is p(-(c p q)) + q(c p^2) = 0 for free reals c, p, q, which is ring arithmetic and nothing else. What carries the claim is the derivation of the two coefficients (the null direction, the derivative, the M12 coefficient on each weight vector), and none of that is typed. Its docstring "The Gram parameter cancels" should say "the two stated coefficients cancel at weights p, q".
- The header's "not typed" reason says the layer defines neither Phi, Omega nor the projection onto the Weyl module. That is accurate for the full projection. The layer now has its Ricci half ([WeylRicciRemoval.lean](../lean/HamiltonsCubic/Results/WeylRicciRemoval.lean), 5da7e093), so "the full projection" is the precise wording. The file is imported by the root module. I did not compile it, since the brief asks for statements.

## Repairs, in one list

1. Section 7, paragraph 1: state the per-pair M12 coefficient -l_a l_b(2 sigma - eps_a - eps_b) and that it reduces to sum w l_a l_b(eps_a+eps_b) on M22-free weights. Say that the corrections enter S with a minus sign (F1, F2).
2. Section 7, paragraph 2: p L235_1 + q L235_2 is half the ordered gap-weighted sum (F3).
3. Proposition: the hypothesis P(W) > 0 can be theta != 0. Optionally add the trace form tr_{W_n}(pi ad_e^2 pi (L_e - 1/2)) (F5).
4. Corollary's reach sentence: replace "every catalogued critical point ... <= 0.43" as in F6, and record the torus equality. Change "reach" to "reach at least".
5. Fourier-Motzkin paragraph: the Cauchy-Schwarz constraints are affine in G12 (F8).
6. [screen_I73c_gapweighted.py](../scripts/misc/screen_I73c_gapweighted.py) docstring: the control checks the identity off the critical set, and it passes (F4).
7. gram_free docstring (F9).
