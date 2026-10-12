import Mathlib
import HamiltonsCubic.Results.RotDeriv
import HamiltonsCubic.Results.L217Le

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L217 at every gapped critical orbit

[findings/second-order.md](../../../findings/second-order.md), Lemma L217: *Let $u$ be a unit critical point of $P$ on the unit sphere
of $\mathcal W_n$ with $\theta_u=P(u)>0$ and $e=u/\theta_u$, and suppose $\langle L_eH,H\rangle\le\tfrac12-\gamma$ for every unit
$H\perp u$ orthogonal to the orbit tangent $T_u\mathcal O$, $\mathcal O=O(n)\cdot u$, with $\gamma\ge0$. Let $W^\ast$ be a global
maximiser of $P$ on the unit sphere, $m=P(W^\ast)$, at geodesic distance $\varphi\in[0,\tfrac\pi2]$ from $\mathcal O$ with
$\sin\varphi\le\min(3\gamma,\tfrac12)$. Then $m\le\theta_u$, and … $m=\theta_u$.*

The orbit tangent `T_u𝒪` is spanned by `orbitTangent u X = [ad_X, u]`, `X` skew, hence by the generators `X = φ_jk`, `j ≠ k`, and the
gap hypothesis is stated over `H` orthogonal to those. The geodesic distance is `arccos` of the largest pairing `⟨U · W^∗, u⟩`.

* **`first_order_gen`**: at a maximiser `U₀` of `U ↦ ⟨U · V, u⟩`, `U₀ · V` is orthogonal to every generator orbit tangent, from
  [RotDeriv.lean](RotDeriv.lean)'s `hasDerivAt_pairing`;
* `pairing_le_self`, **`tangent_perp`**: `u` is a maximiser of its own orbit pairing, so `u ⊥ orbitTangent u φ_jk`;
* **`L217_general`**: the lemma.
-/

namespace HamiltonsCubic.L217Gen

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FrameOp2 HamiltonsCubic.FrameLayer HamiltonsCubic.TensorBridge
  HamiltonsCubic.L3Local HamiltonsCubic.RotDeriv

variable {n : ℕ}

/-- The generator orbit tangent `[ad_{φ_jk}, u]`. -/
noncomputable abbrev tang (u : CurvOp2 (Fin n)) (j k : Fin n) : CurvOp2 (Fin n) :=
  HamiltonsCubic.I117S.orbitTangent u ⟨phi j k, phi_mem_skewSub j k⟩

