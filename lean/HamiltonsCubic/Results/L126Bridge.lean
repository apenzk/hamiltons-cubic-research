import HamiltonsCubic.Results.L126Splits
import HamiltonsCubic.Results.L0Witness
import HamiltonsCubic.Results.L234Split

set_option linter.style.longLine false

/-!
# L126 across the layers: the `(2,2)` Bianchi vector is an eigenvector of `L_e` on `CurvOp2` with eigenvalue `μ_{p,q}`

[findings/second-order.md](../../../findings/second-order.md), Lemma L126. [L126Assembly.lean](L126Assembly.lean) proves
the eigen-equation for the bare Fox product `foxProd` on matrix maps, and [L126Kernel.lean](L126Kernel.lean) carries
`DF(M) = θ(2L_e − Id)` with `L_e = LeLin` on the bundled operators `CurvOp2`. This file joins them on `Fin n`:

* **`split_LeLin`**: at a unit sphere product `M = restrict (diagOp (t · sphereWeight T))` and a `(2,2)`-split,
  `LeLin M v = μ_{p,q} • v` for the Bianchi vector `v = restrictLin (2a − b − c)`, the eigen-equation of the operator
  `critMap_kernel_iff` reads, with `v ≠ 0` proved in [L126Final.lean](L126Final.lean).
-/

namespace HamiltonsCubic.L126Assembly

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block HamiltonsCubic.TensorBridge

variable {n : ℕ}

/-- The Bianchi vector `2a − b − c` as a bare operator. -/
noncomputable def splitVec (i j k l : Fin n) : CurvOp (Fin n) := fun Y =>
  (2 : ℝ) • rk2 (phi i j) (phi k l) Y + (-1 : ℝ) • rk2 (phi k i) (phi j l) Y + (-1 : ℝ) • rk2 (phi i l) (phi j k) Y

theorem splitVec_lin (i j k l : Fin n) : IsLinOp (splitVec i j k l) := by
  refine ⟨fun X Y => ?_, fun c X => ?_⟩
  · simp only [splitVec, (isLinOp_rk2 _ _).1, smul_add]; abel
  · simp only [splitVec, (isLinOp_rk2 _ _).2, smul_add, smul_comm c]

theorem rk2_skew {U V : Matrix (Fin n) (Fin n) ℝ} (hU : IsSkew U) (hV : IsSkew V) (X : Matrix (Fin n) (Fin n) ℝ) :
    IsSkew (rk2 U V X) := by
  unfold IsSkew at *; unfold rk2
  rw [Matrix.transpose_add, Matrix.transpose_smul, Matrix.transpose_smul, hU, hV, smul_neg, smul_neg, neg_add]

theorem splitVec_skew (i j k l : Fin n) (X : Matrix (Fin n) (Fin n) ℝ) : IsSkew (splitVec i j k l X) := by
  have h1 := rk2_skew (phi_isSkew i j) (phi_isSkew k l) X
  have h2 := rk2_skew (phi_isSkew k i) (phi_isSkew j l) X
  have h3 := rk2_skew (phi_isSkew i l) (phi_isSkew j k) X
  unfold IsSkew at *; unfold splitVec
  rw [Matrix.transpose_add, Matrix.transpose_add, Matrix.transpose_smul, Matrix.transpose_smul, Matrix.transpose_smul,
    h1, h2, h3]
  simp only [smul_neg]; abel

/-- **THE EIGEN-EQUATION `LeLin M v = μ_{p,q} • v` ON `CurvOp2`**, at a unit sphere product and a `(2,2)`-split. -/
theorem split_LeLin (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {i j k l : Fin n} (hi : i ∈ T) (hj : j ∈ T) (hk : k ∉ T)
    (hl : l ∉ T) (hij : i ≠ j) (hkl : k ≠ l) :
    let hW : IsWeyl (diagOp (t • sphereWeight T)) := diagOp_isWeyl ((sphereWeight_isWeight T hp hq).smul t)
    LeLin (restrict hW) (restrictLin (splitVec_lin i j k l) (fun X _ => splitVec_skew i j k l X))
      = HamiltonsCubic.L126Statement.mu T.card Tᶜ.card • restrictLin (splitVec_lin i j k l) (fun X _ => splitVec_skew i j k l X) := by
  intro hW
  set w := t • sphereWeight T with hwdef
  set M := restrict hW
  set v := restrictLin (splitVec_lin i j k l) (fun X _ => splitVec_skew i j k l X)
  have hP : Pcubic2 M = theta (diagOp w) := by
    rw [Pcubic2_restrict (isLinOp_diagOp w) hW, theta_of_unit _ hn]
  have hval := split_value_eq T hp hq t ht hn hi hj hk hl hij hkl
  simp only at hval
  have hθ : theta (diagOp w) ≠ 0 := by
    intro h0; rw [h0, mul_zero, div_zero] at hval
    have : 0 < HamiltonsCubic.L126Statement.mu T.card Tᶜ.card := by
      unfold HamiltonsCubic.L126Statement.mu
      have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
      have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
      have : 0 < (T.card : ℝ) - 1 := by linarith
      have : 0 < (Tᶜ.card : ℝ) - 1 := by linarith
      apply div_pos (by linarith) (by positivity)
    linarith
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  change ((foxProd2 ((Pcubic2 M)⁻¹ • M) v X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) = _
  have h2 : ∀ Z, IsSkew Z → IsSkew (extend v Z) := fun Z _ => (v ⟨skewProj Z, skewProj_mem Z⟩).2
  have hcong := foxProd_congr_on_skew (X := extend M) (Y := extend v) (X' := diagOp w) (Y' := splitVec i j k l)
    (fun Z _ => extend_restrict_isSkew hW Z) h2 (fun Z hZ => extend_restrict_on_skew hW Z hZ)
    (fun Z hZ => extend_restrictLin_on_skew (splitVec_lin i j k l) (fun X _ => splitVec_skew i j k l X) Z hZ)
    X X.2
  rw [foxProd2_smul_left, _root_.smul_apply, Submodule.coe_smul, ← foxProd_extend, hcong]
  have he := (split_eigen T t hi hj hk hl hij hkl X.2).1
  simp only at he
  rw [show foxProd (diagOp w) (splitVec i j k l) X = _ from he, hP, smul_smul, ← hval]
  rw [_root_.smul_apply, Submodule.coe_smul]
  congr 1
  rw [← hwdef]
  field_simp

end HamiltonsCubic.L126Assembly
