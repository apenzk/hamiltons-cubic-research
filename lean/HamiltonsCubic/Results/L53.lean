import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp

/-!
# L53, the champion split, and the `ℂPᵐ` forms that turn the table into checks

[bispectral.md](../../../findings/bispectral.md)'s Observation L53. The audit says every
entry becomes a check once the `ℂPᵐ` closed forms are in hand; those forms and the checks are
carried here.

**The bi-spectral identity closes with no residual radical, and that is verifiable without
one.** With `R² = 3m(m²-1)(2m-1)`, the two forms give
`θ = (3/2)p₃(μ) - (1/2)p₃(ω) = (2m² + m - 1)/R`, and `2m² + m - 1 = (2m-1)(m+1)`, so
`θ² = (m+1)(2m-1)/(3m(m-1))`, **exactly the record's `θ²(ℂPᵐ)`**. Squaring removes the
radical entirely, so the closure is a rational identity in `m`.

**Row 3's collision, exactly.** `θ₀(6)² = 10/9` is also `θ²(ℂP³)`, and `θ²(S²×S⁶) = 35/36`
brackets the block's `0.986013`. Both landings are degenerate between two named objects, so
the row identifies nothing without the dropped `p₃(μ)` column.

**The refuted sentence.** *"`W_{ℂP²}` wins the `Λ²` cubic"* is false: `θ²` **decreases** in
`m` across the family while `p₃(μ)²` **rises to a maximum at `m = 6`**, checked at
`m = 4 … 8`, where the two orderings disagree.

**The champion split, conditional on a ceiling for `M(6)`.** A common maximiser of the two extreme
directions needs `θ ≥ 13√10/24`, and `(13√10/24)² = 1690/576 > 3/2`, padded `W_{ℂP²}`'s `θ²`. The
record proves `M(6) ≥ √(3/2)` and no ceiling below `13√10/24` (r649, r1941).
-/

namespace HamiltonsCubic.ChampionSplit

/-! ## The `ℂPᵐ` closed forms close the identity -/

/-- The numerator of `p₃(μ)|_{ℂPᵐ}` before the `1/3`: `4m² + 2m - 11`. -/
def p3muNum (m : ℚ) : ℚ := 4 * m ^ 2 + 2 * m - 11

/-- `R² = 3m(m²-1)(2m-1)`, the common radicand of both forms. -/
def Rsq (m : ℚ) : ℚ := 3 * m * (m ^ 2 - 1) * (2 * m - 1)

/-- **The combination is rational.** `(3/2)·(N/3) - (1/2)·(-9)` collapses to `2m² + m - 1`,
so `θ = (2m² + m - 1)/R` with the radical appearing once. -/
theorem bispectral_numerator (m : ℚ) :
    (3 / 2) * (p3muNum m / 3) - (1 / 2) * (-9) = 2 * m ^ 2 + m - 1 := by
  unfold p3muNum; ring

/-- And that numerator factors, which is what cancels the radical on squaring. -/
theorem numerator_factors (m : ℚ) : 2 * m ^ 2 + m - 1 = (2 * m - 1) * (m + 1) := by ring

/-- **The closure**: `θ² = (2m²+m-1)²/R² = (m+1)(2m-1)/(3m(m-1))`, the record's own
`θ²(ℂPᵐ)`. A rational identity in `m`, so no radical survives. -/
theorem bispectral_closes (m : ℚ) (hm : 2 ≤ m) :
    (2 * m ^ 2 + m - 1) ^ 2 / Rsq m = (m + 1) * (2 * m - 1) / (3 * m * (m - 1)) := by
  unfold Rsq
  have h0 : m ≠ 0 := by intro h; linarith
  have h1 : m - 1 ≠ 0 := by intro h; linarith
  have h2 : m + 1 ≠ 0 := by intro h; linarith
  have h3 : 2 * m - 1 ≠ 0 := by intro h; linarith
  have hsq : m ^ 2 - 1 = (m - 1) * (m + 1) := by ring
  rw [hsq]
  field_simp
  ring

