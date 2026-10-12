import HamiltonsCubic.Results.L126Weyl

set_option linter.style.longLine false

/-!
# L126's clause at a general diagonal `M`, on `LeLin`: the four-set block meets the `½`-eigenspace exactly when `Σ = P(M)²`

[findings/second-order.md](../../../findings/second-order.md), Lemma L126, and [r1602](../../../reviews/REVIEW_r1602.md)'s
owed general-`M` bridge. [L126General.lean](L126General.lean)'s `general_meets_iff` is stated for the bare Fox product
with `θ` free. This file carries it to `LeLin` on `CurvOp2` at `θ = P(M)`, on `Fin n`:

* **`spanVec`**, **`spanVec_lin`**, **`spanVec_skew`**: `x a + y b + z c` as a linear, bivector-preserving operator;
* **`bridge_apply`**: for a Weyl `R` and a linear, bivector-preserving `S`, the bundled product
  `foxProd2 (restrict R) (restrictLin S)` is the bare `foxProd R S` on every bivector;
* **`general_LeLin_iff`**: at a diagonal Weyl weight with `P(M) > 0` and four distinct indices, some Bianchi vector
  `v` of the four-set span with a nonzero coefficient triple has `LeLin M v = ½ v` exactly when `Σ = P(M)²`, and
  **`spanVec_ne_zero`** makes such a `v` nonzero on `CurvOp2`;
* **`spanVec_isWeyl`**, **`general_DF`**: every Bianchi vector of the span is Weyl, self-adjoint and orthogonal to `M`,
  so at a critical `M` the derivative of the criticality map along `M + s v` is `2M∘v − P(M)v`.
-/

namespace HamiltonsCubic.L126Assembly

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block HamiltonsCubic.TensorBridge
  HamiltonsCubic.FourSet

variable {n : ℕ}

/-- `x a + y b + z c` as a bare operator. -/
noncomputable def spanVec (i j k l : Fin n) (x y z : ℝ) : CurvOp (Fin n) := fun Y =>
  x • rk2 (phi i j) (phi k l) Y + y • rk2 (phi k i) (phi j l) Y + z • rk2 (phi i l) (phi j k) Y

theorem spanVec_lin (i j k l : Fin n) (x y z : ℝ) : IsLinOp (spanVec i j k l x y z) := by
  refine ⟨fun X Y => ?_, fun c X => ?_⟩
  · simp only [spanVec, (isLinOp_rk2 _ _).1, smul_add]; abel
  · simp only [spanVec, (isLinOp_rk2 _ _).2, smul_add, smul_comm c]

theorem spanVec_skew (i j k l : Fin n) (x y z : ℝ) (X : Matrix (Fin n) (Fin n) ℝ) :
    IsSkew (spanVec i j k l x y z X) := by
  have h1 := rk2_skew (phi_isSkew i j) (phi_isSkew k l) X
  have h2 := rk2_skew (phi_isSkew k i) (phi_isSkew j l) X
  have h3 := rk2_skew (phi_isSkew i l) (phi_isSkew j k) X
  unfold IsSkew at *; unfold spanVec
  rw [Matrix.transpose_add, Matrix.transpose_add, Matrix.transpose_smul, Matrix.transpose_smul, Matrix.transpose_smul,
    h1, h2, h3]
  simp only [smul_neg]; abel

