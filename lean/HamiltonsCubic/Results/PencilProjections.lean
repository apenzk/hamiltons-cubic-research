import HamiltonsCubic.Base.Bivectors

/-!
# Summing plane projections inside one all-decomposable eigenspace

[findings/diagonal-half.md](../../../findings/diagonal-half.md), the I36 section:
the cross-eigenspace equation. On the all-decomposable locus every eigenspace is,
by the Structure Theorem at `ℓ = 2`, a pencil `f ∧ U'` or `Λ²U` with `dim U = 3`,
and summing the plane projections inside one eigenspace is closed-form in both
types. Those two sums are what this file types.

`planeProj u v` is the orthogonal projection onto `span{u, v}` for orthonormal
`u, v`, written as the outer-product sum. Neither theorem needs the plane, the
wedge or any spectral data: they are identities between outer products, which is
why they are provable here while the equation they feed is not.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Results

open Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The rank-one outer product `u uᵀ`. -/
def outer (u : ι → ℝ) : Matrix ι ι ℝ := Matrix.of fun a b => u a * u b

/-- The orthogonal projection onto `span{u, v}` at orthonormal `u, v`. -/
def planeProj (u v : ι → ℝ) : Matrix ι ι ℝ := outer u + outer v

/-- **The pencil sum.** Over a pencil's basis `{f ∧ uᵢ}` the plane projections add
to `r · f fᵀ + Π_{U'}`, the shared direction `f` counted once per basis element.
Stated as a `Finset` sum so `r` is the cardinality. -/
theorem sum_planeProj_pencil {r : ℕ} (f : ι → ℝ) (u : Fin r → ι → ℝ) :
    ∑ i, planeProj f (u i) = (r : ℝ) • outer f + ∑ i, outer (u i) := by
  simp only [planeProj, Finset.sum_add_distrib, Finset.sum_const, Finset.card_univ,
    Fintype.card_fin]
  congr 1
  funext a b
  simp [Matrix.smul_apply, nsmul_eq_mul]

/-- **The `Λ²U` sum**, at `dim U = 3`: the three coordinate planes of a
three-space add to twice the projection onto it, each direction appearing in two
of the three planes. -/
theorem sum_planeProj_lambda2 (h₁ h₂ h₃ : ι → ℝ) :
    planeProj h₁ h₂ + planeProj h₂ h₃ + planeProj h₁ h₃
      = (2 : ℝ) • (outer h₁ + outer h₂ + outer h₃) := by
  funext a b
  simp only [planeProj, outer, Matrix.add_apply, Matrix.smul_apply, Matrix.of_apply,
    smul_eq_mul]
  ring

end HamiltonsCubic.Results
