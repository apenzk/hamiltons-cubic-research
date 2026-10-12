import HamiltonsCubic.Results.CubicTri

set_option linter.style.longLine false

/-!
# `P` is Fréchet differentiable, which is r1016's second piece

**[r1016](../../../reviews/REVIEW_r1016.md) named three pieces between the line derivative and
Fermat**: the bundled `StrongDual`, Fréchet differentiability, and a `posTangentConeAt` membership.
*[PcubicDiff.lean](PcubicDiff.lean) closed the first.* **This file closes the SECOND.**

**THE TOPOLOGY DIAMOND HAD TO BE DEFEATED FIRST, AND NAMING THE RIGHT CONSTRUCTOR DID IT.**
*[Bivectors2.lean](../Base/Bivectors2.lean)'s scoped norm is `ContinuousLinearMap.toNormedAddCommGroup`,
which builds its own topology beside the native one.* **So a `CurvOp2 ι →L[ℝ] ℝ` built OUTSIDE the
scope carries `ContinuousLinearMap.topologicalSpace` and a `HasFDerivAt` about it elaborates with a
MIXED instance set**, the scoped norm's `AddCommGroup` against the native topology, *which `rw` then
refuses because it matches at reducible transparency while the two agree only at default.*

**A FIRST VERSION OF THIS PARAGRAPH SAID THE INSTANCE'S OWN DOCSTRING CONTRADICTED IT**, *and it
does not*: that docstring says the REPAIR, an `InnerProductSpace` over `innerOp2`, would be built
with `toNormedAddCommGroupOfTopology` so the topology is kept. **It describes what the repair would
do, not what the current instance does**, and reading it as a claim about the current instance is
the same misreading this file's own history is full of.

**THE FIX IS ONE MOVE, AND A FIRST VERSION OF THIS PARAGRAPH CLAIMED TWO**
([r1026](../../../reviews/REVIEW_r1026.md), [r1027](../../../reviews/REVIEW_r1027.md), agreeing).
**`hasFDerivAt_iff_isLittleO_nhds_zero` IS USED AS A TERM RATHER THAN THROUGH `rw`**, since term
elaboration unifies at default transparency where the instances are defeq. *That move is the whole
of it.*

**THE SECOND MOVE BOUGHT NOTHING**: *`PcubicDiffS R = PcubicDiff R` holds by `rfl`, the `rw` fails
IDENTICALLY at both bundlings, and `hasFDerivAt_Pcubic2` proves the statement about
[PcubicDiff.lean](PcubicDiff.lean)'s functional too*, **the mixing living in `HasFDerivAt`'s own
instance arguments rather than in where the functional was built.** *`PcubicDiffS` is kept because
it is the same term and costs nothing, not because it was needed.* **A first reading of the `rw`
failure made the inner product a blocker for the third time in this session**, and the diagnosis
that replaced it was also drawn from where the failure appeared rather than from what it said.

**WHAT THIS LEFT IS NOW DELIVERED.** *The third piece, a `posTangentConeAt {normSq2 = 1} R`
membership, is [SphereTangent.lean](SphereTangent.lean)'s `mem_posTangentConeAt_sphere`*, on the
standard three axioms: every `y` orthogonal to a unit `a` lies in that cone.

**THE WITNESS IS THE NORMALISED CURVE RATHER THAN A SEGMENT**, since `a + t • y` leaves the sphere
and Mathlib's segment entry points therefore do not apply. *Its three obligations reduce to two
scalar limits over `ℝ` and one algebraic decomposition, all proved there.*

**AND A PLUMBING FACT THAT COST THAT FILE MOST OF ITS TIME, RECORDED HERE BECAUSE THIS FILE WORKS
OVER THE SAME TYPE.** *On `CurvOp2` instance search will not chase projections*: `Module ℝ`
synthesizes while `DistribSMul ℝ` does not, and `IsTopologicalAddGroup` synthesizes while
`ContinuousAdd` does not. **So `smul_add`, `smul_smul` and `zero_smul` never fire, and the `module`
tactic is what closes every module-level identity.** *Supplying the missing projection with a local
`haveI` does NOT help, the goal having already elaborated against the original instance.*
-/

