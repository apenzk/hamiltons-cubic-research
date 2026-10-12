import HamiltonsCubic.Results.FourthMoment
import HamiltonsCubic.Results.L57Equality

set_option linter.style.longLine false

/-!
# L57 at odd `n`: `P(W) ≤ Θₙ ‖W‖³` with `Θₙ² = 2(n−1)(n−3)/((n+1)(n−2))`

[findings/problem.md](../../../findings/problem.md), Lemma L57 at odd `n`. The even-`n` chain
([L57Critical.lean](L57Critical.lean), [L57Diagonal.lean](L57Diagonal.lean)) used `∑ v⁴ ≥ 1/n`; at
odd `n` [FourthMoment.lean](FourthMoment.lean)'s `fourth_moment_odd` gives `∑ v⁴ ≥ (n²+3)/(n(n²−1))`,
and the same chain then yields the record's odd constant:

- `Zsq_odd`: `|Z(v)|² ≤ n²(n−3)/(2(n²−1)(n−2))`;
- `L57_critical_odd`: **`λ ≤ Θₙ`** at every unit critical weight at odd `n ≥ 5`;
- `L57_diagonal_odd`: **`P(diag w) ≤ Θₙ ‖diag w‖³` for every weight** at odd `n ≥ 5`.
-/

namespace HamiltonsCubic.L57Critical

open Finset Matrix HamiltonsCubic.FamilyLayer HamiltonsCubic.FourthMoment

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- `Θₙ²` at odd `n`. -/
noncomputable def thetaOddSq (n : ℝ) : ℝ := 2 * (n - 1) * (n - 3) / ((n + 1) * (n - 2))

/-- **L57 AT A CRITICAL POINT, ODD `n`.** -/
theorem L57_critical_odd {S : Matrix ι ι ℝ} (hS : IsWeight S) (hn : 5 ≤ Fintype.card ι)
    (hodd : ¬ Even (Fintype.card ι)) (hunit : ∑ a, ∑ b, S a b ^ 2 = 2) (lam : ℝ)
    (hcrit : ∀ a b, a ≠ b → S a b ^ 2 + (S * S) a b = lam * S a b) :
    lam ≤ Real.sqrt (thetaOddSq (Fintype.card ι : ℝ)) := by
  set n : ℝ := (Fintype.card ι : ℝ) with hndef
  have hn5 : (5 : ℝ) ≤ n := by rw [hndef]; exact_mod_cast hn
  have hnpos : 0 < n := by linarith
  by_cases hl : lam ≤ 0
  · exact le_trans hl (Real.sqrt_nonneg _)
  push Not at hl
  have hne : Nonempty ι := Fintype.card_pos_iff.mp (by omega)
  obtain ⟨μ, v, hμ, hv, h2⟩ := exists_pos_eigen hS hne hunit
  have h1 := sum_v_zero S hS v μ hv hμ.ne'
  have hp := pairing S hS v μ hv lam h2 hcrit
  have hs1 := step1 S hS v μ hv h2 h1
  obtain ⟨hSZ, hZZ⟩ := step23_parts S hS v μ hv h2 h1 (by omega)
  rw [← hndef] at hs1 hSZ hZZ
  have hlm : lam * n ≤ (n - 1) * μ := by
    have : lam * μ * n ≤ (n - 1) * μ ^ 2 := by nlinarith
    have hμ2 : lam * n * μ ≤ (n - 1) * μ * μ := by nlinarith
    exact le_of_mul_le_mul_right hμ2 hμ
  have hcs := cs_pairs S (Zp v n)
  rw [hSZ, hunit, hZZ] at hcs
  have h4 := fourth_moment_odd (ι := ι) (by omega) hodd v h1 h2
  rw [← hndef] at h4
  have hn2 : 0 < n - 2 := by linarith
  have hn1 : 0 < n - 1 := by linarith
  have hk : 0 < n / (2 * (n - 2)) := by positivity
  -- `μ² ≤ 2n²(n−3)/((n²−1)(n−2))`
  have hμsq : μ ^ 2 ≤ 2 * n ^ 2 * (n - 3) / ((n ^ 2 - 1) * (n - 2)) := by
    have hb := mul_le_mul_of_nonneg_left h4 hk.le
    have e : 2 * (2 * ((n ^ 2 - 3 * n + 3) / (2 * (n - 1) * (n - 2)) - n / (2 * (n - 2)) * gOdd n))
        = 2 * n ^ 2 * (n - 3) / ((n ^ 2 - 1) * (n - 2)) := by
      unfold gOdd
      have : n ^ 2 - 1 ≠ 0 := by nlinarith
      field_simp; ring
    rw [← e]; nlinarith
  have hl0 : 0 ≤ lam * n := by positivity
  have hsq : (lam * n) ^ 2 ≤ (n - 1) ^ 2 * μ ^ 2 := by
    have : 0 ≤ (n - 1) * μ := by positivity
    nlinarith
  have hbound : lam ^ 2 ≤ thetaOddSq n := by
    have hA : (n - 1) ^ 2 * μ ^ 2 ≤ (n - 1) ^ 2 * (2 * n ^ 2 * (n - 3) / ((n ^ 2 - 1) * (n - 2))) :=
      mul_le_mul_of_nonneg_left hμsq (by positivity)
    have e : (n - 1) ^ 2 * (2 * n ^ 2 * (n - 3) / ((n ^ 2 - 1) * (n - 2))) = n ^ 2 * thetaOddSq n := by
      unfold thetaOddSq
      have : n ^ 2 - 1 = (n - 1) * (n + 1) := by ring
      rw [this]; field_simp
    have : lam ^ 2 * n ^ 2 ≤ thetaOddSq n * n ^ 2 := by nlinarith
    exact le_of_mul_le_mul_right this (by positivity)
  exact Real.le_sqrt_of_sq_le hbound

