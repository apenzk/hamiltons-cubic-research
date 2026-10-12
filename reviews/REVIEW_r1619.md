# REVIEW r1619: L127 in L_e units, and the p ≥ 3 scoping of the within-factor counts

Log: [agent_logs/r1619.log](../agent_logs/r1619.log)

Scope: pairVec, pairVec_lin, pairVec_skew, LeLin_pairVec_iff and cross_LeLin_spectrum in [L127Le.lean](../lean/HamiltonsCubic/Results/L127Le.lean) at commit 92b9443b, within_LeLin_spectrum at commit db5223e1, the p ≥ 3 scoping in [L127WMult.lean](../lean/HamiltonsCubic/Results/L127WMult.lean) at commit 1614e92a, and the L127 row of [lean/INDEX.md](../lean/INDEX.md), against [findings/second-order.md](../findings/second-order.md) Lemma L127's table and its full within-factor spectrum {λ_p, (−μ)^{q−1}, 0^{p−3}}. Analysis only: the build and the axiom audit were run, and every identity below was checked by hand.

**All five declarations are correct and kernel-checked on the standard three. LeLin_pairVec_iff is an exact translation between L_e and the bare Fox product on the pair span, P(M) = t(n − 1) at a unit sphere product is derived from criticality and nothing else, and both divided values match the record: (p − 2)/(2(p − 1)) and −μ_{p,q}. The p ≥ 3 scoping of 1614e92a is accurate. Two gaps: L127WMult's header still calls the division by θ prose, which L127Le has now made a theorem, and the second within-factor family (j, k ∉ T, top (q − 2)/(2(q − 1))) is stated in L_M units only while the row reads as if "a within block" covered both.**

| claim | declaration | verdict |
|---|---|---|
| C1 | pairVec, pairVec_lin, pairVec_skew | CONFIRMED |
| C2 | LeLin_pairVec_iff, L_e v = λ v iff M ∘ v = (λ P(M)) v on bivectors | CONFIRMED |
| C3 | P(M) = θ = t(n − 1) at a unit sphere product | CONFIRMED |
| C4 | cross_LeLin_spectrum, eigenvalues in {0, ½} | CONFIRMED |
| C5 | within_LeLin_spectrum, eigenvalues in {0, (p − 2)/(2(p − 1)), −μ_{p,q}} for j, k ∈ T | CONFIRMED |
| C6 | LeLin is L126Kernel's L_e | CONFIRMED |
| C7 | "nonzero Ricci-cut vector" encoding | CONFIRMED |
| C8 | 1614e92a's p ≥ 3 scoping | CONFIRMED |
| C9 | L127WMult header "the division by θ are prose" | GAP (stale after L127Le) |
| C10 | the L127 row's L_e-units claim and owed list | CONFIRMED WITH GAPS (second family in L_e units untyped and unlisted) |
| C11 | build and axiom audit | CONFIRMED (5/5 and 3/3 on propext, Classical.choice, Quot.sound) |
| C12 | downstream text | CONFIRMED (nothing stale outside C9) |
| C13 | style | CONFIRMED |

Summary: the L_e-units rows are sound and match the record's values exactly, and what remains is one stale sentence in L127WMult and the second within family's L_e form.

## 1. pairVec (C1)

pairVec j k c is Y ↦ Σ_{i ∈ s} c_i rk2(φ_ji, φ_ki) Y with s = {i : j ≠ i, k ≠ i}, the same summand cross_spectrum and within_spectrum quantify over, so the heig hypotheses of those theorems are literally foxProd M (pairVec j k c) X = μ • pairVec j k c X. Linearity is termwise from isLinOp_rk2, and skewness from rk2_skew on two skew arguments, summed. Both proofs are correct.

## 2. LeLin_pairVec_iff (C2)

