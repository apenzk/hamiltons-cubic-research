import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp
import HamiltonsCubic.Results.CubicRatio

/-!
# The vertex-matrix minimum, the corrected values, in closed form, and where they recur

[bispectral.md](../../../findings/bispectral.md)'s sharp bound on `|min_{a≠b} K_ab|`, together
with the "wrong functional" correction beside it. Every figure in that paragraph is a decimal;
each has an exact form, and two of them are quantities the record already carries elsewhere.

**The odd-`n` closed form checks out.** `√(2n(n-2)/((2n-1)(n-3)))` gives `5/3`, `35/26` and
`21/17` under the square at `n = 5, 7, 9`, matching the recorded `√(5/3)`, `1.16024` and
`√(21/17)`. And it is exactly what the sharp constant `Cₙ = ½(n-1)(2n-1)(n-3)` produces:
`n(n-1)(n-2)/Cₙ = 2n(n-2)/((2n-1)(n-3))` identically, so the two statements are one.

**The corrected values are `2/((n-1)(n-2))` and `2(n-2)/(n²(n-1))`.** The paragraph gives
`min|K|` as `0.3162, 0.2182, 0.1667` and `|min K|` as `0.2108, 0.1637, 0.1333` at
`n = 6, 8, 10`, related *"by exactly `n/(n-2)`"*. Squared, those are `1/10, 1/21, 1/36` and
`2/45, 3/112, 4/225`, and the ratio `(n/(n-2))²` is exact.

**The first sequence is the boxed cubic ratio.** `1/10, 1/21, 1/36` is `2/((n-1)(n-2))`, which
is [nondegeneracy.md](../../../findings/nondegeneracy.md)'s boxed `tr(W³)/θ` at the same balanced
product, see [CubicRatio](CubicRatio.lean). *Three dimensions agreeing is not a proof that the
two quantities coincide at every `n`*, and the record states a closed form for only one of them;
what is established here is that they agree wherever both are recorded.

**The second sequence contains `L67`'s `B`-block value.** `2(n-2)/(n²(n-1))` at `n = 6` is
`2/45`, which [bispectral.md](../../../findings/bispectral.md) elsewhere records as the `B`-block
square bracketing `0.210818511`, so that constant is `|min K|` at the balanced product, which
the record does not say.

**And the `34`–`174%` range is exact**: the witnesses stand at `1.34`, `1.94` and `2.74` times
the lemma bound `√(2/(n(n-1)(n-2)))`.
-/

namespace HamiltonsCubic.MinVertex

/-! ## The odd-`n` closed form -/

/-- `2n(n-2)/((2n-1)(n-3))`, the recorded odd-`n` ratio squared. -/
def oddRatioSq (n : ℚ) : ℚ := 2 * n * (n - 2) / ((2 * n - 1) * (n - 3))

theorem odd_values :
    oddRatioSq 5 = 5 / 3 ∧ oddRatioSq 7 = 35 / 26 ∧ oddRatioSq 9 = 21 / 17 := by
  refine ⟨?_, ?_, ?_⟩ <;> (unfold oddRatioSq; norm_num)

/-- The `n = 7` value's root is the recorded `1.16024`. -/
theorem seven_bracket :
    ((116023 : ℚ) / 100000) ^ 2 < 35 / 26 ∧ (35 : ℚ) / 26 < ((116025 : ℚ) / 100000) ^ 2 := by
  constructor <;> norm_num

/-- **The sharp constant produces exactly that ratio**: `n(n-1)(n-2)/Cₙ` with
`Cₙ = ½(n-1)(2n-1)(n-3)`. -/
theorem constant_gives_ratio (n : ℚ) (hn : 5 ≤ n) :
    n * (n - 1) * (n - 2) / ((n - 1) * (2 * n - 1) * (n - 3) / 2) = oddRatioSq n := by
  unfold oddRatioSq
  have h1 : n - 1 ≠ 0 := by intro h; linarith
  have h3 : n - 3 ≠ 0 := by intro h; linarith
  have h2 : 2 * n - 1 ≠ 0 := by intro h; linarith
  field_simp

/-! ## The two corrected sequences -/