namespace HamiltonsCubic.RealLayer

open Matrix Finset
open scoped Matrix.Norms.Frobenius
open scoped HamiltonsCubic.RealLayer.OperatorNorm

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`S ↦ 3⟨S, Q(R)⟩` BUNDLED INSIDE THE SCOPE**, through `mkContinuous` with the bound
`abs_innerOp2_le` supplies. *[PcubicDiff.lean](PcubicDiff.lean)'s version is the same functional
bundled OUTSIDE it, and the two are the SAME TERM at the SAME TYPE*, `rfl`, **both carrying the
native topology** ([r1027](../../../reviews/REVIEW_r1027.md) compared their `pp.explicit` types
character by character). *A first version of this line said they differ in which topology their
`→L` carries, which is false.* -/
noncomputable def PcubicDiffS (R : CurvOp2 ι) : CurvOp2 ι →L[ℝ] ℝ :=
  LinearMap.mkContinuous
    { toFun := fun S => 3 * innerOp2 S (Qop2 R)
      map_add' := fun S S' => by
        show 3 * innerOp2 (S + S') (Qop2 R) = _
        rw [innerOp2_add_left]; ring
      map_smul' := fun c S => by
        show 3 * innerOp2 (c • S) (Qop2 R) = _
        rw [innerOp2_smul_left]; simp only [RingHom.id_apply, smul_eq_mul]; ring }
    (3 * ‖Qop2 R‖ * normSq2 (ContinuousLinearMap.id ℝ (skewSub ι)))
    (fun S => by
      show |3 * innerOp2 S (Qop2 R)| ≤ _
      rw [abs_mul, abs_of_nonneg (by norm_num : (0:ℝ) ≤ 3)]
      have h := abs_innerOp2_le S (Qop2 R)
      nlinarith [h, _root_.norm_nonneg S, _root_.norm_nonneg (Qop2 R)])

/-- **It computes what the first variation gives.** -/
theorem PcubicDiffS_apply (R S : CurvOp2 ι) : PcubicDiffS R S = 3 * innerOp2 S (Qop2 R) := rfl

/-- **AND IT IS THE LINEAR PART OF THE GENERAL INCREMENT**, at a self-adjoint `R`. -/
theorem PcubicDiffS_eq_lin {R : CurvOp2 ι} (hR : IsSelfAdjoint2 R) (H : CurvOp2 ι) :
    PcubicDiffS R H = Pcubic2Lin R H := by
  rw [PcubicDiffS_apply, Pcubic2Lin_selfAdjoint hR]

/-- **The constant is nonnegative**, both its summands being sums of self-pairings. -/
theorem cubicConst_nonneg : (0:ℝ) ≤ cubicConst ι := by
  unfold cubicConst
  have h0 : (0:ℝ) ≤ normSq2 (ContinuousLinearMap.id ℝ (skewSub ι)) := by
    show (0:ℝ) ≤ (1/2) * ∑ i : ι, ∑ j : ι, inner2 (applyPhi _ i j) (applyPhi _ i j)
    have : (0:ℝ) ≤ ∑ i : ι, ∑ j : ι, inner2 (applyPhi
        (ContinuousLinearMap.id ℝ (skewSub ι)) i j) (applyPhi
        (ContinuousLinearMap.id ℝ (skewSub ι)) i j) :=
      Finset.sum_nonneg fun _ _ => Finset.sum_nonneg fun _ _ => inner2_self_nonneg _
    linarith
  nlinarith [h0, sq_nonneg (phiWeight ι)]

/-- **THE WHOLE REMAINDER IS `O(‖H‖²)` ON THE UNIT BALL.** *The cubic term is absorbed into the
quadratic one there, which is why the hypothesis `‖H‖ ≤ 1` costs nothing: `HasFDerivAt` reads a
neighbourhood of zero.* -/
theorem abs_remainder_le {R : CurvOp2 ι} (hR : IsSelfAdjoint2 R) (H : CurvOp2 ι) (hH : ‖H‖ ≤ 1) :
    |Pcubic2 (R + H) - Pcubic2 R - PcubicDiffS R H|
      ≤ (3 * cubicConst ι * ‖R‖ + cubicConst ι) * ‖H‖^2 := by
  have hid : Pcubic2 (R + H) - Pcubic2 R - PcubicDiffS R H = Pcubic2Quad R H + Pcubic2 H := by
    rw [Pcubic2_expand, PcubicDiffS_eq_lin hR]; ring
  rw [hid]
  have h1 := abs_Pcubic2Quad_le R H
  have h2 := abs_Pcubic2_le H
  have hc := cubicConst_nonneg (ι := ι)
  have hn : (0:ℝ) ≤ ‖H‖ := _root_.norm_nonneg H
  have hcube : ‖H‖ * ‖H‖ * ‖H‖ ≤ ‖H‖^2 := by nlinarith [hn, hH]
  have hstep : cubicConst ι * (‖H‖ * ‖H‖ * ‖H‖) ≤ cubicConst ι * ‖H‖^2 :=
    mul_le_mul_of_nonneg_left hcube hc
  calc |Pcubic2Quad R H + Pcubic2 H| ≤ |Pcubic2Quad R H| + |Pcubic2 H| := _root_.abs_add_le _ _
    _ ≤ (3 * cubicConst ι * ‖R‖ + cubicConst ι) * ‖H‖^2 := by nlinarith [h1, h2, hstep]

open Asymptotics Filter in
/-- **`P` IS FRÉCHET DIFFERENTIABLE AT EVERY SELF-ADJOINT `R`**, with derivative `S ↦ 3⟨S, Q(R)⟩`.
*This is what [r1016](../../../reviews/REVIEW_r1016.md) named as its second piece, and what the four
`_line` lemmas could not give, since they scalarise `t` out before the remainder is named.* -/
theorem hasFDerivAt_Pcubic2 {R : CurvOp2 ι} (hR : IsSelfAdjoint2 R) :
    HasFDerivAt Pcubic2 (PcubicDiffS R) R := by
  refine hasFDerivAt_iff_isLittleO_nhds_zero.mpr ?_
  rw [Asymptotics.isLittleO_iff]
  intro c hc
  set K : ℝ := 3 * cubicConst ι * ‖R‖ + cubicConst ι with hK
  have hKnn : (0:ℝ) ≤ K := by
    have := cubicConst_nonneg (ι := ι); nlinarith [this, _root_.norm_nonneg R]
  have hpos : (0:ℝ) < min 1 (c / (K + 1)) := lt_min one_pos (by positivity)
  have hball : ∀ᶠ H : CurvOp2 ι in nhds 0, ‖H‖ < min 1 (c / (K + 1)) :=
    eventually_nhds_iff.mpr ⟨Metric.ball 0 (min 1 (c / (K + 1))),
      fun H hH => by simpa [dist_zero_right] using hH, Metric.isOpen_ball, by simpa using hpos⟩
  filter_upwards [hball] with H hH
  have h1 : ‖H‖ ≤ 1 := le_of_lt (lt_of_lt_of_le hH (min_le_left _ _))
  have h2 : ‖H‖ < c / (K + 1) := lt_of_lt_of_le hH (min_le_right _ _)
  have hn : (0:ℝ) ≤ ‖H‖ := _root_.norm_nonneg H
  have hstep : K * ‖H‖^2 ≤ c * ‖H‖ := by
    rcases eq_or_lt_of_le hn with h | h
    · simp [← h]
    · have hKH : K * ‖H‖ < c := by
        have := (lt_div_iff₀ (by linarith : (0:ℝ) < K + 1)).mp h2
        nlinarith [this, hKnn, h]
      nlinarith [hKH, h]
  calc ‖Pcubic2 (R + H) - Pcubic2 R - PcubicDiffS R H‖
      = |Pcubic2 (R + H) - Pcubic2 R - PcubicDiffS R H| := rfl
    _ ≤ K * ‖H‖^2 := abs_remainder_le hR H h1
    _ ≤ c * ‖H‖ := hstep

end HamiltonsCubic.RealLayer
