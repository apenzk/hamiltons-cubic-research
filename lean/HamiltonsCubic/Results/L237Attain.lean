import Mathlib
import HamiltonsCubic.Results.RootSlots

/-!
# L237's attainment: the cap `κ_r ≤ r + 2` is reached at `r = 1, 2, 4, 6`

[L237](../../../findings/second-order.md) proves `∑ⱼ ‖[X, yⱼ]‖² ≤ (r + 2) ⟨X, X⟩` at every skew `X`
and orthonormal skew `y₁, …, y_r` (`kappa_cap_norm` in [L237SlotCounts.lean](L237SlotCounts.lean))
and records equality at even `r = 2k` once `n ≥ 2k + 2`: *"the doubled `k`-star (centre weight
`k`, `k` leaves of weight `1`, all one sign) has every load exactly `2k + 2`, and at `r = 6` the
doubled triangle also attains it"*. This file exhibits the witnesses at `r = 1, 2, 4, 6`.

`Attains r κ` says some skew `X` with `⟨X, X⟩ > 0` and orthonormal skew `y₁, …, y_r` have
`∑ⱼ ‖[X, yⱼ]‖² = κ ⟨X, X⟩`.

* `attains_one`: `κ₁ ≥ 2` at `n ≥ 4`, from `X = φ₀₁ + φ₂₃` and the slot `φ₀₂ - φ₁₃`;
* `attains_two`: `κ₂ = 4` at `n ≥ 4`, the `1`-star, adding the slot `φ₀₃ + φ₁₂`;
* `attains_four`: `κ₄ = 6` at `n ≥ 6`, the `2`-star `X = 2φ₀₁ + φ₂₃ + φ₄₅`, four slots of
  eigenvalue `9` against `⟨X, X⟩ = 6`;
* `attains_six`: `κ₆ = 8` at `n ≥ 6`, the triangle `X = φ₀₁ + φ₂₃ + φ₄₅`, six slots of eigenvalue
  `4` against `⟨X, X⟩ = 3`;
* `ray_value_above`: `83√21/294 > √(3/2)`, the comparison the record draws for the ray value.

The slots are built at scale `√2` (`attains_of_scaled`), so every entry is an integer
combination of `φ`, and both the bracket norms and the Gram matrix are evaluated through the
bracket table `br_phi_phi` and `inner2_phi_phi` at indices `e 0, …, e 5` of an embedding
`e : Fin m ↪ ι`, which `n ≥ m` supplies.
-/

open HamiltonsCubic.RealLayer HamiltonsCubic.RootSlots Matrix

namespace HamiltonsCubic.L237Attain

set_option linter.unusedSectionVars false

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`κ` is attained at `r`**: a skew `X` with `⟨X, X⟩ > 0` and `r` orthonormal skew `yⱼ` with
`∑ⱼ ‖[X, yⱼ]‖² = κ ⟨X, X⟩`. With `kappa_cap_norm`, `Attains r (r + 2)` makes `r + 2` the
supremum of the ratio. -/
def Attains (ι : Type*) [Fintype ι] [DecidableEq ι] (r : ℕ) (κ : ℝ) : Prop :=
  ∃ X : Matrix ι ι ℝ, IsSkew X ∧ 0 < inner2 X X ∧
    ∃ y : Fin r → Matrix ι ι ℝ, (∀ j, IsSkew (y j)) ∧
      (∀ i j, inner2 (y i) (y j) = if i = j then 1 else 0) ∧
      ∑ j, inner2 (br X (y j)) (br X (y j)) = κ * inner2 X X

theorem i2_add_l (A B C : Matrix ι ι ℝ) : inner2 (A + B) C = inner2 A C + inner2 B C := by
  simp only [inner2, Matrix.transpose_add, Matrix.add_mul, Matrix.trace_add]; ring
theorem i2_add_r (A B C : Matrix ι ι ℝ) : inner2 A (B + C) = inner2 A B + inner2 A C := by
  simp only [inner2, Matrix.mul_add, Matrix.trace_add]; ring
theorem i2_sub_l (A B C : Matrix ι ι ℝ) : inner2 (A - B) C = inner2 A C - inner2 B C := by
  simp only [inner2, Matrix.transpose_sub, Matrix.sub_mul, Matrix.trace_sub]; ring
theorem i2_sub_r (A B C : Matrix ι ι ℝ) : inner2 A (B - C) = inner2 A B - inner2 A C := by
  simp only [inner2, Matrix.mul_sub, Matrix.trace_sub]; ring
