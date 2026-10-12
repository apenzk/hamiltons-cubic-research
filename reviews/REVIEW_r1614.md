# REVIEW r1614: L127's within-factor row and the occurrence of θ/2 in the cross block

Log: [agent_logs/r1614.log](../agent_logs/r1614.log)

Scope: [L127Within.lean](../lean/HamiltonsCubic/Results/L127Within.lean) at commit ef2b34a6, cross_orbit_exists in [L127Spec.lean](../lean/HamiltonsCubic/Results/L127Spec.lean) and the docstring fixes in [L127Cross.lean](../lean/HamiltonsCubic/Results/L127Cross.lean) at commit 6a89e3e1, and the L127 row of [lean/INDEX.md](../lean/INDEX.md), against [findings/second-order.md](../findings/second-order.md) Lemma L127's table, within-factor row. Analysis only: the build and the axiom audit were run, nothing else.

**within_spectrum is correct and proves the inclusion of every Ricci-cut eigenvalue in {0, ½(α + t)(p − 2), −½(2t + α + β)} for the first family (j, k ∈ T). The second family (j, k ∉ T) is formalised nowhere and named nowhere as owed, the "both < ½" clause and the negativity of the third value are asserted in prose as if proved, and cross_orbit_exists is correct.**

| claim | declaration | verdict |
|---|---|---|
| C1 | within_coeff_in, ½(α + t) C_T at q ∈ T | CONFIRMED |
| C2 | within_coeff_out, ½((−2t − α − β) c_q + (t + β) C_{Tᶜ}) at q ∉ T | CONFIRMED |
| C3 | pair_coeff, the coefficient read off at φ_jq | CONFIRMED |
| C4 | within_spectrum and card((T ∖ {j}) ∖ {k}) = p − 2 | CONFIRMED |
| C5 | the middle value is the record's top (p − 2)/(2(p − 1)) in L_e units | CONFIRMED (prose, honestly labelled) |
| C6 | the second family, C(q, 2) blocks with j, k ∉ T | GAP (silently omitted) |
| C7 | "both < ½" and the third value negative | GAP (prose asserted as proved) |
| C8 | cross_orbit_exists | CONFIRMED |
| C9 | build and axioms | CONFIRMED |
| C10 | downstream and style | CONFIRMED |

Summary: the mathematics is right and kernel-checked on the standard three. The gaps are coverage and wording: one of the row's two families, and two inequalities the row and header state beside the proved equalities.

## 1. The coefficients by hand (C1, C2, C3)

Notation as in the file: p = |T|, q = |Tᶜ|, n = p + q, M = diagOp(w), w = t · sphereWeight T, so w is α = tq/(p − 1) inside T, β = tp/(q − 1) inside Tᶜ, −t across, 0 on the diagonal. The coefficient at q from pair_invariant is ½(w_jq + w_kq − w_jk) c_q + ½ Σ_{i∈s} c_i w_iq, with s = {i : i ≠ j, i ≠ k} and Σ_s c_i = C_T + C_{Tᶜ} = 0.

- q ∈ T (j, k ∈ T): w_jq = w_kq = w_jk = α, so the first term is ½α c_q. The T part of the sum is ½α(C_T − c_q) since w_qq = 0, and the Tᶜ part is −½t C_{Tᶜ} = ½t C_T. Total ½(α + t) C_T. Matches within_coeff_in (L127Within.lean:29-57), whose proof splits the sum by sum_split_T and removes the i = q term with an ite exactly this way.
- q ∉ T: w_jq = w_kq = −t, w_jk = α, so the first term is ½(−2t − α) c_q. The T part is −½t C_T = ½t C_{Tᶜ}, the Tᶜ part ½β(C_{Tᶜ} − c_q). Total ½((−2t − α − β) c_q + (t + β) C_{Tᶜ}). Matches within_coeff_out (L127Within.lean:61-89).
- pair_coeff (L127Within.lean:92-114) evaluates pair_invariant at φ_jq, using pairSum_restrict and pair_eval for the Σ_q' part and a Kronecker read-off for the diagonal part. It holds for any symmetric hollow w, as stated.

## 2. within_spectrum by hand (C4, C5)

