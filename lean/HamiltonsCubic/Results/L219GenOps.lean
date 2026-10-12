import Mathlib
import HamiltonsCubic.Results.L219Gen
import HamiltonsCubic.Results.L219Prod
import HamiltonsCubic.Results.WeylMaximiser

set_option linter.style.longLine false

/-!
# `Q` commutes with every frame change on `𝒲ₙ`, and L219's operator identities at every unit `u`

[findings/second-order.md](../../../findings/second-order.md), Lemma L219: *at $Q(W)=\theta W$, $b\circ b+c\circ c=\theta b$
and $2\,b\circ c=\theta c$*, from $\sigma(x\circ y)=\sigma x\circ\sigma y$. [L219Prod.lean](L219Prod.lean) proves them at
coordinate reflections. At a general orthogonal $U$ the equivariance of $Q$ comes by duality:

* `rotR_comp`, `rotR_one`: the action composes, so `rotR U` and `rotR Uᵀ` are inverse at an orthogonal $U$;
* **`Qop2_rotR`**: $Q(UVU^{\mathsf T})=U\,Q(V)\,U^{\mathsf T}$ at a Weyl $V$, since $\langle Z,Q(V)\rangle=T(V,V,Z)$ at self-adjoint $V$ (`Tsym_lin`,
  `Pcubic2Lin_selfAdjoint`), $T$ and the pairing are invariant on Weyl operators ([FrameOp2.lean](FrameOp2.lean)), and
  $Q$ keeps $\mathcal W_n$ (`isWeyl2_Qop2`);
* `foxProd2_rotR`: polarised, $\sigma(x\circ y)=\sigma x\circ\sigma y$ on Weyl pairs, $\sigma$ any frame change;
* **`L219_ops_gen`**: at a Weyl $W$ with $Q(W)=\theta W$ and every unit $u$, $Q(b)+Q(c)=\theta b$ and $2\,b\circ c=\theta c$.
-/

namespace HamiltonsCubic.L219GenOps

open Matrix HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.FrameLayer HamiltonsCubic.L214Op
  HamiltonsCubic.FrameOp2 HamiltonsCubic.L219Gen HamiltonsCubic.L219Prod

variable {n : ℕ}

theorem rotR_comp (U U' : Matrix (Fin n) (Fin n) ℝ) (V : CurvOp2 (Fin n)) :
    rotR U (rotR U' V) = rotR (U * U') V := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  rw [rotR_coe, rotR_coe, rotR_coe]
  have e : cU U' (cU U X) = cU (U * U') X := by
    apply Subtype.ext
    rw [cU_coe, cU_coe, cU_coe, transpose_mul]
    simp only [Matrix.mul_assoc]
  rw [e, transpose_mul]
  simp only [Matrix.mul_assoc]

theorem rotR_one (V : CurvOp2 (Fin n)) : rotR 1 V = V := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  rw [rotR_coe]
  have e : cU (1 : Matrix (Fin n) (Fin n) ℝ) X = X := Subtype.ext (by rw [cU_coe]; simp)
  rw [e]; simp

theorem rotR_inv {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) (V : CurvOp2 (Fin n)) : rotR U (rotR Uᵀ V) = V := by
  rw [rotR_comp, hU.2, rotR_one]

