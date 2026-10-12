import HamiltonsCubic.Results.PhiTri

set_option linter.style.longLine false

/-!
# The differential of `P` as a bounded functional

**[r1016](../../../reviews/REVIEW_r1016.md) named three pieces between the line derivative and
Fermat**, and this file closes THE FIRST: `IsLocalMaxOn.hasFDerivWithinAt_nonpos` consumes an
`f' : StrongDual ℝ E`, a CONTINUOUS linear functional, and the layer had linearity without
boundedness.

**Linearity is `innerOp2`'s**, `innerOp2_add_left` and `innerOp2_smul_left`, both new this cycle.
**Boundedness is finite dimensionality**, `LinearMap.toContinuousLinearMap`, exactly as it was for
`sharpMapCL` and for `restrict`.

**THE SCOPED OPERATOR NORM IS WHAT PREVENTS THIS.** *With
`HamiltonsCubic.RealLayer.OperatorNorm` open, `IsTopologicalAddGroup (CurvOp2 ι)` fails to
synthesize and the bundling does not elaborate; without it, the NATIVE `ContinuousLinearMap`
topology supplies everything and the same definition goes through unchanged.* **The instance
situation is the one [r1006](../../../reviews/REVIEW_r1006.md) and
[r1008](../../../reviews/REVIEW_r1008.md) documented**, a scoped norm carrying its own topology
beside the native one, *and the failure reads as a missing hypothesis when it is an extra `open`.*

**THE TWO NEEDS DO NOT PULL OPPOSITE WAYS, AND A FIRST VERSION SAID THEY DID**
([r1017](../../../reviews/REVIEW_r1017.md), which compiled the composition). *`PcubicDiff R`, built
OUTSIDE the scope, is the `StrongDual` Fermat consumes INSIDE it.* **Nor does that scope exist to
make `IsLocalMaxOn` elaborate**: [Bivectors2.lean](../Base/Bivectors2.lean) says in its own words
that `IsLocalMaxOn` reads only the topology, which is present without any norm, and the scoped
instances are there to discharge Fermat's `NormedSpace` hypotheses.

**AND THE `Fin n` RESTRICTION WAS MINE, NOT THE ELABORATOR'S.** *A first version blamed the index
type, having changed the type and the scope in one step and credited the wrong one*; at a general
`ι` outside the scope this elaborates unchanged.

**WHAT THIS DOES NOT DO.** *It does not make `Pcubic2` Fréchet differentiable*: that is
[r1016](../../../reviews/REVIEW_r1016.md)'s SECOND piece, *whose estimate on `Pcubic2Quad` is now
proved in [CubicTri.lean](CubicTri.lean) while the `HasFDerivAt` statement itself is not.*
**Nor does it compute the tangent cone**, which is the third and is on no one's list but the plan's.

**THE ORDINALS ABOVE WERE SWAPPED UNTIL [r1024](../../../reviews/REVIEW_r1024.md) AND
[r1025](../../../reviews/REVIEW_r1025.md) CAUGHT IT**, *this file having called itself the second
and the estimate the first*, **and [CubicTri.lean](CubicTri.lean) inherited the swap from here.**
-/

namespace HamiltonsCubic.RealLayer

open Matrix Finset
open scoped Matrix.Norms.Frobenius

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`S ↦ 3⟨S, Q(R)⟩` as a continuous linear functional.** -/
noncomputable def PcubicDiff (R : CurvOp2 ι) : CurvOp2 ι →L[ℝ] ℝ :=
  LinearMap.toContinuousLinearMap
    { toFun := fun S => 3 * innerOp2 S (Qop2 R)
      map_add' := fun S S' => by
        show 3 * innerOp2 (S + S') (Qop2 R) = _
        rw [innerOp2_add_left]
        ring
      map_smul' := fun c S => by
        show 3 * innerOp2 (c • S) (Qop2 R) = _
        rw [innerOp2_smul_left]
        simp only [RingHom.id_apply, smul_eq_mul]
        ring }

/-- **And it computes the value the first variation gives.** -/
theorem PcubicDiff_apply (R S : CurvOp2 ι) :
    PcubicDiff R S = 3 * innerOp2 S (Qop2 R) := by
  show LinearMap.toContinuousLinearMap _ S = _
  simp

/-- **THE LINEAR PART OF THE GENERAL INCREMENT IS THIS FUNCTIONAL**, at a self-adjoint `R`. -/
theorem PcubicDiff_eq_lin {R : CurvOp2 ι} (hR : IsSelfAdjoint2 R) (H : CurvOp2 ι) :
    PcubicDiff R H = Pcubic2Lin R H := by
  rw [PcubicDiff_apply, Pcubic2Lin_selfAdjoint hR]

end HamiltonsCubic.RealLayer
