import Mathlib
import HamiltonsCubic.Results.FourN12
import HamiltonsCubic.Results.L57Attain

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L220's `n ≥ 12` clause as a supremum: `sup P = Θₙ` on `𝒮_Q`, attained, and only on `𝒟ₙ`

[findings/second-order.md](../../../findings/second-order.md), Lemma L220: *Hence at $n\ge12$, $\sup P=\Theta_n$ on the unit
sphere of $\mathcal S_Q$, attained only on $\mathcal D_n$.* … *$\Theta_n$ is attained in $\mathcal D_n$ by the balanced
product ([Nienhaus Proposition 2.25](problem.md)).*

[FourN12.lean](FourN12.lean) gives the bound and its equality on `𝒟ₙ`. The attainment is the sphere product
`t · sphereWeight T` at the balanced split, `|T| = n/2` at even `n` and `|T| = (n-1)/2` at odd `n`, carried from `𝒟ₙ` to
`𝒮_Q ∩ 𝒲ₙ` as an element with zero `V_Q` component.

* `diag_mem`: a unit weight `w` gives a unit element of `𝒮_Q ∩ 𝒲ₙ` with `P = P(diagOp w)`;
* `attained_even`, `attained_odd`: a unit element of `𝒮_Q ∩ 𝒲ₙ` with `P = θ₀(n)` at even `n ≥ 4`, and with
  `P = √(thetaOddSq n)` at odd `n ≥ 5`;
* **`L220_sup_even`**, **`L220_sup_odd`**: at even `n ≥ 12`, and at odd `n ≥ 13`, `Θₙ` bounds `P` on the unit sphere of
  `𝒮_Q ∩ 𝒲ₙ`, is attained there, and is attained only at elements of character `1`, which lie in `𝒟ₙ`.
-/

namespace HamiltonsCubic.FourSup

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L2Operators
  HamiltonsCubic.PairSquare HamiltonsCubic.L120Blocks HamiltonsCubic.SubFermat HamiltonsCubic.L221Ops
  HamiltonsCubic.FourN12 HamiltonsCubic.L120Hess HamiltonsCubic.TensorBridge HamiltonsCubic.Results

variable {n : ℕ} {i j k l : Fin n}

/-- **A unit weight is a unit element of `𝒮_Q ∩ 𝒲ₙ`** with zero `V_Q` component and the same `P`. -/
theorem diag_mem (t : Finset (Fin n)) {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) (hu : normSq (diagOp w) = 1) :
    ∃ W : CurvOp2 (Fin n), normSq2 W = 1 ∧ W ∈ SW t ∧ Pcubic2 W = Pcubic (diagOp w) := by
  refine ⟨restrict (diagOp_isWeyl hw), by rw [normSq2_restrict (isLinOp_diagOp w)]; exact hu,
    ⟨isWeyl2_restrict _, restrict (diagOp_isWeyl hw), 0, ?_, signChar_zero _,
      (add_zero (restrict (diagOp_isWeyl hw) : CurvOp2 (Fin n))).symm⟩,
    Pcubic2_restrict (isLinOp_diagOp w) _⟩
  exact (L120Ident.trivial_block_iff _ (isWeyl2_restrict _)).mpr ⟨_, hw, rfl⟩

/-- `P(diagOp w) = θ(diagOp w)` at a unit weight. -/
theorem P_eq_theta {w : Matrix (Fin n) (Fin n) ℝ} (hu : normSq (diagOp w) = 1) :
    Pcubic (diagOp w) = theta (diagOp w) := by
  have hnorm1 : HamiltonsCubic.RealLayer.norm (diagOp w) = 1 := by
    unfold HamiltonsCubic.RealLayer.norm; rw [hu, Real.sqrt_one]
  unfold theta; rw [hnorm1, one_pow, div_one]

