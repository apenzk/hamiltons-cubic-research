import Mathlib
import HamiltonsCubic.Results.L53CPm
import HamiltonsCubic.Results.L56Statement

set_option linter.style.longLine false

/-!
# L56: the `ℂPᵐ` gap, from the spectrum of `W_{ℂPᵐ}`

[L56Statement.lean](L56Statement.lean) takes the correction's
`gap(ℂPᵐ)² = (m-2)²/(3m(m²-1)(2m-1))` as the definition `cpGapSq`, and the L56 row owes it. The gap is
the smallest modulus of the `Λ²` spectrum of the unit-normalised Weyl operator, the reading
[L56Norm.lean](L56Norm.lean) proves for the sphere products. This file reads it off the layer's
`W_{ℂPᵐ}` ([L70CPm.lean](L70CPm.lean)), `X ↦ cA X + J X Jᵀ + (∑ J_{ij} X_{ij}) J`, `cA = -3/(2m-1)`:

* `eigen_cases`: every eigenvalue on a nonzero bivector is `cA + 1`, `cA - 1` or `cA + 1 + 2m`, from
  L70CPm's `eigen_mul_J`;
* `Xp_eigen`, `Xm_eigen`: at `m ≥ 2`, `φ₀₂ ± Jφ₀₂Jᵀ` are nonzero bivectors at `cA + 1` and `cA - 1`, and
  `J` carries `cA + 1 + 2m` (`WCPm_J`), so `spec_eq`: the spectrum is exactly these three values;
* `min_modulus`: `|cA + 1| = (2m-4)/(2m-1)` is the smallest modulus in the spectrum;
* `cp_gap`: `cpGapSq m = (cA + 1)² / ‖W_{ℂPᵐ}‖²`, through L53CPm's `normSq_WCPm`.

At `m = 2` the smallest modulus is `0`, so `cpGapSq 2 = 0` reads the gap as the smallest modulus
including `0`; the record uses the formula at `m ≥ 3`, where every eigenvalue is nonzero.
-/

namespace HamiltonsCubic.L56CP

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.L70CPm

variable {m : ℕ}

local notation "M" => Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ

theorem conj_add (Y Z : M) : conj (Y + Z) = conj Y + conj Z := by
  unfold conj; simp [Matrix.mul_add, Matrix.add_mul]

theorem conj_sub (Y Z : M) : conj (Y - Z) = conj Y - conj Z := by
  unfold conj; simp [Matrix.mul_sub, Matrix.sub_mul]

theorem conj_skew (Y : M) (hY : IsSkew Y) : IsSkew (conj Y) := by
  unfold IsSkew at hY ⊢
  unfold conj
  rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose, hY]
  simp [Matrix.mul_assoc]

theorem Jm_ne_zero (hm : 1 ≤ m) : (Jm : M) ≠ 0 := by
  intro h
  have := frob_J_J (m := m)
  rw [h] at this
  simp [frob] at this
  have : (1 : ℝ) ≤ m := by exact_mod_cast hm
  linarith

/-- **The spectrum has three values**: every eigenvalue of `W_{ℂPᵐ}` on a nonzero matrix is `cA ± 1`
or `cA + 1 + 2m`. -/
theorem eigen_cases (hm : 1 ≤ m) (X : M) (hX0 : X ≠ 0) (lam : ℝ) (hX : WCPm X = lam • X) :
    lam = cA m + 1 ∨ lam = cA m - 1 ∨ lam = cA m + 1 + 2 * m := by
  by_contra h
  simp only [not_or] at h
  obtain ⟨c, rfl⟩ := eigen_mul_J X lam hX h.1 h.2.1
  have hc : c ≠ 0 := by rintro rfl; exact hX0 (zero_smul _ _)
  have e := congrArg (frob Jm) hX
  rw [(WCPm_isLinOp (m := m)).2, WCPm_J, frob_smul, frob_smul, frob_smul, frob_smul, frob_J_J] at e
  have hmR : (1 : ℝ) ≤ m := by exact_mod_cast hm
  have : (lam - (cA m + 1 + 2 * m)) * (c * (2 * m)) = 0 := by linear_combination -e
  rcases mul_eq_zero.mp this with h' | h'
  · exact h.2.2 (by linarith)
  · rcases mul_eq_zero.mp h' with h'' | h''
    · exact hc h''
    · linarith

