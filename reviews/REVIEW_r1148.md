# REVIEW r1148: Gate 2 on the Lean for L240 piece (a)

Brief: [2026-09-25-L240a-gate2-brief.md](2026-09-25-L240a-gate2-brief.md). File under review: [L240NormalForm.lean](../lean/HamiltonsCubic/Results/L240NormalForm.lean) at HEAD (commits abbb91dc, be0b79fa, f6092224). Givens read: `NormalForm`, `NormalForm.X`, `slotμ` and `slot_kyFan` in [L240SlotBasis.lean](../lean/HamiltonsCubic/Results/L240SlotBasis.lean), and `IsSkew`, `inner2`, `br`, `phi` in [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean).

## Verdicts

| item | verdict |
|---|---|
| 1. declarations state their claims | CONFIRMED, with one cosmetic correction (a spurious `[LinearOrder ι]` on `skew_normal_form`) |
| 2. `kyFan_conj` composes with `skew_normal_form` | CONFIRMED, the composite elaborates in two lines |
| 3. build and axiom audit | CONFIRMED, build exit 0, 20/20 theorems on the standard three axioms |
| 4. docstring and INDEX row | CONFIRMED, with one wording note |

## Item 1

- **Conjugation lemmas.** `isSkew_conj` needs no orthogonality and states none, which is correct since `(OᵀYO)ᵀ = OᵀYᵀO`. `inner2_conj` and `br_conj` take only `O Oᵀ = 1`, which is the identity each proof uses (the middle `O Oᵀ` collapses, and the trace step rotates `Oᵀ` to the right). No weakening.
- **Pair step.** `pair_f_unit`, `pair_Xf`, `pair_Xe`, `pair_compl_invariant` carry exactly the brief's hypotheses (skew, unit `e`, `s > 0`, `X(Xe) = -s²e`). `pair_ef_orth` needs only skewness and states only that. `pair_compl_invariant` states invariance of `{e,f}^⊥` pointwise (orthogonality to `e` and `f` passes from `w` to `Xw`), which is the claim.
- **exists_pair.** Signature `T ≠ 0 → ∃ e, ‖e‖ = 1 ∧ ∃ s, 0 < s ∧ T (T e) = -s ^ 2 • e`, with skew-adjointness as `inner (T x) y = -inner x (T y)`. This is the claim. The nonzero eigenvalue of `-T²` is `‖Te‖² > 0`, as the proof shows.
- **skew_decomp.** The printed signature is `∀ (d : ℕ) (E : Type u_1) [...] , finrank E = d → ∀ T, skew-adjoint T → ∃ κ μ (Fintype κ) (Fintype μ) b s, ...`. The universe of `E` is a free variable `u_1`, so it instantiates at `EuclideanSpace ℝ ι` for `ι : Type u_1`, and the strong induction recurses on the subtype of a submodule of `E`, which lives in the same universe. The index types `κ μ : Type` sit in universe 0, which is sound because they appear only under the existential, and `Fintype.equivOfCardEq` in `skew_normal_form` is a cross-universe equivalence. Nothing is vacuous: the conclusion demands an orthonormal basis of all of `E`.
- **skew_normal_form, construction of N.** `p c = σ (inl (τ⁻¹ c))`, `q c = σ (inr (inl (τ⁻¹ c)))` with `σ : κ ⊕ κ ⊕ μ ≃ ι` and `τ : κ ≃ Fin (card κ)`. The three fields `hp`, `hq`, `hpq` are proved from injectivity of `σ`, `τ⁻¹` and the constructors, so they hold by construction. The theorem has no hypothesis beyond `IsSkew X`.
- **Sign of s.** `NormalForm.s : Fin k → ℝ` carries no sign condition, and `skew_normal_form` exports none. The values produced are in fact positive (they come from `exists_pair`), but the statement does not expose it, which is what piece (b) needs.
- **Orientation check by hand.** `phi i j = single j i 1 - single i j 1` sends `e_i ↦ e_j` and `e_j ↦ -e_i`, so `N.X e_{p_c} = s_c e_{q_c}`. With `O e_{σ y} = B y` (columns of `O` are the basis), `Oᵀ X O e_{p_c} = Oᵀ (s_c B(inr inl c)) = s_c e_{q_c}`, matching `h1`. The conclusion `X = O N.X Oᵀ` carries the right orientation.
- **Correction (cosmetic).** `skew_normal_form` is declared inside `section conj`, whose `variable [LinearOrder ι]` is auto-included because `ι` is. The elaborated signature is `∀ {ι} [Fintype ι] [DecidableEq ι] [LinearOrder ι] (X : Matrix ι ι ℝ), IsSkew X → ...`. The instance is unused in the statement and proof, and `set_option linter.unusedSectionVars false` hides the warning. It is harmless for every use in view (`Fin n` has the order, and `kyFan_conj` needs it anyway), but the theorem as stated is less general than its docstring. Moving it and `eucl`, `ofLp_eucl`, `real_inner_eucl`, `eucl_skew` ahead of the `LinearOrder` variable, or into their own section, would fix it. The same auto-inclusion plausibly reaches `eucl`, `ofLp_eucl`, `real_inner_eucl` and `eucl_skew`, which sit after the same `variable` line. Only `skew_normal_form`'s signature was printed.

