import Mathlib.Tactic
import HamiltonsCubic.Base.WeylTraceStatement
import HamiltonsCubic.Results.L209WeylClosure

/-!
# `FoxClosed`, proved: the closure hypothesis of the trace identities is L209

[WeylTraceStatement.lean](../Base/WeylTraceStatement.lean) takes `FoxClosed` as a hypothesis standing
in for [Fox's Lemma 5.7](../../../references/fox-2019-nonassociative-curvature-algebra/notes.md). L209's
`foxProd_isWeylOp` proves it, so `foxClosed` discharges that hypothesis at every `ι`.

* `linOfIsLinOp` and `isLinOp_curvLin` pass between `IsLinOp` and the bundled `CurvLin`.
* `foxClosed : FoxClosed ι`, with the witness the product itself, one map for every `Z`.
* **Not typed**: the two trace identities that take `FoxClosed` keep their `sorry`s;
  `leftMul_exists` is proved in [WeylTraceStatement.lean](../Base/WeylTraceStatement.lean).
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Results

open HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- A bundled map from a linear operator. -/
def linOfIsLinOp {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (h : IsLinOp R) : CurvLin ι where
  toFun := R
  map_add' := h.1
  map_smul' := fun c X => h.2 c X

theorem isLinOp_curvLin (R : CurvLin ι) : IsLinOp (fun X => R X) :=
  ⟨fun X Y => R.map_add X Y, fun c X => R.map_smul c X⟩

/-- **`FoxClosed` IS A THEOREM**: the hypothesis [WeylTraceStatement.lean](../Base/WeylTraceStatement.lean)
took in place of Fox's Lemma 5.7 is L209's `foxProd_isWeylOp`. -/
theorem foxClosed : FoxClosed ι := by
  intro X Y hX hY
  have hXw : IsWeylOp (fun A => X A) := ⟨isLinOp_curvLin X, hX⟩
  have hYw : IsWeylOp (fun A => Y A) := ⟨isLinOp_curvLin Y, hY⟩
  have hF := foxProd_isWeylOp _ _ hXw hYw
  refine ⟨linOfIsLinOp hF.1, hF.2, fun Z => rfl⟩

end HamiltonsCubic.Results

#print axioms HamiltonsCubic.Results.foxClosed  -- [propext, Classical.choice, Quot.sound]