/-- **`θ₀(n)` is attained on the unit sphere of `𝒮_Q ∩ 𝒲ₙ`** at even `n ≥ 4`, by the balanced sphere product. -/
theorem attained_even (t : Finset (Fin n)) (hn : 4 ≤ n) (heven : Even n) :
    ∃ W : CurvOp2 (Fin n), normSq2 W = 1 ∧ W ∈ SW t ∧
      Pcubic2 W = Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / (n : ℝ) := by
  obtain ⟨m, hm⟩ := heven
  obtain ⟨T, -, hT⟩ := Finset.exists_subset_card_eq (s := (Finset.univ : Finset (Fin n))) (n := m)
    (by rw [Finset.card_univ, Fintype.card_fin]; omega)
  have hTc : Tᶜ.card = m := by rw [Finset.card_compl, hT, Fintype.card_fin]; omega
  have hp : 2 ≤ T.card := by rw [hT]; omega
  have hq : 2 ≤ Tᶜ.card := by rw [hTc]; omega
  obtain ⟨c, hc, hu⟩ := sphere_unit T hp hq
  obtain ⟨W, hW1, hWS, hWP⟩ := diag_mem t ((sphereWeight_isWeight T hp hq).smul c) hu
  refine ⟨W, hW1, hWS, ?_⟩
  rw [hWP, P_eq_theta hu, theta_sphereProduct_value T hp hq c hc hu, hT, hTc, thetaSplit]
  have hmR : (2 : ℝ) ≤ m := by exact_mod_cast (show 2 ≤ m by omega)
  have hnR : (n : ℝ) = 2 * m := by
    have : ((n : ℕ) : ℝ) = ((m + m : ℕ) : ℝ) := by rw [hm]
    push_cast at this; linarith
  rw [thetaSplitSq_balanced (m : ℝ) (by positivity) (by linarith), hnR]
  unfold theta0Sq
  have hpos : (0 : ℝ) < 2 * m := by positivity
  rw [Real.sqrt_div' _ (by positivity), Real.sqrt_sq hpos.le]

/-- **The odd `Θₙ` is attained on the unit sphere of `𝒮_Q ∩ 𝒲ₙ`** at odd `n ≥ 5`, by the `(m, m+1)` sphere product. -/
theorem attained_odd (t : Finset (Fin n)) (hn : 5 ≤ n) (hodd : ¬ Even n) :
    ∃ W : CurvOp2 (Fin n), normSq2 W = 1 ∧ W ∈ SW t ∧
      Pcubic2 W = Real.sqrt (L57Critical.thetaOddSq (n : ℝ)) := by
  obtain ⟨m, hm⟩ := Nat.odd_iff.mpr (Nat.not_even_iff.mp hodd)
  obtain ⟨T, -, hT⟩ := Finset.exists_subset_card_eq (s := (Finset.univ : Finset (Fin n))) (n := m)
    (by rw [Finset.card_univ, Fintype.card_fin]; omega)
  have hTc : Tᶜ.card = m + 1 := by rw [Finset.card_compl, hT, Fintype.card_fin]; omega
  have hp : 2 ≤ T.card := by rw [hT]; omega
  have hq : 2 ≤ Tᶜ.card := by rw [hTc]; omega
  obtain ⟨c, hc, hu⟩ := sphere_unit T hp hq
  obtain ⟨W, hW1, hWS, hWP⟩ := diag_mem t ((sphereWeight_isWeight T hp hq).smul c) hu
  refine ⟨W, hW1, hWS, ?_⟩
  rw [hWP, P_eq_theta hu, theta_sphereProduct_value T hp hq c hc hu, hT, hTc, thetaSplit]
  have hmR : (2 : ℝ) ≤ m := by exact_mod_cast (show 2 ≤ m by omega)
  have hnR : (n : ℝ) = 2 * m + 1 := by
    have : ((n : ℕ) : ℝ) = ((2 * m + 1 : ℕ) : ℝ) := by rw [hm]
    push_cast at this; linarith
  rw [hnR, L57Critical.thetaOddSq_eq]
  push_cast
  rw [thetaSplitSq_odd (m : ℝ) (by positivity) (by positivity) (by linarith)]

section
variable (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
include hij hik hil hjk hjl hkl

/-- **L220's `n ≥ 12` clause at even `n`**: `θ₀(n) = Θₙ` bounds `P` on the unit sphere of `𝒮_Q ∩ 𝒲ₙ`, is attained there,
and is attained only at elements of character `1`, which lie in `𝒟ₙ`. -/
theorem L220_sup_even (hn : 12 ≤ n) (heven : Even n) :
    (∀ W : CurvOp2 (Fin n), normSq2 W = 1 → W ∈ SW ({i, j, k, l} : Finset (Fin n)) →
        Pcubic2 W ≤ Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / (n : ℝ)) ∧
      (∃ W : CurvOp2 (Fin n), normSq2 W = 1 ∧ W ∈ SW ({i, j, k, l} : Finset (Fin n)) ∧
        Pcubic2 W = Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / (n : ℝ)) ∧
      (∀ W : CurvOp2 (Fin n), normSq2 W = 1 → W ∈ SW ({i, j, k, l} : Finset (Fin n)) →
        Pcubic2 W = Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / (n : ℝ) → SignChar (fun _ => 1) W) :=
  ⟨fun _ hW1 hWS => (L220_n12_even hij hik hil hjk hjl hkl hn hW1 hWS).1, attained_even _ (by omega) heven,
    fun _ hW1 hWS => (L220_n12_even hij hik hil hjk hjl hkl hn hW1 hWS).2⟩

/-- **L220's `n ≥ 12` clause at odd `n`**: `√(thetaOddSq n) = Θₙ` bounds `P` on the unit sphere of `𝒮_Q ∩ 𝒲ₙ` at odd
`n ≥ 13`, is attained there, and is attained only at elements of character `1`. -/
theorem L220_sup_odd (hn : 13 ≤ n) (hodd : ¬ Even n) :
    (∀ W : CurvOp2 (Fin n), normSq2 W = 1 → W ∈ SW ({i, j, k, l} : Finset (Fin n)) →
        Pcubic2 W ≤ Real.sqrt (L57Critical.thetaOddSq (n : ℝ))) ∧
      (∃ W : CurvOp2 (Fin n), normSq2 W = 1 ∧ W ∈ SW ({i, j, k, l} : Finset (Fin n)) ∧
        Pcubic2 W = Real.sqrt (L57Critical.thetaOddSq (n : ℝ))) ∧
      (∀ W : CurvOp2 (Fin n), normSq2 W = 1 → W ∈ SW ({i, j, k, l} : Finset (Fin n)) →
        Pcubic2 W = Real.sqrt (L57Critical.thetaOddSq (n : ℝ)) → SignChar (fun _ => 1) W) :=
  ⟨fun _ hW1 hWS => (L220_n12_odd hij hik hil hjk hjl hkl hn hodd hW1 hWS).1, attained_odd _ (by omega) hodd,
    fun _ hW1 hWS => (L220_n12_odd hij hik hil hjk hjl hkl hn hodd hW1 hWS).2⟩

end

end HamiltonsCubic.FourSup
