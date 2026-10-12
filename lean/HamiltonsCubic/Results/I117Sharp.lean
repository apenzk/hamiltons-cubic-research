import HamiltonsCubic.Results.I117Statements
import HamiltonsCubic.Results.L131Sharp
import HamiltonsCubic.Results.FoxBridge

set_option linter.style.longLine false

/-!
# L265's Weyl clause on `𝔰𝔬(n)`: `I # W = −W` at every Weyl `W`

`L265_I_sharp` ([I117Stable.lean](I117Stable.lean)) states three clauses of L265 together, the second being
*"`I # ·` is `−1` on Weyl operators"*. That clause is proved here on its own, from
[L131Sharp.lean](L131Sharp.lean)'s `sharpCross_id` (`W # I = −W` for a bare Weyl `W`) carried across the layers:

* **`sharpB_eq_sharpCross`**: the bundled polarised `#` of `CurvOp2` is the bare `sharpCross` of the extensions, on
  every bivector, through [CubicBridge.lean](CubicBridge.lean)'s `sharpOp_extend`;
* **`L265_weyl_clause`**: `sharpB idOp W = (−1) • W` at every `IsWeyl2 W`.
-/

namespace HamiltonsCubic.I117S

open HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The bundled polarised `#` is the bare one on bivectors.** -/
theorem sharpB_eq_sharpCross (A B : CurvOp2 ι) (X : skewSub ι) :
    ((sharpB A B X : skewSub ι) : Matrix ι ι ℝ) = sharpCross (extend A) (extend B) (X : Matrix ι ι ℝ) := by
  unfold sharpB sharpCross
  have hadd : extend (A + B) = extend A + extend B := funext (extend_add A B)
  rw [← hadd, sharpOp_extend, sharpOp_extend, sharpOp_extend]
  simp only [_root_.smul_apply, _root_.sub_apply, Submodule.coe_smul, Submodule.coe_sub,
    sharpMapCL_apply]

/-- **L265's Weyl clause**: `I # W = −W` at every Weyl `W` on `Λ²`. -/
theorem L265_weyl_clause (W : CurvOp2 ι) (hW : IsWeyl2 W) : sharpB idOp W = (-1 : ℝ) • W := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  rw [sharpB_eq_sharpCross]
  have hWe := isWeyl_extend hW
  -- `extend idOp` is the identity on bivectors
  have hid : ∀ Z, IsSkew Z → extend (idOp : CurvOp2 ι) Z = Z := fun Z hZ => by
    rw [show Z = ((⟨Z, hZ⟩ : skewSub ι) : Matrix ι ι ℝ) from rfl, extend_apply]; rfl
  have hidS : ∀ Z, IsSkew (extend (idOp : CurvOp2 ι) Z) := fun Z =>
    (idOp ⟨skewProj Z, skewProj_mem Z⟩ : skewSub ι).2
  have hsum : ∀ Z, IsSkew Z → IsSkew ((extend (idOp : CurvOp2 ι) + extend W) Z) := fun Z hZ => by
    have h1 := hidS Z; have h2 := hWe.1 Z hZ
    change IsSkew (extend idOp Z + extend W Z)
    unfold IsSkew at *; rw [Matrix.transpose_add, h1, h2]; abel
  have e : sharpCross (extend (idOp : CurvOp2 ι)) (extend W) (X : Matrix ι ι ℝ)
      = sharpCross (extend W) (fun Y => Y) (X : Matrix ι ι ℝ) := by
    unfold sharpCross
    rw [sharpOp_congr_on_skew (R := extend idOp + extend W) (S := extend W + fun Y => Y) hsum
        (fun Z hZ => by change extend idOp Z + extend W Z = extend W Z + Z; rw [hid Z hZ, add_comm]) _ X.2,
      sharpOp_congr_on_skew (R := extend idOp) (S := fun Y => Y) (fun Z _ => hidS Z) hid _ X.2]
    rw [sub_right_comm]
  rw [e, HamiltonsCubic.L41Statement.Frame.sharpCross_id hWe _ X.2, _root_.smul_apply, Submodule.coe_smul,
    extend_apply]
  simp

end HamiltonsCubic.I117S