/-- **L57 AT EVERY DIAGONAL WEYL OPERATOR, ODD `n`.** -/
theorem L57_diagonal_odd (hn : 5 ≤ Fintype.card ι) (hodd : ¬ Even (Fintype.card ι)) (w : Matrix ι ι ℝ) (hw : IsWeight w) :
    HamiltonsCubic.RealLayer.Pcubic (diagOp w) ≤
      Real.sqrt (thetaOddSq (Fintype.card ι : ℝ)) * HamiltonsCubic.RealLayer.norm (diagOp w) ^ 3 := by
  set Θ := Real.sqrt (thetaOddSq (Fintype.card ι : ℝ)) with hΘ
  have hΘ0 : 0 ≤ Θ := Real.sqrt_nonneg _
  obtain ⟨S, hS, hf, hmax⟩ := exists_max_weight (by omega : 4 ≤ Fintype.card ι)
  have hMΘ : diagP S ≤ Θ := by
    obtain ⟨lam, hcrit⟩ := max_crit (by omega) hS hf hmax
    have hunit : ∑ a, ∑ b, S a b ^ 2 = 2 := hf
    rw [diagP_eq_lam hS hunit lam hcrit]
    exact L57_critical_odd hS hn hodd hunit lam hcrit
  rw [HamiltonsCubic.RealLayer.diagCubicFormula w hw]
  have hnorm : HamiltonsCubic.RealLayer.norm (diagOp w) = Real.sqrt (fro w / 2) := by
    unfold HamiltonsCubic.RealLayer.norm
    rw [diagOp_normSq w hw.symm hw.hollow]
    congr 1; unfold fro; ring
  rw [hnorm]
  by_cases h0 : fro w = 0
  · have hz : ∀ a b, w a b = 0 := by
      intro a b
      have hnn : ∀ a ∈ (Finset.univ : Finset ι), 0 ≤ ∑ b, w a b ^ 2 :=
        fun a _ => Finset.sum_nonneg fun b _ => sq_nonneg _
      have h1 := (Finset.sum_eq_zero_iff_of_nonneg hnn).mp h0 a (Finset.mem_univ a)
      have h2 := (Finset.sum_eq_zero_iff_of_nonneg fun b _ => sq_nonneg (w a b)).mp h1 b
        (Finset.mem_univ b)
      exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp h2
    have hwz : w = 0 := Matrix.ext hz
    rw [h0]
    have hd : diagP w = 0 := by rw [hwz]; simp [diagP]
    rw [hd]; simp
  have hfp : 0 < fro w := lt_of_le_of_ne (fro_nonneg w) (Ne.symm h0)
  set c := Real.sqrt (2 / fro w) with hc
  have hcpos : 0 < c := Real.sqrt_pos.mpr (by positivity)
  have hc2 : c ^ 2 = 2 / fro w := Real.sq_sqrt (by positivity)
  have hcw := hmax (c • w) (hw.smul c) (by rw [fro_smul, hc2]; field_simp)
  rw [diagP_smul] at hcw
  have hcinv : Real.sqrt (fro w / 2) = c⁻¹ := by
    rw [hc, ← Real.sqrt_inv, inv_div]
  rw [hcinv]
  have : diagP w ≤ Θ / c ^ 3 := by
    rw [le_div_iff₀ (by positivity)]; linarith
  calc diagP w ≤ Θ / c ^ 3 := this
    _ = Θ * c⁻¹ ^ 3 := by rw [inv_pow, div_eq_mul_inv]

end HamiltonsCubic.L57Critical
