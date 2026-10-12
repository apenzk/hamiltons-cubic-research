# Review r1562: L167's second display at every n (commit 0a3b04aa) and r1559's repairs (commit 949c5a0e)

**Standfirst.** [L167Full.lean](../lean/HamiltonsCubic/Results/L167Full.lean) builds (one `show` linter warning at [L167Full.lean:70](../lean/HamiltonsCubic/Results/L167Full.lean#L70)) and audits 18/18 on the standard three, with no `sorry`, `admit` or `native_decide`. `stab_full` is L167's second display in coordinates at every n ≥ 4: a skew A commutes with the padded W_{ℂP²} under ρ(A) = [A, ·] exactly when its mixed block vanishes and its ℝ⁴ block lies in span(J₀, K₀, K₁, K₂), the ℝ^m block constrained only by skewness. Both directions are proved, with no hypothesis beyond 4 ≤ n and A skew. Commit 949c5a0e closes r1559's gaps 1 to 6. The gaps are downstream prose: L167Statement.lean's "not typed" list still calls the second display unstated, and three headers still assert the 𝔲(2) reading the row lists as owed.

| # | claim | verdict |
| --- | --- | --- |
| A-1a | `stab_full` states the second display: no mixed block, ℝ⁴ block in span(J₀, K₀, K₁, K₂), ℝ^m block free | **CONFIRMED** |
| A-1b | `NoMixed` is the right condition (both orders) | **CONFIRMED** (both orders stated, one order sufficing under skewness, so the condition is exact and harmless) |
| A-1c | `blk`, `pad` extract the first four coordinates of the layer's `Emb n` | **CONFIRMED** (`blk_apply`: blk A x y = A (emb x) (emb y)) |
| A-1d | `Wc_blk`: Wc n X = pad (Wc 4 (blk X)) | **CONFIRMED** (both sides carry the factor ½ from sq2⁻¹ squared, matched against `Wc_four`) |
| A-1e | the equivalence is exact, both directions, no hidden hypothesis | **CONFIRMED** |
| A-2 | L167 rows accurate, owed list complete, row stays partial | **CONFIRMED** |
| A-3 | 949c5a0e repairs r1559 gaps 1 to 6 | **CONFIRMED** |
| B | builds, standard axioms only | **CONFIRMED** |
| C | no remaining text calling the second display untyped at general n | **CONFIRMED WITH GAPS** (L167Statement.lean's "not typed" list, and 𝔲(2) asserted in three headers) |
| D | style of the markdown edits | **CONFIRMED** |

**Summary:** the theorem is L167's second display, exactly, and the gaps are four stale or overclaiming sentences in Lean headers.

## 1. Fidelity of stab_full

- **The statement.** [route-a.md](../findings/route-a.md), Lemma L167, second display: 𝔰𝔱𝔞𝔟(u) = 𝔲(2) ⊕ 𝔰𝔬(m) with u = W_{ℂP²} padded by zero from ℝ⁴ into ℝⁿ. [stab_full](../lean/HamiltonsCubic/Results/L167Full.lean#L162) reads ρ(A) commuting with u as [A, Wc n X] = Wc n [A, X] for every skew X, the reading r1559 confirmed (A-1c) at n = 4, and concludes `NoMixed A ∧ ∃ p q, blk A = p • J 0 + ∑ a, q a • K a`. The ℝ^m block is left constrained only by the hypothesis that A is skew, which is 𝔰𝔬(m). That is the display in coordinates, modulo the 𝔲(2) reading (section 2).
- **NoMixed.** [NoMixed](../lean/HamiltonsCubic/Results/L167Full.lean#L96) asks A i j = 0 and A j i = 0 for i in the first four and j outside. With [In4](../lean/HamiltonsCubic/Results/L167Mixed.lean#L28) as `(i : ℕ) < 4`, this is exactly the vanishing of the ℝ⁴ ⊗ ℝ^m block. Under skewness one order would suffice, so stating both loses nothing and the forward proof derives the second from the first through `hsk`.
- **blk and pad.** [Emb](../lean/HamiltonsCubic/Results/CP2Real.lean#L82) is the 0/1 matrix with Emb p x = 1 when p = x as naturals, so blk A = Embᵀ A Emb is the top-left 4 × 4 block (`blk_apply`), and pad B = Emb B Embᵀ places B there with zeros elsewhere (`pad_out`, `Emb_mul`, `mul_EmbT`). `blk_pad` uses `Emb_orth`, which needs 4 ≤ n, and that hypothesis is carried.
- **Wc_blk.** [Wc](../lean/HamiltonsCubic/Results/CP2Real.lean#L177) n X = Σ μ_a ⟨X, om a⟩ om a with om a = sq2⁻¹ pad(J a). `inner2_pad` moves the inner product to the block, giving Σ μ_a · ½ ⟨blk X, J_a⟩ pad(J_a), which is pad of [Wc_four](../lean/HamiltonsCubic/Results/L167Stab.lean#L33)'s form. Correct.
- **Forward direction.** The mixed rows die at X = om 0 by L167Mixed's argument, rerun on a general A: the right side vanishes off the block by `pad_out`, (om 0 · A) vanishes on rows outside the block by `om_out`, so (A · om 0) i l = 0 for i outside, and right-multiplying by om 0 with `om_sq'` gives −½ (A P) i j = −½ A i j for j inside. So A i j = 0 for i outside and j inside, and skewness gives the other order. With no mixed block, `noMixed_AE` gives A E = E blk A and Eᵀ A = blk A Eᵀ, so `br_pad` and `blk_br` carry the bracket through the block. Testing the hypothesis at X = pad Y and applying blk yields the hypothesis of `stab_so4` for blk A, which gives the span.
- **Converse.** No mixed block plus the span form: rewrite both sides through `Wc_blk`, `br_pad` and `blk_br`, and the identity is pad of `stab_so4`'s converse at blk X. Every skew X is handled, not only padded ones, because Wc n reads only blk X. Correct.
- **Hypotheses.** Only `hn : 4 ≤ n` and `hA : IsSkew A`. No hidden hypothesis. The forward direction bypasses `parity_splits` (the mixed block is killed directly, with the ℝ⁴ and ℝ^m parts unconstrained at that step), which is a legitimate and shorter route than the record's.

## 2. The L167 rows

- **Main row** ([lean/INDEX.md:248](../lean/INDEX.md#L248)). Accurate: `stab_full` is described as proved, its ingredients named correctly, and 18/18 matches the audit. The old owed item "the assembly at general n" is correctly dropped. The remaining owed list, the orbit dimension and the 𝔲(2) reading (J₀, K₀, K₁, K₂ independent, brackets closing), is complete for what route-a asserts. The orbit dimension additionally needs dim 𝔰𝔬(m) = C(m,2) of the free block and the orbit-stabiliser identification, both subsumed under "the orbit dimension as the dimension of the stabiliser's complement". **Partial is right**, since the third display and the 𝔲(2) isomorphism are open.
- **Statement row** ([lean/INDEX.md:249](../lean/INDEX.md#L249)). Accurate: names `stab_mixed_trivial`, `stab_so4` and `stab_full`, and narrows "not stated" to the third display.

## 3. Commit 949c5a0e against r1559's gaps

- **Gap 1 closed.** The L167 (statement) row names L167Stab.lean and `stab_so4`.
- **Gap 2 closed** in the row (the 𝔲(2) reading is owed, with independence and bracket closure named) and in the `stab_so4` docstring ([L167Stab.lean:143](../lean/HamiltonsCubic/Results/L167Stab.lean#L143), "which the record reads as"). The file's title line was left asserting it (section 4, gap 2).
- **Gap 3 closed.** The L262 row reads "statement: typed from the block relations as data", and the "σ/c; 2/2" splice is now two sentences.
- **Gap 4 closed.** [I117LemmaE.lean](../lean/HamiltonsCubic/Results/I117LemmaE.lean) names a single Casimir value on 𝔨, drops 𝔭 irreducible, and says the other two relations follow from the bracket supports with I#I = cI.
- **Gap 5 closed.** [lean/INDEX.md:29](../lean/INDEX.md#L29) no longer lists L141.
- **Gap 6 closed.** The [L141Statement.lean](../lean/HamiltonsCubic/Results/L141Statement.lean) splice is two sentences.

## 4. Downstream

- **Gap 1.** [L167Statement.lean:50](../lean/HamiltonsCubic/Results/L167Statement.lean#L50), "What is NOT typed here", still lists "the three displayed conclusions themselves (the first is proved in L167Mixed.lean)". The second is now proved in coordinates in L167Full.lean. The bullet should name `stab_full` beside `stab_mixed_trivial` and narrow to the third display.
- **Gap 2.** [L167Stab.lean:7](../lean/HamiltonsCubic/Results/L167Stab.lean#L7), the title, still reads "the stabiliser of W_{ℂP²} is 𝔲(2) = ℝJ₀ ⊕ Λ⁻", the unproved isomorphism r1559 gap 2 asked to be stated as owed. Its line 19 also says the 𝔰𝔬(m) summand is L167Statement's parity split and the padding, which is now L167Full's `stab_full`, and splices two clauses with a semicolon (pre-existing).
- **Gap 3.** [L167Full.lean:6](../lean/HamiltonsCubic/Results/L167Full.lean#L6), [:14](../lean/HamiltonsCubic/Results/L167Full.lean#L14) and the `stab_full` docstring at [:161](../lean/HamiltonsCubic/Results/L167Full.lean#L161) end on "𝔲(2) ⊕ 𝔰𝔬(m)" as proved. The theorem proves span(J₀, K₀, K₁, K₂) ⊕ 𝔰𝔬(m), and the row owes the 𝔲(2) reading. The same wording fix as `stab_so4`'s docstring ("which the record reads as") applies.
- **Minor.** [L167.lean](../lean/HamiltonsCubic/Results/L167.lean)'s "Elsewhere" paragraph names L167Statement and L167Mixed and omits L167Stab and L167Full. It calls nothing untyped, so it is an omission.
- [findings/INDEX-results.md](../findings/INDEX-results.md) row 167 and route-a.md make no Lean claims about the display and need nothing.

## 5. Style

- The added lines in lean/INDEX.md, STATUS.md and plan-lean.md carry no em dash and no backticks inside link text. The semicolons in the changed line 29 are pre-existing text re-emitted with the L141 deletion. No hard wrapping in the markdown rows.
- Cosmetic: the `show` at [L167Full.lean:70](../lean/HamiltonsCubic/Results/L167Full.lean#L70) changes the goal and trips the style linter, `change` would silence it.

## 6. Verdict

**CONFIRMED WITH GAPS.** `stab_full` is L167's second display at every n ≥ 4, exact in both directions, on the standard three axioms. The gaps are header prose (section 4, gaps 1 to 3) and none touches a proof.
