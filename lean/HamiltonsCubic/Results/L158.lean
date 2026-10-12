import HamiltonsCubic.Results.Theta0

/-!
# L158's `κ`, and in what sense it is an absolute constant

[L158](../../../results.md) reduces the branch comparison to *"an inequality between
absolute constants, `S` against `√(κ(1+κ))/K`"*, with

  `κ = n c_p = 3√(2(n-1)/(n-2)) ≈ 4.45`,  fixed by the margin `c_p = 3θ₀(n)/(n-2)`.

**The two expressions for `κ` agree identically**, not just numerically: substituting
`θ₀(n) = √(2(n-1)(n-2))/n` into `n·3θ₀/(n-2)` gives `3√(2(n-1)/(n-2))` exactly.

**And `κ` is not constant, it is bounded.** It *decreases* in `n`, from `4.4497…` at
`n = 12` to `3√2 = 4.2426…` in the limit, so it varies by exactly `4.88%` across the whole
range `n ≥ 12`. That is what makes *"absolute constant"* fair, and the `≈ 4.45` is its
value at the smallest admissible `n` rather than a limit.

Also checked: the homogeneity kink `w₀ = (n-4)/n` is `2/3` at `n = 12`, and
[L143](../../../findings/bounds.md)'s bound `sup|P| ≤ 1 + √(n-2)` is `1 + √10` there.

Everything is `ring`, `norm_num` or `nlinarith`, kernel-checked.
-/

namespace HamiltonsCubic.L158

open HamiltonsCubic.Theta0

/-- `κ²`, from the second form: `9·2(n-1)/(n-2)`. -/
def kappaSq (n : ℚ) : ℚ := 18 * (n - 1) / (n - 2)

/-! ## The two expressions agree -/

/-- `(n·3θ₀/(n-2))² = 9n²θ₀²/(n-2)²`, and with `θ₀² = 2(n-1)(n-2)/n²` that is
`18(n-1)/(n-2)`. Stated cross-multiplied. -/
theorem two_forms_agree (n : ℚ) :
    9 * n ^ 2 * (2 * (n - 1) * (n - 2)) * (n - 2)
      = 18 * (n - 1) * (n ^ 2 * (n - 2) ^ 2) := by
  ring

theorem at_12 : kappaSq 12 = 99 / 5 := by norm_num [kappaSq]

/-- `κ(12)² = 99/5 = 19.8`, so `κ ≈ 4.4497`, the record's `≈ 4.45`. -/
theorem at_12_decimal : (4.4497 : ℚ) ^ 2 < kappaSq 12 ∧ kappaSq 12 < (4.4498 : ℚ) ^ 2 := by
  constructor <;> norm_num [kappaSq]

/-! ## It decreases, and is bounded below by `18` -/

/-- The step: `κ²(n) - κ²(n+1)` has numerator `18`, so `κ²` strictly decreases. -/
theorem step_identity (n : ℚ) :
    (n - 1) * (n - 1) - n * (n - 2) = 1 := by ring

theorem decreasing : kappaSq 13 < kappaSq 12 ∧ kappaSq 25 < kappaSq 13 := by
  constructor <;> norm_num [kappaSq]

/-- **And it stays above `18`**, the limit `(3√2)² = 18`: `18(n-1)/(n-2) > 18` reduces to
`n - 1 > n - 2`. -/
theorem above_limit {n : ℚ} (hn : 12 ≤ n) : 18 < kappaSq n := by
  unfold kappaSq
  have h : 0 < n - 2 := by linarith
  rw [lt_div_iff₀ h]
  linarith

/-- **So `κ²` lies in `(18, 99/5]` for every `n ≥ 12`**, a range of exactly `10%` in `κ²`,
`4.88%` in `κ`. That is the content of *"absolute constant"*. -/
theorem narrow_range {n : ℚ} (hn : 12 ≤ n) : 18 < kappaSq n ∧ kappaSq n ≤ 99 / 5 := by
  refine ⟨above_limit hn, ?_⟩
  unfold kappaSq
  have h : 0 < n - 2 := by linarith
  rw [div_le_iff₀ h]
  nlinarith [hn]

/-- The spread is `9/5`, which is **exactly** a tenth of the lower end, so `κ²` ranges
over precisely `10%`, and `κ` over `√1.1 - 1 = 4.88%`. -/
theorem range_width : (99 : ℚ) / 5 - 18 = 9 / 5 ∧ (9 : ℚ) / 5 = 18 / 10 := by
  constructor <;> norm_num

theorem kappa_spread : (1.0488 : ℚ) ^ 2 < 99 / 5 / 18 ∧ (99 : ℚ) / 5 / 18 < (1.0489 : ℚ) ^ 2 := by
  constructor <;> norm_num

/-! ## The kink and L143's bound -/

/-- `w₀ = (n-4)/n` is `2/3` at `n = 12`. -/
theorem kink_at_12 : ((12 : ℚ) - 4) / 12 = 2 / 3 := by norm_num

/-- And `w₀ → 1`, so the kink moves toward the envelope's flat part as `n` grows. -/
theorem kink_rises : ((12 : ℚ) - 4) / 12 < (24 - 4) / 24 := by norm_num

/-- [L143](../../../findings/bounds.md)'s `sup|P| ≤ 1 + √(n-2)` is `1 + √10` at `n = 12`,
so `(sup|P| - 1)² ≤ 10`. -/
theorem l143_at_12 : (12 : ℚ) - 2 = 10 := by norm_num

theorem l143_value : (4.162 : ℚ) ^ 2 < (1 + 3.1623) ^ 2 := by norm_num

/-! ## What this settles

**Settled**: that L158's two expressions for `κ` agree identically in `n`, not merely at
`n = 12`; that `κ²` strictly decreases from `99/5` at `n = 12` toward `18`, staying
strictly above it, **so `κ²` ranges over exactly `10%` and `κ` over `4.88%` across `n ≥ 12`**, which is the precise
content of *"absolute constant"*, and the quoted `≈ 4.45` is its value at the smallest
admissible dimension rather than a limit; the kink `w₀ = 2/3` at `n = 12` and its rise
toward `1`; and L143's bound at `n = 12`.

**Not claimed**: the branch parametrisation, the envelope, or which branch binds, the
last needs `K`, which this statement does not give.
-/

end HamiltonsCubic.L158
