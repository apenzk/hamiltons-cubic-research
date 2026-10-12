import Mathlib
import HamiltonsCubic.Results.L227Attain
import HamiltonsCubic.Results.L57Attain

set_option linter.style.longLine false

/-!
# L228's attainment: `Θₙ` is attained in the block family at every `n ≥ 4`

[findings/second-order.md](../../../findings/second-order.md), Lemma L228: *"In items 3 and 4 the value $\Theta_n$ is
attained in $\mathcal D_n\subseteq\mathcal S_J$."* A sphere-product weight on `Fin 3 ⊕ Fin m` is a Ricci-flat block
operator with diagonal blocks ([L227Attain.lean](L227Attain.lean)), and at the balanced split its value is `Θₙ`. This
file:

* `block_sphere`: every unit sphere product `S^p × S^q` on `Fin 3 ⊕ Fin m`, `p, q ≥ 2`, is a unit Ricci-flat block
  operator with diagonal blocks and `P = θ_{p,q}`;
* `L228_attained_even`, `L228_attained_odd`: at even `n = m + 3 ≥ 4` some such operator has `P = θ₀(n)`, and at odd
  `n ≥ 5` some has `P = Θₙ`, the odd constant.
-/

namespace HamiltonsCubic.L228Attain

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.L226Statement HamiltonsCubic.L226Mixed
  HamiltonsCubic.L57Block HamiltonsCubic.L227Attain

variable {m : ℕ}

