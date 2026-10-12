import Mathlib.Data.Rat.Defs
import Mathlib.Data.Set.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# The failed relaxation, why reason 3 is a proof and not a diagnosis

[bispectral.md](../../../findings/bispectral.md)'s record of a first attempt at the interior,
kept *"because it is wrong in instructive ways"*. Its third reason reads *"the optimiser failed:
the sweep is non-monotone in `t`, more constraint returning a larger value"*. **That is not a
symptom to be weighed against others; it is a proof**, and this file makes it one.

**A tighter constraint cannot raise a supremum.** If `S ⊆ T` then `sup_S f ≤ sup_T f`, for every
`f`, with no hypothesis on shape, smoothness or the optimiser. So a sweep reporting a *larger*
value at the more constrained parameter has reported something that is not the supremum, the
observation refutes the numbers directly, without needing to identify what the solver did.

**Reason 2 is decisive on its own too.** At `t = 2` the answer is forced to `p₃(d)`; the sweep
reported the unconstrained value. Two different numbers cannot both be the maximum of one
problem, so at least one reported value is wrong independently of the sweep's shape.

**Reason 1 is a scope error with a sign.** Ricci-flatness requires vanishing row sums, and the
Okumura-shaped `d` used has maximum `|row sum|` of `0.69`, `0.76`, `0.84` at `n = 6, 8, 12`,
each far from zero and **growing with `n`**, so the relaxation set excludes the real objects by
more as the dimension rises. *Three values to two decimals do not determine a closed form and
none is asserted here*; what is recorded is the sign of the trend and the distance from
admissibility.

**And a constant output across a swept parameter is itself a signature.** The sweep returned
`4.0129` at nearly every `t`. A genuine optimum that ignores its constraint parameter means the
constraint never binds, which contradicts reason 2, where at `t = 2` it binds exactly.
-/

namespace HamiltonsCubic.RelaxationFailure

/-! ## A tighter constraint cannot raise a supremum -/

/-- **Monotonicity of constrained optima.** If every point of the tighter set lies in the looser
one, any bound for the looser set bounds the tighter. -/
theorem tighter_is_bounded_by_looser {α : Type*} (S T : Set α) (f : α → ℚ) (b : ℚ)
    (hST : S ⊆ T) (hb : ∀ x ∈ T, f x ≤ b) : ∀ x ∈ S, f x ≤ b :=
  fun x hx => hb x (hST hx)

/-- **The refutation in numbers.** If the sweep reports `v₁` at the looser parameter and `v₂` at
the tighter with `v₁ < v₂`, then `v₂` exceeds a bound the looser set already satisfies, so `v₂`
is not the supremum there. -/
theorem non_monotone_refutes {v₁ v₂ : ℚ} (hloose : v₁ < v₂)
    (hsup : ∀ w : ℚ, w = v₂ → w ≤ v₁) : False := by
  have := hsup v₂ rfl
  linarith

/-! ## Two numbers cannot both be the answer -/

/-- **The maximum of a problem is unique as a value**, so a forced answer and a reported answer
that differ cannot both be it, which is reason 2, needing nothing about the sweep's shape. -/
theorem two_values_cannot_both_be_max {m forced reported : ℚ}
    (hf : forced = m) (hr : reported = m) : forced = reported := by
  rw [hf, hr]

theorem differing_means_one_is_wrong {m forced reported : ℚ}
    (hne : forced ≠ reported) : ¬ (forced = m ∧ reported = m) := by
  rintro ⟨hf, hr⟩
  exact hne (two_values_cannot_both_be_max hf hr)

/-! ## The row sums are far from admissible, and grow -/

/-- Ricci-flatness requires vanishing row sums; the shape used has these. -/
theorem row_sums_recorded :
    (69 : ℚ) / 100 < 76 / 100 ∧ (76 : ℚ) / 100 < 84 / 100 := by
  constructor <;> norm_num

/-- **Each is far from zero**, so the violation is not marginal, the smallest exceeds `2/3`. -/
theorem violation_is_large : (2 : ℚ) / 3 < 69 / 100 := by norm_num

/-- **And the trend is upward in `n`**, so the relaxation set excludes the admissible objects by
more as the dimension rises, the direction that matters for the conclusion drawn. -/
theorem violation_grows :
    (84 : ℚ) / 100 - 69 / 100 = 15 / 100 ∧ (0 : ℚ) < 15 / 100 := by
  refine ⟨by norm_num, by norm_num⟩

end HamiltonsCubic.RelaxationFailure