section witnesses

variable (hm : 2 ≤ m)
include hm

/-- The indices `0` and `2`, in different `J`-pairs. -/
def i0 : Fin (2 * m) := ⟨0, by omega⟩
def i2 : Fin (2 * m) := ⟨2, by omega⟩

theorem J02 : (Jm : M) (i0 hm) (i2 hm) = 0 := by
  rw [Jm_apply, if_neg]
  intro h
  have := congrArg Fin.val h
  simp [i0, i2, partner] at this

theorem J20 : (Jm : M) (i2 hm) (i0 hm) = 0 := by
  rw [Jm_skew_apply, J02 hm, neg_zero]

theorem frob_J_phi02 : frob (Jm : M) (phi (i0 hm) (i2 hm)) = 0 := by
  rw [frob_phi, J02 hm, mul_zero]

theorem entry_phi02 : phi (i0 hm) (i2 hm) (i0 hm) (i2 hm) = (-1 : ℝ) := by
  have h : i0 hm ≠ i2 hm := by
    intro h; have := congrArg Fin.val h; simp [i0, i2] at this
  rw [phi_apply]
  simp [h, Ne.symm h]

theorem entry_conj_phi02 : conj (phi (i0 hm) (i2 hm) : M) (i0 hm) (i2 hm) = 0 := by
  rw [conj_phi_apply, J02 hm, J20 hm, Jm_diag, Jm_diag]; ring

/-- `φ₀₂ + Jφ₀₂Jᵀ`, at `cA + 1`. -/
noncomputable def Xp : M := phi (i0 hm) (i2 hm) + conj (phi (i0 hm) (i2 hm))

/-- `φ₀₂ - Jφ₀₂Jᵀ`, at `cA - 1`. -/
noncomputable def Xm : M := phi (i0 hm) (i2 hm) - conj (phi (i0 hm) (i2 hm))

theorem Xp_eigen : WCPm (Xp hm) = (cA m + 1) • Xp hm ∧ IsSkew (Xp hm) ∧ Xp hm ≠ 0 := by
  have hf : frob (Jm : M) (Xp hm) = 0 := by
    unfold Xp; rw [frob_add, frob_J_conj, frob_J_phi02 hm, add_zero]
  have hc : conj (Xp hm) = Xp hm := by
    unfold Xp; rw [conj_add, conj_conj, add_comm]
  refine ⟨?_, ?_, ?_⟩
  · have e : WCPm (Xp hm) = cA m • Xp hm + conj (Xp hm) + frob Jm (Xp hm) • Jm := rfl
    rw [e, hc, hf, zero_smul, add_zero, add_smul, one_smul]
  · unfold Xp IsSkew
    have h1 := phi_isSkew (i0 hm) (i2 hm)
    have h2 := conj_skew _ h1
    unfold IsSkew at h1 h2
    rw [Matrix.transpose_add, h1, h2, neg_add]
  · intro h
    have := congrFun (congrFun h (i0 hm)) (i2 hm)
    simp only [Xp, Matrix.add_apply, entry_phi02 hm, entry_conj_phi02 hm, Matrix.zero_apply] at this
    norm_num at this

theorem Xm_eigen : WCPm (Xm hm) = (cA m - 1) • Xm hm ∧ IsSkew (Xm hm) ∧ Xm hm ≠ 0 := by
  have hf : frob (Jm : M) (Xm hm) = 0 := by
    unfold Xm
    rw [sub_eq_add_neg, frob_add, ← neg_one_smul ℝ (conj _), frob_smul, frob_J_conj, frob_J_phi02 hm]
    ring
  have hc : conj (Xm hm) = -Xm hm := by
    unfold Xm; rw [conj_sub, conj_conj, neg_sub]
  refine ⟨?_, ?_, ?_⟩
  · have e : WCPm (Xm hm) = cA m • Xm hm + conj (Xm hm) + frob Jm (Xm hm) • Jm := rfl
    rw [e, hc, hf, zero_smul, add_zero, sub_smul, one_smul, sub_eq_add_neg]
  · unfold Xm IsSkew
    have h1 := phi_isSkew (i0 hm) (i2 hm)
    have h2 := conj_skew _ h1
    unfold IsSkew at h1 h2
    rw [Matrix.transpose_sub, h1, h2, neg_sub_neg, neg_sub]
  · intro h
    have := congrFun (congrFun h (i0 hm)) (i2 hm)
    simp only [Xm, Matrix.sub_apply, entry_phi02 hm, entry_conj_phi02 hm, Matrix.zero_apply] at this
    norm_num at this

