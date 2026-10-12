import HamiltonsCubic.Results.L42Statement
import HamiltonsCubic.Results.L35Mono

set_option linter.style.longLine false

/-!
# L35's packing bound: from a spectrum and a feasible bracket tensor to `√(3/2)`

[findings/stratum-two-negative.md](../../../findings/stratum-two-negative.md), Lemma L35: with at most two negative
eigenvalues `−b, −c`, the cubic `∑λ³ + 3∑_{α<β<γ}T_{αβγ}λ_αλ_βλ_γ` splits by sign class. The `(+++)` part is a
triangle packing `t` under pair caps `≤ 2`, the `(+−−)` part a column `τ` on the pair of negatives under the same
cap, and the `(++−)` part is nonpositive. **This file proves the chain from that split to `√(3/2)`**, REVIEW_r63's
steps 1 to 4 with the relaxation `R(A, s, u)`:

- `dual_general`: weak duality at any dual weight `μ` dominating the harmonic mean of every distinct triple, the
  argument of [L42Statement.lean](L42Statement.lean)'s `sharp_dual_weight` without sorting;
- `hm_le_of_le`, `hm_le_K0`: every triple's harmonic mean is at most `A` and at most `K₀√d`, the second by dropping
  the top entry and `8y²z² ≤ (y + z)²(y² + z²)`, so `μ = min(A, K₀√d)` qualifies (REVIEW_r63's L3);
- `cube_sum_le`: `∑λ³ ≤ A³ + min(A, √d)d` (L4);
- `packing_le_R3`: the whole cubic is at most `R(A, s, d)`, the `(+−−)` column contributing at most `6A·bc`;
- **`packing_le`**: with [L35Mono.lean](L35Mono.lean)'s `R3_le`, at most `√(3/2)`.
-/

namespace HamiltonsCubic.L35Residual

open Finset HamiltonsCubic.L42Statement

variable {k : ℕ}

/-- **Weak duality at any dual weight** that dominates the harmonic mean of every distinct triple. -/
theorem dual_general (t : Fin k → Fin k → Fin k → ℝ) (lam : Fin k → ℝ) (hpos : ∀ i, 0 < lam i)
    (hft : Feasible t) (μ : ℝ) (hμ0 : 0 ≤ μ)
    (hμ : ∀ α β γ : Fin k, α ≠ β → α ≠ γ → β ≠ γ → harmonicMean (lam α) (lam β) (lam γ) ≤ μ) :
    3 * objective t lam ≤ μ * ((∑ i, lam i) ^ 2 - ∑ i, lam i ^ 2) := by
  have h6 : distinctSum (fun α β γ => t α β γ * (lam α * lam β * lam γ)) = 6 * objective t lam := by
    rw [distinctSum_eq_six, objective_eq_increasingSum]
    · intro α β γ
      rw [hft.symm12 α β γ]
      ring
    · intro α β γ
      rw [hft.symm23 α β γ]
      ring
  have hpt : 3 * distinctSum (fun α β γ => t α β γ * (lam α * lam β * lam γ))
      ≤ μ * distinctSum (fun α β γ => t α β γ * (lam α * lam β))
        + μ * distinctSum (fun α β γ => t α β γ * (lam β * lam γ))
        + μ * distinctSum (fun α β γ => t α β γ * (lam α * lam γ)) := by
    simp only [distinctSum, Finset.mul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_le_sum fun α _ => Finset.sum_le_sum fun β _ =>
      Finset.sum_le_sum fun γ _ => ?_
    by_cases hP : α ≠ β ∧ α ≠ γ ∧ β ≠ γ
    · simp only [if_pos hP]
      obtain ⟨h1, h2, h3⟩ := hP
      have hc := triple_constraint (lam α) (lam β) (lam γ) (μ / 3) (hpos α) (hpos β) (hpos γ)
        (by have := hμ α β γ h1 h2 h3; linarith)
      have hm := mul_le_mul_of_nonneg_left hc (hft.nonneg α β γ)
      nlinarith
    · simp only [if_neg hP]
      norm_num
  rw [distinctSum_rel23 t lam hft, distinctSum_rel13 t lam hft, h6] at hpt
  have hA := distinctSum_pair_le t lam hpos hft
  rw [offDiag_eq] at hA
  have hm := mul_le_mul_of_nonneg_left hA hμ0
  nlinarith

theorem hm_le_of_le (x y z A : ℝ) (hx : 0 < x) (hy : 0 < y) (hz : 0 < z) (hxA : x ≤ A) (hyA : y ≤ A)
    (hzA : z ≤ A) : harmonicMean x y z ≤ A := by
  unfold harmonicMean
  have hs : 0 < 1 / x + 1 / y + 1 / z := by positivity
  rw [div_le_iff₀ hs]
  have h1 : 1 ≤ A * (1 / x) := by rw [mul_one_div, le_div_iff₀ hx]; linarith
  have h2 : 1 ≤ A * (1 / y) := by rw [mul_one_div, le_div_iff₀ hy]; linarith
  have h3 : 1 ≤ A * (1 / z) := by rw [mul_one_div, le_div_iff₀ hz]; linarith
  nlinarith

/-- `HM(x, y, z) ≤ K₀ √(y² + z²)`: dropping `1/x` and `8y²z² ≤ (y + z)²(y² + z²)`. -/
theorem hm_le_K0 (x y z : ℝ) (hx : 0 < x) (hy : 0 < y) (hz : 0 < z) :
    harmonicMean x y z ≤ 3 / (2 * Real.sqrt 2) * Real.sqrt (y ^ 2 + z ^ 2) := by
  have h1 : harmonicMean x y z ≤ 3 * y * z / (y + z) := by
    unfold harmonicMean
    rw [div_le_div_iff₀ (by positivity) (by positivity)]
    field_simp
    nlinarith [mul_pos (mul_pos hx hy) hz, mul_pos hy hz, mul_pos (mul_pos hy hz) (mul_pos hy hz)]
  refine le_trans h1 ?_
  have hq : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have hq0 : 0 < Real.sqrt 2 := by positivity
  have hr : Real.sqrt (y ^ 2 + z ^ 2) ^ 2 = y ^ 2 + z ^ 2 := Real.sq_sqrt (by positivity)
  have hr0 : 0 ≤ Real.sqrt (y ^ 2 + z ^ 2) := Real.sqrt_nonneg _
  rw [div_le_iff₀ (by positivity)]
  have key : (3 * y * z) ^ 2 ≤ (3 / (2 * Real.sqrt 2) * Real.sqrt (y ^ 2 + z ^ 2) * (y + z)) ^ 2 := by
    have e : (3 / (2 * Real.sqrt 2) * Real.sqrt (y ^ 2 + z ^ 2) * (y + z)) ^ 2
        = 9 / 8 * (y ^ 2 + z ^ 2) * (y + z) ^ 2 := by
      have : (3 / (2 * Real.sqrt 2)) ^ 2 = 9 / 8 := by rw [div_pow, mul_pow, hq]; norm_num
      rw [mul_pow, mul_pow, this, hr]
    rw [e]
    nlinarith [sq_nonneg (y - z), mul_pos hy hz, sq_nonneg (y ^ 2 - z ^ 2), mul_nonneg (sq_nonneg (y - z)) (mul_pos hy hz).le]
  have hpos : 0 ≤ 3 / (2 * Real.sqrt 2) * Real.sqrt (y ^ 2 + z ^ 2) * (y + z) := by positivity
  nlinarith [sq_nonneg (3 * y * z - 3 / (2 * Real.sqrt 2) * Real.sqrt (y ^ 2 + z ^ 2) * (y + z)),
    mul_pos (mul_pos hy hz) (by norm_num : (0:ℝ) < 3)]

theorem erase_sq (lam : Fin k → ℝ) (i0 : Fin k) :
    ∑ i ∈ univ.erase i0, lam i ^ 2 = ∑ i, lam i ^ 2 - lam i0 ^ 2 := by
  rw [← Finset.add_sum_erase _ _ (mem_univ i0)]; ring

theorem pair_sq_le (lam : Fin k → ℝ) (i0 j l : Fin k) (hj : j ≠ i0) (hl : l ≠ i0) (hjl : j ≠ l) :
    lam j ^ 2 + lam l ^ 2 ≤ ∑ i, lam i ^ 2 - lam i0 ^ 2 := by
  rw [← erase_sq]
  have hsub : ({j, l} : Finset (Fin k)) ⊆ univ.erase i0 := by
    intro x hx
    simp only [mem_insert, mem_singleton] at hx
    rcases hx with rfl | rfl <;> simp [hj, hl]
  have := Finset.sum_le_sum_of_subset_of_nonneg hsub (fun i _ _ => sq_nonneg (lam i))
  rwa [Finset.sum_pair hjl] at this

theorem one_sq_le (lam : Fin k → ℝ) (i0 j : Fin k) (hj : j ≠ i0) :
    lam j ^ 2 ≤ ∑ i, lam i ^ 2 - lam i0 ^ 2 := by
  rw [← erase_sq]
  exact Finset.single_le_sum (fun i _ => sq_nonneg (lam i)) (mem_erase.mpr ⟨hj, mem_univ j⟩)

/-- **`∑_P λ³ ≤ A³ + min(A, √d) d`**, REVIEW_r63's L4. -/
theorem cube_sum_le (lam : Fin k → ℝ) (hpos : ∀ i, 0 < lam i) (i0 : Fin k) (htop : ∀ i, lam i ≤ lam i0) :
    ∑ i, lam i ^ 3 ≤ lam i0 ^ 3 + min (lam i0) (Real.sqrt (∑ i, lam i ^ 2 - lam i0 ^ 2))
      * (∑ i, lam i ^ 2 - lam i0 ^ 2) := by
  set d := ∑ i, lam i ^ 2 - lam i0 ^ 2
  rw [← Finset.add_sum_erase _ _ (mem_univ i0)]
  have hd : ∑ i ∈ univ.erase i0, lam i ^ 2 = d := erase_sq lam i0
  have hterm : ∀ i ∈ univ.erase i0, lam i ^ 3 ≤ min (lam i0) (Real.sqrt d) * lam i ^ 2 := by
    intro i hi
    have hne : i ≠ i0 := (mem_erase.mp hi).1
    have h1 : lam i ≤ Real.sqrt d := by
      rw [← Real.sqrt_sq (hpos i).le]; exact Real.sqrt_le_sqrt (one_sq_le lam i0 i hne)
    have hm : lam i ≤ min (lam i0) (Real.sqrt d) := le_min (htop i) h1
    have : lam i ^ 3 = lam i * lam i ^ 2 := by ring
    rw [this]; exact mul_le_mul_of_nonneg_right hm (sq_nonneg _)
  have := Finset.sum_le_sum hterm
  rw [← Finset.mul_sum, hd] at this
  linarith

theorem hm_perm12 (x y z : ℝ) : harmonicMean x y z = harmonicMean y x z := by unfold harmonicMean; ring_nf
theorem hm_perm13 (x y z : ℝ) : harmonicMean x y z = harmonicMean z y x := by unfold harmonicMean; ring_nf

/-- **The packing bound**: a positive spectrum `λ` with top entry `A = λ_{i₀}`, a feasible `(+++)` tensor `t`, a
`(+−−)` column `τ` under its pair cap, negatives `−b, −c` with `∑λ = b + c` and unit norm, and any nonpositive
`(++−)` contribution `−N`: the cubic is at most `R(A, s, d)`. -/
theorem packing_le_R3 (lam : Fin k → ℝ) (hpos : ∀ i, 0 < lam i) (i0 : Fin k) (htop : ∀ i, lam i ≤ lam i0)
    (t : Fin k → Fin k → Fin k → ℝ) (hft : Feasible t) (τ : Fin k → ℝ) (hτ0 : ∀ a, 0 ≤ τ a) (hτ : ∑ a, τ a ≤ 2)
    (b c : ℝ) (hb : 0 ≤ b) (hc : 0 ≤ c) (hs : ∑ i, lam i = b + c)
    (hn : ∑ i, lam i ^ 2 + b ^ 2 + c ^ 2 = 1) (N : ℝ) (hN : 0 ≤ N) :
    ∑ i, lam i ^ 3 - b ^ 3 - c ^ 3 + 3 * objective t lam + 3 * (∑ a, τ a * lam a) * b * c - N
      ≤ R3 (lam i0) (b + c) (∑ i, lam i ^ 2 - lam i0 ^ 2) := by
  set A := lam i0 with hAdef
  set d := ∑ i, lam i ^ 2 - A ^ 2 with hddef
  have hA : 0 < A := hpos i0
  have hK0 : 0 ≤ 3 / (2 * Real.sqrt 2) := by positivity
  -- the dual weight
  have hμ : ∀ α β γ : Fin k, α ≠ β → α ≠ γ → β ≠ γ →
      harmonicMean (lam α) (lam β) (lam γ) ≤ min A (3 / (2 * Real.sqrt 2) * Real.sqrt d) := by
    intro α β γ h1 h2 h3
    refine le_min (hm_le_of_le _ _ _ _ (hpos α) (hpos β) (hpos γ) (htop α) (htop β) (htop γ)) ?_
    have key : ∀ x y z : Fin k, y ≠ i0 → z ≠ i0 → y ≠ z →
        harmonicMean (lam x) (lam y) (lam z) ≤ 3 / (2 * Real.sqrt 2) * Real.sqrt d := fun x y z hy hz hyz =>
      le_trans (hm_le_K0 _ _ _ (hpos x) (hpos y) (hpos z))
        (mul_le_mul_of_nonneg_left (Real.sqrt_le_sqrt (pair_sq_le lam i0 y z hy hz hyz)) hK0)
    by_cases ha : α = i0
    · exact key α β γ (fun h => h1 (ha.trans h.symm)) (fun h => h2 (ha.trans h.symm)) h3
    · by_cases hb' : β = i0
      · rw [hm_perm12]; exact key β α γ ha (fun h => h3 (hb'.trans h.symm)) h2
      · by_cases hg : γ = i0
        · rw [hm_perm13]; exact key γ β α hb' ha (Ne.symm h1)
        · exact key α β γ hb' hg h3
  have hdual := dual_general t lam hpos hft _ (le_min hA.le (by positivity)) hμ
  have hcube := cube_sum_le lam hpos i0 htop
  have hτA : ∑ a, τ a * lam a ≤ 2 * A := by
    have : ∑ a, τ a * lam a ≤ ∑ a, τ a * A :=
      Finset.sum_le_sum fun a _ => mul_le_mul_of_nonneg_left (htop a) (hτ0 a)
    rw [← Finset.sum_mul] at this; nlinarith
  have hbc0 : 0 ≤ b * c := mul_nonneg hb hc
  have hτbc : 3 * (∑ a, τ a * lam a) * b * c ≤ 6 * A * (b * c) := by nlinarith
  have hbc : b * c = ((b + c) ^ 2 - 1 + (A ^ 2 + d)) / 2 := by rw [hddef]; nlinarith
  unfold R3
  rw [hs] at hdual
  have hu : ∑ i, lam i ^ 2 = A ^ 2 + d := by rw [hddef]; ring
  rw [hu] at hdual
  have hcube' : ∑ i, lam i ^ 3 ≤ A ^ 3 + min A (Real.sqrt d) * d := hcube
  rw [← hbc]
  have hcubes : -b ^ 3 - c ^ 3 + 6 * A * (b * c) = -(b + c) ^ 3 + 3 * (b * c) * (b + c + 2 * A) := by ring
  linarith [hcube', hdual, hτbc, hcubes, hN]

/-- **THE PACKING BOUND IS `√(3/2)`**: under `packing_le_R3`'s hypotheses the cubic is at most `√(3/2)`. -/
theorem packing_le (lam : Fin k → ℝ) (hpos : ∀ i, 0 < lam i) (i0 : Fin k) (htop : ∀ i, lam i ≤ lam i0)
    (t : Fin k → Fin k → Fin k → ℝ) (hft : Feasible t) (τ : Fin k → ℝ) (hτ0 : ∀ a, 0 ≤ τ a) (hτ : ∑ a, τ a ≤ 2)
    (b c : ℝ) (hb : 0 ≤ b) (hc : 0 ≤ c) (hs : ∑ i, lam i = b + c)
    (hn : ∑ i, lam i ^ 2 + b ^ 2 + c ^ 2 = 1) (N : ℝ) (hN : 0 ≤ N) :
    ∑ i, lam i ^ 3 - b ^ 3 - c ^ 3 + 3 * objective t lam + 3 * (∑ a, τ a * lam a) * b * c - N
      ≤ Real.sqrt (3 / 2) := by
  refine le_trans (packing_le_R3 lam hpos i0 htop t hft τ hτ0 hτ b c hb hc hs hn N hN) ?_
  have hd : 0 ≤ ∑ i, lam i ^ 2 - lam i0 ^ 2 := by
    have := Finset.single_le_sum (fun i _ => sq_nonneg (lam i)) (mem_univ i0) (f := fun i => lam i ^ 2)
    linarith
  refine R3_le _ _ _ (hpos i0) hd (by linarith) ?_ ?_
  · nlinarith [mul_nonneg hb hc]
  · nlinarith [sq_nonneg (b - c)]

end HamiltonsCubic.L35Residual
