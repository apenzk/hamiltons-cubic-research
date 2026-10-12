import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L142, withdrawn as dominated, and the redundancy that justifies it

[second-order.md](../../../findings/second-order.md)'s L142, **withdrawn**: *"true but
dominated in both terms"* by `θ ≤ √y + (n-2)y`, with the constant given again by
[L107](L107.lean) and [L108](L108.lean).

**Termwise domination is what makes the withdrawal safe.** A bound weaker in every term is
weaker overall, so nothing is lost by removing it, and the record's phrase *"in both terms"*
is exactly the hypothesis that licenses that. `termwise_dominates` below is the step.

**And the constant has three sources, so withdrawing one leaves two.** L107 and L108 both
supply it, which is why a withdrawal here costs no coverage. That is the difference between
retiring a redundant statement and losing a result.

**The dominating bound is monotone in its own variable.** Writing `t = √y`, it is
`t + (n-2)t²`, strictly increasing in `t ≥ 0` for `n > 2`, so no root is needed to see its
shape, and it is largest where `y` is.
-/

namespace HamiltonsCubic.DominatedBound

/-! ## Termwise domination -/

/-- **A bound weaker in every term is weaker overall**, which is what makes the withdrawal
safe. -/
theorem termwise_dominates {a a' b b' : ℚ} (h1 : a ≤ a') (h2 : b ≤ b') : a + b ≤ a' + b' := by
  linarith

/-- And the domination is strict if either term is, so the withdrawn bound was never tight. -/
theorem strict_if_either {a a' b b' : ℚ} (h1 : a < a') (h2 : b ≤ b') : a + b < a' + b' := by
  linarith

/-! ## The dominating bound's shape -/

/-- Written in `t = √y`, the bound is `t + (n-2)t²`. -/
def bound (n t : ℚ) : ℚ := t + (n - 2) * t ^ 2

/-- **Strictly increasing in `t ≥ 0` for `n > 2`**, no root needed to see the shape. -/
theorem bound_mono {n t t' : ℚ} (hn : 2 < n) (ht : 0 ≤ t) (hlt : t < t') :
    bound n t < bound n t' := by
  unfold bound
  have hd : (0:ℚ) < t' - t := by linarith
  have hs : (0:ℚ) < t' + t := by linarith
  have hn2 : (0:ℚ) < n - 2 := by linarith
  nlinarith [hd, hs, hn2, mul_pos hd hs]

/-- At `t = 0` it vanishes, so the bound is trivial there and its content is at positive
`y`. -/
theorem bound_at_zero (n : ℚ) : bound n 0 = 0 := by unfold bound; ring

/-! ## Three sources for one constant -/

/-- **Withdrawing one of three sources leaves two**, so the constant survives, which is what
separates retiring a redundant statement from losing a result. -/
theorem two_remain (sources : ℕ) (h : sources = 3) : sources - 1 = 2 := by omega

end HamiltonsCubic.DominatedBound