end witnesses

/-- The `Λ²` spectrum of `W_{ℂPᵐ}`: eigenvalues on nonzero bivectors. -/
def Spec (m : ℕ) : Set ℝ :=
  {lam | ∃ X : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ, IsSkew X ∧ X ≠ 0 ∧ WCPm X = lam • X}

/-- **The spectrum is exactly `{cA + 1, cA - 1, cA + 1 + 2m}`** at every `m ≥ 2`. -/
theorem spec_eq (hm : 2 ≤ m) : Spec m = {cA m + 1, cA m - 1, cA m + 1 + 2 * m} := by
  ext lam
  simp only [Spec, Set.mem_ofPred_eq, Set.mem_insert_iff, Set.mem_singleton_iff]
  constructor
  · rintro ⟨X, -, hX0, hX⟩
    exact eigen_cases (by omega) X hX0 lam hX
  · rintro (rfl | rfl | rfl)
    · obtain ⟨h1, h2, h3⟩ := Xp_eigen hm; exact ⟨_, h2, h3, h1⟩
    · obtain ⟨h1, h2, h3⟩ := Xm_eigen hm; exact ⟨_, h2, h3, h1⟩
    · exact ⟨Jm, Jm_skew, Jm_ne_zero (by omega), WCPm_J⟩

/-- **The smallest modulus is `|cA + 1| = (2m-4)/(2m-1)`**, attained. -/
theorem min_modulus (hm : 2 ≤ m) :
    cA m + 1 ∈ Spec m ∧ |cA m + 1| = (2 * (m : ℝ) - 4) / (2 * m - 1) ∧
      ∀ lam ∈ Spec m, |cA m + 1| ≤ |lam| := by
  have hmR : (2 : ℝ) ≤ m := by exact_mod_cast hm
  have hd : (0 : ℝ) < 2 * m - 1 := by linarith
  have hp : cA m + 1 = (2 * (m : ℝ) - 4) / (2 * m - 1) := by
    unfold cA; field_simp; ring
  have hpos : 0 ≤ cA m + 1 := by rw [hp]; exact div_nonneg (by linarith) hd.le
  refine ⟨by rw [spec_eq hm]; simp, by rw [abs_of_nonneg hpos, hp], ?_⟩
  intro lam hl
  rw [spec_eq hm] at hl
  simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hl
  rw [abs_of_nonneg hpos]
  rcases hl with rfl | rfl | rfl
  · exact le_abs_self _
  · have hq : cA m - 1 = -((2 * (m : ℝ) + 2) / (2 * m - 1)) := by
      unfold cA; field_simp; ring
    rw [hq, abs_neg, abs_of_nonneg (div_nonneg (by linarith) hd.le), hp]
    exact div_le_div_of_nonneg_right (by linarith) hd.le
  · rw [abs_of_nonneg (by linarith)]
    linarith

/-- **The `ℂPᵐ` gap**: `cpGapSq m = (cA + 1)² / ‖W_{ℂPᵐ}‖²`, the smallest `Λ²` modulus of the
unit-normalised `W_{ℂPᵐ}`, squared, at every `m ≥ 2`. -/
theorem cp_gap (hm : 2 ≤ m) :
    HamiltonsCubic.L56Statement.cpGapSq m = (cA m + 1) ^ 2 / normSq (WCPm (m := m)) := by
  have hmR : (2 : ℝ) ≤ m := by exact_mod_cast hm
  have h1 : (2 * (m : ℝ) - 1) ≠ 0 := by linarith
  have h2 : (m : ℝ) ≠ 0 := by linarith
  have h3 : (m : ℝ) ^ 2 - 1 ≠ 0 := by nlinarith
  have hp : cA m + 1 = (2 * (m : ℝ) - 4) / (2 * m - 1) := by
    unfold cA; field_simp; ring
  rw [normSq_WCPm (by omega), HamiltonsCubic.L56Statement.cpGapSq, hp]
  field_simp
  ring

end HamiltonsCubic.L56CP
