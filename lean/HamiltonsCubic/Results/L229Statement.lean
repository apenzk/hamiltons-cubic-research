import Mathlib

set_option linter.style.longLine false

/-!
# L229, the common-eigenvector stratum of `G(2)` at fixed total norm

## The claim

[second-order.md](../../../findings/second-order.md)'s Lemma L229. On the stratum where the two free blocks share an
eigenvector of the field frame, the value is the phase sum
`g = 2 l r₂ cos t₁ + 2 l r₁ cos t₂ - 2 l r₁ r₂ cos (t₁ - t₂)` plus terms free of the phases, and

* `g` is capped by `l (1 + r₁² + r₂²)`, the deficit being `l` times the squared distance from `1` to
  `r₂ e^{i t₁} + r₁ e^{i t₂}`, so the cap is attained exactly when `1` lies in the annulus
  `|r₁ - r₂| ≤ |z| ≤ r₁ + r₂`;
* a diagonal pair of blocks is the case `t₁, t₂ ∈ {0, π}`, whose deficit is the square
  `l (1 - e₁ r₂ - e₂ r₁)²`, so cap and diagonal value agree exactly where `1` lies outside the annulus's
  interior, its boundary included;
* with the cap in place the value is affine in `(x, y) = (p², r²)`, and the norm constraint is the
  segment `3x + y = B`, so the maximum over the region where the cap is attained sits on that
  region's boundary, where a diagonal pair attains it.

## What is typed

* `phase_deficit`, `phase_le_cap`: the identity and the cap, proved;
* `collinear_eq_phaseSum`, `collinear_deficit`: the diagonal values and their deficits, proved;
* `cap_attained_of_boundary`: on the annulus boundary a diagonal pair attains the cap, proved;
* `capValue_affine`: the value with the cap in place is affine in `(p², r²)`, proved;
* `diagonal_matches`: the closing step, proved: outside the region the two distances agree, and inside it the
  intermediate value theorem finds a point of the same segment where `collinearDist` vanishes on the side where
  the affine value does not fall.

**Not typed**: the reduction of the block problem to this phase sum, which is
[second-order.md](../../../findings/second-order.md)'s L226 and the derivation's batch 11, and the passage from
`diagonal_matches` back to blocks diagonal in the field frame.
-/

namespace HamiltonsCubic.L229Statement

open Real

/-- **The three-coupling phase sum**, in the scale-free amplitudes `r₁ = β v₂ r / d_A`,
`r₂ = β v₂ p / d_C` and `l = d_A d_C / (β v₂)`. -/
noncomputable def phaseSum (l r₁ r₂ t₁ t₂ : ℝ) : ℝ :=
  2 * l * r₂ * cos t₁ + 2 * l * r₁ * cos t₂ - 2 * l * r₁ * r₂ * cos (t₁ - t₂)

/-- **The cap** `l (1 + r₁² + r₂²)`. -/
noncomputable def phaseCap (l r₁ r₂ : ℝ) : ℝ := l * (1 + r₁ ^ 2 + r₂ ^ 2)

/-- **The value of the phase sum at a diagonal pair of blocks**, `t₁, t₂ ∈ {0, π}`, the signs
carried by `e₁, e₂ ∈ {1, -1}`. -/
noncomputable def collinear (l r₁ r₂ e₁ e₂ : ℝ) : ℝ :=
  2 * l * (e₁ * r₂ + e₂ * r₁ - e₁ * e₂ * r₁ * r₂)

/-- **The identity that runs the lemma**: the deficit against the cap is `l` times the squared
distance from `1` to the point `r₂ e^{i t₁} + r₁ e^{i t₂}` of the plane. -/
theorem phase_deficit (l r₁ r₂ t₁ t₂ : ℝ) :
    phaseCap l r₁ r₂ - phaseSum l r₁ r₂ t₁ t₂
      = l * ((1 - r₂ * cos t₁ - r₁ * cos t₂) ^ 2 + (r₂ * sin t₁ + r₁ * sin t₂) ^ 2) := by
  simp only [phaseCap, phaseSum, Real.cos_sub]
  linear_combination (-(l * r₂ ^ 2)) * Real.sin_sq_add_cos_sq t₁
    + (-(l * r₁ ^ 2)) * Real.sin_sq_add_cos_sq t₂

