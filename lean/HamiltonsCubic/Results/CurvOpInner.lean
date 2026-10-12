import HamiltonsCubic.Results.TraceOp

set_option linter.style.longLine false

/-!
# `innerOp2` as an inner product on `CurvOp2`

**[Bivectors2.lean](../Base/Bivectors2.lean) names this as "the repair that would close both at
once"**, and two rounds have now shown what both are.

- *The scoped `OperatorNorm` gives `CurvOp2` the SUP operator norm, whose unit sphere is not the
  record's*: `‖id‖ = 1` against `normSq2 id = ½n(n-1)`.
- *And opening it breaks `LinearMap.toContinuousLinearMap` at `CurvOp2`*, because the norm carries
  its own topology beside the native `ContinuousLinearMap` one
  ([r1017](../../../reviews/REVIEW_r1017.md)).

**This file builds the CORE**, the algebraic half, over the record's own pairing. *Its definiteness
is `normSq2_eq_zero`, its nonnegativity `inner2_self_nonneg` summed, and its bilinearity the four
lemmas [TraceOp.lean](TraceOp.lean) added.* **What it does NOT yet do is register an instance**,
which is where the topology question lives and where
[r1006](../../../reviews/REVIEW_r1006.md) and [r1008](../../../reviews/REVIEW_r1008.md) recorded
the trap: registering a norm that builds its own topology leaves `TopologicalSpace` and
`UniformSpace` resolving to one structure while `Bornology` comes from another.

**THE CONSTRUCTOR'S THREE TOPOLOGICAL INSTANCE HYPOTHESES ALL SYNTHESIZE** at `CurvOp2 (Fin n)`
in the NATIVE topology, checked rather than assumed: `TopologicalSpace`, `IsTopologicalAddGroup` and
`ContinuousConstSMul ℝ`, *every one through `ContinuousLinearMap`'s own instances.* **`T2Space` and
`FiniteDimensional ℝ` synthesize too and belong to a DIFFERENT lemma**, the compactness route to the
second side condition, *and a first version of this paragraph counted them among the constructor's
own hypotheses* ([r1021](../../../reviews/REVIEW_r1021.md), refuted by `#check`).

**AND THE FIRST OF ITS TWO SIDE CONDITIONS IS PROVED HERE**,
`continuousAt_innerOp2_self_zero`. *What remains is the second,
`Bornology.IsVonNBounded ℝ {v | innerOp2 v v < 1}`.*

**THAT IS ONE STATEMENT AND NOT ONE LEMMA, AND A FIRST VERSION OF THIS NOTE SAID OTHERWISE.**
*Mathlib's route to it is `IsCompact.isVonNBounded` together with a compact superset, and getting
`{v | innerOp2 v v ≤ 1}` compact in the NATIVE topology needs the finite-dimensional homeomorphism
to `Fin d → ℝ` and then that a positive-definite form has bounded sublevel sets.* **The record
called this "locally-convex machinery" and that was the more accurate description**; calling it one
lemma was an over-correction of a correct note.

**AND IT IS NOT ON THE CRITICAL PATH FOR FERMAT.** *The scoped `OperatorNorm` already supplies the
`NormedAddCommGroup` and `NormedSpace` that `IsLocalMaxOn.hasFDerivWithinAt_nonpos` wants, and
[r1017](../../../reviews/REVIEW_r1017.md) compiled `PcubicDiff`, built OUTSIDE the scope, into that
lemma INSIDE it.* **The constraint set `{S | normSq2 S = 1}` is a SET rather than a norm-sphere**,
so the sup norm stating a different sphere costs nothing there. *What this file would buy is that
`normSq2` IS the norm, which is a convenience and not a blocker.*
-/

namespace HamiltonsCubic.RealLayer

open Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`innerOp2` is nonnegative on the diagonal.** -/
theorem innerOp2_self_nonneg (R : CurvOp2 ι) : 0 ≤ innerOp2 R R := by
  unfold innerOp2
  have : (0:ℝ) ≤ ∑ i : ι, ∑ j : ι, inner2 (applyPhi R i j) (applyPhi R i j) :=
    Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => inner2_self_nonneg _
  linarith

/-- **`CurvOp2` as an inner product space over the record's own pairing**, algebraically.
*`normSq R = 1` is the record's unit sphere, and this is the pairing that makes it one.* -/
noncomputable def curvOpCore : InnerProductSpace.Core ℝ (CurvOp2 ι) where
  inner R S := innerOp2 R S
  conj_inner_symm R S := by simpa using innerOp2_comm S R
  re_inner_nonneg R := by simpa using innerOp2_self_nonneg R
  add_left R S T := by simpa using innerOp2_add_left R S T
  smul_left R S c := by simpa using innerOp2_smul_left c R S
  definite R h := normSq2_eq_zero h

/-! ## Continuity of the form, the first of the constructor's two side conditions -/

/-- **Evaluating an operator at a fixed bivector is continuous**, in the NATIVE
`ContinuousLinearMap` topology. -/
theorem continuous_applyPhi (i j : ι) :
    Continuous (fun R : CurvOp2 ι => applyPhi R i j) := by
  have h : Continuous (fun R : CurvOp2 ι => R ⟨phi i j, phi_mem_skewSub i j⟩) :=
    continuous_eval_const _
  exact continuous_subtype_val.comp h

/-- **`inner2` is continuous in each argument separately**, being a polynomial in the entries. -/
theorem continuous_inner2_of {α : Type*} [TopologicalSpace α]
    {f g : α → Matrix ι ι ℝ} (hf : Continuous f) (hg : Continuous g) :
    Continuous (fun a => inner2 (f a) (g a)) := by
  simp only [inner2_eq_sum]
  fun_prop

/-- **SO THE QUADRATIC FORM IS CONTINUOUS**, which is the first side condition of
`InnerProductSpace.Core.toNormedAddCommGroupOfTopology`. -/
theorem continuous_innerOp2_self : Continuous (fun R : CurvOp2 ι => innerOp2 R R) := by
  unfold innerOp2
  have h : ∀ i j : ι, Continuous (fun R : CurvOp2 ι => inner2 (applyPhi R i j) (applyPhi R i j)) :=
    fun i j => continuous_inner2_of (continuous_applyPhi i j) (continuous_applyPhi i j)
  fun_prop

/-- **And hence continuous at `0`.** -/
theorem continuousAt_innerOp2_self_zero :
    ContinuousAt (fun R : CurvOp2 ι => innerOp2 R R) 0 :=
  continuous_innerOp2_self.continuousAt

end HamiltonsCubic.RealLayer
