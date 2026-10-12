import Mathlib

set_option linter.style.longLine false

/-!
# L227's alignment step, proved

[second-order.md](../../../findings/second-order.md)'s Lemma L227, step 3: for real symmetric `U` and `V` there is a
symmetric `V'` commuting with `U`, with the same trace and the same `tr V²`, and `tr(U V²) ≤ tr(U V'²)`.

The proof here takes Birkhoff's route rather than the block's two Rayleigh bounds, at every size `n`: in eigenframes
`U = Q diag(u) Qᵀ` and `V = P diag(ν) Pᵀ`, `tr(U V²) = Σᵢₖ uᵢ Bᵢₖ² νₖ²` with `B = Qᵀ P` orthogonal, so `(Bᵢₖ²)` is doubly
stochastic, Birkhoff puts it in the convex hull of the permutation matrices, and the linear functional is at most its
value at some permutation `σ`. Then `V' = Q diag(ν ∘ σ) Qᵀ`.

`alignment_fin_three` is `L227Statement.alignment_step` with that file's hypotheses, to replace the named `sorry` there.
-/

namespace HamiltonsCubic.L227Alignment

open Matrix Finset

variable {n : Type*} [Fintype n] [DecidableEq n]

omit [Fintype n] [DecidableEq n] in
lemma isHermitian_of_isSymm {A : Matrix n n ℝ} (h : A.IsSymm) : A.IsHermitian := by
  unfold Matrix.IsHermitian
  rw [conjTranspose_eq_transpose_of_trivial]
  exact h

lemma orth_tr_mul {Q : Matrix n n ℝ} (hQ : Q ∈ unitaryGroup n ℝ) : Qᵀ * Q = 1 := by
  have h := mem_unitaryGroup_iff'.mp hQ
  rwa [star_eq_conjTranspose, conjTranspose_eq_transpose_of_trivial] at h

lemma orth_mul_tr {Q : Matrix n n ℝ} (hQ : Q ∈ unitaryGroup n ℝ) : Q * Qᵀ = 1 := by
  have h := mem_unitaryGroup_iff.mp hQ
  rwa [star_eq_conjTranspose, conjTranspose_eq_transpose_of_trivial] at h

/-- **The spectral decomposition over `ℝ`**: `A = Q diag(λ) Qᵀ`. -/
lemma spectral_real {A : Matrix n n ℝ} (hA : A.IsHermitian) :
    A = (hA.eigenvectorUnitary : Matrix n n ℝ) * diagonal hA.eigenvalues
      * (hA.eigenvectorUnitary : Matrix n n ℝ)ᵀ := by
  conv_lhs => rw [hA.spectral_theorem]
  simp [Unitary.conjStarAlgAut_apply, star_eq_conjTranspose, conjTranspose_eq_transpose_of_trivial]

/-- Conjugation by an orthogonal `Q` multiplies through. -/
lemma conj_mul_conj {Q : Matrix n n ℝ} (hQ : Qᵀ * Q = 1) (A B : Matrix n n ℝ) :
    Q * A * Qᵀ * (Q * B * Qᵀ) = Q * (A * B) * Qᵀ := by
  simp only [Matrix.mul_assoc]
  rw [← Matrix.mul_assoc Qᵀ Q, hQ, Matrix.one_mul]

lemma trace_conj {Q : Matrix n n ℝ} (hQ : Qᵀ * Q = 1) (A : Matrix n n ℝ) : (Q * A * Qᵀ).trace = A.trace := by
  rw [Matrix.mul_assoc, trace_mul_comm, Matrix.mul_assoc, hQ, Matrix.mul_one]

