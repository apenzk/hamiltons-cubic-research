import HamiltonsCubic.Results.IndexCompleteness

/-!
# The rank profile, and a hypothesis of mine that context refutes

[IndexCompleteness.lean](HamiltonsCubic/Results/IndexCompleteness.lean) noted three
unindexed values within `1.5·10⁻³`, `1.544331`, `1.544872`, `1.545809`, and called the
cluster *‹the signature of one quantity computed three ways›*.

**Reading their contexts refutes that.** They are three different things:

* `1.544331` is the supremum **at rank 3**, attained at `λ = (2,-1,-1)/√6`, the
  competitor's own spectrum;
* `1.544872` and `1.545809` are the bound's **observed suprema at `n = 6` and `n = 8`**,
  which the entry places just above the rank-3 value. *Paraphrase: that wording appears
  nowhere in the record and was carried here as a quotation.*

And [second-order.md](../../../findings/second-order.md) tabulates the profile by rank:

| rank | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 12 | 15 |
|---|---|---|---|---|---|---|---|---|---|
| sup | `1.544331` | `1.545949` | `1.547` | `1.5478` | `1.5485` | `1.5536` | `1.5631` | `1.6082` | `1.630017` |

**So the three are a rank-3 value and two observations above it**, and the profile rises
with rank, not with `n`, the entry proves it cannot depend on `n`.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.RankProfile

/-! ## The "just above" claim -/

/-- Both observations sit above the rank-3 value. -/
theorem above_rank3 : (1.544331 : ℚ) < 1.544872 ∧ (1.544331 : ℚ) < 1.545809 := by
  constructor <;> norm_num

/-- **And "just above" is the right word**: the gaps are `5.41·10⁻⁴` and `1.48·10⁻³`, both
under `10⁻³` of the value. -/
theorem just_above :
    (1.544872 : ℚ) - 1.544331 < 0.00055 ∧ (1.545809 : ℚ) - 1.544331 < 0.0015 := by
  constructor <;> norm_num

/-- The `n = 8` observation exceeds the `n = 6` one, so the observations rise with `n`
even though the profile does not. -/
theorem observations_rise : (1.544872 : ℚ) < 1.545809 := by norm_num

/-! ## The profile rises with rank -/

theorem profile_monotone :
    (1.544331 : ℚ) < 1.545949 ∧ (1.545949 : ℚ) < 1.547 ∧ (1.547 : ℚ) < 1.5478 ∧
    (1.5478 : ℚ) < 1.5485 ∧ (1.5485 : ℚ) < 1.5536 ∧ (1.5536 : ℚ) < 1.5631 ∧
    (1.5631 : ℚ) < 1.6082 ∧ (1.6082 : ℚ) < 1.630017 := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩ <;> norm_num

/-- **The rise accelerates**: rank `3→4` gains `1.6·10⁻³`, rank `12→15` gains
`2.2·10⁻²`, a factor over `13`. -/
theorem rise_accelerates :
    (13 : ℚ) * (1.545949 - 1.544331) < 1.630017 - 1.6082 := by norm_num

/-- Over the whole tabulated range the profile gains `8.57·10⁻²`, about `5.5%`. -/
theorem total_gain :
    (1.630017 : ℚ) - 1.544331 = 0.085686 ∧ (0.055 : ℚ) * 1.544331 < 0.085686 := by
  constructor <;> norm_num

/-! ## Both endpoints exceed `√(3/2)`

`1.544331² = 2.3849…` against `3/2`, so the whole profile is above the threshold, the
bound is not competitive at any rank.
-/

theorem rank3_above_threshold : (3 : ℚ) / 2 < (1.544331 : ℚ) ^ 2 := by norm_num

theorem rank15_above_threshold : (3 : ℚ) / 2 < (1.630017 : ℚ) ^ 2 := by norm_num

/-- By a factor over `1.58` even at rank `3`. -/
theorem factor_at_rank3 : (1.58 : ℚ) * (3 / 2) < (1.544331 : ℚ) ^ 2 := by norm_num

/-! ## What this settles

**Settled**: that the three clustered values are a rank-3 supremum and two observations
just above it, gaps `5.4·10⁻⁴` and `1.5·10⁻³`; that the tabulated profile rises
monotonically with rank, accelerating by a factor over `13` between its ends, for a total
gain of `5.5%`; and that **every entry exceeds `3/2` in the square, by a factor over
`1.58` even at rank 3**, so the bound is not competitive at any rank.

**And a correction**: [IndexCompleteness.lean](HamiltonsCubic/Results/IndexCompleteness.lean)
called the cluster *‹the signature of one quantity computed three ways›*. **Context
refutes that**, they are three quantities, and that row is corrected.

**Not claimed**: the bound `λ_max p + B₅`, its rank reduction, or that `1.544331` is
algebraic, it is attained at the competitor's spectrum, which suggests a closed form this
file does not supply.
-/

end HamiltonsCubic.RankProfile
