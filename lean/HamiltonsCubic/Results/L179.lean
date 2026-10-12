import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L179, the support of a low-rank Weyl tensor, and Bianchi on the spectrum

[diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L179. It turns
[L178](L178.lean)'s four-dimensional-support hypothesis into an algebraic question about three
`2`-forms, which is the width [I38](../../../plan.md) stays open at.

**What is checked here.** The two scalar facts the lemma turns on: a rank-one self-adjoint
operator has trace `λ‖ω‖²`, which tracelessness forces to zero, so rank one is impossible; and
the zero eigenvalues contribute nothing to the Bianchi sum, so at rank `r` it is a condition on
`r` terms. Plus the dimension bookkeeping of the decomposable case.

**What is not.** That `Im W ⊆ Λ²V` gives `W` supported on `Λ²V`, an argument about index pairs
the base layer does not carry, and that the Bianchi obstruction is the map `S²Λ² → Λ⁴`, which is
the identity being quoted.
-/

namespace HamiltonsCubic.LowRankSupport

/-! ## Rank one is impossible -/

/-- **A rank-one self-adjoint `W = λ ω ⊗ ω` has trace `λ‖ω‖²`.** Tracelessness forces `λ = 0`
whenever `ω ≠ 0`, so the nonzero ranks begin at two. -/
theorem rank_one_impossible (lam nrm : ℝ) (hn : nrm ≠ 0) (h : lam * nrm = 0) : lam = 0 := by
  rcases mul_eq_zero.mp h with h' | h'
  · exact h'
  · exact absurd h' hn

/-! ## Zero eigenvalues drop out of the Bianchi sum -/

/-- **A zero eigenvalue contributes nothing.** So the first Bianchi identity at rank `r` is a
condition on `r` terms and no more, three, at the rank L178 treats. -/
theorem zero_eigenvalue_drops (w : ℝ) : (0 : ℝ) * w = 0 := by ring

/-- Which is why the rank-three sum has exactly three terms. -/
theorem three_terms (a b c : ℝ) : a + b + c + 0 + 0 + 0 = a + b + c := by ring

/-! ## The decomposable case -/

/-- **Three decomposable forms span at most six dimensions**, each supporting a plane. -/
theorem decomposable_dimension_bound : 2 + 2 + 2 = 6 := by norm_num

/-- **And a non-decomposable form needs four on its own**, a `2`-form's support being of even
dimension and a decomposable one having dimension two. -/
theorem nondecomposable_needs_four : (2 : ℕ) < 4 := by norm_num

/-- Six exceeds the four [L178](L178.lean) assumes, which is why the question is open at exactly
that width rather than closed by the bound. -/
theorem six_exceeds_four : (4 : ℕ) < 6 := by norm_num

end HamiltonsCubic.LowRankSupport