/-- **The bundled product is the bare one on bivectors.** -/
theorem bridge_apply {R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} (hW : IsWeyl R)
    {S : CurvOp (Fin n)} (hl : IsLinOp S) (hs : ∀ X, IsSkew X → IsSkew (S X)) (X : skewSub (Fin n)) :
    ((foxProd2 (restrict hW) (restrictLin hl hs) X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)
      = foxProd R S X := by
  rw [← foxProd_extend]
  exact foxProd_congr_on_skew (fun Z _ => extend_restrict_isSkew hW Z)
    (fun Z _ => ((restrictLin hl hs) ⟨skewProj Z, skewProj_mem Z⟩).2)
    (fun Z hZ => extend_restrict_on_skew hW Z hZ) (fun Z hZ => extend_restrictLin_on_skew hl hs Z hZ) X X.2

/-- **L126 AT A GENERAL DIAGONAL `M`, ON `LeLin`**: at a Weyl weight `w` with `P(M) > 0`, `M = restrict (diagOp w)`,
and four distinct indices, some nonzero Bianchi vector `v = x a + y b + z c` of the four-set span has
`LeLin M v = ½ v` exactly when `Σ = P(M)²`. -/
theorem general_LeLin_iff {w : Matrix (Fin n) (Fin n) ℝ} (hwt : IsWeight w) {i j k l : Fin n} (hij : i ≠ j)
    (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l) (hP : 0 < Pcubic (diagOp w)) :
    (∃ x y z : ℝ, x + y + z = 0 ∧ (x, y, z) ≠ (0 : ℝ × ℝ × ℝ) ∧
        LeLin (restrict (diagOp_isWeyl hwt))
            (restrictLin (spanVec_lin i j k l x y z) (fun X _ => spanVec_skew i j k l x y z X))
          = (1 / 2 : ℝ) • restrictLin (spanVec_lin i j k l x y z) (fun X _ => spanVec_skew i j k l x y z X))
      ↔ D (w i j + w k l) (w i k + w j l) (w i l + w j k) = Pcubic (diagOp w) ^ 2 := by
  have hW := diagOp_isWeyl hwt
  have hw : ∀ p q, w p q = w q p := fun p q => hwt.symm p q
  have hPM : Pcubic2 (restrict hW) = Pcubic (diagOp w) := Pcubic2_restrict (isLinOp_diagOp w) hW
  rw [← general_meets_iff w hw hij hik hil hjk hjl hkl _ hP]
  refine exists_congr fun x => exists_congr fun y => exists_congr fun z => and_congr_right fun _ =>
    and_congr_right fun _ => ?_
  set v := restrictLin (spanVec_lin i j k l x y z) (fun X _ => spanVec_skew i j k l x y z X)
  have key : ∀ X : skewSub (Fin n), ((LeLin (restrict hW) v X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)
      = (Pcubic (diagOp w))⁻¹ • foxProd (diagOp w) (spanVec i j k l x y z) X := by
    intro X
    change ((foxProd2 ((Pcubic2 (restrict hW))⁻¹ • restrict hW) v X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) = _
    rw [foxProd2_smul_left, _root_.smul_apply, Submodule.coe_smul, bridge_apply hW, hPM]
  constructor
  · intro h X hX
    have e := congrArg (fun F : CurvOp2 (Fin n) => ((F ⟨X, hX⟩ : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)) h
    rw [key, _root_.smul_apply, Submodule.coe_smul] at e
    change (Pcubic (diagOp w))⁻¹ • foxProd (diagOp w) (spanVec i j k l x y z) X
      = (1 / 2 : ℝ) • spanVec i j k l x y z X at e
    have e2 := congrArg (fun A => Pcubic (diagOp w) • A) e
    simp only [smul_smul, mul_inv_cancel₀ hP.ne', one_smul] at e2
    change foxProd (diagOp w) (spanVec i j k l x y z) X = _
    rw [e2]; unfold spanVec; module
  · intro h
    refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
    rw [key, _root_.smul_apply, Submodule.coe_smul]
    change _ = (1 / 2 : ℝ) • spanVec i j k l x y z X
    have e := h X X.2
    change foxProd (diagOp w) (spanVec i j k l x y z) X = _ at e
    rw [e, smul_smul]
    unfold spanVec
    field_simp

/-- **Every Bianchi vector of the four-set span is Weyl.** -/
theorem spanVec_isWeyl {i j k l : Fin n} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l)
    (hkl : k ≠ l) {x y z : ℝ} (hs : x + y + z = 0) : IsWeyl (spanVec i j k l x y z) := by
  refine ⟨fun X _ => spanVec_skew i j k l x y z X, fun X Y _ _ => ?_, fun p q r s => ?_, fun a b => ?_⟩
  · unfold spanVec; simp only [ip_add_l, ip_add_r, ip_smul_l, ip_smul_r, rk2_symm]
  · exact (fourSet_bianchi_iff hij hik hil hjk hjl hkl x y z).mpr hs p q r s
  · unfold Ric spanVec
    simp only [ip_add_l, ip_smul_l, Finset.sum_add_distrib, ← Finset.mul_sum]
    have r1 := ric_rk2_disjoint hik hil hjk hjl a b
    have r2 := ric_rk2_disjoint (p := k) (q := i) (r := j) (s := l) hjk.symm hkl hij hil a b
    have r3 := ric_rk2_disjoint (p := i) (q := l) (r := j) (s := k) hij hik hjl.symm hkl.symm a b
    unfold Ric at r1 r2 r3
    rw [r1, r2, r3]; ring

/-- **`DF(M)` AT EVERY BIANCHI VECTOR OF A FOUR-SET BLOCK, AT A GENERAL CRITICAL DIAGONAL `M`**: at a Weyl weight `w`
with `M = restrict (diagOp w)` critical on `CurvOp2`, every Bianchi vector `v` of a four-set span is Weyl, self-adjoint
and orthogonal to `M`, so the derivative of the criticality map along `M + s v` is `2M∘v − P(M)v`. -/
theorem general_DF {w : Matrix (Fin n) (Fin n) ℝ} (hwt : IsWeight w) {th : ℝ}
    (hcrit : Qop2 (restrict (diagOp_isWeyl hwt)) = th • restrict (diagOp_isWeyl hwt)) {i j k l : Fin n}
    (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l) {x y z : ℝ}
    (hs : x + y + z = 0) :
    let M := restrict (diagOp_isWeyl hwt)
    let v := restrictLin (spanVec_lin i j k l x y z) (fun X _ => spanVec_skew i j k l x y z X)
    IsWeyl2 v ∧ innerOp2 M v = 0 ∧ ∀ Z : CurvOp2 (Fin n), HasDerivAt (fun s : ℝ => innerOp2 Z (critMap (M + s • v)))
      (innerOp2 Z ((2 : ℝ) • foxProd2 M v - Pcubic2 M • v)) 0 := by
  intro M v
  have hW := diagOp_isWeyl hwt
  have hw : ∀ p q, w p q = w q p := fun p q => hwt.symm p q
  have hWv : IsWeyl2 v := by
    have h := isWeyl2_restrict (spanVec_isWeyl hij hik hil hjk hjl hkl hs)
    have e : v = restrict (spanVec_isWeyl hij hik hil hjk hjl hkl hs) := ContinuousLinearMap.ext fun _ => rfl
    rw [e]; exact h
  have hperp : innerOp2 M v = 0 := by
    rw [← innerOp_extend]
    have e : innerOp (extend M) (extend v) = innerOp (diagOp w) (spanVec i j k l x y z) := by
      unfold innerOp
      refine congrArg _ (Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_)
      rw [extend_restrict_on_skew hW _ (phi_isSkew a b),
        extend_restrictLin_on_skew (spanVec_lin i j k l x y z) (fun X _ => spanVec_skew i j k l x y z X) _ (phi_isSkew a b)]
    rw [e]
    have hsplit : spanVec i j k l x y z = fun Y => x • rk2 (phi i j) (phi k l) Y + y • rk2 (phi k i) (phi j l) Y
        + z • rk2 (phi i l) (phi j k) Y := rfl
    rw [hsplit, innerOp_lin3,
      innerOp_rk2 _ (isLinOp_diagOp w) (phi_isSkew i j) (phi_isSkew k l),
      innerOp_rk2 _ (isLinOp_diagOp w) (phi_isSkew k i) (phi_isSkew j l),
      innerOp_rk2 _ (isLinOp_diagOp w) (phi_isSkew i l) (phi_isSkew j k)]
    simp only [diagOp_phi w hw, ip_smul_l, inner2_phi_phi]
    simp [hij, hik, hil, hjk, hjl, hkl, hij.symm, hik.symm, hil.symm, hjk.symm, hjl.symm, hkl.symm]
  exact ⟨hWv, hperp, fun Z => critMap_hasDerivAt (isSelfAdjoint2_restrict hW) hWv.selfAdjoint hcrit hperp Z⟩

/-- **A nonzero coefficient triple gives a nonzero operator**: `x a + y b + z c` reads off `x`, `y`, `z` at `φ_ij`,
`φ_ki`, `φ_il`, so its restriction to `CurvOp2` vanishes only at `(x,y,z) = 0`. -/
theorem spanVec_ne_zero {i j k l : Fin n} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l)
    (hkl : k ≠ l) {x y z : ℝ} (hne : (x, y, z) ≠ (0 : ℝ × ℝ × ℝ)) :
    restrictLin (spanVec_lin i j k l x y z) (fun X _ => spanVec_skew i j k l x y z X) ≠ 0 := by
  intro h
  obtain ⟨c1, c2, c3⟩ := span_coords hij hik hil hjk hjl hkl x y z
  have ev : ∀ (p q : Fin n), spanVec i j k l x y z (phi p q) = 0 := fun p q => by
    have e := congrArg (fun F : CurvOp2 (Fin n) => ((F ⟨phi p q, phi_isSkew p q⟩ : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)) h
    exact e
  have e1 := congrArg (fun A : Matrix (Fin n) (Fin n) ℝ => A l k) ((c1.symm.trans (ev i j)))
  have e2 := congrArg (fun A : Matrix (Fin n) (Fin n) ℝ => A l j) ((c2.symm.trans (ev k i)))
  have e3 := congrArg (fun A : Matrix (Fin n) (Fin n) ℝ => A k j) ((c3.symm.trans (ev i l)))
  simp only [phi_entry hkl, phi_entry hjl, phi_entry hjk, Matrix.zero_apply] at e1 e2 e3
  exact hne (by rw [e1, e2, e3]; rfl)

end HamiltonsCubic.L126Assembly
