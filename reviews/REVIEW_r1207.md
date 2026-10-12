# Review r1207: I73 (c) general-spectrum ceiling and the p = 8 window claims

Adversarial Gate 2 review of two claims in [2026-09-25-I73c-per-vector-rows.md](2026-09-25-I73c-per-vector-rows.md): (I) the paragraph "L253 at every three-value spectrum", with the Lean theorem general_ceiling in [CoupledMoment.lean](../lean/HamiltonsCubic/Results/CoupledMoment.lean) and [screen_I73c_general_ceiling.py](../scripts/misc/screen_I73c_general_ceiling.py), and (II) the window sentences from "A single element is exhausted by L249 on the window" through "Owed". Analysis-only footing: every computation below is a screen of seconds on objects constructed for it, and none is evidence for a positive claim beyond reproducing a stated screen.

| Item | Claim | Verdict |
|---|---|---|
| 1 | L248 identity and ordering | CONFIRMED |
| 2 | Eckart–Young at a general spectrum | CONFIRMED |
| 3 | x-free form and symmetric reduction to κ ≤ p − 2 | CONFIRMED |
| 4 | Lean general_ceiling | CONFIRMED, with an attribution repair |
| 5 | Survivor counts 4 of 190, 0 of 147 | CONFIRMED |
| 6 | Single-element LP supremum equals L249 on 8 ≤ p ≤ 13 | CONFIRMED (as a screen) |
| 7 | Multi-element inequality | CONFIRMED |
| 8 | p = 8 numbers, and the separation drawn from them | numbers CONFIRMED, separation inference REFUTED as stated |
| 9 | Pairwise line-sharing planes of a space of dimension at least 4 form a star | CONFIRMED |

**Most serious finding (item 8).** The separation is shown at two configurations only, orthogonal disjoint planes (ν = 12) and line-sharing planes (ν = 6). The one-parameter family x₁ = e₁∧e₂, x₂ = (cos α e₁ + sin α e₃)∧e₄ consists of orthonormal decomposable pairs whose planes meet only in 0 for every α > 0, and ν⁽²⁾₄₂ runs continuously from 6 at α = 0 to 12 at α = 90°, crossing the target 4(7 − κ₀) ≈ 8.22 at α ≈ 59.6°. So pairs with planes at principal angle up to about 60° (far from sharing a line) pass the multi-element test, and the sentence "so every two planes of E₀ must nearly share a line" does not follow from the separation as stated. What does force line-sharing is the single-element region applied to combinations: at α = 59.6° the unit combinations cos t x₁ + sin t x₂ reach s₁² ≈ 0.753 < 0.85. The conclusion is reachable, but by linearity plus the single-element region, and the multi-element step as written contributes no demonstrated input to it. The "Owed" line should name this: the quantitative separation must cover the whole principal-angle range, and the record should state which constraint does the work.

## Item 1: the L248 identity and the ordering

At unit x ∈ E₀ the three rows give Σ(λ_a − λ₂)(λ_b − λ₂)b_ab = Σλ_aλ_b b_ab − 2λ₂Σλ_b b_ab + λ₂²Σb_ab = λ₀(θ − λ₀) + 2λ₂λ₀ + (n − 2)λ₂². With λ₀ = −|λ₀| (trace zero forces λ₀ < 0) this is (n − 2)λ₂² − 2λ₂|λ₀| − λ₀² − |λ₀|θ, as stated. Each coefficient (λ_a − λ₂)(λ_b − λ₂) is a product of two non-positive numbers and b_ab ≥ 0, and the index-2 terms vanish. The ordering (λ₂ − λ₀)² ≥ (λ₂ − λ₀)(λ₂ − λ₁) ≥ (λ₂ − λ₁)² holds from λ₂ − λ₀ ≥ λ₂ − λ₁ > 0, and the off-diagonal term carries the factor 2 from b₀₁ = b₁₀, giving (λ₂ − λ₁)²(b₀₀ + 2b₀₁ + b₁₁). CONFIRMED.

## Item 2: Eckart–Young at a general spectrum

With V = E₀ ⊕ E₁ of dimension N − p₂ and A = ad_x restricted to V, the identity ‖(P₀ + P₁)A‖² = 2(b₀₀ + 2b₀₁ + b₁₁) is ad-invariance plus b_ab = ½‖P_b ad_x P_a‖². P₂A has image in E₂, so rank at most p₂, and Eckart–Young bounds ‖A − P₂A‖² below by the sum of the N − 2p₂ smallest eigenvalues of the compression of −ad_x² to V. Cauchy interlacing at codimension p₂ bounds each of those below by the matching smallest eigenvalue of −ad_x², giving μ_{N−2p₂}(x). Nothing in the step uses the symmetric spectrum. CONFIRMED.

## Item 3: the x-free form and its symmetric reduction

The trace of −ad_x² at unit x is 2(n − 2) (row (A)), the nonzero eigenvalues come in equal pairs, so the 2q largest are twice the q largest root values, at most 2(q + 1) by the Gram row sum. Hence μ_{N−2q} ≥ 2(n − 3 − q). At (−a, 0, a) with p₀ = p₂ = p the right side becomes a²(n − 2 − 2 − 1 − (n − 3 − p)) = a²(p − 2), so κ ≤ p − 2, matching L253. Minor: when p₂ > n − 3 the substituted term is negative, which is valid but weaker than μ ≥ 0. The screen uses the negative value, and at n = 12 this changes no count because the L248-only bound already excludes none. CONFIRMED.

