import Mathlib
import HamiltonsCubic.Results.SevenFrameGap
import HamiltonsCubic.Results.L237SlotCounts

/-!
# L240, the rows: every row of a seven-frame is at most `8`, so the total is at most `56`

[findings/second-order.md](../../../findings/second-order.md), Lemma L240, proof: "`T = 56 − ∑ᵢ δᵢ`
with `δᵢ = 8 − rowᵢ ≥ 0` (L237)". This file types that step in
[SevenFrameGap.lean](SevenFrameGap.lean)'s own notation (`ipSo`, `bracketTotal`), from
`kappa_cap_norm` at `r = 6`: `row_le_eight` and `bracketTotal_le_56`. The gap below `56` is the
rest of L240 and is owed.
-/

open HamiltonsCubic.RealLayer Matrix

namespace HamiltonsCubic.L240Rows

open HamiltonsCubic.SevenFrameGap

variable {n : ℕ}

theorem inner2_eq_ipSo {A B : Matrix (Fin n) (Fin n) ℝ} (hA : Aᵀ = -A) :
    inner2 A B = ipSo A B := by
  unfold inner2 ipSo; rw [hA, Matrix.neg_mul, Matrix.trace_neg]; ring

theorem br_skew {A B : Matrix (Fin n) (Fin n) ℝ} (hA : Aᵀ = -A) (hB : Bᵀ = -B) :
    (br A B)ᵀ = -br A B := by
  unfold br; rw [transpose_sub, transpose_mul, transpose_mul, hA, hB]
  simp [Matrix.neg_mul, Matrix.mul_neg]

/-- The `i`-th row of the ordered bracket total. -/
noncomputable def row (X : Fin 7 → Matrix (Fin n) (Fin n) ℝ) (i : Fin 7) : ℝ :=
  ∑ j, if i = j then 0 else ipSo (X i * X j - X j * X i) (X i * X j - X j * X i)

/-- **L237 at a frame element: every row is at most `8`.** -/
theorem row_le_eight (X : Fin 7 → Matrix (Fin n) (Fin n) ℝ) (hskew : ∀ i, (X i)ᵀ = -X i)
    (hon : ∀ i j, ipSo (X i) (X j) = if i = j then 1 else 0) (i : Fin 7) :
    row X i ≤ 8 := by
  set y : Fin 6 → Matrix (Fin n) (Fin n) ℝ := fun k => X (i.succAbove k)
  have hyS : ∀ k, IsSkew (y k) := fun k => hskew _
  have hy : ∀ a b, inner2 (y a) (y b) = if a = b then 1 else 0 := by
    intro a b
    rw [inner2_eq_ipSo (hskew _), hon]
    simp [Fin.succAbove_right_inj]
  have hcap := L237SlotCounts.kappa_cap_norm (X i) (hskew i) (by norm_num : 0 < 6) y hyS hy
  have hXX : inner2 (X i) (X i) = 1 := by rw [inner2_eq_ipSo (hskew i), hon]; simp
  rw [hXX] at hcap
  have e : row X i = ∑ k, inner2 (br (X i) (y k)) (br (X i) (y k)) := by
    unfold row
    rw [Fin.sum_univ_succAbove _ i]
    simp only [if_true, zero_add]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [if_neg (Fin.succAbove_ne i k).symm, inner2_eq_ipSo (br_skew (hskew _) (hskew _))]
    rfl
  rw [e]; norm_num at hcap ⊢; linarith

/-- **The ordered bracket total of a seven-frame is at most `56`.** -/
theorem bracketTotal_le_56 (X : Fin 7 → Matrix (Fin n) (Fin n) ℝ) (hskew : ∀ i, (X i)ᵀ = -X i)
    (hon : ∀ i j, ipSo (X i) (X j) = if i = j then 1 else 0) :
    bracketTotal X ≤ 56 := by
  have : bracketTotal X = ∑ i, row X i := rfl
  rw [this]
  calc ∑ i, row X i ≤ ∑ _i : Fin 7, (8 : ℝ) :=
        Finset.sum_le_sum fun i _ => row_le_eight X hskew hon i
    _ = 56 := by norm_num

/-- **A frame above `54.064` has an element of deficit below `1.936/7 = 0.2765714…`**: `δᵢ = 8 − rowᵢ`
sum to `56 − T < 1.936`, so the smallest is below `1.936/7`. *The record's `0.27657` rounds this constant
down, which the kernel refuses; the exact value is stated here.* -/
theorem exists_small_deficit (X : Fin 7 → Matrix (Fin n) (Fin n) ℝ)
    (hT : 54064 / 1000 < bracketTotal X) : ∃ i, 8 - row X i < 1936 / 7000 := by
  by_contra h
  push Not at h
  have : bracketTotal X = ∑ i, row X i := rfl
  have hsum : ∑ i : Fin 7, (8 - row X i) ≥ ∑ _i : Fin 7, (1936 / 7000 : ℝ) :=
    Finset.sum_le_sum fun i _ => h i
  rw [Finset.sum_sub_distrib] at hsum
  simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul] at hsum
  rw [← this] at hsum
  norm_num at hsum
  linarith

end HamiltonsCubic.L240Rows
