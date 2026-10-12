import HamiltonsCubic.Base.SelfDual

/-!
# Which 2-planes of `Λ²` lie inside the decomposable locus

[findings/diagonal-half.md](../../../findings/diagonal-half.md), the I36 section,
sub-step (a). [Ghorpade–Patil–Pillai](../../../references/decomposable-subspaces-grassmann-codes/notes.md)
Theorem 6 classifies the subspaces of `Λ²V` all of whose elements are
decomposable: at `ℓ = 2` they are the pencils `f ∧ U` and the `Λ²U` at
`dim U = 3`. This file types the algebraic core of that at dimension two, which
is a polarisation: a plane spanned by two decomposable forms lies inside the
locus exactly when the cross term `wedge2 ω η` vanishes.

That is the statement the record needs, because it separates the two conditions
I36b turns on. **A plane carrying a decomposable BASIS** is `wedgeSelf ω = 0` and
`wedgeSelf η = 0`. **A plane lying INSIDE the locus** adds `wedge2 ω η = 0`, and
[r849](../../../reviews/REVIEW_r849.md)'s `span{e₁∧e₂, e₃∧e₄}` is the witness
separating them.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Results

open Matrix HamiltonsCubic.RealLayer HamiltonsCubic.SelfDualLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The polarisation of the self-wedge.** `wedgeSelf` is the quadratic form of
the symmetric bilinear `wedge2`, so a combination expands with a cross term. -/
theorem wedgeSelf_smul_add (a b : ℝ) (X Y : Matrix ι ι ℝ) (i j k l : ι) :
    wedgeSelf (a • X + b • Y) i j k l
      = a ^ 2 * wedgeSelf X i j k l + 2 * (a * b) * wedge2 X Y i j k l
        + b ^ 2 * wedgeSelf Y i j k l := by
  show (halfw (a • X + b • Y) (a • X + b • Y) + halfw (a • X + b • Y) (a • X + b • Y)) i j k l
      = _
  simp only [halfw, Pi.add_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul,
    wedgeSelf, wedge2]
  ring

/-- **A plane spanned by two decomposable forms lies inside the decomposable
locus exactly when the cross term vanishes.** This is the `ℓ = 2` core of the
Structure Theorem: it is what makes "carries a decomposable basis" strictly
weaker than "is a decomposable subspace". -/
theorem plane_decomposable_iff_wedge2_zero (X Y : Matrix ι ι ℝ)
    (hX : wedgeSelf X = 0) (hY : wedgeSelf Y = 0) :
    (∀ a b : ℝ, wedgeSelf (a • X + b • Y) = 0) ↔ wedge2 X Y = 0 := by
  constructor
  · intro h
    funext i j k l
    have h1 := congrFun (congrFun (congrFun (congrFun (h 1 1) i) j) k) l
    rw [wedgeSelf_smul_add] at h1
    have hx : wedgeSelf X i j k l = 0 := by rw [hX]; rfl
    have hy : wedgeSelf Y i j k l = 0 := by rw [hY]; rfl
    have hz : (0 : ι → ι → ι → ι → ℝ) i j k l = 0 := rfl
    rw [hx, hy, hz] at h1
    show wedge2 X Y i j k l = (0 : ι → ι → ι → ι → ℝ) i j k l
    rw [hz]
    linarith
  · intro h a b
    funext i j k l
    have hx : wedgeSelf X i j k l = 0 := by rw [hX]; rfl
    have hy : wedgeSelf Y i j k l = 0 := by rw [hY]; rfl
    have hxy : wedge2 X Y i j k l = 0 := by rw [h]; rfl
    show wedgeSelf (a • X + b • Y) i j k l = (0 : ι → ι → ι → ι → ℝ) i j k l
    rw [wedgeSelf_smul_add, hx, hy, hxy]
    norm_num

/-- The two coordinate forms of the witness have vanishing self-wedge, which is
the holding half of the separation and which [r853](../../../reviews/REVIEW_r853.md)
found stated nowhere. -/
theorem wedgeSelf_phi_01 : wedgeSelf (phi (0 : Fin 4) 1) = 0 := by
  funext a b c d
  fin_cases a <;> fin_cases b <;> fin_cases c <;> fin_cases d <;>
    simp [wedgeSelf, wedge2, halfw, phi]

theorem wedgeSelf_phi_23 : wedgeSelf (phi (2 : Fin 4) 3) = 0 := by
  funext a b c d
  fin_cases a <;> fin_cases b <;> fin_cases c <;> fin_cases d <;>
    simp [wedgeSelf, wedge2, halfw, phi]

/-- **The failing half of the separation**, at `n = 4`: with the two theorems above
the plane spanned by `φ₀₁` and `φ₂₃` has a basis of vanishing self-wedge, and its
cross term is nonzero, so by `plane_decomposable_iff_wedge2_zero` the plane does
not have vanishing self-wedge throughout. -/
theorem wedge2_phi_ne_zero : wedge2 (phi (0 : Fin 4) 1) (phi (2 : Fin 4) 3) ≠ 0 := by
  intro h
  have := congrFun (congrFun (congrFun (congrFun h 0) 1) 2) 3
  simp [wedge2, halfw, phi, Matrix.sub_apply] at this

end HamiltonsCubic.Results
