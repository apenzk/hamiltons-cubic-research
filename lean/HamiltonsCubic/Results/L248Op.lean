import Mathlib
import HamiltonsCubic.Results.I117Sharp
import HamiltonsCubic.Results.I117G2

set_option linter.style.longLine false

/-!
# L248, the operator ceiling, at the operator level

[findings/second-order.md](../../../findings/second-order.md), Lemma L248: *at a unit critical point
$W^2+W^\#=\theta W$ with $\lambda_{\max}=b$, every eigenvalue $\lambda_c$ satisfies
$\lambda_c(\theta-\lambda_c+2b)+(n-2)b^2\ge0$*, the proof being that $(W-b)\#(W-b)$ is positive semidefinite and
equals $\theta W-W^2+2bW+(n-2)b^2I$. [L248OperatorCeiling.lean](L248OperatorCeiling.lean) proves the inequality from
the per-vector rows taken as hypotheses. This file proves it from the operator, on `CurvOp2`:

* `sharpBil2_nonneg_of_nonpos`: $\langle(C\#C)X,X\rangle\ge0$ for a self-adjoint negative semidefinite $C$, in $C$'s
  eigenframe, where $(C\#C)$ is $\tfrac12\sum\lambda_\beta\lambda_\gamma\langle b_\beta,[X,b_\gamma]\rangle^2$
  (`sharpBil2_eigen`) and every $\lambda_\beta\lambda_\gamma\ge0$;
* **`L248_op`**: at a self-adjoint Weyl $W$ with $Q(W)=\theta W$, any $M$ with $W\preceq M$, and a unit eigenvector
  $Wx=\lambda x$, $\lambda(\theta-\lambda+2M)+(n-2)M^2\ge0$. The three terms are $W^\#=\theta W-W^2$ (criticality),
  $I\#W=-W$ (`L265_weyl_clause`) and $I\#I=(n-2)I$ (`sharpMap_id`); the per-vector rows are no longer hypotheses;
* `L244_xfree_op`: at an eigenvalue $-a$ with $W\preceq a$, $\theta\le a(n-5)$, L244 (ii)'s $x$-free bound.
-/

namespace HamiltonsCubic.L248Op

open HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.I117S Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`C#C` is positive semidefinite at a negative semidefinite `C`.** -/
theorem sharpBil2_nonneg_of_nonpos (C : CurvOp2 ι) (hC : IsSelfAdjoint2 C)
    (hneg : ∀ X : skewSub ι, inner2 ((C X : skewSub ι) : Matrix ι ι ℝ) (X : Matrix ι ι ℝ) ≤ 0) (X : skewSub ι) :
    0 ≤ sharpBil2 C X X := by
  have hs := opSk_symm hC
  let b := hs.eigenvectorBasis (n := Module.finrank ℝ (FrameExtension.SkewSp ι)) rfl
  let lam := hs.eigenvalues (n := Module.finrank ℝ (FrameExtension.SkewSp ι)) rfl
  have hCb : ∀ β, C (ofSk (b β)) = lam β • ofSk (b β) := fun β => by
    have h := hs.apply_eigenvectorBasis (n := Module.finrank ℝ (FrameExtension.SkewSp ι)) rfl β
    have h2 : C (ofSk (b β)) = ofSk (opSk C (b β)) := rfl
    rw [h2, h, ofSk_smul]; rfl
  have hunit : ∀ β, inner2 (FrameExtension.toM (b β)) (FrameExtension.toM (b β)) = 1 := fun β => by
    rw [← FrameExtension.inner_def, real_inner_self_eq_norm_sq, b.orthonormal.1 β]; norm_num
  have hlam : ∀ β, lam β ≤ 0 := fun β => by
    have := hneg (ofSk (b β))
    rw [hCb, Submodule.coe_smul, i2_smul_l, ofSk_coe, hunit, mul_one] at this
    exact this
  rw [sharpBil2_eigen b C lam hCb]
  apply mul_nonneg (by norm_num)
  refine Finset.sum_nonneg fun β _ => Finset.sum_nonneg fun γ _ => ?_
  have h1 : 0 ≤ lam β * lam γ := mul_nonneg_of_nonpos_of_nonpos (hlam β) (hlam γ)
  have h2 := mul_nonneg h1 (mul_self_nonneg (inner ℝ (b β) (toSk (brS X (ofSk (b γ))))))
  rw [mul_assoc]
  exact h2

/-- **L248 on `CurvOp2`.** At a self-adjoint Weyl `W` with `Q(W) = θW`, any upper bound `M` of its quadratic form,
and a unit eigenvector `W x = λ x`, `λ(θ − λ + 2M) + (n − 2)M² ≥ 0`. -/
theorem L248_op (W : CurvOp2 ι) (hsa : IsSelfAdjoint2 W) (hW : IsWeyl2 W) {θ : ℝ} (hcrit : Qop2 W = θ • W)
    {M : ℝ} (hM : ∀ X : skewSub ι, inner2 ((W X : skewSub ι) : Matrix ι ι ℝ) (X : Matrix ι ι ℝ)
      ≤ M * inner2 (X : Matrix ι ι ℝ) (X : Matrix ι ι ℝ))
    {x : skewSub ι} {lam : ℝ} (hx : W x = lam • x) (hx1 : inner2 (x : Matrix ι ι ℝ) (x : Matrix ι ι ℝ) = 1) :
    0 ≤ lam * (θ - lam + 2 * M) + ((Fintype.card ι : ℝ) - 2) * M ^ 2 := by
  have hIsa : IsSelfAdjoint2 (idOp : CurvOp2 ι) := fun _ _ => rfl
  have hCsa : IsSelfAdjoint2 (W + (-M) • idOp : CurvOp2 ι) := isSelfAdjoint2_add hsa (isSelfAdjoint2_smul hIsa _)
  have hCneg : ∀ X : skewSub ι,
      inner2 ((((W + (-M) • idOp : CurvOp2 ι)) X : skewSub ι) : Matrix ι ι ℝ) (X : Matrix ι ι ℝ) ≤ 0 := by
    intro X
    have e : ((((W + (-M) • idOp : CurvOp2 ι)) X : skewSub ι) : Matrix ι ι ℝ)
        = ((W X : skewSub ι) : Matrix ι ι ℝ) + (-M) • (X : Matrix ι ι ℝ) := rfl
    rw [e, i2_add_l, i2_smul_l]
    linarith [hM X]
  have key := sharpBil2_nonneg_of_nonpos _ hCsa hCneg x
  have hP : ∀ S : CurvOp2 ι, innerOp2 (rk1 x) S = inner2 ((S x : skewSub ι) : Matrix ι ι ℝ) (x : Matrix ι ι ℝ) :=
    fun S => by rw [innerOp2_comm, innerOp2_rk1]
  have hF : ∀ A : CurvOp2 ι, Ftri A A (rk1 x)
      = inner2 ((sharpMapCL A x : skewSub ι) : Matrix ι ι ℝ) (x : Matrix ι ι ℝ) := fun A => by
    rw [Ftri_sharp, hP]
  rw [← inner2_sharpMap, ← sharpMapCL_apply, ← hF] at key
  simp only [Ftri_add_left, Ftri_add_mid, Ftri_smul_left, Ftri_smul_mid] at key
  -- `W# = θW − W²`
  have hWW : Ftri W W (rk1 x) = θ * lam - lam ^ 2 := by
    have hs : sharpMapCL W = θ • W - compOp2 W := by
      rw [← hcrit]; unfold Qop2; abel
    rw [hF, hs]
    have e : (θ • W - compOp2 W) x = (θ * lam - lam ^ 2) • x := by
      rw [_root_.sub_apply, _root_.smul_apply]
      show θ • W x - W (W x) = _
      rw [hx, map_smul, hx, smul_smul, smul_smul, ← sub_smul]
      congr 1
      ring
    rw [e, Submodule.coe_smul, i2_smul_l, hx1, mul_one]
  -- `I#I = (n − 2) I`
  have hII : Ftri idOp idOp (rk1 x) = (Fintype.card ι : ℝ) - 2 := by
    rw [hF, sharpMapCL_apply, sharpMap_id, i2_smul_l, hx1, mul_one]
  -- `I#W = −W`
  have hIW : Ftri W idOp (rk1 x) + Ftri idOp W (rk1 x) = -2 * lam := by
    have e1 : inner2 ((sharpB idOp W x : skewSub ι) : Matrix ι ι ℝ) (x : Matrix ι ι ℝ) = -lam := by
      rw [L265_weyl_clause W hW]
      show inner2 ((((-1 : ℝ) • W x) : skewSub ι) : Matrix ι ι ℝ) (x : Matrix ι ι ℝ) = -lam
      rw [Submodule.coe_smul, i2_smul_l, hx, Submodule.coe_smul, i2_smul_l, hx1]
      ring
    have e2 : inner2 ((sharpB idOp W x : skewSub ι) : Matrix ι ι ℝ) (x : Matrix ι ι ℝ)
        = (1 / 2) * (Ftri (idOp + W) (idOp + W) (rk1 x) - Ftri idOp idOp (rk1 x) - Ftri W W (rk1 x)) := by
      rw [hF, hF, hF]
      unfold sharpB
      simp only [ContinuousLinearMap.smul_apply, ContinuousLinearMap.sub_apply, Submodule.coe_smul,
        Submodule.coe_sub, i2_smul_l, i2_sub_l]
    simp only [Ftri_add_left, Ftri_add_mid] at e2
    linarith
  rw [hWW, hII] at key
  have h2 : -M * Ftri idOp W (rk1 x) + -M * Ftri W idOp (rk1 x) = 2 * M * lam := by
    linear_combination (-M) * hIW
  linarith [key, h2]

/-- **L244 (ii)'s `x`-free bound on `CurvOp2`**: at a self-adjoint Weyl `W` with `Q(W) = θW`, `W ⪯ a` and an
eigenvalue `−a`, `a > 0`, `θ ≤ a(n − 5)`. -/
theorem L244_xfree_op (W : CurvOp2 ι) (hsa : IsSelfAdjoint2 W) (hW : IsWeyl2 W) {θ : ℝ} (hcrit : Qop2 W = θ • W)
    {a : ℝ} (ha : 0 < a) (hM : ∀ X : skewSub ι, inner2 ((W X : skewSub ι) : Matrix ι ι ℝ) (X : Matrix ι ι ℝ)
      ≤ a * inner2 (X : Matrix ι ι ℝ) (X : Matrix ι ι ℝ))
    {x : skewSub ι} (hx : W x = (-a) • x) (hx1 : inner2 (x : Matrix ι ι ℝ) (x : Matrix ι ι ℝ) = 1) :
    θ ≤ a * ((Fintype.card ι : ℝ) - 5) := by
  have h := L248_op W hsa hW hcrit hM hx hx1
  nlinarith [h]

end HamiltonsCubic.L248Op