/-- **The pairing in two eigenframes.** -/
lemma trace_two_frames (Q P : Matrix n n ℝ) (u w : n → ℝ) :
    (Q * diagonal u * Qᵀ * (P * diagonal w * Pᵀ)).trace
      = ∑ i, ∑ k, u i * ((Qᵀ * P) i k) ^ 2 * w k := by
  have e : (Q * diagonal u * Qᵀ * (P * diagonal w * Pᵀ)).trace
      = (diagonal u * (Qᵀ * P) * diagonal w * (Qᵀ * P)ᵀ).trace := by
    rw [transpose_mul, transpose_transpose]
    rw [show Q * diagonal u * Qᵀ * (P * diagonal w * Pᵀ) = Q * (diagonal u * Qᵀ * (P * diagonal w * Pᵀ)) by
      simp only [Matrix.mul_assoc]]
    rw [trace_mul_comm]
    simp only [Matrix.mul_assoc]
  rw [e]
  generalize Qᵀ * P = B
  unfold Matrix.trace
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Matrix.diag_apply, Matrix.mul_apply]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [Matrix.mul_diagonal, Matrix.diagonal_mul, Matrix.transpose_apply]
  ring

/-- **The squared entries of an orthogonal matrix are doubly stochastic.** -/
lemma sq_mem_doublyStochastic {B : Matrix n n ℝ} (h₁ : Bᵀ * B = 1) (h₂ : B * Bᵀ = 1) :
    (Matrix.of fun i k => B i k ^ 2) ∈ doublyStochastic ℝ n := by
  rw [mem_doublyStochastic_iff_sum]
  refine ⟨fun i k => by simp [sq_nonneg], fun i => ?_, fun k => ?_⟩
  · have := congrFun (congrFun h₂ i) i
    simpa [Matrix.mul_apply, sq] using this
  · have := congrFun (congrFun h₁ k) k
    simpa [Matrix.mul_apply, sq] using this

/-- **Birkhoff's step**: the doubly stochastic pairing is at most a permutation pairing. -/
theorem le_perm_pairing {B : Matrix n n ℝ} (h₁ : Bᵀ * B = 1) (h₂ : B * Bᵀ = 1) (u w : n → ℝ) :
    ∃ σ : Equiv.Perm n, ∑ i, ∑ k, u i * B i k ^ 2 * w k ≤ ∑ i, u i * w (σ i) := by
  let L : Matrix n n ℝ →ₗ[ℝ] ℝ :=
    { toFun := fun M => ∑ i, ∑ k, u i * M i k * w k
      map_add' := fun M N => by
        simp only [Matrix.add_apply, mul_add, add_mul, Finset.sum_add_distrib]
      map_smul' := fun c M => by
        simp only [Matrix.smul_apply, smul_eq_mul, RingHom.id_apply, Finset.mul_sum]
        exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun k _ => by ring }
  have hconv : ConvexOn ℝ Set.univ L := L.convexOn convex_univ
  have hS := sq_mem_doublyStochastic h₁ h₂
  have hS' : (Matrix.of fun i k => B i k ^ 2) ∈ convexHull ℝ {x | ∃ σ : Equiv.Perm n, σ.permMatrix ℝ = x} := by
    rw [← doublyStochastic_eq_convexHull_permMatrix]; exact hS
  obtain ⟨_, ⟨σ, rfl⟩, hle⟩ := hconv.exists_ge_of_mem_convexHull (Set.subset_univ _) hS'
  refine ⟨σ, ?_⟩
  have lhs : L (Matrix.of fun i k => B i k ^ 2) = ∑ i, ∑ k, u i * B i k ^ 2 * w k := rfl
  have rhs : L (σ.permMatrix ℝ) = ∑ i, u i * w (σ i) := by
    change ∑ i, ∑ k, u i * (σ.permMatrix ℝ) i k * w k = _
    refine Finset.sum_congr rfl fun i _ => ?_
    simp [Equiv.Perm.permMatrix, PEquiv.toMatrix_apply]
  rw [← lhs, ← rhs]
  exact hle