/-- **A unit sphere product in the block family.** -/
theorem block_sphere (T : Finset (Fin 3 ⊕ Fin m)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) :
    ∃ (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (K : Fin m → Fin m → ℝ),
      S.IsSymm ∧ (∀ a, (M a).IsSymm) ∧ (∀ a b, K a b = K b a) ∧ (∀ a, K a a = 0) ∧
      (∀ i j, Ric (blockOp S M K) i j = 0) ∧ (∀ a, S * M a = M a * S) ∧ (∀ a b, M a * M b = M b * M a) ∧
      normSq (blockOp S M K) = 1 ∧
      Pcubic (blockOp S M K) = HamiltonsCubic.FamilyLayer.thetaSplit (T.card : ℝ) (Tᶜ.card : ℝ) := by
  obtain ⟨t, ht, hn⟩ := sphere_unit_block T hp hq
  set w := t • HamiltonsCubic.FamilyLayer.sphereWeight T with hwdef
  have hw : HamiltonsCubic.FamilyLayer.IsWeight w := (HamiltonsCubic.FamilyLayer.sphereWeight_isWeight T hp hq).smul t
  have hθ := HamiltonsCubic.FamilyLayer.theta_sphereProduct_value T hp hq t ht hn
  have hnorm1 : HamiltonsCubic.RealLayer.norm (HamiltonsCubic.FamilyLayer.diagOp w) = 1 := by
    unfold HamiltonsCubic.RealLayer.norm; rw [hn, Real.sqrt_one]
  have hP : Pcubic (HamiltonsCubic.FamilyLayer.diagOp w) = HamiltonsCubic.FamilyLayer.thetaSplit (T.card : ℝ) (Tᶜ.card : ℝ) := by
    unfold HamiltonsCubic.RealLayer.theta at hθ
    rw [hnorm1, one_pow, div_one] at hθ
    exact hθ
  obtain ⟨hPB, hNB⟩ := Pcubic_norm_blocks w hw
  refine ⟨Sw w, Mw w, Kw w, diag_isSymm _, fun a => diag_isSymm _, fun a b => hw.symm _ _, fun a => hw.hollow _,
    ricci_blocks w hw, fun a => ?_, fun a b => ?_, by rw [hNB, hn], by rw [hPB, hP]⟩
  · simp only [Sw, Mw, Matrix.diagonal_mul_diagonal, mul_comm]
  · simp only [Mw, Matrix.diagonal_mul_diagonal, mul_comm]

theorem exists_card (k : ℕ) (hk : k ≤ m + 3) :
    ∃ T : Finset (Fin 3 ⊕ Fin m), T.card = k ∧ Tᶜ.card = m + 3 - k := by
  obtain ⟨T, -, hT⟩ := Finset.exists_subset_card_eq (s := (Finset.univ : Finset (Fin 3 ⊕ Fin m))) (n := k)
    (by rw [Finset.card_univ, Fintype.card_sum, Fintype.card_fin, Fintype.card_fin]; omega)
  refine ⟨T, hT, ?_⟩
  rw [Finset.card_compl, hT, Fintype.card_sum, Fintype.card_fin, Fintype.card_fin]
  omega

/-- **`θ₀(n)` is attained in the block family at even `n = m + 3 ≥ 4`.** -/
theorem L228_attained_even (hm : 1 ≤ m) (heven : Even (m + 3)) :
    ∃ (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (K : Fin m → Fin m → ℝ),
      S.IsSymm ∧ (∀ a, (M a).IsSymm) ∧ (∀ a b, K a b = K b a) ∧ (∀ a, K a a = 0) ∧
      (∀ i j, Ric (blockOp S M K) i j = 0) ∧ (∀ a, S * M a = M a * S) ∧ (∀ a b, M a * M b = M b * M a) ∧
      normSq (blockOp S M K) = 1 ∧
      Pcubic (blockOp S M K) = Real.sqrt (2 * (((m : ℝ) + 3) - 1) * (((m : ℝ) + 3) - 2)) / ((m : ℝ) + 3) := by
  obtain ⟨k, hk⟩ := heven
  obtain ⟨T, hT, hTc⟩ := exists_card (m := m) k (by omega)
  have hTc' : Tᶜ.card = k := by rw [hTc]; omega
  obtain ⟨S, M, K, h1, h2, h3, h4, h5, h6, h7, h8, h9⟩ :=
    block_sphere T (by rw [hT]; omega) (by rw [hTc']; omega)
  refine ⟨S, M, K, h1, h2, h3, h4, h5, h6, h7, h8, ?_⟩
  rw [h9, hT, hTc']
  have hkR : (2 : ℝ) ≤ k := by exact_mod_cast (show 2 ≤ k by omega)
  have hmk : (m : ℝ) + 3 = 2 * k := by
    have : ((m + 3 : ℕ) : ℝ) = ((k + k : ℕ) : ℝ) := by rw [hk]
    push_cast at this; linarith
  unfold HamiltonsCubic.FamilyLayer.thetaSplit
  rw [HamiltonsCubic.FamilyLayer.thetaSplitSq_balanced (k : ℝ) (by positivity) (by linarith), hmk]
  unfold HamiltonsCubic.FamilyLayer.theta0Sq
  have hpos : (0 : ℝ) < 2 * k := by positivity
  rw [Real.sqrt_div' _ (by positivity), Real.sqrt_sq hpos.le]

/-- **The odd `Θₙ` is attained in the block family at odd `n = m + 3 ≥ 5`.** -/
theorem L228_attained_odd (hm : 2 ≤ m) (hodd : ¬ Even (m + 3)) :
    ∃ (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (K : Fin m → Fin m → ℝ),
      S.IsSymm ∧ (∀ a, (M a).IsSymm) ∧ (∀ a b, K a b = K b a) ∧ (∀ a, K a a = 0) ∧
      (∀ i j, Ric (blockOp S M K) i j = 0) ∧ (∀ a, S * M a = M a * S) ∧ (∀ a b, M a * M b = M b * M a) ∧
      normSq (blockOp S M K) = 1 ∧
      Pcubic (blockOp S M K) = Real.sqrt (HamiltonsCubic.L57Critical.thetaOddSq ((m : ℝ) + 3)) := by
  obtain ⟨k, hk⟩ := Nat.odd_iff.mpr (Nat.not_even_iff.mp hodd)
  obtain ⟨T, hT, hTc⟩ := exists_card (m := m) k (by omega)
  have hTc' : Tᶜ.card = k + 1 := by rw [hTc]; omega
  obtain ⟨S, M, K, h1, h2, h3, h4, h5, h6, h7, h8, h9⟩ :=
    block_sphere T (by rw [hT]; omega) (by rw [hTc']; omega)
  refine ⟨S, M, K, h1, h2, h3, h4, h5, h6, h7, h8, ?_⟩
  rw [h9, hT, hTc']
  have hkR : (2 : ℝ) ≤ k := by exact_mod_cast (show 2 ≤ k by omega)
  have hmk : (m : ℝ) + 3 = 2 * k + 1 := by
    have : ((m + 3 : ℕ) : ℝ) = ((2 * k + 1 : ℕ) : ℝ) := by rw [hk]
    push_cast at this; linarith
  unfold HamiltonsCubic.FamilyLayer.thetaSplit
  push_cast
  rw [HamiltonsCubic.FamilyLayer.thetaSplitSq_odd (k : ℝ) (by positivity) (by positivity) (by linarith), hmk,
    HamiltonsCubic.L57Critical.thetaOddSq_eq]

end HamiltonsCubic.L228Attain