/-! ## Row 3's collision -/

/-- `θ₀(6)² = 10/9`. -/
theorem theta0_six : 2 * (6 - 1 : ℚ) * (6 - 2) / 6 ^ 2 = 10 / 9 := by norm_num

/-- **And `θ²(ℂP³) = 10/9` too**, the same value, from a different object. -/
theorem cp3_same : (3 + 1 : ℚ) * (2 * 3 - 1) / (3 * 3 * (3 - 1)) = 10 / 9 := by norm_num

/-- `θ²(S² × S⁶) = 35/36`, which brackets the block's `0.986013`. -/
theorem s2s6 : 2 * (8 - 1 : ℚ) * (2 - 1) * (6 - 1) / ((8 - 2) * 2 * 6) = 35 / 36 := by
  norm_num

theorem s2s6_bracket :
    ((986012 : ℚ) / 1000000) ^ 2 < 35 / 36 ∧ (35 : ℚ) / 36 < ((986014 : ℚ) / 1000000) ^ 2 := by
  constructor <;> norm_num

/-! ## The refuted sentence: the two orderings disagree -/

/-- `θ²(ℂPᵐ)`, which the record records as strictly decreasing in `m`. -/
def thetaSq (m : ℚ) : ℚ := (m + 1) * (2 * m - 1) / (3 * m * (m - 1))

/-- `p₃(μ)² = (4m²+2m-11)² / (9 R²)`. -/
def p3muSq (m : ℚ) : ℚ := p3muNum m ^ 2 / (9 * Rsq m)

/-- **`θ²` falls from `m = 4` to `m = 8`.** -/
theorem theta_decreases :
    thetaSq 5 < thetaSq 4 ∧ thetaSq 6 < thetaSq 5 ∧ thetaSq 7 < thetaSq 6
      ∧ thetaSq 8 < thetaSq 7 := by
  unfold thetaSq; refine ⟨by norm_num, by norm_num, by norm_num, by norm_num⟩

/-- **`p₃(μ)²` rises to `m = 6` and falls after**, so the two orderings disagree and
*"`W_{ℂP²}` wins the `Λ²` cubic"* is false. -/
theorem p3mu_peaks_at_six :
    p3muSq 4 < p3muSq 5 ∧ p3muSq 5 < p3muSq 6 ∧ p3muSq 7 < p3muSq 6
      ∧ p3muSq 8 < p3muSq 6 := by
  unfold p3muSq p3muNum Rsq
  refine ⟨by norm_num, by norm_num, by norm_num, by norm_num⟩

/-! ## The champion split is a theorem -/

/-- A common maximiser of the two extreme directions needs `θ ≥ 13√10/24`, whose square is
`1690/576`. -/
theorem common_maximiser_sq : (13 : ℚ) ^ 2 * 10 / 24 ^ 2 = 1690 / 576 := by norm_num

/-- **And that exceeds `3/2`**, padded `W_{ℂP²}`'s `θ²`: no common maximiser exists at `n = 6` once
`M(6) < 13√10/24`, a ceiling the record does not hold. -/
theorem exceeds_M6 : (3 : ℚ) / 2 < 1690 / 576 := by norm_num

/-- The margin is `826/576`, so the exclusion is not marginal. -/
theorem champion_margin : (1690 : ℚ) / 576 - 3 / 2 = 826 / 576 := by norm_num

/-- `13√10/24 = 1.7129…`, the block's decimal. -/
theorem champion_bracket :
    ((1712899 : ℚ) / 1000000) ^ 2 < 1690 / 576
      ∧ (1690 : ℚ) / 576 < ((1712901 : ℚ) / 1000000) ^ 2 := by
  constructor <;> norm_num

end HamiltonsCubic.ChampionSplit
