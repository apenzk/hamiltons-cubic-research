import Mathlib
import HamiltonsCubic.Results.FrameOp2
import HamiltonsCubic.Results.L219Statement
import HamiltonsCubic.Results.L24Weyl
import HamiltonsCubic.Results.SphereCurve

set_option linter.style.longLine false

/-!
# L219 at every unit vector: the reflection split for $\sigma_u$, $u$ arbitrary

[findings/second-order.md](../../../findings/second-order.md), Lemma L219 is stated for the reflection $\sigma_u$ in
$u^\perp$ at every unit $u\in\mathbb R^n$. [L219Op.lean](L219Op.lean) proves it at coordinate reflections. Here
$\sigma_u$ is `rotR (Su u)`, $S_u=I-2uu^{\mathsf T}$, and [FrameOp2.lean](FrameOp2.lean)'s invariances of $T$ and the pairing
on Weyl operators replace the coordinate argument:

* `Su_orth`, `Su_symm`, `Su_sq`: $S_u$ is a symmetric orthogonal involution at unit $u$; `rotR_Su_Su`, so $\sigma_u^2=1$;
* **`L219_split_gen`**: at every Weyl $W$, critical or not, $\langle b,c\rangle=0$, $T(b,b,c)=0$, $P(c)=0$ and $P(W)=P(b)+3T(b,c,c)$;
* **`L219_gen`**: at a Weyl $W$ with $Q(W)=\theta W$ and $b,c=\tfrac12(W\pm\sigma_uW)$: $\langle b,c\rangle=0$, $T(b,b,c)=0$,
  $P(c)=0$, $P(W)=P(b)+3T(b,c,c)$, $T(b,c,c)=\tfrac\theta2\lVert c\rVert^2$ and $P(b)=\theta(\lVert b\rVert^2-\tfrac12\lVert c\rVert^2)$;
* `odd_mass_gen`: at a unit Weyl global maximiser with $\theta>0$, $\lVert c_u\rVert^2\le\tfrac34$ at every unit $u$.
-/

namespace HamiltonsCubic.L219Gen

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.FrameLayer
  HamiltonsCubic.L214Op HamiltonsCubic.FrameOp2

variable {n : ℕ}

/-- **The reflection in `u⊥`**, `S_u = I − 2uuᵀ`. -/
noncomputable def Su (u : Fin n → ℝ) : Matrix (Fin n) (Fin n) ℝ := 1 - (2 : ℝ) • Matrix.vecMulVec u u

theorem Su_symm (u : Fin n → ℝ) : (Su u)ᵀ = Su u := by
  unfold Su
  rw [transpose_sub, transpose_one, transpose_smul]
  congr 2
  ext i j
  simp [Matrix.vecMulVec_apply, mul_comm]

theorem Su_sq (u : Fin n → ℝ) (hu : ∑ a, u a ^ 2 = 1) : Su u * Su u = 1 := by
  have hP : Matrix.vecMulVec u u * Matrix.vecMulVec u u = Matrix.vecMulVec u u := by
    ext i j
    simp only [Matrix.mul_apply, Matrix.vecMulVec_apply]
    calc ∑ k, u i * u k * (u k * u j) = u i * u j * ∑ k, u k ^ 2 := by
          rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun k _ => by ring
      _ = u i * u j := by rw [hu, mul_one]
  unfold Su
  rw [sub_mul, mul_sub, mul_sub, Matrix.one_mul, Matrix.mul_one, Matrix.one_mul, Matrix.smul_mul, Matrix.mul_smul,
    smul_smul, hP]
  module

theorem Su_orth (u : Fin n → ℝ) (hu : ∑ a, u a ^ 2 = 1) : IsOrth (Su u) := by
  refine ⟨?_, ?_⟩ <;> rw [Su_symm] <;> exact Su_sq u hu

