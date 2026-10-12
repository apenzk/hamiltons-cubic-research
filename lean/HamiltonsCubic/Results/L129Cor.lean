import HamiltonsCubic.Results.L129
import Mathlib.Analysis.Matrix.Spectrum

set_option linter.style.longLine false

/-!
# L129, corollary (i): `λ_max(K) > λ` at every pure critical point

[findings/diagonal-half.md](../../../findings/diagonal-half.md), Lemma L129 (i): *`λ_max(K) > λ` strictly at every pure
critical point, since `tr K = 0` with `K ≠ 0` forces `λ_max > 0` and the half-open gap then forbids `λ_max ≤ λ`.*
[L129.lean](L129.lean)'s `spec_gap_half_open` is the gap; **`L129_cor_i` supplies the spectral step**, the top eigenvalue
and its unit eigenvector from Mathlib's spectral theorem.
-/

namespace HamiltonsCubic.HalfOpen

open Finset Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **L129 (i)**: at a pure critical point `K ≠ 0` (hollow, symmetric, zero row sums, off-diagonal criticality with
`λ > 0`), the largest eigenvalue of `K` exceeds `λ`. -/
theorem L129_cor_i (K : Matrix ι ι ℝ) (hA : K.IsHermitian) (hK0 : K ≠ 0) (hh : ∀ a, K a a = 0)
    (hr : ∀ a, ∑ b, K a b = 0) (lam : ℝ)
    (hcrit : ∀ a b, a ≠ b → (∑ c, K a c * K c b) + K a b ^ 2 = lam * K a b) :
    ∃ j, lam < hA.eigenvalues j ∧ ∀ i, hA.eigenvalues i ≤ hA.eigenvalues j := by
  have hne : Nonempty ι := by
    by_contra h; rw [not_nonempty_iff] at h; exact hK0 (Matrix.ext fun a => isEmptyElim a)
  obtain ⟨j, -, hj⟩ := Finset.exists_max_image Finset.univ hA.eigenvalues Finset.univ_nonempty
  refine ⟨j, ?_, fun i => hj i (Finset.mem_univ i)⟩
  have hs : ∀ a b, K a b = K b a := fun a b => by
    have := congrFun (congrFun hA a) b; simpa [Matrix.conjTranspose_apply] using this.symm
  -- `λ_max > 0`, from `tr K = 0` and `K ≠ 0`
  have htr : ∑ i, hA.eigenvalues i = 0 := by
    have h := hA.trace_eq_sum_eigenvalues
    have h0 : K.trace = 0 := by simp [Matrix.trace, hh]
    rw [h0] at h; simpa using h.symm
  have hpos : 0 < hA.eigenvalues j := by
    by_contra hle
    push Not at hle
    have hall : ∀ i, hA.eigenvalues i ≤ 0 := fun i => le_trans (hj i (Finset.mem_univ i)) hle
    have hz := (Finset.sum_eq_zero_iff_of_nonpos fun i _ => hall i).mp htr
    exact hK0 (hA.eigenvalues_eq_zero_iff.mp (funext fun i => hz i (Finset.mem_univ i)))
  -- the half-open gap forbids `λ_max ≤ λ`
  by_contra hle
  push Not at hle
  set v : ι → ℝ := ⇑(hA.eigenvectorBasis j)
  have hv := hA.mulVec_eigenvectorBasis j
  have heig : ∀ a, ∑ b, K a b * v b = hA.eigenvalues j * v a := fun a => by
    have := congrFun hv a; simpa [Matrix.mulVec, dotProduct] using this
  have h0 := spec_gap_half_open hh hs hr hcrit hpos hle heig
  have hn := hA.eigenvectorBasis.orthonormal.1 j
  rw [EuclideanSpace.norm_eq, Real.sqrt_eq_one] at hn
  have : ∑ a, v a ^ 2 = 1 := by simpa [Real.norm_eq_abs, sq_abs] using hn
  rw [h0] at this; simp at this

end HamiltonsCubic.HalfOpen
