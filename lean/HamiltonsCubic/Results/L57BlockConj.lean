import Mathlib
import HamiltonsCubic.Results.L57Block
import HamiltonsCubic.Results.L226Mixed

set_option linter.style.longLine false

/-!
# The rotation to a coordinate-diagonal tensor on the block family

L227 and L228 owe *"the rotation to a coordinate-diagonal tensor"*: a block operator whose `S` and `M_a` are
simultaneously diagonal in one orthonormal frame `F` of `ℝ^J` is carried by the rotation `F` to one whose blocks are
diagonal, with the same `P`, the same norm and the same Ricci form up to conjugation. This file, for `F` orthogonal:

* `conj_mul`, `trace_conj`, `det_conj`, `adj_formula`, `adj_conj`: the `3 × 3` conjugation identities, the adjugate
  through Cayley–Hamilton;
* `blockP_conj`, `normSq_conj`: L226's `blockP` and norm formula are invariant under `S ↦ FᵀSF`, `M_a ↦ FᵀM_aF`;
* `ricci_conj`: Ricci-flatness is invariant, through L226's `ricciFlat_iff`;
* `L57_block_conj_of`, `L57_block_conj`, `L57_block_conj_odd`: a Ricci-flat block operator whose `S` and `M_a`
  are simultaneously diagonalised by an orthogonal `F` obeys every bound its diagonal tensors obey, so
  `P(W) ≤ θ₀(n) ‖W‖³`, `n = m + 3 ≥ 4` (the record's `Θₙ` at even `n`), and `P(W) ≤ Θₙ ‖W‖³` with the odd constant
  at odd `n ≥ 5`, through [L57Block.lean](L57Block.lean).
-/

namespace HamiltonsCubic.L57BlockConj

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.L226Statement HamiltonsCubic.L57Block HamiltonsCubic.L226Mixed

variable {m : ℕ}

section Orth
variable {F : Matrix (Fin 3) (Fin 3) ℝ}

theorem conj_mul (hF2 : F * Fᵀ = 1) (A B : Matrix (Fin 3) (Fin 3) ℝ) :
    (Fᵀ * A * F) * (Fᵀ * B * F) = Fᵀ * (A * B) * F := by
  rw [show (Fᵀ * A * F) * (Fᵀ * B * F) = Fᵀ * A * (F * Fᵀ) * B * F by simp only [Matrix.mul_assoc], hF2,
    Matrix.mul_one]
  simp only [Matrix.mul_assoc]

theorem trace_conj (hF2 : F * Fᵀ = 1) (A : Matrix (Fin 3) (Fin 3) ℝ) : (Fᵀ * A * F).trace = A.trace := by
  rw [Matrix.trace_mul_comm, ← Matrix.mul_assoc, hF2, Matrix.one_mul]

theorem det_conj (hF1 : Fᵀ * F = 1) (A : Matrix (Fin 3) (Fin 3) ℝ) : (Fᵀ * A * F).det = A.det := by
  have h := congrArg Matrix.det hF1
  rw [Matrix.det_mul, Matrix.det_transpose, Matrix.det_one] at h
  rw [Matrix.det_mul, Matrix.det_mul, Matrix.det_transpose]
  linear_combination A.det * h

/-- Cayley–Hamilton for the `3 × 3` adjugate. -/
theorem adj_formula (A : Matrix (Fin 3) (Fin 3) ℝ) :
    A.adjugate = A * A - A.trace • A + ((A.trace ^ 2 - (A * A).trace) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [Matrix.adjugate_fin_three, Matrix.trace_fin_three, Matrix.mul_apply, Fin.sum_univ_three,
      Matrix.one_apply] <;> ring

theorem adj_conj (hF1 : Fᵀ * F = 1) (hF2 : F * Fᵀ = 1) (A : Matrix (Fin 3) (Fin 3) ℝ) :
    (Fᵀ * A * F).adjugate = Fᵀ * A.adjugate * F := by
  rw [adj_formula, adj_formula, conj_mul hF2, trace_conj hF2, trace_conj hF2]
  simp only [Matrix.mul_add, Matrix.add_mul, Matrix.mul_sub, Matrix.sub_mul, Matrix.mul_smul, Matrix.smul_mul,
    Matrix.mul_one, hF1]

end Orth

/-- **`blockP` is invariant under an orthogonal rotation of `J`.** -/
theorem blockP_conj {F : Matrix (Fin 3) (Fin 3) ℝ} (hF1 : Fᵀ * F = 1) (hF2 : F * Fᵀ = 1)
    (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (K : Fin m → Fin m → ℝ) :
    blockP (Fᵀ * S * F) (fun a => Fᵀ * M a * F) K = blockP S M K := by
  unfold blockP cubicJ
  simp only [conj_mul hF2, adj_conj hF1 hF2, trace_conj hF2, det_conj hF1]

/-- **And so is L226's norm formula.** -/
theorem normSq_conj {F : Matrix (Fin 3) (Fin 3) ℝ} (hF2 : F * Fᵀ = 1)
    (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) :
    ((Fᵀ * S * F) * (Fᵀ * S * F)).trace + ∑ a, ((Fᵀ * M a * F) * (Fᵀ * M a * F)).trace
      = (S * S).trace + ∑ a, (M a * M a).trace := by
  simp only [conj_mul hF2, trace_conj hF2]

theorem isSymm_conj {F : Matrix (Fin 3) (Fin 3) ℝ} (A : Matrix (Fin 3) (Fin 3) ℝ) (hA : A.IsSymm) :
    (Fᵀ * A * F).IsSymm := by
  unfold Matrix.IsSymm
  rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose, hA.eq, Matrix.mul_assoc]

/-- **Ricci-flatness is invariant.** -/
theorem ricci_conj {F : Matrix (Fin 3) (Fin 3) ℝ} (hF1 : Fᵀ * F = 1) (hF2 : F * Fᵀ = 1)
    (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (hRic : ∀ i j, Ric (blockOp S M K) i j = 0) :
    ∀ i j, Ric (blockOp (Fᵀ * S * F) (fun a => Fᵀ * M a * F) K) i j = 0 := by
  obtain ⟨hJ, hO⟩ := (ricciFlat_iff S hS M hM K hK hK0).mp hRic
  refine (ricciFlat_iff _ (isSymm_conj S hS) _ (fun a => isSymm_conj (M a) (hM a)) K hK hK0).mpr ⟨?_, fun a => ?_⟩
  · have h : Fᵀ * (S.trace • (1 : Matrix (Fin 3) (Fin 3) ℝ) - S + ∑ a, M a) * F = 0 := by
      rw [hJ, Matrix.mul_zero, Matrix.zero_mul]
    rw [← h, trace_conj hF2]
    simp only [Matrix.mul_add, Matrix.add_mul, Matrix.mul_sub, Matrix.sub_mul, Matrix.mul_smul, Matrix.smul_mul,
      Matrix.mul_one, hF1, Matrix.mul_sum, Matrix.sum_mul]
  · rw [trace_conj hF2]
    exact hO a

/-- **Any diagonal bound transfers to a simultaneously diagonalisable block operator.** -/
theorem L57_block_conj_of (c : ℝ)
    (hc : ∀ w : Matrix (Fin 3 ⊕ Fin m) (Fin 3 ⊕ Fin m) ℝ, HamiltonsCubic.FamilyLayer.IsWeight w →
      Pcubic (HamiltonsCubic.FamilyLayer.diagOp w) ≤ c * HamiltonsCubic.RealLayer.norm (HamiltonsCubic.FamilyLayer.diagOp w) ^ 3)
    (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm)
    (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (hRic : ∀ i j, Ric (blockOp S M K) i j = 0)
    (F : Matrix (Fin 3) (Fin 3) ℝ) (hF1 : Fᵀ * F = 1) (hF2 : F * Fᵀ = 1)
    (hSd : ∀ x y, x ≠ y → (Fᵀ * S * F) x y = 0) (hMd : ∀ a x y, x ≠ y → (Fᵀ * M a * F) x y = 0) :
    Pcubic (blockOp S M K) ≤ c * HamiltonsCubic.RealLayer.norm (blockOp S M K) ^ 3 := by
  have hS' := isSymm_conj (F := F) S hS
  have hM' : ∀ a, (Fᵀ * M a * F).IsSymm := fun a => isSymm_conj (M a) (hM a)
  have hP : Pcubic (blockOp S M K) = Pcubic (blockOp (Fᵀ * S * F) (fun a => Fᵀ * M a * F) K) := by
    rw [Pcubic_blockOp S hS M hM K hK hK0, Pcubic_blockOp _ hS' _ hM' K hK hK0, blockP_conj hF1 hF2]
  have hN : HamiltonsCubic.RealLayer.norm (blockOp S M K)
      = HamiltonsCubic.RealLayer.norm (blockOp (Fᵀ * S * F) (fun a => Fᵀ * M a * F) K) := by
    unfold HamiltonsCubic.RealLayer.norm
    rw [normSq_blockOp S hS M hM K hK hK0, normSq_blockOp _ hS' _ hM' K hK hK0, normSq_conj hF2]
  rw [hP, hN]
  exact L57_block_of c hc _ hSd _ hMd K hK hK0 (ricci_conj hF1 hF2 S hS M hM K hK hK0 hRic)

/-- **L57 on a simultaneously diagonalisable block operator**, `θ₀(n)`, the record's `Θₙ` at even `n`. -/
theorem L57_block_conj (hm : 1 ≤ m) (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm)
    (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (hRic : ∀ i j, Ric (blockOp S M K) i j = 0)
    (F : Matrix (Fin 3) (Fin 3) ℝ) (hF1 : Fᵀ * F = 1) (hF2 : F * Fᵀ = 1)
    (hSd : ∀ x y, x ≠ y → (Fᵀ * S * F) x y = 0) (hMd : ∀ a x y, x ≠ y → (Fᵀ * M a * F) x y = 0) :
    Pcubic (blockOp S M K)
      ≤ Real.sqrt (2 * (((m : ℝ) + 3) - 1) * (((m : ℝ) + 3) - 2)) / ((m : ℝ) + 3)
        * HamiltonsCubic.RealLayer.norm (blockOp S M K) ^ 3 :=
  L57_block_conj_of _ (diag_bound hm) S hS M hM K hK hK0 hRic F hF1 hF2 hSd hMd

/-- **And the odd constant** at odd `n = m + 3 ≥ 5`. -/
theorem L57_block_conj_odd (hm : 2 ≤ m) (hodd : ¬ Even (m + 3)) (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm)
    (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (hRic : ∀ i j, Ric (blockOp S M K) i j = 0)
    (F : Matrix (Fin 3) (Fin 3) ℝ) (hF1 : Fᵀ * F = 1) (hF2 : F * Fᵀ = 1)
    (hSd : ∀ x y, x ≠ y → (Fᵀ * S * F) x y = 0) (hMd : ∀ a x y, x ≠ y → (Fᵀ * M a * F) x y = 0) :
    Pcubic (blockOp S M K)
      ≤ Real.sqrt (HamiltonsCubic.L57Critical.thetaOddSq ((m : ℝ) + 3))
        * HamiltonsCubic.RealLayer.norm (blockOp S M K) ^ 3 :=
  L57_block_conj_of _ (diag_bound_odd hm hodd) S hS M hM K hK hK0 hRic F hF1 hF2 hSd hMd

end HamiltonsCubic.L57BlockConj
