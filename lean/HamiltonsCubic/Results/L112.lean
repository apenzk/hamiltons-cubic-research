import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp

/-!
# L112, the doubly stochastic statement, and the sentence it carries

[bounds.md](../../../findings/bounds.md)'s Lemma L112: the lemma is right and the sentence it
carries is not. `λ` is a `-1/(n-2)`-eigenvector of a symmetric hollow doubly stochastic
matrix, and [L73](../../../findings/bounds.md) is its one-index shadow.

**The refutation is about which variables a constraint set mentions.** `(A)` and `(B)`
contain no `θ`, so **nothing built from them can bound it**, whatever bound is proposed, a
larger `θ` satisfies the same constraints, since they do not see it. That is
`constraints_without_theta_dont_bound` below, and it needs nothing about curvature.

**The eigenvector is forced orthogonal to `1`.** A doubly stochastic matrix has `R1 = 1`, and
`-1/(n-2) ≠ 1` at every `n ≥ 3`, so a `-1/(n-2)`-eigenvector of a symmetric `R` is orthogonal
to the constant vector, the trace condition the lemma needs, and it comes free.
-/

namespace HamiltonsCubic.DoublyStochastic

/-! ## The eigenvalue is never `1` -/

/-- **`-1/(n-2) ≠ 1` at every `n ≥ 3`**, so the eigenvector is not the constant one. -/
theorem eigenvalue_ne_one (n : ℚ) (hn : 3 ≤ n) : -(1 / (n - 2)) ≠ 1 := by
  intro h
  have hpos : (0:ℚ) < n - 2 := by linarith
  have : -(1:ℚ) = n - 2 := by
    field_simp at h
    linarith [h]
  linarith

/-- **So the eigenvector is orthogonal to `1`.** With `R` symmetric, `R1 = 1` and `Rλ = μλ`,
`μ⟨λ,1⟩ = ⟨Rλ,1⟩ = ⟨λ,R1⟩ = ⟨λ,1⟩`, and `μ ≠ 1` divides out. -/
theorem eigenvector_orthogonal {mu ip : ℚ} (hmu : mu ≠ 1) (h : mu * ip = ip) : ip = 0 := by
  have : (mu - 1) * ip = 0 := by linarith
  rcases mul_eq_zero.1 this with h' | h'
  · exact absurd (by linarith : mu = 1) hmu
  · exact h'

/-- At `n = 6` the eigenvalue is `-1/4`. -/
theorem eigenvalue_six : -(1 / ((6 : ℚ) - 2)) = -(1 / 4) := by norm_num

/-! ## A constraint set that does not mention `θ` cannot bound it -/

/-- **Whatever bound is proposed, a larger `θ` satisfies the same constraints.** `(A)` and
`(B)` are conditions on the matrix alone, so nothing derived from them reaches `θ`, the
sentence the block carries is refuted without examining what it derives. -/
theorem constraints_without_theta_dont_bound (C : ℚ → Prop) (x : ℚ) (hx : C x) (B : ℚ) :
    ∃ θ : ℚ, C x ∧ B < θ :=
  ⟨B + 1, hx, by linarith⟩

/-- And symmetrically from below, so the constraints bound `θ` on neither side. -/
theorem no_lower_bound_either (C : ℚ → Prop) (x : ℚ) (hx : C x) (B : ℚ) :
    ∃ θ : ℚ, C x ∧ θ < B :=
  ⟨B - 1, hx, by linarith⟩

end HamiltonsCubic.DoublyStochastic
