import Mathlib
import HamiltonsCubic.Results.L227Alignment

set_option linter.style.longLine false

/-!
# L228, the `|J| = 3` step of R27 on two strata, at every `n`

## The claim

[second-order.md](../../../findings/second-order.md)'s Lemma L228: with one block `X_a` moving and the rest fixed,
`Y = X_a + ½ Σ_{c≠a} X_c` makes the norm `2|Y|² + const` and the value `6 tr Y³ + tr(Y ℓ') + const`, the quadratic term
cancelling. When the other blocks share a frame `F`, `ℓ'` is diagonal in `F`, and aligning `Y` to `F` by Birkhoff raises
the value at the same norm and makes every block diagonal in `F`.

## What is typed

* `cubicX`, `cubic_split`: the cubic part of `P` in the traceless blocks, split at block `0` over `Fin (m + 1)`, proved;
* `complete_square`, `complete_square_norm`: the shift `Y = X_a + ½ R` in the value and the norm, proved;
* `inFrame`, `align_to_frame`: for symmetric `Y` and a matrix `F diag(l) Fᵀ` with `F` orthogonal, a `Y' = F diag(y') Fᵀ`
  with the same `tr Y`, `tr Y²`, `tr Y³` and `tr(Y · F diag(l) Fᵀ) ≤ tr(Y' · F diag(l) Fᵀ)`, proved from
  [L227Alignment.lean](L227Alignment.lean)'s Birkhoff step.

**Not typed**: `cubicX` is the cubic part by definition, with no bridge to L226's `blockP`, so item 1's reduction of L226,
item 2's Gram and norm expansions, item 4, the rotation to a coordinate-diagonal tensor and L57 are outside the file.
-/

namespace HamiltonsCubic.L228Statement

open Matrix HamiltonsCubic.L227Alignment

/-- **The cubic part of `P` on `𝒮_J ∩ 𝒲ₙ`**: `2 tr X³ + 3 Σ_c tr(X X_c²) + Σ_c tr X_c³` with `X = Σ_c X_c`. -/
def cubicX {m : ℕ} (Xs : Fin m → Matrix (Fin 3) (Fin 3) ℝ) : ℝ :=
  2 * ((∑ c, Xs c) * (∑ c, Xs c) * (∑ c, Xs c)).trace
    + 3 * ∑ c, ((∑ d, Xs d) * Xs c * Xs c).trace + ∑ c, (Xs c * Xs c * Xs c).trace

/-- **The cubic part split at one block**: `6 tr X₀³ + 9 tr(X₀² R) + tr(X₀ (6R² + 3T))` plus terms free of `X₀`. -/
theorem cubic_split {m : ℕ} (Xs : Fin (m + 1) → Matrix (Fin 3) (Fin 3) ℝ) :
    cubicX Xs = 6 * (Xs 0 * Xs 0 * Xs 0).trace + 9 * (Xs 0 * Xs 0 * (∑ i : Fin m, Xs i.succ)).trace
      + (Xs 0 * ((6 : ℝ) • ((∑ i : Fin m, Xs i.succ) * (∑ i : Fin m, Xs i.succ))
          + (3 : ℝ) • (∑ i : Fin m, Xs i.succ * Xs i.succ))).trace
      + (2 * ((∑ i : Fin m, Xs i.succ) * (∑ i : Fin m, Xs i.succ) * (∑ i : Fin m, Xs i.succ)).trace
        + 3 * ((∑ i : Fin m, Xs i.succ) * (∑ i : Fin m, Xs i.succ * Xs i.succ)).trace
        + ∑ i : Fin m, (Xs i.succ * Xs i.succ * Xs i.succ).trace) := by
  have hsum : ∑ i : Fin m, ((Xs 0 + ∑ j : Fin m, Xs j.succ) * Xs i.succ * Xs i.succ).trace
      = ((Xs 0 + ∑ j : Fin m, Xs j.succ) * ∑ i : Fin m, Xs i.succ * Xs i.succ).trace := by
    rw [Matrix.mul_sum, Matrix.trace_sum]
    exact Finset.sum_congr rfl fun i _ => by rw [Matrix.mul_assoc]
  simp only [cubicX, Fin.sum_univ_succ]
  rw [hsum]
  generalize ∑ j : Fin m, Xs j.succ = R
  generalize ∑ i : Fin m, Xs i.succ * Xs i.succ = T
  generalize ∑ i : Fin m, (Xs i.succ * Xs i.succ * Xs i.succ).trace = c
  generalize Xs 0 = A
  simp only [trace_fin_three, Matrix.mul_apply, Fin.sum_univ_three, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul]
  ring

