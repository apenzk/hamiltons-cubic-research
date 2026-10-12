import Mathlib
import HamiltonsCubic.Results.L228Item3

set_option linter.style.longLine false

/-!
# L227: every Ricci-flat `W ∈ 𝒮_J` at `n = 5` has `P(W) ≤ Θ₅ ‖W‖³`

[findings/second-order.md](../../../findings/second-order.md), Lemma L227: *"Every unit $W\in\mathcal S_J\cap\mathcal W_5$
has $P(W)\le\Theta_5=\tfrac{2\sqrt2}3$"*, and Lemma L228: *"At $m\le2$ item 3 covers every $W$."* With at most two
outer blocks, the one block besides `X_0` is diagonalised by the spectral theorem, so
[L228Item3.lean](L228Item3.lean)'s `L228_item3` applies to every Ricci-flat block operator. This file:

* `exists_diag_frame`: a symmetric `3 × 3` matrix is diagonal in some orthonormal frame;
* `blockOp_normal_form`: a Ricci-flat `blockOp S M K` with symmetric blocks is `blockOp (X - ½μ I) (t_a I + X_a) K`
  with `t_a = tr M_a / 3` and `X_a = M_a - t_a I` traceless;
* `L57_block_le_two_of`: with at most two outer blocks, every Ricci-flat block operator with symmetric blocks obeys
  every bound its diagonal tensors obey;
* `L57_block_n4`, `L227_full`: so `P(W) ≤ Θ₄ ‖W‖³` at `n = 4` and `P(W) ≤ Θ₅ ‖W‖³`, `Θ₅ = 2√2/3`, at `n = 5`,
  L227's bound, through `L57_diagonal_odd`'s odd constant.
-/

namespace HamiltonsCubic.L227Full

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.L226Statement HamiltonsCubic.L228Statement
  HamiltonsCubic.L228Item1 HamiltonsCubic.L228Item3 HamiltonsCubic.L226Mixed HamiltonsCubic.L227Alignment
  HamiltonsCubic.L57Block

variable {m : ℕ}

/-- **A symmetric matrix is diagonal in some orthonormal frame.** -/
theorem exists_diag_frame (A : Matrix (Fin 3) (Fin 3) ℝ) (hA : A.IsSymm) :
    ∃ F : Matrix (Fin 3) (Fin 3) ℝ, Fᵀ * F = 1 ∧ F * Fᵀ = 1 ∧ DiagIn F A := by
  have hAH := isHermitian_of_isSymm hA
  have hAd := spectral_real hAH
  have hQ₁ := orth_tr_mul hAH.eigenvectorUnitary.2
  have hQ₂ := orth_mul_tr hAH.eigenvectorUnitary.2
  generalize (hAH.eigenvectorUnitary : Matrix (Fin 3) (Fin 3) ℝ) = Q at hAd hQ₁ hQ₂
  generalize hAH.eigenvalues = y at hAd
  refine ⟨Q, hQ₁, hQ₂, fun x z h => ?_⟩
  rw [hAd, show Qᵀ * (Q * diagonal y * Qᵀ) * Q = (Qᵀ * Q) * diagonal y * (Qᵀ * Q) by simp only [Matrix.mul_assoc],
    hQ₁, Matrix.one_mul, Matrix.mul_one, Matrix.diagonal_apply_ne _ h]

/-- **The normal form of a Ricci-flat block operator.** -/
theorem blockOp_normal_form (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm)
    (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (hRic : ∀ i j, Ric (blockOp S M K) i j = 0) :
    ∃ (t : Fin m → ℝ) (Xs : Fin m → Matrix (Fin 3) (Fin 3) ℝ),
      (∀ a, (Xs a).trace = 0) ∧ (∀ a, (Xs a).IsSymm) ∧
      M = (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) ∧
      S = ∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ) := by
  set t : Fin m → ℝ := fun a => (M a).trace / 3 with ht
  set Xs : Fin m → Matrix (Fin 3) (Fin 3) ℝ := fun a => M a - t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) with hXsd
  refine ⟨t, Xs, ?_⟩
  have hXtr : ∀ a, (Xs a).trace = 0 := fun a => by
    show (M a - ((M a).trace / 3) • (1 : Matrix (Fin 3) (Fin 3) ℝ)).trace = 0
    rw [Matrix.trace_sub, Matrix.trace_smul, Matrix.trace_one, Fintype.card_fin, smul_eq_mul]
    push_cast; ring
  have hXs : ∀ a, (Xs a).IsSymm := fun a => by
    show (M a - ((M a).trace / 3) • (1 : Matrix (Fin 3) (Fin 3) ℝ)).IsSymm
    unfold Matrix.IsSymm
    rw [Matrix.transpose_sub, Matrix.transpose_smul, Matrix.transpose_one, (hM a).eq]
  have hMeq : M = (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) := by
    funext a
    show M a = t a • 1 + (M a - t a • 1)
    rw [add_sub_cancel]
  refine ⟨hXtr, hXs, hMeq, ?_⟩
  obtain ⟨hJ, -⟩ := (ricciFlat_iff S hS M hM K hK hK0).mp hRic
  have hJ' : S.trace • (1 : Matrix (Fin 3) (Fin 3) ℝ) - S = -∑ a, M a := eq_neg_of_add_eq_zero_left hJ
  have hSeq := (ricciJ_inverse S _).mp hJ'
  rw [hMeq] at hSeq
  rw [hSeq]
  exact N_shift t Xs hXtr

