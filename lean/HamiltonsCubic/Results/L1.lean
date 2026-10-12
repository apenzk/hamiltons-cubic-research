import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.BigOperators.Group.Finset

/-!
# L1, the moment problem's support hypothesis, and the edge the box drops

[problem.md](../../../findings/problem.md)'s Lemma L1, step 2. The reduction to Jäger's own
expression is imported; **the moment problem and its certified line are carried here**, since
that is where the record records its own defect.

**The support hypothesis is load-bearing, with an exact witness.** Stated as
`F(v) = min{E[λ] : E[λ²] = v, E[λ⁻²] ≤ n}` with no support constraint, `δ₋₁` is feasible at
`v = 1` (it meets both moment constraints) and gives `E[λ] = -1`, against the certified line's
`φ(1) = 35247/38000`. The two differ by `73247/38000 > 1`, so the printed form fails by more
than the whole range of the quantity it bounds. The record says these hypotheses *"lived in the
scripts' docstrings and in no statement"*; the witness is what that costs.

**And the certified line straddles `1/√12`**, which is what makes the omission consequential
rather than cosmetic: at `v = 1/12` the line sits *below* `1/√12`, at `v = 1/10` *above* it. So
an unsupported reading is not uniformly weaker, it crosses the value the record says the
degenerate atom pins, and the crossing is inside the range the argument uses. Both comparisons
are made against squares here, so no radical enters.

**The box drops a Cauchy–Schwarz edge, and the flat spectrum is exactly where it binds.** With
`S ⪰ 0` and `tr S² = 1`, Cauchy–Schwarz on `(λ, λ²)` gives **`(tr S³)² ≤ tr S⁴`**, and on
`(λ^{1/2}, λ^{3/2})` (routed through the squared form, so no root is taken), gives
**`1 ≤ (tr S)(tr S³)`**. Neither is available to a box that bounds `tr S³` and `tr S⁴`
separately. **The corner elimination the record describes in words is the SECOND edge**, not the
first: `1 ≤ (tr S)(tr S³)` with `tr S ≤ √n` forces `tr S³ ≥ 1/√n`. The first edge does **not**
exclude that corner, at `n = 12` it reads `1/12 = 0.0833 ≤ 709/4680 = 0.1515`, which holds, and
Jäger already prints it. What the first edge does say is that `tr S³` at its floor forces equality
in Cauchy–Schwarz, hence the flat spectrum, where `tr S⁴` sits at its own floor; the flat spectrum
below sits **on** that edge, with equality.
-/

namespace HamiltonsCubic.MomentBody

open Finset

/-! ## The certified line -/

/-- `φ(v) = (7/10)v + 8647/38000`, the supporting line the dual returns. -/
def phi (v : ℚ) : ℚ := 7 * v / 10 + 8647 / 38000

theorem phi_at_one : phi 1 = 35247 / 38000 := by unfold phi; norm_num

/-! ## `δ₋₁` is feasible without the support constraint, and refutes the line there -/

/-- **`δ₋₁` meets both moment constraints at `v = 1`**: `E[λ²] = 1` and `E[λ⁻²] = 1 ≤ 12`. -/
theorem delta_feasible : ((-1 : ℚ)) ^ 2 = 1 ∧ (1 : ℚ) / (-1 : ℚ) ^ 2 ≤ 12 := by
  constructor <;> norm_num

/-- **And it gives `E[λ] = -1`, below the line by more than `1`.** -/
theorem delta_refutes : (-1 : ℚ) < phi 1 ∧ phi 1 - (-1) = 73247 / 38000 := by
  rw [phi_at_one]
  constructor <;> norm_num

theorem gap_exceeds_one : (1 : ℚ) < 73247 / 38000 := by norm_num

/-- The support constraint `λ ∈ (0,1]` is what excludes the witness, `-1` fails it. -/
theorem support_excludes_witness : ¬ (0 < (-1 : ℚ)) := by norm_num

/-! ## The line straddles `1/√12`, compared through squares -/

/-- At `v = 1/12` the line is **below** `1/√12`. -/
theorem line_below_at_twelfth : phi (1 / 12) ^ 2 < 1 / 12 := by
  unfold phi; norm_num

/-- At `v = 1/10` the line is **above** it, so the crossing is inside the range used. -/
theorem line_above_at_tenth : 1 / 12 < phi (1 / 10) ^ 2 := by
  unfold phi; norm_num

/-! ## The edges a separate box cannot see -/

variable {ι : Type*} (s : Finset ι)

/-- **`(tr S³)² ≤ tr S⁴` when `tr S² = 1`.** Cauchy–Schwarz on `(λ, λ²)`. -/
theorem trace_cube_sq_le_trace_fourth (l : ι → ℝ) (hnorm : ∑ i ∈ s, (l i) ^ 2 = 1) :
    (∑ i ∈ s, (l i) ^ 3) ^ 2 ≤ ∑ i ∈ s, (l i) ^ 4 := by
  have h := Finset.sum_mul_sq_le_sq_mul_sq s l (fun i => (l i) ^ 2)
  have e1 : ∑ i ∈ s, l i * (l i) ^ 2 = ∑ i ∈ s, (l i) ^ 3 :=
    Finset.sum_congr rfl fun i _ => by ring
  have e2 : ∑ i ∈ s, ((l i) ^ 2) ^ 2 = ∑ i ∈ s, (l i) ^ 4 :=
    Finset.sum_congr rfl fun i _ => by ring
  rw [e1, e2, hnorm, one_mul] at h
  exact h

/-- **`1 ≤ (tr S)(tr S³)` for `S ⪰ 0` with `tr S² = 1`.** The squared Cauchy–Schwarz form, so
no square root is taken. -/
theorem one_le_trace_mul_trace_cube (l : ι → ℝ) (hpos : ∀ i ∈ s, 0 ≤ l i)
    (hnorm : ∑ i ∈ s, (l i) ^ 2 = 1) :
    1 ≤ (∑ i ∈ s, l i) * ∑ i ∈ s, (l i) ^ 3 := by
  have h := Finset.sum_sq_le_sum_mul_sum_of_sq_le_mul s
    (f := l) (g := fun i => (l i) ^ 3) (r := fun i => (l i) ^ 2)
    hpos (fun i hi => pow_nonneg (hpos i hi) 3) (fun i _ => le_of_eq (by ring))
  rwa [hnorm, one_pow] at h

/-! ## The flat spectrum sits on the edge -/

/-- Four atoms at `1/2`: `tr S² = 1`, `tr S³ = 1/2`, `tr S⁴ = 1/4`. -/
theorem flat_moments :
    4 * ((1:ℚ)/2) ^ 2 = 1 ∧ 4 * ((1:ℚ)/2) ^ 3 = 1/2 ∧ 4 * ((1:ℚ)/2) ^ 4 = 1/4 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- **And it attains the edge with equality**, `(1/2)² = 1/4`, which is the corner elimination
the record states in words. -/
theorem flat_on_edge : ((1:ℚ)/2) ^ 2 = 1/4 := by norm_num

/-- **A point the box admits and the moment body excludes**: `tr S³ = 1/2` with `tr S⁴ = 1/5`
satisfies both separate bounds and violates the edge. -/
theorem box_corner_excluded : (1:ℚ)/5 < ((1:ℚ)/2) ^ 2 := by norm_num

end HamiltonsCubic.MomentBody
