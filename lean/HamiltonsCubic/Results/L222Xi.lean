import Mathlib
import HamiltonsCubic.Results.L222MinW

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L222 item 5's infinitesimal form: `ξ · D ∈ V_{jk}` with coordinates `K_{ja} − K_{ka}`, `ξ · ν ∈ 𝒟ₙ` with `‖ξ · ν‖² = 4‖ν‖²`

[findings/second-order.md](../../../findings/second-order.md), Lemma L222, item 5: *$\xi\cdot D\in V_{jk}$ with coordinates
$K_{ja}-K_{ka}$, and $\xi\cdot\nu\in\mathcal D_n$ with $\lVert\xi\cdot\nu\rVert^2=4\lVert\nu\rVert^2$*, `ξ` the generator of the rotations
of the `(j, k)`-plane. With `R_φ = Rot_{jk}(cos φ, sin φ)`, `ξ · W` is the derivative of `φ ↦ R_φ · W` at `0`:

* **`rot_phi`**: `R_φ · (coordOp w + ν_x) = coordOp e + cos 2φ · D⁻_y + sin 2φ · ν_y + cos 2φ · ν_x − sin 2φ · D⁻_x`, `e` the swap-even
  part of `w` and `y_a = (w_{ja} − w_{ka})/2`, from [L224Rot.lean](L224Rot.lean)'s finite action;
* **`xi_W`**: the derivative at `0` is `2 ν_y − 2 D⁻_x`, stated weakly (for every `V`, `φ ↦ ⟨R_φ · W, V⟩` has derivative
  `⟨2 ν_y − 2 D⁻_x, V⟩`), which determines it since the pairing is nondegenerate;
* **`xi_D`**: `ξ · coordOp w = ν_{K_{j·} − K_{k·}}`, an element of `V_{jk}` with coordinates `w_{ja} − w_{ka}`;
* **`xi_nu`**: `ξ · ν_x = −2 D⁻_x`, of character `1`, with `‖ξ · ν_x‖² = 4 ‖ν_x‖²`;
* **`xi_weyl`**: both derivatives are Weyl, so `ξ · D ∈ V_{jk}` and `ξ · ν ∈ 𝒟ₙ` as subspaces of `𝒲ₙ` (r1880 O2).
-/

namespace HamiltonsCubic.L222Xi

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.I117S
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FrameOp2 HamiltonsCubic.L224Rot
  HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.L222Op HamiltonsCubic.FamilyLayer

variable {n : ℕ} {j k : Fin n}

/-- **The rotation by `φ`, in the double angle.** -/
theorem rot_phi (hjk : j ≠ k) {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) (x : Fin n → ℝ) (φ : ℝ) :
    rotR (Rot j k (Real.cos φ) (Real.sin φ)) (coordOp w + nuX j k x)
      = coordOp (w - Dminus j k (fun a => (w j a - w k a) / 2))
        + Real.cos (2 * φ) • coordOp (Dminus j k (fun a => (w j a - w k a) / 2))
        + Real.sin (2 * φ) • nuX j k (fun a => (w j a - w k a) / 2)
        + Real.cos (2 * φ) • nuX j k x + (-Real.sin (2 * φ)) • coordOp (Dminus j k x) := by
  set y : Fin n → ℝ := fun a => (w j a - w k a) / 2 with hydef
  have hcs : Real.cos φ ^ 2 + Real.sin φ ^ 2 = 1 := Real.cos_sq_add_sin_sq φ
  have hys := HamiltonsCubic.L222MinW.odd_sum_zero hjk hw
  have hDy := HamiltonsCubic.OddPart.Dminus_weight hjk y hys
  set ev : Matrix (Fin n) (Fin n) ℝ := w - Dminus j k y with hev
  have hevT : evᵀ = ev := by
    ext p q
    simp only [hev, Matrix.transpose_apply, Matrix.sub_apply, hw.symm q p, hDy.symm q p]
  have hevs : ∀ a, a ≠ j → a ≠ k → ev j a = ev k a := by
    intro a haj hak
    simp only [hev, Matrix.sub_apply, Dminus, Matrix.add_apply, Matrix.vecMulVec_apply, uj, vy, hydef,
      if_pos rfl, if_neg haj, if_neg hak, Ne.symm hjk, if_neg (Ne.symm hjk), if_pos rfl]
    simp [haj, hak, hjk, Ne.symm hjk]
    ring
  have hsplit : coordOp w = coordOp ev + coordOp (Dminus j k y) := by
    rw [← coordOp_add, hev, sub_add_cancel]
  have hc2 : Real.cos φ ^ 2 - Real.sin φ ^ 2 = Real.cos (2 * φ) := by
    rw [Real.cos_two_mul]; nlinarith [hcs]
  have hs2 : 2 * Real.cos φ * Real.sin φ = Real.sin (2 * φ) := by
    rw [Real.sin_two_mul]; ring
  rw [map_add, hsplit, map_add, rot_even hjk hcs ev hevT hevs, rot_Dminus hjk hcs y, rot_nuX hjk hcs x, hc2, hs2]
  module

