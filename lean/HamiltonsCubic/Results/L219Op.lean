import Mathlib
import HamiltonsCubic.Results.L219Statement
import HamiltonsCubic.Results.L214Op
import HamiltonsCubic.Results.WeylInvariantZero
import HamiltonsCubic.Results.WeylEquivariance
import HamiltonsCubic.Results.WeylTraceSchur
import HamiltonsCubic.Results.RecordNormed

set_option linter.style.longLine false

/-!
# L219 on `𝒲ₙ`: the reflection split at a coordinate reflection

[findings/second-order.md](../../../findings/second-order.md), Lemma L219: *split $W=b+c$ with $\sigma_ub=b$, $\sigma_uc=-c$;
then $P(W)=P(b)+3\langle L_bc,c\rangle$, $P(c)=0$, and at a critical point $\langle L_bc,c\rangle=\tfrac\theta2\lVert c\rVert^2$,
$P(b)=\theta(\lVert b\rVert^2-\tfrac12\lVert c\rVert^2)$.* [L219Statement.lean](L219Statement.lean) proves the algebra for any
symmetric trilinear form invariant under a linear map. This file supplies the map on `CurvOp2` at a coordinate reflection
$\sigma_{e_m}$ and its invariances:

* `cS m`, conjugation by the reflection `flip m` on bivectors, an involution (`cS_cS`) acting on $\varphi_{ij}$ by
  $\varepsilon_i\varepsilon_j$ (`cS_phi`), commuting with the bracket (`cS_br`) and self-adjoint for `inner2` (`i2_cS`);
* `sig m`, its action $R\mapsto\sigma R\sigma$ on `CurvOp2`, an involution (`sig_sig`) that commutes with composition and
  preserves `innerOp2`, `phiTri` and so `Tsym` (`Tsym_sig`), each $\varphi$ term picking up a sign that appears squared;
* **`L219_op`**: at a self-adjoint $W$ with $Q(W)=\theta W$ and $b=\tfrac12(W+\sigma W)$, $c=\tfrac12(W-\sigma W)$,
  $T(b,c,c)=\tfrac\theta2\lVert c\rVert^2$, $P(b)=\theta(\lVert b\rVert^2-\tfrac12\lVert c\rVert^2)$, $P(c)=0$ and
  $P(W)=P(b)+3T(b,c,c)$, $T$ being `Tsym`, whose $T(b,c,c)$ is $\langle L_bc,c\rangle$.

A general unit $u$ is a coordinate direction in a rotated frame; carrying `CurvOp2` through that rotation is not done here.
-/

namespace HamiltonsCubic.L219Op

open HamiltonsCubic.RealLayer HamiltonsCubic.L214Op Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem flip_T (m : ι) : (Results.flip m)ᵀ = Results.flip m := by
  unfold Results.flip; exact diagonal_transpose _

theorem flip_sq (m : ι) : Results.flip m * Results.flip m = 1 := by
  have h := Results.flip_orth m
  rwa [flip_T] at h

theorem conj_skew (m : ι) {X : Matrix ι ι ℝ} (hX : Xᵀ = -X) :
    ((Results.flip m)ᵀ * X * Results.flip m)ᵀ = -((Results.flip m)ᵀ * X * Results.flip m) := by
  rw [transpose_mul, transpose_mul, transpose_transpose, hX]
  simp [Matrix.mul_assoc]

/-- Conjugation by the coordinate reflection `flip m`, on bivectors. -/
noncomputable def cS (m : ι) : skewSub ι →ₗ[ℝ] skewSub ι where
  toFun X := ⟨(Results.flip m)ᵀ * (X : Matrix ι ι ℝ) * Results.flip m, conj_skew m X.2⟩
  map_add' X Y := Subtype.ext (by simp [Matrix.mul_add, Matrix.add_mul])
  map_smul' c X := Subtype.ext (by simp)

theorem cS_coe (m : ι) (X : skewSub ι) :
    ((cS m X : skewSub ι) : Matrix ι ι ℝ) = (Results.flip m)ᵀ * (X : Matrix ι ι ℝ) * Results.flip m := rfl

