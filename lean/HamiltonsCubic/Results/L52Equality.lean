import HamiltonsCubic.Results.L52Bound
import HamiltonsCubic.Results.DoublyStochasticEq
import HamiltonsCubic.Results.SpectralTrace

set_option linter.style.longLine false

/-!
# L52's equality clause, the "only if" half

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L52: equality in the display forces both diagonals to be
rearrangements of their spectra. [L52Bound.lean](L52Bound.lean)'s `L52_matrix_bound` sums two Jensen steps over doubly
stochastic diagonals; at equality both are tight, and [DoublyStochasticEq.lean](DoublyStochasticEq.lean)'s `eq_multiset`
turns each tight step into a rearrangement, the strictness being [CubicConvexity.lean](CubicConvexity.lean)'s
`strictConvexOn_g` and `strictConcaveOn_h` on the closed ranges:

* **`L52_matrix_eq`**: for real symmetric `A` (spectrum `μ ≤ M₊`, `∑ μ² = 1`) and `B` (spectrum `ω ≥ −m`, `∑ ω² = 3`), if
  the display holds with equality then the diagonal of `A` is `μ` and the diagonal of `B` is `ω`, each as a multiset;
* **`offDiag_zero_of_diag_spectrum`**, **`L52_matrix_eq_frame`**: then both are diagonal, `∑ A_ii² = ∑ μ² = tr A²`
  leaving no off-diagonal mass, which at `A = Mpair R` and `B = Bw w (ringW R)` built from one frame is the record's
  shared frame;
* **`trace_pow_diag`**, **`L52_matrix_if`**: the converse at the matrices, diagonal `A` and `B` giving equality, since
  `∑ A_ii^k = tr A^k = ∑ μ^k`; the ψ stipulation enters only at the record's objects.
-/

namespace HamiltonsCubic.L52Bound

open Finset HamiltonsCubic.L54Statement HamiltonsCubic.CubicConvexity

/-- **The "only if" half of L52's equality clause.** -/
theorem L52_matrix_eq {P Q : Type*} [Fintype P] [DecidableEq P] [Fintype Q] [DecidableEq Q]
    (A : Matrix P P ℝ) (hA : A.IsHermitian) (B : Matrix Q Q ℝ) (hB : B.IsHermitian) (Mp m : ℝ)
    (hμ : ∀ j, hA.eigenvalues j ≤ Mp) (hω : ∀ j, -m ≤ hB.eigenvalues j)
    (hμ2 : ∑ j, hA.eigenvalues j ^ 2 = 1) (hω2 : ∑ j, hB.eigenvalues j ^ 2 = 3)
    (heq : (3 / 2) * ∑ j, hA.eigenvalues j ^ 3 - (1 / 2) * ∑ j, hB.eigenvalues j ^ 3
      = (3 / 2) * (∑ i, A i i ^ 3 + 3 * Mp * (1 - ∑ i, A i i ^ 2))
        - (1 / 2) * (∑ i, B i i ^ 3 + 3 * m * (∑ i, B i i ^ 2 - 3))) :
    Multiset.map (fun i => A i i) univ.val = Multiset.map hA.eigenvalues univ.val ∧
      Multiset.map (fun i => B i i) univ.val = Multiset.map hB.eigenvalues univ.val := by
  obtain ⟨PA, hPA, hdA⟩ := diag_doublyStochastic A hA
  obtain ⟨PB, hPB, hdB⟩ := diag_doublyStochastic B hB
  set h : ℝ → ℝ := fun t => t ^ 3 - 3 * Mp * t ^ 2
  have h1 := sum_concaveOn_diag (concaveOn_h Mp) hPA hA.eigenvalues (fun j => hμ j)
  have h2 := sum_convexOn_diag (convexOn_g m) hPB hB.eigenvalues (fun j => hω j)
  -- the two slacks are nonnegative and the display's gap is their weighted sum, so both vanish
  have e1 : ∑ i, h (∑ j, PA i j * hA.eigenvalues j) = ∑ j, h (hA.eigenvalues j) := by
    have hK : ∀ i, ∑ j, PA i j * hA.eigenvalues j = A i i := fun i => (hdA i).symm
    have h1' := h1
    simp only [hK] at h1' ⊢
    simp only [h, sum_sub_distrib, ← mul_sum, hμ2] at h1' ⊢
    have h2' := h2
    simp only [← hdB, CubicConvexity.g, sum_add_distrib, ← mul_sum, hω2] at h2'
    nlinarith [h1', h2', heq]
  have e2 : ∑ i, CubicConvexity.g m (∑ j, PB i j * hB.eigenvalues j) = ∑ j, CubicConvexity.g m (hB.eigenvalues j) := by
    have hK : ∀ i, ∑ j, PB i j * hB.eigenvalues j = B i i := fun i => (hdB i).symm
    have h2' := h2
    simp only [hK] at h2' ⊢
    simp only [CubicConvexity.g, sum_add_distrib, ← mul_sum, hω2] at h2' ⊢
    have h1' := h1
    simp only [← hdA, sum_sub_distrib, ← mul_sum, hμ2] at h1'
    nlinarith [h1', h2', heq]
  constructor
  · have hs := (CubicConvexity.strictConcaveOn_h Mp).neg
    have e1' : ∑ i, (-h) (∑ j, PA i j • hA.eigenvalues j) = ∑ j, (-h) (hA.eigenvalues j) := by
      simp only [Pi.neg_apply, sum_neg_distrib, smul_eq_mul, e1]
    have := DoublyStochastic.eq_multiset hPA hs hA.eigenvalues (fun j => hμ j) e1'
    simpa only [smul_eq_mul, ← hdA] using this
  · have := DoublyStochastic.eq_multiset hPB (CubicConvexity.strictConvexOn_g m) hB.eigenvalues
      (fun j => (hω j : hB.eigenvalues j ∈ Set.Ici (-m))) (by simpa only [smul_eq_mul] using e2)
    simpa only [smul_eq_mul, ← hdB] using this

