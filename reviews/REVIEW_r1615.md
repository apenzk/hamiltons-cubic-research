# REVIEW r1615: L127's second within-factor family, the bounds against ½, and the occurrence of the within-factor top

Log: [agent_logs/r1615.log](../agent_logs/r1615.log)

Scope: sphereWeight_compl, within_spectrum_out and within_bounds in [L127Within.lean](../lean/HamiltonsCubic/Results/L127Within.lean) at commit 9b7d2bf7, withinPair and within_top_exists in the same file at commit 13dae7a0, and the L127 row of [lean/INDEX.md](../lean/INDEX.md), against [findings/second-order.md](../findings/second-order.md) Lemma L127's table, within-factor row. Analysis only: the build and the axiom audit were run, and every identity below was checked by hand.

**All five declarations are correct and close r1614's two gaps. within_top_exists proves the eigen-equation for the stated vector but not that the vector is a nonzero operator, so "the top occurs" is one pair_eval short of what it says, and the second family's "< ½" is an instantiation left untyped.**

| claim | declaration | verdict |
|---|---|---|
| C1 | sphereWeight_compl, sphereWeight Tᶜ = sphereWeight T | CONFIRMED |
| C2 | within_spectrum_out, the C(q, 2) family with values 0, ½(β + t)(q − 2), −½(2t + α + β) | CONFIRMED |
| C3 | within_bounds, first-family top < t(n − 1)/2 and third value < 0 at t > 0, p, q ≥ 2 | CONFIRMED |
| C4 | the second family's top < ½ in L_e units | GAP (not a declaration, one instantiation away) |
| C5 | withinPair, M ∘ Σ c_i f_i = Σ_q κ_q f_q on the Ricci cut | CONFIRMED |
| C6 | within_top_exists, Ricci cut and eigen-equation at ½(α + t)(p − 2) | CONFIRMED |
| C7 | within_top_exists as "the top occurs" (nonzero eigenvector) | GAP (nonzeroness unstated) |
| C8 | the L127 row's owed list (multiplicities, L_e division, D_n row, agreement) | CONFIRMED |
| C9 | build and axioms | CONFIRMED |
| C10 | downstream and style | CONFIRMED |

Summary: the mathematics is right and kernel-checked on the standard three. The gaps are one missing conjunct (v ≠ 0) that the sibling cross_orbit_exists already carries, and the second family's bound left as an unstated instantiation.

## 1. sphereWeight_compl and the exchange of factors (C1, C2)