/-- `min|K|²` at the balanced product. -/
def minAbsSq (n : ℚ) : ℚ := 2 / ((n - 1) * (n - 2))

/-- `|min K|²` at the balanced product. -/
def absMinSq (n : ℚ) : ℚ := 2 * (n - 2) / (n ^ 2 * (n - 1))

theorem minAbs_values :
    minAbsSq 6 = 1 / 10 ∧ minAbsSq 8 = 1 / 21 ∧ minAbsSq 10 = 1 / 36 := by
  refine ⟨?_, ?_, ?_⟩ <;> (unfold minAbsSq; norm_num)

theorem absMin_values :
    absMinSq 6 = 2 / 45 ∧ absMinSq 8 = 3 / 112 ∧ absMinSq 10 = 4 / 225 := by
  refine ⟨?_, ?_, ?_⟩ <;> (unfold absMinSq; norm_num)

/-- **The ratio is exactly `(n/(n-2))²`**, as the correction states. -/
theorem ratio_is_n_over_n_minus_two (n : ℚ) (hn : 4 ≤ n) :
    minAbsSq n = absMinSq n * (n / (n - 2)) ^ 2 := by
  unfold minAbsSq absMinSq
  have h0 : n ≠ 0 := by intro h; linarith
  have h1 : n - 1 ≠ 0 := by intro h; linarith
  have h2 : n - 2 ≠ 0 := by intro h; linarith
  field_simp

/-! ## Where the two sequences recur -/

/-- **`min|K|²` agrees with the boxed cubic ratio at every dimension both are recorded.**
[CubicRatio](CubicRatio.lean) carries `tr(W³)/θ = 2/((n-1)(n-2))` at the same balanced product,
whose values at `n = 6, 8, 10` are `1/10`, `1/21`, `1/36`, these. *Three agreements do not
establish that the two quantities coincide at every `n`*; the record states a closed form for
only one of them. -/
theorem minAbs_matches_cubic_ratio :
    minAbsSq 6 = CubicRatio.ratio 6 ∧ minAbsSq 8 = CubicRatio.ratio 8
      ∧ minAbsSq 10 = CubicRatio.ratio 10 := by
  refine ⟨?_, ?_, ?_⟩ <;> (unfold minAbsSq CubicRatio.ratio; norm_num)

/-- **`|min K|²` at `n = 6` is `2/45`**, the `B`-block square the record brackets against
`0.210818511`, so that constant is this minimum, which the record does not say. -/
theorem b_block_is_abs_min : absMinSq 6 = 2 / 45 := by unfold absMinSq; norm_num

theorem b_block_bracket :
    ((210818510 : ℚ) / 1000000000) ^ 2 < 2 / 45
      ∧ (2 : ℚ) / 45 < ((210818512 : ℚ) / 1000000000) ^ 2 := by
  constructor <;> norm_num

/-! ## The witnesses against the lemma bound -/

/-- The lemma bound squared at `t = 2`. -/
def lemmaBoundSq (n : ℚ) : ℚ := 2 / (n * ((n - 1) * (n - 2)))

theorem bound_values :
    lemmaBoundSq 6 = 1 / 60 ∧ lemmaBoundSq 8 = 1 / 168 ∧ lemmaBoundSq 10 = 1 / 360 := by
  refine ⟨?_, ?_, ?_⟩ <;> (unfold lemmaBoundSq; norm_num)

/-- **The witnesses stand at `1.34`, `1.94` and `2.74` times it**, the recorded `34`–`174%`. -/
theorem witness_excess :
    ((1732 : ℚ) / 10000) ^ 2 / (1 / 60) < 18 / 10
      ∧ (17 : ℚ) / 10 < ((1732 : ℚ) / 10000) ^ 2 / (1 / 60)
      ∧ (74 : ℚ) / 10 < ((1444 : ℚ) / 10000) ^ 2 / (1 / 360)
      ∧ ((1444 : ℚ) / 10000) ^ 2 / (1 / 360) < 76 / 10 := by
  refine ⟨by norm_num, by norm_num, by norm_num, by norm_num⟩

end HamiltonsCubic.MinVertex
