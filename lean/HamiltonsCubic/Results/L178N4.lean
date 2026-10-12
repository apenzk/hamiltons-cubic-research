import HamiltonsCubic.Results.L178Theta

set_option linter.style.longLine false

/-!
# L178 at `n = 4`: `|θ| ≤ √(3/2)` for every Weyl operator of `Λ²`-rank at most three

[diagonal-half.md](../../../findings/diagonal-half.md), Lemma L178, at `V = ℝ⁴`, in the layer's own `n = 4` model
([Sharp.lean](../Base/Sharp.lean)'s `IsWeyl`, `Pcubic` and `#` on `6 × 6` rational matrices), so that every step runs on
one carrier:

- **`mixed_zero4`** (step 1): Ricci-flatness kills the mixed block `ω⁺ᵀ R ω⁻`;
- **`trace4`** (step 4's Bianchi): each block is trace-free, Ricci-flatness giving the sum and Bianchi the difference;
- `blkP`, `blkM`, **`decomp4`**: `R = R⁺(B⁺) + R⁻(B⁻)` with `B^± = ω^±ᵀ R ω^± / 2`, the blocks in the orthonormal bases
  `ω^±/√2`;
- `dot_symm`, `eq_zero_of_minorsQ`, `exists_minorQ`, `two_by_twoQ`, **`rank4`** (step 1): `rank R ≤ 3` forces `B⁺ = 0`
  or `B⁻ = 0`;
- **`L178_n4`**: with [L178Theta.lean](L178Theta.lean)'s steps 4 and 5, `P(R)² ≤ (3/2) ‖R‖⁶` for every `n = 4` Weyl
  operator of rank at most three.
-/
-- The Ricci contractions unfold through `Fin.sum_univ_six` and `Fin.sum_univ_four`, as in Sharp.lean.
set_option maxRecDepth 100000

namespace HamiltonsCubic.Base

open Matrix

variable {R : Matrix (Fin 6) (Fin 6) ℚ}

set_option maxHeartbeats 16000000 in
-- Ten Ricci contractions, each a double sum over `Λ²ℝ⁴`, expanded symbolically.
/-- **Ricci-flatness kills the mixed block** in the layer's `n = 4` model. -/
theorem mixed_zero4 (hS : R.IsSymm) (hR : IsRicciFlat R) (i j : Fin 3) : wp i ⬝ᵥ (R *ᵥ wm j) = 0 := by
  have hs : ∀ p q, R q p = R p q := fun p q => by
    have := congrFun (congrFun hS p) q; simpa [Matrix.transpose_apply] using this
  have r00 := hR 0 0; have r01 := hR 0 1; have r02 := hR 0 2; have r03 := hR 0 3; have r11 := hR 1 1
  have r12 := hR 1 2; have r13 := hR 1 3; have r22 := hR 2 2; have r23 := hR 2 3; have r33 := hR 3 3
  simp only [Ric, toMat4, coord4, basis4, pair4, phi, inner2, Matrix.mulVec, dotProduct, Fin.sum_univ_six,
    Fin.sum_univ_four, Matrix.single, Matrix.sub_apply, Matrix.add_apply, Matrix.smul_apply, Fin.isValue,
    Matrix.of_apply, Matrix.transpose_apply, Matrix.mul_apply, Matrix.trace, Matrix.diag] at r00 r01 r02 r03 r11 r12 r13 r22 r23 r33
  norm_num [Fin.ext_iff] at r00 r01 r02 r03 r11 r12 r13 r22 r23 r33
  fin_cases i <;> fin_cases j <;>
    simp only [wp, wm, dotProduct, Matrix.mulVec, Fin.sum_univ_six, Fin.isValue, Fin.zero_eta, Fin.mk_one,
      Fin.reduceFinMk] <;> norm_num <;>
    linarith [hs 0 1, hs 0 2, hs 0 3, hs 0 4, hs 0 5, hs 1 2, hs 1 3, hs 1 4, hs 1 5, hs 2 3, hs 2 4, hs 2 5,
      hs 3 4, hs 3 5, hs 4 5]

theorem symm_entries (hS : R.IsSymm) (p q : Fin 6) : R q p = R p q := by
  have := congrFun (congrFun hS p) q; simpa [Matrix.transpose_apply] using this

set_option maxHeartbeats 16000000 in
-- Four Ricci contractions expanded symbolically.
/-- **Each summand is trace-free**: Ricci-flatness gives the sum, first Bianchi the difference. -/
theorem trace4 (hS : R.IsSymm) (hB : IsBianchi R) (hR : IsRicciFlat R) :
    wp 0 ⬝ᵥ (R *ᵥ wp 0) + wp 1 ⬝ᵥ (R *ᵥ wp 1) + wp 2 ⬝ᵥ (R *ᵥ wp 2) = 0 ∧
      wm 0 ⬝ᵥ (R *ᵥ wm 0) + wm 1 ⬝ᵥ (R *ᵥ wm 1) + wm 2 ⬝ᵥ (R *ᵥ wm 2) = 0 := by
  have hs := symm_entries hS
  have r00 := hR 0 0; have r11 := hR 1 1; have r22 := hR 2 2; have r33 := hR 3 3
  simp only [Ric, toMat4, coord4, basis4, pair4, phi, inner2, Matrix.mulVec, dotProduct, Fin.sum_univ_six, Fin.sum_univ_four, Matrix.single, Matrix.sub_apply, Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.transpose_apply, Matrix.mul_apply, Matrix.trace, Matrix.diag] at r00 r11 r22 r33
  norm_num [Fin.ext_iff] at r00 r11 r22 r33
  unfold IsBianchi at hB
  simp only [wp, wm, dotProduct, Matrix.mulVec, Fin.sum_univ_six, Fin.isValue]
  norm_num
  constructor <;> linarith [hs 0 1, hs 0 2, hs 0 3, hs 0 4, hs 0 5, hs 1 2, hs 1 3, hs 1 4, hs 1 5, hs 2 3, hs 2 4, hs 2 5, hs 3 4, hs 3 5, hs 4 5]

/-- The block of `R` on `Λ⁺` in the orthonormal basis `ω⁺/√2`. -/
def blkP (R : Matrix (Fin 6) (Fin 6) ℚ) (i j : Fin 3) : ℚ := (wp i ⬝ᵥ (R *ᵥ wp j)) / 2
/-- The block of `R` on `Λ⁻`. -/
def blkM (R : Matrix (Fin 6) (Fin 6) ℚ) (i j : Fin 3) : ℚ := (wm i ⬝ᵥ (R *ᵥ wm j)) / 2

set_option maxHeartbeats 16000000 in
-- Thirty-six entries, each a linear identity in the entries of `R`.
/-- **`R = R⁺ ⊕ R⁻`** once the mixed block vanishes. -/
theorem decomp4 (hS : R.IsSymm) (hmix : ∀ i j, wp i ⬝ᵥ (R *ᵥ wm j) = 0) :
    R = Rp (blkP R 0 0) (blkP R 0 1) (blkP R 0 2) (blkP R 1 1) (blkP R 1 2) (blkP R 2 2) +
      Rm (blkM R 0 0) (blkM R 0 1) (blkM R 0 2) (blkM R 1 1) (blkM R 1 2) (blkM R 2 2) := by
  have hs := symm_entries hS
  have m00 := hmix 0 0; have m01 := hmix 0 1; have m02 := hmix 0 2; have m10 := hmix 1 0; have m11 := hmix 1 1
  have m12 := hmix 1 2; have m20 := hmix 2 0; have m21 := hmix 2 1; have m22 := hmix 2 2
  simp only [wp, wm, dotProduct, Matrix.mulVec, Fin.sum_univ_six, Fin.isValue] at m00 m01 m02 m10 m11 m12 m20 m21 m22
  norm_num at m00 m01 m02 m10 m11 m12 m20 m21 m22
  ext p q
  fin_cases p <;> fin_cases q <;>
    simp only [Matrix.add_apply, Rp, Rm, Matrix.of_apply, blkP, blkM, wp, wm, dotProduct, Matrix.mulVec,
      Fin.sum_univ_six, Fin.isValue, Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk] <;> norm_num <;>
    linarith [hs 0 1, hs 0 2, hs 0 3, hs 0 4, hs 0 5, hs 1 2, hs 1 3, hs 1 4, hs 1 5, hs 2 3, hs 2 4, hs 2 5, hs 3 4, hs 3 5, hs 4 5]

theorem dot_symm (hS : R.IsSymm) (u v : Fin 6 → ℚ) : u ⬝ᵥ (R *ᵥ v) = v ⬝ᵥ (R *ᵥ u) := by
  rw [Matrix.dotProduct_mulVec]; nth_rewrite 1 [← hS.eq]; rw [Matrix.vecMul_transpose, dotProduct_comm]

/-- A symmetric trace-free `3 × 3` array with every `2 × 2` minor zero vanishes, over `ℚ`. -/
theorem eq_zero_of_minorsQ {B : Fin 3 → Fin 3 → ℚ} (hB : ∀ i j, B i j = B j i) (htr : B 0 0 + B 1 1 + B 2 2 = 0)
    (hm : ∀ i₁ i₂ j₁ j₂, B i₁ j₁ * B i₂ j₂ - B i₁ j₂ * B i₂ j₁ = 0) : ∀ i j, B i j = 0 := by
  have m01 := hm 0 1 0 1; have m02 := hm 0 2 0 2; have m12 := hm 1 2 1 2
  rw [hB 1 0] at m01; rw [hB 2 0] at m02; rw [hB 2 1] at m12
  have h2 : B 2 2 = -B 0 0 - B 1 1 := by linarith
  rw [h2] at m02 m12
  have ha : B 0 0 = 0 := by
    nlinarith [sq_nonneg (B 0 0 + B 1 1), sq_nonneg (B 0 0), sq_nonneg (B 1 1), sq_nonneg (B 0 1), sq_nonneg (B 0 2), sq_nonneg (B 1 2)]
  have hd : B 1 1 = 0 := by
    nlinarith [sq_nonneg (B 0 0 + B 1 1), sq_nonneg (B 0 0), sq_nonneg (B 1 1), sq_nonneg (B 0 1), sq_nonneg (B 0 2), sq_nonneg (B 1 2)]
  have hb : B 0 1 = 0 := by nlinarith [sq_nonneg (B 0 1)]
  have hc : B 0 2 = 0 := by nlinarith [sq_nonneg (B 0 2)]
  have he : B 1 2 = 0 := by nlinarith [sq_nonneg (B 1 2)]
  intro i j
  fin_cases i <;> fin_cases j <;> simp only [Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Fin.isValue] <;>
    first | assumption | (rw [hB]; assumption) | linarith

theorem exists_minorQ {B : Fin 3 → Fin 3 → ℚ} (hB : ∀ i j, B i j = B j i) (htr : B 0 0 + B 1 1 + B 2 2 = 0)
    (hne : ∃ i j, B i j ≠ 0) : ∃ i₁ i₂ j₁ j₂, B i₁ j₁ * B i₂ j₂ - B i₁ j₂ * B i₂ j₁ ≠ 0 := by
  by_contra h
  push Not at h
  obtain ⟨i, j, hij⟩ := hne
  exact hij (eq_zero_of_minorsQ hB htr h i j)

theorem two_by_twoQ {a b c d x y : ℚ} (hdet : a * d - b * c ≠ 0) (h1 : x * a + y * b = 0) (h2 : x * c + y * d = 0) :
    x = 0 ∧ y = 0 := by
  constructor
  · have : x * (a * d - b * c) = 0 := by linear_combination d * h1 - b * h2
    exact (mul_eq_zero.mp this).resolve_right hdet
  · have : y * (a * d - b * c) = 0 := by linear_combination a * h2 - c * h1
    exact (mul_eq_zero.mp this).resolve_right hdet

/-- **Rank at most three forces one block to vanish**, in the layer's `n = 4` model. -/
theorem rank4 (hS : R.IsSymm) (hB : IsBianchi R) (hR : IsRicciFlat R) (hrank : R.rank ≤ 3) :
    (∀ i j, blkP R i j = 0) ∨ (∀ i j, blkM R i j = 0) := by
  by_contra h
  push Not at h
  obtain ⟨hp, hm⟩ := h
  have hmix := mixed_zero4 hS hR
  have hmix' : ∀ i j, wm i ⬝ᵥ (R *ᵥ wp j) = 0 := fun i j => by rw [dot_symm hS]; exact hmix j i
  obtain ⟨htp, htm⟩ := trace4 hS hB hR
  have symP : ∀ i j, blkP R i j = blkP R j i := fun i j => by simp only [blkP, dot_symm hS (wp i)]
  have symM : ∀ i j, blkM R i j = blkM R j i := fun i j => by simp only [blkM, dot_symm hS (wm i)]
  have trP : blkP R 0 0 + blkP R 1 1 + blkP R 2 2 = 0 := by simp only [blkP]; linarith
  have trM : blkM R 0 0 + blkM R 1 1 + blkM R 2 2 = 0 := by simp only [blkM]; linarith
  obtain ⟨i₁, i₂, j₁, j₂, hdp⟩ := exists_minorQ symP trP hp
  obtain ⟨k₁, k₂, l₁, l₂, hdm⟩ := exists_minorQ symM trM hm
  simp only [blkP, blkM] at hdp hdm
  let v : Fin 4 → LinearMap.range R.mulVecLin := ![⟨R *ᵥ wp j₁, ⟨_, rfl⟩⟩, ⟨R *ᵥ wp j₂, ⟨_, rfl⟩⟩,
    ⟨R *ᵥ wm l₁, ⟨_, rfl⟩⟩, ⟨R *ᵥ wm l₂, ⟨_, rfl⟩⟩]
  have hli : LinearIndependent ℚ v := by
    rw [Fintype.linearIndependent_iff]
    intro c hc
    have hc' : c 0 • (R *ᵥ wp j₁) + c 1 • (R *ᵥ wp j₂) + c 2 • (R *ᵥ wm l₁) + c 3 • (R *ᵥ wm l₂) = 0 := by
      have := congrArg Subtype.val hc
      simpa [Fin.sum_univ_four, v] using this
    have e : ∀ x : Fin 6 → ℚ, x ⬝ᵥ (c 0 • (R *ᵥ wp j₁) + c 1 • (R *ᵥ wp j₂) + c 2 • (R *ᵥ wm l₁) + c 3 • (R *ᵥ wm l₂)) = 0 :=
      fun x => by rw [hc', dotProduct_zero]
    have ep1 := e (wp i₁); have ep2 := e (wp i₂); have em1 := e (wm k₁); have em2 := e (wm k₂)
    simp only [dotProduct_add, dotProduct_smul, smul_eq_mul, hmix, hmix', mul_zero, add_zero, zero_add] at ep1 ep2 em1 em2
    have hdp' : (wp i₁ ⬝ᵥ (R *ᵥ wp j₁)) * (wp i₂ ⬝ᵥ (R *ᵥ wp j₂)) - (wp i₁ ⬝ᵥ (R *ᵥ wp j₂)) * (wp i₂ ⬝ᵥ (R *ᵥ wp j₁)) ≠ 0 := by
      intro h0; apply hdp; field_simp; linarith
    have hdm' : (wm k₁ ⬝ᵥ (R *ᵥ wm l₁)) * (wm k₂ ⬝ᵥ (R *ᵥ wm l₂)) - (wm k₁ ⬝ᵥ (R *ᵥ wm l₂)) * (wm k₂ ⬝ᵥ (R *ᵥ wm l₁)) ≠ 0 := by
      intro h0; apply hdm; field_simp; linarith
    obtain ⟨h0, h1⟩ := two_by_twoQ hdp' ep1 ep2
    obtain ⟨h2, h3⟩ := two_by_twoQ hdm' em1 em2
    intro t; fin_cases t <;> assumption
  have := hli.fintype_card_le_finrank
  simp only [Fintype.card_fin] at this
  unfold Matrix.rank at hrank
  omega

theorem Rm_zero : Rm 0 0 0 0 0 0 = 0 := by ext p q; simp [Rm]
theorem Rp_zero : Rp 0 0 0 0 0 0 = 0 := by ext p q; simp [Rp]

/-- **L178 at `n = 4`**: a Weyl operator on `Λ²ℝ⁴` of rank at most three has `P(R)² ≤ (3/2) ‖R‖⁶`, that is
`|θ| ≤ √(3/2)` at unit norm. -/
theorem L178_n4 (hW : IsWeyl R) (hrank : R.rank ≤ 3) :
    Pcubic R ^ 2 ≤ (3 / 2) * ((Rᵀ * R).trace) ^ 3 := by
  obtain ⟨hS, hB, hR⟩ := hW
  have hd := decomp4 hS (mixed_zero4 hS hR)
  obtain ⟨htp, htm⟩ := trace4 hS hB hR
  rcases rank4 hS hB hR hrank with h | h
  · have hf : blkM R 2 2 = -blkM R 0 0 - blkM R 1 1 := by simp only [blkM]; linarith
    rw [show blkP R 0 0 = 0 from h 0 0, show blkP R 0 1 = 0 from h 0 1, show blkP R 0 2 = 0 from h 0 2,
      show blkP R 1 1 = 0 from h 1 1, show blkP R 1 2 = 0 from h 1 2, show blkP R 2 2 = 0 from h 2 2, Rp_zero,
      zero_add, hf] at hd
    rw [hd]
    exact (L178_theta_asd _ _ _ _ _).2
  · have hf : blkP R 2 2 = -blkP R 0 0 - blkP R 1 1 := by simp only [blkP]; linarith
    rw [show blkM R 0 0 = 0 from h 0 0, show blkM R 0 1 = 0 from h 0 1, show blkM R 0 2 = 0 from h 0 2,
      show blkM R 1 1 = 0 from h 1 1, show blkM R 1 2 = 0 from h 1 2, show blkM R 2 2 = 0 from h 2 2, Rm_zero,
      add_zero, hf] at hd
    rw [hd]
    exact (L178_theta_sd _ _ _ _ _).2

end HamiltonsCubic.Base
