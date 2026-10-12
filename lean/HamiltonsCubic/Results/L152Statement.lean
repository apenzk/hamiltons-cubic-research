import Mathlib

set_option linter.style.longLine false

/-!
# L152, REFUTED AS STATED: the numerator identity holds, the constant it was built into has no range, and the disagreement it claimed to resolve was never one

The record's block, quoted verbatim from
[second-order.md](../../../findings/second-order.md):

> **WHAT SURVIVES:** `max_Γ |ζ| = (1+α)g_n`, the numerator identity below, for any complex centre.
> **WHAT FALLS, IN TWO PLACES.** *The constant it was built into is stated with no range and is false
> outside it*: `W*` is symmetric, so `max_Γ ‖(W* − ζ)⁻¹‖ = 1/(d·g_n)` with `d = min(α, D−α)` and
> `D = (2m−1)/(m−1)`, while r456 and this lemma both use `1/(α g_n)` unconditionally, valid only for
> `α ≤ D/2`, and **at r456's own optimum `(4/3, 2/3)` at `m = 6` the true constant is `17.9` against
> the recorded `3.5`.** *And the disagreement it claimed to resolve was never one*: r457 never
> estimates `max_Γ |ζ|`, its `m/(m−1)` is `‖W*‖_op/g_n` multiplying the **second** term of r447's
> decomposition, where it is exact. **Two valid bounds by different routes, and r457 stays inside
> `α < 1 < D/2`, so it never commits the resolvent error.** *The claimed `20%` gap is the `α → 0`
> limit; at the true optimum it is `9.5%`.*

> **THE NUMERATOR IS `max_Γ |ζ|`, AND ON A CIRCLE ABOUT `λ₋` IT IS `|λ₋| + α g_n = (1+α)g_n`.** *So
> the numerator is set by the eigenvalue the contour **encloses**, together with the contour's own
> radius.* **r457's `m/(m−1)` is `λ₊/g_n`**, the **positive** eigenvalue, which `Γ` does not enclose
> and whose magnitude therefore never bounds `|ζ|` on `Γ`.

and the ratio the trace-freeness supplies:

> *`g_n` is the analyticity radius `dist(spec, 0)`, so the equality needs `λ₊ > |λ₋|`, and
> trace-freeness supplies it: `λ₊ m(m−1) + λ₋ m² = 0` gives `λ₊/|λ₋| = m/(m−1) > 1`, available at
> `Sᵐ × Sᵐ` and nowhere claimed beyond it.*

## What this file types

* `max_abs_on_circle`, **the survivor**, in the generality the record claims it in: on the circle of
  radius `r` about any complex centre `c`, `max |ζ| = |c| + r`, with the bound proved and the
  maximiser exhibited. Its specialisation `numerator_identity` gives `(1+α)g_n`.
* `lambda_plus_ratio` and `gap_D`, trace-freeness gives `λ₊/|λ₋| = m/(m−1)`, hence
  `(λ₊ − λ₋)/g_n = D = (2m−1)/(m−1)`.
* `dist_circle_to_point`, the geometry behind the resolvent's kink: the distance from the circle of
  radius `r` about `c` to a point at distance `R` from `c` is `|R − r|`, proved and attained. Its
  specialisation `spectral_distance` gives `dist(Γ, spec W*) = min(α, D−α)·g_n`.
* `kink_at_half_D`, `min(α, D−α) = α` exactly on `α ≤ D/2`, which is the range the recorded
  constant `1/(α g_n)` is silently valid on.
* `r456_optimum_understates`, the two constants at `(α,γ) = (4/3, 2/3)`, `m = 6`: `2100/117` against
  the recorded `7/2`.
* `r457_stays_below_the_kink`, `α < 1 < D/2` for every `m ≥ 2`, so r457's route never meets the kink.
* `r441_check` and `r457_never_returns_six`, `(1+α)/(α−γ) = 6` exactly at `(1/2, 1/4)`, while
  `(α + m/(m−1))/(α−γ)` exceeds `6` at every finite `m` and returns it only in the limit.
* `gap_is_twenty_percent_only_at_zero`, the claimed `20%` is the `α → 0` limit; at `α* = D/2` the
  ratio is `23/21`.

## What is NOT typed here