/-- **The first-order condition at every operator.** -/
theorem first_order_gen {u V : CurvOp2 (Fin n)} (hu : IsWeyl2 u) (hV : IsWeyl2 V)
    {U₀ : Matrix (Fin n) (Fin n) ℝ} (hU₀ : U₀ ∈ orthSet n)
    (hmax : ∀ U ∈ orthSet n, innerOp2 (rotR U V) u ≤ innerOp2 (rotR U₀ V) u) {j k : Fin n} (hjk : j ≠ k) :
    innerOp2 (tang u j k) (rotR U₀ V) = 0 := by
  have hV' : IsWeyl2 (rotR U₀ V) := rotR_isWeyl2 hU₀ hV
  have hd := hasDerivAt_pairing u (rotR U₀ V) hjk
  have hloc : IsLocalMax (fun φ => innerOp2 (rotR (HamiltonsCubic.PairSquare.Rot j k (Real.cos φ) (Real.sin φ)) u)
      (rotR U₀ V)) 0 := by
    refine Filter.Eventually.of_forall fun φ => ?_
    have hR : ∀ ψ : ℝ, IsOrth (HamiltonsCubic.PairSquare.Rot j k (Real.cos ψ) (Real.sin ψ)) := fun ψ =>
      HamiltonsCubic.PairSquare.Rot_orth hjk (Real.cos_sq_add_sin_sq ψ)
    have key : ∀ ψ : ℝ, innerOp2 (rotR (HamiltonsCubic.PairSquare.Rot j k (Real.cos ψ) (Real.sin ψ)) u) (rotR U₀ V)
        = innerOp2 (rotR ((HamiltonsCubic.PairSquare.Rot j k (Real.cos ψ) (Real.sin ψ))ᵀ * U₀) V) u := by
      intro ψ
      rw [innerOp2_rotR_adj (hR ψ) hu hV', HamiltonsCubic.L219GenOps.rotR_comp, innerOp2_comm]
    simp only
    rw [key φ, key 0, Real.cos_zero, Real.sin_zero, Rot_zero, Matrix.transpose_one, Matrix.one_mul]
    exact hmax _ (isOrth_mul (isOrth_transpose (hR φ)) hU₀)
  exact hloc.hasDerivAt_eq_zero hd

/-- `⟨U · u, u⟩ ≤ ⟨u, u⟩`: the frame change preserves the norm. -/
theorem pairing_le_self {u : CurvOp2 (Fin n)} (hu : IsWeyl2 u) {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) :
    innerOp2 (rotR U u) u ≤ innerOp2 (rotR 1 u) u := by
  rw [HamiltonsCubic.L219GenOps.rotR_one]
  have h := innerOp2_self_nonneg (rotR U u - u)
  have hn : normSq2 (rotR U u) = normSq2 u := normSq2_rotR hU hu
  have e := normSq2_sub (rotR U u) u
  unfold normSq2 at hn e
  linarith

/-- **The orbit tangents are orthogonal to `u`.** -/
theorem tangent_perp {u : CurvOp2 (Fin n)} (hu : IsWeyl2 u) {j k : Fin n} (hjk : j ≠ k) :
    innerOp2 (tang u j k) u = 0 := by
  have h1 : (1 : Matrix (Fin n) (Fin n) ℝ) ∈ orthSet n := by
    show IsOrth 1
    exact ⟨by simp, by simp⟩
  have h := first_order_gen hu hu h1 (fun U hU => pairing_le_self hu hU) hjk
  rwa [HamiltonsCubic.L219GenOps.rotR_one] at h

/-- **L217 at every gapped critical orbit.** `u` a unit critical Weyl operator with `θ = P(u) > 0`, the gap
`⟨L_e H, H⟩ ≤ ½ − γ` at every unit Weyl `H ⊥ u` orthogonal to the orbit tangent, `γ ≥ 0`; `W^∗` a global maximiser of `P` on the unit
sphere within geodesic angle `arcsin min(3γ, ½)` of the orbit, i.e. `⟨U · W^∗, u⟩ ≥ √(1 − min(3γ, ½)²)` for some orthogonal `U`.
Then `P(W^∗) = θ`. -/
theorem L217_general {u : CurvOp2 (Fin n)} (huW : IsWeyl2 u) (hu1 : normSq2 u = 1) {θ : ℝ} (hQ : Qop2 u = θ • u)
    (hθ : 0 < θ) {γ : ℝ} (hγ : 0 ≤ γ)
    (hgap : ∀ H : CurvOp2 (Fin n), IsWeyl2 H → normSq2 H = 1 → innerOp2 u H = 0 →
      (∀ j k : Fin n, j ≠ k → innerOp2 (tang u j k) H = 0) → innerOp2 (LeLin u H) H ≤ 1 / 2 - γ)
    {W : CurvOp2 (Fin n)} (hWW : IsWeyl2 W) (hW1 : normSq2 W = 1)
    (hmax : ∀ R : CurvOp2 (Fin n), IsWeyl2 R → normSq2 R = 1 → Pcubic2 R ≤ Pcubic2 W)
    (hnear : ∃ U, IsOrth U ∧ Real.sqrt (1 - (min (3 * γ) (1 / 2)) ^ 2) ≤ innerOp2 (rotR U W) u) :
    Pcubic2 W = θ := by
  have hPu : Pcubic2 u = θ := HamiltonsCubic.L217Le.Pcubic2_crit huW.isSelfAdjoint2 hQ hu1
  set r : ℝ := min (3 * γ) (1 / 2) with hrdef
  have hr0 : 0 ≤ r := le_min (by linarith) (by norm_num)
  obtain ⟨U, hU, hUnear⟩ := hnear
  obtain ⟨U₀, hU₀, hmx⟩ := exists_max W u
  set V' := rotR U₀ W with hV'def
  have hV'W : IsWeyl2 V' := rotR_isWeyl2 hU₀ hWW
  have hV'1 : normSq2 V' = 1 := by rw [hV'def, normSq2_rotR hU₀ hWW, hW1]
  have hPV : Pcubic2 W = Pcubic2 V' := (Pcubic2_rotR hU₀ hWW).symm
  set c := innerOp2 V' u with hcdef
  have hc_ge : Real.sqrt (1 - r ^ 2) ≤ c := le_trans hUnear (hmx U hU)
  have hc0 : 0 ≤ c := le_trans (Real.sqrt_nonneg _) hc_ge
  set h := V' - c • u with hhdef
  have hhW : IsWeyl2 h := HamiltonsCubic.L214Frame.isWeyl2_sub' hV'W (isWeyl2_smul c huW)
  have hperp : innerOp2 u h = 0 := by
    rw [hhdef, innerOp2_comm, innerOp2_sub_left', innerOp2_smul_left, show innerOp2 u u = 1 from hu1, ← hcdef]; ring
  have hu : normSq2 h = 1 - c ^ 2 := by
    rw [hhdef, normSq2_sub, hV'1, innerOp2_smul_right, ← hcdef]
    unfold normSq2
    rw [innerOp2_smul_left, innerOp2_smul_right]
    unfold normSq2 at hu1
    rw [hu1]; ring
  have hdecomp : V' = c • u + h := by rw [hhdef]; abel
  have htan : ∀ j k : Fin n, j ≠ k → innerOp2 (tang u j k) h = 0 := by
    intro j k hjk
    have h1 := first_order_gen huW hWW hU₀ hmx hjk
    have h2 := tangent_perp huW hjk
    rw [hhdef, innerOp2_comm, innerOp2_sub_left', innerOp2_smul_left, innerOp2_comm V', innerOp2_comm u, h1, h2]
    ring
  have hPV' : Pcubic2 u ≤ Pcubic2 V' := by rw [← hPV]; exact hmax u huW hu1
  have hu0 : 0 ≤ normSq2 h := innerOp2_self_nonneg h
  clear_value h c V' r
  by_cases hz : normSq2 h = 0
  · have h0 : h = 0 := normSq2_eq_zero hz
    have e : (c - 1) * (c + 1) = 0 := by
      have : 1 - c ^ 2 = 0 := by rw [← hu, hz]
      linear_combination -this
    have hc1 : c = 1 := by
      rcases mul_eq_zero.mp e with h1 | h1
      · linarith
      · linarith
    rw [hPV, hdecomp, h0, hc1, ← hPu]
    congr 1
    module
  · have hpos : 0 < normSq2 h := lt_of_le_of_ne hu0 (Ne.symm hz)
    set s := Real.sqrt (normSq2 h) with hsdef
    have hs0 : 0 < s := Real.sqrt_pos.mpr hpos
    have hs2 : s ^ 2 = normSq2 h := Real.sq_sqrt hu0
    have hcs : c ^ 2 + s ^ 2 = 1 := by rw [hs2, hu]; ring
    have hc2 : 1 - r ^ 2 ≤ c ^ 2 := by
      have hr := Real.sqrt_nonneg (1 - r ^ 2)
      have hsq : Real.sqrt (1 - r ^ 2) ^ 2 ≤ c ^ 2 := pow_le_pow_left₀ hr hc_ge 2
      by_cases hneg : 0 ≤ 1 - r ^ 2
      · rwa [Real.sq_sqrt hneg] at hsq
      · have hneg' := lt_of_not_ge hneg
        nlinarith only [hneg', sq_nonneg c]
    have hs : s ≤ r := by
      have hss : s ^ 2 ≤ r ^ 2 := by linarith only [hcs, hc2]
      exact (pow_le_pow_iff_left₀ hs0.le hr0 (by norm_num)).mp hss
    have hshalf : s ≤ 1 / 2 := le_trans hs (by rw [hrdef]; exact min_le_right _ _)
    have hs3 : s ≤ 3 * γ := le_trans hs (by rw [hrdef]; exact min_le_left _ _)
    set v := s⁻¹ • h with hvdef
    have hvW : IsWeyl2 v := isWeyl2_smul _ hhW
    have hv1 : normSq2 v = 1 := by
      rw [hvdef]; unfold normSq2
      rw [innerOp2_smul_left, innerOp2_smul_right]
      have : innerOp2 h h = s ^ 2 := hs2.symm
      rw [this]; field_simp
    have hvu : innerOp2 u v = 0 := by rw [hvdef, innerOp2_smul_right, hperp, mul_zero]
    have hvtan : ∀ j k : Fin n, j ≠ k → innerOp2 (tang u j k) v = 0 := by
      intro j k hjk; rw [hvdef, innerOp2_smul_right, htan j k hjk, mul_zero]
    have hg := hgap v hvW hv1 hvu hvtan
    have hW' : V' = c • u + s • v := by
      rw [hdecomp, hvdef, smul_smul, mul_inv_cancel₀ hs0.ne', one_smul]
    have hmax' : ∀ R : CurvOp2 (Fin n), IsWeyl2 R → normSq2 R = 1 → Pcubic2 R ≤ Pcubic2 V' := by
      intro R hRW hR1; rw [← hPV]; exact hmax R hRW hR1
    have hle := HamiltonsCubic.L217Le.L217_op_Le huW.isSelfAdjoint2 hQ hu1 hθ hvW hv1 hvu hg hs0.le hc0 hcs hs3
      hshalf hW' hmax'
    rw [hPV]
    rw [hPu] at hPV'
    linarith only [hle, hPV']

end HamiltonsCubic.L217Gen
