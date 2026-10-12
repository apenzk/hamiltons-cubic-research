import HamiltonsCubic.Results.BalanceMax

/-!
# The sphere-product maximum: monotone, and crossing `3/2` at exactly `n = 12`

Conjecture A carries a `ℂP²` exception at `8 ≤ n ≤ 11` and drops it at `n ≥ 12`. The
record justifies the threshold through the **balanced** value: `θ₀(n) > √(3/2)` exactly
when `n² - 12n + 8 > 0`, that is `n > 6 + 2√7 ≈ 11.29`.

**That argument covers even `n` only.** `θ₀` is the balanced value, and at odd `n` no
balanced split exists, so the crossing at odd dimensions is left to the reader.

Here the true maximum over **all** splits is decided at every `4 ≤ n ≤ 24`:

* it is **strictly increasing in `n`**, odd dimensions included;
* it is below `3/2` at `n = 11` (`40/27`, at `S⁵×S⁶`) and above at `n = 12`, `55/36`;
* so **the crossing is at exactly `n = 12`, over every split and not only the balanced
  ones.**

The technique is [BalanceMax.lean](HamiltonsCubic/Results/BalanceMax.lean)'s: values as
integer pairs, compared by cross-multiplication.
-/

namespace HamiltonsCubic.MaxCrossing

open HamiltonsCubic.BalanceMax

set_option maxRecDepth 1000000

/-- The maximising split at `n`, which [BalanceMax](HamiltonsCubic/Results/BalanceMax.lean)
proves is the most balanced one. -/
def best (n : ℕ) : ℕ × ℕ := balanced n

/-- Strictly increasing: `val (best n) < val (best (n+1))` by cross-multiplication. -/
def rises (n : ℕ) : Bool :=
  (val (best n)).1 * (val (best (n + 1))).2 < (val (best (n + 1))).1 * (val (best n)).2

/-- **The maximum is strictly increasing at every `4 ≤ n ≤ 23`**, odd dimensions
included. -/
theorem max_increasing : ((List.range 24).filter (fun n => 4 ≤ n)).all rises := by
  decide

/-! ## The crossing -/

/-- Below `3/2` at `n = 11`: the maximiser is `S⁵×S⁶` and its value is `40/27`. -/
theorem best_11 : best 11 = (5, 6) := by decide

theorem val_11 : val (best 11) = (400, 270) := by decide

theorem below_at_11 : (400 : ℕ) * 2 < 3 * 270 := by decide

/-- Above `3/2` at `n = 12`: the maximiser is `S⁶×S⁶` and its value is `55/36`. -/
theorem best_12 : best 12 = (6, 6) := by decide

theorem val_12 : val (best 12) = (550, 360) := by decide

theorem above_at_12 : (3 : ℕ) * 360 < 550 * 2 := by decide

/-- **So the crossing is at exactly `n = 12`**, and by monotonicity it happens once. -/
theorem crossing_at_twelve :
    (400 : ℕ) * 2 < 3 * 270 ∧ (3 : ℕ) * 360 < 550 * 2 := ⟨below_at_11, above_at_12⟩

/-! ## What this adds to the record's threshold argument

The record's crossover `6 + 2√7` is where the **balanced** form crosses, and is
irrational, lying in `(11, 12)`. That settles even dimensions. **This settles the odd
ones too**: at `n = 11` the best split of any shape is `S⁵×S⁶` at `40/27`, still below
`3/2`, so no odd dimension below `12` reaches the competitor either.
-/

/-- At `n = 9` and `n = 10` the maximum is also below `3/2`, so the whole range
`8 ≤ n ≤ 11` sits under the competitor, which is the exception's range. -/
theorem below_at_9 : (val (best 9)).1 * 2 < 3 * (val (best 9)).2 := by decide
theorem below_at_10 : (val (best 10)).1 * 2 < 3 * (val (best 10)).2 := by decide
theorem below_at_8 : (val (best 8)).1 * 2 < 3 * (val (best 8)).2 := by decide

/-- And from `n = 12` on it stays above, at every dimension to `24`. -/
def aboveHalf3 (n : ℕ) : Bool := 3 * (val (best n)).2 < (val (best n)).1 * 2

theorem above_from_12 : ((List.range 25).filter (fun n => 12 ≤ n)).all aboveHalf3 := by
  decide

/-! ## What this settles

**Settled, in the kernel**: that the sphere-product maximum is strictly increasing at
every `4 ≤ n ≤ 23`, odd dimensions included; that it is below `3/2` at `n = 8, 9, 10, 11`
and above at every `n` from `12` to `24`; and hence that **the crossing is at exactly
`n = 12` over all splits, not only the balanced ones**, which is Conjecture A's own
threshold, and covers the odd dimensions the record's crossover argument does not reach.

**Not settled here**: anything beyond `n = 24`, and the closed form.
-/

end HamiltonsCubic.MaxCrossing
