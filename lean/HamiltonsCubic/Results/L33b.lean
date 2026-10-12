import HamiltonsCubic.Base.Bridge
import HamiltonsCubic.Base.CP2
import HamiltonsCubic.Results.L33

/-!
# L33's operator identity, by the route that does not go through `#`

L33's proof runs on `Σ_α λ_α ad(v_α)² = 2W`, obtained by pairing first Bianchi
against `u ⊗ u` and killing `tr(u²v_α²)` with Ricci-flatness.

**That is `𝒜(W) = 2W` written in an eigenbasis**, `𝒜(W) = Σ_{g,h} W_{gh}
ad(φ_g) ad(φ_h)` is basis-free, and in `W`'s own eigenbasis it is the block's
sum. So L33's identity and relation (B) are one statement.

**Why it is worth checking again.** [B9](../Base/RelationB.lean) reached (B)
through `W # I = -W`, using the `#` operator. `𝒜` is computed here directly from
brackets, so the two routes share no machinery, and agreeing, they also confirm
`𝒜 = -2(· # I)`, the bridge whose sign the record once had backwards.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

/-- `𝒜(W)` as an operator on bivectors, straight from the definition:
`Σ_{g,h} W_{gh} ad(φ_g) ad(φ_h)`. -/
def calA (W : Matrix (Fin 6) (Fin 6) ℚ) (X : Matrix (Fin 4) (Fin 4) ℚ) :
    Matrix (Fin 4) (Fin 4) ℚ :=
  ∑ g : Fin 6, ∑ h : Fin 6, W g h • br (basis4 g) (br (basis4 h) X)

set_option maxHeartbeats 4000000 in
set_option maxRecDepth 100000 in
/-- **`𝒜(W) = 2W` at the competitor**, on each basis bivector, computed from
brackets alone, with no `#` anywhere. -/
theorem WCP2_calA (a : Fin 6) :
    calA WCP2 (basis4 a) = (2 : ℚ) • ofMatrix WCP2 (basis4 a) := by
  ext i j
  fin_cases a <;>
    simp only [Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Fin.isValue] <;>
    simp [calA, ofMatrix, WCP2, basis4, br, phi, toMat4, coord4, pair4,
      Matrix.mulVec, dotProduct, Fin.sum_univ_six, Fin.sum_univ_four,
      Matrix.mul_apply, Matrix.single_apply, Matrix.sub_apply, Matrix.add_apply,
      Matrix.smul_apply, Matrix.sum_apply, Matrix.of_apply, Fin.ext_iff] <;>
    fin_cases i <;> fin_cases j <;> norm_num

/-- **`W33` WRITTEN AS A LITERAL**, which is the whole of why the twin below now closes.

*`W33` is `Matrix.diagonal ![...]`, so every one of the thirty-six coefficient lookups in `calA`
goes through `diagonal_apply` and the terms deepen until `simp` walls on recursion depth.* **The
same matrix as a `!![...]` array closes under the UNMODIFIED script that retires `WCP2_calA`**, with
no raised `maxSteps`. *The form was the cause, and it was established by testing the diagnosis
rather than by reasoning from it* ([r1033](../../../reviews/REVIEW_r1033.md)). -/
def W33lit : Matrix (Fin 6) (Fin 6) ℚ :=
  !![ 2,  0,  0,  0,  0,  0;
      0, -1,  0,  0,  0,  0;
      0,  0, -1,  0,  0,  0;
      0,  0,  0, -1,  0,  0;
      0,  0,  0,  0, -1,  0;
      0,  0,  0,  0,  0,  2]

theorem W33lit_eq : W33lit = W33 := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [W33lit, W33, Fin.ext_iff]

set_option maxHeartbeats 4000000 in
set_option maxRecDepth 100000 in
/-- The rung at the literal form. -/
theorem W33lit_calA (a : Fin 6) :
    calA W33lit (basis4 a) = (2 : ℚ) • ofMatrix W33lit (basis4 a) := by
  ext i j
  fin_cases a <;>
    simp only [Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Fin.isValue] <;>
    simp [calA, ofMatrix, W33lit, basis4, br, phi, toMat4, coord4, pair4,
      Matrix.mulVec, dotProduct, Fin.sum_univ_six, Fin.sum_univ_four,
      Matrix.mul_apply, Matrix.single_apply, Matrix.sub_apply, Matrix.add_apply,
      Matrix.smul_apply, Matrix.sum_apply, Matrix.of_apply, Fin.ext_iff] <;>
    fin_cases i <;> fin_cases j <;> norm_num

/-- The same at [L33](L33.lean)'s own witness, transported across the two forms. -/
theorem W33_calA (a : Fin 6) :
    calA W33 (basis4 a) = (2 : ℚ) • ofMatrix W33 (basis4 a) := by
  rw [← W33lit_eq]; exact W33lit_calA a

end HamiltonsCubic.Base