/-- **At most two outer blocks**: every Ricci-flat block operator with symmetric blocks obeys every bound
`P ≤ c ‖·‖³` its diagonal tensors obey. -/
theorem L57_block_le_two_of (hm : m ≤ 1) (c : ℝ)
    (hc : ∀ w : Matrix (Fin 3 ⊕ Fin (m + 1)) (Fin 3 ⊕ Fin (m + 1)) ℝ, HamiltonsCubic.FamilyLayer.IsWeight w →
      Pcubic (HamiltonsCubic.FamilyLayer.diagOp w) ≤ c * HamiltonsCubic.RealLayer.norm (HamiltonsCubic.FamilyLayer.diagOp w) ^ 3)
    (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm)
    (M : Fin (m + 1) → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin (m + 1) → Fin (m + 1) → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (hRic : ∀ i j, Ric (blockOp S M K) i j = 0) :
    Pcubic (blockOp S M K) ≤ c * HamiltonsCubic.RealLayer.norm (blockOp S M K) ^ 3 := by
  obtain ⟨t, Xs, hXtr, hXs, hMeq, hSeq⟩ := blockOp_normal_form S hS M hM K hK hK0 hRic
  subst hMeq hSeq
  obtain ⟨F, hF1, hF2, hdiag⟩ : ∃ F : Matrix (Fin 3) (Fin 3) ℝ, Fᵀ * F = 1 ∧ F * Fᵀ = 1 ∧
      ∀ i : Fin m, DiagIn F (Xs i.succ) := by
    rcases Nat.le_one_iff_eq_zero_or_eq_one.mp hm with rfl | rfl
    · exact ⟨1, by simp, by simp, fun i => i.elim0⟩
    · obtain ⟨F, hF1, hF2, hd⟩ := exists_diag_frame (Xs 1) (hXs 1)
      refine ⟨F, hF1, hF2, fun i => ?_⟩
      rw [Fin.fin_one_eq_zero i]
      exact hd
  exact L228_item3_of c hc t Xs hXtr hXs K hK hK0 hRic F hF1 hF2 hdiag

/-- **`n = 4`, one outer block**: every Ricci-flat `W ∈ 𝒮_J` has `P(W) ≤ Θ₄ ‖W‖³`, `Θ₄ = θ₀(4) = √12/4`. -/
theorem L57_block_n4 (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm)
    (M : Fin 1 → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin 1 → Fin 1 → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (hRic : ∀ i j, Ric (blockOp S M K) i j = 0) :
    Pcubic (blockOp S M K)
      ≤ Real.sqrt (2 * (((1 : ℕ) : ℝ) + 3 - 1) * (((1 : ℕ) : ℝ) + 3 - 2)) / (((1 : ℕ) : ℝ) + 3)
        * HamiltonsCubic.RealLayer.norm (blockOp S M K) ^ 3 :=
  L57_block_le_two_of (m := 0) (by norm_num) _ (diag_bound le_rfl) S hS M hM K hK hK0 hRic

/-- **L227**: at `n = 5` (two outer blocks) every Ricci-flat `W ∈ 𝒮_J` has `P(W) ≤ Θ₅ ‖W‖³`, `Θ₅ = 2√2/3`, the
record's odd constant. -/
theorem L227_full (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm)
    (M : Fin 2 → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin 2 → Fin 2 → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (hRic : ∀ i j, Ric (blockOp S M K) i j = 0) :
    Pcubic (blockOp S M K) ≤ 2 * Real.sqrt 2 / 3 * HamiltonsCubic.RealLayer.norm (blockOp S M K) ^ 3 := by
  have hΘ : Real.sqrt (HamiltonsCubic.L57Critical.thetaOddSq (((2 : ℕ) : ℝ) + 3)) = 2 * Real.sqrt 2 / 3 := by
    have h8 : HamiltonsCubic.L57Critical.thetaOddSq (((2 : ℕ) : ℝ) + 3) = (2 * Real.sqrt 2 / 3) ^ 2 := by
      unfold HamiltonsCubic.L57Critical.thetaOddSq
      rw [div_pow, mul_pow, Real.sq_sqrt (by norm_num)]
      norm_num
    rw [h8, Real.sqrt_sq (by positivity)]
  have hc := fun w hw => (diag_bound_odd (m := 2) le_rfl (by decide) w hw)
  rw [hΘ] at hc
  exact L57_block_le_two_of (m := 1) le_rfl _ hc S hS M hM K hK hK0 hRic

end HamiltonsCubic.L227Full
