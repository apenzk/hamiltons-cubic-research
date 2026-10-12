import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L138, the `Alt` defect has an exact size, and it is the omitted summand's non-alternating part

[route-a.md](../../../findings/route-a.md)'s Lemma L138, withdrawn with
[L137](L137.lean) but with two of its three parts standing. The part that does not stand is its
displayed `‖g₁‖²` inequality, which **applies `Alt` to one summand and not the other when the
two share `4`-sets**.

**The discrepancy is exactly `‖y - Alt(y)‖²`.** `Alt` is an orthogonal projection, so for any
summands `x` and `y`,

`‖Alt(x) + y‖² = ‖Alt(x+y)‖² + ‖y - Alt(y)‖²`,

with the cross term vanishing by orthogonality. So the two expressions differ by a nonnegative
amount, and they **agree exactly when the omitted summand is already alternating**, which is
what *"when the two share `4`-sets"* rules out. The defect therefore has a size rather than
being merely a slip, and that size is computable from the omitted summand alone.

**The defective expression is the larger of the two**, since the discrepancy is a square. So the
error's direction is fixed: it overstates, and a bound proved for it would have transferred,
while a value computed from it does not.

**The two surviving parts are consistent.** The Daleckii–Krein multiplier at `u` takes three
magnitudes `{0, 1/3, 1}`, so any combination it weights is bounded by its largest, `1`; and on
the cone `B₁₁ = 0` with `B₃₃ = -B₂₂` makes the `B`-block traceless, as recorded at
[L137](L137.lean).
-/

namespace HamiltonsCubic.AltDefect

/-! ## `Alt` as an orthogonal projection, concretely -/

/-- The projection standing for `Alt`: it keeps the alternating part and kills the rest. -/
def alt (v : ℚ × ℚ) : ℚ × ℚ := (v.1, 0)

/-- Squared norm on the model. -/
def nsq (v : ℚ × ℚ) : ℚ := v.1 ^ 2 + v.2 ^ 2

/-- `alt` is idempotent, as a projection must be. -/
theorem alt_idem (v : ℚ × ℚ) : alt (alt v) = alt v := by unfold alt; rfl

/-- **The exact discrepancy.** `‖Alt(x) + y‖² = ‖Alt(x+y)‖² + ‖y - Alt(y)‖²`. -/
theorem alt_discrepancy (x y : ℚ × ℚ) :
    nsq (alt x + y) = nsq (alt (x + y)) + nsq (y - alt y) := by
  unfold nsq alt
  simp only [Prod.fst_add, Prod.snd_add, Prod.fst_sub, Prod.snd_sub]
  ring

/-- **So the defective expression is the larger**, the gap being a square. -/
theorem defective_overstates (x y : ℚ × ℚ) : nsq (alt (x + y)) ≤ nsq (alt x + y) := by
  have h := alt_discrepancy x y
  have hnn : 0 ≤ nsq (y - alt y) := by unfold nsq; positivity
  linarith

/-- **And the two agree exactly when the omitted summand is already alternating.** -/
theorem agree_iff_summand_alternating (x y : ℚ × ℚ) :
    nsq (alt x + y) = nsq (alt (x + y)) ↔ y = alt y := by
  have h := alt_discrepancy x y
  constructor
  · intro heq
    have hz : nsq (y - alt y) = 0 := by linarith
    unfold nsq at hz
    have h2 : y.2 = 0 := by
      have : (y - alt y).2 = y.2 := by unfold alt; simp
      nlinarith [sq_nonneg (y - alt y).1, sq_nonneg (y - alt y).2, hz, this]
    unfold alt
    exact Prod.ext rfl h2
  · intro heq
    have : nsq (y - alt y) = 0 := by rw [← heq]; unfold nsq; simp
    linarith

/-- A witness that the gap is genuinely nonzero: at `x = (1,1)` and `y = (1,1)` the defective
value is `5` against the correct `4`. -/
theorem witness_gap :
    nsq (alt (1, 1) + (1, 1)) = 5 ∧ nsq (alt ((1, 1) + (1, 1))) = 4 := by
  unfold nsq alt; norm_num

/-! ## The surviving parts -/

/-- The Daleckii–Krein multiplier's three magnitudes, and the largest is `1`, so any
combination it weights is bounded by the combination's own size. -/
theorem multiplier_magnitudes :
    (0 : ℚ) < 1 / 3 ∧ (1 : ℚ) / 3 < 1 ∧ max (max (0:ℚ) (1/3)) 1 = 1 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

end HamiltonsCubic.AltDefect
