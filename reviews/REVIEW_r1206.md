# REVIEW r1206: L253 at every three-value spectrum, and the single-element LP, multi-element L249 and p = 8 separation

Reviewer r1206, adversarial Gate 2, independent of r1207. Source: [2026-09-25-I73c-per-vector-rows.md](2026-09-25-I73c-per-vector-rows.md), claim (I) the paragraph "L253 at every three-value spectrum", claim (II) the sentences from "A single element is exhausted by L249 on the window" through "Owed". Analysis-only footing: every computation below is a screen of seconds on objects constructed for it, reported as a screen.

| Item | Claim | Verdict |
|---|---|---|
| 1 | L248 identity and ordering step | CONFIRMED |
| 2 | Eckart–Young and interlacing at a general spectrum, μ over the N − 2p_2 smallest | CONFIRMED |
| 3 | x-free form via the Gram row sum, symmetric reduction κ ≤ p − 2 | CONFIRMED |
| 4 | Lean general_ceiling | CONFIRMED WITH GAP (citation scope) |
| 5 | survivor screen, 4 of 190 and 0 of 147 | CONFIRMED (counts), explanatory clause REFUTED |
| 6 | full single-element LP has L249's supremum on 8 ≤ p ≤ 13 | CONFIRMED (screen), "only L249 binding" imprecise at p ≥ 10 |
| 7 | multi-element inequality ν^(k)_{N−(k+1)p}(X) ≤ 2k(7 − κ) | CONFIRMED |
| 8 | p = 8 numbers and the conclusion "every two planes must nearly share a line" | numbers CONFIRMED, conclusion REFUTED as derived |
| 9 | pairwise line-sharing planes of a space of dimension at least 4 form a star | CONFIRMED (for the linear span), wording ambiguous |

**Most serious finding (item 8).** The separation is shown only for two decomposables on completely orthogonal planes. Two orthonormal decomposables on planes that meet trivially but are not orthogonal, x_1 = e_1∧e_2 and x_2 = (cos α e_2 + sin α e_3)∧e_4, give ν^(2)_42 below 4(7 − κ_0) ≈ 8.22 for every α up to about 1.04 rad (5.755 at α = 0.26, below the line-sharing value 6, and 7.54 at α = 0.92). So the multi-element inequality does not force two planes of E_0 to nearly share a line, and "line-sharing vs disjoint" is not a dichotomy of ν. Along this family the single-element region applied to the pencil already does more: min s_1² over the pencil is 0.854 at α = π/4 and 0.75 at α = 1.047, where ν crosses the target, so s_1² ≳ 0.85 excludes the family earlier than the multi-element bound does. The pairwise common line is therefore a consequence of near-decomposability of every element of span(x_1, x_2) (x_1∧x_2 = 0 exactly when the planes share a line), and the multi-element form adds nothing to that step on this family.

## Item 1: the L248 identity and the ordering

Expanding with b_ab = b_ba and the three rows at x ∈ E_0: Σ(λ_a − λ_2)(λ_b − λ_2)b_ab = λ_0(θ − λ_0) + 2λ_2λ_0 + (n − 2)λ_2², which with λ_0 = −|λ_0| is the displayed right side. Terms with an index 2 vanish, b_ab ≥ 0 as sums of squares, and the remaining three terms are (λ_2 − λ_0)²b_00 + 2(λ_2 − λ_0)(λ_2 − λ_1)b_01 + (λ_2 − λ_1)²b_11 ≥ (λ_2 − λ_1)²(b_00 + 2b_01 + b_11). CONFIRMED. Minor: the prose writes |λ_0| without saying λ_0 < 0, which holds since W is trace-free and nonzero, and the Lean statement carries it as hl0.

## Item 2: Eckart–Young at a general spectrum

h = E_0 ⊕ E_1 has dimension N − p_2. ‖(P_0 + P_1)ad_x|_h‖² sums ⟨[ψ_γ, ψ_δ], x⟩² over ordered pairs in E_0 ∪ E_1, which is 2(b_00 + 2b_01 + b_11). P_2 ad_x|_h has rank at most p_2, so the tail Σ_{i>p_2}σ_i² is at most that norm. Interlacing for a restriction to codimension p_2 gives σ_i(A) ≥ σ_{i+p_2}(ad_x), and i runs from p_2 + 1 to N − p_2, so the bound is the sum of the N − 2p_2 smallest eigenvalues of −ad_x². At the symmetric spectrum this is μ_m. CONFIRMED.

