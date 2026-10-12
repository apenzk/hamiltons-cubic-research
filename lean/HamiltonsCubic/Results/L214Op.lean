import Mathlib
import HamiltonsCubic.Results.L24Weyl
import HamiltonsCubic.Results.L214FrameSplit

set_option linter.style.longLine false

/-!
# L214 at the operator: the frame split's relations for `P`, and the maximiser inequality through L24

[findings/second-order.md](../../../findings/second-order.md), Lemma L214: at a unit critical point `W = D + N`,
`t = ‖D‖²`, `a = ⟨D ∘ N, N⟩`, *"$\theta t=P(D)+a$ and $\theta(1-t)=2a+P(N)$, and if in addition
$L_W\le\tfrac\theta2$ on $W^\perp$, which Lemma L24 gives at every GLOBAL maximiser, and at a local one with
$\theta>0$, then $a\ge\tfrac\theta2t(1-t)$."* [L214FrameSplit.lean](L214FrameSplit.lean) proves this for an
abstract totally symmetric trilinear form with criticality and the cap as hypotheses. This file instantiates it
at `P` on `CurvOp2`:

* `Tsym`: the symmetrisation of [CubicTri.lean](CubicTri.lean)'s `cubicTri`, a totally symmetric trilinear
  form with `Tsym R R R = P(R)`, `3 Tsym R R H = Pcubic2Lin R H`, the linear part of `P`'s increment, and
  `3 Tsym R H H = Pcubic2Quad R H`, its quadratic part, so `Tsym R H H = ⅙ P''(R)(H, H)`; `TsymL` and `ipL`
  bundle it and the pairing `⟨·,·⟩` as multilinear maps;
* `Tsym_crit`: at a self-adjoint `W` with `Q(W) = θW`, `Tsym W W x = θ⟨W, x⟩` for every `x`;
* `Tsym_cap`: at a unit Weyl local maximiser `W` of `P` on the Weyl sphere with `Q(W) = θW` and `θ > 0`,
  `Tsym W X X ≤ (θ/2)‖X‖²` for every Weyl `X ⊥ W`, from `L24_weyl`;
* `L214_op`: the two relations at every split `W = D + N` with `⟨D, N⟩ = 0`, `‖D‖² = t`, `‖N‖² = 1 - t` and
  `Tsym D D N = 0`;
* `L214_op_cap`: under the cap `T(W,X,X) ≤ (θ/2)‖X‖²` on Weyl `X ⊥ W`, `a ≥ (θ/2) t(1 - t)`;
* `L214_op_max`: at such a maximiser with `D` Weyl (so `N = W - D` is Weyl), `a ≥ (θ/2) t(1 - t)`.

The frame input `Tsym D D N = 0`, which the record draws from L120 at the coordinate-diagonal split, enters as a
hypothesis.
-/

namespace HamiltonsCubic.L214Op

open HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The symmetrised cubic form.** -/
noncomputable def Tsym (X Y Z : CurvOp2 ι) : ℝ :=
  (1 / 6) * (cubicTri X Y Z + cubicTri Y X Z + cubicTri X Z Y + cubicTri Z Y X + cubicTri Y Z X
    + cubicTri Z X Y)

theorem Tsym_add_left (X X' Y Z : CurvOp2 ι) : Tsym (X + X') Y Z = Tsym X Y Z + Tsym X' Y Z := by
  unfold Tsym; simp only [cubicTri_add_left, cubicTri_add_mid, cubicTri_add_right]; ring

theorem Tsym_add_mid (X Y Y' Z : CurvOp2 ι) : Tsym X (Y + Y') Z = Tsym X Y Z + Tsym X Y' Z := by
  unfold Tsym; simp only [cubicTri_add_left, cubicTri_add_mid, cubicTri_add_right]; ring

theorem Tsym_add_right (X Y Z Z' : CurvOp2 ι) : Tsym X Y (Z + Z') = Tsym X Y Z + Tsym X Y Z' := by
  unfold Tsym; simp only [cubicTri_add_left, cubicTri_add_mid, cubicTri_add_right]; ring

theorem Tsym_smul_left (c : ℝ) (X Y Z : CurvOp2 ι) : Tsym (c • X) Y Z = c * Tsym X Y Z := by
  unfold Tsym; simp only [cubicTri_smul_left, cubicTri_smul_mid, cubicTri_smul_right]; ring

theorem Tsym_smul_mid (c : ℝ) (X Y Z : CurvOp2 ι) : Tsym X (c • Y) Z = c * Tsym X Y Z := by
  unfold Tsym; simp only [cubicTri_smul_left, cubicTri_smul_mid, cubicTri_smul_right]; ring

