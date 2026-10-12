import HamiltonsCubic.Results.L174Statement
import HamiltonsCubic.Results.L94Statement

set_option linter.style.longLine false

/-!
# L174 on Weyl tensors, with L94 proved

[L174Statement.lean](L174Statement.lean) proves L174's class transfer over abstract predicates, with
[L94](../../../findings/bispectral.md) a named hypothesis `h94`. L94 is proved
([L94Statement.lean](L94Statement.lean)'s `kappaSq_eq_two_iff`), so the transfer holds on Weyl tensors outright:

* **`L94_holds`**: L174's `L94` predicate, instantiated at unit-norm Weyl tensors on `ℝⁿ`, orthonormal frames and
  `CoordinateDiagonal (rotate R W)`, is a theorem, which [I36Budget.lean](I36Budget.lean)'s `l94_concrete'` already
  proves at the same types;
* **`class_transfer_weyl`**: for every class `𝒞` of unit Weyl tensors, every member is coordinate-diagonal in some
  frame exactly when every member has `κ² = 2`;
* **`I36_shape_iff_budget_weyl`**: the specialisation [I36](../../../plan.md) needs, on the unit local maximisers
  with `θ > t`, for any predicates `IsLocalMax` and `theta`.
-/

namespace HamiltonsCubic.L174Statement

open HamiltonsCubic.L94Statement

variable {n : ℕ}

/-- Unit-norm Weyl tensors on `ℝⁿ`. -/
abbrev WeylT (n : ℕ) := {W : Tensor4 n // IsWeyl W}

/-- Orthonormal frames. -/
abbrev FrameT (n : ℕ) := {R : Fin n → Fin n → ℝ // IsFrame R}

/-- **L94, instantiated, is a theorem.** -/
theorem L94_holds :
    L94 (W := WeylT n) (F := FrameT n) (fun w f => CoordinateDiagonal (rotate f.1 w.1)) (fun w => kappaSq w.1)
      (fun w => normM2 w.1 = 1) := by
  intro w hw
  rw [kappaSq_eq_two_iff w.1 w.2 hw]
  constructor
  · rintro ⟨R, hR, h⟩; exact ⟨⟨R, hR⟩, h⟩
  · rintro ⟨⟨R, hR⟩, h⟩; exact ⟨R, hR, h⟩

/-- **L174 on Weyl tensors**: for every class `𝒞` of unit Weyl tensors, all members are coordinate-diagonal in some
frame exactly when all have `κ² = 2`. -/
theorem class_transfer_weyl (C : WeylT n → Prop) (hC : ∀ w, C w → normM2 w.1 = 1) :
    (∀ w, C w → ∃ f : FrameT n, CoordinateDiagonal (rotate f.1 w.1)) ↔ (∀ w, C w → kappaSq w.1 = 2) :=
  class_transfer _ _ _ C L94_holds hC

/-- **The specialisation I36 needs**, on Weyl tensors, for any local-maximum predicate and any `θ`. -/
theorem I36_shape_iff_budget_weyl (theta : WeylT n → ℝ) (IsLocalMax : WeylT n → Prop) (t : ℝ) :
    (∀ w, normM2 w.1 = 1 → IsLocalMax w → t < theta w → ∃ f : FrameT n, CoordinateDiagonal (rotate f.1 w.1))
      ↔ (∀ w, normM2 w.1 = 1 → IsLocalMax w → t < theta w → kappaSq w.1 = 2) :=
  I36_shape_iff_budget _ _ theta _ IsLocalMax t L94_holds

end HamiltonsCubic.L174Statement
