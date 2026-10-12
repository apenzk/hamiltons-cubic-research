import HamiltonsCubic.Base.Families

/-!
# The `O(n)` action, and *coordinate-diagonal in some frame*

**Why this file exists.** [I1](../../../plan.md)'s theorem quantifies over `W` **non-diagonal**,
and the record means *coordinate-diagonal in no orthonormal frame*, a statement about the whole
`O(n)` orbit, not about the standard basis. [Families.lean](Families.lean) builds `diagOp`, which
is diagonality in the frame you are handed; without the action, `¬ ∃ w, R = diagOp w` is a strictly
weaker hypothesis and a theorem written against it would be a different theorem.

*[plan.md](../../../plan.md)'s B1 lists the `O(n)`-orbit predicates among the base layer's six
needs, and this is that one.*
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.FrameLayer

open HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

open Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **An orthogonal frame change.** -/
def IsOrth (U : Matrix ι ι ℝ) : Prop := Uᵀ * U = 1 ∧ U * Uᵀ = 1

theorem isOrth_one : IsOrth (1 : Matrix ι ι ℝ) := by
  constructor <;> simp

/-- **The action of a frame change on a curvature operator.** A bivector is carried by
`X ↦ Uᵀ X U`, so an operator on bivectors is carried by conjugation on both sides. -/
def conjOp (U : Matrix ι ι ℝ) (R : Matrix ι ι ℝ → Matrix ι ι ℝ) :
    Matrix ι ι ℝ → Matrix ι ι ℝ :=
  fun X => U * R (Uᵀ * X * U) * Uᵀ

theorem conjOp_one (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : conjOp 1 R = R := by
  funext X; simp [conjOp]

/-- **The frame change carries skew matrices to skew matrices**, so it acts on `Λ²`. -/
theorem isSkew_conj {U X : Matrix ι ι ℝ} (hX : IsSkew X) : IsSkew (Uᵀ * X * U) := by
  unfold IsSkew at hX ⊢
  rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose, hX]
  simp [Matrix.mul_assoc]

/-- **`R` is coordinate-diagonal in SOME orthonormal frame**, the record's *diagonal*, and the
negation of it is [I1](../../../plan.md)'s *non-diagonal*.

*Written against the standard frame alone this predicate is strictly smaller, and a theorem
assuming its negation would be assuming less than the record does.* -/
def IsCoordDiagonalSomeFrame (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : Prop :=
  ∃ U : Matrix ι ι ℝ, IsOrth U ∧ ∃ w : Matrix ι ι ℝ, IsWeight w ∧ conjOp U R = diagOp w

/-- **Diagonal in the standard frame is diagonal in some frame**, which is the direction that makes
the predicate non-vacuous. -/
theorem isCoordDiagonalSomeFrame_of_diagOp {w : Matrix ι ι ℝ} (hw : IsWeight w) :
    IsCoordDiagonalSomeFrame (diagOp w) :=
  ⟨1, isOrth_one, w, hw, conjOp_one _⟩

/-- **So a non-diagonal operator is not `diagOp` of anything**, which is the implication a consumer
of [I1](../../../plan.md)'s hypothesis actually uses. -/
theorem not_diagOp_of_not_coordDiagonal {R : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (h : ¬ IsCoordDiagonalSomeFrame R) {w : Matrix ι ι ℝ} (hw : IsWeight w) : R ≠ diagOp w := by
  rintro rfl
  exact h (isCoordDiagonalSomeFrame_of_diagOp hw)

end HamiltonsCubic.FrameLayer
