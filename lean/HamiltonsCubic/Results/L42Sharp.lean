import HamiltonsCubic.Results.L42Statement

set_option linter.style.longLine false

/-!
# L42, the constant cannot be improved: the witness at every `k ≥ 3`

[findings/stratum-two-negative.md](../../../findings/stratum-two-negative.md), Lemma L42:
`3 M(λ_P) ≤ h (s² − u)`, and **the constant cannot be improved**.

[L42Statement.lean](L42Statement.lean)'s `sharp_dual_weight` proves the bound. **This file proves
the sharpness against the same objects**: at `k` equal positives `λ ≡ 1` with the weight
`t = 2/(k−2)` on every triple of distinct indices, `t` is `Feasible` (every pair cap holds with
equality, `(k−2) · 2/(k−2) = 2`), any three distinct indices are `ThreeLargest`, and
`3 · objective t λ = h (s² − u)` exactly, both sides being `k(k−1)` (`sharp_witness`). So no
constant smaller than `h` works at any `k ≥ 3`.
-/

namespace HamiltonsCubic.L42Statement

open Finset

variable {k : ℕ}

/-- The witness weight: `2/(k−2)` on every triple of distinct indices. -/
noncomputable def witnessT (k : ℕ) : Fin k → Fin k → Fin k → ℝ := fun α β γ =>
  if α ≠ β ∧ α ≠ γ ∧ β ≠ γ then 2 / ((k : ℝ) - 2) else 0

/-- Two excluded indices leave `k − 2`. -/
theorem card_two_excluded {α β : Fin k} (h : α ≠ β) :
    ((univ : Finset (Fin k)).filter fun γ => γ ≠ α ∧ γ ≠ β).card = k - 2 := by
  have e : ((univ : Finset (Fin k)).filter fun γ => γ ≠ α ∧ γ ≠ β) = (univ.erase α).erase β := by
    ext γ; simp [and_comm]
  rw [e, card_erase_of_mem (by simp [Ne.symm h]), card_erase_of_mem (mem_univ _), card_univ,
    Fintype.card_fin]
  omega

/-- The inner sum over the third index. -/
theorem sum_third {α β : Fin k} (c : ℝ) :
    (∑ γ : Fin k, if α ≠ β ∧ α ≠ γ ∧ β ≠ γ then c else 0)
      = if α ≠ β then ((k : ℝ) - 2) * c else 0 := by
  by_cases h : α ≠ β
  · rw [if_pos h, ← Finset.sum_filter]
    have e : ((univ : Finset (Fin k)).filter fun γ => α ≠ β ∧ α ≠ γ ∧ β ≠ γ)
        = (univ.filter fun γ => γ ≠ α ∧ γ ≠ β) := by
      ext γ; simp only [mem_filter, mem_univ, true_and]
      constructor
      · rintro ⟨-, h1, h2⟩; exact ⟨Ne.symm h1, Ne.symm h2⟩
      · rintro ⟨h1, h2⟩; exact ⟨h, Ne.symm h1, Ne.symm h2⟩
    rw [e, sum_const, card_two_excluded h, nsmul_eq_mul]
    have hk : 2 ≤ k := by
      have := Fintype.card_le_of_injective ![α, β] (by
        intro i j hij; fin_cases i <;> fin_cases j <;> simp_all [Ne.symm h])
      simpa using this
    rw [Nat.cast_sub hk]; push_cast; ring
  · rw [if_neg h]
    exact sum_eq_zero fun γ _ => if_neg fun hh => h hh.1

