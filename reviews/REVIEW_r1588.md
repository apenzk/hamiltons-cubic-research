# Review r1588: L143's first term and assembly (L143Assembly), commit 951b473a

**Standfirst.** The new file is faithful to Lemma L143 and sound. `posMass` is the block's p = Σ_{λ>0} λ², and `first_term_le` proves ℓ · p ≤ 1 for every eigenvalue ℓ of a unit spectrum, λ_max included, which is the block's "first term bounded by 1 outright". `B5_le_sqrt` takes the square root of `B5_frame`'s 4(n − 2) correctly through √4 = 2, at μ = |λ| with the unit hypothesis transported by `sq_abs`. The binder `hso` in `L143_of_second_order` is second-order.md's θ ≤ λ_max p + B₅ with the same T = c², the same μ = |λ| and the same ½(Σ_α⟨T_αμ,μ⟩²)^{1/2}, so the theorem is exactly the lemma's final line granted its import. The build is clean with no warnings, the audit reads 4/4 on the standard three, and the L143 row states honestly that the second-order bound and the attainment of sup|P| at a critical point remain owed. One gap remains, in prose: the Lean pointer in bounds.md's L143 block still names only `B5_frame`.

| # | Claim | Verdict |
| --- | --- | --- |
| A-1 | `posMass` is p = Σ_{λ>0} λ² | **CONFIRMED** |
| A-2 | `first_term_le`: at Σλ² = 1 every eigenvalue ℓ has ℓ · p ≤ 1, so λ_max p ≤ 1 | **CONFIRMED** |
| A-3 | `B5_le_sqrt`: ½(Σ_α⟨T_αμ,μ⟩²)^{1/2} ≤ √(n − 2) at μ = \|λ\|, the square root of `B5_frame`'s 4(n − 2) | **CONFIRMED** |
| A-4 | `L143_at_frame`: λ_a p + B₅ ≤ 1 + √(n − 2) at every Weyl eigenframe of unit spectrum and every index a | **CONFIRMED** |
| A-5 | `hso` is the imported bound θ ≤ λ_max p + B₅ with the same B₅ and μ = \|λ\| | **CONFIRMED** |
| A-6 | the file and the row claim no more than they prove, and name the second-order bound and the attainment of sup\|P\| as owed | **CONFIRMED** |
| B | `lake build HamiltonsCubic.Results.L143Assembly`, axiom audit 4/4 on propext, Classical.choice, Quot.sound, no `sorry`/`admit`/`native_decide` | **CONFIRMED** |
| C | downstream consistency | **CONFIRMED WITH GAP** ([bounds.md:33](../findings/bounds.md#L33) names only `B5_frame` as machine-checked) |
| D | style of the docstrings and the L143 row | **CONFIRMED** |

**Summary:** L143Assembly proves the block's first term and its assembly faithfully and on the standard three, `hso` is the imported second-order bound verbatim, and the only gap is bounds.md's Lean pointer, which predates the new file.

## 1. Files and rows carrying the id

- [L143.lean](../lean/HamiltonsCubic/Results/L143.lean): `form_le_mass`, `form_le`, `B5_sq_le`, `B5_frame` (reviewed in earlier rounds, read here as the import).
- [L143Assembly.lean](../lean/HamiltonsCubic/Results/L143Assembly.lean): `posMass`, `first_term_le`, `B5_le_sqrt`, `L143_at_frame`, `L143_of_second_order`, new in 951b473a and identical in the working tree.
- One L143 row, [lean/INDEX.md:372](../lean/INDEX.md#L372), partial, "statement: not typed". The rows at lines 131 and 321 cite L143 in passing and make no claim about its Lean status.
- The root import [HamiltonsCubic.lean:756](../lean/HamiltonsCubic.lean#L756) carries the new module.

## 2. Fidelity against Lemma L143

- **p.** The block ([bounds.md:27](../findings/bounds.md#L27)) and second-order.md ([second-order.md:914](../findings/second-order.md#L914)) define p = Σ_{λ>0} λ². [L143Assembly.lean:30](../lean/HamiltonsCubic/Results/L143Assembly.lean#L30) sums `lam a ^ 2` over the indices with `0 < lam a`. Same object.
- **The first term.** The block's argument is p ≤ Σλ² = 1 and λ_max ≤ 1. `first_term_le` ([L143Assembly.lean:34](../lean/HamiltonsCubic/Results/L143Assembly.lean#L34)) proves 0 ≤ p ≤ 1 termwise against the unit sum, ℓ² ≤ 1 by `single_le_sum`, hence ℓ ≤ 1, and splits on the sign of ℓ: for ℓ ≤ 0 the product is at most 0, for ℓ > 0 it is at most 1 · 1. Stating it for every index is stronger than the block needs and covers λ_max as one instance. The eigenframe's `lam` are the eigenvalues of W on Λ² in an orthonormal frame for `inner2`, so Σλ² = 1 is ‖W‖ = 1 as the block reads it.
- **B₅.** second-order.md:912 defines B₅ = ½(Σ_α⟨T_αμ,μ⟩²)^{1/2} with T = c'² in an eigenbasis and μ = |λ|, and ⟨T_αμ,μ⟩ = Σ_{βγ} T_{αβγ} μ_β μ_γ. The Lean expression is `(1/2) * sqrt (∑ a, (∑ b, ∑ c, cst v a b c ^ 2 * |lam b| * |lam c|) ^ 2)` with `cst v a b c = inner2 [v a, v b] (v c)`. Same object, the normalisation being the one `B5_frame`'s pair cap 2 and row mass 2(n − 2) already fix.
- **The square root.** `B5_frame` gives Σ ≤ 4(n − 2). `B5_le_sqrt` ([L143Assembly.lean:48](../lean/HamiltonsCubic/Results/L143Assembly.lean#L48)) instantiates μ = |λ| (nonnegative by `abs_nonneg`, unit by `sq_abs`), applies `Real.sqrt_le_sqrt`, splits √(4(n − 2)) = √4 · √(n − 2) by `Real.sqrt_mul` at 0 ≤ 4, and uses √4 = 2. Then ½ · √Σ ≤ √(n − 2) by `linarith`. Correct.
- **The binder.** `hso` ([L143Assembly.lean:77](../lean/HamiltonsCubic/Results/L143Assembly.lean#L77)) reads θ ≤ `lam amax * posMass lam` + the same B₅ expression. Instantiated at amax the index of λ_max it is second-order.md:916's θ ≤ λ_max p + B₅ verbatim. Since the conclusion holds at every index, the free `amax` costs nothing. θ is a bare real with no criticality typed, so the theorem is transitivity with `L143_at_frame`, and the docstring's "a critical value" is the reading the owed list supplies rather than a typed hypothesis. That is honest: the row owes "the second-order bound θ ≤ λ_max p + B₅ at a critical point" and the attainment of sup|P| at a critical point ([r1469](REVIEW_r1469.md)), and closes on "statement: not typed", which is right since sup|P| ≤ 1 + √(n − 2) appears nowhere as a Lean statement.

## 3. Soundness

- `~/.elan/bin/lake build HamiltonsCubic.Results.L143Assembly`: "Build completed successfully (8716 jobs)". The one linter note in the tail belongs to another module. `lake env lean` on the file alone prints no warning and no error.
- `python3 scripts/misc/axiom_audit.py --only L143Assembly.lean`: "4/4 clean -- resting on the standard three alone".
- No `sorry`, `admit` or `native_decide` in the file.

## 4. Downstream

- [lean/INDEX.md:372](../lean/INDEX.md#L372) agrees with the file on every declaration, the 4/4 count and the owed list.
- [findings/INDEX-results.md:159](../findings/INDEX-results.md#L159) states the lemma and its Gate 2 status and makes no Lean claim. Consistent.
- STATUS.md and plan-lean.md were regenerated in the same commit, their counts moving with unrelated L270 and L271 rows. Nothing there contradicts the new file.
- **Gap.** [bounds.md:33](../findings/bounds.md#L33) ends the proof with "The estimate B₅ ≤ √(n − 2) is machine-checked at every Weyl eigenframe as `B5_frame` in L143.lean". That sentence is true, and it now under-reports: the first term and the assembly λ_max p + B₅ ≤ 1 + √(n − 2) are machine-checked too, in L143Assembly.lean, and the block carries no pointer to it.

## 5. Style

- No em dash in the file or in the row. The semicolons in the module docstring's bullets and in the row separate list items that carry commas, which is their permitted use. No backticks inside link text. The row is one line.

## 6. Verdict

**CONFIRMED WITH GAPS.** The mathematics and the Lean are faithful and sound. Gap 1: [bounds.md:33](../findings/bounds.md#L33) should name L143Assembly.lean's `first_term_le` and `L143_at_frame` beside `B5_frame`.