/-- The two zero identities, `ν_0 = 0` and `D⁻_0 = 0`. -/
theorem nuX_zero : nuX j k (0 : Fin n → ℝ) = 0 := by
  have h := HamiltonsCubic.L224EqRot.nuX_smul (j := j) (k := k) 0 (0 : Fin n → ℝ)
  simp only [smul_zero] at h
  rw [h]; module

theorem Dminus_zero : coordOp (Dminus j k (0 : Fin n → ℝ)) = 0 := by
  have h := HamiltonsCubic.L224EqRot.Dminus_smul (j := j) (k := k) 0 (0 : Fin n → ℝ)
  simp only [smul_zero] at h
  rw [h]; module

theorem coordOp_zero' : coordOp (0 : Matrix (Fin n) (Fin n) ℝ) = 0 := by
  have h := coordOp_smul' (0 : ℝ) (0 : Matrix (Fin n) (Fin n) ℝ)
  simp only [smul_zero] at h
  rw [h]; module

/-- **`ξ · W`**, weakly: for every `V`, `φ ↦ ⟨R_φ · W, V⟩` has derivative `⟨2 ν_y − 2 D⁻_x, V⟩` at `0`. The pairing is
nondegenerate, so this determines `ξ · W = 2 ν_y − 2 D⁻_x`. -/
theorem xi_W (hjk : j ≠ k) {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) (x : Fin n → ℝ) (V : CurvOp2 (Fin n)) :
    HasDerivAt (fun φ => innerOp2 (rotR (Rot j k (Real.cos φ) (Real.sin φ)) (coordOp w + nuX j k x)) V)
      (innerOp2 ((2 : ℝ) • nuX j k (fun a => (w j a - w k a) / 2) + (-2 : ℝ) • coordOp (Dminus j k x)) V) 0 := by
  set A := coordOp (w - Dminus j k (fun a => (w j a - w k a) / 2))
  set B := coordOp (Dminus j k (fun a => (w j a - w k a) / 2))
  set C := nuX j k (fun a => (w j a - w k a) / 2)
  set E := coordOp (Dminus j k x)
  have e : (fun φ => innerOp2 (rotR (Rot j k (Real.cos φ) (Real.sin φ)) (coordOp w + nuX j k x)) V)
      = fun φ => innerOp2 A V + Real.cos (2 * φ) * innerOp2 B V + Real.sin (2 * φ) * innerOp2 C V
        + Real.cos (2 * φ) * innerOp2 (nuX j k x) V + (-Real.sin (2 * φ)) * innerOp2 E V := by
    funext φ
    rw [rot_phi hjk hw x φ]
    simp only [innerOp2_add_left, innerOp2_smul_left]
    rfl
  rw [e]
  have h2 : HasDerivAt (fun φ : ℝ => 2 * φ) 2 0 := by simpa using (hasDerivAt_id (0 : ℝ)).const_mul 2
  have hc : HasDerivAt (fun φ : ℝ => Real.cos (2 * φ)) (-Real.sin (2 * 0) * 2) 0 := h2.cos
  have hs : HasDerivAt (fun φ : ℝ => Real.sin (2 * φ)) (Real.cos (2 * 0) * 2) 0 := h2.sin
  have hsum := ((((hasDerivAt_const (0 : ℝ) (innerOp2 A V)).add (hc.mul_const (innerOp2 B V))).add
    (hs.mul_const (innerOp2 C V))).add (hc.mul_const (innerOp2 (nuX j k x) V))).add (hs.neg.mul_const (innerOp2 E V))
  have hv : innerOp2 ((2 : ℝ) • C + (-2 : ℝ) • E) V = 2 * innerOp2 C V + (-2) * innerOp2 E V := by
    rw [innerOp2_add_left, innerOp2_smul_left, innerOp2_smul_left]
  refine hsum.congr_deriv ?_
  rw [hv, mul_zero, Real.sin_zero, Real.cos_zero]
  ring

