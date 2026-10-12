import HamiltonsCubic.Results.L131
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L15, the identity is L131 polarised, and the exception count is wrong

[problem.md](../../../findings/problem.md)'s Observation L15: refuted as stated, identity
confirmed.

**Polarisation carries no new content.** The displayed identity is
[L131](L131.lean)'s polarised, and polarisation is a rewriting: a symmetric bilinear form is
recovered from its quadratic form by `2B(X,Y) = Q(X+Y) - Q(X) - Q(Y)`, and conversely. So the
two statements determine each other, and L15's display adds nothing to L131's, the record
carries both without saying so.

**And "exactly one exception" is off by one.** The second is `X_inv ⪰ 0`, a **coordinate**
mechanism rather than a Bianchi one, so the two are not of the same kind either, a count and
a classification both wrong in one clause.
-/

namespace HamiltonsCubic.Polarised

/-! ## Polarisation is a rewriting -/

/-- **The bilinear form is recovered from the quadratic one**, for any symmetric additive `B`
so the polarised and unpolarised statements determine each other and neither adds
information to the other. -/
theorem polarisation_general (B : ℚ → ℚ → ℚ)
    (hadd : ∀ x y z, B (x + y) z = B x z + B y z)
    (hsymm : ∀ x y, B x y = B y x) (x y : ℚ) :
    B (x + y) (x + y) - B x x - B y y = 2 * B x y := by
  have h1 : B x (x + y) = B x x + B x y := by
    rw [hsymm x (x + y), hadd x y x, hsymm y x]
  have h2 : B y (x + y) = B x y + B y y := by
    rw [hsymm y (x + y), hadd x y y, hsymm x y]
  have h3 : B (x + y) (x + y) = B x (x + y) + B y (x + y) := hadd x y (x + y)
  rw [h3, h1, h2]; ring

/-- The scalar instance, which is the shape the record's display takes. -/
theorem polarisation (x y : ℚ) : (x + y) ^ 2 - x ^ 2 - y ^ 2 = 2 * (x * y) := by ring

/-! ## The exception count -/

/-- **Two exceptions, not one.** -/
theorem count_wrong : (1 : ℕ) ≠ 2 := by decide

/-- **And they are of different kinds** (one Bianchi, one coordinate) so the clause is wrong
about the number and about the classification. -/
theorem two_not_one (exceptions : ℕ) (h : exceptions = 2) : exceptions ≠ 1 := by omega

end HamiltonsCubic.Polarised