/-- **The cap holds at every pair of phases.** -/
theorem phase_le_cap (l r₁ r₂ t₁ t₂ : ℝ) (hl : 0 ≤ l) :
    phaseSum l r₁ r₂ t₁ t₂ ≤ phaseCap l r₁ r₂ := by
  have h := phase_deficit l r₁ r₂ t₁ t₂
  nlinarith [sq_nonneg (1 - r₂ * cos t₁ - r₁ * cos t₂), sq_nonneg (r₂ * sin t₁ + r₁ * sin t₂)]

/-- **A diagonal pair is a pair of phases**, `cos t = ±1` and `sin t = 0`. -/
theorem collinear_eq_phaseSum (l r₁ r₂ t₁ t₂ e₁ e₂ : ℝ)
    (h₁ : cos t₁ = e₁) (h₂ : cos t₂ = e₂) (hs₁ : sin t₁ = 0) (hs₂ : sin t₂ = 0) :
    phaseSum l r₁ r₂ t₁ t₂ = collinear l r₁ r₂ e₁ e₂ := by
  simp only [phaseSum, collinear, Real.cos_sub, h₁, h₂, hs₁, hs₂]
  ring

/-- **The deficit of a diagonal pair is an exact square.** -/
theorem collinear_deficit (l r₁ r₂ e₁ e₂ : ℝ) (h₁ : e₁ ^ 2 = 1) (h₂ : e₂ ^ 2 = 1) :
    phaseCap l r₁ r₂ - collinear l r₁ r₂ e₁ e₂ = l * (1 - e₁ * r₂ - e₂ * r₁) ^ 2 := by
  simp only [phaseCap, collinear]
  linear_combination (-(l * r₂ ^ 2)) * h₁ + (-(l * r₁ ^ 2)) * h₂

/-- **On the annulus boundary a diagonal pair attains the cap.** The three cases are
`r₁ + r₂ = 1`, the outer circle, and `r₁ - r₂ = ±1`, the inner one. -/
theorem cap_attained_of_boundary (l r₁ r₂ : ℝ)
    (h : r₁ + r₂ = 1 ∨ r₁ - r₂ = 1 ∨ r₂ - r₁ = 1) :
    ∃ e₁ e₂ : ℝ, e₁ ^ 2 = 1 ∧ e₂ ^ 2 = 1 ∧ collinear l r₁ r₂ e₁ e₂ = phaseCap l r₁ r₂ := by
  rcases h with h | h | h
  · refine ⟨1, 1, by norm_num, by norm_num, ?_⟩
    have hd := collinear_deficit l r₁ r₂ 1 1 (by norm_num) (by norm_num)
    have hz : (1 : ℝ) - 1 * r₂ - 1 * r₁ = 0 := by linarith
    rw [hz] at hd
    simp only [ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, mul_zero] at hd
    linarith
  · refine ⟨-1, 1, by norm_num, by norm_num, ?_⟩
    have hd := collinear_deficit l r₁ r₂ (-1) 1 (by norm_num) (by norm_num)
    have hz : (1 : ℝ) - (-1) * r₂ - 1 * r₁ = 0 := by linarith
    rw [hz] at hd
    simp only [ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, mul_zero] at hd
    linarith
  · refine ⟨1, -1, by norm_num, by norm_num, ?_⟩
    have hd := collinear_deficit l r₁ r₂ 1 (-1) (by norm_num) (by norm_num)
    have hz : (1 : ℝ) - 1 * r₂ - (-1) * r₁ = 0 := by linarith
    rw [hz] at hd
    simp only [ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, mul_zero] at hd
    linarith

/-- The part of the value that does not come from the phases, as a function of `x = p²`
and `y = r²`, with `a = α`, `b = β`. -/
noncomputable def sPart (a b u₂ v₂ ta tc x y : ℝ) : ℝ :=
  a * (3 / 4 * u₂ ^ 3 - 3 * u₂ * x) + b * u₂ * (3 / 4 * v₂ ^ 2 - y) + ta * u₂ + tc * v₂