theorem i2_smul_l (c : ℝ) (A B : Matrix ι ι ℝ) : inner2 (c • A) B = c * inner2 A B := by
  simp only [inner2, Matrix.transpose_smul, Matrix.smul_mul, Matrix.trace_smul, smul_eq_mul]; ring
theorem i2_smul_r (c : ℝ) (A B : Matrix ι ι ℝ) : inner2 A (c • B) = c * inner2 A B := by
  simp only [inner2, Matrix.mul_smul, Matrix.trace_smul, smul_eq_mul]; ring
theorem i2_neg_l (A B : Matrix ι ι ℝ) : inner2 (-A) B = -inner2 A B := by
  simp only [inner2, Matrix.transpose_neg, Matrix.neg_mul, Matrix.trace_neg]; ring
theorem i2_neg_r (A B : Matrix ι ι ℝ) : inner2 A (-B) = -inner2 A B := by
  simp only [inner2, Matrix.mul_neg, Matrix.trace_neg]; ring

theorem i2_phi (i j k l : ι) :
    inner2 (phi i j) (phi k l)
      = (if i = k ∧ j = l then (1:ℝ) else 0) - (if j = k ∧ i = l then (1:ℝ) else 0) := by
  rw [inner2_phi _ (phi_isSkew i j) k l]
  simp only [phi, Matrix.sub_apply, Matrix.single_apply, neg_sub]

theorem brL_sub (A B C : Matrix ι ι ℝ) : br (A - B) C = br A C - br B C := by
  simp only [br, Matrix.sub_mul, Matrix.mul_sub]; abel

theorem skew_add {A B : Matrix ι ι ℝ} (hA : IsSkew A) (hB : IsSkew B) : IsSkew (A + B) := by
  unfold IsSkew at *; rw [Matrix.transpose_add, hA, hB, neg_add]
theorem skew_sub {A B : Matrix ι ι ℝ} (hA : IsSkew A) (hB : IsSkew B) : IsSkew (A - B) := by
  unfold IsSkew at *; rw [Matrix.transpose_sub, hA, hB, neg_sub_neg, neg_sub]
theorem skew_smul (c : ℝ) {A : Matrix ι ι ℝ} (hA : IsSkew A) : IsSkew (c • A) := by
  unfold IsSkew at *; rw [Matrix.transpose_smul, hA, smul_neg]

/-- **The slots at scale `√2`**: skew `Zⱼ` with Gram matrix `2δᵢⱼ` and
`∑ⱼ ‖[X, Zⱼ]‖² = 2κ ⟨X, X⟩` give `Attains r κ` through `yⱼ = Zⱼ / √2`. -/
theorem attains_of_scaled {r : ℕ} {κ : ℝ} (X : Matrix ι ι ℝ) (hX : IsSkew X)
    (hXX : 0 < inner2 X X) (Z : Fin r → Matrix ι ι ℝ) (hZS : ∀ j, IsSkew (Z j))
    (hZ : ∀ i j, inner2 (Z i) (Z j) = if i = j then 2 else 0)
    (hsum : ∑ j, inner2 (br X (Z j)) (br X (Z j)) = 2 * κ * inner2 X X) :
    Attains ι r κ := by
  set c : ℝ := (Real.sqrt 2)⁻¹ with hc
  have hcc : c * c = 1 / 2 := by
    rw [hc, ← mul_inv, Real.mul_self_sqrt (by norm_num : (0:ℝ) ≤ 2), one_div]
  refine ⟨X, hX, hXX, fun j => c • Z j, fun j => skew_smul c (hZS j), ?_, ?_⟩
  · intro i j
    rw [i2_smul_l, i2_smul_r, hZ, ← mul_assoc, hcc]
    split_ifs <;> norm_num
  · have e : ∀ j, inner2 (br X (c • Z j)) (br X (c • Z j))
        = (1 / 2) * inner2 (br X (Z j)) (br X (Z j)) := by
      intro j
      rw [brR_smul, i2_smul_l, i2_smul_r, ← mul_assoc, hcc]
    simp only [e, ← Finset.mul_sum, hsum]
    ring

