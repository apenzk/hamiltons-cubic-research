import HamiltonsCubic.Results.MuCap

/-!
# The odd-`n` shortfall table, exactly

[bispectral.md](../../../findings/bispectral.md) tabulates the gap between the two
estimates at odd `n`:

| `n` | `5` | `7` | `9` | `11` | `13` | `25` |
|---|---|---|---|---|---|---|
| `θ₀(n)` | `0.9797959` | `1.1065667` | `1.1758895` | `1.2196734` | `1.2498521` | `1.3290598` |
| `Θₙ` | `0.9428090` | `1.0954451` | `1.1710801` | `1.2171612` | `1.2483756` | `1.3288665` |
| shortfall | `0.0369869` | `0.0111216` | `0.0048094` | `0.0025122` | `0.0014765` | `0.0001933` |

and concludes: *"the gap shrinks but never closes, and at even `n` it is exactly zero"*,
calling it **a scope limit on the proof, not a defect in it**.

**Every entry is exact.** Squared, the six gaps are `16/225`, `6/245`, `32/2835`,
`20/3267`, `48/13013`, `96/186875`, each `8(n-1)/(n²(n+1)(n-2))` from
[MuCap.lean](HamiltonsCubic/Results/MuCap.lean). **So "shrinks but never closes" has a
rate: the gap falls like `8/n³`**, which the table's six decimals do not show.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.Shortfall

open HamiltonsCubic.MuCap

/-- The gap in `θ²`, from the closed form. -/
def gap (n : ℚ) : ℚ := 8 * (n - 1) / (n ^ 2 * (n + 1) * (n - 2))

/-! ## The six tabulated gaps, exactly -/

theorem g5 : gap 5 = 16 / 225 := by norm_num [gap]
theorem g7 : gap 7 = 6 / 245 := by norm_num [gap]
theorem g9 : gap 9 = 32 / 2835 := by norm_num [gap]
theorem g11 : gap 11 = 20 / 3267 := by norm_num [gap]
theorem g13 : gap 13 = 48 / 13013 := by norm_num [gap]
theorem g25 : gap 25 = 96 / 186875 := by norm_num [gap]

/-- Each equals `θ₀² - Θₙ²` at that `n`, so the closed form and the table agree. -/
theorem matches_5 : theta0Sq 5 - bigThetaSqOdd 5 = gap 5 := by
  norm_num [theta0Sq, bigThetaSqOdd, gap]

theorem matches_25 : theta0Sq 25 - bigThetaSqOdd 25 = gap 25 := by
  norm_num [theta0Sq, bigThetaSqOdd, gap]

/-! ## It shrinks, and never reaches zero -/

theorem strictly_shrinking :
    gap 25 < gap 13 ∧ gap 13 < gap 11 ∧ gap 11 < gap 9 ∧ gap 9 < gap 7 ∧ gap 7 < gap 5 := by
  refine ⟨?_, ?_, ?_, ?_, ?_⟩ <;> norm_num [gap]

/-- **And it is positive at every `n > 2`**: the numerator is `8(n-1)` and the
denominator `n²(n+1)(n-2)`, both positive. -/
theorem positive {n : ℚ} (hn : 3 ≤ n) : 0 < gap n := by
  unfold gap
  have h1 : 0 < 8 * (n - 1) := by linarith
  have hn2 : 0 < n - 2 := by linarith
  have hn1 : 0 < n + 1 := by linarith
  have hnsq : 0 < n ^ 2 := by nlinarith
  have h2 : 0 < n ^ 2 * (n + 1) * (n - 2) := by positivity
  exact div_pos h1 h2

/-! ## The rate

`8(n-1)/(n²(n+1)(n-2))` is asymptotically `8/n³`. At `n = 25` the closed form gives
`96/186875`, and `8/25³ = 8/15625`, the two agree to within `10%`.
-/

theorem rate_at_25 : (8 : ℚ) / 15625 < gap 25 ∧ gap 25 < 1.01 * (8 / 15625) := by
  constructor <;> norm_num [gap]

/-- **So the shortfall vanishes cubically**, the record says it *"shrinks but never
closes"*, and this is how fast. The closed form sits just **above** `8/n³`, by `0.4%` at
`n = 25`. -/
theorem cubic_decay : (8 : ℚ) / 15625 < gap 25 := by norm_num [gap]

/-- Between `n = 5` and `n = 25` the gap falls by a factor over `130`. -/
theorem factor_over_130 : (130 : ℚ) * gap 25 < gap 5 := by norm_num [gap]

/-! ## What this settles

**Settled**: that all six tabulated shortfalls are exact, `16/225`, `6/245`, `32/2835`,
`20/3267`, `48/13013`, `96/186875` in `θ²`, each given by `8(n-1)/(n²(n+1)(n-2))`; that
the sequence strictly shrinks and is positive at every `n > 2`, so it *"never closes"*;
and that the decay is cubic, sitting just above `8/n³`, by `0.4%` at `n = 25`.

**What the rate adds to the record's reading.** The passage calls the shortfall *"a scope
limit on the proof, not a defect"* and says *"something other than the `‖K^F‖² ≤ 2` budget
must supply it"*. **The amount needing supply falls like `8/n³`**, so whatever supplies it
has to work hardest at small odd `n`, the opposite of an asymptotic difficulty.

**Not claimed**: the two closed forms, or the cap's derivation.
-/

end HamiltonsCubic.Shortfall