omit [DecidableEq n] in
/-- **The alignment step at every size.** -/
theorem alignment (U V : Matrix n n ℝ) (hU : U.IsSymm) (hV : V.IsSymm) :
    ∃ V' : Matrix n n ℝ, V'.IsSymm ∧ V'.trace = V.trace ∧ (V' * V').trace = (V * V).trace ∧
      U * V' = V' * U ∧ (U * V * V).trace ≤ (U * V' * V').trace := by
  classical
  have hUH := isHermitian_of_isSymm hU
  have hVH := isHermitian_of_isSymm hV
  have hUd := spectral_real hUH
  have hVd := spectral_real hVH
  have hQ₁ := orth_tr_mul hUH.eigenvectorUnitary.2
  have hQ₂ := orth_mul_tr hUH.eigenvectorUnitary.2
  have hP₁ := orth_tr_mul hVH.eigenvectorUnitary.2
  have hP₂ := orth_mul_tr hVH.eigenvectorUnitary.2
  generalize (hUH.eigenvectorUnitary : Matrix n n ℝ) = Q at hUd hQ₁ hQ₂
  generalize (hVH.eigenvectorUnitary : Matrix n n ℝ) = P at hVd hP₁ hP₂
  generalize hUH.eigenvalues = u at hUd
  generalize hVH.eigenvalues = ν at hVd
  subst hUd hVd
  have hVV : P * diagonal ν * Pᵀ * (P * diagonal ν * Pᵀ) = P * diagonal (fun k => ν k ^ 2) * Pᵀ := by
    rw [conj_mul_conj hP₁, diagonal_mul_diagonal]; simp [sq]
  have hB₁ : (Qᵀ * P)ᵀ * (Qᵀ * P) = 1 := by
    rw [transpose_mul, transpose_transpose]
    simp only [Matrix.mul_assoc]; rw [← Matrix.mul_assoc Q Qᵀ, hQ₂, Matrix.one_mul, hP₁]
  have hB₂ : (Qᵀ * P) * (Qᵀ * P)ᵀ = 1 := by
    rw [transpose_mul, transpose_transpose]
    simp only [Matrix.mul_assoc]; rw [← Matrix.mul_assoc P Pᵀ, hP₂, Matrix.one_mul, hQ₁]
  obtain ⟨σ, hσ⟩ := le_perm_pairing hB₁ hB₂ u (fun k => ν k ^ 2)
  refine ⟨Q * diagonal (fun i => ν (σ i)) * Qᵀ, ?_, ?_, ?_, ?_, ?_⟩
  · simp [Matrix.IsSymm, transpose_mul, Matrix.mul_assoc]
  · rw [trace_conj hQ₁, trace_conj hP₁, trace_diagonal, trace_diagonal]
    exact Equiv.sum_comp σ ν
  · rw [conj_mul_conj hQ₁, hVV, trace_conj hQ₁, trace_conj hP₁, diagonal_mul_diagonal, trace_diagonal,
      trace_diagonal]
    simp only [← sq]
    exact Equiv.sum_comp σ (fun k => ν k ^ 2)
  · rw [conj_mul_conj hQ₁, conj_mul_conj hQ₁, diagonal_mul_diagonal, diagonal_mul_diagonal]
    have hc : (fun i => u i * ν (σ i)) = (fun i => ν (σ i) * u i) := funext fun i => mul_comm _ _
    rw [hc]
  · rw [Matrix.mul_assoc (Q * diagonal u * Qᵀ), hVV, trace_two_frames]
    rw [Matrix.mul_assoc (Q * diagonal u * Qᵀ), conj_mul_conj hQ₁, conj_mul_conj hQ₁, diagonal_mul_diagonal,
      trace_conj hQ₁, diagonal_mul_diagonal, trace_diagonal]
    refine hσ.trans (le_of_eq ?_)
    exact Finset.sum_congr rfl fun i _ => by ring

/-- **`L227Statement.alignment_step`, proved**, with that file's hypotheses. -/
theorem alignment_fin_three (U V : Matrix (Fin 3) (Fin 3) ℝ) (hU : U.IsSymm) (hV : V.IsSymm) (hV₀ : V.trace = 0) :
    ∃ V' : Matrix (Fin 3) (Fin 3) ℝ, V'.IsSymm ∧ V'.trace = 0 ∧ (V' * V').trace = (V * V).trace ∧
      U * V' = V' * U ∧ (U * V * V).trace ≤ (U * V' * V').trace := by
  obtain ⟨V', h₁, h₂, h₃, h₄, h₅⟩ := alignment U V hU hV
  exact ⟨V', h₁, h₂.trans hV₀, h₃, h₄, h₅⟩

end HamiltonsCubic.L227Alignment