* **`max_Γ ‖(W* − ζ)⁻¹‖ = 1/dist(Γ, spec W*)`**, the classical resolvent identity for a symmetric
  operator. It is an external theorem, not a claim of this record, and only the geometric half, the
  distance itself, is typed here; the operator half is neither proved nor assumed as a hypothesis.
* **The Riesz contour bound** `‖W₋‖ ≤ (1/2π)·(length)·(max|ζ|)·(max‖resolvent‖)` and the passage from
  it to `M ≤ Cγg_n`, which the record itself says needs five factors where the display carries three
  and attributes to [L156](../../../findings/second-order.md).
* **That r457's `m/(m−1)` multiplies the second term of r447's decomposition**, a claim about what
  is written in two reviews, not a mathematical one.
* **The identification of `1.596764`-style numerals with the spectra of the named spaces.**
-/

namespace HamiltonsCubic.L152Statement

/-! ## The survivor: the numerator identity, at any complex centre -/

/-- **`max_Γ |ζ| = |c| + r`** on the circle of radius `r` about `c`, the bound, and a maximiser.
This is L152's surviving claim, and the record's "for any complex centre" is exactly the generality
proved here. -/
theorem max_abs_on_circle (c : ℂ) (r : ℝ) (hr : 0 ≤ r) :
    (∀ z : ℂ, ‖z - c‖ = r → ‖z‖ ≤ ‖c‖ + r) ∧ ∃ z : ℂ, ‖z - c‖ = r ∧ ‖z‖ = ‖c‖ + r := by
  constructor
  · intro z hz
    have hzc : c + (z - c) = z := by ring
    calc ‖z‖ = ‖c + (z - c)‖ := by rw [hzc]
      _ ≤ ‖c‖ + ‖z - c‖ := norm_add_le _ _
      _ = ‖c‖ + r := by rw [hz]
  · rcases eq_or_ne c 0 with rfl | hc
    · refine ⟨(r : ℂ), ?_, ?_⟩ <;> simp [abs_of_nonneg hr]
    · have hcn : 0 < ‖c‖ := norm_pos_iff.mpr hc
      refine ⟨((1 + r / ‖c‖ : ℝ) : ℂ) * c, ?_, ?_⟩
      · have e : ((1 + r / ‖c‖ : ℝ) : ℂ) * c - c = ((r / ‖c‖ : ℝ) : ℂ) * c := by push_cast; ring
        rw [e, norm_mul, Complex.norm_real, Real.norm_eq_abs,
          abs_of_nonneg (by positivity : (0:ℝ) ≤ r / ‖c‖)]
        field_simp
      · rw [norm_mul, Complex.norm_real, Real.norm_eq_abs,
          abs_of_nonneg (by positivity : (0:ℝ) ≤ 1 + r / ‖c‖)]
        field_simp

/-- **The specialisation the record states.** With `Γ` the circle of radius `α g` about `λ₋` and
`|λ₋| = g`, the numerator is `(1+α)g`: set by the eigenvalue the contour encloses and the contour's
own radius, with `λ₊` nowhere in it. -/
theorem numerator_identity (lm : ℂ) (g alpha : ℝ) (hg : 0 ≤ g) (ha : 0 ≤ alpha)
    (hlm : ‖lm‖ = g) :
    (∀ z : ℂ, ‖z - lm‖ = alpha * g → ‖z‖ ≤ (1 + alpha) * g)
      ∧ ∃ z : ℂ, ‖z - lm‖ = alpha * g ∧ ‖z‖ = (1 + alpha) * g := by
  obtain ⟨hub, z, hz1, hz2⟩ := max_abs_on_circle lm (alpha * g) (by positivity)
  refine ⟨fun w hw => ?_, ⟨z, hz1, ?_⟩⟩
  · have := hub w hw; rw [hlm] at this; linarith [this]
  · rw [hz2, hlm]; ring

/-! ## Trace-freeness, the eigenvalue ratio, and the gap `D` -/

