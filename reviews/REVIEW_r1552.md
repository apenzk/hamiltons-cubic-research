# Review r1552: L167's first display (commit 47c72a72) and L54's (4) on S²₀ with r1551's gaps repaired (commit 30f49126)

**Standfirst.** Both Lean files build, audit clean on the standard three (7/7 for [L167Mixed.lean](../lean/HamiltonsCubic/Results/L167Mixed.lean), 5/5 for [L54Diag.lean](../lean/HamiltonsCubic/Results/L54Diag.lean)) and carry no `sorry`, `admit` or `native_decide`. The mathematics is faithful: `stab_mixed_trivial` is the record's 𝔰𝔱𝔞𝔟(u) ∩ (ℝ⁴ ⊗ ℝ^m) = 0 with ρ(A) = [A, ·] the derivation action and the block's own one-nondegenerate-element proof, and `L54_rigidity_S20` is the record's ω = d at t_F = 2 on S²₀ as a multiset equality. r1551's six gaps are closed apart from one minor residue it recorded under gap 3. The gaps are in the index and in two file headers: 47c72a72 flips the L167 main row to `statement: typed` while two of L167's three displays are untyped, the same overclaim r1551 returned on L67, and the headers of [L167.lean](../lean/HamiltonsCubic/Results/L167.lean) and [L54Rigid.lean](../lean/HamiltonsCubic/Results/L54Rigid.lean) still call proved work owed.

