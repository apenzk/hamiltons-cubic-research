import HamiltonsCubic.Results.CP2Real

set_option linter.style.longLine false

/-!
# L167's first display: the competitor's stabiliser meets the mixed block trivially

[findings/route-a.md](../../../findings/route-a.md), Lemma L167: with `u` the padded `W_{ℂP²}` on `ℝⁿ`,
`𝔰𝔱𝔞𝔟(u) ∩ (ℝ⁴ ⊗ ℝ^m) = 0`. [L167Statement.lean](L167Statement.lean) proves the ingredients (the parity split, the
corrected `ω² = -½‖ω‖² Id`, the dimension count). **This file proves the display** at the layer's `Wc`
([CP2Real.lean](CP2Real.lean)), `ρ(A)X = [A, X]` being the derivation action on bivectors:

* **`om_out`**: `om a` vanishes off the first four coordinates;
* **`Wc_mixed`**: `Wc` kills every matrix vanishing on the `ℝ⁴ × ℝ⁴` block, the padding;
* **`br_mixed`**: for `A` mixed, `[A, om 0]` is mixed;
* **`stab_mixed_trivial`**: a mixed skew `A` with `[A, Wc X] = Wc [A, X]` for every skew `X` is zero, by the block's proof:
  at `X = om 0` the right side vanishes and the left is `μ₀[A, om 0]`, and `om 0 · om 0 = -½` on the block makes the
  mixed rows of `A` vanish.
-/

namespace HamiltonsCubic.CP2Real

open Finset Matrix HamiltonsCubic.RealLayer

variable {n : ℕ}

/-- The first four coordinates. -/
abbrev In4 (i : Fin n) : Prop := (i : ℕ) < 4

instance (i : Fin n) : Decidable (In4 i) := inferInstanceAs (Decidable ((i : ℕ) < 4))

/-- `A` lives on the mixed block `ℝ⁴ ⊗ ℝ^m`. -/
abbrev IsMixed (A : Matrix (Fin n) (Fin n) ℝ) : Prop := ∀ i j, (In4 i ↔ In4 j) → A i j = 0

theorem Emb_out {i : Fin n} (hi : ¬ In4 i) (x : Fin 4) : Emb n i x = 0 := by
  unfold Emb In4 at *; rw [if_neg]; intro h; exact hi (h ▸ x.2)

theorem om_out (a : Fin 3) (i j : Fin n) (h : ¬ (In4 i ∧ In4 j)) : om a i j = 0 := by
  simp only [om, Matrix.smul_apply, smul_eq_mul, Matrix.mul_apply, Matrix.transpose_apply]
  rcases not_and_or.mp h with hi | hj
  · simp [Emb_out hi]
  · simp [Emb_out hj]

/-- **`Wc` kills everything vanishing on the `ℝ⁴ × ℝ⁴` block.** -/
theorem Wc_mixed (Y : Matrix (Fin n) (Fin n) ℝ) (hY : ∀ i j, In4 i → In4 j → Y i j = 0) : Wc n Y = 0 := by
  apply Wc_perp
  intro a
  rw [inner2_eq_sum]
  have : ∀ i j, Y i j * om a i j = 0 := fun i j => by
    by_cases h : In4 i ∧ In4 j
    · rw [hY i j h.1 h.2, zero_mul]
    · rw [om_out a i j h, mul_zero]
  simp [this]

/-- **`[A, om 0]` is mixed** when `A` is. -/
theorem br_mixed (A : Matrix (Fin n) (Fin n) ℝ) (hA : IsMixed A) (i j : Fin n) (hi : In4 i) (hj : In4 j) :
    (A * om (n := n) 0 - om (n := n) 0 * A) i j = 0 := by
  simp only [Matrix.sub_apply, Matrix.mul_apply]
  have h1 : ∀ k, A i k * om 0 k j = 0 := fun k => by
    by_cases hk : In4 k
    · rw [hA i k (iff_of_true hi hk), zero_mul]
    · rw [om_out 0 k j (fun h => hk h.1), mul_zero]
  have h2 : ∀ k, om 0 i k * A k j = 0 := fun k => by
    by_cases hk : In4 k
    · rw [hA k j (iff_of_true hk hj), mul_zero]
    · rw [om_out 0 i k (fun h => hk h.2), zero_mul]
  simp [h1, h2]

/-- `om 0 · om 0 = -½ P`, `P` the projector onto the first four coordinates. -/
theorem om_sq' (hn : 4 ≤ n) : om (n := n) 0 * om 0 = (-(sq2⁻¹ * sq2⁻¹)) • (Emb n * (Emb n)ᵀ) := by
  have h := om_sq hn 0
  have hs : (om (n := n) 0)ᵀ = -om 0 := om_skew 0
  rw [hs, Matrix.neg_mul] at h
  rw [neg_smul, ← h, neg_neg]

