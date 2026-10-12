import Mathlib.Algebra.Lie.Basic
import Mathlib.Algebra.Lie.Ideal
import Mathlib.Algebra.Lie.IdealOperations

/-!
# Lemma L210, the de Rham reduction, at the algebra where it is free of topology

[findings/problem.md](../../../findings/problem.md), the L210 block.

**What the record needed.** [Lemma L48](../../../findings/problem.md) argues the reducible case
for a space that *is* a product, while the Theorem it serves quantifies over EVERY compact
Einstein symmetric space. The step from one to the other is the de Rham reduction, which
[ROUND_L48](../../../verification/ROUND_L48.md)'s finding R10 records as having no argument on
file and as "the step by which the Theorem reaches products at all".

**Why it is done at the algebra.** On a locally symmetric space the curvature is
`R x y z = -⁅⁅x, y⁆, z⁆`
([Gorodski](../../../references/gorodski-symmetric-spaces-intro/notes.md), Proposition 3.1.2),
and the splitting of the orthogonal involutive Lie algebra into ideals is Proposition 2.1.3
there, whose proof is linear algebra on `p`. **Neither carries a topological hypothesis**, so the
splitting is available before any question of covers, completeness or compactness is settled,
and those enter only where the block genuinely needs them, at `λ > 0`.

## What is typed here, and what changed after Gate 2

`curv` is the symmetric-space curvature as a function of three Lie algebra elements, and
`curv_eq_zero_of_mem_of_mem_ideal` is **the load-bearing step**: the mixed curvature terms
vanish for two elements of DISTINCT ideals whose intersection is trivial.

**An earlier version of this file took `⁅x, y⁆ = 0` as a hypothesis and a note here claimed
`LieIdeal` was absent from the vendored Mathlib. Both Gate 2 readers found that claim false**,
and they were right: `LieIdeal` is at `Mathlib/Algebra/Lie/Ideal.lean`, and
`LieSubmodule.lie_le_inf` gives `⁅I, J⁆ ≤ I ⊓ J`. So the commuting is now DERIVED from ideal
membership rather than assumed, which is the difference between stating the step and asserting
it.

**Still not stated here**: that `Ric = λ g` with `λ ≠ 0` kills the Euclidean factor, that each
surviving factor inherits the same `λ`, and that `λ > 0` is what the passage to L47 needs. All
three want a Ricci contraction of a Lie-algebra curvature, and the layer has no such object.
-/

namespace HamiltonsCubic.Results

variable {R L : Type*} [CommRing R] [LieRing L] [LieAlgebra R L]

/-- **The curvature of a locally symmetric space, as an algebraic expression.** Gorodski's
Proposition 3.1.2 reads `R x y z = -⁅⁅x, y⁆, z⁆`, and this is its right-hand side. *The sign
convention is that source's, fixed against
`R X Y Z = ∇_X ∇_Y Z - ∇_Y ∇_X Z - ∇_{⁅X,Y⁆} Z`. Every conclusion below is a VANISHING, so no
conclusion here depends on the sign.* -/
def curv (x y z : L) : L := -⁅⁅x, y⁆, z⁆

/-- The curvature vanishes wherever the first bracket does. -/
theorem curv_eq_zero_of_bracket_eq_zero {x y : L} (h : ⁅x, y⁆ = (0 : L)) (z : L) :
    curv x y z = 0 := by
  simp [curv, h]

/-- **THE MIXED TERMS VANISH, DERIVED FROM IDEAL MEMBERSHIP.** For two ideals meeting only in
`0`, any `x ∈ I` and `y ∈ J` have `⁅x, y⁆ = 0`, hence span no curvature.

*This is Proposition 2.1.3's output used as it stands: the `gᵢ` are ideals of an internal direct
sum, so distinct ones intersect trivially, and `LieSubmodule.lie_le_inf` puts their bracket
inside that intersection.* **It is why the reduction costs nothing topologically**, and it is
the step [Lemma L48](../../../findings/problem.md) needs as *"zero on the mixed terms"*. -/
theorem curv_eq_zero_of_mem_of_mem_ideal {I J : LieIdeal R L} (hIJ : I ⊓ J = ⊥)
    {x y : L} (hx : x ∈ I) (hy : y ∈ J) (z : L) :
    curv x y z = 0 := by
  refine curv_eq_zero_of_bracket_eq_zero ?_ z
  have hmem : ⁅x, y⁆ ∈ (⊥ : LieIdeal R L) := by
    have hle : ⁅I, J⁆ ≤ I ⊓ J := LieSubmodule.lie_le_inf I J
    rw [hIJ] at hle
    exact hle (LieSubmodule.lie_mem_lie hx hy)
  simpa using hmem

/-- **And the curvature of a Euclidean factor is zero**, the step `Ric = λ g` with `λ ≠ 0` then
contradicts. *Gorodski's (2.1.4) gives the stronger `⁅p₀, p⁆ = 0`, so this takes the bracket
against ALL of the tangent space rather than only against `p₀`, which is what makes the Ricci
trace over the whole space vanish term by term.* -/
theorem curv_eq_zero_of_bracket_trivial {P : Set L} (hP : ∀ a ∈ P, ∀ b : L, ⁅a, b⁆ = (0 : L))
    {x : L} (hx : x ∈ P) (y z : L) :
    curv x y z = 0 :=
  curv_eq_zero_of_bracket_eq_zero (hP x hx y) z

end HamiltonsCubic.Results

#print axioms HamiltonsCubic.Results.curv_eq_zero_of_bracket_eq_zero
#print axioms HamiltonsCubic.Results.curv_eq_zero_of_mem_of_mem_ideal
#print axioms HamiltonsCubic.Results.curv_eq_zero_of_bracket_trivial
