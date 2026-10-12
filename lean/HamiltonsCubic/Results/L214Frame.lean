import Mathlib
import HamiltonsCubic.Results.L214Diag
import HamiltonsCubic.Results.L219FrameDiag
import HamiltonsCubic.Results.L24Eigen
import HamiltonsCubic.Results.L24Weyl
import HamiltonsCubic.Results.TraceOp

set_option linter.style.longLine false

/-!
# L214 in every orthonormal frame

[findings/second-order.md](../../../findings/second-order.md), Lemma L214: *fix any orthonormal frame $F$ of $\mathbb R^n$ and
split a unit critical point as $W=D+N$, where $D=\pi_FW$ is its coordinate-diagonal part in $F$ and $N=W-D$, with
$t=\lVert D\rVert^2$ and $a=\langle L_DN,N\rangle$. Then $\theta t=P(D)+a$, $\theta(1-t)=2a+P(N)$, and at a maximiser
$a\ge\tfrac\theta2t(1-t)$.* [L214Diag.lean](L214Diag.lean) proves it in the coordinate frame. A frame is the columns of an
orthogonal $U$, and the frame change `rotR` of [FrameOp2.lean](FrameOp2.lean) carries every clause across:

* `piF`: $\pi_FW=U\,\pi(U^{\mathsf T}WU)\,U^{\mathsf T}$, with $\pi$ the sign-fixed component `comp ∅` of [L120Decomp.lean](L120Decomp.lean);
* `piF_diag`, `piF_perp`: $\pi_FW$ is diagonal in the frame (the form of [L219FrameDiag.lean](L219FrameDiag.lean)), and
  $W-\pi_FW$ is orthogonal to every operator diagonal in the frame, so $\pi_F$ is the orthogonal projection onto them;
* **`L214_frame`**: at a unit Weyl $W$ with $Q(W)=\theta W$, $\langle D,N\rangle=0$, $T(D,D,N)=0$, $\theta t=P(D)+T(D,N,N)$ and
  $\theta(1-t)=2T(D,N,N)+P(N)$, with $a=T(D,N,N)=\langle D\circ N,N\rangle$;
* **`L214_frame_max`**: at a local maximiser on the unit Weyl sphere with $\theta>0$, $T(D,N,N)\ge\tfrac\theta2t(1-t)$;
* `Tsym_eq_fox`, `piF_unique`, `piF_t_range`: $a=T(D,N,N)=\langle D\circ N,N\rangle$, $\pi_FW$ is the unique operator diagonal in the frame
  with $W-\pi_FW$ orthogonal to them, and $t\in[0,1]$;
* **`L214_frame_cap`**: the inequality under the record's own hypothesis $\langle L_WX,X\rangle\le\tfrac\theta2\lVert X\rVert^2$ on Weyl
  $X\perp W$, with its equivalent form $P(D)\le\tfrac\theta2t(1+t)$ (`L214_ineq_iff`, the equivalence from the first relation);
* **`L214_frame_global`**: the same at every global maximiser, $n\ge4$, with $\theta=P(W)$ and no sign hypothesis.
-/

namespace HamiltonsCubic.L214Frame

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess HamiltonsCubic.FrameLayer
  HamiltonsCubic.L120Blocks HamiltonsCubic.L120Decomp HamiltonsCubic.L120Ident HamiltonsCubic.L214Op HamiltonsCubic.L214Diag
  HamiltonsCubic.FrameOp2 HamiltonsCubic.L219GenOps HamiltonsCubic.FamilyLayer

variable {n : ℕ}

/-- **The coordinate-diagonal part in the frame of `U`**, `π_F W = U π(Uᵀ W U) Uᵀ`. -/
noncomputable def piF {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) (W : CurvOp2 (Fin n)) (hW : IsWeyl2 W) :
    CurvOp2 (Fin n) :=
  rotR U (comp ∅ (rotR Uᵀ W) (rotR_isWeyl2 (FrameLayer.isOrth_transpose hU) hW))

theorem isWeyl2_sub' {A B : CurvOp2 (Fin n)} (hA : IsWeyl2 A) (hB : IsWeyl2 B) : IsWeyl2 (A - B) := by
  have e : A - B = A + (-1 : ℝ) • B := by module
  rw [e]
  exact isWeyl2_add hA (isWeyl2_smul _ hB)