theorem Tsym_smul_right (c : ℝ) (X Y Z : CurvOp2 ι) : Tsym X Y (c • Z) = c * Tsym X Y Z := by
  unfold Tsym; simp only [cubicTri_smul_left, cubicTri_smul_mid, cubicTri_smul_right]; ring

theorem Tsym_12 (X Y Z : CurvOp2 ι) : Tsym X Y Z = Tsym Y X Z := by unfold Tsym; ring

theorem Tsym_23 (X Y Z : CurvOp2 ι) : Tsym X Y Z = Tsym X Z Y := by unfold Tsym; ring

/-- `Tsym` bundled as a trilinear map. -/
noncomputable def TsymL : CurvOp2 ι →ₗ[ℝ] CurvOp2 ι →ₗ[ℝ] CurvOp2 ι →ₗ[ℝ] ℝ where
  toFun X := LinearMap.mk₂ ℝ (Tsym X) (fun Y Y' Z => Tsym_add_mid X Y Y' Z)
    (fun c Y Z => Tsym_smul_mid c X Y Z) (fun Y Z Z' => Tsym_add_right X Y Z Z')
    (fun c Y Z => Tsym_smul_right c X Y Z)
  map_add' X X' := by
    ext Y Z
    simp only [LinearMap.mk₂_apply, LinearMap.add_apply]
    exact Tsym_add_left X X' Y Z
  map_smul' c X := by
    ext Y Z
    simp only [LinearMap.mk₂_apply, LinearMap.smul_apply, RingHom.id_apply, smul_eq_mul]
    exact Tsym_smul_left c X Y Z

/-- The pairing `⟨·,·⟩` bundled as a bilinear map. -/
noncomputable def ipL : CurvOp2 ι →ₗ[ℝ] CurvOp2 ι →ₗ[ℝ] ℝ :=
  LinearMap.mk₂ ℝ innerOp2 innerOp2_add_left innerOp2_smul_left innerOp2_add_right innerOp2_smul_right

theorem TsymL_apply (X Y Z : CurvOp2 ι) : TsymL X Y Z = Tsym X Y Z := rfl

theorem ipL_apply (X Y : CurvOp2 ι) : ipL X Y = innerOp2 X Y := rfl

/-- `Tsym R R R = P(R)`. -/
theorem Tsym_diag (R : CurvOp2 ι) : Tsym R R R = Pcubic2 R := by
  rw [Pcubic2_eq_cubicTri]; unfold Tsym; ring

/-- `Tsym R R H` is a third of the linear part of `P`'s increment. -/
theorem Tsym_lin (R H : CurvOp2 ι) : 3 * Tsym R R H = Pcubic2Lin R H := by
  rw [Pcubic2Lin_eq_cubicTri]; unfold Tsym; ring

/-- `Tsym R H H` is a third of the quadratic part. -/
theorem Tsym_quad (R H : CurvOp2 ι) : 3 * Tsym R H H = Pcubic2Quad R H := by
  rw [Pcubic2Quad_eq_cubicTri]; unfold Tsym; ring

/-- **Criticality, paired**: at a self-adjoint `W` with `Q(W) = θW`, `Tsym W W x = θ⟨W, x⟩`. -/
theorem Tsym_crit {W : CurvOp2 ι} (hW : IsSelfAdjoint2 W) {θ : ℝ} (hQ : Qop2 W = θ • W) (x : CurvOp2 ι) :
    Tsym W W x = θ * innerOp2 W x := by
  have h := Tsym_lin W x
  rw [Pcubic2Lin_selfAdjoint hW, hQ, innerOp2_smul_right, innerOp2_comm x W] at h
  linarith