theorem witness_feasible (hk : 3 ≤ k) : Feasible (witnessT k) where
  nonneg α β γ := by
    unfold witnessT; split_ifs
    · have : (0 : ℝ) < (k : ℝ) - 2 := by
        have : (3 : ℝ) ≤ k := by exact_mod_cast hk
        linarith
      positivity
    · exact le_refl 0
  symm12 α β γ := by
    unfold witnessT
    congr 1; apply propext; constructor <;> rintro ⟨h1, h2, h3⟩ <;> exact ⟨Ne.symm h1, h3, h2⟩
  symm23 α β γ := by
    unfold witnessT
    congr 1; apply propext; constructor <;> rintro ⟨h1, h2, h3⟩ <;> exact ⟨h2, h1, Ne.symm h3⟩
  pairCap α β hab := by
    have e : ∀ γ ∈ (univ : Finset (Fin k)).filter (fun γ => γ ≠ α ∧ γ ≠ β),
        witnessT k α β γ = 2 / ((k : ℝ) - 2) := by
      intro γ hγ
      simp only [mem_filter, mem_univ, true_and] at hγ
      unfold witnessT; rw [if_pos ⟨hab, Ne.symm hγ.1, Ne.symm hγ.2⟩]
    rw [sum_congr rfl e, sum_const, card_two_excluded hab, nsmul_eq_mul, Nat.cast_sub (by omega)]
    have : (0 : ℝ) < (k : ℝ) - 2 := by
      have : (3 : ℝ) ≤ k := by exact_mod_cast hk
      linarith
    push_cast
    rw [mul_div_cancel₀ _ this.ne']

/-- **The bound is attained at every `k ≥ 3`**: `3 · objective = h (s² − u)` at the witness,
both sides `k(k − 1)`, with `a, b, c` any three distinct indices. -/
theorem sharp_witness (hk : 3 ≤ k) (a b c : Fin k) (hab : a ≠ b) (hbc : b ≠ c) (hac : a ≠ c) :
    Feasible (witnessT k) ∧ ThreeLargest (fun _ : Fin k => (1 : ℝ)) a b c ∧
      3 * objective (witnessT k) (fun _ => 1)
        = harmonicMean 1 1 1 * ((∑ _i : Fin k, (1 : ℝ)) ^ 2 - ∑ _i : Fin k, (1 : ℝ) ^ 2) := by
  have hk3 : (3 : ℝ) ≤ k := by exact_mod_cast hk
  have hne : (k : ℝ) - 2 ≠ 0 := by linarith
  refine ⟨witness_feasible hk, ⟨hab, hbc, hac, fun _ _ _ _ => by simp⟩, ?_⟩
  have h6 := distinctSum_eq_six (fun α β γ => witnessT k α β γ * (1 * 1 * 1))
    (fun α β γ => by rw [(witness_feasible hk).symm12 α β γ])
    (fun α β γ => by rw [(witness_feasible hk).symm23 α β γ])
  rw [← objective_eq_increasingSum] at h6
  have hd : distinctSum (fun α β γ => witnessT k α β γ * (1 * 1 * 1))
      = (k : ℝ) * ((k : ℝ) - 1) * 2 := by
    unfold distinctSum witnessT
    have : ∀ α β : Fin k, (∑ γ : Fin k, if α ≠ β ∧ α ≠ γ ∧ β ≠ γ then
        (if α ≠ β ∧ α ≠ γ ∧ β ≠ γ then 2 / ((k : ℝ) - 2) else 0) * (1 * 1 * 1) else 0)
        = if α ≠ β then 2 else 0 := by
      intro α β
      rw [show (∑ γ : Fin k, if α ≠ β ∧ α ≠ γ ∧ β ≠ γ then
          (if α ≠ β ∧ α ≠ γ ∧ β ≠ γ then 2 / ((k : ℝ) - 2) else 0) * (1 * 1 * 1) else 0)
          = ∑ γ : Fin k, if α ≠ β ∧ α ≠ γ ∧ β ≠ γ then 2 / ((k : ℝ) - 2) else 0 from
        sum_congr rfl fun γ _ => by split_ifs <;> simp]
      rw [sum_third]
      split_ifs <;> field_simp
    simp only [this]
    have hβ : ∀ α : Fin k, (∑ β : Fin k, if α ≠ β then (2 : ℝ) else 0) = ((k : ℝ) - 1) * 2 := by
      intro α
      rw [← Finset.sum_filter, sum_const, nsmul_eq_mul]
      have : ((univ : Finset (Fin k)).filter fun β => α ≠ β) = univ.erase α := by
        ext β; simp [eq_comm]
      rw [this, card_erase_of_mem (mem_univ _), card_univ, Fintype.card_fin,
        Nat.cast_sub (by omega)]
      push_cast; ring
    simp only [hβ, sum_const, card_univ, Fintype.card_fin, nsmul_eq_mul]
    ring
  rw [hd] at h6
  unfold harmonicMean
  simp only [sum_const, card_univ, Fintype.card_fin, nsmul_eq_mul, one_pow, mul_one]
  have : objective (witnessT k) (fun _ => 1) = (k : ℝ) * ((k : ℝ) - 1) / 3 := by linarith
  rw [this]
  field_simp
  ring

end HamiltonsCubic.L42Statement
