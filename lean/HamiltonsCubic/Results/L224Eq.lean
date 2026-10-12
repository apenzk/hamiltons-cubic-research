import Mathlib
import HamiltonsCubic.Results.L224Bound
import HamiltonsCubic.Results.CurvOpInner

set_option linter.style.longLine false

/-!
# L224 step 5's first half: at equality every inequality of step 4 is tight, and `λ > 0` when `s > 0`

[findings/second-order.md](../../../findings/second-order.md), Lemma L224, step 5: *If $P(W)=\Theta_n$ then $P(W')=\Theta_n$,
$q_E(y)=\lambda\lVert y\rVert^2$ and $q_E(x)=\lambda\lVert x\rVert^2$. At $s=0$, $W=E$ is diagonal. At $s>0$, $\lVert E\rVert<1$ gives
$P(E)\le\Theta_n\lVert E\rVert^3<\Theta_n$, so $\lambda>0$.* The constant enters through one hypothesis, L57's bound on diagonal
operators with a positive constant $\Theta$, so both parities of [L224Bound.lean](L224Bound.lean) instantiate it.

* **`L224_eq_tight`**: at $P(D+\nu)=\Theta\lVert D+\nu\rVert^3$, either $y=x=0$ (so $D+\nu=E$), or a maximiser $z_*$ of $q_E$ on the unit
  sphere of the plane has $\lambda=q_E(z_*)>0$, $q_E(y)=\lambda\lVert y\rVert^2$, $q_E(x)=\lambda\lVert x\rVert^2$, and
  $W'=E+D^-_{\sqrt s z_*}$ attains $P(W')=\Theta\lVert W'\rVert^3$, the second branch carrying $s>0$;
* `theta0_pos`, `L57_even`, `thetaOdd_pos`, `L57_odd`: the two hypotheses on $\Theta$ hold for $\theta_0(n)$ at $n\ge4$ and for
  the odd $\Theta_n$ at odd $n\ge5$, so `L224_eq_tight` applies at both parities;
* `zero_branch`: in the branch $y=x=0$, $D+\nu=E$, the record's *At $s=0$, $W=E$ is diagonal*.
-/

namespace HamiltonsCubic.L224Eq

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.I117S HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.PairIdent HamiltonsCubic.L222Swap
  HamiltonsCubic.OddPart HamiltonsCubic.L224Cubic HamiltonsCubic.FrameOp2 HamiltonsCubic.L222Op HamiltonsCubic.L120Blocks
  HamiltonsCubic.PairNorm HamiltonsCubic.FrameLayer HamiltonsCubic.L224Norm HamiltonsCubic.L224Step4 HamiltonsCubic.L224Bound
  HamiltonsCubic.FamilyLayer

variable {n : ℕ} {j k : Fin n}

/-- L57's bound carried to a Weyl operator of character `1`. -/
theorem charOne_le {Θ : ℝ} (hL57 : ∀ w : Matrix (Fin n) (Fin n) ℝ, IsWeight w →
      Pcubic (diagOp w) ≤ Θ * RealLayer.norm (diagOp w) ^ 3)
    {W : CurvOp2 (Fin n)} (hW : IsWeyl2 W) (h1 : SignChar (fun _ => 1) W) :
    Pcubic2 W ≤ Θ * Real.sqrt (normSq2 W) ^ 3 := by
  obtain ⟨w, hw, hP, hN⟩ := charOne_diag hW h1
  have hL := hL57 w hw
  unfold RealLayer.norm at hL
  rw [hP, hN]; exact hL

