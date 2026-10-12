import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp

/-!
# L127, the block-level refinement, and two things at `p = 2`

[second-order.md](../../../findings/second-order.md)'s Lemma L127.

**The `½`-count matches the orbit dimension by construction.** Cross-factor pair blocks are
`{½, 0^{n-4}}` (one `½` each) and there are `pq` of them, which is `dim 𝒪`. So the count is
`pq` because the blocks are `pq`, not by a separate coincidence. Each block carries `n-3`
eigenvalues, matching the pair block's dimension after the Ricci cut.

**And at `p = 2` two rows go wrong, both checkable.** The within-factor top
`(p-2)/(2(p-1))` evaluates to `0` there while the block is entirely `-μ`, so the printed value
is not in the spectrum. And the four-set value `μ = (n-2)/(2(p-1)(q-1))` at `p = 2` is
`q/(2(q-1))`, which is **never `½` and always above it**, so the column's condition has to
read `= ½`, since `≥ ½` would admit `min(p,q) = 2`.
-/

namespace HamiltonsCubic.BlockRefinement

/-! ## The `½`-count is the block count -/

/-- Each carries `n - 3` eigenvalues: one `½` and `n - 4` zeros. -/
theorem block_spectrum_size (n : ℚ) : 1 + (n - 4) = n - 3 := by ring

/-! ## The within-factor row at `p = 2` -/

/-- The printed within-factor top `(p-2)/(2(p-1))`. -/
def withinTop (p : ℚ) : ℚ := (p - 2) / (2 * (p - 1))

/-- **At `p = 2` it evaluates to `0`**, while the block is entirely `-μ`, so the printed
value is not in the spectrum unless `μ = 0`. -/
theorem within_at_two : withinTop 2 = 0 := by unfold withinTop; norm_num

/-- And it is nonzero from `p = 3` on, so the row is right everywhere else. -/
theorem within_nonzero (p : ℚ) (hp : 3 ≤ p) : withinTop p ≠ 0 := by
  unfold withinTop
  have h1 : (0:ℚ) < 2 * (p - 1) := by linarith
  intro h
  rw [div_eq_zero_iff] at h
  rcases h with h | h
  · linarith
  · linarith

/-! ## The four-set row at `p = 2` -/

/-- The four-set value `μ = (n-2)/(2(p-1)(q-1))` with `n = p + q`. -/
def fourSetMu (p q : ℚ) : ℚ := (p + q - 2) / (2 * (p - 1) * (q - 1))

/-- **At `p = 2` it is `q/(2(q-1))`.** -/
theorem mu_at_two (q : ℚ) (hq : 2 ≤ q) : fourSetMu 2 q = q / (2 * (q - 1)) := by
  unfold fourSetMu
  have h : q - 1 ≠ 0 := by intro h; linarith
  field_simp
  ring

/-- **And that is always strictly above `½`**, since `q > q - 1`. -/
theorem mu_above_half (q : ℚ) (hq : 2 ≤ q) : 1 / 2 < q / (2 * (q - 1)) := by
  have h1 : (0:ℚ) < 2 * (q - 1) := by linarith
  rw [div_lt_div_iff₀ (by norm_num) h1]
  linarith

/-- **So it is never `½` at `p = 2`**, which is why the column must read `= ½` rather than
`≥ ½`, the latter admitting `min(p,q) = 2`. -/
theorem mu_never_half (q : ℚ) (hq : 2 ≤ q) : q / (2 * (q - 1)) ≠ 1 / 2 :=
  ne_of_gt (mu_above_half q hq)

/-- At `q = 4` the value is `2/3`, comfortably above the threshold. -/
theorem mu_at_two_four : (4 : ℚ) / (2 * (4 - 1)) = 2 / 3 := by norm_num

end HamiltonsCubic.BlockRefinement