/-- **`ξ · D ∈ V_{jk}` with coordinates `K_{ja} − K_{ka}`**, weakly. Every Weyl `D` of character `1` is a `coordOp w` at a weight `w`
(`L120Ident.trivial_block_iff`), so this covers all of `𝒟ₙ` (r1880 O3). -/
theorem xi_D (hjk : j ≠ k) {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) (V : CurvOp2 (Fin n)) :
    HasDerivAt (fun φ => innerOp2 (rotR (Rot j k (Real.cos φ) (Real.sin φ)) (coordOp w)) V) (innerOp2 (nuX j k (fun a => w j a - w k a)) V) 0 ∧
      SignChar (setChar {j, k}) (nuX j k (fun a => w j a - w k a)) := by
  have hfun : (fun φ => innerOp2 (rotR (Rot j k (Real.cos φ) (Real.sin φ)) (coordOp w)) V)
      = fun φ => innerOp2 (rotR (Rot j k (Real.cos φ) (Real.sin φ)) (coordOp w + nuX j k 0)) V := by
    funext φ; rw [nuX_zero, add_zero (coordOp w : CurvOp2 (Fin n))]
  have hval : innerOp2 ((2 : ℝ) • nuX j k (fun a => (w j a - w k a) / 2) + (-2 : ℝ) • coordOp (Dminus j k 0)) V
      = innerOp2 (nuX j k (fun a => w j a - w k a)) V := by
    have e2 : (fun a => w j a - w k a) = (2 : ℝ) • (fun a => (w j a - w k a) / 2) := by
      funext a; simp only [Pi.smul_apply, smul_eq_mul]; ring
    rw [Dminus_zero, e2, HamiltonsCubic.L224EqRot.nuX_smul, innerOp2_add_left, innerOp2_smul_left, innerOp2_smul_left]
    have hz : innerOp2 (0 : CurvOp2 (Fin n)) V = 0 := by
      have := innerOp2_smul_left (0 : ℝ) V V
      rw [zero_mul] at this
      rw [← this]; congr 1; module
    rw [hz]; ring
  refine ⟨?_, ?_⟩
  · rw [hfun, ← hval]; exact xi_W hjk hw 0 V
  · have hys := HamiltonsCubic.L222MinW.odd_sum_zero hjk hw
    set z : Fin n → ℝ := fun a => w j a - w k a
    have ez : vy j k z = (2 : ℝ) • vy j k (fun a => (w j a - w k a) / 2) := by
      funext i; simp only [z, vy, Pi.smul_apply, smul_eq_mul]; split_ifs <;> ring
    have hzs : ∑ c, vy j k z c = 0 := by
      rw [ez]; simp only [Pi.smul_apply, smul_eq_mul, ← Finset.mul_sum, hys, mul_zero]
    have hvj : vy j k z j = 0 := by simp [vy]
    have hvk : vy j k z k = 0 := by simp [vy]
    have e : nuX j k z = nuX j k (vy j k z) := by unfold nuX; simp only [HamiltonsCubic.L222Min.vy_vy]
    rw [e]
    have hzs' : ∑ i, vy j k z i = 0 := hzs
    exact HamiltonsCubic.PairConv.nuX_char hjk (vy j k z) hvj hvk hzs'

