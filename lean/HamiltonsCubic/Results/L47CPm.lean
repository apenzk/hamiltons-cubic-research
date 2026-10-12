import Mathlib
import HamiltonsCubic.Results.L47Statement
import HamiltonsCubic.Results.L53CPm

/-!
# L47's `ℂPᵐ` closed form, read off the `ℂPᵐ` Weyl operator

[L47Statement.lean](L47Statement.lean) carries the record's closed form
`‖W‖²(ℂPᵐ) = 3m(m-1)/(4(m+1)(2m-1))` as the definition `cpNormSq`, and L47's row owes that it is
the norm of the `ℂPᵐ` Weyl tensor. The record normalises to Einstein constant `½`, where
`θ = (1/2)/‖W‖` (Lemma L46, and `theta_le_of_floor`'s reading); `θ` is scale-invariant, so the
closed form is determined by `θ(W_{ℂPᵐ})` alone.

* `cp_theta`: `(1/2)/√(cpNormSq m) = θ(W_{ℂPᵐ})` at every `m ≥ 2`, for the operator `WCPm` of
  [L70CPm.lean](L70CPm.lean), from `normSq_WCPm` (`‖W‖² = 12m(m²-1)/(2m-1)`) and `Pcubic_WCPm`
  (`P = (2m+2)‖W‖²`) in [L53CPm.lean](L53CPm.lean). So `cpNormSq m` is `‖W‖²` at the Einstein-`½`
  normalisation of `W_{ℂPᵐ}`.
* `cp_theta_le`: with `cp_floor`, `θ(W_{ℂPᵐ}) ≤ √(3/2)` at every `m ≥ 2`.
* `cp_normalised`: `W_{ℂPᵐ}/(4(m+1))` is critical with multiplier `½` and has squared norm
  `cpNormSq m`, the normalisation itself rather than its `θ` reading.
-/

namespace HamiltonsCubic.L47CPm

open HamiltonsCubic.RealLayer HamiltonsCubic.L70CPm HamiltonsCubic.L47Statement

/-- **The `ℂPᵐ` closed form is `‖W‖²` at Einstein constant `½`**: `(1/2)/√(cpNormSq m)` is
`θ(W_{ℂPᵐ})`. -/
theorem cp_theta {m : ℕ} (hm : 2 ≤ m) :
    (1 / 2) / Real.sqrt (cpNormSq m) = theta (WCPm (m := m)) := by
  have hm1 : 1 ≤ m := le_trans (by norm_num) hm
  have hmR : (2 : ℝ) ≤ m := by exact_mod_cast hm
  set N : ℝ := 12 * m * ((m : ℝ) ^ 2 - 1) / (2 * m - 1) with hNdef
  have hN : 0 < N := by
    rw [hNdef]
    apply div_pos
    · have : (0 : ℝ) < (m : ℝ) ^ 2 - 1 := by nlinarith
      positivity
    · linarith
  have hcp : cpNormSq m = N / (4 * ((m : ℝ) + 1)) ^ 2 := by
    rw [cpNormSq, hNdef]
    have h1 : (2 * (m : ℝ) - 1) ≠ 0 := by linarith
    have h2 : ((m : ℝ) + 1) ≠ 0 := by linarith
    field_simp
    ring
  have hpos4 : 0 < 4 * ((m : ℝ) + 1) := by linarith
  have hsq : Real.sqrt (cpNormSq m) = Real.sqrt N / (4 * ((m : ℝ) + 1)) := by
    rw [hcp, Real.sqrt_div hN.le, Real.sqrt_sq hpos4.le]
  have hsN : 0 < Real.sqrt N := Real.sqrt_pos.mpr hN
  have hsN2 : Real.sqrt N ^ 2 = N := Real.sq_sqrt hN.le
  unfold theta HamiltonsCubic.RealLayer.norm
  rw [Pcubic_WCPm hm1, normSq_WCPm hm1, ← hNdef, hsq]
  have h3 : Real.sqrt N ^ 3 = N * Real.sqrt N := by rw [pow_succ, hsN2]
  rw [h3]
  field_simp
  ring

/-- **`θ(W_{ℂPᵐ}) ≤ √(3/2)` at every `m ≥ 2`**, from `cp_floor` through `theta_le_of_floor`. -/
theorem cp_theta_le {m : ℕ} (hm : 2 ≤ m) : theta (WCPm (m := m)) ≤ Real.sqrt (3 / 2) := by
  rw [← cp_theta hm]
  exact theta_le_of_floor (cp_floor (by exact_mod_cast hm))

/-- **The Einstein-`½` normalisation, typed** ([r1691](../../../reviews/REVIEW_r1691.md) O1):
`W' = W_{ℂPᵐ}/(4(m+1))` is critical with multiplier `½` and has `‖W'‖² = cpNormSq m`, so the record's
closed form is the squared norm of the `ℂPᵐ` Weyl operator scaled to Einstein constant `½`. -/
theorem cp_normalised {m : ℕ} (hm : 2 ≤ m) :
    normSq ((1 / (4 * ((m : ℝ) + 1))) • WCPm (m := m)) = cpNormSq m ∧
      IsCritical ((1 / (4 * ((m : ℝ) + 1))) • WCPm (m := m)) (1 / 2) := by
  have hm1 : 1 ≤ m := le_trans (by norm_num) hm
  have hmR : (2 : ℝ) ≤ m := by exact_mod_cast hm
  have hpos : (0 : ℝ) < 4 * ((m : ℝ) + 1) := by linarith
  set c : ℝ := 1 / (4 * ((m : ℝ) + 1)) with hc
  constructor
  · have hsc : normSq (c • WCPm (m := m)) = c ^ 2 * normSq (WCPm (m := m)) := by
      unfold normSq innerOp
      simp only [Pi.smul_apply, HamiltonsCubic.FamilyLayer.inner2_smul_left,
        HamiltonsCubic.FamilyLayer.inner2_smul_right]
      simp only [← Finset.mul_sum]
      ring
    rw [hsc, HamiltonsCubic.L70CPm.normSq_WCPm (m := m) hm1]
    unfold cpNormSq
    rw [hc]
    have h1 : (2 * (m : ℝ) - 1) ≠ 0 := by linarith
    have h2 : ((m : ℝ) + 1) ≠ 0 := by linarith
    field_simp
    ring
  · intro i j
    rw [Qop_smul _ (WCPm_isWeylOp hm1).1, WCPm_critical hm1 i j, Pi.smul_apply, smul_smul,
      smul_smul]
    congr 1
    rw [hc]
    have h2 : ((m : ℝ) + 1) ≠ 0 := by linarith
    field_simp
    ring

end HamiltonsCubic.L47CPm
