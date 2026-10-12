# REVIEW r1633: L131Lin.lean, first-slot linearity of # and L131's Lambda^4 entry on the span

**Verdict: CONFIRMED WITH GAPS.** The four theorems are correct, build, and rest on the standard three axioms. The gaps are in the surrounding record: the INDEX owed list asks for more than is still owed, and the finding does not cite the new file.

Reviewed: commit ff0f4720, [L131Lin.lean](../lean/HamiltonsCubic/Results/L131Lin.lean), the L131 row of [lean/INDEX.md](../lean/INDEX.md) (line 492), against [findings/isotropy-cap.md](../findings/isotropy-cap.md) Lemma L131 (lines 423 to 435).

## Claim table

| # | Claim | Verdict |
|---|---|---|
| 1 | `sharpCross_add_left`, `sharpCross_smul_left`, `sharpCross_sum_left`: `X ↦ X # Y` is additive, homogeneous and finitely linear at linear `X`, `X'`, `Y` | CONFIRMED |
| 2 | `sharpCross_lam4_span`: `(∑ c_t v_t) # I = 2 ∑ c_t v_t` on bivectors, for four-set elements at distinct indices, which is L131's fourth entry on all of Λ⁴ | CONFIRMED WITH GAPS |
| 3 | INDEX row L131: states the linearity and the Λ⁴ span accurately, the Weyl entry is `sharpCross_id` on every Weyl operator, and the owed list is accurate | CONFIRMED WITH GAPS |
| 4 | Axiom audit | CONFIRMED, 4/4 clean on the standard three |

## 1. Linearity

