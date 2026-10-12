import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L175, `θ` occurs in (C) and nowhere else

[bounds-relaxations.md](../../../findings/bounds-relaxations.md)'s Lemma L175. In
[L104](../../../findings/bounds-relaxations.md)'s value-type reduction, (Aᵢ)'s right side is
`2(n-2)` and (Bᵢ)'s is `-2νᵢ`, while (Cᵢ)'s is `2νᵢ(θ - νᵢ)`.

**That observation is true and it is not a fence.** An earlier version of this file drew from
it that a `θ`-free constraint set bounds `θ` only vacuously, and stated three theorems for it.
**Gate 2 broke the inference and found the three theorems empty**: (C) is *solvable* for `θ`,
giving `θ = g(T)` with `g` linear and `θ`-free, so a bound over the (A),(B)-feasible set of `g`
does bound `θ`. Of the four theorems, `theta_free_bounds_nothing` was `X ↔ X` with both binders
unused, `bound_must_come_from_C`'s hypothesis proved `False`, and `A_theta_free` and
`B_theta_free` were `rfl` on expressions containing no `θ`.

**What is left is the one theorem with content**, and the file no longer claims more.
-/

namespace HamiltonsCubic.ThetaFree

/-- **(C)'s right side pins `θ`** as soon as `νᵢ ≠ 0`: it is injective in `θ`. This is what
makes (C) solvable for `θ`, which is why the fence the first version drew is false. -/
theorem C_determines_theta (ν θ θ' : ℝ) (hν : ν ≠ 0)
    (h : 2 * ν * (θ - ν) = 2 * ν * (θ' - ν)) : θ = θ' := by
  have h2 : 2 * ν ≠ 0 := by simpa using hν
  have := mul_left_cancel₀ h2 h
  linarith

end HamiltonsCubic.ThetaFree
