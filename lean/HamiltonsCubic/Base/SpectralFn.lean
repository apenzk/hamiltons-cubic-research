import Mathlib

set_option linter.style.longLine false

/-!
# Spectral functions of symmetric operators, characterised on eigenvectors

Milestone 2 of [the build plan for L17's derivative](../../../reviews/2026-09-26-lean-DK-plan.md). For a symmetric
operator `T` on a finite-dimensional real inner product space and any `g : ℝ → ℝ`, `specFn hn g hT` is
`g(T) = ∑ᵢ g(λᵢ) eᵢ ⟪eᵢ, ·⟫` in Mathlib's eigenbasis.

- `specFn_apply_of_eigen`: `T v = μ v` gives `g(T) v = g(μ) v`, for every eigenvector, not only the basis ones;
- **`specFn_unique`**: an operator doing that on every eigenvector is `g(T)`, so `g(T)` is independent of the basis;
- `specFn_isSymmetric` and `specFn_congr` (dependence on `g` only through the spectrum), from the definition;
- `specFn_id`, `specFn_neg` (`g(T) = −T` when `g = −id` on the spectrum), `specFn_smul` (positive homogeneity) and
  `specFn_conj` (`g(U⁻¹TU) = U⁻¹ g(T) U` for invertible `U` with `U⁻¹TU` symmetric), from uniqueness;
- **`inner_specFn_sub`**, the mixed-basis identity `⟪eᵢ, (g(B) − g(A)) fⱼ⟫ = (g(νⱼ) − g(λᵢ)) ⟪eᵢ, fⱼ⟫`, beside
  `inner_sub_eigen`, `⟪eᵢ, (B − A) fⱼ⟫ = (νⱼ − λᵢ) ⟪eᵢ, fⱼ⟫`;
- **`hsSq_specFn_sub_le`**: an `L`-Lipschitz `g` is `L`-Lipschitz on symmetric operators in the Hilbert–Schmidt norm,
  with `norm_apply_sq_le` and `hsSq_le_opNorm` comparing that norm with the operator norm.
-/

namespace HamiltonsCubic.SpectralFn

open Module

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  {n : ℕ} (hn : finrank ℝ E = n)

/-- **`g(T)`**, the spectral function of a symmetric operator, in Mathlib's eigenbasis. -/
noncomputable def specFn (g : ℝ → ℝ) {T : E →ₗ[ℝ] E} (hT : T.IsSymmetric) : E →ₗ[ℝ] E :=
  ∑ i, g (hT.eigenvalues hn i) • (innerₛₗ ℝ (hT.eigenvectorBasis hn i)).smulRight (hT.eigenvectorBasis hn i)

section
variable (g : ℝ → ℝ) {T : E →ₗ[ℝ] E} (hT : T.IsSymmetric)

theorem specFn_apply (x : E) :
    specFn hn g hT x = ∑ i, (g (hT.eigenvalues hn i) * inner ℝ (hT.eigenvectorBasis hn i) x) • hT.eigenvectorBasis hn i := by
  simp [specFn, LinearMap.sum_apply, smul_smul]

/-- The eigenbasis relation with the `RCLike` coercion removed. -/
theorem apply_eigvec (i : Fin n) :
    T (hT.eigenvectorBasis hn i) = hT.eigenvalues hn i • hT.eigenvectorBasis hn i := by
  exact hT.apply_eigenvectorBasis hn i

/-- **`g(T)` acts on every eigenvector of `T` by `g` of its eigenvalue.** -/
theorem specFn_apply_of_eigen {μ : ℝ} {v : E} (hv : T v = μ • v) : specFn hn g hT v = g μ • v := by
  rw [specFn_apply]
  set e := hT.eigenvectorBasis hn
  have key : ∀ i, g (hT.eigenvalues hn i) * inner ℝ (e i) v = g μ * inner ℝ (e i) v := fun i => by
    have h1 : inner ℝ (T (e i)) v = inner ℝ (e i) (T v) := hT (e i) v
    rw [apply_eigvec hn hT, hv, real_inner_smul_left, real_inner_smul_right] at h1
    by_cases h0 : inner ℝ (e i) v = 0
    · rw [h0]; ring
    · have : hT.eigenvalues hn i = μ := mul_right_cancel₀ h0 h1
      rw [this]
  simp_rw [key, ← smul_smul, ← Finset.smul_sum]
  rw [e.sum_repr']

/-- **Uniqueness**: an operator acting on every eigenvector of `T` by `g` of its eigenvalue is `g(T)`. -/
theorem specFn_unique (S : E →ₗ[ℝ] E) (hS : ∀ (μ : ℝ) (v : E), T v = μ • v → S v = g μ • v) :
    S = specFn hn g hT :=
  (hT.eigenvectorBasis hn).toBasis.ext fun i => by
    rw [OrthonormalBasis.coe_toBasis, hS _ _ (apply_eigvec hn hT i), specFn_apply_of_eigen hn g hT (apply_eigvec hn hT i)]

theorem inner_specFn_left (x y : E) :
    inner ℝ (specFn hn g hT x) y = ∑ i, g (hT.eigenvalues hn i) * (inner ℝ (hT.eigenvectorBasis hn i) x * inner ℝ (hT.eigenvectorBasis hn i) y) := by
  rw [specFn_apply, sum_inner]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [real_inner_smul_left]; ring

/-- **`g(T)` is symmetric.** -/
theorem specFn_isSymmetric : (specFn hn g hT).IsSymmetric := fun x y => by
  rw [inner_specFn_left, real_inner_comm, inner_specFn_left]
  exact Finset.sum_congr rfl fun i _ => by ring

/-- **`id(T) = T`.** -/
theorem specFn_id : specFn hn id hT = T :=
  (specFn_unique hn id hT T fun _ _ hv => hv).symm

/-- **`g(T)` depends on `g` only on the spectrum.** -/
theorem specFn_congr (g' : ℝ → ℝ) (h : ∀ i, g (hT.eigenvalues hn i) = g' (hT.eigenvalues hn i)) :
    specFn hn g hT = specFn hn g' hT := by
  unfold specFn
  exact Finset.sum_congr rfl fun i _ => by rw [h i]

/-- **`g(T) = −T`** when `g(λᵢ) = −λᵢ` at every eigenvalue. -/
theorem specFn_neg (h : ∀ i, g (hT.eigenvalues hn i) = -hT.eigenvalues hn i) : specFn hn g hT = -T := by
  rw [specFn_congr hn g hT (fun x => -x) h]
  exact (specFn_unique hn (fun x => -x) hT (-T) fun μ v hv => by rw [LinearMap.neg_apply, hv, neg_smul]).symm

end

/-- **`g(cT) = c g(T)` for `c ≥ 0`** when `g` is positively homogeneous. -/
theorem specFn_smul (g : ℝ → ℝ) (hg : ∀ c x, 0 ≤ c → g (c * x) = c * g x) {T : E →ₗ[ℝ] E}
    (hT : T.IsSymmetric) {c : ℝ} (hc : 0 ≤ c) (hcT : (c • T).IsSymmetric) :
    specFn hn g hcT = c • specFn hn g hT := by
  refine (specFn_unique hn g hcT _ fun μ v hv => ?_).symm
  rw [LinearMap.smul_apply]
  rcases hc.eq_or_lt with h0 | hpos
  · subst h0
    have hμv : μ • v = 0 := by rw [← hv]; simp
    rcases smul_eq_zero.mp hμv with hμ | hv0
    · have : g 0 = 0 := by have := hg 0 0 le_rfl; simpa using this
      rw [hμ, this]; simp
    · rw [hv0]; simp
  · have hTv : T v = (μ / c) • v := by
      rw [LinearMap.smul_apply] at hv
      rw [div_eq_inv_mul, ← smul_smul, ← hv, smul_smul, inv_mul_cancel₀ hpos.ne', one_smul]
    rw [specFn_apply_of_eigen hn g hT hTv, smul_smul, ← hg c (μ / c) hc, mul_div_cancel₀ _ hpos.ne']

/-- **`g(U⁻¹ T U) = U⁻¹ g(T) U`** for every invertible `U` with `U⁻¹ T U` symmetric. Orthogonality of `U` is
what makes `U⁻¹ T U` symmetric in use, and the identity itself needs nothing beyond invertibility. -/
theorem specFn_conj (g : ℝ → ℝ) {T : E →ₗ[ℝ] E} (hT : T.IsSymmetric) (U : E ≃ₗ[ℝ] E)
    (hT' : ((U.symm : E →ₗ[ℝ] E) ∘ₗ T ∘ₗ (U : E →ₗ[ℝ] E)).IsSymmetric) :
    specFn hn g hT' = (U.symm : E →ₗ[ℝ] E) ∘ₗ specFn hn g hT ∘ₗ (U : E →ₗ[ℝ] E) := by
  refine (specFn_unique hn g hT' _ fun μ v hv => ?_).symm
  have hTU : T (U v) = μ • U v := by
    have := congrArg U hv
    simpa using this
  simp [specFn_apply_of_eigen hn g hT hTU]

/-! ## The mixed-basis identity -/

section Mixed
variable (g : ℝ → ℝ) {A B : E →ₗ[ℝ] E} (hA : A.IsSymmetric) (hB : B.IsSymmetric)

/-- **`⟪eᵢ, (B − A) fⱼ⟫ = (νⱼ − λᵢ) ⟪eᵢ, fⱼ⟫`**, `e` the eigenbasis of `A` and `f` that of `B`. -/
theorem inner_sub_eigen (i j : Fin n) :
    inner ℝ (hA.eigenvectorBasis hn i) ((B - A) (hB.eigenvectorBasis hn j)) =
      (hB.eigenvalues hn j - hA.eigenvalues hn i) * inner ℝ (hA.eigenvectorBasis hn i) (hB.eigenvectorBasis hn j) := by
  rw [LinearMap.sub_apply, inner_sub_right, ← hA, apply_eigvec hn hB, apply_eigvec hn hA,
    real_inner_smul_left, real_inner_smul_right]
  ring

/-- **The mixed-basis identity**: `⟪eᵢ, (g(B) − g(A)) fⱼ⟫ = (g(νⱼ) − g(λᵢ)) ⟪eᵢ, fⱼ⟫`. -/
theorem inner_specFn_sub (i j : Fin n) :
    inner ℝ (hA.eigenvectorBasis hn i) ((specFn hn g hB - specFn hn g hA) (hB.eigenvectorBasis hn j)) =
      (g (hB.eigenvalues hn j) - g (hA.eigenvalues hn i)) * inner ℝ (hA.eigenvectorBasis hn i) (hB.eigenvectorBasis hn j) := by
  rw [LinearMap.sub_apply, inner_sub_right, ← specFn_isSymmetric hn g hA,
    specFn_apply_of_eigen hn g hB (apply_eigvec hn hB j), specFn_apply_of_eigen hn g hA (apply_eigvec hn hA i),
    real_inner_smul_left, real_inner_smul_right]
  ring

end Mixed

/-! ## The Hilbert–Schmidt norm and the Lipschitz bound -/

/-- **`‖X‖²_HS = ∑ᵢ ‖X bᵢ‖²`** over the standard orthonormal basis. -/
noncomputable def hsSq (X : E →ₗ[ℝ] E) : ℝ := ∑ i, ‖X (stdOrthonormalBasis ℝ E i)‖ ^ 2

omit [FiniteDimensional ℝ E] in
/-- `∑ⱼ ‖X fⱼ‖² = ∑ᵢ ∑ⱼ ⟪eᵢ, X fⱼ⟫²` for orthonormal bases `e`, `f`. -/
theorem sum_norm_sq_eq {ι κ : Type*} [Fintype ι] [Fintype κ] (e : OrthonormalBasis ι ℝ E)
    (f : OrthonormalBasis κ ℝ E) (X : E →ₗ[ℝ] E) :
    ∑ j, ‖X (f j)‖ ^ 2 = ∑ i, ∑ j, inner ℝ (e i) (X (f j)) ^ 2 := by
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [← real_inner_self_eq_norm_sq, ← e.sum_inner_mul_inner (X (f j)) (X (f j))]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [real_inner_comm (X (f j)) (e i)]; ring

omit [FiniteDimensional ℝ E] in
/-- **For symmetric `X`, `∑ⱼ ‖X fⱼ‖²` is the same over every orthonormal basis.** -/
theorem sum_norm_sq_basis_indep {ι κ : Type*} [Fintype ι] [Fintype κ] (e : OrthonormalBasis ι ℝ E)
    (f : OrthonormalBasis κ ℝ E) {X : E →ₗ[ℝ] E} (hX : X.IsSymmetric) :
    ∑ j, ‖X (f j)‖ ^ 2 = ∑ i, ‖X (e i)‖ ^ 2 := by
  rw [sum_norm_sq_eq e f X, sum_norm_sq_eq f e X, Finset.sum_comm]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  rw [← hX, real_inner_comm]

/-- **An `L`-Lipschitz `g` is `L`-Lipschitz on symmetric operators in the Hilbert–Schmidt norm**:
`‖g(B) − g(A)‖²_HS ≤ L² ‖B − A‖²_HS`. -/
theorem hsSq_specFn_sub_le (g : ℝ → ℝ) {L : ℝ} (hg : ∀ x y, |g x - g y| ≤ L * |x - y|)
    {A B : E →ₗ[ℝ] E} (hA : A.IsSymmetric) (hB : B.IsSymmetric) :
    hsSq (specFn hn g hB - specFn hn g hA) ≤ L ^ 2 * hsSq (B - A) := by
  have hD : (specFn hn g hB - specFn hn g hA).IsSymmetric := fun x y => by
    simp only [LinearMap.sub_apply, inner_sub_left, inner_sub_right, specFn_isSymmetric hn g hA x y,
      specFn_isSymmetric hn g hB x y]
  have hΔ : (B - A).IsSymmetric := fun x y => by
    simp only [LinearMap.sub_apply, inner_sub_left, inner_sub_right, hA x y, hB x y]
  set e := hA.eigenvectorBasis hn
  set f := hB.eigenvectorBasis hn
  unfold hsSq
  rw [← sum_norm_sq_basis_indep (stdOrthonormalBasis ℝ E) f hD, ← sum_norm_sq_basis_indep (stdOrthonormalBasis ℝ E) f hΔ,
    sum_norm_sq_eq e f, sum_norm_sq_eq e f, Finset.mul_sum]
  refine Finset.sum_le_sum fun i _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_le_sum fun j _ => ?_
  rw [inner_specFn_sub hn g hA hB, inner_sub_eigen hn hA hB]
  have h := hg (hB.eigenvalues hn j) (hA.eigenvalues hn i)
  have hsq : (g (hB.eigenvalues hn j) - g (hA.eigenvalues hn i)) ^ 2 ≤
      L ^ 2 * (hB.eigenvalues hn j - hA.eigenvalues hn i) ^ 2 := by
    have := pow_le_pow_left₀ (abs_nonneg _) h 2
    rwa [sq_abs, mul_pow, sq_abs] at this
  rw [mul_pow, mul_pow, ← mul_assoc]
  exact mul_le_mul_of_nonneg_right hsq (sq_nonneg _)

theorem hsSq_nonneg (X : E →ₗ[ℝ] E) : 0 ≤ hsSq X :=
  Finset.sum_nonneg fun _ _ => sq_nonneg _

/-- **The operator norm is at most the Hilbert–Schmidt norm**: `‖X v‖² ≤ ‖X‖²_HS ‖v‖²`. -/
theorem norm_apply_sq_le (X : E →ₗ[ℝ] E) (v : E) : ‖X v‖ ^ 2 ≤ hsSq X * ‖v‖ ^ 2 := by
  set b := stdOrthonormalBasis ℝ E
  have hv : X v = ∑ i, inner ℝ (b i) v • X (b i) := by
    conv_lhs => rw [← b.sum_repr' v]
    simp [map_sum, map_smul]
  have hpars : ‖v‖ ^ 2 = ∑ i, inner ℝ (b i) v ^ 2 := by
    rw [← real_inner_self_eq_norm_sq, ← b.sum_inner_mul_inner v v]
    exact Finset.sum_congr rfl fun i _ => by rw [real_inner_comm v (b i)]; ring
  have h1 : ‖X v‖ ≤ ∑ i, |inner ℝ (b i) v| * ‖X (b i)‖ := by
    rw [hv]
    refine (norm_sum_le _ _).trans (le_of_eq (Finset.sum_congr rfl fun i _ => ?_))
    rw [norm_smul, Real.norm_eq_abs]
  have h2 : (∑ i, |inner ℝ (b i) v| * ‖X (b i)‖) ^ 2 ≤ (∑ i, |inner ℝ (b i) v| ^ 2) * ∑ i, ‖X (b i)‖ ^ 2 :=
    Finset.sum_mul_sq_le_sq_mul_sq _ _ _
  have h0 : 0 ≤ ‖X v‖ := norm_nonneg _
  calc ‖X v‖ ^ 2 ≤ (∑ i, |inner ℝ (b i) v| * ‖X (b i)‖) ^ 2 := pow_le_pow_left₀ h0 h1 2
    _ ≤ (∑ i, |inner ℝ (b i) v| ^ 2) * ∑ i, ‖X (b i)‖ ^ 2 := h2
    _ = hsSq X * ‖v‖ ^ 2 := by
      rw [hpars, hsSq, mul_comm]
      simp only [sq_abs]
      rfl

/-- **The Hilbert–Schmidt norm is at most `√n` times the operator norm**: `‖X‖²_HS ≤ n ‖X‖²`. -/
theorem hsSq_le_opNorm (X : E →L[ℝ] E) : hsSq (X : E →ₗ[ℝ] E) ≤ finrank ℝ E * ‖X‖ ^ 2 := by
  unfold hsSq
  calc ∑ i, ‖(X : E →ₗ[ℝ] E) (stdOrthonormalBasis ℝ E i)‖ ^ 2 ≤ ∑ _i : Fin (finrank ℝ E), ‖X‖ ^ 2 := by
        refine Finset.sum_le_sum fun i _ => pow_le_pow_left₀ (norm_nonneg _) ?_ 2
        have := X.le_opNorm (stdOrthonormalBasis ℝ E i)
        rwa [(stdOrthonormalBasis ℝ E).orthonormal.1 i, mul_one] at this
    _ = finrank ℝ E * ‖X‖ ^ 2 := by simp

end HamiltonsCubic.SpectralFn