/-- **`λ₊/|λ₋| = m/(m−1)`**, from `λ₊ m(m−1) + λ₋ m² = 0` at `Sᵐ × Sᵐ`. -/
theorem lambda_plus_ratio (m lp lm : ℝ) (hm : 2 ≤ m) (hneg : lm < 0)
    (htrace : lp * (m * (m - 1)) + lm * m ^ 2 = 0) :
    lp = |lm| * (m / (m - 1)) ∧ |lm| < lp := by
  have hm1 : (0 : ℝ) < m - 1 := by linarith
  have hmp : (0 : ℝ) < m := by linarith
  have habs : |lm| = -lm := abs_of_neg hneg
  have hlp : lp = -lm * (m / (m - 1)) := by
    field_simp at htrace ⊢
    nlinarith [htrace]
  refine ⟨by rw [habs, hlp], ?_⟩
  rw [habs, hlp]
  have : (1 : ℝ) < m / (m - 1) := by
    rw [lt_div_iff₀ hm1]; linarith
  nlinarith

/-- **`D = (λ₊ − λ₋)/g = (2m−1)/(m−1)`**, with `g = |λ₋|`. -/
theorem gap_D (m lp lm : ℝ) (hm : 2 ≤ m) (hneg : lm < 0)
    (htrace : lp * (m * (m - 1)) + lm * m ^ 2 = 0) :
    lp - lm = |lm| * ((2 * m - 1) / (m - 1)) := by
  have hm1 : (0 : ℝ) < m - 1 := by linarith
  obtain ⟨h1, _⟩ := lambda_plus_ratio m lp lm hm hneg htrace
  have habs : |lm| = -lm := abs_of_neg hneg
  rw [h1, habs]
  field_simp
  ring

/-! ## The geometry behind the resolvent's kink -/

/-- **The distance from a circle to a point.** The circle of radius `r` about `c` and a point `p`
with `‖p − c‖ = R`: every circle point is at least `|R − r|` from `p`, and one attains it. This is
what makes the resolvent bound switch at `α = D/2`. -/
theorem dist_circle_to_point (c p : ℂ) (r R : ℝ) (hr : 0 ≤ r) (hR : ‖p - c‖ = R) :
    (∀ z : ℂ, ‖z - c‖ = r → |R - r| ≤ ‖z - p‖)
      ∧ ∃ z : ℂ, ‖z - c‖ = r ∧ ‖z - p‖ = |R - r| := by
  constructor
  · intro z hz
    have e : (z - c) - (p - c) = z - p := by ring
    have := abs_norm_sub_norm_le (z - c) (p - c)
    rw [e, hz, hR] at this
    rw [abs_sub_comm]
    exact this
  · rcases eq_or_ne p c with rfl | hpc
    · have hR0 : R = 0 := by rw [← hR]; simp
      refine ⟨p + (r : ℂ), by simp [abs_of_nonneg hr], ?_⟩
      simp [hR0, abs_of_nonneg hr]
    · have hRpos : 0 < R := by rw [← hR]; simpa [sub_eq_zero] using hpc
      refine ⟨c + ((r / R : ℝ) : ℂ) * (p - c), ?_, ?_⟩
      · simp only [add_sub_cancel_left, norm_mul, Complex.norm_real, Real.norm_eq_abs,
          abs_of_nonneg (by positivity : (0:ℝ) ≤ r / R), hR]
        field_simp
      · have e : c + ((r / R : ℝ) : ℂ) * (p - c) - p = ((r / R - 1 : ℝ) : ℂ) * (p - c) := by
          push_cast; ring
        rw [e, norm_mul, Complex.norm_real, Real.norm_eq_abs, hR]
        rw [abs_sub_comm R r, ← abs_of_pos hRpos, ← abs_mul, abs_of_pos hRpos]
        congr 1
        field_simp

/-- **`dist(Γ, spec W*) = min(α, D−α)·g`.** The contour of radius `α g` about `λ₋` sees `λ₋` at
`α g` and `λ₊` at `|D − α| g`; on `0 < α < D` that is `min(α, D−α)·g`. -/
theorem spectral_distance (alpha D : ℝ) (halpha : 0 < alpha) (hlt : alpha < D) :
    min alpha |D - alpha| = min alpha (D - alpha) := by
  rw [abs_of_pos (by linarith : (0:ℝ) < D - alpha)]

/-- **The kink.** `min(α, D−α) = α` exactly on `α ≤ D/2`, the range on which the recorded
`1/(α g_n)` is valid, and which L152 and r456 both left unstated. -/
theorem kink_at_half_D (alpha D : ℝ) : min alpha (D - alpha) = alpha ↔ alpha ≤ D / 2 := by
  constructor
  · intro h
    have := min_le_right alpha (D - alpha)
    rw [h] at this; linarith
  · intro h
    exact min_eq_left (by linarith)

