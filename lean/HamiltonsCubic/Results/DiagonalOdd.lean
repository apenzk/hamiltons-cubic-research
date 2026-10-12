import HamiltonsCubic.Results.Theta0

/-!
# The diagonal theorem's odd-`n` constant

[diagonal-half.md](../../../findings/diagonal-half.md) records:

> **The sharp odd-`n` constant is elementary, and the record had it as three measured
> ratios.** Substituting `B = K + 1` turns the problem into maximising `‖B‖_F²` over the
> fractional perfect matching polytope of `Kₙ`, whose vertices are a matching plus
> disjoint odd cycles. That gives `Cₙ = ½(n-1)(2n-1)(n-3)` at odd `n`, **re-derives
> `n(n-1)(n-2)` at even `n` by a second route**, and yields the ratio
> `√(2n(n-2)/((2n-1)(n-3)))`, reproducing the recorded `√(5/3)` and `1.16024` exactly and
> **correcting the recorded `n = 9` value from `1.11153` to `√(21/17) = 1.111438`**, an
> error in the direction a stalled optimiser errs.

**Every value checks**, including the correction: the ratio squared is `5/3`, `35/26` and
`21/17` at `n = 5, 7, 9`.

Everything is `ring` or `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.DiagonalOdd

/-- The odd-`n` constant. -/
def COdd (n : ℚ) : ℚ := (n - 1) * (2 * n - 1) * (n - 3) / 2

/-- The even-`n` constant. -/
def CEven (n : ℚ) : ℚ := n * (n - 1) * (n - 2)

/-- The ratio squared. -/
def ratioSq (n : ℚ) : ℚ := 2 * n * (n - 2) / ((2 * n - 1) * (n - 3))

/-! ## The three odd values -/

theorem at_5 : ratioSq 5 = 5 / 3 := by norm_num [ratioSq]
theorem at_7 : ratioSq 7 = 35 / 26 := by norm_num [ratioSq]

/-- **The corrected `n = 9` value**: `21/17`, whose root is `1.111438`, against the
recorded `1.11153`. -/
theorem at_9 : ratioSq 9 = 21 / 17 := by norm_num [ratioSq]

theorem at_9_correction :
    (1.111437 : ℚ) ^ 2 < 21 / 17 ∧ (21 : ℚ) / 17 < (1.111438 : ℚ) ^ 2 := by
  constructor <;> norm_num

/-- **And the recorded value was too large**: `1.11153² > 21/17`. *The record calls this
"the direction a stalled optimiser errs"; see
[LPCut](HamiltonsCubic/Results/LPCut.lean), where this record's other optimiser
correction runs the **opposite** way, so that phrase names no single direction.* -/
theorem old_value_too_large : (21 : ℚ) / 17 < (1.11153 : ℚ) ^ 2 := by norm_num

/-- The correction's size is under `10⁻⁴`. -/
theorem correction_small : (1.11153 : ℚ) - 1.111438 < 0.0001 := by norm_num

/-! ## The constants themselves -/

theorem COdd_5 : COdd 5 = 36 := by norm_num [COdd]
theorem COdd_7 : COdd 7 = 156 := by norm_num [COdd]
theorem COdd_9 : COdd 9 = 408 := by norm_num [COdd]

theorem CEven_6 : CEven 6 = 120 := by norm_num [CEven]
theorem CEven_8 : CEven 8 = 336 := by norm_num [CEven]

/-- **The two constants interleave**: `COdd(7) = 156` sits between `CEven(6) = 120` and
`CEven(8) = 336`, so the sequence is monotone across parities. -/
theorem interleave : CEven 6 < COdd 7 ∧ COdd 7 < CEven 8 := by
  constructor <;> norm_num [CEven, COdd]

/-! ## The ratio decreases

`√(5/3) = 1.291`, `1.160`, `1.111`, falling toward `1`.
-/

theorem decreasing : ratioSq 9 < ratioSq 7 ∧ ratioSq 7 < ratioSq 5 := by
  constructor <;> norm_num [ratioSq]

/-- **And it tends to `1`**: `2n(n-2)/((2n-1)(n-3))` has leading coefficients `2` over
`2`. At `n = 25` it is already `1150/1078`. -/
theorem at_25 : ratioSq 25 = 1150 / 1078 := by norm_num [ratioSq]

theorem approaching_one : (1 : ℚ) < ratioSq 25 ∧ ratioSq 25 < 11 / 10 := by
  constructor <;> norm_num [ratioSq]

/-! ## What this settles

**Settled**: the three odd ratios as `5/3`, `35/26`, `21/17`; **that the corrected `n = 9`
value is right and the recorded one was too large**, in the direction the record names;
the constants `COdd` at `n = 5, 7, 9` and `CEven` at `6, 8`, which interleave; and that
the ratio falls toward `1`, already within `10%` at `n = 25`.

**Not claimed**: the substitution `B = K + 1`, the polytope's vertex description, or that
the maximum is attained there, the lemma's three structural moves.
-/

end HamiltonsCubic.DiagonalOdd
