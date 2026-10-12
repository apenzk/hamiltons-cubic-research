import HamiltonsCubic.Base.SelfDual

/-!
# Lemma L205, the `κ = 1` stratum: projections summing to the identity are orthogonal

[findings/diagonal-half.md](../../../findings/diagonal-half.md), the I76 section. At a
two-eigenvalue point of the decomposable locus whose positive eigenspace has dimension
`n/2`, isotropy reads `∑ P a = 1`. This file types the three-line argument that the planes
are then mutually orthogonal, which is what gives the frame.

`sum_offDiag_eq_zero` is the first step and is PROVED: multiplying the completeness
relation by `P a` and cancelling the idempotent term leaves the off-diagonal sum zero.

`mutually_orthogonal` is the conclusion, and it is PROVED: for symmetric idempotents
`trace (P a * P b) = tr((P b * P a)ᵀ (P b * P a))`, a sum of squares, so every term of the
vanishing off-diagonal trace sum is zero, and a matrix whose `tr(AᵀA)` vanishes is zero.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Results

open Matrix

variable {n m : ℕ}

/-- **The off-diagonal products sum to zero.** From `∑ b, P b = 1` and `P a * P a = P a`,
multiplying by `P a` leaves `∑_{b ≠ a} P a * P b = 0`. No trace and no symmetry is used. -/
theorem sum_offDiag_eq_zero (P : Fin m → Matrix (Fin n) (Fin n) ℝ)
    (hidem : ∀ a, P a * P a = P a)
    (hsum : ∑ b, P b = (1 : Matrix (Fin n) (Fin n) ℝ)) (a : Fin m) :
    ∑ b ∈ Finset.univ.erase a, P a * P b = 0 := by
  have hall : ∑ b, P a * P b = P a := by
    rw [← Finset.mul_sum, hsum, Matrix.mul_one]
  have hsplit : P a * P a + ∑ b ∈ Finset.univ.erase a, P a * P b = ∑ b, P a * P b :=
    Finset.add_sum_erase Finset.univ (fun b => P a * P b) (Finset.mem_univ a)
  rw [hidem a, hall] at hsplit
  have := hsplit
  linear_combination (norm := module) this

/-- **The trace of the off-diagonal sum vanishes**, which is the scalar form of the step
above and is what the nonnegativity argument is applied to. -/
theorem trace_sum_offDiag_eq_zero (P : Fin m → Matrix (Fin n) (Fin n) ℝ)
    (hidem : ∀ a, P a * P a = P a)
    (hsum : ∑ b, P b = (1 : Matrix (Fin n) (Fin n) ℝ)) (a : Fin m) :
    ∑ b ∈ Finset.univ.erase a, (P a * P b).trace = 0 := by
  rw [← Matrix.trace_sum, sum_offDiag_eq_zero P hidem hsum a, Matrix.trace_zero]

/-- **`tr(AᵀA)` is a sum of squares**, hence nonnegative. -/
theorem l205_trace_transpose_mul_self_nonneg (A : Matrix (Fin n) (Fin n) ℝ) :
    0 ≤ (Aᵀ * A).trace := by
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply]
  exact Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => mul_self_nonneg _

/-- **A matrix with `tr(AᵀA) = 0` is zero**, every entry's square being a term of a vanishing sum of squares. -/
theorem l205_eq_zero_of_trace_transpose_mul_self (A : Matrix (Fin n) (Fin n) ℝ)
    (h : (Aᵀ * A).trace = 0) : A = 0 := by
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply] at h
  have h1 := (Finset.sum_eq_zero_iff_of_nonneg fun i _ =>
    Finset.sum_nonneg fun j _ => mul_self_nonneg (A j i)).mp h
  ext j i
  have h2 := (Finset.sum_eq_zero_iff_of_nonneg fun j _ => mul_self_nonneg (A j i)).mp
    (h1 i (Finset.mem_univ i)) j (Finset.mem_univ j)
  simpa using mul_self_eq_zero.mp h2

/-- **For symmetric idempotents `tr(P a P c) = ‖P c P a‖²`**, in the form `tr((P c P a)ᵀ(P c P a))`. -/
theorem l205_trace_eq_normSq (P : Fin m → Matrix (Fin n) (Fin n) ℝ)
    (hsymm : ∀ a, Matrix.transpose (P a) = P a) (hidem : ∀ a, P a * P a = P a) (a c : Fin m) :
    (P a * P c).trace = ((P c * P a)ᵀ * (P c * P a)).trace := by
  rw [Matrix.transpose_mul, hsymm, hsymm]
  have e : P a * P c * (P c * P a) = (P a * P c) * P a := by
    rw [Matrix.mul_assoc, ← Matrix.mul_assoc (P c), hidem, Matrix.mul_assoc]
  rw [e, Matrix.mul_assoc, Matrix.trace_mul_comm (P a) (P c * P a), Matrix.mul_assoc, hidem,
    Matrix.trace_mul_comm]

/-- **Lemma L205.** Symmetric idempotents summing to the identity are pairwise orthogonal.
*Each `trace (P a * P b)` is `‖P b * P a‖²`, so the vanishing sum above forces every term, and
with it `P b * P a` and its transpose `P a * P b`, to vanish.* -/
theorem mutually_orthogonal (P : Fin m → Matrix (Fin n) (Fin n) ℝ)
    (hsymm : ∀ a, Matrix.transpose (P a) = P a)
    (hidem : ∀ a, P a * P a = P a)
    (hsum : ∑ b, P b = (1 : Matrix (Fin n) (Fin n) ℝ))
    {a b : Fin m} (hab : a ≠ b) :
    P a * P b = 0 := by
  have hz := trace_sum_offDiag_eq_zero P hidem hsum a
  have hterm := (Finset.sum_eq_zero_iff_of_nonneg fun c _ => by
    rw [l205_trace_eq_normSq P hsymm hidem a c]
    exact l205_trace_transpose_mul_self_nonneg _).mp hz b (Finset.mem_erase.mpr ⟨hab.symm, Finset.mem_univ b⟩)
  rw [l205_trace_eq_normSq P hsymm hidem a b] at hterm
  have hba := l205_eq_zero_of_trace_transpose_mul_self _ hterm
  have : P a * P b = (P b * P a)ᵀ := by rw [Matrix.transpose_mul, hsymm, hsymm]
  rw [this, hba, Matrix.transpose_zero]


end HamiltonsCubic.Results

#print axioms HamiltonsCubic.Results.mutually_orthogonal
