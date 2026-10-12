import Mathlib

set_option linter.style.longLine false

/-!
# L225, the per-block cubic: `Σ λ³ ≤ (k-2)/√(k(k-1))` on the unit trace-free sphere

## The claim

[second-order.md](../../../findings/second-order.md)'s Lemma L225: for real `λ₁, …, λ_k` with `Σ λ = 0` and
`Σ λ² = 1`, `Σ λ³ ≤ (k-2)/c` with `c = √(k(k-1))`, with equality exactly when one entry is `(k-1)/c` and the
other `k-1` are `-1/c`. Applied to the eigenvalues of a trace-free symmetric matrix `M⁰` it reads
`tr (M⁰)³ ≤ (k-2)/√(k(k-1)) ‖M⁰‖³`, Case–Tyrrell's bound; at `k = 3` the constant is `1/√6`.

## What is typed

* `entry_sq_le`: `λ_i² ≤ (k-1)/k` on the unit trace-free sphere;
* `cube_sum_le`: the bound, proved by the tangent cubic `(x - α)(x + β)² ≤ 0` for `x ≤ α`;
* `cube_sum_eq`: at equality every entry is `α = (k-1)/c` or `-β = -1/c`;
* `cube_sum_eq_card`: at equality exactly one entry is `α`;
* `cube_sum_attained`: the vector with one entry `α` and the rest `-β` attains the bound;
* `three_by_three`: the `k = 3` discriminant identity `8(a²+ab+b²)³ - 54a²b²(a+b)² = 2(a-b)²(2a+b)²(a+2b)²`.

The matrix form, through the spectral theorem, is [L225Matrix.lean](L225Matrix.lean)'s `matrix_cube_le` and `matrix_cube_attained`.
-/

namespace HamiltonsCubic.L225Statement

open Finset

variable {ι : Type*} [Fintype ι]

/-- **Every entry is bounded**: `Σ λ = 0` and `Σ λ² = 1` give `k λ_i² ≤ k - 1`. -/
theorem entry_sq_le (l : ι → ℝ) (h1 : ∑ j, l j = 0) (h2 : ∑ j, l j ^ 2 = 1) (i : ι) :
    (Fintype.card ι : ℝ) * l i ^ 2 ≤ (Fintype.card ι : ℝ) - 1 := by
  classical
  have hs : ∑ j ∈ univ.erase i, l j = -l i := by
    have := Finset.add_sum_erase univ l (mem_univ i); linarith
  have hq : ∑ j ∈ univ.erase i, l j ^ 2 = 1 - l i ^ 2 := by
    have := Finset.add_sum_erase univ (fun j => l j ^ 2) (mem_univ i); linarith
  have cs := sq_sum_le_card_mul_sum_sq (s := univ.erase i) (f := l)
  rw [hs, hq, Finset.card_erase_of_mem (mem_univ i), Finset.card_univ] at cs
  have hk : 1 ≤ Fintype.card ι := Fintype.card_pos_iff.mpr ⟨i⟩
  push_cast [hk] at cs
  nlinarith

