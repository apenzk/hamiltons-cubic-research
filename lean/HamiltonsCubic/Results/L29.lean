import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.NormNum

/-!
# L29, the rank-3 stratum's cap, as one polynomial identity

[L29](../../../findings/stratum-two-negative.md) caps `θ` at `√(3/2)` on the stratum
with one positive and two negative eigenvalues. Its proof reduces the cap, in the
ratio `t = b/a`, to

  `θ ≤ f(t) = 9√2 · t(t+1) / (4 (t²+t+1)^{3/2})`,

and then argues *"whose unique stationary point on `t ≥ 0` is `t = 1`"*, a calculus
argument, with the equality case handed to two further lemmas.

**Squaring clears both radicals**, since `f(t)² ≤ 3/2` is `27 t²(t+1)² ≤ 4 (t²+t+1)³`.
And that is not an inequality needing analysis: the difference is a **perfect square**,

  `4(t²+t+1)³ - 27 t²(t+1)² = ((t-1)(t+2)(2t+1))²`,

so the cap holds at every real `t`, the `t ≥ 0` hypothesis is unused, and the equality
case is read off the factorisation instead of being deferred.

Everything is `ring` and `positivity`, kernel-checked. Stated over `ℚ`; the identity is
one of polynomials and holds over any commutative ring.
-/

namespace HamiltonsCubic.Stratum3

/-- **The identity.** The gap between the two sides of the squared cap is a square. -/
theorem gap_is_square (t : ℚ) :
    4 * (t ^ 2 + t + 1) ^ 3 - 27 * t ^ 2 * (t + 1) ^ 2
      = ((t - 1) * (t + 2) * (2 * t + 1)) ^ 2 := by
  ring

/-- **The cap, at every real `t`**, the stratum's `t ≥ 0` is not needed. -/
theorem cap (t : ℚ) : 27 * t ^ 2 * (t + 1) ^ 2 ≤ 4 * (t ^ 2 + t + 1) ^ 3 := by
  have h : 0 ≤ 4 * (t ^ 2 + t + 1) ^ 3 - 27 * t ^ 2 * (t + 1) ^ 2 := by
    rw [gap_is_square]; positivity
  linarith

/-- **Equality forces `(t-1)(t+2)(2t+1) = 0`.** -/
theorem eq_iff_root (t : ℚ) :
    27 * t ^ 2 * (t + 1) ^ 2 = 4 * (t ^ 2 + t + 1) ^ 3
      ↔ (t - 1) * (t + 2) * (2 * t + 1) = 0 := by
  constructor
  · intro h
    have := gap_is_square t
    have hz : ((t - 1) * (t + 2) * (2 * t + 1)) ^ 2 = 0 := by rw [← this, h]; ring
    exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp hz
  · intro h
    have := gap_is_square t
    rw [h] at this
    linarith [this]

/-- **On the stratum's own range `t ≥ 0`, equality holds exactly at `t = 1`**, the
other two roots, `-2` and `-1/2`, are negative. This is the equality case the record
defers to two further lemmas at the tensor level; at the scalar level it is the
factorisation. -/
theorem eq_iff_one {t : ℚ} (ht : 0 ≤ t) :
    27 * t ^ 2 * (t + 1) ^ 2 = 4 * (t ^ 2 + t + 1) ^ 3 ↔ t = 1 := by
  rw [eq_iff_root]
  constructor
  · intro h
    rcases mul_eq_zero.mp h with h' | h'
    · rcases mul_eq_zero.mp h' with h'' | h''
      · linarith
      · linarith
    · linarith
  · intro h; rw [h]; ring

/-- The cap's value: at `t = 1` the two sides agree, both `108`, which is `θ² = 3/2`
after the normalisation `f(t)² = 81 t²(t+1)² / (8 (t²+t+1)³)`. -/
theorem value_at_one : 27 * (1 : ℚ) ^ 2 * (1 + 1) ^ 2 = 108 ∧ 4 * ((1 : ℚ) ^ 2 + 1 + 1) ^ 3 = 108 := by
  norm_num

/-- `f(1)² = 3/2` exactly. -/
theorem f_sq_at_one : 81 * (1 : ℚ) ^ 2 * (1 + 1) ^ 2 / (8 * ((1 : ℚ) ^ 2 + 1 + 1) ^ 3) = 3 / 2 := by
  norm_num

/-! ## What this settles, and what stays with the record

**Settled**: the whole one-variable half of L29, the cap, the equality case, and the
value, with the calculus replaced by an identity, and with the `t ≥ 0` hypothesis shown
unnecessary for the inequality.

**Not settled here**: the reduction *to* that one variable. The vanishing of the
`(+++)`, `(++-)` and `(---)` blocks, the pair cap `Σ_γ T_{αβγ} = ‖[v_α,v_β]‖² ≤ 2`,
trace-freeness giving `λ₁ = a + b`, and the unit-norm normalisation are the record's,
and none of them is arithmetic.

**A note for whoever formalises the reduction**: the equality case here is `t = 1`,
i.e. `a = b`, reached without L31 or L33. Those lemmas close the converse at the level
of the tensor (that equality forces the *spectrum* `(2,-1,-1)/√6`) which is a strictly
stronger statement and is not what this file proves.
-/

end HamiltonsCubic.Stratum3