/-- The simp set evaluating a bracket norm or a Gram entry of `φ` combinations at the
indices of an embedding. -/
macro "phi_eval" he:term : tactic =>
  `(tactic| (simp only [Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Matrix.cons_val,
      brL_add, brR_add, brR_sub, brL_sub, brL_smul, brR_smul, brR_neg,
      br_phi_phi, i2_add_l, i2_add_r, i2_sub_l, i2_sub_r, i2_smul_l, i2_smul_r, i2_neg_l, i2_neg_r,
      i2_phi, ($he).eq_iff, smul_add, smul_sub, smul_zero, smul_neg, zero_smul, one_smul,
      add_zero, zero_add, sub_zero, zero_sub, neg_zero, mul_zero, mul_one, zero_mul, one_mul]
    <;> norm_num [Fin.ext_iff]))

/-- An embedding `Fin m ↪ ι` from `m ≤ n`. -/
theorem emb_of_le {m : ℕ} (h : m ≤ Fintype.card ι) : Nonempty (Fin m ↪ ι) :=
  Function.Embedding.nonempty_of_card_le (by simpa using h)

/-- The `1`-star `φ₀₁ + φ₂₃` at the indices of `e`. -/
def star1 (e : Fin 4 ↪ ι) : Matrix ι ι ℝ := phi (e 0) (e 1) + phi (e 2) (e 3)

/-- Its two plus slots at scale `√2`, `φ₀₂ - φ₁₃` and `φ₀₃ + φ₁₂`. -/
def slots1 (e : Fin 4 ↪ ι) : Fin 2 → Matrix ι ι ℝ :=
  ![phi (e 0) (e 2) - phi (e 1) (e 3), phi (e 0) (e 3) + phi (e 1) (e 2)]

/-- The `2`-star `2φ₀₁ + φ₂₃ + φ₄₅`. -/
def star2 (e : Fin 6 ↪ ι) : Matrix ι ι ℝ :=
  (2:ℝ) • phi (e 0) (e 1) + phi (e 2) (e 3) + phi (e 4) (e 5)

/-- The triangle `φ₀₁ + φ₂₃ + φ₄₅`. -/
def triangle (e : Fin 6 ↪ ι) : Matrix ι ι ℝ := phi (e 0) (e 1) + phi (e 2) (e 3) + phi (e 4) (e 5)

/-- The four plus slots of the `2`-star at scale `√2`, two per leaf. -/
def slots2 (e : Fin 6 ↪ ι) : Fin 4 → Matrix ι ι ℝ :=
  ![phi (e 0) (e 2) - phi (e 1) (e 3), phi (e 0) (e 3) + phi (e 1) (e 2),
    phi (e 0) (e 4) - phi (e 1) (e 5), phi (e 0) (e 5) + phi (e 1) (e 4)]

/-- The six plus slots of the triangle at scale `√2`, two per block pair. -/
def slotsT (e : Fin 6 ↪ ι) : Fin 6 → Matrix ι ι ℝ :=
  ![phi (e 0) (e 2) - phi (e 1) (e 3), phi (e 0) (e 3) + phi (e 1) (e 2),
    phi (e 0) (e 4) - phi (e 1) (e 5), phi (e 0) (e 5) + phi (e 1) (e 4),
    phi (e 2) (e 4) - phi (e 3) (e 5), phi (e 2) (e 5) + phi (e 3) (e 4)]

/-- **`κ₂ = 4` at `n ≥ 4`**: the `1`-star `X = φ₀₁ + φ₂₃` and the slots `φ₀₂ - φ₁₃`,
`φ₀₃ + φ₁₂`, each of eigenvalue `(1 + 1)² = 4`, against `⟨X, X⟩ = 2`. -/
theorem attains_two (h : 4 ≤ Fintype.card ι) : Attains ι 2 4 := by
  obtain ⟨e⟩ := emb_of_le (ι := ι) h
  have he := e.injective
  refine attains_of_scaled (star1 e) (skew_add (phi_isSkew _ _) (phi_isSkew _ _)) ?_ (slots1 e)
    ?_ ?_ ?_
  · simp only [star1]; phi_eval he
  · intro j; fin_cases j
    · exact skew_sub (phi_isSkew _ _) (phi_isSkew _ _)
    · exact skew_add (phi_isSkew _ _) (phi_isSkew _ _)
  · intro i j; fin_cases i <;> fin_cases j <;> unfold slots1 <;> phi_eval he
  · simp only [Fin.sum_univ_two, star1, slots1]; phi_eval he

/-- **`κ₁ ≥ 2` at `n ≥ 4`**: `X = φ₀₁ + φ₂₃` and the one slot `φ₀₂ - φ₁₃`. -/
theorem attains_one (h : 4 ≤ Fintype.card ι) : Attains ι 1 2 := by
  obtain ⟨e⟩ := emb_of_le (ι := ι) h
  have he := e.injective
  refine attains_of_scaled (star1 e) (skew_add (phi_isSkew _ _) (phi_isSkew _ _)) ?_
    ![phi (e 0) (e 2) - phi (e 1) (e 3)] ?_ ?_ ?_
  · simp only [star1]; phi_eval he
  · intro j; fin_cases j; exact skew_sub (phi_isSkew _ _) (phi_isSkew _ _)
  · intro i j; fin_cases i; fin_cases j; phi_eval he
  · simp only [Fin.sum_univ_one, star1]; phi_eval he

/-- **`κ₄ = 6` at `n ≥ 6`**: the `2`-star `X = 2φ₀₁ + φ₂₃ + φ₄₅`, `⟨X, X⟩ = 6`, and its four
slots `φ₀₂ - φ₁₃`, `φ₀₃ + φ₁₂`, `φ₀₄ - φ₁₅`, `φ₀₅ + φ₁₄`, each of eigenvalue `(2 + 1)² = 9`. -/
theorem attains_four (h : 6 ≤ Fintype.card ι) : Attains ι 4 6 := by
  obtain ⟨e⟩ := emb_of_le (ι := ι) h
  have he := e.injective
  refine attains_of_scaled (star2 e)
    (skew_add (skew_add (skew_smul _ (phi_isSkew _ _)) (phi_isSkew _ _)) (phi_isSkew _ _))
    ?_ (slots2 e) ?_ ?_ ?_
  · simp only [star2]; phi_eval he
  · intro j; fin_cases j
    · exact skew_sub (phi_isSkew _ _) (phi_isSkew _ _)
    · exact skew_add (phi_isSkew _ _) (phi_isSkew _ _)
    · exact skew_sub (phi_isSkew _ _) (phi_isSkew _ _)
    · exact skew_add (phi_isSkew _ _) (phi_isSkew _ _)
  · intro i j; fin_cases i <;> fin_cases j <;> unfold slots2 <;> phi_eval he
  · simp only [Fin.sum_univ_four, star2, slots2]; phi_eval he

/-- **`κ₆ = 8` at `n ≥ 6`**: the triangle `X = φ₀₁ + φ₂₃ + φ₄₅`, `⟨X, X⟩ = 3`, and its six slots,
two per block pair, each of eigenvalue `(1 + 1)² = 4`. -/
theorem attains_six (h : 6 ≤ Fintype.card ι) : Attains ι 6 8 := by
  obtain ⟨e⟩ := emb_of_le (ι := ι) h
  have he := e.injective
  refine attains_of_scaled (triangle e)
    (skew_add (skew_add (phi_isSkew _ _) (phi_isSkew _ _)) (phi_isSkew _ _)) ?_ (slotsT e) ?_ ?_ ?_
  · simp only [triangle]; phi_eval he
  · intro j; fin_cases j
    · exact skew_sub (phi_isSkew _ _) (phi_isSkew _ _)
    · exact skew_add (phi_isSkew _ _) (phi_isSkew _ _)
    · exact skew_sub (phi_isSkew _ _) (phi_isSkew _ _)
    · exact skew_add (phi_isSkew _ _) (phi_isSkew _ _)
    · exact skew_sub (phi_isSkew _ _) (phi_isSkew _ _)
    · exact skew_add (phi_isSkew _ _) (phi_isSkew _ _)
  · intro i j; fin_cases i <;> fin_cases j <;> unfold slotsT <;> phi_eval he
  · simp only [Fin.sum_univ_six, triangle, slotsT]; phi_eval he

/-- **`83√21/294 > √(3/2)`**, the comparison the record draws between the ray value and the
threshold `√(3/2)`: squared, `83² · 21 / 294² = 144669/86436 > 3/2`. That `83√21/294` is the ray's
exact value is owed in the L237 row; this is the arithmetic the comparison rests on. -/
theorem ray_value_above : Real.sqrt (3 / 2) < 83 * Real.sqrt 21 / 294 := by
  have h21 : Real.sqrt 21 ^ 2 = 21 := Real.sq_sqrt (by norm_num)
  have hpos : 0 < 83 * Real.sqrt 21 / 294 := by positivity
  rw [Real.sqrt_lt' hpos, div_pow, mul_pow, h21]
  norm_num

end HamiltonsCubic.L237Attain