/-! ## What the missing range costs, at r456's own optimum -/

/-- **`D = 11/5` at `m = 6`, `d = 13/15` at `α = 4/3`, and the two constants differ by more than a
factor of five.** L156's corrected `α(1+α)/(d(d−γ)) = 2100/117 ≈ 17.9` against the recorded
`(1+α)/(α−γ) = 7/2`. -/
theorem r456_optimum_understates :
    ((2 * 6 - 1 : ℚ) / (6 - 1) = 11 / 5)
      ∧ (min (4 / 3 : ℚ) (11 / 5 - 4 / 3) = 13 / 15)
      ∧ ((4 / 3 : ℚ) * (1 + 4 / 3) / ((13 / 15) * (13 / 15 - 2 / 3)) = 2100 / 117)
      ∧ ((1 + (4 / 3 : ℚ)) / (4 / 3 - 2 / 3) = 7 / 2)
      ∧ ((7 : ℚ) / 2 < 2100 / 117) := by
  refine ⟨by norm_num, ?_, by norm_num, by norm_num, by norm_num⟩
  rw [min_eq_right (by norm_num)]
  norm_num

/-- **`α < 1 < D/2` at every `m ≥ 2`**, so r457's route stays below the kink and never commits the
resolvent error. -/
theorem r457_stays_below_the_kink (m : ℝ) (hm : 2 ≤ m) : 1 < (2 * m - 1) / (m - 1) / 2 := by
  have hm1 : (0 : ℝ) < m - 1 := by linarith
  rw [lt_div_iff₀ (by norm_num : (0:ℝ) < 2), lt_div_iff₀ hm1]
  linarith

/-! ## The check the two derivations pass together, and the one they do not -/

/-- **r441's `M ≤ 6ρ` at `(α, γ) = (1/2, 1/4)`**, reproduced exactly by `(1+α)/(α−γ)`. -/
theorem r441_check : (1 + (1 / 2 : ℚ)) / (1 / 2 - 1 / 4) = 6 := by norm_num

/-- **And r457's form returns `6` only in the limit.** `(α + m/(m−1))/(α−γ) = 2 + 4m/(m−1)` at
`(1/2, 1/4)`, which exceeds `6` at every finite `m > 1` and tends to `6` as `m → ∞`. -/
theorem r457_never_returns_six (m : ℝ) (hm : 2 ≤ m) :
    (1 / 2 + m / (m - 1)) / (1 / 2 - 1 / 4) = 2 + 4 * (m / (m - 1)) ∧ 6 < 2 + 4 * (m / (m - 1)) := by
  have hm1 : (0 : ℝ) < m - 1 := by linarith
  have hgt : (1 : ℝ) < m / (m - 1) := by rw [lt_div_iff₀ hm1]; linarith
  exact ⟨by ring, by linarith⟩

/-- **The claimed `20%` gap is the `α → 0` limit.** At `m = 6` the ratio `(α + m/(m−1))/(1+α)` is
`6/5` at `α = 0` and `23/21 ≈ 1.095` at the true optimum `α* = D/2 = 11/10`. -/
theorem gap_is_twenty_percent_only_at_zero :
    ((0 + (6 : ℚ) / 5) / (1 + 0) = 6 / 5)
      ∧ ((11 / 10 + (6 : ℚ) / 5) / (1 + 11 / 10) = 23 / 21)
      ∧ ((23 : ℚ) / 21 < 6 / 5) := by
  norm_num

/-! ## A witness, so the circle statements are not vacuous -/

/-- The hypotheses of `numerator_identity` are satisfiable: `λ₋ = −1`, `g = 1`, `α = 1/2`. -/
example : ‖(-1 : ℂ)‖ = 1 ∧ ∃ z : ℂ, ‖z - (-1 : ℂ)‖ = (1 / 2 : ℝ) * 1 ∧ ‖z‖ = (1 + 1 / 2 : ℝ) * 1 := by
  refine ⟨by simp, ?_⟩
  obtain ⟨_, z, hz1, hz2⟩ :=
    numerator_identity (-1 : ℂ) 1 (1 / 2) (by norm_num) (by norm_num) (by simp)
  exact ⟨z, hz1, hz2⟩

end HamiltonsCubic.L152Statement