/-- **The shift in the value**: the quadratic term in `Y` cancels. -/
theorem complete_square (Y R L : Matrix (Fin 3) (Fin 3) ℝ) :
    6 * ((Y - (1 / 2 : ℝ) • R) * (Y - (1 / 2 : ℝ) • R) * (Y - (1 / 2 : ℝ) • R)).trace
      + 9 * ((Y - (1 / 2 : ℝ) • R) * (Y - (1 / 2 : ℝ) • R) * R).trace + ((Y - (1 / 2 : ℝ) • R) * L).trace
    = 6 * (Y * Y * Y).trace + (Y * (L - (9 / 2 : ℝ) • (R * R))).trace
      + (3 / 2 * (R * R * R).trace - 1 / 2 * (R * L).trace) := by
  simp only [trace_fin_three, Matrix.mul_apply, Fin.sum_univ_three, Matrix.sub_apply,
    Matrix.smul_apply, smul_eq_mul]
  ring

/-- **The shift in the norm**: `2|X_a|² + 2 tr(X_a R) = 2|Y|² - ½|R|²`. -/
theorem complete_square_norm (Xa R : Matrix (Fin 3) (Fin 3) ℝ) :
    2 * (Xa * Xa).trace + 2 * (Xa * R).trace
      = 2 * ((Xa + (1 / 2 : ℝ) • R) * (Xa + (1 / 2 : ℝ) • R)).trace - 1 / 2 * (R * R).trace := by
  simp only [trace_fin_three, Matrix.mul_apply, Fin.sum_univ_three, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul]
  ring

/-- A matrix diagonal in the frame `F`. -/
def inFrame (F : Matrix (Fin 3) (Fin 3) ℝ) (y : Fin 3 → ℝ) : Matrix (Fin 3) (Fin 3) ℝ := F * diagonal y * Fᵀ

/-- **Alignment to a given frame.** -/
theorem align_to_frame (F Y : Matrix (Fin 3) (Fin 3) ℝ) (hF₁ : Fᵀ * F = 1) (hF₂ : F * Fᵀ = 1) (hY : Y.IsSymm)
    (l : Fin 3 → ℝ) :
    ∃ y : Fin 3 → ℝ, (inFrame F y * inFrame F y * inFrame F y).trace = (Y * Y * Y).trace ∧
      (inFrame F y * inFrame F y).trace = (Y * Y).trace ∧ (inFrame F y).trace = Y.trace ∧
      (Y * inFrame F l).trace ≤ (inFrame F y * inFrame F l).trace := by
  have hYH := isHermitian_of_isSymm hY
  have hYd := spectral_real hYH
  have hQ₁ := orth_tr_mul hYH.eigenvectorUnitary.2
  have hQ₂ := orth_mul_tr hYH.eigenvectorUnitary.2
  generalize (hYH.eigenvectorUnitary : Matrix (Fin 3) (Fin 3) ℝ) = Q at hYd hQ₁ hQ₂
  generalize hYH.eigenvalues = y at hYd
  subst hYd
  have hB₁ : (Qᵀ * F)ᵀ * (Qᵀ * F) = 1 := by
    rw [transpose_mul, transpose_transpose]
    simp only [Matrix.mul_assoc]; rw [← Matrix.mul_assoc Q Qᵀ, hQ₂, Matrix.one_mul, hF₁]
  have hB₂ : (Qᵀ * F) * (Qᵀ * F)ᵀ = 1 := by
    rw [transpose_mul, transpose_transpose]
    simp only [Matrix.mul_assoc]; rw [← Matrix.mul_assoc F Fᵀ, hF₂, Matrix.one_mul, hQ₁]
  obtain ⟨σ, hσ⟩ := le_perm_pairing hB₁ hB₂ y l
  refine ⟨fun k => y (σ.symm k), ?_, ?_, ?_, ?_⟩
  · simp only [inFrame]
    rw [conj_mul_conj hF₁, conj_mul_conj hF₁, conj_mul_conj hQ₁, conj_mul_conj hQ₁, trace_conj hF₁, trace_conj hQ₁,
      diagonal_mul_diagonal, diagonal_mul_diagonal, diagonal_mul_diagonal, diagonal_mul_diagonal, trace_diagonal,
      trace_diagonal]
    exact Equiv.sum_comp σ.symm (fun k => y k * y k * y k)
  · simp only [inFrame]
    rw [conj_mul_conj hF₁, conj_mul_conj hQ₁, trace_conj hF₁, trace_conj hQ₁, diagonal_mul_diagonal,
      diagonal_mul_diagonal, trace_diagonal, trace_diagonal]
    exact Equiv.sum_comp σ.symm (fun k => y k * y k)
  · simp only [inFrame]
    rw [trace_conj hF₁, trace_conj hQ₁, trace_diagonal, trace_diagonal]
    exact Equiv.sum_comp σ.symm y
  · simp only [inFrame]
    rw [trace_two_frames, conj_mul_conj hF₁, trace_conj hF₁, diagonal_mul_diagonal, trace_diagonal]
    refine hσ.trans (le_of_eq ?_)
    rw [← Equiv.sum_comp σ (fun k => y (σ.symm k) * l k)]
    simp

end HamiltonsCubic.L228Statement
