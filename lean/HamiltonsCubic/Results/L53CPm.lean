import HamiltonsCubic.Results.L70CPmCrit
import HamiltonsCubic.Results.L53

set_option linter.style.longLine false

/-!
# L53's `ℂPᵐ` forms, from the layer's `W_{ℂPᵐ}`

[bispectral.md](../../../findings/bispectral.md)'s Observation L53, and [L53.lean](L53.lean), which checks the
record's two `ℂPᵐ` closed forms against each other and against `θ²(ℂPᵐ)` but owes *"the `Λ²` Weyl spectrum of
`ℂPᵐ` the forms are derived from"*. The forms need the power sums of that spectrum, not the eigenspaces, and those
are traces of polynomials in `W = cA·Id + C + (∑ J_{ij}(·)_{ij}) J` ([L70CPm.lean](L70CPm.lean)).

- `frob_W_W`, `frob_W2_W`: one basis term of `‖W‖²` and of `tr M³`, from `W² = (cA² + 1) Id + 2cA·C + …`
  ([L70CPmCrit.lean](L70CPmCrit.lean)'s `WCPm_sq`);
- `sum_frob_phi_phi`, `sum_frob_conj_phi`, `sum_J_sq`: the traces on `Λ²` of `Id`, of `C` and of
  `Π = (∑ J_{ij}(·)_{ij}) J`, which is `2m` times the projection onto `J`;
- **`normSq_WCPm`**: `‖W‖² = 12m(m² − 1)/(2m − 1)`; **`trCube_WCPm`**: `tr M³ = 8(m² − 1)(8m⁴ − 24m² + 11m)/(2m − 1)³`;
- `Pcubic_eq_innerOp_Qop`, `innerOp_Qop_of_critical` and **`Pcubic_WCPm`**: `P = (2m + 2)‖W‖²` from criticality;
- **`p3mu_WCPm`**: `(tr M³)² R² = (N/3)² ‖W‖⁶` with `N = 4m² + 2m − 11`, which is L53's `p₃(μ)² = N²/(9R²)`, the
  factor being `8m⁴ − 24m² + 11m = m(2m − 1)N`; **`thetaSq_WCPm`**: `P² = θ²(ℂPᵐ) ‖W‖⁶` with L53's
  `θ² = (m + 1)(2m − 1)/(3m(m − 1))`;
- **`trS2_cube_WCPm`** and **`p3omega_WCPm`**: from [L50Spectra.lean](L50Spectra.lean)'s `L50_bispectral`,
  `tr_{S²} W̊³ = 3 tr M³ − 2P = −216m(m² − 1)/(2m − 1)²`, so `p₃(ω)² R² = 81 ‖W‖⁶` with `p₃(ω) < 0`, L53's
  `p₃(ω) = −9/R`.
-/

namespace HamiltonsCubic.L70CPm

open Finset Matrix HamiltonsCubic.RealLayer

variable {m : ℕ}

local notation "M" => Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ

theorem frob_phi_phi (i j : Fin (2 * m)) : frob (phi i j : M) (phi i j) = 2 - 2 * (if i = j then 1 else 0) := by
  unfold frob
  simp only [phi_apply]
  by_cases h : i = j
  · subst h; simp
  · simp only [if_neg h]
    simp [ite_and, Finset.sum_ite_eq, Finset.sum_ite_eq', sub_mul, mul_sub, h, Ne.symm h]
    ring

theorem frob_conj_phi (i j : Fin (2 * m)) : frob (conj (phi i j) : M) (phi i j) = 2 * Jm i j ^ 2 := by
  unfold frob
  simp only [conj_phi_apply, phi_apply, mul_sub, mul_ite, mul_one, mul_zero, Finset.sum_sub_distrib, ite_and]
  simp [Finset.sum_ite_eq, Finset.sum_ite_eq', Jm_diag, Jm_skew_apply i j]
  ring

theorem sum_frob_phi_phi : ∑ i : Fin (2 * m), ∑ j, frob (phi i j : M) (phi i j) = 2 * (2 * m) ^ 2 - 2 * (2 * m) := by
  simp only [frob_phi_phi, Finset.sum_sub_distrib, Finset.sum_const, Finset.card_univ, Fintype.card_fin,
    nsmul_eq_mul, ← Finset.mul_sum, Finset.sum_ite_eq, Finset.mem_univ, if_true]
  push_cast; ring

theorem sum_J_sq : ∑ i : Fin (2 * m), ∑ j, Jm i j ^ 2 = 2 * m := by
  rw [← frob_J_J]; unfold frob; simp [sq]

theorem sum_frob_conj_phi : ∑ i : Fin (2 * m), ∑ j, frob (conj (phi i j) : M) (phi i j) = 4 * m := by
  simp only [frob_conj_phi, ← Finset.mul_sum, sum_J_sq]; ring

/-- One basis term of `‖W‖²`, in frob form. -/
theorem frob_W_W (X : M) :
    frob (WCPm X) (WCPm X) = (cA m ^ 2 + 1) * frob X X + 2 * cA m * frob (conj X) X
      + frob Jm X ^ 2 * (2 * cA m + 2 + 2 * m) := by
  have hW : ∀ Y : M, WCPm Y = cA m • Y + conj Y + frob Jm Y • Jm := fun Y => rfl
  rw [hW X]
  simp only [frob_add_l, frob_add, frob_smul_l, frob_smul]
  rw [frob_conj X (conj X), conj_conj, frob_comm X (conj X), frob_comm (conj X) Jm, frob_J_conj,
    frob_comm X Jm, frob_J_J]
  ring

/-- One basis term of `tr M³`, in frob form. -/
theorem frob_W2_W (X : M) :
    frob (WCPm (WCPm X)) (WCPm X) = ((cA m ^ 2 + 1) * cA m + 2 * cA m) * frob X X
      + ((cA m ^ 2 + 1) + 2 * cA m * cA m) * frob (conj X) X
      + frob Jm X ^ 2 * ((cA m ^ 2 + 1) + 2 * cA m + (2 * cA m + 2 + 2 * m) * (cA m + 1 + 2 * m)) := by
  have hW : ∀ Y : M, WCPm Y = cA m • Y + conj Y + frob Jm Y • Jm := fun Y => rfl
  rw [WCPm_sq, hW X]
  simp only [frob_add_l, frob_add, frob_smul_l, frob_smul]
  rw [frob_conj X (conj X), conj_conj, frob_comm X (conj X), frob_comm (conj X) Jm, frob_J_conj,
    frob_comm X Jm, frob_J_J]
  ring

/-- **`‖W_{ℂPᵐ}‖² = 12m(m² − 1)/(2m − 1)`.** -/
theorem normSq_WCPm (hm : 1 ≤ m) : normSq (WCPm (m := m)) = 12 * m * (m ^ 2 - 1) / (2 * m - 1) := by
  unfold normSq innerOp
  simp only [inner2_eq_frob, frob_W_W, Finset.sum_add_distrib, ← Finset.mul_sum, ← Finset.sum_mul, frob_phi,
    sum_frob_phi_phi, sum_frob_conj_phi]
  have hJ : ∑ i : Fin (2 * m), ∑ j, (-2 * Jm i j : ℝ) ^ 2 = (4 : ℝ) * (2 * (m : ℝ)) := by
    have e : ∀ i j : Fin (2 * m), (-2 * Jm i j : ℝ) ^ 2 = 4 * Jm i j ^ 2 := fun _ _ => by ring
    simp only [e, ← Finset.mul_sum, sum_J_sq]
  rw [hJ]
  have h2m : (2 * (m : ℝ) - 1) ≠ 0 := by
    have : (1 : ℝ) ≤ m := by exact_mod_cast hm
    linarith
  simp only [cA]; field_simp; ring

/-- **`tr M³ = 8(m² − 1)(8m⁴ − 24m² + 11m)/(2m − 1)³`** for `W_{ℂPᵐ}`. -/
theorem trCube_WCPm (hm : 1 ≤ m) :
    trCube (WCPm (m := m)) = 8 * (m ^ 2 - 1) * (8 * m ^ 4 - 24 * m ^ 2 + 11 * m) / (2 * m - 1) ^ 3 := by
  unfold trCube innerOp compOp
  simp only [inner2_eq_frob, frob_W2_W, Finset.sum_add_distrib, ← Finset.mul_sum, ← Finset.sum_mul, frob_phi,
    sum_frob_phi_phi, sum_frob_conj_phi]
  have hJ : ∑ i : Fin (2 * m), ∑ j, (-2 * Jm i j : ℝ) ^ 2 = (4 : ℝ) * (2 * (m : ℝ)) := by
    have e : ∀ i j : Fin (2 * m), (-2 * Jm i j : ℝ) ^ 2 = 4 * Jm i j ^ 2 := fun _ _ => by ring
    simp only [e, ← Finset.mul_sum, sum_J_sq]
  rw [hJ]
  have h2m : (2 * (m : ℝ) - 1) ≠ 0 := by
    have : (1 : ℝ) ≤ m := by exact_mod_cast hm
    linarith
  simp only [cA]; field_simp; ring

/-- `P(R) = ⟨R, Q(R)⟩` for any operator. -/
theorem Pcubic_eq_innerOp_Qop {ι : Type*} [Fintype ι] [DecidableEq ι] (R : Matrix ι ι ℝ → Matrix ι ι ℝ) :
    Pcubic R = innerOp R (Qop R) := by
  have hQ : Qop R = fun X => compOp R X + sharpOp R X := rfl
  unfold Pcubic trCube sharpPair
  rw [hQ, innerOp_comm R (sharpOp R), innerOp_comm R (fun X => compOp R X + sharpOp R X), FamilyLayer.innerOp_add_left]

/-- At a critical operator, `⟨R, Q(R)⟩ = θ ‖R‖²`. -/
theorem innerOp_Qop_of_critical {ι : Type*} [Fintype ι] [DecidableEq ι] (R : Matrix ι ι ℝ → Matrix ι ι ℝ)
    (th : ℝ) (hc : IsCritical R th) : innerOp R (Qop R) = th * normSq R := by
  have hc' : ∀ i j, Qop R (phi i j) = th • R (phi i j) := hc
  unfold normSq innerOp
  simp only [hc', FamilyLayer.inner2_smul_right, ← Finset.mul_sum]
  ring

/-- **`P(W_{ℂPᵐ}) = (2m + 2)‖W‖²`**, from criticality. -/
theorem Pcubic_WCPm (hm : 1 ≤ m) : Pcubic (WCPm (m := m)) = (2 * m + 2) * normSq (WCPm (m := m)) := by
  rw [Pcubic_eq_innerOp_Qop, innerOp_Qop_of_critical _ _ (WCPm_critical hm)]

theorem two_m_sub_one_ne (hm : 1 ≤ m) : (2 * (m : ℝ) - 1) ≠ 0 := by
  have : (1 : ℝ) ≤ m := by exact_mod_cast hm
  linarith

/-- **L53'S `p₃(μ)` FORM FOR `ℂPᵐ`**: `(tr M³)² = p₃(μ)² ‖W‖⁶` with `p₃(μ)² = (4m² + 2m − 11)²/(9R²)`,
`R² = 3m(m² − 1)(2m − 1)`, [L53.lean](L53.lean)'s `p3muSq`. -/
theorem p3mu_WCPm (hm : 1 ≤ m) :
    trCube (WCPm (m := m)) ^ 2 * (HamiltonsCubic.ChampionSplit.Rsq (m : ℚ) : ℝ)
      = ((HamiltonsCubic.ChampionSplit.p3muNum (m : ℚ) : ℝ) / 3) ^ 2 * normSq (WCPm (m := m)) ^ 3 := by
  rw [trCube_WCPm hm, normSq_WCPm hm]
  simp only [HamiltonsCubic.ChampionSplit.Rsq, HamiltonsCubic.ChampionSplit.p3muNum]
  push_cast
  have hd := two_m_sub_one_ne (m := m) hm
  have hd' : (m : ℝ) * 2 - 1 ≠ 0 := by rw [mul_comm]; exact hd
  field_simp [hd]
  ring

/-- **L53'S `θ²(ℂPᵐ)`**: `P² = θ² ‖W‖⁶` with `θ² = (m + 1)(2m − 1)/(3m(m − 1))`, [L53.lean](L53.lean)'s `thetaSq`,
at `m ≥ 2`. -/
theorem thetaSq_WCPm (hm : 2 ≤ m) :
    Pcubic (WCPm (m := m)) ^ 2 = (HamiltonsCubic.ChampionSplit.thetaSq (m : ℚ) : ℝ) * normSq (WCPm (m := m)) ^ 3 := by
  rw [Pcubic_WCPm (by omega), normSq_WCPm (by omega)]
  simp only [HamiltonsCubic.ChampionSplit.thetaSq]
  push_cast
  have h1 := two_m_sub_one_ne (m := m) (by omega)
  have hmR : (2 : ℝ) ≤ m := by exact_mod_cast hm
  have h2 : (m : ℝ) - 1 ≠ 0 := by linarith
  have h3 : (m : ℝ) ≠ 0 := by linarith
  field_simp
  ring

/-- **`tr_{S²} W̊³ = −216m(m² − 1)/(2m − 1)²`** for `W_{ℂPᵐ}`, from the bi-spectral identity. -/
theorem trS2_cube_WCPm (hm : 1 ≤ m) :
    HamiltonsCubic.SecondKind.trS2 (fun h => HamiltonsCubic.SecondKind.ringW (WCPm (m := m))
      (HamiltonsCubic.SecondKind.ringW WCPm (HamiltonsCubic.SecondKind.ringW WCPm h)))
      = -216 * m * (m ^ 2 - 1) / (2 * m - 1) ^ 2 := by
  have hW := WCPm_isWeylOp (m := m) hm
  have hb := HamiltonsCubic.L50Spectra.L50_bispectral (WCPm (m := m)) hW.1 hW.2.1 hW.2.2.1 hW.2.2.2.1
  rw [Pcubic_WCPm hm, normSq_WCPm hm, trCube_WCPm hm] at hb
  have hd := two_m_sub_one_ne (m := m) hm
  have e : HamiltonsCubic.SecondKind.trS2 (fun h => HamiltonsCubic.SecondKind.ringW (WCPm (m := m))
      (HamiltonsCubic.SecondKind.ringW WCPm (HamiltonsCubic.SecondKind.ringW WCPm h)))
      = 3 * (8 * (m ^ 2 - 1) * (8 * m ^ 4 - 24 * m ^ 2 + 11 * m) / (2 * m - 1) ^ 3)
        - 2 * ((2 * m + 2) * (12 * m * (m ^ 2 - 1) / (2 * m - 1))) := by linarith
  rw [e, div_eq_mul_inv, div_eq_mul_inv, div_eq_mul_inv, ← inv_pow, ← inv_pow]
  have hu : (2 * (m : ℝ) - 1) * (2 * (m : ℝ) - 1)⁻¹ = 1 := mul_inv_cancel₀ hd
  set u := (2 * (m : ℝ) - 1)⁻¹
  linear_combination (-216 * (m : ℝ) * ((m : ℝ) ^ 2 - 1) * u ^ 2
    + 2 * (2 * (m : ℝ) + 2) * (12 * (m : ℝ) * ((m : ℝ) ^ 2 - 1)) * u * ((2 * (m : ℝ) - 1) * u + 1)) * hu

/-- **L53'S `p₃(ω)` FORM FOR `ℂPᵐ`**: `(tr_{S²} W̊³)² R² = 81 ‖W‖⁶` and `tr_{S²} W̊³ < 0`, which is `p₃(ω) = −9/R`
at unit norm, `m ≥ 2`. -/
theorem p3omega_WCPm (hm : 2 ≤ m) :
    HamiltonsCubic.SecondKind.trS2 (fun h => HamiltonsCubic.SecondKind.ringW (WCPm (m := m))
      (HamiltonsCubic.SecondKind.ringW WCPm (HamiltonsCubic.SecondKind.ringW WCPm h))) ^ 2
      * (HamiltonsCubic.ChampionSplit.Rsq (m : ℚ) : ℝ) = 81 * normSq (WCPm (m := m)) ^ 3 ∧
    HamiltonsCubic.SecondKind.trS2 (fun h => HamiltonsCubic.SecondKind.ringW (WCPm (m := m))
      (HamiltonsCubic.SecondKind.ringW WCPm (HamiltonsCubic.SecondKind.ringW WCPm h))) < 0 := by
  rw [trS2_cube_WCPm (by omega), normSq_WCPm (by omega)]
  have hd := two_m_sub_one_ne (m := m) (by omega)
  have hmR : (2 : ℝ) ≤ m := by exact_mod_cast hm
  refine ⟨?_, ?_⟩
  · simp only [HamiltonsCubic.ChampionSplit.Rsq]
    push_cast
    field_simp
    ring
  · have hpos : 0 < (2 * (m : ℝ) - 1) ^ 2 := by positivity
    rw [div_neg_iff]
    right
    refine ⟨?_, hpos⟩
    nlinarith

end HamiltonsCubic.L70CPm