/-- **With the cap in place the value is affine in `(x, y) = (p², r²)`.** This is what puts the
maximum on the boundary of the region where the cap is attained. -/
theorem capValue_affine (a b u₂ v₂ dA dC ta tc x y : ℝ)
    (hb : b ≠ 0) (hv : v₂ ≠ 0) (hA : dA ≠ 0) (hC : dC ≠ 0) (hx : 0 ≤ x) (hy : 0 ≤ y) :
    sPart a b u₂ v₂ ta tc x y
        + phaseCap (dA * dC / (b * v₂)) (b * v₂ * Real.sqrt y / dA) (b * v₂ * Real.sqrt x / dC)
      = (a * (3 / 4 * u₂ ^ 3) + b * u₂ * (3 / 4 * v₂ ^ 2) + ta * u₂ + tc * v₂
          + dA * dC / (b * v₂))
        + (b * v₂ * dA / dC - 3 * a * u₂) * x + (b * v₂ * dC / dA - b * u₂) * y := by
  have ex : (b * v₂ * Real.sqrt x / dC) ^ 2 = (b * v₂) ^ 2 * x / dC ^ 2 := by
    rw [div_pow, mul_pow, Real.sq_sqrt hx]
  have ey : (b * v₂ * Real.sqrt y / dA) ^ 2 = (b * v₂) ^ 2 * y / dA ^ 2 := by
    rw [div_pow, mul_pow, Real.sq_sqrt hy]
  simp only [sPart, phaseCap, ex, ey]
  field_simp
  ring

/-- The distance from `1` to the annulus `|r₁ - r₂| ≤ |z| ≤ r₁ + r₂`, whose square is the deficit
at the best pair of phases. -/
noncomputable def annulusDist (r₁ r₂ : ℝ) : ℝ := max 0 (max (1 - r₁ - r₂) (|r₁ - r₂| - 1))

/-- The distance from `1` to the four points `± r₁ ± r₂` of the real axis, whose square is the
deficit at the best diagonal pair. -/
noncomputable def collinearDist (r₁ r₂ : ℝ) : ℝ :=
  min |1 - r₁ - r₂| (abs (1 - abs (r₁ - r₂)))

/-- **Outside the region the two distances agree**, since `(1 - r₁ - r₂) + (|r₁ - r₂| - 1) ≤ 0` lets at
most one of the two be positive. -/
theorem collinear_eq_annulus (r₁ r₂ : ℝ) (h₁ : 0 ≤ r₁) (h₂ : 0 ≤ r₂)
    (h : 0 < max (1 - r₁ - r₂) (|r₁ - r₂| - 1)) :
    collinearDist r₁ r₂ = annulusDist r₁ r₂ := by
  unfold collinearDist annulusDist
  rw [max_eq_right h.le]
  have hs : |r₁ - r₂| ≤ r₁ + r₂ := abs_sub_le_iff.mpr ⟨by linarith, by linarith⟩
  rcases le_total (|r₁ - r₂| - 1) (1 - r₁ - r₂) with hk | hk
  · rw [max_eq_left hk] at h ⊢
    rw [abs_of_pos h, abs_of_pos (show 0 < 1 - |r₁ - r₂| by linarith), min_eq_left (by linarith)]
  · rw [max_eq_right hk] at h ⊢
    rw [abs_of_neg (show 1 - r₁ - r₂ < 0 by linarith), abs_of_neg (show 1 - |r₁ - r₂| < 0 by linarith),
      min_eq_right (by linarith)]
    ring

/-- **On the region's boundary the diagonal deficit vanishes.** -/
theorem collinear_zero (r₁ r₂ : ℝ) (h : max (1 - r₁ - r₂) (|r₁ - r₂| - 1) = 0) :
    collinearDist r₁ r₂ = 0 := by
  unfold collinearDist
  rcases max_choice (1 - r₁ - r₂) (|r₁ - r₂| - 1) with hc | hc
  · rw [hc] at h; rw [h, abs_zero]; exact min_eq_left (abs_nonneg _)
  · rw [hc] at h
    rw [show 1 - |r₁ - r₂| = 0 by linarith, abs_zero]; exact min_eq_right (abs_nonneg _)

theorem annulus_zero (r₁ r₂ : ℝ) (h : max (1 - r₁ - r₂) (|r₁ - r₂| - 1) ≤ 0) : annulusDist r₁ r₂ = 0 := by
  unfold annulusDist; exact max_eq_left h