- key: pairing heig at X = φ_jq and reading the (q, k) entry gives λ c_q = coefficient_q for every q ∈ s. Sound, since phi_entry' needs only k ≠ q.
- cardA: s ∩ T = (T.erase j).erase k by within_filter_in (a direct ext), so its card is p − 2, and the two Nat.cast_sub side conditions follow from j, k ∈ T with 2 ≤ p. Correct.
- Summing λ c_q = top · C_T over s ∩ T gives λ C_T = top · C_T · (p − 2), so either λ = top(p − 2) or C_T = 0. In the second case C_{Tᶜ} = 0 too, and a q with c_q ≠ 0 gives λ = 0 (q ∈ T) or λ = ½(−2t − α − β) (q ∉ T). The case analysis is complete.
- With α + t = t(n − 1)/(p − 1) (cross_kappa), top(p − 2) = t(n − 1)(p − 2)/(2(p − 1)), which divided by θ = t(n − 1) is the record's (p − 2)/(2(p − 1)), and is 0 at p = 2. Checked.
- A consistency check the file could state: 2 + q/(p − 1) + p/(q − 1) = (n − 1)(n − 2)/((p − 1)(q − 1)), so the third value divided by θ is −(n − 2)/(2(p − 1)(q − 1)) = −μ_{p,q}, the value second-order.md's box gives for the whole within-factor spectrum {λ_p, (−μ)^{q−1}, 0^{p−3}}. The inclusion agrees with the record's full within-factor spectrum.
- Honesty: the header (L127Within.lean:15-18) says "The occurrence of each value and the division by θ are prose", and the row's Owed list names the multiplicities, the occurrence of the within-factor top and the division by θ. That is honest for what the file covers.

## 3. The second family (C6)

The table's row is "C(p,2) and C(q,2), **two families**", and the header quotes it in full (L127Within.lean:8-10). Every theorem in the file takes j, k ∈ T. The second family follows by applying within_spectrum at Tᶜ, but that yields a statement about diagOp(t · sphereWeight Tᶜ), and the layer has no lemma sphereWeight Tᶜ = sphereWeight T (grep for sphereWeight_compl and for sphereWeight Tᶜ finds nothing). The identity is true by definition (Families.lean:308): inside Tᶜ, sphereWeight Tᶜ is |Tᶜᶜ|/(|Tᶜ| − 1) = p/(q − 1), inside T it is |Tᶜ|/(|Tᶜᶜ| − 1) = q/(p − 1), across −1, so a short ext with compl_compl closes it. Neither the header nor the lean/INDEX.md L127 row's Owed list (lean/INDEX.md:495) mentions the second family, so the row reads as covering the within-factor row while covering half of it.

## 4. The two inequalities (C7)

- "both < ½" is in the table and in the header's quotation. It is a one-line fact ((p − 2)/(2(p − 1)) < ½ iff p − 2 < p − 1), but no declaration states it and neither the header nor the Owed list says it is prose.
- The lean/INDEX.md L127 row says within_spectrum gives "−½(2t+α+β)<0", and the theorem's docstring (L127Within.lean:124-126) says "the other is negative". within_spectrum states only lam = ½(−2t − α − β) (L127Within.lean:135). Negativity needs 0 < t and p, q ≥ 2 and is not a declaration. True, and prose.
- Neither affects the mathematics. Both are statements the row presents beside proved equalities without the prose label the file uses for occurrence and division.

## 5. cross_orbit_exists (C8)

- The eigen-equation is orbit_eigen at sphere_diagCrit, whose multiplier t(p + q − 1) halves to the stated t(n − 1)/2. The rw closes the goal, so the shapes agree.
- Nonzero: orbit_in_pairBlock writes T_jk = Σ_i (w_ji − w_ki) f_i, and pair_eval at φ_jq, q ∈ T ∖ {j}, gives (w_jq − w_kq) φ_kq = (α + t) φ_kq. With t > 0 and p, q ≥ 2, α > 0, so the coefficient is positive and T_jk(φ_jq) ≠ 0. The (q, k) entry read-off and the final linarith do exactly this. Correct.
- The theorem places T_jk in the pair span only inside its proof, and its Ricci-cut membership (Σ_i (w_ji − w_ki) = 0 at Ricci-flat rows) is unstated. This does not affect the claim that θ/2 is an eigenvalue of M ∘ on a nonzero operator. Noted, not a gap.
- The L127Cross.lean docstring changes (crossPair points to cross_spectrum and cross_orbit_exists, cross_kappa cites theta_of_critical_unit) are accurate.

## 6. Build and axioms (C9)

- `lake build HamiltonsCubic.Results.L127Within HamiltonsCubic.Results.L127Spec`: build completed successfully, no warnings in either file.
- axiom_audit.py --only L127Within.lean: 5/5 clean, standard three. --only L127Spec.lean: 6/6 clean, standard three.

## 7. Downstream and style (C10)

- findings/second-order.md and findings/INDEX-results.md carry no text the two commits make stale. The within-factor box in second-order.md (the full spectrum {λ_p, (−μ)^{q−1}, 0^{p−3}}) agrees with the inclusion, as §2 shows.
- No em dashes in the three Lean files or the L127 row. The row's one semicolon clause splice ("without the reason; the reason is ...") predates both commits. Its other semicolon separates list items that carry commas, which is permitted. No backticks inside link text in the changed prose.

## Verdict

**CONFIRMED WITH GAPS.** The proved content is correct. Gaps: (1) the second within-factor family is neither formalised nor listed as owed, and the missing piece is a one-line sphereWeight Tᶜ = sphereWeight T; (2) "both < ½" and the negativity of the third value are asserted beside the theorems without a prose label or an Owed entry.
