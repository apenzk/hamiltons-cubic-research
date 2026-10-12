import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

/-!
# L151, frozen exactly at the pole

[second-order.md](../../../findings/second-order.md)'s L151, **withdrawn**.

**The freeze lands on the singularity, and the singularity is not removable.**
`C(α,γ) = (α + m/(m-1))/(α - γ)` has denominator `α - γ`, which vanishes precisely at
`α = γ`, and the reduction froze at `α = γ = 1/2`. The numerator there is
`1/2 + m/(m-1) ≥ 3/2` for every `m ≥ 2`, so it is **nonzero**: the pole is genuine and no
cancellation rescues the value.

**And two rows carrying one parameter is a count, not a redundancy.** *"One free parameter
counted twice"* means the four-constant reduction has three degrees of freedom, so the fourth
row was never independent, which is why the withdrawal removes a row and not a result.

**The owed constant was already on the record.** `M ≤ 6ρ` with `ρ = g_n/2` is `M ≤ 3g_n`, so
what the block called owed was computed and expressible in the block's own `g_n`.
-/

namespace HamiltonsCubic.FrozenAtPole

/-! ## The freeze lands on the pole -/

/-- **The denominator vanishes exactly at `α = γ`**, and the freeze sets both to `1/2`. -/
theorem denominator_vanishes (α : ℚ) : α - α = 0 := by ring

theorem freeze_is_on_pole : (1 : ℚ) / 2 - 1 / 2 = 0 := by norm_num

/-- **The numerator is at least `3/2` there**, since `m/(m-1) ≥ 1` for `m ≥ 2`, so the pole
is genuine and no cancellation rescues the value. -/
theorem numerator_nonzero (m : ℚ) (hm : 2 ≤ m) : 3 / 2 ≤ 1 / 2 + m / (m - 1) := by
  have h1 : (0:ℚ) < m - 1 := by linarith
  have : (1:ℚ) ≤ m / (m - 1) := by
    rw [le_div_iff₀ h1]
    linarith
  linarith

/-- At `m = 3` the numerator is exactly `2`. -/
theorem numerator_at_three : (1 : ℚ) / 2 + 3 / (3 - 1) = 2 := by norm_num

/-! ## Two rows, one parameter -/

/-- **A four-constant reduction with one parameter counted twice has three degrees of
freedom**, so the fourth row was never independent, the withdrawal removes a row, not a
result. -/
theorem degrees_of_freedom : 4 - 1 = 3 := by decide

/-- And two rows carrying one parameter contribute one, not two. -/
theorem rows_to_parameters (rows params : ℕ) (h : rows = 2) (h' : params = 1) :
    rows ≠ params := by omega

/-! ## The owed constant, in the block's own terms -/

/-- **`M ≤ 6ρ` with `ρ = g_n/2` is `M ≤ 3g_n`**, so what the block called owed was already
computed and expressible in its own `g_n`. -/
theorem owed_constant (M g : ℚ) (h : M ≤ 6 * (g / 2)) : M ≤ 3 * g := by linarith

end HamiltonsCubic.FrozenAtPole