/-- **L24's cap in `Tsym` form.** -/
theorem Tsym_cap {W : CurvOp2 ι} {θ : ℝ} (hW1 : normSq2 W = 1) (hWW : IsWeyl2 W) (hQ : Qop2 W = θ • W)
    (hmax : IsLocalMaxOn Pcubic2 {R : CurvOp2 ι | normSq2 R = 1 ∧ IsWeyl2 R} W) (hθ : 0 < θ)
    {X : CurvOp2 ι} (hXW : IsWeyl2 X) (hXp : innerOp2 W X = 0) :
    Tsym W X X ≤ θ / 2 * normSq2 X := by
  have hPW : Pcubic2 W = θ := by
    rw [← Tsym_diag, Tsym_crit hWW.isSelfAdjoint2 hQ, show innerOp2 W W = normSq2 W from rfl, hW1, mul_one]
  rcases (normSq2_nonneg X).lt_or_eq with hpos | hzero
  · set r := Real.sqrt (normSq2 X) with hr
    have hr0 : 0 < r := Real.sqrt_pos.mpr hpos
    have hr2 : r ^ 2 = normSq2 X := Real.sq_sqrt hpos.le
    set v := (1 / r) • X with hv
    have hvW : IsWeyl2 v := isWeyl2_smul _ hXW
    have hvp : innerOp2 W v = 0 := by rw [hv, innerOp2_smul_right, hXp, mul_zero]
    have hv1 : normSq2 v = 1 := by
      show innerOp2 v v = 1
      rw [hv, innerOp2_smul_left, innerOp2_smul_right, show innerOp2 X X = normSq2 X from rfl, ← hr2]
      field_simp
    have hcap := L24_weyl hW1 hWW hQ hmax (by rw [hPW]; exact hθ) hvW hvp hv1
    have hTv : Tsym W v v = innerOp2 W (Qop2 v) := by
      have := Tsym_quad W v
      rw [Pcubic2Quad_selfAdjoint hvW.isSelfAdjoint2] at this
      linarith
    have hX : X = r • v := by rw [hv, smul_smul, mul_one_div_cancel hr0.ne', one_smul]
    have hTX : Tsym W X X = r ^ 2 * Tsym W v v := by
      rw [hX, Tsym_smul_mid, Tsym_smul_right]; ring
    rw [hTX, hTv, ← hr2, hPW] at *
    nlinarith [sq_nonneg r]
  · have hX0 : X = 0 := normSq2_eq_zero hzero.symm
    have e : (0 : ℝ) • X = X := by
      refine ContinuousLinearMap.ext fun x => Subtype.ext ?_
      subst hX0; simp
    have h := Tsym_smul_mid (0 : ℝ) W X X
    rw [e, zero_mul] at h
    rw [h, ← hzero, mul_zero]

/-- **L214's two relations at the operator.** -/
theorem L214_op {W D N : CurvOp2 ι} (hW : IsSelfAdjoint2 W) {θ t : ℝ} (hQ : Qop2 W = θ • W)
    (hsplit : W = D + N) (hDN : innerOp2 D N = 0) (ht : innerOp2 D D = t) (htN : innerOp2 N N = 1 - t)
    (hperp : Tsym D D N = 0) :
    θ * t = Pcubic2 D + Tsym D N N ∧ θ * (1 - t) = 2 * Tsym D N N + Pcubic2 N := by
  have hs12 : ∀ x y z : CurvOp2 ι, TsymL x y z = TsymL y x z := fun x y z => Tsym_12 x y z
  have hs23 : ∀ x y z : CurvOp2 ι, TsymL x y z = TsymL x z y := fun x y z => Tsym_23 x y z
  have hip : ∀ x y : CurvOp2 ι, ipL x y = ipL y x := fun x y => innerOp2_comm x y
  have hcrit : ∀ x : CurvOp2 ι, TsymL (D + N) (D + N) x = θ * ipL (D + N) x := fun x => by
    rw [TsymL_apply, ipL_apply, ← hsplit]; exact Tsym_crit hW hQ x
  have h1 := HamiltonsCubic.Results.rel_one (T := TsymL) (ip := ipL) (D := D) (N := N) (θ := θ) (t := t)
    hs12 hs23 hip hcrit hDN ht hperp
  have h2 := HamiltonsCubic.Results.rel_two (T := TsymL) (ip := ipL) (D := D) (N := N) (θ := θ) (t := t)
    hs12 hip hcrit hDN htN hperp
  simp only [TsymL_apply, Tsym_diag] at h1 h2
  exact ⟨h1, h2⟩

/-- **L214's inequality under the cap**: at a critical Weyl `W` with `T(W,X,X) ≤ (θ/2)‖X‖²` for every Weyl `X ⊥ W`
(the record's `L_W ≤ θ/2` on `W^⊥`), and a split with `D` Weyl, `a ≥ (θ/2) t(1 - t)`. -/
theorem L214_op_cap {W D N : CurvOp2 ι} {θ t : ℝ} (hWW : IsWeyl2 W) (hQ : Qop2 W = θ • W)
    (hcapW : ∀ X : CurvOp2 ι, IsWeyl2 X → innerOp2 W X = 0 → Tsym W X X ≤ θ / 2 * normSq2 X) (hDW : IsWeyl2 D)
    (hsplit : W = D + N) (hDN : innerOp2 D N = 0) (ht : innerOp2 D D = t) (htN : innerOp2 N N = 1 - t)
    (hperp : Tsym D D N = 0) :
    θ / 2 * (t * (1 - t)) ≤ Tsym D N N := by
  have hs12 : ∀ x y z : CurvOp2 ι, TsymL x y z = TsymL y x z := fun x y z => Tsym_12 x y z
  have hs23 : ∀ x y z : CurvOp2 ι, TsymL x y z = TsymL x z y := fun x y z => Tsym_23 x y z
  have hip : ∀ x y : CurvOp2 ι, ipL x y = ipL y x := fun x y => innerOp2_comm x y
  obtain ⟨hr1, hr2⟩ := L214_op hWW.isSelfAdjoint2 hQ hsplit hDN ht htN hperp
  have hr1' : θ * t = TsymL D D D + TsymL D N N := by simp only [TsymL_apply, Tsym_diag]; exact hr1
  have hr2' : θ * (1 - t) = 2 * TsymL D N N + TsymL N N N := by
    simp only [TsymL_apply, Tsym_diag]; exact hr2
  have hcancel := HamiltonsCubic.Results.cross_cancel (T := TsymL) (D := D) (N := N) (θ := θ) (t := t)
    hs12 hs23 hperp hr1' hr2'
  set X := t • N - (1 - t) • D with hXdef
  have hNW : IsWeyl2 N := by
    have e : N = W + (-1 : ℝ) • D := by
      refine ContinuousLinearMap.ext fun x => Subtype.ext ?_
      rw [hsplit]
      simp only [ContinuousLinearMap.add_apply, ContinuousLinearMap.smul_apply, Submodule.coe_add,
        Submodule.coe_smul]
      module
    rw [e]
    exact isWeyl2_add hWW (isWeyl2_smul _ hDW)
  have hXW : IsWeyl2 X := by
    have e : t • N - (1 - t) • D = t • N + (t - 1) • D := by
      refine ContinuousLinearMap.ext fun x => Subtype.ext ?_
      simp only [ContinuousLinearMap.sub_apply, ContinuousLinearMap.add_apply, ContinuousLinearMap.smul_apply,
        Submodule.coe_sub, Submodule.coe_add, Submodule.coe_smul]
      module
    rw [hXdef, e]
    exact isWeyl2_add (isWeyl2_smul _ hNW) (isWeyl2_smul _ hDW)
  have hperpX := HamiltonsCubic.Results.test_perp (ip := ipL) (D := D) (N := N) (t := t) hip hDN ht htN
  have hnormX := HamiltonsCubic.Results.test_norm (ip := ipL) (D := D) (N := N) (t := t) hip hDN ht htN
  rw [ipL_apply] at hperpX hnormX
  have hWX : innerOp2 W X = 0 := by rw [innerOp2_comm, hsplit]; exact hperpX
  have hcap := hcapW X hXW hWX
  rw [show normSq2 X = innerOp2 X X from rfl, hnormX] at hcap
  have hcap' : TsymL (D + N) X X ≤ θ / 2 * (t * (1 - t)) := by
    rw [TsymL_apply, ← hsplit]; exact hcap
  have := HamiltonsCubic.Results.maximiser_ineq (T := TsymL) (D := D) (N := N) (θ := θ) (t := t) hcancel hcap'
  rw [TsymL_apply] at this
  exact this

/-- **L214's inequality at a Weyl local maximiser**: `a ≥ (θ/2) t(1 - t)`. -/
theorem L214_op_max {W D N : CurvOp2 ι} {θ t : ℝ} (hW1 : normSq2 W = 1) (hWW : IsWeyl2 W)
    (hQ : Qop2 W = θ • W) (hmax : IsLocalMaxOn Pcubic2 {R : CurvOp2 ι | normSq2 R = 1 ∧ IsWeyl2 R} W)
    (hθ : 0 < θ) (hDW : IsWeyl2 D)
    (hsplit : W = D + N) (hDN : innerOp2 D N = 0) (ht : innerOp2 D D = t) (htN : innerOp2 N N = 1 - t)
    (hperp : Tsym D D N = 0) :
    θ / 2 * (t * (1 - t)) ≤ Tsym D N N := by
  exact L214_op_cap hWW hQ (fun X hX hXp => Tsym_cap hW1 hWW hQ hmax hθ hX hXp) hDW hsplit hDN ht htN hperp

end HamiltonsCubic.L214Op