/-- `W − π_F W` is the frame change of the coordinate `N`. -/
theorem sub_piF {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) (W : CurvOp2 (Fin n)) (hW : IsWeyl2 W) :
    W - piF hU W hW = rotR U (rotR Uᵀ W - comp ∅ (rotR Uᵀ W) (rotR_isWeyl2 (FrameLayer.isOrth_transpose hU) hW)) := by
  have e := map_sub (rotR U) (rotR Uᵀ W) (comp ∅ (rotR Uᵀ W) (rotR_isWeyl2 (FrameLayer.isOrth_transpose hU) hW))
  rw [e, rotR_inv hU W]
  rfl

theorem isWeyl2_piF {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) (W : CurvOp2 (Fin n)) (hW : IsWeyl2 W) :
    IsWeyl2 (piF hU W hW) :=
  rotR_isWeyl2 hU (comp_isWeyl2 _ _ _)

/-- **`π_F W` is diagonal in the frame.** -/
theorem piF_diag {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) (W : CurvOp2 (Fin n)) (hW : IsWeyl2 W) :
    ∃ (w : Matrix (Fin n) (Fin n) ℝ) (hw : IsWeight w), piF hU W hW = rotR U (RealLayer.restrict (diagOp_isWeyl hw)) := by
  have hW' := rotR_isWeyl2 (FrameLayer.isOrth_transpose hU) hW
  obtain ⟨w, hw, h⟩ := (trivial_block_iff _ (comp_isWeyl2 ∅ _ hW')).1 (comp_empty_fix _ hW')
  exact ⟨w, hw, by rw [piF, h]⟩

/-- **`W − π_F W` is orthogonal to every operator diagonal in the frame**, so `π_F` is the orthogonal projection. -/
theorem piF_perp {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) (W : CurvOp2 (Fin n)) (hW : IsWeyl2 W)
    (w : Matrix (Fin n) (Fin n) ℝ) (hw : IsWeight w) :
    innerOp2 (rotR U (RealLayer.restrict (diagOp_isWeyl hw))) (W - piF hU W hW) = 0 := by
  have hUt := FrameLayer.isOrth_transpose hU
  have hW' := rotR_isWeyl2 hUt hW
  have hY : IsWeyl2 (RealLayer.restrict (diagOp_isWeyl hw)) := isWeyl2_restrict _
  have hfix := (trivial_block_iff _ hY).2 ⟨w, hw, rfl⟩
  rw [sub_piF hU W hW, innerOp2_rotR hU hY (isWeyl2_sub' hW' (comp_isWeyl2 _ _ _))]
  have hs := sum_comp _ hW'
  rw [← Finset.add_sum_erase _ _ (Finset.mem_univ ∅)] at hs
  have hN : rotR Uᵀ W - comp ∅ (rotR Uᵀ W) hW' = ∑ t ∈ univ.erase ∅, comp t (rotR Uᵀ W) hW' := by
    calc rotR Uᵀ W - comp ∅ (rotR Uᵀ W) hW'
        = (comp ∅ (rotR Uᵀ W) hW' + ∑ t ∈ univ.erase ∅, comp t (rotR Uᵀ W) hW') - comp ∅ (rotR Uᵀ W) hW' := by
          rw [hs]
      _ = ∑ t ∈ univ.erase ∅, comp t (rotR Uᵀ W) hW' := by abel
  rw [hN, innerOp2_sum']
  exact Finset.sum_eq_zero fun t ht => comp_perp_ne hfix (Finset.ne_of_mem_erase ht) _ hW'

/-- **L214's two relations in every orthonormal frame.** -/
theorem L214_frame {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) (W : CurvOp2 (Fin n)) (hW : IsWeyl2 W)
    (hW1 : normSq2 W = 1) {θ : ℝ} (hQ : Qop2 W = θ • W) :
    innerOp2 (piF hU W hW) (W - piF hU W hW) = 0 ∧
      Tsym (piF hU W hW) (piF hU W hW) (W - piF hU W hW) = 0 ∧
      θ * normSq2 (piF hU W hW) = Pcubic2 (piF hU W hW) + Tsym (piF hU W hW) (W - piF hU W hW) (W - piF hU W hW) ∧
      θ * (1 - normSq2 (piF hU W hW))
        = 2 * Tsym (piF hU W hW) (W - piF hU W hW) (W - piF hU W hW) + Pcubic2 (W - piF hU W hW) := by
  have hUt := FrameLayer.isOrth_transpose hU
  have hW' := rotR_isWeyl2 hUt hW
  have hW'1 : normSq2 (rotR Uᵀ W) = 1 := by rw [normSq2_rotR hUt hW, hW1]
  have hQ' : Qop2 (rotR Uᵀ W) = θ • rotR Uᵀ W := by rw [Qop2_rotR hUt hW, hQ, map_smul]
  obtain ⟨h1, h2, h3, h4⟩ := L214_diag (rotR Uᵀ W) hW' hW'1 hQ'
  have hD := comp_isWeyl2 ∅ _ hW'
  have hN := isWeyl2_sub' hW' hD
  rw [sub_piF hU W hW]
  unfold piF
  rw [innerOp2_rotR hU hD hN, Tsym_rotR hU hD hD hN, normSq2_rotR hU hD, Pcubic2_rotR hU hD, Tsym_rotR hU hD hN hN,
    Pcubic2_rotR hU hN]
  exact ⟨h1, h2, h3, h4⟩

/-- **L214's inequality in every orthonormal frame**, at a local maximiser on the unit Weyl sphere with `θ > 0`. -/
theorem L214_frame_max {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) (W : CurvOp2 (Fin n)) (hW : IsWeyl2 W)
    (hW1 : normSq2 W = 1) {θ : ℝ} (hQ : Qop2 W = θ • W)
    (hmax : IsLocalMaxOn Pcubic2 {R : CurvOp2 (Fin n) | normSq2 R = 1 ∧ IsWeyl2 R} W) (hθ : 0 < θ) :
    θ / 2 * (normSq2 (piF hU W hW) * (1 - normSq2 (piF hU W hW)))
      ≤ Tsym (piF hU W hW) (W - piF hU W hW) (W - piF hU W hW) := by
  have hUt := FrameLayer.isOrth_transpose hU
  have hW' := rotR_isWeyl2 hUt hW
  have hW'1 : normSq2 (rotR Uᵀ W) = 1 := by rw [normSq2_rotR hUt hW, hW1]
  have hQ' : Qop2 (rotR Uᵀ W) = θ • rotR Uᵀ W := by rw [Qop2_rotR hUt hW, hQ, map_smul]
  set S := {R : CurvOp2 (Fin n) | normSq2 R = 1 ∧ IsWeyl2 R} with hS
  have hm : IsLocalMaxOn Pcubic2 S (rotR U (rotR Uᵀ W)) := by rw [rotR_inv hU]; exact hmax
  have hcont : Continuous (rotR U) := LinearMap.continuous_of_finiteDimensional (𝕜 := ℝ) (E := CurvOp2 (Fin n)) (F' := CurvOp2 (Fin n)) (rotR U)
  have hmaps : S ⊆ rotR U ⁻¹' S := fun R hR => ⟨by rw [normSq2_rotR hU hR.2, hR.1], rotR_isWeyl2 hU hR.2⟩
  have hc := hm.comp_continuousOn hmaps hcont.continuousOn ⟨hW'1, hW'⟩
  have hmax' : IsLocalMaxOn Pcubic2 S (rotR Uᵀ W) := by
    unfold IsLocalMaxOn IsMaxFilter at hc ⊢
    filter_upwards [hc, self_mem_nhdsWithin] with R hR hRS
    simp only [Function.comp] at hR
    rwa [Pcubic2_rotR hU hRS.2, Pcubic2_rotR hU hW'] at hR
  have h := L214_diag_max (rotR Uᵀ W) hW' hW'1 hQ' hmax' hθ
  have hD := comp_isWeyl2 ∅ _ hW'
  have hN := isWeyl2_sub' hW' hD
  rw [sub_piF hU W hW]
  unfold piF
  rw [normSq2_rotR hU hD, Tsym_rotR hU hD hN hN]
  exact h

/-- **L214's inequality at every global maximiser, in every orthonormal frame**, `n ≥ 4`: the eigen-equation with
`θ = P(W)` by Fermat (`Qop2_eq_smul_weyl`) and `θ ≥ √(3/2) > 0` by the maximiser's competitor (`exists_weyl_maximiser`). -/
theorem L214_frame_global (hn : 4 ≤ n) {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) (W : CurvOp2 (Fin n))
    (hW : W ∈ weylSphereSet (Fin n)) (hmax : IsMaxOn Pcubic2 (weylSphereSet (Fin n)) W) :
    Pcubic2 W / 2 * (normSq2 (piF hU W hW.2) * (1 - normSq2 (piF hU W hW.2)))
      ≤ Tsym (piF hU W hW.2) (W - piF hU W hW.2) (W - piF hU W hW.2) := by
  have hQ := Qop2_eq_smul_weyl hW.1 hW.2 hmax.localize
  obtain ⟨a, ha, -, hpa⟩ := exists_weyl_maximiser hn
  have hθ : 0 < Pcubic2 W := by
    have h1 : Pcubic2 a ≤ Pcubic2 W := hmax ha
    have h2 : 0 < Real.sqrt (3 / 2) := Real.sqrt_pos.mpr (by norm_num)
    linarith
  exact L214_frame_max hU W hW.2 hW.1 hQ hmax.localize hθ

/-- **`T(D,N,N) = ⟨D∘N, N⟩`** at self-adjoint `D`, `N`: the record's `a = ⟨L_D N, N⟩` is `Tsym D N N`. -/
theorem Tsym_eq_fox {D N : CurvOp2 (Fin n)} (hD : IsSelfAdjoint2 D) (hN : IsSelfAdjoint2 N) :
    Tsym D N N = innerOp2 (foxProd2 D N) N := by
  have h1 := Tsym_quad D N
  rw [Pcubic2Quad_selfAdjoint hN] at h1
  rw [innerOp2_foxProd2_self hD hN]
  linarith

/-- **`π_F W` is unique**: an operator diagonal in the frame with `W − D` orthogonal to every frame-diagonal operator
is `π_F W`. -/
theorem piF_unique {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) (W : CurvOp2 (Fin n)) (hW : IsWeyl2 W)
    (D : CurvOp2 (Fin n))
    (hDd : ∃ (w : Matrix (Fin n) (Fin n) ℝ) (hw : IsWeight w), D = rotR U (RealLayer.restrict (diagOp_isWeyl hw)))
    (hDp : ∀ (w : Matrix (Fin n) (Fin n) ℝ) (hw : IsWeight w),
      innerOp2 (rotR U (RealLayer.restrict (diagOp_isWeyl hw))) (W - D) = 0) :
    D = piF hU W hW := by
  obtain ⟨w1, hw1, e1⟩ := hDd
  obtain ⟨w2, hw2, e2⟩ := piF_diag hU W hW
  set P := piF hU W hW with hPdef
  have a1 : innerOp2 D (W - D) = 0 := by have h := hDp w1 hw1; rw [← e1] at h; exact h
  have a2 : innerOp2 P (W - D) = 0 := by have h := hDp w2 hw2; rw [← e2] at h; exact h
  have a3 : innerOp2 D (W - P) = 0 := by have h := piF_perp hU W hW w1 hw1; rw [← e1] at h; exact h
  have a4 : innerOp2 P (W - P) = 0 := by have h := piF_perp hU W hW w2 hw2; rw [← e2] at h; exact h
  have key : D - P = (W - P) - (W - D) := by abel
  have b1 : innerOp2 (D - P) (W - P) = 0 := by rw [innerOp2_sub_left, a3, a4]; ring
  have b2 : innerOp2 (D - P) (W - D) = 0 := by rw [innerOp2_sub_left, a1, a2]; ring
  have hz : normSq2 (D - P) = 0 := by
    calc normSq2 (D - P) = innerOp2 ((W - P) - (W - D)) (D - P) := by
          show innerOp2 (D - P) (D - P) = _; rw [← key]
      _ = 0 := by rw [innerOp2_sub_left, innerOp2_comm (W - P), innerOp2_comm (W - D), b1, b2]; ring
  exact sub_eq_zero.mp (normSq2_eq_zero hz)

/-- **`t = ‖π_F W‖² ∈ [0,1]`**, and `‖W − π_F W‖² = 1 − t`, at a unit Weyl `W`. -/
theorem piF_t_range {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) (W : CurvOp2 (Fin n)) (hW : IsWeyl2 W)
    (hW1 : normSq2 W = 1) :
    innerOp2 (W - piF hU W hW) (W - piF hU W hW) = 1 - normSq2 (piF hU W hW) ∧
      0 ≤ normSq2 (piF hU W hW) ∧ normSq2 (piF hU W hW) ≤ 1 := by
  set D := piF hU W hW with hDdef
  have hDN : innerOp2 D (W - D) = 0 := by
    obtain ⟨w, hw, e⟩ := piF_diag hU W hW
    have h := piF_perp hU W hW w hw
    rw [← e] at h; exact h
  have hNN : innerOp2 (W - D) (W - D) = 1 - normSq2 D := by
    have e : innerOp2 (D + (W - D)) (D + (W - D)) = normSq2 D + innerOp2 (W - D) (W - D) := by
      rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, hDN, innerOp2_comm (W - D) D, hDN]
      unfold normSq2
      ring
    rw [show D + (W - D) = W by abel] at e
    have : innerOp2 W W = 1 := hW1
    linarith
  have hN0 : 0 ≤ innerOp2 (W - D) (W - D) := normSq2_nonneg _
  exact ⟨hNN, normSq2_nonneg _, by linarith⟩

/-- **L214's inequality under the cap, in every orthonormal frame**: at a unit critical Weyl `W` with
`⟨L_W X, X⟩ ≤ (θ/2)‖X‖²` for every Weyl `X ⊥ W`, the record's hypothesis, `a ≥ (θ/2) t(1 − t)` and equivalently
`P(D) ≤ (θ/2) t(1 + t)`. -/
theorem L214_frame_cap {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) (W : CurvOp2 (Fin n)) (hW : IsWeyl2 W)
    (hW1 : normSq2 W = 1) {θ : ℝ} (hQ : Qop2 W = θ • W)
    (hcap : ∀ X : CurvOp2 (Fin n), IsWeyl2 X → innerOp2 W X = 0 → innerOp2 (foxProd2 W X) X ≤ θ / 2 * normSq2 X) :
    θ / 2 * (normSq2 (piF hU W hW) * (1 - normSq2 (piF hU W hW)))
        ≤ Tsym (piF hU W hW) (W - piF hU W hW) (W - piF hU W hW) ∧
      Pcubic2 (piF hU W hW) ≤ θ / 2 * (normSq2 (piF hU W hW) * (1 + normSq2 (piF hU W hW))) := by
  obtain ⟨h1, h2, h3, -⟩ := L214_frame hU W hW hW1 hQ
  obtain ⟨hNN, -, -⟩ := piF_t_range hU W hW hW1
  have hcapT : ∀ X : CurvOp2 (Fin n), IsWeyl2 X → innerOp2 W X = 0 → Tsym W X X ≤ θ / 2 * normSq2 X :=
    fun X hX hXp => by rw [Tsym_eq_fox hW.isSelfAdjoint2 hX.isSelfAdjoint2]; exact hcap X hX hXp
  have ha := L214_op_cap (t := normSq2 (piF hU W hW)) hW hQ hcapT (isWeyl2_piF hU W hW) (show W = piF hU W hW + (W - piF hU W hW) by abel)
    h1 rfl hNN h2
  refine ⟨ha, ?_⟩
  have e : θ / 2 * (normSq2 (piF hU W hW) * (1 + normSq2 (piF hU W hW)))
      = θ * normSq2 (piF hU W hW) - θ / 2 * (normSq2 (piF hU W hW) * (1 - normSq2 (piF hU W hW))) := by ring
  rw [e]
  linarith [ha, h3]

/-- **The two forms of L214's inequality are equivalent** given the first relation `θt = P(D) + a`. -/
theorem L214_ineq_iff {θ t PD a : ℝ} (h : θ * t = PD + a) :
    θ / 2 * (t * (1 - t)) ≤ a ↔ PD ≤ θ / 2 * (t * (1 + t)) := by
  have e : θ / 2 * (t * (1 + t)) = θ * t - θ / 2 * (t * (1 - t)) := by ring
  rw [e]
  constructor <;> intro h' <;> linarith

end HamiltonsCubic.L214Frame
