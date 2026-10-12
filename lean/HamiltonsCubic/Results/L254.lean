import Mathlib

set_option linter.style.longLine false

/-!
# L254's structural half: the step from the certificate to the bound

[sym3-stability.md](../../../findings/sym3-stability.md), Lemma L254: *on `𝒲₁₂`,
`f₁₂(R) = (55/36)|R|⁶ - ⟨Q(R), R⟩²` is a sum of `170` positive rational multiples of squared norms of
`O(12)`-equivariant cubic maps. Hence `⟨Q(R), R⟩ ≤ Θ₁₂|R|³`, attained at `S⁶ × S⁶`, so `M(12) = Θ₁₂`.* **The
certificate itself is an outside generator's `22 915 × 477` table, outside version control, and is not
formalised here.** What this file proves is the arithmetic the block derives from it:

* **`sos_nonneg`**: a finite sum of positive multiples of squares is nonnegative;
* **`bound_of_certificate`**: if `(55/36)N⁶ - x² = Σ cₖ sₖ²` with `cₖ > 0` and `N ≥ 0`, then `|x| ≤ Θ₁₂ N³`,
  `Θ₁₂ = √55/6`, which is the step from the certificate to the bound, both signs of `⟨Q(R), R⟩` included;
* **`theta12_sq`**: `Θ₁₂² = 55/36 = θ₀(12)² = 2·11·10/12²`;
* **`ratio_eq_record`**: the certificate's two-sphere ratio `11(p-1)(q-1)/(5pq)` is the record's
  `θ(S^p × S^q)² = 2(n-1)(p-1)(q-1)/((n-2)pq)` at `n = 12`, **at every split**, so the ratio the block quotes for
  the certificate agrees with the record's formula on the whole two-sphere family and not only at the balanced
  point. This compares two printed formulas, the certificate's ratio being taken as the block quotes it;
* **`ratio_le_balanced`**: on `p + q = 12` the ratio is at most `55/36`, with equality exactly at `p = q = 6`,
  a maximum of a closed form over splits that evaluates no tensor.

**Owed**, three things. The certificate identity itself, over the outside tables, and the independent computation
of the `71` block scales `κ_λ` that the block names as the check lifting its qualification, are computations and are
not started on the analysis-only footing. The identification of the certificate's `⟨Q(R), R⟩` (FORMULA.md's `Q`,
four-index norm) with the record's `P` is analysis, and the attainment at `S⁶ × S⁶` and `M(12) = Θ₁₂` both rest on
it. The equality case is not claimed by the block and is not typed.
-/

namespace HamiltonsCubic.L254

open Finset

/-- **A finite sum of positive multiples of squares is nonnegative.** -/
theorem sos_nonneg {k : ℕ} (c s : Fin k → ℝ) (hc : ∀ i, 0 < c i) : 0 ≤ ∑ i, c i * s i ^ 2 :=
  sum_nonneg fun i _ => mul_nonneg (hc i).le (sq_nonneg _)

/-- `Θ₁₂ = √55/6`. -/
noncomputable def Theta12 : ℝ := Real.sqrt 55 / 6

/-- **`Θ₁₂² = 55/36 = θ₀(12)²`**, with `θ₀(n)² = 2(n-1)(n-2)/n²`. -/
theorem theta12_sq : Theta12 ^ 2 = 55 / 36 ∧ (55 : ℝ) / 36 = 2 * (12 - 1) * (12 - 2) / 12 ^ 2 := by
  refine ⟨?_, by norm_num⟩
  unfold Theta12
  rw [div_pow, Real.sq_sqrt (by norm_num)]; norm_num

/-- **From the certificate to the bound**: `(55/36)N⁶ - x² = Σ cₖ sₖ²` with `cₖ > 0` and `N ≥ 0` gives
`|x| ≤ Θ₁₂ N³`. -/
theorem bound_of_certificate {k : ℕ} (c s : Fin k → ℝ) (hc : ∀ i, 0 < c i) {x N : ℝ} (hN : 0 ≤ N)
    (hcert : 55 / 36 * N ^ 6 - x ^ 2 = ∑ i, c i * s i ^ 2) : |x| ≤ Theta12 * N ^ 3 := by
  have h0 := sos_nonneg c s hc
  have hsq : x ^ 2 ≤ (Theta12 * N ^ 3) ^ 2 := by
    rw [mul_pow, theta12_sq.1]; nlinarith
  have hT : 0 ≤ Theta12 * N ^ 3 := by unfold Theta12; positivity
  exact abs_le.mpr (abs_le_of_sq_le_sq' hsq hT)

/-- **The certificate's two-sphere ratio is the record's `θ(S^p × S^q)²` at `n = 12`, at every split.** -/
theorem ratio_eq_record (p q : ℝ) (hp : p ≠ 0) (hq : q ≠ 0) (hpq : p + q = 12) :
    11 * (p - 1) * (q - 1) / (5 * p * q) = 2 * ((p + q) - 1) * (p - 1) * (q - 1) / (((p + q) - 2) * p * q) := by
  rw [hpq]; field_simp; ring

/-- **On `p + q = 12` the ratio is at most `55/36`, with equality exactly at `p = q = 6`.** -/
theorem ratio_le_balanced (p q : ℝ) (hp : 0 < p) (hq : 0 < q) (hpq : p + q = 12) :
    11 * (p - 1) * (q - 1) / (5 * p * q) ≤ 55 / 36 ∧
      (11 * (p - 1) * (q - 1) / (5 * p * q) = 55 / 36 ↔ p = 6 ∧ q = 6) := by
  have hpq0 : 0 < 5 * p * q := by positivity
  -- `(p-1)(q-1) = pq - 11`, and `pq ≤ 36` with equality iff `p = q = 6`
  have hprod : p * q ≤ 36 := by nlinarith [sq_nonneg (p - q)]
  have key : 11 * (p - 1) * (q - 1) / (5 * p * q) = 55 / 36 - 11 * 11 * (36 - p * q) / (180 * p * q) := by
    have : q = 12 - p := by linarith
    subst this; field_simp; ring
  have hpos : 0 < 180 * p * q := by positivity
  refine ⟨?_, ?_⟩
  · rw [key]
    have : 0 ≤ 11 * 11 * (36 - p * q) / (180 * p * q) := div_nonneg (by nlinarith) hpos.le
    linarith
  · rw [key]
    constructor
    · intro h
      have h1 : 11 * 11 * (36 - p * q) / (180 * p * q) = 0 := by linarith
      rw [div_eq_zero_iff] at h1
      rcases h1 with h1 | h1
      · have hpq36 : p * q = 36 := by linarith
        have : (p - q) ^ 2 = 0 := by nlinarith
        have : p = q := by nlinarith [sq_nonneg (p - q)]
        constructor <;> linarith
      · linarith
    · rintro ⟨rfl, rfl⟩; norm_num

end HamiltonsCubic.L254
