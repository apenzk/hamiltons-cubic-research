import HamiltonsCubic.Results.L159Spin7

set_option linter.style.longLine false

/-!
# `dim 𝔰𝔭𝔦𝔫(7) = 21`

[graded-half.md](../../../findings/graded-half.md), Lemma L159's `n = 8` case, takes `𝔰𝔭𝔦𝔫(7) ⊂ 𝔰𝔬(8)` with `dim = 21`, so
that an invariant `k`-plane with `2 ≤ k ≤ 6` would put it inside `𝔰𝔬(k) ⊕ 𝔰𝔬(8 − k)`, of smaller dimension.

- **`Lz_gram`**: the `21` products `L_i L_j`, `i < j`, are Frobenius-orthogonal of square norm `8`, by `decide`;
- `Pr`, `card_Pr`, `G`, `gram`, **`G_linearIndependent`**: so they are linearly independent over `ℝ`;
- `L_anticomm`, **`spin7_eq_span`**: `[L_i, L_j] = 2 L_i L_j` for `i ≠ j`, so they span
  [L159Spin7.lean](L159Spin7.lean)'s `spin7`;
- **`finrank_spin7`**: `dim 𝔰𝔭𝔦𝔫(7) = 21`.
-/

namespace HamiltonsCubic.Spin7

open Module

/-- **The Frobenius Gram matrix of the `L_i L_j`, `i < j`**, is `8` times the identity. -/
theorem Lz_gram : ∀ i j k l : Fin 7, i < j → k < l →
    Matrix.trace ((Lz i * Lz j) * (Lz k * Lz l).transpose) = if i = k ∧ j = l then 8 else 0 := by
  decide

/-- The index set `{(i, j) : i < j}`. -/
abbrev Pr := {p : Fin 7 × Fin 7 // p.1 < p.2}

theorem card_Pr : Fintype.card Pr = 21 := by decide

/-- The generator `L_i L_j` for `i < j`. -/
def G (p : Pr) : Matrix (Fin 8) (Fin 8) ℝ := L p.1.1 * L p.1.2

theorem gram (p q : Pr) : Matrix.trace (G p * (G q).transpose) = if p = q then 8 else 0 := by
  have e : G p * (G q).transpose =
      (Lz p.1.1 * Lz p.1.2 * (Lz q.1.1 * Lz q.1.2).transpose).map (Int.castRingHom ℝ) := by
    simp only [G, L, RingHom.mapMatrix_apply, Matrix.map_mul, Matrix.transpose_map]
  rw [e, ← AddMonoidHom.map_trace, Lz_gram _ _ _ _ p.2 q.2]
  have hpq : p = q ↔ (p.1.1 = q.1.1 ∧ p.1.2 = q.1.2) := by rw [Subtype.ext_iff, Prod.ext_iff]
  by_cases h : p = q
  · rw [if_pos (hpq.mp h), if_pos h]; simp
  · rw [if_neg (fun h' => h (hpq.mpr h')), if_neg h]; simp

theorem G_linearIndependent : LinearIndependent ℝ G := by
  rw [Fintype.linearIndependent_iff]
  intro c hc q
  have h := congrArg (fun X => Matrix.trace (X * (G q).transpose)) hc
  simp only [Finset.sum_mul, Matrix.trace_sum, Matrix.smul_mul, Matrix.trace_smul, gram, smul_eq_mul, mul_ite,
    mul_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true, Matrix.zero_mul, Matrix.trace_zero] at h
  linarith

/-- The anticommutation `L_j L_i = −L_i L_j` for `i ≠ j`. -/
theorem L_anticomm {i j : Fin 7} (hij : i ≠ j) : L j * L i = -(L i * L j) := by
  have h := congrArg (Int.castRingHom ℝ).mapMatrix (Lz_clifford i j)
  rw [if_neg hij, map_add, map_mul, map_mul, map_zero] at h
  exact eq_neg_of_add_eq_zero_right h

/-- **`𝔰𝔭𝔦𝔫(7)` is spanned by the `21` products `L_i L_j`, `i < j`.** -/
theorem spin7_eq_span : spin7 = Submodule.span ℝ (Set.range G) := by
  apply le_antisymm
  · refine Submodule.span_le.2 ?_
    rintro _ ⟨⟨a, b⟩, rfl⟩
    rcases lt_trichotomy a b with h | rfl | h
    · have : L a * L b - L b * L a = (2 : ℝ) • G ⟨(a, b), h⟩ := by
        rw [L_anticomm h.ne, G, sub_neg_eq_add, two_smul]
      rw [SetLike.mem_coe]; dsimp only; rw [this]
      exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨_, rfl⟩)
    · simp
    · have : L a * L b - L b * L a = (-2 : ℝ) • G ⟨(b, a), h⟩ := by
        rw [L_anticomm h.ne, G, neg_smul, two_smul]; abel
      rw [SetLike.mem_coe]; dsimp only; rw [this]
      exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨_, rfl⟩)
  · refine Submodule.span_le.2 ?_
    rintro _ ⟨p, rfl⟩
    have : G p = (1 / 2 : ℝ) • (L p.1.1 * L p.1.2 - L p.1.2 * L p.1.1) := by
      rw [L_anticomm p.2.ne, G, sub_neg_eq_add, ← two_smul ℝ, smul_smul]; norm_num
    rw [SetLike.mem_coe, this]
    exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨(p.1.1, p.1.2), rfl⟩)

/-- **`dim 𝔰𝔭𝔦𝔫(7) = 21`.** -/
theorem finrank_spin7 : finrank ℝ spin7 = 21 := by
  rw [spin7_eq_span, finrank_span_eq_card G_linearIndependent, card_Pr]

end HamiltonsCubic.Spin7