/-- **A real symmetric matrix whose diagonal is its spectrum is diagonal**: `∑ A_ii² = ∑ μ² = tr A² = ∑_ij A_ij²`, so
every off-diagonal square vanishes. -/
theorem offDiag_zero_of_diag_spectrum {N : Type*} [Fintype N] [DecidableEq N] (A : Matrix N N ℝ) (hA : A.IsHermitian)
    (hm : Multiset.map (fun i => A i i) univ.val = Multiset.map hA.eigenvalues univ.val) {i j : N} (hij : i ≠ j) :
    A i j = 0 := by
  have hs : ∀ a b, A b a = A a b := fun a b => by
    have := congrFun (congrFun hA a) b
    simpa [Matrix.conjTranspose_apply] using this
  have hdiag : ∑ a, A a a ^ 2 = ∑ a, hA.eigenvalues a ^ 2 := by
    have := congrArg (fun s => (Multiset.map (fun x : ℝ => x ^ 2) s).sum) hm
    simpa [Multiset.map_map, Function.comp_def] using this
  have htr : ∑ a, ∑ b, A a b ^ 2 = ∑ a, hA.eigenvalues a ^ 2 := by
    rw [← HamiltonsCubic.SecondKind.trace_pow_eq_sum_eigenvalues A hA 2, pow_two, Matrix.trace]
    simp only [Matrix.diag, Matrix.mul_apply]
    exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by rw [hs a b]; ring
  have hoff : ∑ a, ∑ b ∈ univ.erase a, A a b ^ 2 = 0 := by
    have : ∑ a, ∑ b, A a b ^ 2 = ∑ a, (A a a ^ 2 + ∑ b ∈ univ.erase a, A a b ^ 2) :=
      Finset.sum_congr rfl fun a _ => by rw [← Finset.add_sum_erase _ _ (Finset.mem_univ a)]
    rw [this, Finset.sum_add_distrib, hdiag] at htr
    linarith
  have hnn : ∀ a ∈ univ, 0 ≤ ∑ b ∈ univ.erase a, A a b ^ 2 := fun a _ => Finset.sum_nonneg fun b _ => sq_nonneg _
  have hi := (Finset.sum_eq_zero_iff_of_nonneg hnn).1 hoff i (Finset.mem_univ i)
  have hij' := (Finset.sum_eq_zero_iff_of_nonneg fun b _ => sq_nonneg (A i b)).1 hi j
    (Finset.mem_erase.mpr ⟨Ne.symm hij, Finset.mem_univ j⟩)
  exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp hij'