theorem cS_cS (m : ι) (X : skewSub ι) : cS m (cS m X) = X := by
  apply Subtype.ext
  rw [cS_coe, cS_coe, flip_T]
  calc Results.flip m * (Results.flip m * (X : Matrix ι ι ℝ) * Results.flip m) * Results.flip m
      = (Results.flip m * Results.flip m) * (X : Matrix ι ι ℝ) * (Results.flip m * Results.flip m) := by
        simp only [Matrix.mul_assoc]
    _ = X := by rw [flip_sq, Matrix.one_mul, Matrix.mul_one]

theorem cS_phi (m i j : ι) :
    cS m ⟨phi i j, phi_mem_skewSub i j⟩ = (Results.sgn m i * Results.sgn m j) • ⟨phi i j, phi_mem_skewSub i j⟩ := by
  apply Subtype.ext
  rw [cS_coe]
  exact Results.rot_flip m i j

theorem cS_br (m : ι) (X Y : skewSub ι) : cS m (brS X Y) = brS (cS m X) (cS m Y) := by
  apply Subtype.ext
  show (Results.flip m)ᵀ * br (X : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) * Results.flip m
    = br ((Results.flip m)ᵀ * (X : Matrix ι ι ℝ) * Results.flip m) ((Results.flip m)ᵀ * (Y : Matrix ι ι ℝ) * Results.flip m)
  rw [flip_T]
  unfold br
  set F := Results.flip m
  have h1 : F * (X : Matrix ι ι ℝ) * F * (F * (Y : Matrix ι ι ℝ) * F) = F * ((X : Matrix ι ι ℝ) * Y) * F := by
    calc F * (X : Matrix ι ι ℝ) * F * (F * (Y : Matrix ι ι ℝ) * F)
        = F * (X : Matrix ι ι ℝ) * (F * F) * (Y : Matrix ι ι ℝ) * F := by simp only [Matrix.mul_assoc]
      _ = F * ((X : Matrix ι ι ℝ) * Y) * F := by rw [flip_sq, Matrix.mul_one]; simp only [Matrix.mul_assoc]
  have h2 : F * (Y : Matrix ι ι ℝ) * F * (F * (X : Matrix ι ι ℝ) * F) = F * ((Y : Matrix ι ι ℝ) * X) * F := by
    calc F * (Y : Matrix ι ι ℝ) * F * (F * (X : Matrix ι ι ℝ) * F)
        = F * (Y : Matrix ι ι ℝ) * (F * F) * (X : Matrix ι ι ℝ) * F := by simp only [Matrix.mul_assoc]
      _ = F * ((Y : Matrix ι ι ℝ) * X) * F := by rw [flip_sq, Matrix.mul_one]; simp only [Matrix.mul_assoc]
  rw [h1, h2, Matrix.mul_sub, Matrix.sub_mul]

theorem i2_cS (m : ι) (X Y : skewSub ι) :
    inner2 ((cS m X : skewSub ι) : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ)
      = inner2 (X : Matrix ι ι ℝ) ((cS m Y : skewSub ι) : Matrix ι ι ℝ) := by
  rw [cS_coe, cS_coe]
  have h := Results.inner2_conj (Results.flip m)ᵀ (X : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ)
  simp only [transpose_transpose, flip_T] at h ⊢
  exact h

/-- The reflection acting on `CurvOp2`, `R ↦ σ R σ`. -/
noncomputable def sigR (m : ι) (R : CurvOp2 ι) : CurvOp2 ι :=
  LinearMap.toContinuousLinearMap ((cS m).comp ((R : skewSub ι →ₗ[ℝ] skewSub ι).comp (cS m)))

theorem sigR_apply (m : ι) (R : CurvOp2 ι) (X : skewSub ι) : sigR m R X = cS m (R (cS m X)) := rfl

noncomputable def sig (m : ι) : CurvOp2 ι →ₗ[ℝ] CurvOp2 ι where
  toFun := sigR m
  map_add' R R' := ContinuousLinearMap.ext fun X => by
    simp only [sigR_apply, ContinuousLinearMap.add_apply, map_add]
  map_smul' c R := ContinuousLinearMap.ext fun X => by
    simp only [sigR_apply, ContinuousLinearMap.smul_apply, map_smul, RingHom.id_apply]

theorem sig_apply (m : ι) (R : CurvOp2 ι) (X : skewSub ι) : sig m R X = cS m (R (cS m X)) := rfl

theorem sig_sig (m : ι) (R : CurvOp2 ι) : sig m (sig m R) = R :=
  ContinuousLinearMap.ext fun X => by rw [sig_apply, sig_apply, cS_cS, cS_cS]

