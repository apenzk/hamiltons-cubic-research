# REVIEW r1616: L127's cross-factor eigenspaces, and r1615's two repairs

Log: [agent_logs/r1616.log](../agent_logs/r1616.log)

Scope: cross_kernel_iff and cross_top_iff in [L127Mult.lean](../lean/HamiltonsCubic/Results/L127Mult.lean) at commit c1801c89, within_top_ne_zero and within_bounds_out in [L127Within.lean](../lean/HamiltonsCubic/Results/L127Within.lean) at commit 43099561, and the L127 row of [lean/INDEX.md](../lean/INDEX.md), against [findings/second-order.md](../findings/second-order.md) Lemma L127's table (cross-factor row and within-factor row). Analysis only: the build and the axiom audit were run, and every identity below was checked by hand.

**All four declarations are correct and kernel-checked on the standard three. Together with crossPair they give the cross-factor row's "exactly {½ simple, 0^{n−4}}" up to a dimension count the row discloses as prose. The second within-factor family's top is bounded but its occurrence at q ≥ 3 is neither typed nor named as owed, and the new module docstring carries one semicolon splice.**

| claim | declaration | verdict |
|---|---|---|
| C1 | cross_kernel_iff, on the Ricci cut M ∘ Σ c_i f_i = 0 iff C_T = 0 | CONFIRMED |
| C2 | the kernel is the zero-sum-per-factor vectors, dimension n − 4 | CONFIRMED (dimension is prose, disclosed) |
| C3 | cross_top_iff, eigen-equation at t(n − 1)/2 iff c constant on each factor | CONFIRMED |
| C4 | C1 with C3 give {θ/2 simple, 0^{n−4}} on the n − 3 dimensional Ricci cut | CONFIRMED up to the disclosed count |
| C5 | within_top_ne_zero, the within-factor top's vector is nonzero at p ≥ 3 | CONFIRMED (closes r1615 gap 1) |
| C6 | within_bounds_out, ½(β + t)(q − 2) < t(n − 1)/2 | CONFIRMED (closes r1615 gap 2) |
| C7 | the second family's top occurs at q ≥ 3 | GAP (untyped, not listed as owed) |
| C8 | build and axiom audit | CONFIRMED (2/2 and 12/12 on propext, Classical.choice, Quot.sound) |
| C9 | downstream text | CONFIRMED (nothing stale) |
| C10 | style | GAP (one semicolon splice, [L127Mult.lean:9](../lean/HamiltonsCubic/Results/L127Mult.lean#L9)) |

Summary: the cross-factor eigenspaces are characterised correctly in both directions, r1615's two gaps are closed, and what remains is an unnamed owed item (the second family's occurrence) and one style defect.

## 1. cross_kernel_iff by hand (C1, C2)

crossPair ([L127Cross.lean:108](../lean/HamiltonsCubic/Results/L127Cross.lean#L108)) gives M ∘ Σ c_i f_i = Σ_q κ_q f_q with κ_q = ½(α + t) C_T for q ∈ T and ½(β + t) C_{Tᶜ} for q ∉ T, where α = tq/(p − 1), β = tp/(q − 1), on the Ricci cut C_T + C_{Tᶜ} = 0.

- **Forward.** The proof picks a second index q ∈ T, q ≠ j, which exists at p ≥ 2 and lies in s because k ∉ T. Evaluating at φ_jq with pair_eval gives κ_q φ_kq = 0, and the (q, k) entry reads κ_q = 0. Since α + t > 0 at t > 0 (α > 0 from q ≥ 1 and p − 1 > 0), C_T = 0. The hypothesis t > 0 is needed: at t = 0 the operator vanishes and every vector is in the kernel. The second index of T is the natural choice at p ≥ 2 (at p = 1 one could read the second factor instead, which is outside the lemma's setting).
- **Converse.** C_T = 0 and the Ricci cut give C_{Tᶜ} = 0 through sum_split_T, so every κ_q vanishes. Correct.
- **The kernel.** The characterised set is {c on s : Σ_{s∩T} c = 0 and Σ_{s∖T} c = 0}, with s ∩ T = T ∖ {j} (p − 1 indices) and s ∖ T = Tᶜ ∖ {k} (q − 1 indices), so its dimension is (p − 2) + (q − 2) = n − 4. The translation from coefficient vectors to operators uses the injectivity of c ↦ Σ c_i f_i, which pair_eval supplies (the value at φ_jq is c_q φ_kq). Both the count and the injectivity are prose. The module header says "The dimension count itself is prose", and the L127 row lists "the dimension counts as declarations" as owed, so this is disclosed.

## 2. cross_top_iff by hand (C3, C4)

cross_kappa gives α + t = t(n − 1)/(p − 1) and β + t = t(n − 1)/(q − 1). At q ∈ T: κ_q = ½ · t(n − 1)/(p − 1) · C_T = (t(n − 1)/2) · C_T/(p − 1), and off T symmetrically with q − 1. This is the proof's `coef` identity, and it checks.

- **Forward.** Evaluation at φ_jq on both sides (pair_eval twice, the right side after pulling the scalar inside) gives κ_q = (t(n − 1)/2) c_q. Cancelling t(n − 1)/2 ≠ 0 (t > 0, n − 1 ≥ 3) gives c_q = C_T/(p − 1) in T and C_{Tᶜ}/(q − 1) off T.
- **Converse.** Substituting h into the coefficient identity closes termwise. Correct.
- **One line.** The condition says c is a constant a on T ∖ {j} and b on Tᶜ ∖ {k}, and the Ricci cut forces (p − 1)a + (q − 1)b = 0, a single line spanned by (q − 1, −(p − 1)). The orbit tangent of cross_orbit_exists (γ − α on the first part, β − γ on the second) is factor-constant, so it spans this line. That identification is prose in the docstring and true.
- **Exactly the table's spectrum.** The Ricci cut of the pair span has dimension (n − 2) − 1 = n − 3 = (n − 4) + 1. Since the kernel and the θ/2-line are complementary in it, and cross_spectrum ([L127Spec.lean](../lean/HamiltonsCubic/Results/L127Spec.lean)) excludes other eigenvalues, the spectrum is {θ/2 simple, 0^{n−4}}, which is {½ simple, 0^{n−4}} after the division by θ that the row lists as owed. Modulo the disclosed count, the cross-factor row is carried.

## 3. r1615's repairs (C5, C6)

- **within_top_ne_zero** ([L127Within.lean:313](../lean/HamiltonsCubic/Results/L127Within.lean#L313)). The vector is exactly within_top_exists's c (|Tᶜ| on T, −(p − 2) off T). At φ_jq with q ∈ Tᶜ (which exists at |Tᶜ| ≥ 2, and q ∈ s since j, k ∈ T), pair_eval gives −(p − 2) φ_kq, whose (q, k) entry is −(p − 2) ≠ 0 at p ≥ 3. Correct, and it closes r1615 gap 1.
- **within_bounds_out** ([L127Within.lean:331](../lean/HamiltonsCubic/Results/L127Within.lean#L331)). within_bounds at Tᶜ, after compl_compl, reads ½(t·p/(q − 1) + t)(q − 2) < t(q + p − 1)/2, which linarith reorders to the stated form. The left side is ½(β + t)(q − 2), the second family's top from within_spectrum_out. Correct, and it closes r1615 gap 2.

## 4. What the row owes (C7)

The L127 row ([lean/INDEX.md:495](../lean/INDEX.md#L495)) lists as owed the dimension counts, the within-factor eigenspaces, the division by θ, the D_n row and the agreement of the two decompositions. That list is honest for the cross-factor row.

**Gap (C7).** For the within-factor row the table's "top" for the second family, (q − 2)/(2(q − 1)), is a top only if it occurs at q ≥ 3. within_top_exists and within_top_ne_zero cover the j, k ∈ T family only. The second family's occurrence is within_top_exists at Tᶜ with sphereWeight_compl, one instantiation away, exactly as within_bounds_out was. The row now says the second family's top is "below t(n−1)/2 too" and says nothing about its occurrence, and "the within-factor eigenspaces" in the owed list is the multiplicity question, not this one. Either type within_top_exists_out (and its nonzeroness) or name the second family's occurrence in the owed list.

## 5. Build and axioms (C8)

`lake build HamiltonsCubic.Results.L127Mult HamiltonsCubic.Results.L127Within` completed successfully (8800 jobs). The axiom audit returned 2/2 for L127Mult.lean and 12/12 for L127Within.lean, resting on propext, Classical.choice and Quot.sound alone. No sorry, no native_decide.

## 6. Downstream (C9)

- findings/second-order.md's L127 section names no Lean file, and its table is unchanged and consistent with the declarations.
- findings/INDEX-results.md's L127 row carries the Gate 2 history and does not describe Lean coverage, so nothing is stale.
- STATUS.md and plan-lean.md moved from 864 to 865 files, matching the new module, and lean/HamiltonsCubic.lean imports it.
- The L127 row names cross_kernel_iff and cross_top_iff with the right content and marks the dimension as parenthetical.

## 7. Style (C10)

- No em dashes in either Lean file or in the L127 row. No backticks inside link text in the row.
- **Gap.** [L127Mult.lean:9](../lean/HamiltonsCubic/Results/L127Mult.lean#L9): "gives the inclusion and the occurrence; this file characterises the two eigenspaces" splices two clauses. A colon or a full stop fixes it.
- The row's semicolons separate list items that already carry commas, which is the permitted use.

## Verdict

**CONFIRMED WITH GAPS.** Gaps: (1) the second within-factor family's top occurrence at q ≥ 3 is neither typed nor named as owed in the L127 row ([lean/INDEX.md:495](../lean/INDEX.md#L495)); (2) a semicolon clause splice in the module docstring ([L127Mult.lean:9](../lean/HamiltonsCubic/Results/L127Mult.lean#L9)).
