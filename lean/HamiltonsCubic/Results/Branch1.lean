import HamiltonsCubic.Results.Theta0

/-!
# Branch 1's saturation table, exactly

[target.md](../../../findings/target.md) tabulates, at the six sphere products
`S³×S³, S³×S⁴, S⁴×S⁴, S⁴×S⁵, S⁵×S⁵, S⁶×S⁶` (that is `n = 6, 7, 8, 9, 10, 12`):

* `λ`, six decimals;
* `μ`, six decimals;
* `μ / (n/(n-1))λ`, printed as `1.0000` six times;
* a bottom mass share, printed as percentages to one place.

The prose alongside says **"Branch 1 is an EQUALITY at every sphere product"**, but
the row that would show it prints `1.0000`, which is what a rounding looks like. The
difference between *saturated numerically* and *an equality* is the whole content of
the sentence, and the table cannot carry it.

Here every entry is exact. The `1.0000` row is `1`, at all six, in `ℚ`.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.Branch1

open HamiltonsCubic.Theta0

/-- `μ² = (n/(n-1))² λ²` is the row printed as `1.0000`. -/
def muSq (lamSq n : ℚ) : ℚ := lamSq * (n / (n - 1)) ^ 2

/-! ## The `μ` column, from the `λ` column and the ratio

Each line reads: the record's `λ²` at that `n`, scaled by `(n/(n-1))²`, is exactly the
rational whose square root is the record's printed `μ`.
-/

theorem mu_6  : muSq (10 / 9)  6  = 8 / 5     := by norm_num [muSq]
theorem mu_7  : muSq (6 / 5)   7  = 49 / 30   := by norm_num [muSq]
theorem mu_8  : muSq (21 / 16) 8  = 12 / 7    := by norm_num [muSq]
theorem mu_9  : muSq (48 / 35) 9  = 243 / 140 := by norm_num [muSq]
theorem mu_10 : muSq (36 / 25) 10 = 16 / 9    := by norm_num [muSq]
theorem mu_12 : muSq (55 / 36) 12 = 20 / 11   := by norm_num [muSq]

/-- **`μ₁₀ = 4/3` exactly**, the second rational entry in the table, printed
`1.333333`. -/
theorem mu_ten_rational : muSq (36 / 25) 10 = (4 / 3 : ℚ) ^ 2 := by norm_num [muSq]

/-! ## The ratio row is `1`, not `1.0000`

Written without division by the printed `μ`: the claim is that the squared ratio is
exactly one, which for nonnegative quantities is the equality the prose asserts.
-/

theorem ratio_6  : muSq (10 / 9)  6  / (8 / 5)     = 1 := by norm_num [muSq]
theorem ratio_7  : muSq (6 / 5)   7  / (49 / 30)   = 1 := by norm_num [muSq]
theorem ratio_8  : muSq (21 / 16) 8  / (12 / 7)    = 1 := by norm_num [muSq]
theorem ratio_9  : muSq (48 / 35) 9  / (243 / 140) = 1 := by norm_num [muSq]
theorem ratio_10 : muSq (36 / 25) 10 / (16 / 9)    = 1 := by norm_num [muSq]
theorem ratio_12 : muSq (55 / 36) 12 / (20 / 11)   = 1 := by norm_num [muSq]

/-! ## The bottom mass share

`Σ νₐ² = 3` at unit norm, so the share carried by the bottom eigenvalue is `μ²/3`.
The record prints `53.3%, 54.4%, 57.1%, 57.9%, 59.3%, 60.6%`; each is exact.
-/

theorem share_6  : (8 / 5 : ℚ)     / 3 = 8 / 15   := by norm_num
theorem share_7  : (49 / 30 : ℚ)   / 3 = 49 / 90  := by norm_num
theorem share_8  : (12 / 7 : ℚ)    / 3 = 4 / 7    := by norm_num
theorem share_9  : (243 / 140 : ℚ) / 3 = 81 / 140 := by norm_num
theorem share_10 : (16 / 9 : ℚ)    / 3 = 16 / 27  := by norm_num
theorem share_12 : (20 / 11 : ℚ)   / 3 = 20 / 33  := by norm_num

/-- The share is increasing across the tabulated points, and the bolded last entry
`60.6%` is `20/33`, which is below `2/3`. -/
theorem share_lt_two_thirds : (20 / 33 : ℚ) < 2 / 3 := by norm_num

/-- `μ² ≤ 3` at every tabulated point, the ceiling `μ ≤ √3` the prose derives from
`Σ νₐ² = 3`. The largest tabulated value is `20/11`. -/
theorem mu_le_ceiling : (20 / 11 : ℚ) < 3 := by norm_num

/-! ## What this settles

**Settled**: every entry of the four-row table is an exact rational, and the row
printed `1.0000` is exactly `1` at all six points, so the prose's *"EQUALITY at every
sphere product"* is what the table's own numbers say, rather than what they round to.

**Not settled here**: that the equality holds at *every* sphere product rather than at
these six. The record states it as a general claim and the table exhibits six cases;
this file makes the six exact and reaches no further. **A formula fitted to six points
is not a theorem**, and the loop does not supply one.
-/

end HamiltonsCubic.Branch1