/-- **At equality both matrices are diagonal**, the record's shared frame once both are built from one frame. -/
theorem L52_matrix_eq_frame {P Q : Type*} [Fintype P] [DecidableEq P] [Fintype Q] [DecidableEq Q]
    (A : Matrix P P ℝ) (hA : A.IsHermitian) (B : Matrix Q Q ℝ) (hB : B.IsHermitian) (Mp m : ℝ)
    (hμ : ∀ j, hA.eigenvalues j ≤ Mp) (hω : ∀ j, -m ≤ hB.eigenvalues j)
    (hμ2 : ∑ j, hA.eigenvalues j ^ 2 = 1) (hω2 : ∑ j, hB.eigenvalues j ^ 2 = 3)
    (heq : (3 / 2) * ∑ j, hA.eigenvalues j ^ 3 - (1 / 2) * ∑ j, hB.eigenvalues j ^ 3
      = (3 / 2) * (∑ i, A i i ^ 3 + 3 * Mp * (1 - ∑ i, A i i ^ 2))
        - (1 / 2) * (∑ i, B i i ^ 3 + 3 * m * (∑ i, B i i ^ 2 - 3))) :
    (∀ i j, i ≠ j → A i j = 0) ∧ (∀ i j, i ≠ j → B i j = 0) := by
  obtain ⟨hmA, hmB⟩ := L52_matrix_eq A hA B hB Mp m hμ hω hμ2 hω2 heq
  exact ⟨fun i j hij => offDiag_zero_of_diag_spectrum A hA hmA hij,
    fun i j hij => offDiag_zero_of_diag_spectrum B hB hmB hij⟩

/-- `tr A^k = ∑ A_ii^k` for a diagonal matrix. -/
theorem trace_pow_diag {N : Type*} [Fintype N] [DecidableEq N] (A : Matrix N N ℝ) (hA : ∀ i j, i ≠ j → A i j = 0)
    (k : ℕ) : (A ^ k).trace = ∑ i, A i i ^ k := by
  have hD : A = Matrix.diagonal (fun i => A i i) := by
    ext i j
    by_cases hij : i = j
    · subst hij; simp
    · simp [Matrix.diagonal_apply_ne _ hij, hA i j hij]
  rw [hD, Matrix.diagonal_pow, Matrix.trace_diagonal]
  simp

/-- **The "if" half at the matrices**: diagonal `A` and `B` make the display an equality. -/
theorem L52_matrix_if {P Q : Type*} [Fintype P] [DecidableEq P] [Fintype Q] [DecidableEq Q]
    (A : Matrix P P ℝ) (hA : A.IsHermitian) (B : Matrix Q Q ℝ) (hB : B.IsHermitian) (Mp m : ℝ)
    (hμ2 : ∑ j, hA.eigenvalues j ^ 2 = 1) (hω2 : ∑ j, hB.eigenvalues j ^ 2 = 3)
    (hAd : ∀ i j, i ≠ j → A i j = 0) (hBd : ∀ i j, i ≠ j → B i j = 0) :
    (3 / 2) * ∑ j, hA.eigenvalues j ^ 3 - (1 / 2) * ∑ j, hB.eigenvalues j ^ 3
      = (3 / 2) * (∑ i, A i i ^ 3 + 3 * Mp * (1 - ∑ i, A i i ^ 2))
        - (1 / 2) * (∑ i, B i i ^ 3 + 3 * m * (∑ i, B i i ^ 2 - 3)) := by
  have a2 := (trace_pow_diag A hAd 2).symm.trans (HamiltonsCubic.SecondKind.trace_pow_eq_sum_eigenvalues A hA 2)
  have a3 := (trace_pow_diag A hAd 3).symm.trans (HamiltonsCubic.SecondKind.trace_pow_eq_sum_eigenvalues A hA 3)
  have b2 := (trace_pow_diag B hBd 2).symm.trans (HamiltonsCubic.SecondKind.trace_pow_eq_sum_eigenvalues B hB 2)
  have b3 := (trace_pow_diag B hBd 3).symm.trans (HamiltonsCubic.SecondKind.trace_pow_eq_sum_eigenvalues B hB 3)
  rw [a2, a3, b2, b3, hμ2, hω2]; ring

end HamiltonsCubic.L52Bound
