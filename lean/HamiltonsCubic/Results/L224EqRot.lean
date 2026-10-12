import Mathlib
import HamiltonsCubic.Results.L224Rot

set_option linter.style.longLine false

/-!
# L224's equality clause on the operators: at `P(W) = Θ_n‖W‖³`, `W` is a rotation of the `(j, k)`-plane of a diagonal maximiser

[findings/second-order.md](../../../findings/second-order.md), Lemma L224: *Equality holds exactly when $W=e^{\varphi\xi}\cdot B$ for a unit
diagonal $B$ attaining [L57]'s equality and an angle $\varphi$*, and step 5: *both $y$ and $x$ lie on it: $(y,x)=\sqrt s\,\hat u\,(\cos\psi,
\sin\psi)$ … $W=e^{\varphi\xi}\cdot W'$ with $2\varphi=\psi$ … Conversely $P$ is $O(n)$-invariant.* The line comes from
[L224Line.lean](L224Line.lean) and [L224LineOdd.lean](L224LineOdd.lean), the rotation formulas from [L224Rot.lean](L224Rot.lean).

* `Dminus_smul`, `nuX_smul`: $D^-_{ty}=tD^-_y$, $\nu_{tx}=t\nu_x$;
* `double_angle`: for $p^2+q^2=1$ there are $c,s$ with $c^2+s^2=1$, $c^2-s^2=p$, $2cs=q$;
* `even_fixed`: a swap-even Weyl operator of character $1$ has a swap-even weight, so the rotation fixes it;
* `assemble`: from the line data, $D+\nu=R\cdot B$ with $B=E+D^-_{\gamma\bar u}$ Weyl of character $1$, $\lVert B\rVert=\lVert D+\nu\rVert$;
* **`L224_eq_even`**, **`L224_eq_odd`**: at $P(D+\nu)=\Theta_n\lVert D+\nu\rVert^3$, $D+\nu=R\cdot B$ for a rotation $R$ of the $(j,k)$-plane
  and a Weyl $B$ of character $1$ with $\lVert B\rVert=\lVert D+\nu\rVert$ and $P(B)=\Theta_n\lVert B\rVert^3$;
* `L224_eq_converse`: $P$ and the norm are invariant under the rotation, so every such $R\cdot B$ attains $\Theta_n$.
-/

namespace HamiltonsCubic.L224EqRot

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.I117S HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.PairIdent HamiltonsCubic.L222Swap
  HamiltonsCubic.OddPart HamiltonsCubic.L224Cubic HamiltonsCubic.FrameOp2 HamiltonsCubic.L222Op HamiltonsCubic.L120Blocks
  HamiltonsCubic.PairNorm HamiltonsCubic.FrameLayer HamiltonsCubic.L224Norm HamiltonsCubic.L224Step4 HamiltonsCubic.L224Bound
  HamiltonsCubic.FamilyLayer HamiltonsCubic.L224Eq HamiltonsCubic.L57Bridge HamiltonsCubic.L224Rank HamiltonsCubic.L57Critical
  HamiltonsCubic.ItemFour HamiltonsCubic.L224Line HamiltonsCubic.L224LineOdd HamiltonsCubic.L224Rot

variable {n : ℕ} {j k : Fin n}

