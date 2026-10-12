import HamiltonsCubic.Results.CurvOpInner

set_option linter.style.longLine false

/-!
# `CurvOp2` under the record's norm, as an inner product space

[CurvOpInner.lean](CurvOpInner.lean) builds `curvOpCore`, the record's pairing `innerOp2` as an
`InnerProductSpace.Core`, and stops before registering an instance on `CurvOp2` itself: that type
already carries the native `ContinuousLinearMap` topology, and a norm built from the core brings a
second one ([r1006](../../../reviews/REVIEW_r1006.md), [r1017](../../../reviews/REVIEW_r1017.md)).

**This file registers it on a TYPE SYNONYM**, `RecCurv ι`, which has the same elements, addition
and scaling as `CurvOp2 ι` and no other structure, so the core's norm and topology are the only
ones present. *On `RecCurv ι`, `‖R‖² = normSq2 R` (`norm_sq_eq`) and `⟪R, S⟫ = innerOp2 R S`
(`inner_eq`), so the record's unit sphere IS the norm sphere, and Mathlib's inner-product
theorems (Cauchy–Schwarz, orthogonal complements, and in finite dimension the spectral theorem for
self-adjoint operators) apply to the record's own pairing.*

**Not done here**: transporting local maximality between the native topology of `CurvOp2` and the
norm topology of `RecCurv`, which agree in finite dimension but are not identified by this file.
-/

namespace HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`CurvOp2 ι` with only its linear structure**, ready to take the record's norm. -/
def RecCurv (ι : Type*) [Fintype ι] [DecidableEq ι] : Type _ := CurvOp2 ι

instance : AddCommGroup (RecCurv ι) := inferInstanceAs (AddCommGroup (CurvOp2 ι))

instance : Module ℝ (RecCurv ι) := inferInstanceAs (Module ℝ (CurvOp2 ι))

/-- The identification with `CurvOp2`, as a linear equivalence. -/
def RecCurv.equiv : CurvOp2 ι ≃ₗ[ℝ] RecCurv ι := LinearEquiv.refl ℝ (CurvOp2 ι)

/-- The record's pairing, as a core on the synonym. -/
@[instance_reducible] noncomputable def recCore : InnerProductSpace.Core ℝ (RecCurv ι) := curvOpCore (ι := ι)

noncomputable instance : NormedAddCommGroup (RecCurv ι) :=
  InnerProductSpace.Core.toNormedAddCommGroup (cd := recCore (ι := ι))

noncomputable instance : InnerProductSpace ℝ (RecCurv ι) :=
  InnerProductSpace.ofCore (recCore (ι := ι)).toCore

instance (ι : Type*) [Fintype ι] [DecidableEq ι] : FiniteDimensional ℝ (RecCurv ι) :=
  inferInstanceAs (FiniteDimensional ℝ (CurvOp2 ι))

/-- **The inner product is the record's `innerOp2`.** -/
theorem RecCurv.inner_eq (R S : RecCurv ι) :
    inner ℝ R S = innerOp2 (R : CurvOp2 ι) (S : CurvOp2 ι) := rfl

/-- **The norm squared is the record's `normSq2`**, so the record's unit sphere is the norm
sphere. -/
theorem RecCurv.norm_sq_eq (R : RecCurv ι) : ‖R‖ ^ 2 = normSq2 (R : CurvOp2 ι) := by
  rw [← real_inner_self_eq_norm_sq]; rfl

end HamiltonsCubic.RealLayer
