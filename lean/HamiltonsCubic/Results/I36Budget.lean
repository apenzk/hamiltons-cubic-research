import HamiltonsCubic.Results.L94Statement
import HamiltonsCubic.Results.L174
import HamiltonsCubic.Results.L174Statement

set_option linter.style.longLine false

/-!
# [I36](../../../plan.md)'s shape-to-budget equivalence, with its hypothesis discharged

**[L174.lean](L174.lean) proves `I36_shape ↔ I36_budget` FROM an abstract `L94`**, and carries that
`L94` as a hypothesis because the file is stated over arbitrary types. *[plan-lean.md](../../../plan-lean.md)
read that hypothesis as a claim the layer proves nowhere.*

**It is proved, in [L94Statement.lean](L94Statement.lean)**, as `kappaSq_eq_two_iff`. This file
instantiates the abstract types at the concrete tensors and discharges it, so the equivalence holds
with no hypothesis left over.

**What this does NOT do, and [r1002](../../../reviews/REVIEW_r1002.md) sharpened it.** *It gives
I36 a mechanism and not a proof*: whether every unit local maximiser above `√(3/2)` attains the
budget is exactly as open as it was. **And `shape_iff_budget_concrete` carries nothing beyond
`l94_concrete`**, since `t` and `IsLocalMax` are never read and `theta` is universally quantified.
*The link to the plan item is a naming rather than a typing until `theta` and local-maximality are
defined at these types, which no file in the layer does.*
-/

namespace HamiltonsCubic.I36Budget

open HamiltonsCubic.L94Statement HamiltonsCubic.VertexBudget

variable {n : ℕ}

/-- The Weyl tensors of `Fin n`, as a type, so the abstract file's `Weyl` can be instantiated. -/
def WeylT (n : ℕ) : Type := {W : Tensor4 n // IsWeyl W}

/-- The orthonormal frames, as a type. -/
def FrameT (n : ℕ) : Type := {R : Fin n → Fin n → ℝ // IsFrame R}

/-- `W` read in the frame `F` is coordinate-diagonal. -/
def IsCoordDiagonalC (W : WeylT n) (F : FrameT n) : Prop :=
  CoordinateDiagonal (rotate F.1 W.1)

/-- `κ²` at the concrete tensor. -/
noncomputable def kappaSqC (W : WeylT n) : ℝ := kappaSq W.1

/-- Unit norm is `‖M‖_F² = 1`, the normalisation `kappaSq_eq_two_iff` is stated at. -/
def IsUnitC (W : WeylT n) : Prop := normM2 W.1 = 1

/-- **THE ABSTRACT `L94` HOLDS AT THE CONCRETE TENSORS.** *So the hypothesis
[L174.lean](L174.lean) carries is discharged rather than owed, and the record's debt table was
reading a proved statement as an open one.* -/
theorem l94_concrete :
    L94 (Weyl := WeylT n) (Frame := FrameT n) IsCoordDiagonalC kappaSqC IsUnitC := by
  intro W hW
  have h := kappaSq_eq_two_iff W.1 W.2 hW
  constructor
  · intro hk
    obtain ⟨R, hR, hcd⟩ := h.mp hk
    exact ⟨⟨R, hR⟩, hcd⟩
  · rintro ⟨F, hF⟩
    exact h.mpr ⟨F.1, F.2, hF⟩

/-- **THE SECOND `L94` IS DISCHARGED BY THE SAME TERM.** *[L174Statement.lean](L174Statement.lean)
carries its own `L94`, a different `Prop` of the same name, and `l94_concrete` is accepted at it on
the nose* ([r1002](../../../reviews/REVIEW_r1002.md)). **So both abstract `L94`s in the tree are
discharged**, which [plan-lean.md](../../../plan-lean.md)'s row collapses into one. -/
theorem l94_concrete' :
    HamiltonsCubic.L174Statement.L94 (W := WeylT n) (F := FrameT n)
      IsCoordDiagonalC kappaSqC IsUnitC := l94_concrete

/-- **The shape-to-budget equivalence at the concrete tensors, with no hypothesis.**

**IT CARRIES NO I36 CONTENT BEYOND `l94_concrete`, and saying otherwise was an overstatement**
([r1002](../../../reviews/REVIEW_r1002.md)). *`t` and `IsLocalMax` are passed to
[L174.lean](L174.lean)'s `shape_iff_budget` and never read, so this holds at `t = 0` and at
`IsLocalMax := fun _ => True`, and universal quantification over `theta` makes it formally stronger
while making the link to I36 a NAMING rather than a typing.* **Neither `theta` nor local-maximality
is defined at these types anywhere in the Lean layer**, and supplying them is the real work this
leaves. -/
theorem shape_iff_budget_concrete (theta : WeylT n → ℝ) (IsLocalMax : WeylT n → Prop) (t : ℝ) :
    I36_shape (Frame := FrameT n) IsCoordDiagonalC theta IsUnitC IsLocalMax t
      ↔ I36_budget kappaSqC theta IsUnitC IsLocalMax t :=
  shape_iff_budget (Frame := FrameT n) IsCoordDiagonalC kappaSqC theta IsUnitC IsLocalMax t
    l94_concrete

end HamiltonsCubic.I36Budget
