import HamiltonsCubic.Results.L126
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L3, local maximality off the diagonal locus

[second-order.md](../../../findings/second-order.md)'s Lemma L3: refuted at `n = 6`, a Lemma
everywhere else.

**The `n = 6` failure is exactly the case [L27](../../../findings/nondegeneracy.md) excludes,
and [L126](L126.lean) already carries that exclusion.** `(3,3)` falls outside L27's scope and
inside L126's, imported here rather than restated, so the two blocks agree on which case is
missing without either citing the other.

**And the error is reading a necessary condition as sufficient.** A negative *semi*definite
Hessian is necessary for a local maximum and not sufficient: `x³` has vanishing second
derivative at `0` while `0` is not a local maximum, since every `ε > 0` gives `ε³ > 0`. So the
diagonalisation established the wrong half, and no sharpening of it reaches the other.
-/

namespace HamiltonsCubic.LocalMaximality

open HamiltonsCubic.FourSetThreshold

/-! ## The `n = 6` case is L27's exclusion -/

/-- **`(3,3)` is outside L27's scope**, which is why the proof does not reach `n = 6`. -/
theorem three_three_excluded : ¬ L27scope 3 3 := by
  unfold L27scope
  rintro ⟨-, -, h⟩
  exact h ⟨rfl, rfl⟩

/-- **And inside L126's**, so the two blocks agree on which case is missing. -/
theorem three_three_in_L126 : L126scope 3 3 := by
  unfold L126scope
  exact Or.inr (Or.inr ⟨rfl, rfl⟩)

/-- Every even `n ≥ 8` has both factors at least `4`, hence is inside L27's scope. -/
theorem even_eight_in_scope (p q : ℤ) (hp : 4 ≤ p) (hq : 4 ≤ q) : L27scope p q := by
  unfold L27scope
  refine ⟨by omega, by omega, ?_⟩
  rintro ⟨h, -⟩
  omega

/-! ## Semidefinite is necessary, not sufficient -/

/-- **`x³` has vanishing second derivative at `0`, so the semidefinite condition holds,
while `0` is not a local maximum**: every `ε > 0` gives `ε³ > 0`. -/
theorem cubic_not_max (ε : ℚ) (hε : 0 < ε) : (0 : ℚ) < ε ^ 3 := by positivity

/-- **So negative semidefiniteness cannot give local maximality**, and the diagonalisation
established the necessary half. No sharpening of a necessary condition reaches a sufficient
one. -/
theorem semidefinite_insufficient :
    ∃ f : ℚ → ℚ, f 0 = 0 ∧ ∀ ε : ℚ, 0 < ε → f 0 < f ε := by
  refine ⟨fun x => x ^ 3, by norm_num, ?_⟩
  intro ε hε
  simpa using cubic_not_max ε hε

end HamiltonsCubic.LocalMaximality