/-- **`Q` commutes with every frame change, on Weyl operators.** -/
theorem Qop2_rotR {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) {V : CurvOp2 (Fin n)} (hV : IsWeyl2 V) :
    Qop2 (rotR U V) = rotR U (Qop2 V) := by
  have hrV := rotR_isWeyl2 hU hV
  have hA := isWeyl2_Qop2 hrV
  have hB := rotR_isWeyl2 hU (isWeyl2_Qop2 hV)
  have hUt := isOrth_transpose hU
  -- `⟨Z, Q(R)⟩ = T(R, R, Z)` at self-adjoint `R`
  have dual : ∀ R Z : CurvOp2 (Fin n), IsSelfAdjoint2 R → innerOp2 Z (Qop2 R) = Tsym R R Z := fun R Z hR => by
    have h1 := Tsym_lin R Z
    rw [Pcubic2Lin_selfAdjoint hR] at h1
    linarith
  have key : ∀ Z : CurvOp2 (Fin n), IsWeyl2 Z → innerOp2 Z (Qop2 (rotR U V)) = innerOp2 Z (rotR U (Qop2 V)) := by
    intro Z hZ
    have hZ' := rotR_isWeyl2 hUt hZ
    have eZ : Z = rotR U (rotR Uᵀ Z) := (rotR_inv hU Z).symm
    rw [dual _ _ hrV.isSelfAdjoint2]
    conv_lhs => rw [eZ]
    rw [Tsym_rotR hU hV hV hZ', ← dual _ _ hV.isSelfAdjoint2]
    conv_rhs => rw [eZ]
    rw [innerOp2_rotR hU hZ' (isWeyl2_Qop2 hV)]
  have hD : IsWeyl2 (Qop2 (rotR U V) - rotR U (Qop2 V)) := by
    have e : Qop2 (rotR U V) - rotR U (Qop2 V) = Qop2 (rotR U V) + (-1 : ℝ) • rotR U (Qop2 V) := by module
    rw [e]; exact isWeyl2_add hA (isWeyl2_smul _ hB)
  have h0 := key _ hD
  have hsub : innerOp2 (Qop2 (rotR U V) - rotR U (Qop2 V)) (Qop2 (rotR U V) - rotR U (Qop2 V)) = 0 := by
    have e : Qop2 (rotR U V) - rotR U (Qop2 V) = Qop2 (rotR U V) + (-1 : ℝ) • rotR U (Qop2 V) := by module
    rw [e, innerOp2_add_right, innerOp2_smul_right]
    rw [e] at h0
    linarith
  have := normSq2_eq_zero hsub
  have e2 : Qop2 (rotR U V) = (Qop2 (rotR U V) - rotR U (Qop2 V)) + rotR U (Qop2 V) := by abel
  rw [e2, this]
  module

/-- **The Fox product commutes with every frame change on Weyl pairs**, `σ(x∘y) = σx∘σy`, by polarising `Qop2_rotR`. -/
theorem foxProd2_rotR {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) {X Y : CurvOp2 (Fin n)} (hX : IsWeyl2 X)
    (hY : IsWeyl2 Y) : foxProd2 (rotR U X) (rotR U Y) = rotR U (foxProd2 X Y) := by
  unfold foxProd2
  have hs : ∀ A B : CurvOp2 (Fin n), rotR U (A - B) = rotR U A - rotR U B := fun A B => by
    have e : A - B = A + (-1 : ℝ) • B := by module
    rw [e, LinearMap.map_add, LinearMap.map_smul]; module
  rw [← map_add, Qop2_rotR hU (isWeyl2_add hX hY), Qop2_rotR hU hX, Qop2_rotR hU hY, LinearMap.map_smul, hs, hs]

/-- **L219's operator identities at every unit `u`.** -/
theorem L219_ops_gen (u : Fin n → ℝ) (hu : ∑ a, u a ^ 2 = 1) (W : CurvOp2 (Fin n)) (hW : IsWeyl2 W) {θ : ℝ}
    (hQ : Qop2 W = θ • W) :
    Qop2 ((1 / 2 : ℝ) • (W + rotR (Su u) W)) + Qop2 ((1 / 2 : ℝ) • (W - rotR (Su u) W))
        = θ • ((1 / 2 : ℝ) • (W + rotR (Su u) W)) ∧
      (2 : ℝ) • foxProd2 ((1 / 2 : ℝ) • (W + rotR (Su u) W)) ((1 / 2 : ℝ) • (W - rotR (Su u) W))
        = θ • ((1 / 2 : ℝ) • (W - rotR (Su u) W)) := by
  set b : CurvOp2 (Fin n) := (1 / 2 : ℝ) • (W + rotR (Su u) W) with hbdef
  set c : CurvOp2 (Fin n) := (1 / 2 : ℝ) • (W - rotR (Su u) W) with hcdef
  have hU := Su_orth u hu
  have hbc : b + c = W := by rw [hbdef, hcdef]; module
  have hbmc : b - c = rotR (Su u) W := by rw [hbdef, hcdef]; module
  have hσ : Qop2 (rotR (Su u) W) = θ • rotR (Su u) W := by rw [Qop2_rotR hU hW, hQ, LinearMap.map_smul]
  have E1 : θ • (b + c) = Qop2 b + Qop2 c + (2 : ℝ) • foxProd2 b c := by rw [← L219Prod.Qop2_add, hbc, hQ]
  have E2 : θ • (b - c) = Qop2 b + Qop2 c - (2 : ℝ) • foxProd2 b c := by rw [← L219Prod.Qop2_sub, hbmc, hσ]
  refine ⟨?_, ?_⟩
  · calc Qop2 b + Qop2 c
        = (1 / 2 : ℝ) • ((Qop2 b + Qop2 c + (2 : ℝ) • foxProd2 b c) + (Qop2 b + Qop2 c - (2 : ℝ) • foxProd2 b c)) := by
          module
      _ = (1 / 2 : ℝ) • (θ • (b + c) + θ • (b - c)) := by rw [← E1, ← E2]
      _ = θ • b := by module
  · calc (2 : ℝ) • foxProd2 b c
        = (1 / 2 : ℝ) • ((Qop2 b + Qop2 c + (2 : ℝ) • foxProd2 b c) - (Qop2 b + Qop2 c - (2 : ℝ) • foxProd2 b c)) := by
          module
      _ = (1 / 2 : ℝ) • (θ • (b + c) - θ • (b - c)) := by rw [← E1, ← E2]
      _ = θ • c := by module

end HamiltonsCubic.L219GenOps