theorem sig_comp (m : ι) (X Y : CurvOp2 ι) : (sig m X).comp (sig m Y) = sig m (X.comp Y) :=
  ContinuousLinearMap.ext fun v => by
    rw [ContinuousLinearMap.comp_apply, sig_apply, sig_apply, cS_cS, sig_apply, ContinuousLinearMap.comp_apply]

theorem sgn_sq (m i j : ι) : (Results.sgn m i * Results.sgn m j) * (Results.sgn m i * Results.sgn m j) = 1 := by
  calc (Results.sgn m i * Results.sgn m j) * (Results.sgn m i * Results.sgn m j)
      = (Results.sgn m i * Results.sgn m i) * (Results.sgn m j * Results.sgn m j) := by ring
    _ = 1 := by rw [Results.sgn_mul_self, Results.sgn_mul_self, one_mul]

theorem sig_phi (m : ι) (R : CurvOp2 ι) (i j : ι) :
    sig m R ⟨phi i j, phi_mem_skewSub i j⟩
      = (Results.sgn m i * Results.sgn m j) • cS m (R ⟨phi i j, phi_mem_skewSub i j⟩) := by
  rw [sig_apply, cS_phi, map_smul, map_smul]

theorem innerOp2_sig (m : ι) (A B : CurvOp2 ι) : innerOp2 (sig m A) (sig m B) = innerOp2 A B := by
  unfold innerOp2
  refine congrArg (HMul.hMul (1 / 2 : ℝ)) (Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_)
  show inner2 ((sig m A ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ)
      ((sig m B ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ)
    = inner2 ((A ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ)
      ((B ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ)
  rw [sig_phi, sig_phi, Submodule.coe_smul, Submodule.coe_smul, HamiltonsCubic.FamilyLayer.inner2_smul_left, HamiltonsCubic.FamilyLayer.inner2_smul_right, i2_cS, cS_cS,
    ← mul_assoc, sgn_sq, one_mul]

theorem phiTri_sig (m : ι) (A B C : CurvOp2 ι) : phiTri (sig m A) (sig m B) (sig m C) = phiTri A B C := by
  unfold phiTri
  refine congrArg (HMul.hMul (-(1 / 4) : ℝ)) (Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
    Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_)
  rw [sig_phi, sig_phi, brS_smul_left, brS_smul_right, ← cS_br, map_smul, map_smul, sig_apply, cS_cS,
    Submodule.coe_smul, Submodule.coe_smul, HamiltonsCubic.FamilyLayer.inner2_smul_left, HamiltonsCubic.FamilyLayer.inner2_smul_left, i2_cS, cS_br, cS_phi, cS_phi,
    brS_smul_left, brS_smul_right, Submodule.coe_smul, Submodule.coe_smul, HamiltonsCubic.FamilyLayer.inner2_smul_right, HamiltonsCubic.FamilyLayer.inner2_smul_right]
  have key : ∀ a b x : ℝ, a * a = 1 → b * b = 1 → a * (b * (a * (b * x))) = x := fun a b x ha hb => by
    linear_combination (b * b * x) * ha + x * hb
  exact key _ _ _ (sgn_sq m i j) (sgn_sq m k l)

theorem Tsym_sig (m : ι) (X Y Z : CurvOp2 ι) : Tsym (sig m X) (sig m Y) (sig m Z) = Tsym X Y Z := by
  have hc : ∀ A B C : CurvOp2 ι, cubicTri (sig m A) (sig m B) (sig m C) = cubicTri A B C := fun A B C => by
    unfold cubicTri
    rw [sig_comp, innerOp2_sig, phiTri_sig]
  unfold Tsym
  rw [hc, hc, hc, hc, hc, hc]

/-- `Tsym` on the inner product space `RecCurv`. -/
noncomputable def TR : RecCurv ι →ₗ[ℝ] RecCurv ι →ₗ[ℝ] RecCurv ι →ₗ[ℝ] ℝ := TsymL

noncomputable def sigV (m : ι) : RecCurv ι →ₗ[ℝ] RecCurv ι := sig m

/-- **L219 at a coordinate reflection.** At a self-adjoint `W` with `Q(W) = θW`, the even and odd parts `b`, `c` under
`σ = sig m` satisfy `T(b,c,c) = (θ/2)‖c‖²`, `P(b) = θ(‖b‖² − ½‖c‖²)`, `P(c) = 0` and `P(W) = P(b) + 3T(b,c,c)`. -/
theorem L219_op (m : ι) (W : CurvOp2 ι) (hWs : IsSelfAdjoint2 W) {θ : ℝ} (hQ : Qop2 W = θ • W) :
    Tsym ((1 / 2 : ℝ) • (W + sig m W)) ((1 / 2 : ℝ) • (W - sig m W)) ((1 / 2 : ℝ) • (W - sig m W))
        = θ / 2 * normSq2 ((1 / 2 : ℝ) • (W - sig m W)) ∧
      Pcubic2 ((1 / 2 : ℝ) • (W + sig m W))
        = θ * (normSq2 ((1 / 2 : ℝ) • (W + sig m W)) - normSq2 ((1 / 2 : ℝ) • (W - sig m W)) / 2) ∧
      Pcubic2 ((1 / 2 : ℝ) • (W - sig m W)) = 0 ∧
      Pcubic2 W = Pcubic2 ((1 / 2 : ℝ) • (W + sig m W))
        + 3 * Tsym ((1 / 2 : ℝ) • (W + sig m W)) ((1 / 2 : ℝ) • (W - sig m W)) ((1 / 2 : ℝ) • (W - sig m W)) := by
  set b : CurvOp2 ι := (1 / 2 : ℝ) • (W + sig m W) with hbdef
  set c : CurvOp2 ι := (1 / 2 : ℝ) • (W - sig m W) with hcdef
  have hbc : b + c = W := by rw [hbdef, hcdef]; module
  let bV : RecCurv ι := b
  let cV : RecCurv ι := c
  have hb : sigV m bV = bV := by
    show sig m b = b
    rw [hbdef, LinearMap.map_smul, LinearMap.map_add, sig_sig]
    congr 1
    abel
  have hc : sigV m cV = -cV := by
    show sig m c = -c
    have e : sig m (W - sig m W) = sig m W - W := ContinuousLinearMap.ext fun X => by
      simp only [sig_apply, ContinuousLinearMap.sub_apply, map_sub, cS_cS]
    rw [hcdef, LinearMap.map_smul, e]
    module
  have h12 : ∀ x y z : RecCurv ι, TR x y z = TR y x z := fun x y z => Tsym_12 x y z
  have h23 : ∀ x y z : RecCurv ι, TR x y z = TR x z y := fun x y z => Tsym_23 x y z
  have hσ : ∀ x y z : RecCurv ι, TR (sigV m x) (sigV m y) (sigV m z) = TR x y z := fun x y z => Tsym_sig m x y z
  have hcrit : ∀ x : RecCurv ι, TR (bV + cV) (bV + cV) x = θ * inner ℝ (bV + cV) x := fun x => by
    show Tsym (b + c) (b + c) x = θ * innerOp2 (b + c) x
    rw [hbc]
    exact Tsym_crit hWs hQ x
  have horth : inner ℝ bV cV = 0 := by
    show innerOp2 b c = 0
    have e := innerOp2_sig m b c
    have hb' : sig m b = b := hb
    have hc' : sig m c = -c := hc
    have hneg : innerOp2 b (-c) = -innerOp2 b c := by
      rw [show -c = (-1 : ℝ) • c by module, innerOp2_smul_right]; ring
    rw [hb', hc', hneg] at e
    linarith
  obtain ⟨h1, h2⟩ := HamiltonsCubic.L219Statement.reflection_split_critical TR h12 h23 (sigV m) hσ hb hc hcrit horth
  obtain ⟨h3, h4⟩ := HamiltonsCubic.L219Statement.reflection_split TR h12 h23 (sigV m) hσ hb hc
  have hn : ∀ x : RecCurv ι, ‖x‖ ^ 2 = normSq2 x := RecCurv.norm_sq_eq
  rw [hn] at h1
  rw [hn, hn] at h2
  refine ⟨h1, ?_, ?_, ?_⟩
  · rw [← Tsym_diag]; exact h2
  · rw [← Tsym_diag]; exact h4
  · calc Pcubic2 W = Tsym (b + c) (b + c) (b + c) := by rw [hbc, Tsym_diag]
      _ = Tsym b b b + 3 * Tsym b c c := h3
      _ = Pcubic2 b + 3 * Tsym b c c := by rw [Tsym_diag]

end HamiltonsCubic.L219Op
