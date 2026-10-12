# REVIEW r1613: L127's cross-factor spectrum as a theorem and cross_kappa

Log: [agent_logs/r1613.log](../agent_logs/r1613.log)

Scope: [L127Spec.lean](../lean/HamiltonsCubic/Results/L127Spec.lean) at commit efcbd77c, cross_kappa in [L127Cross.lean](../lean/HamiltonsCubic/Results/L127Cross.lean) at commit 7077dc79, and the L127 row of [lean/INDEX.md](../lean/INDEX.md), against [findings/second-order.md](../findings/second-order.md) Lemma L127's table, cross-factor row. Analysis only: the build and the axiom audit were run, nothing else.

**cross_spectrum is correct and proves the spectral inclusion {0, θ/2} on the Ricci cut of the cross pair span. The row states the owed multiplicities, but its PROVED sentence still carries the multiplicity reading, and the θ/2 eigenvector is cited through a lemma never instantiated at the sphere product.**

| claim | declaration | verdict |
|---|---|---|
| C1 | pair_eval, the coefficient read-off | CONFIRMED |
| C2 | cross_filter_in, cross_filter_out, and card(T ∖ {j}) = p − 1 as a real | CONFIRMED |
| C3 | cross_spectrum, every eigenvalue is 0 or t(n − 1)/2 | CONFIRMED |
| C4 | cross_kappa, α + t = t(n − 1)/(p − 1), β + t = t(n − 1)/(q − 1) | CONFIRMED |
| C5 | t(n − 1) = θ at unit norm is justified in the layer | CONFIRMED (not cited) |
| C6 | L127 row wording | CONFIRMED WITH GAPS |
| C7 | build and axioms | CONFIRMED |
| C8 | downstream and style | CONFIRMED WITH GAPS |

Summary: the mathematics is right and kernel-checked on the standard three. The gaps are wording and citation, with one owed item (existence of the θ/2 eigenvector at the sphere product as a declaration) missing from the row's owed list.

## 1. pair_eval and the filters (C1, C2)

- pair_eval: at X = φ_jq, each term d_i rk2(φ_ji, φ_ki)(φ_jq) = d_i(⟨φ_ji, φ_jq⟩ φ_ki + ⟨φ_ki, φ_jq⟩ φ_ji). For i, q ∉ {j, k} the second pairing vanishes (k ≠ j and k ≠ q) and the first is δ_iq. So the sum is d_q φ_kq. Checked by hand, and the Lean proof does exactly this split.
- cross_filter_in: {i : i ≠ j, i ≠ k} ∩ T = T ∖ {j}, since k ∉ T. cross_filter_out: ∩ Tᶜ = Tᶜ ∖ {k}, since j ∈ T. Both are correct.
- cardT: card(T.erase j) = p − 1 by card_erase_of_mem, and the cast Nat.cast_sub needs 1 ≤ p, which omega discharges from 2 ≤ p. The real equality (p : ℝ) − 1 is therefore sound. cardO likewise with q.

## 2. cross_spectrum by hand (C3)