/-- At an end of the segment one radius is `0`, and the region's defining max is `|1 - r| ≥ 0`. -/
theorem end_nonneg (r : ℝ) (hr : 0 ≤ r) : 0 ≤ max (1 - 0 - r) (|0 - r| - 1) := by
  rw [zero_sub, abs_neg, abs_of_nonneg hr]
  rcases le_total r 1 with h | h
  · exact le_max_of_le_left (by linarith)
  · exact le_max_of_le_right (by linarith)

theorem end_nonneg' (r : ℝ) (hr : 0 ≤ r) : 0 ≤ max (1 - r - 0) (|r - 0| - 1) := by
  rw [sub_zero, sub_zero, abs_of_nonneg hr]
  rcases le_total r 1 with h | h
  · exact le_max_of_le_left (by linarith)
  · exact le_max_of_le_right (by linarith)

/-- **The closing step, PROVED by the intermediate value theorem.** On the norm segment `3x + y = B` the free value is
matched by the diagonal value somewhere on the same segment: the free value is affine wherever
`annulusDist` vanishes, so its maximum there sits at a point of that region's boundary, where
`collinearDist` vanishes too. -/
theorem diagonal_matches (c₀ c₁ c₂ l bv dA dC B : ℝ) (hl : 0 ≤ l) (hB : 0 ≤ B)
    (hA : 0 < dA) (hC : 0 < dC) (hbv : 0 < bv)
    (x y : ℝ) (hx : 0 ≤ x) (hy : 0 ≤ y) (hxy : 3 * x + y = B) :
    ∃ x' y' : ℝ, 0 ≤ x' ∧ 0 ≤ y' ∧ 3 * x' + y' = B ∧
      (c₀ + c₁ * x + c₂ * y
          - l * annulusDist (bv * Real.sqrt y / dA) (bv * Real.sqrt x / dC) ^ 2)
        ≤ (c₀ + c₁ * x' + c₂ * y'
          - l * collinearDist (bv * Real.sqrt y' / dA) (bv * Real.sqrt x' / dC) ^ 2) := by
  have hxB : x ≤ B / 3 := by linarith
  obtain rfl : y = B - 3 * x := by linarith
  set φ : ℝ → ℝ := fun t => max (1 - bv * Real.sqrt (B - 3 * t) / dA - bv * Real.sqrt t / dC)
    (|bv * Real.sqrt (B - 3 * t) / dA - bv * Real.sqrt t / dC| - 1) with hφ
  have hcont : Continuous φ := by fun_prop
  have r1nn : ∀ t, 0 ≤ bv * Real.sqrt (B - 3 * t) / dA := fun t => by positivity
  have r2nn : ∀ t, 0 ≤ bv * Real.sqrt t / dC := fun t => by positivity
  have hend : 0 ≤ φ (B / 3) := by
    simp only [hφ]
    rw [show B - 3 * (B / 3) = 0 by ring, Real.sqrt_zero, mul_zero, zero_div]
    exact end_nonneg _ (r2nn _)
  have hstart : 0 ≤ φ 0 := by
    simpa [hφ] using end_nonneg' (bv * Real.sqrt B / dA) (by positivity)
  by_cases hin : φ x ≤ 0
  · have hA0 : annulusDist (bv * Real.sqrt (B - 3 * x) / dA) (bv * Real.sqrt x / dC) = 0 :=
      annulus_zero _ _ hin
    rcases le_total 0 (c₁ - 3 * c₂) with hc | hc
    · obtain ⟨t, ⟨ht1, ht2⟩, hφt⟩ := intermediate_value_Icc hxB hcont.continuousOn ⟨hin, hend⟩
      refine ⟨t, B - 3 * t, by linarith, by linarith, by ring, ?_⟩
      rw [hA0, collinear_zero _ _ hφt]
      nlinarith [mul_nonneg hc (sub_nonneg.mpr ht1)]
    · obtain ⟨t, ⟨ht1, ht2⟩, hφt⟩ := intermediate_value_Icc' hx hcont.continuousOn ⟨hin, hstart⟩
      refine ⟨t, B - 3 * t, ht1, by linarith, by ring, ?_⟩
      rw [hA0, collinear_zero _ _ hφt]
      nlinarith [mul_nonneg_of_nonpos_of_nonpos hc (sub_nonpos.mpr ht2)]
  · push_neg at hin
    refine ⟨x, B - 3 * x, hx, hy, by ring, ?_⟩
    rw [collinear_eq_annulus _ _ (r1nn x) (r2nn x) hin]

end HamiltonsCubic.L229Statement