theorem EmbEmbT_apply (i j : Fin n) :
    (Emb n * (Emb n)ᵀ) i j = if i = j ∧ In4 i then 1 else 0 := by
  simp only [Matrix.mul_apply, Matrix.transpose_apply, Emb, In4, mul_ite, mul_one, mul_zero]
  by_cases hi : (i : ℕ) < 4
  · rw [Finset.sum_eq_single (⟨i, hi⟩ : Fin 4)]
    · by_cases hij : i = j
      · subst hij; simp [hi]
      · have : (j : ℕ) ≠ i := fun h => hij (Fin.ext h.symm)
        simp [hij, this]
    · intro x _ hx
      have : (i : ℕ) ≠ x := fun h => hx (Fin.ext h.symm)
      simp [this]
    · simp
  · have : ∀ x : Fin 4, (i : ℕ) ≠ x := fun x h => hi (h ▸ x.2)
    simp [this, hi]

/-- **L167's first display**: a mixed skew `A` whose derivation action commutes with `Wc` is zero. -/
theorem stab_mixed_trivial (hn : 4 ≤ n) (A : Matrix (Fin n) (Fin n) ℝ) (hA : IsMixed A) (hAs : IsSkew A)
    (hstab : ∀ X, IsSkew X → A * Wc n X - Wc n X * A = Wc n (A * X - X * A)) : A = 0 := by
  -- at `X = om 0`: `μ₀ [A, om 0] = Wc [A, om 0] = 0`
  have hc : A * om (n := n) 0 - om (n := n) 0 * A = 0 := by
    have h := hstab (om 0) (om_skew 0)
    rw [Wc_om hn 0, Wc_mixed _ (br_mixed A hA), Matrix.mul_smul, Matrix.smul_mul, ← smul_sub] at h
    have hmu : mu 0 ≠ 0 := by
      simp only [mu, Matrix.cons_val_zero]; positivity
    exact (smul_eq_zero.mp h).resolve_left hmu
  -- so for `i ∉ ℝ⁴`, `Σ_k A i k om0 k j = 0`, and multiplying by `om 0` again gives `-½ A i j = 0` for `j ∈ ℝ⁴`
  have hrow : ∀ i j, ¬ In4 i → In4 j → A i j = 0 := by
    intro i j hi hj
    have hAom : ∀ l, (A * om (n := n) 0) i l = 0 := fun l => by
      have := congrFun (congrFun hc i) l
      simp only [Matrix.sub_apply, Matrix.zero_apply] at this
      have h0 : (om (n := n) 0 * A) i l = 0 := by
        simp only [Matrix.mul_apply]
        exact Finset.sum_eq_zero fun k _ => by rw [om_out 0 i k (fun h => hi h.1), zero_mul]
      linarith
    set o : Matrix (Fin n) (Fin n) ℝ := om 0 with ho
    have h2 : (A * o * o) i j = 0 := by
      rw [Matrix.mul_apply]
      exact Finset.sum_eq_zero fun l _ => by rw [hAom l, zero_mul]
    rw [Matrix.mul_assoc, ho, om_sq' hn, Matrix.mul_smul, Matrix.smul_apply, smul_eq_mul] at h2
    have hP : (A * (Emb n * (Emb n)ᵀ)) i j = A i j := by
      rw [Matrix.mul_apply, Finset.sum_eq_single j]
      · rw [EmbEmbT_apply, if_pos ⟨rfl, hj⟩, mul_one]
      · intro k _ hk; rw [EmbEmbT_apply, if_neg (fun h => hk h.1), mul_zero]
      · simp
    rw [hP] at h2
    have hc0 : -(sq2⁻¹ * sq2⁻¹) ≠ 0 := by
      have := sq2_pos
      exact neg_ne_zero.mpr (mul_ne_zero (inv_ne_zero this.ne') (inv_ne_zero this.ne'))
    exact (mul_eq_zero.mp h2).resolve_left hc0
  ext i j
  rw [Matrix.zero_apply]
  by_cases hi : In4 i <;> by_cases hj : In4 j
  · exact hA i j (iff_of_true hi hj)
  · have := congrFun (congrFun hAs i) j
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    rw [hrow j i hj hi] at this; linarith
  · exact hrow i j hi hj
  · exact hA i j (iff_of_false hi hj)

end HamiltonsCubic.CP2Real
