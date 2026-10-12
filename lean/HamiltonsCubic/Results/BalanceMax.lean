import Mathlib.Tactic.NormNum

/-!
# Balance maximises `θ`, at every dimension to `24`

The record treats `θ₀(n)` (the balanced sphere product's value) as *the* sphere-product
maximum, and calls `Θₙ` the diagonal maximum on that basis. **The claim that the most
balanced split is the maximising one is used throughout and stated nowhere**, and at odd
`n`, where no balanced split exists, the record uses the nearest one.

Here it is decided: over every dimension `4 ≤ n ≤ 24`, the split with `q - p` smallest
maximises `θ²` among all splits with `2 ≤ p ≤ q`.

The technique is [Census.lean](HamiltonsCubic/Results/Census.lean)'s, values carried as
normalised pairs over `ℕ`, so ordering and equality reduce in the kernel. Comparison of
two such pairs is by cross-multiplication.
-/

namespace HamiltonsCubic.BalanceMax

set_option maxRecDepth 1000000

/-- Splits of `n` with `2 ≤ p ≤ q`. -/
def splits (n : ℕ) : List (ℕ × ℕ) :=
  ((List.range (n + 1)).map (fun p => (p, n - p))).filter
    (fun x => 2 ≤ x.1 && x.1 ≤ x.2 && x.1 + x.2 == n)

/-- `θ²` as a numerator–denominator pair, unnormalised, comparison is by
cross-multiplication, so no reduction is needed. -/
def val (x : ℕ × ℕ) : ℕ × ℕ :=
  let p := x.1; let q := x.2; let n := p + q
  (2 * (p - 1) * (q - 1) * (n - 1), p * q * (n - 2))

/-- `a/b ≤ c/d` for positive denominators. -/
def le (u v : ℕ × ℕ) : Bool := u.1 * v.2 ≤ v.1 * u.2

/-- The most balanced split is the last one listed, `p` largest. -/
def balanced (n : ℕ) : ℕ × ℕ := (splits n).getLast! 

/-- **At every `n` from `4` to `24`, the most balanced split maximises `θ²`.** -/
def balanceWins (n : ℕ) : Bool :=
  (splits n).all (fun x => le (val x) (val (balanced n)))

theorem balance_maximises : ((List.range 25).filter (fun n => 4 ≤ n)).all balanceWins := by
  decide

/-! ## The count of splits, and that the range is non-trivial -/

theorem splits_12 : (splits 12).length = 5 := by decide
theorem splits_24 : (splits 24).length = 11 := by decide

/-- At `n = 24` there are eleven splits and the balanced one wins over all of them. -/
theorem balance_wins_24 : balanceWins 24 := by decide

/-- And at odd `n` the nearest-to-balanced split wins: at `n = 13` there are five splits
and `S⁶×S⁷` is the maximum. -/
theorem splits_13 : (splits 13).length = 5 := by decide
theorem balance_wins_13 : balanceWins 13 := by decide

theorem balanced_13 : balanced 13 = (6, 7) := by decide

/-! ## What this settles

**Settled, in the kernel**: that the most balanced split maximises `θ²` at every
`4 ≤ n ≤ 24`, over every admissible split, **the fact the record's `θ₀` and `Θₙ` rest on
and which it never states**. At odd `n` the maximiser is the nearest-to-balanced split,
which is what the record uses.

**Not settled here**: the same claim beyond `n = 24`, and the closed form itself.
-/

end HamiltonsCubic.BalanceMax
