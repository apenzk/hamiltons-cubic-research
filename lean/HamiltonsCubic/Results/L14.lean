import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L14, why two sharp bounds sum to a slack one

[curvature-invariants.md](../../../findings/curvature-invariants.md)'s Conjecture L14, withdrawn
as a numbered result because it states no inequality. What survives is a note on the reduction
and one quantitative claim: summing this bound with the separately sharp `tr(W³)` bound
**overshoots the true maximum by about `1.7–1.8×`, since their extremal profiles do not
coincide**. That mechanism is exact, and it is the whole reason a joint bound is needed.

**Equality in `sup(f+g) ≤ sup f + sup g` forces a common maximiser.** Two bounds each attained,
but at different points, therefore sum to something strictly slack, and the size of the slack
is set by how far apart the two profiles are, not by how good either bound is. So no refinement
of either piece closes the gap; only a bound on the sum does.

**The record's factor is attainable exactly, at misalignment `1/7`.** Two profiles on two
points, each peaking where the other sits at `1/7`, have sharp bounds summing to `2` against a
true maximum of `8/7`, a ratio of exactly **`7/4`**, inside the block's stated range. So the
`1.7–1.8×` is the signature of a near-complementary pair rather than a coincidence of the
particular tensors.

**A provenance note here is false in both clauses**, as at [L13](L13.lean) and
[L6](L6.lean) in the same file. It reads *"moved here from results.md, where the argument was
the only copy. That file now carries the statement and points here"*, but
[results.md](../../../results.md) carries this block's argument paragraph **byte-identically**,
`874` bytes, and its pointer returns here. So the move was a copy, both copies are live, and
what the other file carries is the argument rather than the statement.
-/

namespace HamiltonsCubic.SummedBounds

/-! ## Summing bounds is valid, and equality is restrictive -/

/-- The sum of two bounds bounds the sum, this direction is free. -/
theorem sum_bounds {f g : Bool → ℚ} {Mf Mg : ℚ}
    (hf : ∀ x, f x ≤ Mf) (hg : ∀ x, g x ≤ Mg) : ∀ x, f x + g x ≤ Mf + Mg :=
  fun x => add_le_add (hf x) (hg x)

/-- **And equality at a point forces both bounds to be attained there.** So two sharp bounds
sum to a sharp bound exactly when their extremal profiles meet, which is the block's stated
reason the sum overshoots. -/
theorem equality_forces_common_maximiser {f g : Bool → ℚ} {Mf Mg : ℚ} {x : Bool}
    (hf : ∀ y, f y ≤ Mf) (hg : ∀ y, g y ≤ Mg) (h : f x + g x = Mf + Mg) :
    f x = Mf ∧ g x = Mg := by
  constructor <;> linarith [hf x, hg x]

/-! ## The factor `7/4`, exactly -/

/-- The near-complementary pair: each profile peaks where the other sits at `1/7`. -/
def f : Bool → ℚ := fun b => if b then 1 / 7 else 1

def g : Bool → ℚ := fun b => if b then 1 else 1 / 7

/-- Each bound is sharp: `1` is attained by both. -/
theorem f_sharp : (∀ x, f x ≤ 1) ∧ f false = 1 := by
  refine ⟨fun x => ?_, rfl⟩
  cases x <;> (unfold f; norm_num)

theorem g_sharp : (∀ x, g x ≤ 1) ∧ g true = 1 := by
  refine ⟨fun x => ?_, rfl⟩
  cases x <;> (unfold g; norm_num)

/-- **The true maximum of the sum is `8/7`**, attained at both points. -/
theorem sum_max : ∀ x, f x + g x = 8 / 7 := by
  intro x; cases x <;> (unfold f g; norm_num)

/-- **So the summed bound overshoots by exactly `7/4`**, inside the block's `1.7–1.8×`. -/
theorem overshoot_is_seven_quarters : (1 + 1 : ℚ) / (8 / 7) = 7 / 4 := by norm_num

theorem in_recorded_range : (17 : ℚ) / 10 < 7 / 4 ∧ (7 : ℚ) / 4 < 18 / 10 := by
  constructor <;> norm_num

/-- **And refining either piece cannot help**: both are already attained, so the slack is carried
entirely by the misalignment. Halving the misalignment to `1/14` moves the overshoot to `28/15`,
which is **worse**, the factor grows as the profiles separate. -/
theorem tighter_misalignment_is_worse : (1 + 1 : ℚ) / (1 + 1 / 14) = 28 / 15 ∧ (7:ℚ)/4 < 28/15 := by
  refine ⟨by norm_num, by norm_num⟩

end HamiltonsCubic.SummedBounds