/-- **L224 (5), the tight inequalities**: at equality `P(D + ν) = Θ ‖D + ν‖³`, either `y = x = 0`, or `λ = q_E(z₊) > 0` with
`q_E(y) = λ‖y‖²`, `q_E(x) = λ‖x‖²` and `W' = E + D⁻_{√s z₊}` attaining `Θ`. -/
theorem L224_eq_tight {Θ : ℝ} (hΘ : 0 < Θ) (hL57 : ∀ w : Matrix (Fin n) (Fin n) ℝ, IsWeight w →
      Pcubic (diagOp w) ≤ Θ * RealLayer.norm (diagOp w) ^ 3)
    (hjk : j ≠ k) {D ν : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hνW : IsWeyl2 ν)
    (hD : SignChar (fun _ => 1) D) (hν : SignChar (setChar {j, k}) ν)
    (heq : Pcubic2 (D + ν) = Θ * Real.sqrt (normSq2 (D + ν)) ^ 3) :
    ∃ y x : Fin n → ℝ, y j = 0 ∧ y k = 0 ∧ ∑ i, y i = 0 ∧ x j = 0 ∧ x k = 0 ∧ ∑ i, x i = 0 ∧
      (1 / 2 : ℝ) • (D - rotR (swapM j k) D) = coordOp (Dminus j k y) ∧ ν = nuX j k x ∧
      ((y = 0 ∧ x = 0) ∨
        ∃ z₁ : Fin n → ℝ, z₁ j = 0 ∧ z₁ k = 0 ∧ ∑ i, z₁ i = 0 ∧ ∑ i, z₁ i ^ 2 = 1 ∧
          0 < ∑ i, y i ^ 2 + ∑ i, x i ^ 2 ∧
          (∀ z : Fin n → ℝ, z j = 0 → z k = 0 → ∑ i, z i = 0 →
            qE j k ((1 / 2 : ℝ) • (D + rotR (swapM j k) D)) z
              ≤ (∑ i, z i ^ 2) * qE j k ((1 / 2 : ℝ) • (D + rotR (swapM j k) D)) z₁) ∧
          0 < qE j k ((1 / 2 : ℝ) • (D + rotR (swapM j k) D)) z₁ ∧
          qE j k ((1 / 2 : ℝ) • (D + rotR (swapM j k) D)) y
            = (∑ i, y i ^ 2) * qE j k ((1 / 2 : ℝ) • (D + rotR (swapM j k) D)) z₁ ∧
          qE j k ((1 / 2 : ℝ) • (D + rotR (swapM j k) D)) x
            = (∑ i, x i ^ 2) * qE j k ((1 / 2 : ℝ) • (D + rotR (swapM j k) D)) z₁ ∧
          Pcubic2 ((1 / 2 : ℝ) • (D + rotR (swapM j k) D)
              + coordOp (Dminus j k (Real.sqrt (∑ i, y i ^ 2 + ∑ i, x i ^ 2) • z₁)))
            = Θ * Real.sqrt (normSq2 ((1 / 2 : ℝ) • (D + rotR (swapM j k) D)
              + coordOp (Dminus j k (Real.sqrt (∑ i, y i ^ 2 + ∑ i, x i ^ 2) • z₁)))) ^ 3) := by
  obtain ⟨y, x, hyj, hyk, hy, hxj, hxk, hx, hM, hνx, hnorm⟩ := L224_norm hjk hDW hνW hD hν
  refine ⟨y, x, hyj, hyk, hy, hxj, hxk, hx, hM, hνx, ?_⟩
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
  have hvx : vy j k x = x := vy_of_zero x hxj hxk
  have hcub : Pcubic2 (D + ν) = Pcubic2 E + 3 * qE j k E y + 3 * qE j k E x := by
    have h := L224_cubic_pair hjk hDW hνW hD hν
    have hQν : Qop2 ν = coordOp (Gy j k x) := by rw [hνx]; exact Q_nuX hjk x (by rw [hvx]; exact hx)
    rw [foxProd2_self, foxProd2_self, hM, Q_Dminus, hQν] at h
    rw [h]; unfold qE; rfl
  set s := ∑ c, y c ^ 2 + ∑ c, x c ^ 2 with hsdef
  have hy0 : 0 ≤ ∑ c, y c ^ 2 := Finset.sum_nonneg fun c _ => sq_nonneg (y c)
  have hx0 : 0 ≤ ∑ c, x c ^ 2 := Finset.sum_nonneg fun c _ => sq_nonneg (x c)
  have hs0 : 0 ≤ s := add_nonneg hy0 hx0
  by_cases hs : s = 0
  · left
    have hy2 : ∑ c, y c ^ 2 = 0 := by linarith
    have hx2 : ∑ c, x c ^ 2 = 0 := by linarith
    exact ⟨funext fun i => pow_eq_zero_iff two_ne_zero |>.mp
        ((Finset.sum_eq_zero_iff_of_nonneg fun c _ => sq_nonneg (y c)).mp hy2 i (Finset.mem_univ i)),
      funext fun i => pow_eq_zero_iff two_ne_zero |>.mp
        ((Finset.sum_eq_zero_iff_of_nonneg fun c _ => sq_nonneg (x c)).mp hx2 i (Finset.mem_univ i))⟩
  · right
    have hspos : 0 < s := lt_of_le_of_ne hs0 (Ne.symm hs)
    have hne : ∃ z : Fin n → ℝ, z j = 0 ∧ z k = 0 ∧ ∑ i, z i = 0 ∧ ∑ i, z i ^ 2 = 1 := by
      have key : ∀ w : Fin n → ℝ, w j = 0 → w k = 0 → ∑ i, w i = 0 → 0 < ∑ i, w i ^ 2 →
          ∃ z : Fin n → ℝ, z j = 0 ∧ z k = 0 ∧ ∑ i, z i = 0 ∧ ∑ i, z i ^ 2 = 1 := by
        intro w hwj hwk hws hwp
        refine ⟨(Real.sqrt (∑ i, w i ^ 2))⁻¹ • w, by simp [hwj], by simp [hwk], ?_, ?_⟩
        · simp only [Pi.smul_apply, smul_eq_mul, ← Finset.mul_sum, hws, mul_zero]
        · simp only [Pi.smul_apply, smul_eq_mul, mul_pow]
          rw [← Finset.mul_sum, inv_pow, Real.sq_sqrt hwp.le]
          exact inv_mul_cancel₀ hwp.ne'
      by_cases hy2 : ∑ c, y c ^ 2 = 0
      · have hx2 : 0 < ∑ c, x c ^ 2 := by
          rcases hx0.lt_or_eq with h | h
          · exact h
          · exfalso; apply hs; rw [hsdef, hy2, ← h]; ring
        exact key x hxj hxk hx hx2
      · exact key y hyj hyk hy (lt_of_le_of_ne hy0 (Ne.symm hy2))
    obtain ⟨z₁, hz₁j, hz₁k, hz₁s, hz₁n, hbound⟩ := exists_qE_max (j := j) (k := k) E hne
    set zs : Fin n → ℝ := Real.sqrt s • z₁ with hzsdef
    have hzsj : zs j = 0 := by simp [hzsdef, hz₁j]
    have hzsk : zs k = 0 := by simp [hzsdef, hz₁k]
    have hzss : ∑ c, vy j k zs c = 0 := by
      rw [vy_of_zero zs hzsj hzsk]
      simp only [hzsdef, Pi.smul_apply, smul_eq_mul, ← Finset.mul_sum, hz₁s, mul_zero]
    have hzsn : ∑ c, zs c ^ 2 = s := by
      simp only [hzsdef, Pi.smul_apply, smul_eq_mul, mul_pow]
      rw [← Finset.mul_sum, hz₁n, Real.sq_sqrt hs0, mul_one]
    set M' := coordOp (Dminus j k zs) with hM'def
    have hM'W : IsWeyl2 M' := Dminus_weyl hjk zs hzss
    have hM'1 : SignChar (fun _ => 1) M' := Dminus_charOne hjk zs hzss
    have hEM' : innerOp2 E M' = 0 := by
      refine inner_flip_zero hσ hEW hM'W hσE ?_
      rw [hM'def, Dminus_swap_odd hjk zs]; module
    have hnW' : normSq2 (E + M') = normSq2 (D + ν) := by
      rw [hnorm]
      unfold normSq2
      rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, innerOp2_comm M' E, hEM']
      have hnM' : innerOp2 M' M' = 2 * s := by
        have := normSq2_Dminus hjk zs
        unfold normSq2 at this
        rw [← hM'def] at this
        rw [this, vy_of_zero zs hzsj hzsk, hzsn]
      rw [hnM']; ring
    have hPW' : Pcubic2 (E + M') = Pcubic2 E + 3 * (s * qE j k E z₁) := by
      rw [cubic_even_odd hjk hEW hE1 hσE zs hzss, hzsdef, qE_smul, Real.sq_sqrt hs0]
    have hqy := hbound y hyj hyk hy
    have hqx := hbound x hxj hxk hx
    -- the chain `P(W) ≤ P(W') ≤ Θ ‖W'‖³ = Θ ‖W‖³ = P(W)`
    have hW'le := charOne_le hL57 (isWeyl2_add hEW hM'W) (signChar_add hE1 hM'1)
    rw [hnW'] at hW'le
    have hsum : qE j k E y + qE j k E x ≤ s * qE j k E z₁ := by rw [hsdef, add_mul]; linarith
    have htight : qE j k E y + qE j k E x = s * qE j k E z₁ := by
      have := hcub ▸ heq
      linarith
    have hqy' : qE j k E y = (∑ c, y c ^ 2) * qE j k E z₁ := by
      have : qE j k E y + qE j k E x = (∑ c, y c ^ 2) * qE j k E z₁ + (∑ c, x c ^ 2) * qE j k E z₁ := by
        rw [htight, hsdef, add_mul]
      linarith
    have hqx' : qE j k E x = (∑ c, x c ^ 2) * qE j k E z₁ := by linarith
    -- `λ > 0`: otherwise `P(W) ≤ P(E) ≤ Θ‖E‖³ < Θ‖W‖³`
    have hlam : 0 < qE j k E z₁ := by
      by_contra hle
      push Not at hle
      have hE := charOne_le hL57 hEW hE1
      have hnE : normSq2 E = normSq2 (D + ν) - 2 * s := by rw [hnorm]; ring
      have hE0 : 0 ≤ normSq2 E := by unfold normSq2; exact innerOp2_self_nonneg E
      have hlt : Real.sqrt (normSq2 E) < Real.sqrt (normSq2 (D + ν)) :=
        Real.sqrt_lt_sqrt hE0 (by rw [hnE]; linarith)
      have hcube : Real.sqrt (normSq2 E) ^ 3 < Real.sqrt (normSq2 (D + ν)) ^ 3 :=
        pow_lt_pow_left₀ hlt (Real.sqrt_nonneg _) (by norm_num)
      have : Pcubic2 (D + ν) ≤ Pcubic2 E := by
        have h0 := mul_le_mul_of_nonneg_left hle hs0
        rw [hcub]; linarith
      nlinarith
    refine ⟨z₁, hz₁j, hz₁k, hz₁s, hz₁n, hspos, hbound, hlam, hqy', hqx', ?_⟩
    have hle' : Pcubic2 (E + M') ≤ Θ * Real.sqrt (normSq2 (E + M')) ^ 3 :=
      charOne_le hL57 (isWeyl2_add hEW hM'W) (signChar_add hE1 hM'1)
    rw [hnW'] at hle' ⊢
    have : Pcubic2 (D + ν) = Pcubic2 (E + M') := by rw [hcub, hPW', ← htight]; ring
    linarith

/-- `θ₀(n) > 0` at `n ≥ 4`. -/
theorem theta0_pos (hn : 4 ≤ n) : 0 < Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / (n : ℝ) := by
  have h4 : (4 : ℝ) ≤ n := by exact_mod_cast hn
  apply div_pos (Real.sqrt_pos.mpr (by nlinarith)) (by linarith)

/-- L57's even-form bound in the shape `L224_eq_tight` takes. -/
theorem L57_even (hn : 4 ≤ n) : ∀ w : Matrix (Fin n) (Fin n) ℝ, IsWeight w →
    Pcubic (diagOp w) ≤ Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / (n : ℝ) * RealLayer.norm (diagOp w) ^ 3 := by
  intro w hw
  have hL := L57Critical.L57_diagonal (by rw [Fintype.card_fin]; exact hn) w hw
  rwa [Fintype.card_fin] at hL

/-- The odd `Θ_n > 0` at `n ≥ 5`. -/
theorem thetaOdd_pos (hn : 5 ≤ n) : 0 < Real.sqrt (L57Critical.thetaOddSq (n : ℝ)) := by
  have h5 : (5 : ℝ) ≤ n := by exact_mod_cast hn
  apply Real.sqrt_pos.mpr
  unfold L57Critical.thetaOddSq
  apply div_pos <;> nlinarith

/-- L57's odd bound in the shape `L224_eq_tight` takes. -/
theorem L57_odd (hn : 5 ≤ n) (hodd : ¬ Even n) : ∀ w : Matrix (Fin n) (Fin n) ℝ, IsWeight w →
    Pcubic (diagOp w) ≤ Real.sqrt (L57Critical.thetaOddSq (n : ℝ)) * RealLayer.norm (diagOp w) ^ 3 := by
  intro w hw
  have hL := L57Critical.L57_diagonal_odd (by rw [Fintype.card_fin]; exact hn) (by rw [Fintype.card_fin]; exact hodd) w hw
  rwa [Fintype.card_fin] at hL

/-- **The branch `s = 0`**: with `y = x = 0`, `D + ν = E`, which is diagonal. -/
theorem zero_branch (hjk : j ≠ k) {D ν : CurvOp2 (Fin n)}
    (hM : (1 / 2 : ℝ) • (D - rotR (swapM j k) D) = coordOp (Dminus j k 0)) (hνx : ν = nuX j k 0) :
    D + ν = (1 / 2 : ℝ) • (D + rotR (swapM j k) D) := by
  have hv0 : vy j k (0 : Fin n → ℝ) = 0 := by funext i; simp [vy]
  have h1 : coordOp (Dminus j k 0) = 0 := normSq2_eq_zero (by rw [normSq2_Dminus hjk, hv0]; simp)
  have h2 : nuX j k 0 = 0 := normSq2_eq_zero (by rw [normSq2_nuX hjk 0 (by rw [hv0]; simp), hv0]; simp)
  have e : D + ν = (1 / 2 : ℝ) • (D + rotR (swapM j k) D) + (1 / 2 : ℝ) • (D - rotR (swapM j k) D) + ν := by module
  rw [e, hM, h1, hνx, h2]
  module

end HamiltonsCubic.L224Eq