LeLin a v = foxProd2 ((Pcubic2 a)⁻¹ • a) v ([L24Restrict.lean:87](../lean/HamiltonsCubic/Results/L24Restrict.lean#L87)). The proof pulls the scalar out (foxProd2_smul_left), identifies the bundled product with the bare one on bivectors (bridge_apply, [L126GenBridge.lean:49](../lean/HamiltonsCubic/Results/L126GenBridge.lean#L49)), and replaces Pcubic2 (restrict hW) by Pcubic (diagOp w) (Pcubic2_restrict). So (L_e v)(X) = P(M)⁻¹ (M ∘ v)(X) for every skew X, and the equivalence L_e v = λ v ⟺ M ∘ v = λ P(M) v on skew X follows by multiplying through by P(M) ≠ 0 in one direction and by field_simp in the other. The quantifier "every bivector" is exactly what a CurvOp2 equality means, since CurvOp2 acts on skewSub. Correct.

## 3. P(M) = t(n − 1) (C3)

sphere_isCritical gives IsCritical (diagOp (t • sphereWeight T)) (t(p + q − 1)), theta_of_critical_unit gives θ(M) = t(n − 1) at normSq M = 1 from P = ⟨M, Q(M)⟩, and theta_of_unit gives θ = P at unit norm. The composite hPθ is P(M) = t(n − 1). Nonvanishing uses t > 0 and p + q − 1 ≥ 3. Correct, and no appeal to the Nienhaus value is made.

## 4. The divided values (C4, C5), by hand

With α = tq/(p − 1), β = tp/(q − 1) (sphereWeight's in-block entries times t) and θ = t(n − 1):

* cross: θ/2 ÷ θ = ½.
* within top: ½(α + t)(p − 2) = ½ t (q + p − 1)/(p − 1) · (p − 2) = t(n − 1)(p − 2)/(2(p − 1)), and ÷ θ gives (p − 2)/(2(p − 1)).
* within negative: 2 + q/(p − 1) + p/(q − 1) has numerator 2(p − 1)(q − 1) + q(q − 1) + p(p − 1) = (p + q)² − 3(p + q) + 2 = (n − 1)(n − 2) over (p − 1)(q − 1), so −½(2t + α + β) = −t(n − 1)(n − 2)/(2(p − 1)(q − 1)), and ÷ θ gives −(n − 2)/(2(p − 1)(q − 1)) = −μ_{p,q}.

The Lean statements carry exactly these three right-hand sides, and each proof is mul_right_cancel₀ against θ after the tactics field_simp and ring. Both theorems are inclusions (every eigenvalue lies in the set), which is what their docstrings and the row claim. Occurrence in L_e units is not claimed, and it is immediate from LeLin_pairVec_iff with within_top_exists and cross_orbit_exists. At p = 2 the within top evaluates to 0, which coincides with the kernel value, so the inclusion stays true there and the record's p = 2 defect is untouched by this file.

## 5. The same L_e (C6)

critMap_kernel_iff ([L126Kernel.lean:75](../lean/HamiltonsCubic/Results/L126Kernel.lean#L75)) is stated on LeLin M, the same definition, so the ½ of cross_LeLin_spectrum is the ½ of the DF-kernel criterion. L127Le works on Fin n through restrict, which is where bridge_apply lives, and L126Kernel's ι specialises to Fin n.

## 6. The nonzero Ricci-cut vector (C7)

hsum is Σ_{i ∈ s} c_i = 0, the Ricci cut of the pair span, and hne is c_q ≠ 0 for some q ∈ s. By pair_eval ([L127Spec.lean:28](../lean/HamiltonsCubic/Results/L127Spec.lean#L28)), pairVec(φ_jq) = c_q φ_kq ≠ 0 whenever j ≠ k, which holds in both theorems (hk : k ∉ T in the cross case, hjk in the within case). So hne is exactly nonvanishing of the operator. Correct.

## 7. 1614e92a (C8)

At p = 2, T = {j, k}, so s ∩ T is empty and s = Tᶜ with q elements. The kernel condition (first-factor sum zero, second factor zero) leaves {0}, and the Ricci cut Σ c = 0 on Tᶜ has dimension q − 1, the dimension of the negative eigenspace. So "{0} at p = 2" and "the cut is the negative eigenspace alone at p = 2" are both right, and at p ≥ 3 the count (p − 3) + (q − 1) + 1 = n − 3 holds. The fix closes r1618's gap 1.

## 8. Gaps (C9, C10)

1. [L127WMult.lean:17](../lean/HamiltonsCubic/Results/L127WMult.lean#L17): the header ends "The dimension counts and the division by `θ` are prose." After 92b9443b and db5223e1 the division by θ is within_LeLin_spectrum's content, so half the sentence is stale. It should say the dimension counts are prose and point to L127Le for the division.
2. [lean/INDEX.md:495](../lean/INDEX.md#L495): the row says within_LeLin_spectrum holds "on a within block", while the theorem takes j, k ∈ T only. The second family (j, k ∉ T), whose L_e top is (q − 2)/(2(q − 1)), is typed in L_M units (within_spectrum_out) but not in L_e units, and the owed list does not name it. The fix is either a within_LeLin_spectrum_out through sphereWeight_compl or the words "at j, k ∈ T" in the row with the second family added to the owed list.

Otherwise the owed list (dimension counts as declarations, the D_n row, the agreement) is honest: none of the three is typed in L127Le or L127WMult.

## 9. Soundness (C11)

`lake build HamiltonsCubic.Results.L127Le HamiltonsCubic.Results.L127WMult` completed (exit 0, linter warnings only). `axiom_audit.py --only L127Le.lean`: 5/5 clean. `--only L127WMult.lean`: 3/3 clean. Only propext, Classical.choice and Quot.sound.

## 10. Downstream and style (C12, C13)

[findings/second-order.md](../findings/second-order.md) and [findings/INDEX-results.md](../findings/INDEX-results.md) carry no Lean status beyond a pointer to lean/INDEX.md, so nothing there is stale. No em dash in L127Le.lean, L127WMult.lean or the L127 row, no backticks inside link text, and the row is one line. The row's new text uses no semicolon splices, and the owed list's semicolons separate list items that carry commas.

## Verdict

**CONFIRMED WITH GAPS.**