## Item 4: Lean general_ceiling

The file compiles clean (lake env lean, exit 0, no sorry), with two unused-hypothesis warnings, hl0 and hb11. The hypotheses match the prose and are no stronger: hS is the definition of the left side restricted to the {0,1} block, hrows takes the L248 identity as an inequality (weaker than the equality the rows give), and hμ is the Eckart–Young and interlacing output of item 2, taken as a hypothesis because the layer has no singular values. They are jointly satisfiable (l = (−1, 0, 1), all b and μ zero, n = 12, θ = 0), so the theorem is not vacuous. Attribution repair: the prose places the tag general_ceiling after "κ ≤ p − 2", but the theorem proves only the algebraic step to the μ form. The Gram-row-sum substitution μ ≥ 2(n − 3 − p₂) and the symmetric reduction are outside it, and the theorem has no row in [lean/INDEX.md](../lean/INDEX.md). The tag belongs after the μ-form display, or a two-line corollary should carry the x-free and symmetric forms.

## Item 5: survivor counts

Rerun of [screen_I73c_general_ceiling.py](../scripts/misc/screen_I73c_general_ceiling.py) against [I73c_offray_n12_theta0.log](../agent_logs/I73c_offray_n12_theta0.log) and [I73c_offray_n12_theta0_T42.log](../agent_logs/I73c_offray_n12_theta0_T42.log): 190 points, 4 excluded (multiplicities (5,55,6), (5,54,7), (6,54,6), (7,53,6), all at frac 0.5), L248 alone 0, and 147 points, 0 excluded. The spectrum is Frobenius-normalised with trace zero asserted, matching θ₀ = 1.2361. The bound is homogeneous of degree 2 in λ so the normalisation matters only through θ, and it is consistent. CONFIRMED.

## Item 6: the single-element LP

No script for this screen is on disk, so it is not rebuildable from the record. I rebuilt it: at (−1, 0, 1), variables b₀₀, b₀₁, b₀₂, b₁₁, b₁₂, b₂₂ ≥ 0 and κ, rows (A) to (C), Ky Fan caps 2R_b ≤ κ_{m_b} single and union, Eckart–Young 2Σ_{a,b≠e}b_ab ≥ μ_{N−2m_e} for e = 0, 1, 2, optionally the Ky Fan lower caps too, maximised over angle vectors by 180 Nelder–Mead starts per p. The supremum equals L249's at every p ∈ [8, 13], in θ units 1.3187, 1.4432, 1.5652, 1.4924, 1.4289, 1.3728, and the LP never exceeds L249 pointwise at the starts (gap ≤ 1e−15). The quoted 1.3187 and 1.5652 are θ values (κ = 5.2749 and 7), which the sentence leaves unlabelled beside κ-valued bounds elsewhere in the paragraph. CONFIRMED as a screen, with two repairs owed: link a script, and label the unit.

## Item 7: the multi-element inequality

For orthonormal x₁, ..., x_k in E₀ and A: V → so(n)^k, z ↦ ([x_i, z])_i, the norm identity is item 2 summed over i. The bound b₀₀ + 2b₀₁ + b₁₁ ≤ 4b₀₀ + 4b₀₁ + b₁₁ = n − 5 − κ = 7 − κ gives ‖(P₀ + P₁)A‖² ≤ 2k(7 − κ). P₂A maps into E₂^k, rank at most kp. Eckart–Young leaves the dim V − kp = N − (k + 1)p smallest eigenvalues of AᵀA, which is the compression of Σ_i −ad_{x_i}² to V, and codimension-p interlacing gives ν⁽ᵏ⁾_{N−(k+1)p}(X) ≤ 2k(7 − κ). Screens of the side remarks: a star pair has common centraliser so(9) (kernel dimension 36 ≥ 66 − 3p for p ≥ 10, so ν = 0), the so(3) triple has ν⁽³⁾₃₄ = 0 at p = 8, and line-sharing pairs meet the bound at p = 8 (6 < 8.22) and p = 9 (ν⁽²⁾₃₉ = 3 < 7.02). CONFIRMED.

## Item 8: the p = 8 numbers and the separation

Numbers, CONFIRMED: e₁∧e₂ and e₃∧e₄ commute, the common centraliser is so(2) ⊕ so(2) ⊕ so(8) of dimension 30, and Σ −ad² has eigenvalues 0 (30), 1 (32), 2 (4), so ν⁽²⁾₄₂ = 12. The line-sharing pair e₁∧e₂, e₁∧e₃ gives exactly 6. The target 4(7 − √(55/36 · 16)) = 8.22. The inference drawn from them is REFUTED as stated, as set out in the most serious finding above: the tilted family gives ν⁽²⁾₄₂ of 5.755, 6.072, 6.929, 8.268, 9.998 at α = 15°, 30°, 45°, 60°, 75°, crossing the target at α ≈ 59.6° while the planes meet only in 0.

## Item 9: pairwise line-sharing planes form a star

For decomposable elements, two planes share a line exactly when the sum is decomposable, so pairwise line-sharing over all elements of E₀ makes E₀ a linear space of decomposables. The classical dichotomy is a star or a subspace of Λ²R³, and Λ²R³ has dimension 3, so dimension at least 4 forces a star. The sentence is correct as a statement about all pairs of elements, and the preceding paragraph states the full dichotomy. The statement also holds for pairs of basis planes, since pairwise-meeting projective lines are concurrent or coplanar, so either reading is correct. CONFIRMED.