theorem Dminus_smul (t : ℝ) (y : Fin n → ℝ) : coordOp (Dminus j k (t • y)) = t • coordOp (Dminus j k y) := by
  rw [← coordOp_smul']
  congr 1
  ext p q
  simp only [Dminus, vy_smul, Matrix.add_apply, Matrix.smul_apply, Matrix.vecMulVec_apply, Pi.smul_apply, smul_eq_mul]
  ring

theorem nuX_smul (t : ℝ) (x : Fin n → ℝ) : nuX j k (t • x) = t • nuX j k x := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  unfold nuX
  show _ = ((t • sandOp (Smat j k) (diagonal (vy j k x)) (Smat_T j k) (diag_T _) X : skewSub (Fin n)) :
    Matrix (Fin n) (Fin n) ℝ)
  rw [Submodule.coe_smul, sandOp_coe, sandOp_coe, vy_smul, show diagonal (t • vy j k x) = t • diagonal (vy j k x) from
    diagonal_smul _ _]
  simp only [Matrix.smul_mul, Matrix.mul_smul]
  module

/-- **The double angle**, without trigonometry. -/
theorem double_angle {p q : ℝ} (h : p ^ 2 + q ^ 2 = 1) :
    ∃ c s : ℝ, c ^ 2 + s ^ 2 = 1 ∧ c ^ 2 - s ^ 2 = p ∧ 2 * c * s = q := by
  by_cases hp : p = -1
  · have hq : q = 0 := by subst hp; nlinarith
    exact ⟨0, 1, by norm_num, by rw [hp]; norm_num, by rw [hq]; norm_num⟩
  · have hp1 : -1 < p := by
      rcases lt_or_gt_of_ne hp with h1 | h1
      · nlinarith
      · exact h1
    set c := Real.sqrt ((1 + p) / 2) with hc
    have hc0 : 0 < c := Real.sqrt_pos.mpr (by linarith)
    have hc2 : c ^ 2 = (1 + p) / 2 := Real.sq_sqrt (by linarith)
    have hq2 : q ^ 2 = 1 - p ^ 2 := by linarith
    have hp' : 1 + p ≠ 0 := by linarith
    refine ⟨c, q / (2 * c), ?_, ?_, ?_⟩
    · rw [div_pow, mul_pow, hc2, hq2]; field_simp; ring
    · rw [div_pow, mul_pow, hc2, hq2]; field_simp; ring
    · field_simp

/-- **A swap-even Weyl operator of character `1` is fixed by every rotation of the plane.** -/
theorem even_fixed (hjk : j ≠ k) {c s : ℝ} (hcs : c ^ 2 + s ^ 2 = 1) {E : CurvOp2 (Fin n)} (hEW : IsWeyl2 E)
    (hE1 : SignChar (fun _ => 1) E) (hσE : rotR (swapM j k) E = E) : rotR (Rot j k c s) E = E := by
  obtain ⟨e, he, rfl⟩ := (L120Ident.trivial_block_iff E hEW).mp hE1
  rw [← coordOp_eq_restrict he] at hσE ⊢
  have heT : eᵀ = e := by ext a b; rw [Matrix.transpose_apply, he.symm]
  have hsT : (Matrix.of fun p q => e (Equiv.swap j k p) (Equiv.swap j k q))ᵀ
      = Matrix.of fun p q => e (Equiv.swap j k p) (Equiv.swap j k q) := by
    ext p q; simp only [Matrix.transpose_apply, Matrix.of_apply]; exact he.symm _ _
  rw [rotR_swap_coordOp j k e heT] at hσE
  refine rot_even hjk hcs e heT fun a haj hak => ?_
  have := coordOp_weight_eq hsT heT hσE (Ne.symm haj)
  simp only [Matrix.of_apply, Equiv.swap_apply_left, Equiv.swap_apply_of_ne_of_ne haj hak] at this
  exact this.symm

/-- **The assembly**: from the line data, `D + ν = R · B` with `B = E + D⁻_{γū}`. -/
theorem assemble (hjk : j ≠ k) {D ν : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hD : SignChar (fun _ => 1) D)
    {y x : Fin n → ℝ} (hM : (1 / 2 : ℝ) • (D - rotR (swapM j k) D) = coordOp (Dminus j k y)) (hνx : ν = nuX j k x)
    (hcase : (y = 0 ∧ x = 0) ∨ ∃ ub : Fin n → ℝ, ub j = 0 ∧ ub k = 0 ∧ ∑ i, ub i = 0 ∧ 0 < ∑ i, ub i ^ 2 ∧
      (∀ l, y l = ((∑ i, ub i * y i) / (∑ i, ub i ^ 2)) * ub l) ∧
      (∀ l, x l = ((∑ i, ub i * x i) / (∑ i, ub i ^ 2)) * ub l)) :
    ∃ c s : ℝ, c ^ 2 + s ^ 2 = 1 ∧ ∃ B : CurvOp2 (Fin n), IsWeyl2 B ∧ SignChar (fun _ => 1) B ∧
      D + ν = rotR (Rot j k c s) B := by
  have hσ := swapM_orth j k
  have hσDW : IsWeyl2 (rotR (swapM j k) D) := rotR_isWeyl2 hσ hDW
  have hσD1 : SignChar (fun _ => 1) (rotR (swapM j k) D) := signChar_rotR_swap j k hD fun _ _ => rfl
  set E : CurvOp2 (Fin n) := (1 / 2 : ℝ) • (D + rotR (swapM j k) D) with hEdef
  have hEW : IsWeyl2 E := isWeyl2_smul _ (isWeyl2_add hDW hσDW)
  have hE1 : SignChar (fun _ => 1) E := signChar_smul (signChar_add hD hσD1) _
  have hσσ : rotR (swapM j k) (rotR (swapM j k) D) = D := by
    rw [L219GenOps.rotR_comp, swapM_sq, L219GenOps.rotR_one]
  have hσE : rotR (swapM j k) E = E := by
    rw [hEdef, LinearMap.map_smul, LinearMap.map_add, hσσ]; module
  have hsplit : D + ν = E + coordOp (Dminus j k y) + nuX j k x := by
    rw [← hM, hνx, hEdef]; module
  rcases hcase with ⟨rfl, rfl⟩ | ⟨ub, hubj, hubk, hubs, hA, hy, hx⟩
  · refine ⟨1, 0, by norm_num, E, hEW, hE1, ?_⟩
    rw [zero_branch hjk hM hνx, even_fixed hjk (by norm_num) hEW hE1 hσE]
  set A := ∑ i, ub i ^ 2 with hAdef
  set α := (∑ i, ub i * y i) / A with hα
  set β := (∑ i, ub i * x i) / A with hβ
  have hyα : y = α • ub := funext fun l => by rw [hy l]; rfl
  have hxβ : x = β • ub := funext fun l => by rw [hx l]; rfl
  have hvub : vy j k ub = ub := vy_of_zero ub hubj hubk
  by_cases h0 : α ^ 2 + β ^ 2 = 0
  · have hα0 : α = 0 := by nlinarith
    have hβ0 : β = 0 := by nlinarith
    refine ⟨1, 0, by norm_num, E, hEW, hE1, ?_⟩
    have hy0 : y = 0 := by rw [hyα, hα0, zero_smul]
    have hx0 : x = 0 := by rw [hxβ, hβ0, zero_smul]
    rw [hy0] at hM
    rw [hx0] at hνx
    rw [zero_branch hjk hM hνx, even_fixed hjk (by norm_num) hEW hE1 hσE]
  · have hpos : 0 < α ^ 2 + β ^ 2 := lt_of_le_of_ne (by positivity) (Ne.symm h0)
    set γ := Real.sqrt (α ^ 2 + β ^ 2) with hγ
    have hγ0 : 0 < γ := Real.sqrt_pos.mpr hpos
    have hγ2 : γ ^ 2 = α ^ 2 + β ^ 2 := Real.sq_sqrt hpos.le
    have hpq : (α / γ) ^ 2 + (β / γ) ^ 2 = 1 := by
      have e : (α / γ) ^ 2 + (β / γ) ^ 2 = (α ^ 2 + β ^ 2) / γ ^ 2 := by field_simp
      rw [e, hγ2]; exact div_self hpos.ne'
    obtain ⟨c, s, hcs, hc, hs⟩ := double_angle hpq
    have hs' : ∑ c, vy j k (γ • ub) c = 0 := by
      rw [vy_smul, hvub]; simp only [Pi.smul_apply, smul_eq_mul, ← Finset.mul_sum, hubs, mul_zero]
    refine ⟨c, s, hcs, E + coordOp (Dminus j k (γ • ub)), isWeyl2_add hEW (Dminus_weyl hjk _ hs'),
      signChar_add hE1 (Dminus_charOne hjk _ hs'), ?_⟩
    rw [LinearMap.map_add, even_fixed hjk hcs hEW hE1 hσE, rot_Dminus hjk hcs, hsplit, hyα, hxβ,
      Dminus_smul, Dminus_smul, nuX_smul, nuX_smul, hc, hs]
    have hγne : γ ≠ 0 := hγ0.ne'
    have e1 : α = α / γ * γ := by field_simp
    have e2 : β = β / γ * γ := by field_simp
    rw [show α • coordOp (Dminus j k ub) = (α / γ * γ) • coordOp (Dminus j k ub) by rw [← e1],
      show β • nuX j k ub = (β / γ * γ) • nuX j k ub by rw [← e2]]
    module

/-- **L224's equality clause at even `n`.** Stated with `θ₀(n)`, it carries no parity hypothesis. At odd `n`, `θ₀(n) > Θ_n`
and its hypothesis forces `D + ν = 0`, so `L224_eq_odd` is the odd case. -/
theorem L224_eq_even (hn : 4 ≤ n) (hjk : j ≠ k) {D ν : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hνW : IsWeyl2 ν)
    (hD : SignChar (fun _ => 1) D) (hν : SignChar (setChar {j, k}) ν)
    (heq : Pcubic2 (D + ν) = Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / (n : ℝ) * Real.sqrt (normSq2 (D + ν)) ^ 3) :
    ∃ c s : ℝ, c ^ 2 + s ^ 2 = 1 ∧ ∃ B : CurvOp2 (Fin n), IsWeyl2 B ∧ SignChar (fun _ => 1) B ∧
      normSq2 B = normSq2 (D + ν) ∧
      Pcubic2 B = Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / (n : ℝ) * Real.sqrt (normSq2 B) ^ 3 ∧
      D + ν = rotR (Rot j k c s) B := by
  obtain ⟨y, x, -, -, -, -, -, -, hM, hνx, hcase⟩ := L224_line_even hn hjk hDW hνW hD hν heq
  have hcase' : (y = 0 ∧ x = 0) ∨ ∃ ub : Fin n → ℝ, ub j = 0 ∧ ub k = 0 ∧ ∑ i, ub i = 0 ∧ 0 < ∑ i, ub i ^ 2 ∧
      (∀ l, y l = ((∑ i, ub i * y i) / (∑ i, ub i ^ 2)) * ub l) ∧
      (∀ l, x l = ((∑ i, ub i * x i) / (∑ i, ub i ^ 2)) * ub l) := by
    rcases hcase with h | ⟨-, h⟩
    · exact Or.inl h
    · exact Or.inr h
  obtain ⟨c, s, hcs, B, hBW, hB1, hWB⟩ := assemble hjk hDW hD hM hνx hcase'
  have hR := Rot_orth hjk hcs
  have hN : normSq2 B = normSq2 (D + ν) := by rw [hWB, normSq2_rotR hR hBW]
  refine ⟨c, s, hcs, B, hBW, hB1, hN, ?_, hWB⟩
  rw [hN, ← heq, hWB, Pcubic2_rotR hR hBW]

/-- **L224's equality clause at odd `n`.** -/
theorem L224_eq_odd (hn : 5 ≤ n) (hodd : ¬ Even n) (hjk : j ≠ k) {D ν : CurvOp2 (Fin n)} (hDW : IsWeyl2 D)
    (hνW : IsWeyl2 ν) (hD : SignChar (fun _ => 1) D) (hν : SignChar (setChar {j, k}) ν)
    (heq : Pcubic2 (D + ν) = Real.sqrt (thetaOddSq (n : ℝ)) * Real.sqrt (normSq2 (D + ν)) ^ 3) :
    ∃ c s : ℝ, c ^ 2 + s ^ 2 = 1 ∧ ∃ B : CurvOp2 (Fin n), IsWeyl2 B ∧ SignChar (fun _ => 1) B ∧
      normSq2 B = normSq2 (D + ν) ∧ Pcubic2 B = Real.sqrt (thetaOddSq (n : ℝ)) * Real.sqrt (normSq2 B) ^ 3 ∧
      D + ν = rotR (Rot j k c s) B := by
  obtain ⟨y, x, -, -, -, -, -, -, hM, hνx, hcase⟩ := L224_line_odd hn hodd hjk hDW hνW hD hν heq
  obtain ⟨c, s, hcs, B, hBW, hB1, hWB⟩ := assemble hjk hDW hD hM hνx hcase
  have hR := Rot_orth hjk hcs
  have hN : normSq2 B = normSq2 (D + ν) := by rw [hWB, normSq2_rotR hR hBW]
  refine ⟨c, s, hcs, B, hBW, hB1, hN, ?_, hWB⟩
  rw [hN, ← heq, hWB, Pcubic2_rotR hR hBW]

/-- **The converse**: a rotation of the plane keeps `P` and the norm, so `R · B` attains whatever `B` attains. -/
theorem L224_eq_converse (hjk : j ≠ k) {c s : ℝ} (hcs : c ^ 2 + s ^ 2 = 1) {B : CurvOp2 (Fin n)} (hBW : IsWeyl2 B)
    {Θ : ℝ} (hB : Pcubic2 B = Θ * Real.sqrt (normSq2 B) ^ 3) :
    Pcubic2 (rotR (Rot j k c s) B) = Θ * Real.sqrt (normSq2 (rotR (Rot j k c s) B)) ^ 3 := by
  have hR := Rot_orth hjk hcs
  rw [Pcubic2_rotR hR hBW, normSq2_rotR hR hBW, hB]

end HamiltonsCubic.L224EqRot
