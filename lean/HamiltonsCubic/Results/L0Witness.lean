import HamiltonsCubic.Results.L66Positive
import HamiltonsCubic.Results.WeylMaximiser
import HamiltonsCubic.Results.L57Attain

set_option linter.style.longLine false

/-!
# L0's lower half: the sphere product is a witness at `P = Θₙ` on the unit Weyl sphere

[findings/problem.md](../../../findings/problem.md), Lemma L0: *`sup P = Θₙ` on the unit sphere of `𝒲ₙ` is equivalent to
`P ≤ Θₙ` at every critical point.* `L0_critical_reduction` ([WeylMaximiser.lean](WeylMaximiser.lean)) proves the
`sup ≤ Θ` form; **the lower half is the balanced-split witness**, which [L57Attain.lean](L57Attain.lean) types on the
diagonal operator layer. **This file carries it to the Weyl sphere of `L0_critical_reduction`**:

- `Pcubic2_restrict`, `normSq2_restrict`: at every linear Weyl `W`, `P` and `‖·‖²` of its restriction are `W`'s, the
  bridge `Wc` used, stated for every `W`;
- `L0_witness_even`, `L0_witness_odd`: **a point of the unit Weyl sphere with `P = Θₙ`**, at `n = 2m` and `n = 2m + 1`,
  `m ≥ 2`;
- `L0_sup_even`, `L0_sup_odd`: **so `Θₙ` is the greatest value of `P` on the unit Weyl sphere iff `P ≤ Θₙ` at every
  critical point**, both halves.
-/

namespace HamiltonsCubic.RealLayer

open HamiltonsCubic.TensorBridge HamiltonsCubic.FamilyLayer HamiltonsCubic.L57Critical HamiltonsCubic.L2Operators
open HamiltonsCubic.CP2Real HamiltonsCubic.L66Statement
open scoped NNReal Matrix.Norms.Frobenius OperatorNorm

variable {n : ℕ}

theorem restrict_eq_restrictLin' {W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} (hL : IsLinOp W)
    (hW : IsWeyl W) : restrict hW = restrictLin hL hW.1 :=
  ContinuousLinearMap.ext fun _ => rfl