- `sharpCross` ([FoxProduct.lean:264](../lean/HamiltonsCubic/Base/FoxProduct.lean#L264)) is the polarisation of `sharpOp`, and `foxProd_split` ([FoxProduct.lean:270](../lean/HamiltonsCubic/Base/FoxProduct.lean#L270)) gives `X ∘ Y = jordanProd X Y + sharpCross X Y` at additive `X`, `Y`. The file writes `sharpCross = foxProd − jordanProd` and proves each half linear in `X`.
- Fox half: `foxProd_comm` moves `X + X'` to the second slot, and [FoxBilinear.lean:122](../lean/HamiltonsCubic/Base/FoxBilinear.lean#L122) and [FoxBilinear.lean:132](../lean/HamiltonsCubic/Base/FoxBilinear.lean#L132) supply additivity and homogeneity there. Both need `IsLinOp` on both slots, which is where `hX`, `hX'`, `hY` enter.
- Jordan half: `jordanProd (X + X') Y Z = ½((X + X')(Y Z) + Y(X Z + X' Z))`, linear in `X` using only `hY.1` (resp. `hY.2`), checked by hand against [FoxProduct.lean:259](../lean/HamiltonsCubic/Base/FoxProduct.lean#L259).
- Hypotheses: sufficient. They are stronger than needed only in the sense that `sharpOp` is built from `sharpBil`, whose own linearity requirements were left unexamined here. A hypothesis stronger than necessary is no defect, and every caller in the file discharges it (`lam4_lin`, identity).
- Empty sum: the case reduces `sharpCross (fun W => 0) Y Z = 0` to `sharpCross_smul_left 0 Y Y`, which reads `sharpCross (fun W => 0 • Y W) Y Z = 0 • sharpCross Y Y Z` and simplifies to the goal. Sound, and the build accepts it.
- Insert step: `hS` and `hcX` rebuild `IsLinOp` for the partial sum and the scaled term, then add, smul and the induction hypothesis close it. Sound.

## 2. The Λ⁴ span

- `lam4 i j k l = φ_ij ⊙ φ_kl + φ_ki ⊙ φ_jl + φ_il ⊙ φ_jk` with `rk2 U V X = ⟨V,X⟩U + ⟨U,X⟩V` ([L121Block.lean:102](../lean/HamiltonsCubic/Results/L121Block.lean#L102)). Since `φ_ki = −φ_ik`, this is `(ij)(kl) − (ik)(jl) + (il)(jk)`, the standard embedding of `e_i ∧ e_j ∧ e_k ∧ e_l` in `S²Λ²`. Its coefficients `R_ijkl = 1`, `R_ikjl = −1`, `R_iljk = 1` are totally antisymmetric, checked by hand on a transposition and a 3-cycle.
- Over `i < j < k < l` the elements have disjoint supports, so they are independent and there are `C(n,4)` of them: a basis of Λ⁴. Every other distinct-index choice is ± one of them. So the span of the theorem's family is exactly Λ⁴, and `sharpCross_lam4_span` holds on all of it, the sum being arbitrary over a finite index set.
- Gap 2a: the identification "span of `lam4` = Λ⁴" is prose ([L131Lin.lean:17-18](../lean/HamiltonsCubic/Results/L131Lin.lean#L17)), since the layer has no Λ⁴ predicate. "On the whole span" is the honest Lean statement, and the INDEX's "on all of Λ⁴" is correct as a reading of it. The row should say the identification is by hand, as [L131Four.lean:15](../lean/HamiltonsCubic/Results/L131Four.lean#L15) already does for the orthogonality to the Bianchi cut.
- The statement is on bivectors (`IsSkew Z`), matching L131's operators on Λ². At `n < 4` the family is empty and the statement vacuous, as Λ⁴ = 0.

## 3. The INDEX row

- The linearity and span sentences match the file. No overclaim there.
- Weyl entry: `sharpCross_id` ([L131Sharp.lean:104](../lean/HamiltonsCubic/Results/L131Sharp.lean#L104)) takes `IsWeyl W` and gives `W # I = −W` on every bivector. The row's "the Weyl entry is `sharpCross_id` on every Weyl operator" is accurate, and it already covers the whole summand.
- Gap 3a, owed list asks for too much: it owes "that each Bianchi summand is spanned by frame images of these representatives". For `Weyl_n` the entry is already whole-summand through `sharpCross_id`, and for `ℝ·Id` the summand is one-dimensional, so `eig_scalar` plus `sharpCross_smul_left` reaches it once `eig_scalar` is lifted from the basis `φ_ab` ([L131Diag.lean:133](../lean/HamiltonsCubic/Results/L131Diag.lean#L133)) to every bivector. What remains owed by frame images is `S²₀` alone. The row should name `S²₀` and record the scalar entry's lift in `Z` as the remaining small step.
- Gap 3b: `eig_weyl`, `eig_ricci`, `eig_scalar` are stated on `φ_ab`, whereas `sharpCross_four_id`, `sharpCross_lam4_span` and `sharpCross_id` are stated on every skew `Z`. The row does not note this asymmetry, which a reader needs to know before combining the entries.
- The owed items "Weyl_n is the whole −1 eigenspace", "identification of A on the other summands" and the `Ric(R) ∧ id` identity are correctly listed as open. `A` has no Lean operator, so the row's "read against `aW2` by hand" is the honest wording.

## 4. Axioms and build

- `lake build HamiltonsCubic.Results.L131Lin`: completed successfully, no `sorry`, no warning located in L131Lin.lean.
- `python3 scripts/misc/axiom_audit.py --only L131Lin`: 4/4 clean, standard three only. No `native_decide`.

## 5. Record

- Gap 5a: [findings/isotropy-cap.md:433](../findings/isotropy-cap.md) cites L131Four for the fourth entry "on the four-set elements that span Λ⁴" and has no citation of L131Lin, which is what carries it from the spanning elements to the summand. `findings/INDEX.md` and `results.md` also have no mention.

## What would break each claim, and what was done to look for it

| Claim | Breaking object | Search |
|---|---|---|
| 1 | a nonlinear `X` with `(X + X') # Y ≠ X # Y + X' # Y` admitted by the hypotheses, or a `jordanProd` term needing `X` additive where only `Y` is assumed | read the definitions of `sharpCross`, `foxProd`, `jordanProd`, `IsLinOp`, and the two FoxBilinear lemmas, rederived the Jordan half by hand, built the file |
| 1, empty case | `fun W => ∑ ∅ ...` failing to reduce to `fun W => 0` | read the case, build accepted it |
| 2 | a `lam4` whose coefficients fail total antisymmetry (sign error on `φ_ki`), making the span a different subspace of `S²Λ²` | expanded `lam4` via `rk2` and `phi_swap`, checked the sign on a transposition and a 3-cycle, checked independence by disjoint support |
| 3 | an INDEX sentence asserting a whole-summand result that Lean holds only on representatives | compared each sentence to the statements of `sharpCross_id`, `eig_*`, `sharpCross_four_id`, `sharpCross_lam4_span` |
| 4 | a `sorryAx` or `native_decide` in the dependency cone | axiom audit and build |

All checks here are hand derivations plus one build and one audit of objects in hand, no sweep.