## Item 2

The composite, checked by elaboration against the built module at `ι = Fin n`:

```lean
example (n : ℕ) (X : Matrix (Fin n) (Fin n) ℝ) (hX : IsSkew X) :
    ∃ (k : ℕ) (N : NormalForm (Fin n) k), ∀ {r : ℕ} (y : Fin r → Matrix (Fin n) (Fin n) ℝ),
      (∀ j, IsSkew (y j)) → (∀ i j, inner2 (y i) (y j) = if i = j then 1 else 0) → ∀ c : ℝ,
      ∑ j, inner2 (y j) (-br X (br X (y j))) ≤ r * c + ∑ ij, max (slotμ N ij - c) 0 := by
  obtain ⟨k, N, O, h1, h2, h3⟩ := skew_normal_form X hX
  exact ⟨k, N, fun y hyS hy c => kyFan_conj N h1 h2 h3 y hyS hy c⟩
```

It compiles with no error. Nothing is missing for the composite as stated. Two points a downstream user should know:

- The composite is not a declared theorem in the file. The docstring's "with `kyFan_conj` Ky Fan holds at every real skew matrix" is delivered by the two-line composition above, not by a named declaration.
- The bound is over `slotμ N` for the `N` the existential produces. The layer does not state that `slotμ N` are the eigenvalues of `-ad_X²` at `X` itself, nor relate `N.s` to the singular values of `X` beyond `X = O N.X Oᵀ`. Pieces (c) to (e) will have to read the `s_c` off through that conjugation.

## Item 3

- `lake build HamiltonsCubic.Results.L240NormalForm` (background, from `lean/`): "Build completed successfully (8736 jobs)", exit 0. No `sorry` in the log. Warnings are lint only: one long line (line 15), unused `[DecidableEq ι]` on the matrix-free lemmas, two unused simp arguments at line 264.
- `python3 scripts/misc/axiom_audit.py --only L240NormalForm`: "auditing 20 declarations across 1 files, 20/20 clean -- resting on the standard three alone". The file has 20 theorems plus the definition `eucl`, so every theorem was found.

## Item 4

- The file docstring claims steps A1 to A4 and "Piece (a) is done". Every named step exists with the stated content, and the claim holds.
- The [lean/INDEX.md](../lean/INDEX.md) L240 row lists `isSkew_conj`, `inner2_conj`, `br_conj`, `kyFan_conj`, `exists_pair`, `skew_decomp`, `eucl`, `eucl_skew`, `skew_normal_form` with correct descriptions, keeps the row at **partial**, and names (c), (d), (e) as still owed. That is accurate.
- Wording note: "so Ky Fan holds at every skew X" in both places is true through the composition of item 2, which no declaration names. A named corollary (the `example` above) would make the sentence point at something the audit can check.