- crossPair gives M ∘ Σ c_i f_i = Σ_q κ_q f_q with κ_q = A_T C_T on T ∖ {j} and A_O C_O on Tᶜ ∖ {k}, where A_T = ½(α + t), α = t q/(p − 1), and symmetrically A_O.
- Evaluating the eigen-equation at X = φ_jq with pair_eval on both sides gives κ_q φ_kq = λ c_q φ_kq, and the (q, k) entry reads off κ_q = λ c_q (phi_entry'). This is the coefficientwise equation.
- Summing over T ∖ {j}, which has p − 1 terms: A_T C_T (p − 1) = λ C_T. By cross_kappa, A_T (p − 1) = ½ t(n − 1). So λ C_T = (θ/2) C_T with θ = t(n − 1), and likewise λ C_O = (θ/2) C_O.
- If λ ≠ θ/2 then C_T = C_O = 0, every κ_q vanishes, and λ c_q = 0 at a q with c_q ≠ 0 forces λ = 0. The case split in the proof is exactly this.
- The hypothesis hne asks for a nonzero coefficient vector. By pair_eval the coefficients are read off the operator, so this is equivalent to a nonzero vector of the span. The Ricci cut Σ c_i = 0 is the record's 1^⊥ ([r1608](REVIEW_r1608.md) checked Ric(Σ c_i f_i) = Σ c_i).
- Screen at n = 4 (p = q = 2): the cut is one-dimensional, c = (a, −a), C_T = a ≠ 0, so λ = θ/2, which matches {½ simple, 0^0}.

So cross_spectrum establishes the inclusion spec ⊆ {0, θ/2} of M ∘ on the Ricci cut. It says nothing on existence or multiplicity, and the file and row say so.

## 3. cross_kappa and θ (C4, C5)

- α + t = t q/(p − 1) + t = t(q + p − 1)/(p − 1) = t(n − 1)/(p − 1) with n = p + q = card T + card Tᶜ. The Lean statement uses T.card + Tᶜ.card − 1 literally, so n is never a separate symbol that could drift. field_simp then ring, with p − 1, q − 1 ≠ 0 closes it. Correct.
- t(n − 1) = θ at unit norm: [L126DF.lean:132](../lean/HamiltonsCubic/Results/L126DF.lean#L132) sphere_isCritical gives IsCritical (diagOp (t • sphereWeight S)) (t(n − 1)), and [L74Statement.lean:395](../lean/HamiltonsCubic/Results/L74Statement.lean#L395) theta_of_critical_unit gives theta R = th at a unit-norm critical point, through P = ⟨R, Q(R)⟩ (Pcubic_eq_inner_Qop) and theta_of_unit. So the identification is a composition of two declarations on the layer. Neither L127Spec nor cross_kappa's docstring cites theta_of_critical_unit (gap 3).

## 4. The L127 row (C6)

- "The cross-factor row's operator identity is PROVED" is accurate for crossPair and cross_kappa.
- The same sentence continues "so the block carries θ/2 once (the orbit) and 0 on the n − 4 zero-sum-per-factor vectors, the record's {½ simple, 0^{n−4}} in L_e units". That is the multiplicity reading, which the row later lists as owed. Read in sequence the PROVED sentence claims it (gap 1).
- "And the cross-factor spectrum is a theorem" in bold overstates: the theorem is the inclusion in {0, θ/2}. The owed list then repairs it, but the bold head should say inclusion.
- "with the orbit direction the θ/2 eigenvector (orbit_eigen)": [L122Orbit.lean:63](../lean/HamiltonsCubic/Results/L122Orbit.lean#L63) orbit_eigen is stated at a general diagonally critical w. No declaration instantiates it at t • sphereWeight T (via sphere_diagCrit), shows the orbit tangent nonzero there (its coefficients w_ji − w_ki take the values α − γ and γ − β on the two factors), or places it on the Ricci cut. So existence of the θ/2 eigenvalue in this block is a composition left in prose, and it is missing from the owed list, which names only the kernel and the L_e division (gap 2).

## 5. Build and axioms (C7)

- lake build HamiltonsCubic.Results.L127Spec HamiltonsCubic.Results.L127Cross: completed successfully (8798 jobs), only the unusedDecidableInType linter note.
- axiom_audit.py --only L127Spec.lean: 5/5 clean on propext, Classical.choice, Quot.sound. --only L127Cross.lean: 5/5 clean.

## 6. Downstream and style (C8)

- [findings/INDEX-results.md](../findings/INDEX-results.md) row 127 says "Lean: partial", consistent with the row. [findings/second-order.md](../findings/second-order.md) carries no Lean text for L127. Nothing stale there.
- [L127Cross.lean:103-106](../lean/HamiltonsCubic/Results/L127Cross.lean#L103) crossPair's docstring still ends "so the block's spectrum there is {θ/2 simple, 0}" as a statement, while the file header now calls the spectral reading prose (gap 4).
- No em dashes in either commit's added lines, no backticks inside link text in the new row text, and the row is one line. The semicolon in the row's owed list separates list items that carry commas, which is the permitted use.

## Gaps

1. [lean/INDEX.md:495](../lean/INDEX.md#L495): the PROVED sentence carries the multiplicity reading ("θ/2 once ... 0 on the n − 4 ...") that the owed list defers, and the bold "the cross-factor spectrum is a theorem" should read as the inclusion in {0, θ/2}.
2. [lean/INDEX.md:495](../lean/INDEX.md#L495) and [L127Spec.lean:15-16](../lean/HamiltonsCubic/Results/L127Spec.lean#L15): the θ/2 eigenvector is cited as orbit_eigen, which is never instantiated at the sphere product nor shown nonzero and on the Ricci cut there. The owed list should add existence of θ/2 in the block.
3. [L127Cross.lean](../lean/HamiltonsCubic/Results/L127Cross.lean) cross_kappa's docstring and [L127Spec.lean:15](../lean/HamiltonsCubic/Results/L127Spec.lean#L15): "θ at unit norm" rests on theta_of_critical_unit ([L74Statement.lean:395](../lean/HamiltonsCubic/Results/L74Statement.lean#L395)), which is uncited.
4. [L127Cross.lean:103-106](../lean/HamiltonsCubic/Results/L127Cross.lean#L103): crossPair's docstring asserts the spectrum {θ/2 simple, 0} that the header calls prose.

## Verdict

**CONFIRMED WITH GAPS.** cross_spectrum and cross_kappa are correct, kernel-checked on the standard three, and give the record's cross-factor row up to existence, multiplicities and the L_e division. The gaps are wording and citation.
