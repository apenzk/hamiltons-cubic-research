import Mathlib
import HamiltonsCubic.Results.L1Statement
import HamiltonsCubic.Results.FrameOp2

set_option linter.style.longLine false

/-!
# L1 in every orthonormal frame

[L1Statement.lean](L1Statement.lean) proves L1 for Weyl operators diagonal in the coordinate frame. The record's
diagonal case is frame-free: $W$ diagonal in some orthonormal frame, that is $W=U\,W'(U^{\mathsf T}\cdot U)\,U^{\mathsf T}$ with $W'$
coordinate-diagonal and $U$ orthogonal ([r1768](../../../reviews/REVIEW_r1768.md) O1). This file carries it across:

* `conj_diag_invariants`: at a coordinate-diagonal Weyl $W$ and orthogonal $U$, $P(\mathrm{conj}_UW)=P(W)$ and
  $\lVert\mathrm{conj}_UW\rVert^2=\lVert W\rVert^2$, through $W$'s diagonal model `diagOp (wOf c)` (`pcubic_congr`) and
  [FrameOp2.lean](FrameOp2.lean)'s `Pcubic2_rotR`, `normSq2_rotR`;
* **`L1_frame`**: at $n=12,14$, every Weyl operator diagonal in an orthonormal frame has $P\le\theta_0(n)\lVert W\rVert^3$.
-/

namespace HamiltonsCubic.L1Frame

open Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.TensorBridge HamiltonsCubic.FrameLayer
  HamiltonsCubic.FrameOp2 HamiltonsCubic.L1Statement

variable {n : ℕ}

/-- The frame change of a linear Weyl operator is `rotR` of its restriction. -/
theorem restrict_conj_eq {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) {D : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ}
    (hD : IsWeyl D) : restrict (isWeyl_conj hU hD) = rotR U (restrict hD) := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  rw [rotR_coe, restrict_apply, restrict_apply, cU_coe]
  rfl

theorem conj_diag_invariants {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U)
    {W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} (hW : IsWeyl W) (hdiag : IsDiagonalOp W) :
    Pcubic (conjOp U W) = Pcubic W ∧ normSq (conjOp U W) = normSq W := by
  obtain ⟨c, hc⟩ := hdiag
  have hwt := wOf_isWeight hW hc
  set D := diagOp (wOf c)
  have hD : IsWeyl D := diagOp_isWeyl hwt
  have hL : IsLinOp D := isLinOp_diagOp _
  have hLc : IsLinOp (conjOp U D) := by
    refine ⟨fun X Y => ?_, fun r X => ?_⟩
    · unfold conjOp; rw [Matrix.mul_add, Matrix.add_mul, hL.1, Matrix.mul_add, Matrix.add_mul]
    · unfold conjOp; rw [Matrix.mul_smul, Matrix.smul_mul, hL.2, Matrix.mul_smul, Matrix.smul_mul]
  have hDc := isWeyl_conj hU hD
  -- `W` and its diagonal model agree on bivectors, before and after the frame change
  have hWD := pcubic_congr hW.1 (fun X hX => diag_eq hW hc hX)
  have hWDc := pcubic_congr (isWeyl_conj hU hW).1 (fun X hX => by
    show U * W (Uᵀ * X * U) * Uᵀ = U * D (Uᵀ * X * U) * Uᵀ
    rw [diag_eq hW hc (isSkew_conj hX)])
  -- the diagonal model through `CurvOp2`
  have hr := restrict_conj_eq hU hD
  have hP : Pcubic (conjOp U D) = Pcubic D := by
    rw [← Pcubic2_restrict hLc hDc, hr, Pcubic2_rotR hU (isWeyl2_restrict hD), Pcubic2_restrict hL hD]
  have hN : normSq (conjOp U D) = normSq D := by
    rw [← normSq2_restrict hLc hDc, hr, normSq2_rotR hU (isWeyl2_restrict hD), normSq2_restrict hL hD]
  exact ⟨hWDc.1.trans (hP.trans hWD.1.symm), hWDc.2.trans (hN.trans hWD.2.symm)⟩

/-- **L1 in every orthonormal frame.** -/
theorem L1_frame (hn : n = 12 ∨ n = 14) {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U)
    (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeyl W) (hdiag : IsDiagonalOp W) :
    Pcubic (conjOp U W) ≤ L1Statement.theta0 n * RealLayer.norm (conjOp U W) ^ 3 := by
  obtain ⟨hP, hN⟩ := conj_diag_invariants hU hW hdiag
  have hnorm : RealLayer.norm (conjOp U W) = RealLayer.norm W := by unfold RealLayer.norm; rw [hN]
  rw [hP, hnorm]
  exact L1 n hn (Fintype.card_fin n) W hW hdiag

end HamiltonsCubic.L1Frame
