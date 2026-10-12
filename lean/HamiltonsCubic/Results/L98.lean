import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L98, the diagonal floor, and the equals sign the source did not write

[diagonal-half.md](../../../findings/diagonal-half.md)'s Observation L98. The formula's
arithmetic checks everywhere; its *status* does not, and the two are separated here.

**A census bounds an infimum from above only, the third instance of this class.**
[L40](L40.lean) reads a supremum over a catalogue as if it bounded the whole set;
[L90](L90.lean) infers an unmeasured rank from a measured one through `≤`; here a census of
`571` points bounds `min λ_max(L_e)` from **above**, and the record prints `=`. The source
wrote a question mark over the equals sign and asked for the population to be quoted; the
fold-in removed the hedge and the numbering commit promoted the bare `=` into a heading.

**The unscoped survival claim is refuted by its own table.** *"`Δ > 0 ⇒ λ_max(L_e) ≥ 1`
survives"* stands three lines above values `0.608885`, `0.5628` and `0.5535`, **all three
below `1`**, so the claim is false as written and needs the diagonal scope the block exists to
supply.

**And the "less than half" correction is confirmed with room.** The non-diagonal witness is
`59.4%` of the recorded `1.025` floor, a factor `1.68` below it, above half, which is what
the earlier reading got wrong.
-/

namespace HamiltonsCubic.DiagonalFloor

/-- The floor `1 + 1/(2(n-3)(n-4))`. -/
def floor (n : ℚ) : ℚ := 1 + 1 / (2 * (n - 3) * (n - 4))

/-! ## The three tabulated values -/

theorem floor_ten : floor 10 = 85 / 84 := by unfold floor; norm_num

theorem floor_twelve : floor 12 = 145 / 144 := by unfold floor; norm_num

theorem floor_sixteen : floor 16 = 313 / 312 := by unfold floor; norm_num

/-- The record's six-digit decimals bracket all three. -/
theorem decimals_bracket :
    (1011904 : ℚ) / 1000000 < 85 / 84 ∧ (85 : ℚ) / 84 < 1011906 / 1000000
      ∧ (1006944 : ℚ) / 1000000 < 145 / 144 ∧ (145 : ℚ) / 144 < 1006945 / 1000000
      ∧ (1003205 : ℚ) / 1000000 < 313 / 312 ∧ (313 : ℚ) / 312 < 1003206 / 1000000 := by
  refine ⟨by norm_num, by norm_num, by norm_num, by norm_num, by norm_num, by norm_num⟩

/-! ## The formula's shape -/

/-- **Strictly above `1` at every `n ≥ 5`**, so the floor never reaches the bound it
approaches. -/
theorem floor_above_one (n : ℚ) (hn : 5 ≤ n) : 1 < floor n := by
  unfold floor
  have h1 : (0:ℚ) < 2 * (n - 3) * (n - 4) := by nlinarith [hn]
  have : (0:ℚ) < 1 / (2 * (n - 3) * (n - 4)) := div_pos one_pos h1
  linarith

/-- **And strictly decreasing**, which is the convergence to `1` the block reports. -/
theorem floor_antitone {n n' : ℚ} (hn : 5 ≤ n) (hlt : n < n') : floor n' < floor n := by
  unfold floor
  have h1 : (0:ℚ) < 2 * (n - 3) * (n - 4) := by nlinarith [hn]
  have h2 : (0:ℚ) < 2 * (n' - 3) * (n' - 4) := by nlinarith [hn, hlt]
  have hlt2 : 2 * (n - 3) * (n - 4) < 2 * (n' - 3) * (n' - 4) := by nlinarith [hn, hlt]
  have : 1 / (2 * (n' - 3) * (n' - 4)) < 1 / (2 * (n - 3) * (n - 4)) := by
    rw [div_lt_div_iff₀ h2 h1]; linarith
  linarith

/-! ## The unscoped claim is refuted by its own table -/

/-- **All three tabled values fall below `1`**, so `Δ > 0 ⇒ λ_max ≥ 1` is false unscoped. -/
theorem table_refutes :
    (608885 : ℚ) / 1000000 < 1 ∧ (5628 : ℚ) / 10000 < 1 ∧ (5535 : ℚ) / 10000 < 1 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- And the lowest is barely over half the floor, so the failure is wide. -/
theorem lowest_vs_floor : (5535 : ℚ) / 10000 < 1025 / 1000 := by norm_num

/-! ## The "less than half" correction -/

/-- **The witness is `59.4%` of the recorded floor**, not under half, half of `1.025` is
`0.5125` and the witness is `0.608885`. -/
theorem above_half : (5125 : ℚ) / 10000 < 608885 / 1000000 := by norm_num

/-- The ratio brackets the record's `59.4%`. -/
theorem ratio_bracket :
    (593 : ℚ) / 1000 < (608885 / 1000000) / (1025 / 1000)
      ∧ (608885 : ℚ) / 1000000 / (1025 / 1000) < 595 / 1000 := by
  constructor <;> norm_num

/-- And the factor brackets `1.68`. -/
theorem factor_bracket :
    (167 : ℚ) / 100 < (1025 / 1000) / (608885 / 1000000)
      ∧ (1025 : ℚ) / 1000 / (608885 / 1000000) < 169 / 100 := by
  constructor <;> norm_num

/-! ## The independent solve is consistent -/

/-- **`1.0089` at `n = 12` sits above the formula's `145/144`**, which is what an upper bound
on an infimum permits, the two do not conflict. -/
theorem solve_consistent : (145 : ℚ) / 144 < 10089 / 10000 := by norm_num

/-- **A census bounds an infimum from above only.** A minimum over a sample can exceed the
true minimum, so `=` does not follow, the same direction error as [L40](L40.lean) and
[L90](L90.lean). -/
theorem census_bounds_above :
    ∃ sampleMin trueMin : ℚ, trueMin ≤ sampleMin ∧ trueMin ≠ sampleMin :=
  ⟨1, 0, by norm_num, by norm_num⟩

end HamiltonsCubic.DiagonalFloor