[Families.lean:308-312](../lean/HamiltonsCubic/Base/Families.lean#L308) defines sphereWeight S a b as 0 on the diagonal, |Sᶜ|/(|S| − 1) with both in S, −1 across, and |S|/(|Sᶜ| − 1) with both out. At S = Tᶜ: both in Tᶜ gives |T|/(|Tᶜ| − 1), the original out-out value; both out of Tᶜ (so in T) gives |Tᶜ|/(|T| − 1), the original in-in value; across is −1 either way. So the identity is true of the definition, and the Lean proof (L127Within.lean:195-201) is the four-case split.

within_spectrum_out (L127Within.lean:204-215) applies within_spectrum at Tᶜ, rewriting the operator by sphereWeight_compl and simplifying Tᶜᶜ = T. The needed hypothesis 2 ≤ |Tᶜ| is supplied. With p = |T|, q = |Tᶜ|, α = tq/(p − 1), β = tp/(q − 1), the returned values are 0, ½(β + t)(q − 2) and −½(2t + β + α). Since β + t = t(n − 1)/(q − 1) (cross_kappa's second conjunct), the middle value is t(n − 1)(q − 2)/(2(q − 1)), the record's (q − 2)/(2(q − 1)) at θ = t(n − 1). The third value is the first family's, with α and β in exchanged order.

## 2. within_bounds (C3, C4)

Top: ½(α + t)(p − 2) = t(n − 1)(p − 2)/(2(p − 1)) by cross_kappa, and this is below t(n − 1)/2 iff (p − 2)/(p − 1) < 1, true at p ≥ 2 with t(n − 1) > 0. Dividing by θ = t(n − 1) gives (p − 2)/(2(p − 1)) < ½, the table's clause in the right units. Third value: α, β > 0 at t > 0 and p, q ≥ 2, so −½(2t + α + β) < 0. The Lean proof (L127Within.lean:220-240) follows exactly this, with nlinarith on hfrac and hn. By hand, ½(2t + α + β)/(t(n − 1)) = (n − 2)/(2(p − 1)(q − 1)) = μ_{p,q}, since 2(p − 1)(q − 1) + q(q − 1) + p(p − 1) = (n − 1)(n − 2), so the header's "the third is −μθ" (L127Within.lean:18) is right, as prose.

**Gap (C4).** within_bounds bounds the first family's top only. The table says "both < ½", and the second family's top ½(β + t)(q − 2) < t(n − 1)/2 is within_bounds at Tᶜ with compl_compl and add_comm, not typed. The row (lean/INDEX.md:495) says "the top below t(n−1)/2", which a reader takes for the row's clause as printed, both families. A two-line corollary or the word "first-family" in the row closes it.

## 3. withinPair and within_top_exists by hand (C5, C6, C7)

withinPair (L127Within.lean:245-266) assembles pair_invariant with within_coeff_in and within_coeff_out (both confirmed in r1614) into the full expansion Σ_q κ_q f_q. Correct.

The vector: c_i = q on T ∖ {j, k} (p − 2 indices, within_filter_in), c_i = −(p − 2) on Tᶜ (q indices, filtB). C_T = (p − 2)q, C_{Tᶜ} = −q(p − 2), so Σ c_i = 0: on the Ricci cut.

- At an index in T ∖ {j, k}: κ = ½(α + t) C_T = ½(α + t)(p − 2) · q = λ c_i with λ = ½(α + t)(p − 2).
- At an index in Tᶜ: κ = ½((−2t − α − β)(−(p − 2)) + (t + β)(−q(p − 2))) = −½(p − 2)(−2t − α − β + (t + β)q). The identity needed is −2t − α − β + (t + β)q = (α + t)(p − 2). Since (t + β)(q − 1) = t(p + q − 1), the left side is t(n − 1) − t − α = t(p + q − 2) − tq/(p − 1) = t[(p + q − 2)(p − 1) − q]/(p − 1) = t(p − 2)(p + q − 1)/(p − 1), and the right side is t(n − 1)(p − 2)/(p − 1) by cross_kappa. Equal, so κ = λ · (−(p − 2)) = λ c_i.

The Lean proof matches, the second case by field_simp and ring with p − 1, q − 1 ≠ 0. The spectrum's multiplicity count {λ_p, (−μ)^{q−1}, 0^{p−3}} (second-order.md:1734) is also consistent with the coefficient equations: the three eigenvector types have dimensions 1, q − 1 and p − 3, summing to n − 3.

**Gap (C7).** within_top_exists (L127Within.lean:270-277) concludes Σ c_i = 0 and the eigen-equation, but the eigen-equation is also satisfied by the zero operator, so it alone does not show the top is an eigenvalue. The vector is nonzero: at p ≥ 3 the coefficients are q ≥ 2 on the nonempty T ∖ {j, k} and −(p − 2) ≠ 0 on Tᶜ, and pair_eval at φ_jq for any q ∈ Tᶜ reads c_q φ_kq ≠ 0. But this is neither stated nor proved. The sibling cross_orbit_exists ([L127Spec.lean:135](../lean/HamiltonsCubic/Results/L127Spec.lean#L135)) carries an explicit ∃ X, IsSkew X ∧ ... ≠ 0 conjunct for the same purpose, so the omission is inconsistent with the file's own precedent, and the docstring title "THE WITHIN-FACTOR TOP OCCURS" and the row's "carrying the top" (lean/INDEX.md:495) assert the occurrence. Repair: add the nonzero conjunct via pair_eval and phi_entry'.

Minor: the docstring at L127Within.lean:268 writes "coefficient q = |Tᶜ|" while q is also the proof's index variable. Noted, not a gap.

## 4. The row's honesty (C8)

The L127 row lists as owed the multiplicities as declarations in both pair rows, the division by θ into L_e units, the D_n row (L27's summands) and the agreement of the two decompositions. That is complete for the within-factor row apart from C4 and C7. The p = 2 caveat is carried ("0 at p = 2"), and within_top_exists is restricted to p ≥ 3, which matches the record's defect note (second-order.md:1731).

## 5. Build and axioms (C9)

`cd lean && ~/.elan/bin/lake build HamiltonsCubic.Results.L127Within`: build completed successfully (8799 jobs), linter notes only. `python3 scripts/misc/axiom_audit.py --only L127Within.lean`: 10/10 clean, the standard three (propext, Classical.choice, Quot.sound). No sorry and no native_decide in the file.

## 6. Downstream and style (C10)

sphereWeight_compl and within_spectrum_out are used nowhere else, so there is nothing downstream to break. findings/INDEX-results.md's L127 row points to lean/INDEX.md for coverage and is not stale. second-order.md's table is unchanged and consistent with the declarations. No em dashes in the file or the row, no backticks inside link text, the row is one line, and its semicolons separate list items that carry commas.

## Verdict

**CONFIRMED WITH GAPS.** Gaps: (1) within_top_exists states no nonzeroness of the eigenvector, which the occurrence claim needs and cross_orbit_exists carries; (2) the second family's "< ½" is not a declaration though the row's wording covers it.