## Item 3: the x-free form and the symmetric reduction

μ_{N−2q} = 2(n − 2) − κ_{2q}, and κ_{2q} is twice a sum of q root values because every nonzero eigenvalue of −ad_x² is doubled, so the Gram row sum gives κ_{2q} ≤ 2(q + 1) and μ_{N−2q} ≥ 2(n − 3 − q). When n − 3 − p_2 < 0 the bound is weaker than μ ≥ 0 but still valid. At (−a, 0, a) with p_2 = p: aθ ≤ a²[(n − 2) − 2 − 1 − (n − 3 − p)] = a²(p − 2), so κ ≤ p − 2. CONFIRMED.

## Item 4: Lean general_ceiling

The theorem in [CoupledMoment.lean](../lean/HamiltonsCubic/Results/CoupledMoment.lean) takes l0 < l1 < l2, l0 < 0, b_00, b_01, b_11 ≥ 0, the {0,1} block S, hrows as S ≤ right side (weaker than the equality the prose derives, since the index-2 terms vanish), and hμ as μ ≤ 2(b_00 + 2b_01 + b_11). Its conclusion is the per-element μ form. The hypotheses are no stronger than the prose, and they are satisfiable (l = (−1, 0, 1), all b and μ zero, S = 0, θ small), so the theorem is not vacuous. Compile: `lake env lean` on the file exits 0 with no error and no sorry, two linter warnings: hl0 and hb11 are unused, so the proved statement is stronger than displayed (it holds without λ_0 < 0 and without b_11 ≥ 0), which is harmless. **Gap**: the note attaches `general_ceiling` to the sentence "the x-free form ... which at the symmetric spectrum is κ ≤ p − 2", but the theorem proves neither the Gram substitution nor the symmetric reduction, only the μ form. The theorem is also absent from [lean/INDEX.md](../lean/INDEX.md) and from the file's module docstring.

## Item 5: the survivor screen

[screen_I73c_general_ceiling.py](../scripts/misc/screen_I73c_general_ceiling.py) reruns in seconds and prints 4 of 190 at θ = 1.2361 from agent_logs/I73c_offray_n12_theta0.log and 0 of 147 from agent_logs/I73c_offray_n12_theta0_T42.log, L248 alone none, as claimed. Every survivor spectrum satisfies λ_0 < λ_1 < λ_2 with λ_0 < 0. The four excluded are (5,55,6), (6,54,6), (5,54,7), (7,53,6) at fraction 0.5, near-symmetric with p_2 ∈ {6, 7}, as claimed. The file the brief names as "..._T42.log" (agent_logs/I73c_offray_n12_T42.log) is a different run (θ = 1.2248, 194 points). The script reads ..._theta0_T42.log, which is the right one. **The explanatory clause is false**: "the survivors have λ_1 close to λ_2 or p_2 large" fails at (5,59,2), (7,56,3), (8,55,3) at fraction 0.3, where p_2 ≤ 3 and (λ_2 − λ_1)/(λ_2 − λ_0) = 0.7. There the new term is large (9.61 at (5,59,2)), and these survive because λ_2 ≫ |λ_0| makes the L248 term (n − 2)λ_2²/|λ_0| large (12.37). The correct reading: the survivors are those where λ_2 − λ_1 is small, or p_2 is large, or λ_2 is large against |λ_0|.

## Item 6: the single-element LP