/-- **The per-block cubic bound.** With `c > 0`, `c² = k(k-1)` and `k ≥ 2`, every `λ` on the unit trace-free
sphere has `Σ λ³ ≤ (k-2)/c`. -/
theorem cube_sum_le (l : ι → ℝ) (c : ℝ) (hc0 : 0 < c)
    (hc : c ^ 2 = (Fintype.card ι : ℝ) * ((Fintype.card ι : ℝ) - 1)) (hk : 2 ≤ Fintype.card ι)
    (h1 : ∑ j, l j = 0) (h2 : ∑ j, l j ^ 2 = 1) :
    ∑ j, l j ^ 3 ≤ ((Fintype.card ι : ℝ) - 2) / c := by
  set k : ℝ := (Fintype.card ι : ℝ) with hkdef
  have hk2 : (2 : ℝ) ≤ k := by rw [hkdef]; exact_mod_cast hk
  have hα : ∀ i, l i ≤ (k - 1) / c := by
    intro i
    have e := entry_sq_le l h1 h2 i
    have hsq : l i ^ 2 ≤ ((k - 1) / c) ^ 2 := by
      rw [div_pow, hc, le_div_iff₀ (by nlinarith)]; nlinarith
    have h0 : 0 ≤ (k - 1) / c := div_nonneg (by linarith) hc0.le
    exact abs_le_of_sq_le_sq' hsq h0 |>.2
  have tang : ∀ i, (l i - (k - 1) / c) * (l i + 1 / c) ^ 2 ≤ 0 := fun i =>
    mul_nonpos_of_nonpos_of_nonneg (by linarith [hα i]) (sq_nonneg _)
  have sumle : ∑ i, (l i - (k - 1) / c) * (l i + 1 / c) ^ 2 ≤ 0 := Finset.sum_nonpos fun i _ => tang i
  have expand : ∑ i, (l i - (k - 1) / c) * (l i + 1 / c) ^ 2
      = ∑ i, l i ^ 3 + (2 / c - (k - 1) / c) * ∑ i, l i ^ 2
        + (1 / c ^ 2 - 2 * (k - 1) / c ^ 2) * ∑ i, l i - k * ((k - 1) / c ^ 3) := by
    simp only [Finset.mul_sum, ← Finset.sum_add_distrib]
    rw [show k * ((k - 1) / c ^ 3) = ∑ _i : ι, (k - 1) / c ^ 3 by
      rw [Finset.sum_const, Finset.card_univ, nsmul_eq_mul]]
    rw [← Finset.sum_sub_distrib]
    exact Finset.sum_congr rfl fun i _ => by field_simp; ring
  rw [expand, h1, h2] at sumle
  have key : k * ((k - 1) / c ^ 3) = 1 / c := by
    have hk0 : k ≠ 0 := ne_of_gt (by linarith)
    have hk1 : k - 1 ≠ 0 := ne_of_gt (by linarith)
    rw [show c ^ 3 = c ^ 2 * c by ring, hc]; field_simp
  rw [key] at sumle
  have : ((k - 2) / c) = (k - 1) / c - 2 / c + 1 / c := by ring
  rw [this]; nlinarith

/-- **Equality forces two values**: if the bound is attained, every entry is `(k-1)/c` or `-1/c`. -/
theorem cube_sum_eq (l : ι → ℝ) (c : ℝ) (hc0 : 0 < c)
    (hc : c ^ 2 = (Fintype.card ι : ℝ) * ((Fintype.card ι : ℝ) - 1)) (hk : 2 ≤ Fintype.card ι)
    (h1 : ∑ j, l j = 0) (h2 : ∑ j, l j ^ 2 = 1)
    (heq : ∑ j, l j ^ 3 = ((Fintype.card ι : ℝ) - 2) / c) (i : ι) :
    l i = ((Fintype.card ι : ℝ) - 1) / c ∨ l i = -1 / c := by
  set k : ℝ := (Fintype.card ι : ℝ) with hkdef
  have hk2 : (2 : ℝ) ≤ k := by rw [hkdef]; exact_mod_cast hk
  have hα : ∀ i, l i ≤ (k - 1) / c := by
    intro i
    have e := entry_sq_le l h1 h2 i
    have hsq : l i ^ 2 ≤ ((k - 1) / c) ^ 2 := by
      rw [div_pow, hc, le_div_iff₀ (by nlinarith)]; nlinarith
    exact abs_le_of_sq_le_sq' hsq (div_nonneg (by linarith) hc0.le) |>.2
  have expand : ∑ i, (l i - (k - 1) / c) * (l i + 1 / c) ^ 2
      = ∑ i, l i ^ 3 + (2 / c - (k - 1) / c) * ∑ i, l i ^ 2
        + (1 / c ^ 2 - 2 * (k - 1) / c ^ 2) * ∑ i, l i - k * ((k - 1) / c ^ 3) := by
    simp only [Finset.mul_sum, ← Finset.sum_add_distrib]
    rw [show k * ((k - 1) / c ^ 3) = ∑ _i : ι, (k - 1) / c ^ 3 by
      rw [Finset.sum_const, Finset.card_univ, nsmul_eq_mul]]
    rw [← Finset.sum_sub_distrib]
    exact Finset.sum_congr rfl fun i _ => by field_simp; ring
  have key : k * ((k - 1) / c ^ 3) = 1 / c := by
    have hk0 : k ≠ 0 := ne_of_gt (by linarith)
    have hk1 : k - 1 ≠ 0 := ne_of_gt (by linarith)
    rw [show c ^ 3 = c ^ 2 * c by ring, hc]; field_simp
  have hzero : ∑ i, (l i - (k - 1) / c) * (l i + 1 / c) ^ 2 = 0 := by
    rw [expand, h1, h2, heq, key]; ring
  have hall := (Finset.sum_eq_zero_iff_of_nonpos fun i _ =>
    mul_nonpos_of_nonpos_of_nonneg (by linarith [hα i]) (sq_nonneg (l i + 1 / c))).mp hzero i (mem_univ i)
  rcases mul_eq_zero.mp hall with h | h
  · left; linarith
  · right; have := pow_eq_zero_iff (n := 2) (by norm_num) |>.mp h; rw [neg_div]; linarith