| # | claim | verdict |
| --- | --- | --- |
| A-1a | `IsMixed` with `IsSkew` is the record's mixed block ℝ⁴ ⊗ ℝ^m in skew-matrix form | **CONFIRMED** |
| A-1b | `hstab`, [A, Wc X] = Wc [A, X] for every skew X, is "ρ(A) commutes with u", with the layer's `br` convention | **CONFIRMED** |
| A-1c | `Wc` is the record's padded W_{ℂP²}, and the proof follows the block | **CONFIRMED** |
| A-1d | the L167 rows in lean/INDEX.md are accurate, `parity_splits` being the parity argument | **CONFIRMED WITH GAP** (the main row's flag moved to typed) |
| A-2 | `L54_rigidity_S20` is the record's (4) on S²₀, with the record's operators and hypotheses | **CONFIRMED** |
| A-3a | r1551 gaps 1, 2, 4, 5 and 6 are closed | **CONFIRMED** |
| A-3b | r1551 gap 3 is closed and the L116 owed list is complete | **CONFIRMED WITH GAP** (the minor untyped symmetries of `rankOne` stay unnamed) |
| B | build, axiom audit, no `sorry`, `admit` or `native_decide` | **CONFIRMED** |
| C | no downstream text still calls the two results untyped | **GAP** (two Lean file headers) |
| D | style of the markdown edits | **CONFIRMED** |

**Summary:** both theorems are sound and faithful, and the defects are one overclaimed statement flag on L167 and two stale headers.

## 1. L167Mixed.lean against Lemma L167's first display (A-1)

- **The mixed block.** `IsMixed A` says A_ij = 0 whenever i and j are both in or both out of the first four coordinates, so with `IsSkew A` the only entries are the pairs (a, b) and (b, a) with a < 4 ≤ b, which is span{e_a ∧ f_b} = ℝ⁴ ⊗ ℝ^m under the identification of Λ² with skew matrices. `In4` is the same "first four" as `Emb`, where `Wc`'s padding sits ([CP2Real.lean:82](../lean/HamiltonsCubic/Results/CP2Real.lean#L82)).
- **The derivation and its sign.** For x ∧ y ↔ xyᵀ − yxᵀ and A skew, ρ(A)(x ∧ y) = Ax ∧ y + x ∧ Ay = (Ax)yᵀ − y(Ax)ᵀ + x(Ay)ᵀ − (Ay)xᵀ = A(xyᵀ − yxᵀ) − (xyᵀ − yxᵀ)A, using (Ax)ᵀ = −xᵀA. So ρ(A)X = AX − XA, which is the layer's `br A X` ([WeylReal.lean:42](../lean/HamiltonsCubic/Base/WeylReal.lean#L42)). The hypothesis `A * Wc X − Wc X * A = Wc (A * X − X * A)` for every skew X is ρ(A) ∘ u = u ∘ ρ(A) on Λ², which is A ∈ 𝔰𝔱𝔞𝔟(u). The statement is also invariant under A ↦ −A, so the sign cannot matter.
- **The operator.** `Wc n X = Σ_a μ_a ⟨X, ω_a⟩ ω_a` with ω_a = √2⁻¹ Emb J_a Embᵀ and μ ∝ (2, −1, −1) ([CP2Real.lean:177](../lean/HamiltonsCubic/Results/CP2Real.lean#L177)) is W_{ℂP²} on Λ²ℝ⁴ padded by zero, with its image the 3-space spanned by the ω_a. It is defined on every matrix, and the theorem only feeds it skew X, so nothing extra is assumed.
- **The proof is the block's.** `Wc_mixed` is "u annihilates ℝ⁴ ∧ ℝ^m by the padding", `br_mixed` is "ρ(A)ξ lies in ℝ⁴ ∧ ℝ^m for ξ ∈ Λ²ℝ⁴", so at X = ω₀ the commutator is one-termed, μ₀ [A, ω₀] = 0, and μ₀ ≠ 0 is the record's "the eigenvalues are nonzero". `om_sq'`, ω₀² = −½P, is the corrected constant at the nondegenerate element, and multiplying the out-rows of Aω₀ = 0 by ω₀ gives −½ A_ij = 0 for i out, j in, with skewness giving the transposed entries. This is exactly "one nondegenerate element of the image finishes it", taken at ω₀. The expansion ρ(A)ω = −Σ_j (ω v_j) ∧ f_j is bypassed by the matrix computation, so its removal from the owed list is right. `n ≥ 4` enters as `hn`, matching the record's "n ≥ 4 is used and was unstated".
- **The L167 rows.** The main row ([lean/INDEX.md:245](../lean/INDEX.md#L245)) states the theorem, its lemmas and the 7/7 audit correctly, and "the parity argument is L167Statement's `parity_splits`" is accurate: `parity_splits` ([L167Statement.lean:68](../lean/HamiltonsCubic/Results/L167Statement.lean#L68)) is the record's argument in the abstract grading, an even u, an even X and an odd Y with [X + Y, u] = 0 forcing both brackets to vanish. The owed list, the second display as a Lie-algebra statement at Wc and the orbit dimension as its complement, is complete against the record's three displays. **Gap 1**: 47c72a72 moves the main row's flag from `statement: not typed` to `statement: typed`. L167's statement is three displays and one of them is typed, the row itself owing the other two. [lean-layer.md:48](../.claude/skills/lean-layer.md) reserves the flag for a row whose file carries the lemma's own statement, and r1551 gap 1 returned the same flip on L67 for the same reason. The statement row at [lean/INDEX.md:246](../lean/INDEX.md#L246) carried `typed` before this commit while saying no display was stated. It now says the first display is stated, in another file, which leaves it on the same footing as the main row.

## 2. L54_rigidity_S20 against Lemma L54 (4) (A-2)

- **The claim.** [bispectral.md:491](../findings/bispectral.md#L491) (4): at t_F = 2, μ = d_φ and ω = d as multisets, ω the spectrum of W̊ on S²₀ and d = (d_φ, d_ψ) with d_ψ = −(eigenvalues of K on 𝟏^⊥). `L54_rigidity_S20` states: the multiset of eigenvalues of `Bw w (ringW R)` restricted to (ℝ g_W)^⊥ equals the multiset of the pair diagonal plus the multiset of −(eigenvalues of K restricted to 𝟏^⊥). That is ω = d on the record's objects, as a multiset equality.
- **The restricted operators.** (ℝ g_W)^⊥ with g_W the metric's coordinates in the orthonormal basis `ew w` is S²₀, as `Bw_gCoord` and `gCoord_wStd_eq_gvec` establish and r1549 checked. (ℝ 𝟏)^⊥ is 𝟏^⊥. The right-hand ψ part is minus the spectrum of K on 𝟏^⊥, which by `psi_block` is the record's d_ψ at any eigenbasis of K on 𝟏^⊥, so the choice of basis in the record washes out.
- **The hypotheses.** Unit norm, t_F = 2, first Bianchi and Ricci-flatness, over the section variables (R linear, skew-preserving, self-adjoint). That is the record's W ∈ Weyl_n with ‖M‖_F = 1. `0 < n` replaces the record's n ≥ 4 and is weaker, so the Lean statement is at least as general.
- **The proof.** `L54_rigidity`'s second conjunct gives the S² spectrum and S² diagonal the same sorted vector, `sameSorted_multiset` reads a permutation as multiset equality, `ringW_spectrum_split` and `dpsi_split` put one 0 on each side, and `Multiset.cons_inj_right` cancels it. Correct, and exactly the route r1549 named.
- **The μ = d_φ half.** It lives on Λ² in the pair basis with no S²₀ passage, and `L54_rigidity`'s first conjunct already carries it as `SameSorted`, which is equality of multisets. So (4) is typed in full, as the L54 row ([lean/INDEX.md:275](../lean/INDEX.md#L275)) now says, with only (2)'s majorisation cancellation owed.

## 3. 30f49126 against r1551 (A-3)

- **Gap 1 closed.** The L67 main row ([lean/INDEX.md:392](../lean/INDEX.md#L392)) reads `statement: not typed` and owes L67 itself at the unit Weyl tensor of S^m × S^m and "no other eigenvalue" as a statement.
- **Gap 2 closed.** The L67 statement row ([lean/INDEX.md:393](../lean/INDEX.md#L393)) points at L67Ring for the connection to W̊.
- **Gap 3 closed in substance.** The L116 row ([lean/INDEX.md:468](../lean/INDEX.md#L468)) is back to partial and owes that R^# alone fails to preserve Bianchi, the "What M actually is" subsection, the degenerate-point claim and the ℂP³/ℂP⁴ numerics. Read against [bounds-relaxations.md:246–300](../findings/bounds-relaxations.md#L246), the remaining sentences are the displayed identity (typed as `L116` and `bianchi_sq_spectral`), Böhm–Wilking's "the sum preserves Bianchi" (the same identity), the falsity of b(W²) = 0 at critical points (the numerics, "both sides genuinely nonzero") and the F15 remark, which is interpretation with no formal referent. The list is complete. **Gap 2 of this review, minor**: r1551's gap 3 also recorded that [L116Witness.lean:25](../lean/HamiltonsCubic/Results/L116Witness.lean#L25) leaves the two antisymmetries and pair symmetry of `rankOne v` untyped, and neither the file nor the row names this.
- **Gap 4 closed.** [findings/INDEX-results.md:132](../findings/INDEX-results.md#L132) reads "Lean: partial", which now matches the row.
- **Gap 5 closed.** [L82.lean:45](../lean/HamiltonsCubic/Results/L82.lean#L45) and [L82.lean:62](../lean/HamiltonsCubic/Results/L82.lean#L62) say "the all-equal value", the L82 row names the `adn` link and the two untyped conclusions, and `free_bound_skew`'s docstring ([L82Free.lean:109](../lean/HamiltonsCubic/Results/L82Free.lean#L109)) states its two-block restriction.
- **Gap 6 closed.** Both named splices in the L116 row are rewritten. The semicolons left there separate list items that carry commas.

## 4. Soundness (B)

- `lake build HamiltonsCubic.Results.L167Mixed HamiltonsCubic.Results.L54Diag`: build completed successfully (8741 jobs). Warnings only: an unused section variable in L52Frame.lean and an unused simp argument `Finset.map_val` at [L54Diag.lean:91](../lean/HamiltonsCubic/Results/L54Diag.lean#L91), the second new in 30f49126 and harmless.
- `axiom_audit.py --only L167Mixed.lean`: 7/7 clean. `--only L54Diag.lean`: 5/5 clean. Each rests on propext, Classical.choice and Quot.sound alone.
- No `sorry`, `admit` or `native_decide` in either file.

## 5. Downstream (C)

- [findings/route-a.md](../findings/route-a.md) Lemma L167 and [findings/bispectral.md](../findings/bispectral.md) Lemma L54 carry no Lean status text. [findings/INDEX-results.md](../findings/INDEX-results.md) marks both L167 and L54 "Lean: partial", still right for both (L167's second and third displays, L54's (2) on S²₀).
- **Gap 3**: [L167.lean:15](../lean/HamiltonsCubic/Results/L167.lean#L15) still says "What is not. The parity argument splitting stab(u) across the blocks, and the expansion ρ(A)ω = ..., both are bivector computations the base layer has no type for", and line 18 says the block argues the splitting "and this file does not". The parity argument is `parity_splits`, and the first display is proved in L167Mixed at the layer's bivector matrices. The commit replaced this text in the row and left it in the file.
- **Gap 4**: [L54Rigid.lean:23](../lean/HamiltonsCubic/Results/L54Rigid.lean#L23) still says "That the ψ-diagonal here is the record's d plus one 0 is the owed assembly named in the L54 row", which `dpsi_split` and now `L54_rigidity_S20` discharge.
- Minor: [L167Statement.lean:50](../lean/HamiltonsCubic/Results/L167Statement.lean#L50) lists the three displays as "NOT typed here". That is true of the file, and a pointer to L167Mixed for the first would save a reader the search.

## 6. Style (D)

- No em dash and no backtick inside link text in the added markdown lines of either commit. Every edited row stays on one line.
- The new L167 row has no semicolon. The new L54 and L116 text adds none as a clause splice, and the L67 row's semicolons separate list items that carry commas. The splices still visible in the L54 row ("at any eigenbasis; 3/3", "null_zero_eigen; standard three axioms") and the L82 row ("> 1; and the feasible class") predate these commits.

## 7. Verdict

**CONFIRMED WITH GAPS.** Both theorems are sound and faithful to the record, and r1551's gaps are closed. Gaps:

1. [lean/INDEX.md:245](../lean/INDEX.md#L245): the L167 main row moved to `statement: typed` with two of L167's three displays owed, the overclaim r1551 gap 1 returned on L67.
2. [L116Witness.lean:25](../lean/HamiltonsCubic/Results/L116Witness.lean#L25) and [lean/INDEX.md:468](../lean/INDEX.md#L468): the untyped symmetries of `rankOne v` from r1551 gap 3 stay unnamed. Minor.
3. [L167.lean:15](../lean/HamiltonsCubic/Results/L167.lean#L15): the header still calls the parity argument untyped and without a type in the base layer.
4. [L54Rigid.lean:23](../lean/HamiltonsCubic/Results/L54Rigid.lean#L23): the header still calls the S²₀ assembly owed.

*Reviewer r1552, one reviewer, analysis only: hand derivations from the definitions, `lake build` and the axiom audit, no numerical screens run.*
