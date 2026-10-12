# Review r1709: J1_odd for m >= 7 from L278, and the odd L273 (R48 batch 11)

Log: agent_logs/r1709.log. Brief: agent_logs/brief_r1708_r1709.md. Claim: reviews/2026-09-27-R48-torus-families.md, batch 11.

**Verdict: J1_odd is CONFIRMED from L278 and L277's lemmas. The odd L273 paragraph's conclusion follows given batch 5's F, but one of its stated sub-claims is false (the range delta >= -0.5), and the range it actually needs is far smaller, where the claim holds with a two-line argument.**

| claim | verdict | reason |
|---|---|---|
| J1_odd statement | CONFIRMED | follows from steps 1-7, each checked below; screen finds no violation and equality at the uniform point |
| step 1 embedding | CONFIRMED | U', V' symmetric, zero diagonal; exactly-one-index-(m+1) terms: 3 positions x 2 w^T P w = 6 w^T P w (the two sqrt2 factors give 2); two or three such indices always meet the zero diagonal; Q' = 0 on new edges; norm = b^2; d'_i = d_i + w_i^2, d'_{m+1} = norm(w)^2, x' = w_i^2 on new pairs |
| steps 2-3 | CONFIRMED | cocktail_rows is generic in the size; diagonal pairs contribute 0; old/new split is a partition of a != b; pointwise s sqrt(E) <= sqrt(f) sqrt(R) (E <= R from ee_le_R, E = 0 when R = 0) then Cauchy-Schwarz per group |
| step 4 | CONFIRMED | AM-GM, F, R >= 0, t > 0 |
| step 5 | CONFIRMED | hterm_ab = x(1-q)(1+gamma(1-2q))/2 exactly, so f_ij + f_ji <= 2(h_ij + h_ji) = the stated two-order sum, and F_o <= sum over ordered old pairs of x(1-q)(1+gamma(1-2q)); (U^2-V^2)^2 = x^2(1-gamma^2) = P^2 Q^2 (also at x = 0); q uses d' because pair_bound runs on U', V' |
| step 6 | CONFIRMED | x' = w_i^2, (abs U' + abs V')^2 = 2 w_i^2, R' = d'_i norm(w)^2; f' is symmetric, so F_n = 4 sum w_i^2(1-q_i0)(1-q_0i) and (t_n/2)F_n = 2 t_n sum(...); R_n/(2 t_n) = pi_0 sum pi_i / t_n. Degenerate cases (w_i = 0, norm(w) = 0) make both sides 0 under the x/0 = 0 convention |
| step 7 | CONFIRMED | total mass 1, pi_i = d'_i, pi_0 = norm(w)^2; g^2 = sum_{i<=m} pi_i^2 + sum x^2(1-gamma^2) matches L278's lambda sum_{i>=1} pi_i^2 and the (lambda - 1/(2 t_o)) term; checked numerically as an identity (screen) |
| odd L273 | PLAUSIBLE (conditional on batch 5) | Psi_kappa, the double root and positivity of c2, c3, c4 all hold symbolically for every m; the sub-claim "c2 + c3 delta + c4 delta^2 > 0 for delta >= -0.5" is FALSE for large m, but only delta >= 1 - t_u > -1/(4m) is needed, where it holds |
| Lean statement | CONFIRMED | m = n + 1, n >= 6; IsPairWeights = symmetric, zero diagonal; lambda = 3 sqrt2 m/(2(2m-1)), c0 = sqrt2(2m-1)(4m-1)/(8m^2); g^2 with the off-diagonal if; precedence parses as lambda * g^2 |

## Findings

1. **Odd L273, false intermediate claim (error in a sub-claim, conclusion unaffected).** With delta = t - t_u, h(t) = delta^2 (c2 + c3 delta + c4 delta^2) exactly (h is a quartic, c0 = c1 = 0 symbolically). The quadratic at delta = -0.5 is +0.023 at m = 7, +0.001 at m = 8, and **-0.10 at m = 20, -0.16 at m = 100, tending to -0.177**, so "> 0 for delta >= -0.5" fails for moderately large m. The range t >= 1 needs only delta >= 1 - t_u, and t_u - 1 <= 1/(4m) (from sqrt(1+x) <= 1 + x/2). There c2 + c3 delta + c4 delta^2 >= c2 - c3/(4m) = c2 - kappa/m > 0, since c2 > 2 and kappa < sqrt2. Replace "-0.5" by "1 - t_u >= -1/(4m)" and this argument.
2. **Odd L273, the owed positivity is dischargeable in closed form (gap closed).** Symbolically: c2 = 3 sqrt2 (2m-1)(m+1)/(2m(2m+1)), c3 = 4 kappa (the degree-7 numerator factors as (16m^4-1)(2m-1)^2(2m+1) against (16m^4-1)(4m^2-1)), c4 = lambda kappa^2 = 3 sqrt2 (2m-1)/(2(2m+1)). All positive for m >= 1, so the "for all m >= 7" item owed in the note is proved. h(t_u) = h'(t_u) = 0 and g_u^2 = (2m-1)^2/(4m^3) verified symbolically. The m = 5 numbers 2.08, 4.85, 1.74 reproduce.
3. **Odd L273, homogeneity left implicit (presentational gap).** The paragraph works "at b = 1" and concludes F <= kappa norm(X)^3. The general case needs F cubic-homogeneous in (A, U, V, w) and the b = 0 case (F = 0 there, since d, w, P, Q vanish). Both are immediate but unstated.
4. **Step 3, Lean route (note for the formaliser, the mathematics is sound).** J1.lean's `pairing` applies Cauchy-Schwarz over all pairs jointly. The pointwise bound s sqrt(E) <= sqrt(f) sqrt(R) that the split needs is a local `have` (hpt) inside `pairing`, so J1odd_holds will need that step exported as its own lemma, or a split version of `pairing` over a Finset of pairs.
5. **Step 6, convention (minor).** q_0i = w_i^2/norm(w)^2 is undefined at w = 0. Every term carries w_i^2 as a factor, so any convention works, and oddMWprime's x/0 = 0 matches. The prose should say so.
6. **L278 prose vs Lean (checked, consistent).** oddMWprime drops the common sqrt2: To = t_o/sqrt2, Tn = t_n/sqrt2, Lam = lambda/sqrt2, C0 = c0/sqrt2. Dividing the prose inequality by sqrt2 gives Lean's coefficients term for term: 1/(4 To) = (1/(2 t_o))/sqrt2, 1/(2 Tn) = (1/t_n)/sqrt2, and ((sum pi)^2 - sum pi^2) = sum_{i != j} pi_i pi_j. The J1_odd statement keeps the sqrt2 in lambda and c0, so the Lean proof must rescale by sqrt2 when it calls oddMWprime.

## Screen (a screen, evidence against refutation only)

At m = 7 and 8, with seed 1709: 3000 random sparse (U, V, w) normalised to b = 1 give max(LHS - c0) = -0.15 and -0.57. At U = V = w = 1/(m sqrt2), LHS - c0 = -4e-16 (equality). 2000 perturbations of size 1e-3 give max -8e-7. Twelve BFGS starts (maxiter 400) give max -2e-9 and -3e-9. The embedding identity holds to 1e-16. The step-7 assembled bound (L278's left side) minus c0 is <= -0.10 on the random points and is >= J1_odd's LHS on every point. Script: scratchpad r1709/screen.py and r1709/l273.py (session scratch, outside the repository).