/-- **`ξ · ν ∈ 𝒟ₙ` with `‖ξ · ν‖² = 4‖ν‖²`**, weakly. -/
theorem xi_nu (hjk : j ≠ k) {x : Fin n → ℝ} (hxv : ∑ c, vy j k x c = 0) (V : CurvOp2 (Fin n)) :
    HasDerivAt (fun φ => innerOp2 (rotR (Rot j k (Real.cos φ) (Real.sin φ)) (nuX j k x)) V) (innerOp2 ((-2 : ℝ) • coordOp (Dminus j k x)) V) 0 ∧
      SignChar (fun _ => 1) ((-2 : ℝ) • coordOp (Dminus j k x)) ∧
      normSq2 ((-2 : ℝ) • coordOp (Dminus j k x)) = 4 * normSq2 (nuX j k x) := by
  have hw0 : IsWeight (0 : Matrix (Fin n) (Fin n) ℝ) := ⟨fun _ _ => rfl, fun _ => rfl, fun _ => by simp⟩
  have hy0 : (fun a => ((0 : Matrix (Fin n) (Fin n) ℝ) j a - (0 : Matrix (Fin n) (Fin n) ℝ) k a) / 2) = 0 := by
    funext a; simp
  have hfun : (fun φ => innerOp2 (rotR (Rot j k (Real.cos φ) (Real.sin φ)) (nuX j k x)) V)
      = fun φ => innerOp2 (rotR (Rot j k (Real.cos φ) (Real.sin φ)) (coordOp (0 : Matrix (Fin n) (Fin n) ℝ) + nuX j k x)) V := by
    funext φ; rw [coordOp_zero', zero_add (nuX j k x : CurvOp2 (Fin n))]
  have hDx := HamiltonsCubic.OddPart.Dminus_weight hjk x hxv
  refine ⟨?_, ?_, ?_⟩
  · rw [hfun]
    have h := xi_W hjk hw0 x V
    have hval : innerOp2 ((2 : ℝ) • nuX j k (fun a => ((0 : Matrix (Fin n) (Fin n) ℝ) j a - (0 : Matrix (Fin n) (Fin n) ℝ) k a) / 2)
        + (-2 : ℝ) • coordOp (Dminus j k x)) V = innerOp2 ((-2 : ℝ) • coordOp (Dminus j k x)) V := by
      rw [hy0, nuX_zero, innerOp2_add_left, innerOp2_smul_left]
      have hz : innerOp2 (0 : CurvOp2 (Fin n)) V = 0 := by
        have := innerOp2_smul_left (0 : ℝ) V V
        rw [zero_mul] at this
        rw [← this]; congr 1; module
      rw [hz]; ring
    rw [hval] at h
    exact h
  · apply signChar_smul
    rw [coordOp_eq_restrict hDx]
    exact (HamiltonsCubic.L120Ident.trivial_block_iff _ (isWeyl2_restrict _)).mpr ⟨_, hDx, rfl⟩
  · have hs : normSq2 ((-2 : ℝ) • coordOp (Dminus j k x)) = 4 * normSq2 (coordOp (Dminus j k x)) := by
      unfold normSq2; rw [innerOp2_smul_left, innerOp2_smul_right]; ring
    rw [hs, HamiltonsCubic.PairNorm.normSq2_Dminus hjk, HamiltonsCubic.PairNorm.normSq2_nuX hjk x hxv]

/-- **Both derivatives are Weyl** (r1880 O2): `ν_{K_{j·} − K_{k·}}` at a weight, and `−2 D⁻_x` at `∑ vy x = 0`. -/
theorem xi_weyl (hjk : j ≠ k) {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) {x : Fin n → ℝ} (hxv : ∑ c, vy j k x c = 0) :
    IsWeyl2 (nuX j k (fun a => w j a - w k a)) ∧ IsWeyl2 ((-2 : ℝ) • coordOp (Dminus j k x)) := by
  refine ⟨HamiltonsCubic.PairConv.nuX_weyl hjk _ ?_, isWeyl2_smul _ (Dminus_weyl hjk x hxv)⟩
  rw [HamiltonsCubic.L222Rot.sum_vy hjk, Finset.sum_sub_distrib, hw.rowSum j, hw.rowSum k]
  simp only [hw.hollow j, hw.hollow k, hw.symm k j]
  ring

end HamiltonsCubic.L222Xi