theorem rotR_Su_Su (u : Fin n → ℝ) (hu : ∑ a, u a ^ 2 = 1) (V : CurvOp2 (Fin n)) :
    rotR (Su u) (rotR (Su u) V) = V := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  rw [rotR_coe]
  have hin : cU (Su u) X = cU (Su u) X := rfl
  have e1 : ((rotR (Su u) V (cU (Su u) X) : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)
      = Su u * ((V (cU (Su u) (cU (Su u) X)) : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) * (Su u)ᵀ := rotR_coe _ _ _
  have hcc : cU (Su u) (cU (Su u) X) = X := by
    apply Subtype.ext
    rw [cU_coe, cU_coe, Su_symm]
    calc Su u * (Su u * (X : Matrix (Fin n) (Fin n) ℝ) * Su u) * Su u
        = (Su u * Su u) * (X : Matrix (Fin n) (Fin n) ℝ) * (Su u * Su u) := by simp only [Matrix.mul_assoc]
      _ = X := by rw [Su_sq u hu, Matrix.one_mul, Matrix.mul_one]
  rw [e1, hcc, Su_symm]
  calc Su u * (Su u * ((V X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) * Su u) * Su u
      = (Su u * Su u) * ((V X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) * (Su u * Su u) := by
        simp only [Matrix.mul_assoc]
    _ = _ := by rw [Su_sq u hu, Matrix.one_mul, Matrix.mul_one]

/-- **L219's parity clauses at every unit `u`, at every Weyl `W`**: `⟨b,c⟩ = 0`, `T(b,b,c) = 0`, `P(c) = 0` and
`P(W) = P(b) + 3T(b,c,c)`, with no criticality hypothesis. -/
theorem L219_split_gen (u : Fin n → ℝ) (hu : ∑ a, u a ^ 2 = 1) (W : CurvOp2 (Fin n)) (hW : IsWeyl2 W) :
    let b := (1 / 2 : ℝ) • (W + rotR (Su u) W)
    let c := (1 / 2 : ℝ) • (W - rotR (Su u) W)
    innerOp2 b c = 0 ∧ Tsym b b c = 0 ∧ Pcubic2 c = 0 ∧ Pcubic2 W = Pcubic2 b + 3 * Tsym b c c := by
  intro b c
  have hU := Su_orth u hu
  have hσ : IsWeyl2 (rotR (Su u) W) := rotR_isWeyl2 hU hW
  have hb : IsWeyl2 b := isWeyl2_smul _ (isWeyl2_add hW hσ)
  have hc : IsWeyl2 c := by
    have e : W - rotR (Su u) W = W + (-1 : ℝ) • rotR (Su u) W := by module
    show IsWeyl2 ((1 / 2 : ℝ) • (W - rotR (Su u) W))
    rw [e]; exact isWeyl2_smul _ (isWeyl2_add hW (isWeyl2_smul _ hσ))
  have hsb : rotR (Su u) b = b := by
    show rotR (Su u) ((1 / 2 : ℝ) • (W + rotR (Su u) W)) = (1 / 2 : ℝ) • (W + rotR (Su u) W)
    rw [LinearMap.map_smul, LinearMap.map_add, rotR_Su_Su u hu]; congr 1; abel
  have hsc : rotR (Su u) c = -c := by
    show rotR (Su u) ((1 / 2 : ℝ) • (W - rotR (Su u) W)) = -((1 / 2 : ℝ) • (W - rotR (Su u) W))
    have e : rotR (Su u) (W - rotR (Su u) W) = rotR (Su u) W - W := by
      rw [show W - rotR (Su u) W = W + (-1 : ℝ) • rotR (Su u) W by module, LinearMap.map_add, LinearMap.map_smul,
        rotR_Su_Su u hu]
      module
    rw [LinearMap.map_smul, e]; module
  have hbc : b + c = W := by show (1 / 2 : ℝ) • (W + rotR (Su u) W) + (1 / 2 : ℝ) • (W - rotR (Su u) W) = W; module
  have tneg : ∀ x y z : CurvOp2 (Fin n), Tsym x y (-z) = -Tsym x y z := fun x y z => by
    rw [show -z = (-1 : ℝ) • z by module, Tsym_smul_right]; ring
  have tneg1 : ∀ x y z : CurvOp2 (Fin n), Tsym (-x) y z = -Tsym x y z := fun x y z => by
    rw [show -x = (-1 : ℝ) • x by module, Tsym_smul_left]; ring
  have tneg2 : ∀ x y z : CurvOp2 (Fin n), Tsym x (-y) z = -Tsym x y z := fun x y z => by
    rw [show -y = (-1 : ℝ) • y by module, Tsym_smul_mid]; ring
  -- parity
  have hbbc : Tsym b b c = 0 := by
    have e := Tsym_rotR hU hb hb hc
    rw [hsb, hsc, tneg] at e; linarith
  have hccc : Tsym c c c = 0 := by
    have e := Tsym_rotR hU hc hc hc
    rw [hsc, tneg, tneg1, tneg2] at e; linarith
  have horth : innerOp2 b c = 0 := by
    have e := innerOp2_rotR hU hb hc
    rw [hsb, hsc, show -c = (-1 : ℝ) • c by module, innerOp2_smul_right] at e; linarith
  -- symmetries of the expansion
  have s1 := Tsym_12 b c b; have s2 := Tsym_23 b b c; have s3 := Tsym_12 c b c; have s4 := Tsym_23 c b c
  have s5 := Tsym_12 c b b; have s6 := Tsym_23 b c b; have s7 := Tsym_23 c c b; have s8 := Tsym_12 b c c
  -- the split
  have hsplit : Pcubic2 W = Pcubic2 b + 3 * Tsym b c c := by
    rw [← hbc, ← Tsym_diag, ← Tsym_diag]
    simp only [Tsym_add_left, Tsym_add_mid, Tsym_add_right]
    linarith
  exact ⟨horth, hbbc, by rw [← Tsym_diag]; exact hccc, hsplit⟩

/-- **L219 at every unit `u`.** -/
theorem L219_gen (u : Fin n → ℝ) (hu : ∑ a, u a ^ 2 = 1) (W : CurvOp2 (Fin n)) (hW : IsWeyl2 W) {θ : ℝ}
    (hQ : Qop2 W = θ • W) :
    let b := (1 / 2 : ℝ) • (W + rotR (Su u) W)
    let c := (1 / 2 : ℝ) • (W - rotR (Su u) W)
    innerOp2 b c = 0 ∧ Tsym b b c = 0 ∧ Pcubic2 c = 0 ∧ Pcubic2 W = Pcubic2 b + 3 * Tsym b c c ∧
      Tsym b c c = θ / 2 * normSq2 c ∧ Pcubic2 b = θ * (normSq2 b - normSq2 c / 2) := by
  intro b c
  obtain ⟨horth, hbbc, hccc, hsplit⟩ := L219_split_gen u hu W hW
  have hccc' : Tsym c c c = 0 := by rw [Tsym_diag]; exact hccc
  have s1 := Tsym_12 b c b; have s2 := Tsym_23 b b c; have s3 := Tsym_12 c b c; have s4 := Tsym_23 c b c
  have s5 := Tsym_12 c b b; have s6 := Tsym_23 b c b; have s7 := Tsym_23 c c b; have s8 := Tsym_12 b c c
  have hbc : b + c = W := by show (1 / 2 : ℝ) • (W + rotR (Su u) W) + (1 / 2 : ℝ) • (W - rotR (Su u) W) = W; module
  -- criticality against c and b
  have hWs := hW.isSelfAdjoint2
  have kc := Tsym_crit hWs hQ c
  have kb := Tsym_crit hWs hQ b
  rw [← hbc] at kc kb
  simp only [Tsym_add_left, Tsym_add_mid, innerOp2_add_left] at kc kb
  have hcb : innerOp2 c b = 0 := by rw [innerOp2_comm]; exact horth
  have hTbcc : Tsym b c c = θ / 2 * normSq2 c := by
    have : innerOp2 c c = normSq2 c := rfl
    rw [horth, this] at kc
    linarith
  refine ⟨horth, hbbc, hccc, hsplit, hTbcc, ?_⟩
  have : innerOp2 b b = normSq2 b := rfl
  rw [hcb, this] at kb
  rw [← Tsym_diag]
  linarith

/-- **L219's bound at a maximiser, at every unit `u`**: `‖c_u‖² ≤ ¾`. -/
theorem odd_mass_gen (u : Fin n → ℝ) (hu : ∑ a, u a ^ 2 = 1) (W : CurvOp2 (Fin n)) (hW : IsWeyl2 W)
    (hW1 : normSq2 W = 1) {θ : ℝ} (hQ : Qop2 W = θ • W) (hθ : 0 < θ)
    (hmax : ∀ R : CurvOp2 (Fin n), IsWeyl2 R → normSq2 R = 1 → Pcubic2 R ≤ Pcubic2 W) :
    normSq2 ((1 / 2 : ℝ) • (W - rotR (Su u) W)) ≤ 3 / 4 := by
  obtain ⟨horth, -, -, hPW, -, hPb⟩ := L219_gen u hu W hW hQ
  set b : CurvOp2 (Fin n) := (1 / 2 : ℝ) • (W + rotR (Su u) W) with hbdef
  set c : CurvOp2 (Fin n) := (1 / 2 : ℝ) • (W - rotR (Su u) W) with hcdef
  have hU := Su_orth u hu
  have hbW : IsWeyl2 b := isWeyl2_smul _ (isWeyl2_add hW (rotR_isWeyl2 hU hW))
  have hbc : b + c = W := by rw [hbdef, hcdef]; module
  have hnorm : normSq2 b + normSq2 c = 1 := by
    have e : normSq2 (b + c) = normSq2 b + normSq2 c := by
      unfold normSq2
      rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, horth, innerOp2_comm c b, horth]
      ring
    rw [← e, hbc, hW1]
  have hPWθ : Pcubic2 W = θ := by
    rw [← Tsym_diag, Tsym_crit hW.isSelfAdjoint2 hQ, show innerOp2 W W = normSq2 W from rfl, hW1, mul_one]
  have hb0 : 0 < normSq2 b := by
    rcases (normSq2_nonneg b).lt_or_eq with h | h
    · exact h
    · exfalso
      have hb : b = 0 := normSq2_eq_zero h.symm
      rw [hb] at hPW
      have h0 : Pcubic2 (0 : CurvOp2 (Fin n)) = 0 := by
        have := Pcubic2_smul 0 (0 : CurvOp2 (Fin n))
        rw [show (0 : ℝ) • (0 : CurvOp2 (Fin n)) = 0 by module] at this
        rw [this]; ring
      have hT0 : Tsym (0 : CurvOp2 (Fin n)) c c = 0 := by
        have := Tsym_smul_left 0 (0 : CurvOp2 (Fin n)) c c
        rw [show (0 : ℝ) • (0 : CurvOp2 (Fin n)) = 0 by module] at this
        rw [this]; ring
      rw [h0, hT0] at hPW
      linarith
  set t := normSq2 b with htdef
  set α : ℝ := -(Real.sqrt t)⁻¹ with hαdef
  have hst : 0 < Real.sqrt t := Real.sqrt_pos.mpr hb0
  have hs2 : Real.sqrt t ^ 2 = t := Real.sq_sqrt hb0.le
  have hα : α < 0 := by rw [hαdef]; exact neg_neg_of_pos (inv_pos.mpr hst)
  have hαt : α ^ 2 * t = 1 := by rw [hαdef, neg_sq, inv_pow, hs2, inv_mul_cancel₀ hb0.ne']
  have hV := hmax (α • b) (isWeyl2_smul α hbW) (by rw [normSq2_smul, hαt])
  rw [Pcubic2_smul, hPb, hPWθ] at hV
  have hc2 : normSq2 c = 1 - t := by linarith
  rw [hc2] at hV
  have hplane : θ * (3 * α - α ^ 3) / 2 ≤ θ := by
    have e : α ^ 3 * (θ * (t - (1 - t) / 2)) = θ * (3 * α - α ^ 3) / 2 := by
      have h3 : α ^ 3 * t = α := by
        calc α ^ 3 * t = α * (α ^ 2 * t) := by ring
          _ = α := by rw [hαt, mul_one]
      linear_combination (3 / 2 * θ) * h3
    linarith
  have ht := HamiltonsCubic.L219Statement.odd_mass_le θ t α hθ hα hαt hplane
  linarith

end HamiltonsCubic.L219Gen