/-- **Exactly one entry is large at equality**: the two values of `cube_sum_eq` and `Σ λ = 0` force exactly one
entry equal to `(k-1)/c`. -/
theorem cube_sum_eq_card (l : ι → ℝ) (c : ℝ) (hc0 : 0 < c)
    (hc : c ^ 2 = (Fintype.card ι : ℝ) * ((Fintype.card ι : ℝ) - 1)) (hk : 2 ≤ Fintype.card ι)
    (h1 : ∑ j, l j = 0) (h2 : ∑ j, l j ^ 2 = 1)
    (heq : ∑ j, l j ^ 3 = ((Fintype.card ι : ℝ) - 2) / c) :
    (univ.filter fun i => l i = ((Fintype.card ι : ℝ) - 1) / c).card = 1 := by
  have two := cube_sum_eq l c hc0 hc hk h1 h2 heq
  have hcard := Finset.card_filter_add_card_filter_not (s := univ)
    (fun i => l i = ((Fintype.card ι : ℝ) - 1) / c)
  rw [Finset.card_univ] at hcard
  have hcardR : ((univ.filter fun i => l i = ((Fintype.card ι : ℝ) - 1) / c).card : ℝ)
      + ((univ.filter fun i => ¬ l i = ((Fintype.card ι : ℝ) - 1) / c).card : ℝ)
      = (Fintype.card ι : ℝ) := by exact_mod_cast hcard
  have hsplit := Finset.sum_filter_add_sum_filter_not univ
    (fun i => l i = ((Fintype.card ι : ℝ) - 1) / c) l
  set k : ℝ := (Fintype.card ι : ℝ) with hkdef
  have hk2 : (2 : ℝ) ≤ k := by rw [hkdef]; exact_mod_cast hk
  have hA : ∑ i ∈ univ.filter (fun i => l i = (k - 1) / c), l i
      = ((univ.filter fun i => l i = (k - 1) / c).card : ℝ) * ((k - 1) / c) := by
    rw [Finset.sum_congr rfl (fun i hi => (Finset.mem_filter.mp hi).2), Finset.sum_const, nsmul_eq_mul]
  have hB : ∑ i ∈ univ.filter (fun i => ¬ l i = (k - 1) / c), l i
      = ((univ.filter fun i => ¬ l i = (k - 1) / c).card : ℝ) * (-1 / c) := by
    rw [Finset.sum_congr rfl (fun i hi => (two i).resolve_left (Finset.mem_filter.mp hi).2),
      Finset.sum_const, nsmul_eq_mul]
  rw [hA, hB, h1] at hsplit
  have hc' : c ≠ 0 := hc0.ne'
  have hmul : ((univ.filter fun i => l i = (k - 1) / c).card : ℝ) * k = k := by
    have h := congrArg (· * c) hsplit
    simp only [zero_mul, add_mul, mul_assoc, div_mul_cancel₀ _ hc'] at h
    nlinarith
  have hk0 : k ≠ 0 := by linarith
  have hone : ((univ.filter fun i => l i = (k - 1) / c).card : ℝ) = 1 :=
    mul_right_cancel₀ hk0 (by rw [hmul, one_mul])
  exact_mod_cast hone

/-- Summing a function of a vector that takes one value at `i₀` and another elsewhere. -/
lemma sum_two_valued [DecidableEq ι] (i₀ : ι) (a b : ℝ) (f : ℝ → ℝ) :
    ∑ j, f (if j = i₀ then a else b) = f a + ((Fintype.card ι : ℝ) - 1) * f b := by
  rw [← Finset.add_sum_erase univ _ (mem_univ i₀)]
  rw [Finset.sum_congr rfl (fun j hj => by rw [if_neg (Finset.ne_of_mem_erase hj)]), Finset.sum_const,
    Finset.card_erase_of_mem (mem_univ i₀), Finset.card_univ, nsmul_eq_mul]
  have : 1 ≤ Fintype.card ι := Fintype.card_pos_iff.mpr ⟨i₀⟩
  push_cast [this]; simp

/-- **The bound is attained**: one entry `(k-1)/c` and the other `k-1` entries `-1/c` lie on the unit
trace-free sphere and give `Σ λ³ = (k-2)/c`. -/
theorem cube_sum_attained [DecidableEq ι] (c : ℝ) (hc0 : 0 < c)
    (hc : c ^ 2 = (Fintype.card ι : ℝ) * ((Fintype.card ι : ℝ) - 1)) (i₀ : ι) :
    (∑ j, (if j = i₀ then ((Fintype.card ι : ℝ) - 1) / c else -1 / c)) = 0 ∧
    (∑ j, (if j = i₀ then ((Fintype.card ι : ℝ) - 1) / c else -1 / c) ^ 2) = 1 ∧
    (∑ j, (if j = i₀ then ((Fintype.card ι : ℝ) - 1) / c else -1 / c) ^ 3)
      = ((Fintype.card ι : ℝ) - 2) / c := by
  have e1 := sum_two_valued i₀ (((Fintype.card ι : ℝ) - 1) / c) (-1 / c) id
  have e2 := sum_two_valued i₀ (((Fintype.card ι : ℝ) - 1) / c) (-1 / c) (fun x => x ^ 2)
  have e3 := sum_two_valued i₀ (((Fintype.card ι : ℝ) - 1) / c) (-1 / c) (fun x => x ^ 3)
  simp only [id] at e1 e2 e3
  rw [e1, e2, e3]
  set k : ℝ := (Fintype.card ι : ℝ) with hkdef
  have hc' : c ≠ 0 := hc0.ne'
  have hk1 : k * (k - 1) ≠ 0 := by rw [← hc]; exact pow_ne_zero 2 hc'
  refine ⟨by field_simp; ring, ?_, ?_⟩
  · field_simp
    linear_combination -hc
  · field_simp
    linear_combination -(k - 2) * hc

/-- **The `k = 3` case as one identity**: with `c = -a - b`, `Σλ² = 2(a²+ab+b²)` and `Σλ³ = 3abc`, and
`8(a²+ab+b²)³ - 54 a²b²(a+b)² = 2(a-b)²(2a+b)²(a+2b)²`, which is `(Σλ³)² ≤ (1/6)(Σλ²)³`. -/
theorem three_by_three (a b : ℝ) :
    8 * (a ^ 2 + a * b + b ^ 2) ^ 3 - 54 * a ^ 2 * b ^ 2 * (a + b) ^ 2
      = 2 * (a - b) ^ 2 * (2 * a + b) ^ 2 * (a + 2 * b) ^ 2 := by
  ring

/-- A witness for `cube_sum_le` at `k = 2`: `λ = (1/√2, -1/√2)`, `c = √2`, bound `0`. -/
example : ∑ j : Fin 2, (![1 / Real.sqrt 2, -1 / Real.sqrt 2] j) ^ 3 ≤ ((Fintype.card (Fin 2) : ℝ) - 2) / Real.sqrt 2 := by
  apply cube_sum_le _ (Real.sqrt 2) (by positivity)
  · simp [Real.sq_sqrt (show (0 : ℝ) ≤ 2 by norm_num)]; norm_num
  · norm_num
  · simp [Fin.sum_univ_two]; ring
  · simp [Fin.sum_univ_two, div_pow, Real.sq_sqrt (show (0 : ℝ) ≤ 2 by norm_num)]; norm_num

end HamiltonsCubic.L225Statement
