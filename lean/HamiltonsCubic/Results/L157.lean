import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp

/-!
# L157, the crossing root, and what its quadratic says

[second-order.md](../../../findings/second-order.md)'s Lemma L157. Its core is that the reach
parameter is **determined by a fixed point** rather than chosen, with crossing root
`η* = (2t+1-√(4t+1))/(2t)`.

**The quadratic behind it is palindromic, and that has a consequence the block does not
state.** Clearing the radical gives `tη² - (2t+1)η + t = 0`, whose outer coefficients are
equal, so **the two roots multiply to `1`**. One lies inside the unit interval and the other
outside, and the fixed point is the inner one. That is why a root exists in range at all, and
it follows from the coefficients rather than from an estimate.

**And freezing `η = 1/2` is exact at exactly one `t`.** Evaluating the quadratic at `1/2`
gives `t/4 - 1/2`, so `η* = 1/2` **iff `t = 2`**, everywhere else the freeze costs something,
which the audit measures at about `2.9` against the recorded `4`, an overstatement of roughly
`38%`.
-/

namespace HamiltonsCubic.CrossingRoot

/-- The quadratic the crossing root satisfies, after clearing the radical. -/
def q (t η : ℚ) : ℚ := t * η ^ 2 - (2 * t + 1) * η + t

/-! ## The quadratic is palindromic -/

/-- **The polynomial is palindromic**: reversing the coefficients returns it, which is
`η² q(t, 1/η) = q(t, η)`. -/
theorem palindromic (t η : ℚ) (hη : η ≠ 0) : η ^ 2 * q t (1 / η) = q t η := by
  unfold q
  field_simp
  ring

/-- **So the roots multiply to `1`**: if `η` is a root and `t ≠ 0`, so is `1/η`. -/
theorem reciprocal_root {t η : ℚ} (ht : t ≠ 0) (hη : η ≠ 0) (h : q t η = 0) :
    q t (1 / η) = 0 := by
  unfold q at h ⊢
  field_simp at h ⊢
  linarith [h]

/-- Hence one root is inside the unit interval and the other outside, which is why a fixed
point exists in range, from the coefficients rather than an estimate. -/
theorem product_one {a b : ℚ} (ha : 0 < a) (hb : 0 < b) (h : a * b = 1) (hlt : a < 1) :
    1 < b := by nlinarith [h, ha, hb, hlt]

/-! ## The freeze is exact at one `t` -/

/-- **The quadratic at `η = 1/2` is `t/4 - 1/2`.** -/
theorem at_half (t : ℚ) : q t (1 / 2) = t / 4 - 1 / 2 := by unfold q; ring

/-- **So `η* = 1/2` exactly when `t = 2`.** -/
theorem half_iff_t_two (t : ℚ) : q t (1 / 2) = 0 ↔ t = 2 := by
  rw [at_half]
  constructor <;> intro h <;> linarith

/-- At `t = 2` the closed form returns `1/2` directly: `(2·2+1-3)/(2·2) = 2/4`. -/
theorem closed_form_at_two : (2 * 2 + 1 - 3 : ℚ) / (2 * 2) = 1 / 2 := by norm_num

/-! ## The cost of freezing -/

/-- **The recorded `4` overstates the measured `2.9` by about `38%`.** -/
theorem overstatement : (4 : ℚ) / (29 / 10) = 40 / 29 := by norm_num

theorem overstatement_bracket :
    (137 : ℚ) / 100 < 40 / 29 ∧ (40 : ℚ) / 29 < 139 / 100 := by
  constructor <;> norm_num

end HamiltonsCubic.CrossingRoot