No script for this screen is on disk (none of the recorded scripts carries 1.3187 or 1.5652), so it is not reproducible from the record. Rebuilt (scratch, seconds): variables b_00, b_01, b_02, b_11, b_12, b_22 ≥ 0 and κ, rows (A) to (C), the three single caps (κ_{p−1}, κ_m, κ_p), the three union caps (κ_{p+m−1}, κ_{2p−1}, κ_{m+p}), and Eckart–Young for e = 2 (μ_m) and e = 0 (μ_{N−2p}), with e = 1 vacuous since N − 2m < 0 for p ≤ 16. Over 3000 random angle vectors per p plus Nelder–Mead: the LP supremum equals L249's at every p ∈ [8, 13] (κ = 5.2749, 6.1231, 7, 7, 7, 7, θ = 1.3187 at p = 8 and 1.5652 at p = 10 as stated), and pointwise LP − L249 never exceeds 0. CONFIRMED as a screen. Imprecision: at p ≥ 10 the supremum is n − 5 = 7 at a decomposable x, where the E_2 cap κ + 2 ≤ κ_p(x) = 10 binds as well (slack 0.0006 at the numerical maximiser), so "only L249's constraint binding" holds at p = 8 (every other slack ≥ 0.57) and not at p ≥ 10.

## Item 7: the multi-element inequality

A: h → so(n)^k, z ↦ ([x_i, z])_i. ‖(P_0 + P_1)A‖² = Σ_i 2(b_00 + 2b_01 + b_11)(x_i) ≤ 2k(n − 5 − κ) by the symmetric row identity 4b_00 + 4b_01 + b_11 = n − 5 − κ with b ≥ 0. The image of P_2 A lies in E_2^k, rank ≤ kp. A is the restriction of Ã: so(n) → so(n)^k to codimension p, and ÃᵀÃ = Σ_i −ad_{x_i}². Indices j > kp up to N − p give σ_{j+p}(Ã), the N − (k + 1)p smallest eigenvalues. CONFIRMED. The "7" is n − 5 at n = 12. Side claims checked: two elements of a star have common centraliser of dimension 36 = dim so(9), and at p = 10, N − 3p = 36, so ν = 0.

## Item 8: the p = 8 numbers and the separation

Rebuilt ad on so(12) (scratch, seconds). e_1∧e_2, e_3∧e_4: kernel of Σ −ad² of dimension 30, ν^(2)_42 = 12.000. e_1∧e_2, e_1∧e_3: kernel 36, ν^(2)_42 = 6.000. Target 4(7 − 4θ_0) = 8.2235. The numbers are CONFIRMED. The inference is REFUTED as derived, see the most serious finding: on the family x_2 = (cos α e_2 + sin α e_3)∧e_4 (planes meeting trivially for α > 0), ν^(2)_42 = 6.0, 5.81, 5.76, 5.84, 6.07, 6.44, 6.93, 7.54, 8.27, …, 12.0 at α = kπ/24, k = 0, …, 12. Every α ≤ about 1.04 meets the inequality. What would carry the step is the single-element region on the pencil span(x_1, x_2), whose min s_1² falls to 0.854 at α = π/4, and the note does not use it there.

## Item 9: the star statement

For a linear space L of 2-forms whose elements' planes pairwise share a line, x∧y = 0 for all x, y ∈ L, so every element of L is decomposable, and the classical classification gives a star e∧V or a subspace of Λ²U with dim U = 3, which has dimension at most 3. So dim L ≥ 4 forces a star. CONFIRMED with "space" read as the linear span E_0. Read as the ambient R^n, the sentence would be false (Λ²R³ sits in R^12). Recommend "a linear space of 2-forms of dimension at least 4 whose planes pairwise share a line is a star (Λ²R³ has dimension 3)". The quantitative version, where a near-Λ²R³ block of dimension 3 sits inside a larger near-star, is exactly the owed step and the note records it as owed.

## Recommended repairs

- Replace "So with every element near-decomposable ..., every two planes of E_0 must nearly share a line" by the pencil argument (near-decomposability of every element of span(x, y) forces x∧y ≈ 0), and record that the multi-element form does not separate non-orthogonal disjoint planes (ν^(2)_42 ≈ 5.76 to 8.2 for α ≤ 1.04).
- Rewrite the survivor explanation to include "λ_2 large against |λ_0|".
- Scope `general_ceiling` to the μ form, or add the x-free and symmetric corollaries to Lean, and index it.
- Commit the single-element LP and multi-element screens as scripts.