theorem Pcubic2_restrict {W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} (hL : IsLinOp W)
    (hW : IsWeyl W) : Pcubic2 (restrict hW) = Pcubic W := by
  rw [restrict_eq_restrictLin' hL hW, Pcubic2_eq_innerOp2, innerOp2_comm, ← foxProd2_self]
  have h := foxTri_eq_foxTri2_restrictLin hL hW.1 hL hW.1 hL hW.1
  rw [foxTri_self _ hL] at h
  rw [h]; rfl

theorem normSq2_restrict {W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} (hL : IsLinOp W)
    (hW : IsWeyl W) : normSq2 (restrict hW) = normSq W := by
  rw [← normSq_extend, restrict_eq_restrictLin' hL hW]
  unfold normSq innerOp
  refine congrArg (fun x => (1 / 2 : ℝ) * x) ?_
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  rw [extend_restrictLin_on_skew _ _ _ (phi_isSkew i j)]

theorem diagOp_isLinOp' (w : Matrix (Fin n) (Fin n) ℝ) : IsLinOp (diagOp w) :=
  ⟨fun X Y => by ext a b; simp [diagOp, mul_add], fun c X => by ext a b; simp [diagOp]; ring⟩

/-- A unit linear Weyl operator gives a point of the unit Weyl sphere with the same `P`. -/
theorem witness_of_unit {W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} (hL : IsLinOp W)
    (hW : IsWeyl W) (h1 : normSq W = 1) :
    ∃ R ∈ weylSphereSet (Fin n), Pcubic2 R = Pcubic W := by
  refine ⟨restrict hW, ⟨?_, isWeyl2_restrict hW⟩, Pcubic2_restrict hL hW⟩
  rw [normSq2_restrict hL hW, h1]

/-- A unit sphere product gives a point of the unit Weyl sphere with `P = θ`. -/
theorem witness_sphere (S : Finset (Fin n)) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) (t : ℝ)
    (hn1 : normSq (diagOp (t • sphereWeight S)) = 1) :
    ∃ R ∈ weylSphereSet (Fin n), Pcubic2 R = theta (diagOp (t • sphereWeight S)) := by
  have hw := (sphereWeight_isWeight S hp hq).smul t
  rw [theta_of_unit _ hn1]
  exact witness_of_unit (diagOp_isLinOp' _) (diagOp_isWeyl hw) hn1

/-- **L0's witness at even `n = 2m`**: a point of the unit Weyl sphere with `P = √(2(n−1)(n−2))/n = Θₙ`. -/
theorem L0_witness_even (m : ℕ) (hm : 2 ≤ m) :
    ∃ R ∈ weylSphereSet (Fin (2 * m)),
      Pcubic2 R = Real.sqrt (2 * (((2 * m : ℕ) : ℝ) - 1) * (((2 * m : ℕ) : ℝ) - 2)) / ((2 * m : ℕ) : ℝ) := by
  have hle : m ≤ 2 * m := by omega
  have hS : (firstP (2 * m) m).card = m := card_firstP hle
  have hSc : (firstP (2 * m) m)ᶜ.card = m := by rw [card_compl_firstP hle]; omega
  have hp : 2 ≤ (firstP (2 * m) m).card := by rw [hS]; exact hm
  have hq : 2 ≤ (firstP (2 * m) m)ᶜ.card := by rw [hSc]; exact hm
  obtain ⟨t, ht, hn⟩ := HamiltonsCubic.L2Operators.sphere_unit (firstP (2 * m) m) hp hq
  obtain ⟨R, hR, hP⟩ := witness_sphere _ hp hq t hn
  refine ⟨R, hR, hP.trans ?_⟩
  rw [theta_sphereProduct_value _ hp hq t ht hn, hS, hSc, thetaSplit]
  have hmR : (2 : ℝ) ≤ m := by exact_mod_cast hm
  rw [thetaSplitSq_balanced (m : ℝ) (by positivity) (by linarith)]
  unfold theta0Sq
  push_cast
  have hpos : (0 : ℝ) < 2 * m := by positivity
  rw [Real.sqrt_div' _ (by positivity), Real.sqrt_sq hpos.le]

/-- **L0's witness at odd `n = 2m + 1`**: a point of the unit Weyl sphere with `P = √(thetaOddSq n) = Θₙ`. -/
theorem L0_witness_odd (m : ℕ) (hm : 2 ≤ m) :
    ∃ R ∈ weylSphereSet (Fin (2 * m + 1)), Pcubic2 R = Real.sqrt (thetaOddSq ((2 * m + 1 : ℕ) : ℝ)) := by
  have hle : m ≤ 2 * m + 1 := by omega
  have hS : (firstP (2 * m + 1) m).card = m := card_firstP hle
  have hSc : (firstP (2 * m + 1) m)ᶜ.card = m + 1 := by rw [card_compl_firstP hle]; omega
  have hp : 2 ≤ (firstP (2 * m + 1) m).card := by rw [hS]; exact hm
  have hq : 2 ≤ (firstP (2 * m + 1) m)ᶜ.card := by rw [hSc]; omega
  obtain ⟨t, ht, hn⟩ := HamiltonsCubic.L2Operators.sphere_unit (firstP (2 * m + 1) m) hp hq
  obtain ⟨R, hR, hP⟩ := witness_sphere _ hp hq t hn
  refine ⟨R, hR, hP.trans ?_⟩
  rw [theta_sphereProduct_value _ hp hq t ht hn, hS, hSc, thetaSplit]
  congr 1
  have hmR : (2 : ℝ) ≤ m := by exact_mod_cast hm
  rw [thetaOddSq_eq]
  push_cast
  exact thetaSplitSq_odd (m : ℝ) (by positivity) (by positivity) (by linarith)

/-- **L0 at even `n`, both halves**: `Θₙ` is the greatest value of `P` on the unit Weyl sphere iff `P ≤ Θₙ` at every
critical point. -/
theorem L0_sup_even (m : ℕ) (hm : 2 ≤ m) (hnm : n = 2 * m) :
    IsGreatest (Pcubic2 '' weylSphereSet (Fin n))
        (Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / (n : ℝ)) ↔
      ∀ R ∈ weylSphereSet (Fin n), Qop2 R = Pcubic2 R • R →
        Pcubic2 R ≤ Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / (n : ℝ) := by
  rw [← L0_critical_reduction (by omega)]
  subst hnm
  obtain ⟨R₀, hR₀, hP₀⟩ := L0_witness_even m hm
  constructor
  · rintro ⟨-, hub⟩ R hR; exact hub ⟨R, hR, rfl⟩
  · intro h; exact ⟨⟨R₀, hR₀, hP₀⟩, by rintro _ ⟨R, hR, rfl⟩; exact h R hR⟩

/-- **L0 at odd `n`, both halves.** -/
theorem L0_sup_odd (m : ℕ) (hm : 2 ≤ m) (hnm : n = 2 * m + 1) :
    IsGreatest (Pcubic2 '' weylSphereSet (Fin n)) (Real.sqrt (thetaOddSq (n : ℝ))) ↔
      ∀ R ∈ weylSphereSet (Fin n), Qop2 R = Pcubic2 R • R → Pcubic2 R ≤ Real.sqrt (thetaOddSq (n : ℝ)) := by
  rw [← L0_critical_reduction (by omega)]
  subst hnm
  obtain ⟨R₀, hR₀, hP₀⟩ := L0_witness_odd m hm
  constructor
  · rintro ⟨-, hub⟩ R hR; exact hub ⟨R, hR, rfl⟩
  · intro h; exact ⟨⟨R₀, hR₀, hP₀⟩, by rintro _ ⟨R, hR, rfl⟩; exact h R hR⟩

end HamiltonsCubic.RealLayer
