import Mathlib

/-!
# Ky Fan's maximum principle, in its dual form, proved

For a real symmetric `M` with eigenvalues `λ_k`, orthonormal `x₁,…,x_r` and any real `c`,
`Σ_j ⟨x_j, M x_j⟩ ≤ r c + Σ_k max(λ_k − c, 0)`. At `c = λ_r` (the `r`-th largest eigenvalue) the
right side is the sum of the `r` largest eigenvalues, which is Ky Fan's principle; the dual form
needs no sorting of the spectrum.

[L237](../../../findings/second-order.md) applies it to `-ad_X²` on `𝔰𝔬(n)` to cap
`Σ_j ‖[X₀, X_j]‖²`; [KyFanBracketCap.lean](KyFanBracketCap.lean) proves the configuration bounds
that evaluate the right side.

**PROVED** by the spectral decomposition, `Σ_j ⟨x_j, M x_j⟩ = Σ_k λ_k w_k` with
`w_k = Σ_j ⟨u_k, x_j⟩²`, `0 ≤ w_k ≤ 1` by Bessel and `Σ_k w_k = r` by Parseval, then
`λ_k w_k ≤ c w_k + max(λ_k − c, 0)`.
-/

namespace HamiltonsCubic.Results

open Matrix

/-- **Bessel**, for an orthonormal family in `ℝ^d` under the dot product. -/
theorem bessel {d r : ℕ} (y : Fin r → Fin d → ℝ)
    (hy : ∀ i j, y i ⬝ᵥ y j = if i = j then 1 else 0) (z : Fin d → ℝ) :
    ∑ j, (z ⬝ᵥ y j) ^ 2 ≤ z ⬝ᵥ z := by
  set c : Fin r → ℝ := fun j => z ⬝ᵥ y j with hc
  have h0 : 0 ≤ (z - ∑ j, c j • y j) ⬝ᵥ (z - ∑ j, c j • y j) := by
    have := Finset.sum_nonneg (s := Finset.univ) (f := fun k : Fin d =>
      (z - ∑ j, c j • y j) k * (z - ∑ j, c j • y j) k) (fun k _ => mul_self_nonneg _)
    simpa [dotProduct] using this
  have hexp : (z - ∑ j, c j • y j) ⬝ᵥ (z - ∑ j, c j • y j) = z ⬝ᵥ z - ∑ j, (c j) ^ 2 := by
    simp only [sub_dotProduct, dotProduct_sub, sum_dotProduct, dotProduct_sum, smul_dotProduct,
      dotProduct_smul, smul_eq_mul, hy, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq,
      Finset.sum_ite_eq', Finset.mem_univ, if_true]
    have hzy : ∀ j, y j ⬝ᵥ z = c j := fun j => by rw [dotProduct_comm]
    simp only [hzy, hc, sq]
    ring_nf
    simp
  rw [hexp] at h0
  simpa [hc] using h0


/-- **Ky Fan's maximum principle, dual form.** -/
theorem kyFan_sum_le {d r : ℕ} (M : Matrix (Fin d) (Fin d) ℝ) (hM : M.IsHermitian)
    (x : Fin r → Fin d → ℝ) (hx : ∀ i j, x i ⬝ᵥ x j = if i = j then 1 else 0) (c : ℝ) :
    ∑ j, x j ⬝ᵥ M.mulVec (x j) ≤ r * c + ∑ k, max (hM.eigenvalues k - c) 0 := by
  set V : Matrix (Fin d) (Fin d) ℝ := (hM.eigenvectorUnitary : Matrix (Fin d) (Fin d) ℝ) with hVdef
  have hstar : star V = Vᵀ := by
    rw [Matrix.star_eq_conjTranspose, Matrix.conjTranspose_eq_transpose_of_trivial]
  have hVV : Vᵀ * V = 1 := by rw [← hstar]; exact Unitary.coe_star_mul_self hM.eigenvectorUnitary
  have hVV' : V * Vᵀ = 1 := by rw [← hstar]; exact Unitary.coe_mul_star_self hM.eigenvectorUnitary
  set lam := hM.eigenvalues with hlam
  have hspec : M = V * diagonal lam * Vᵀ := by
    have hs := hM.spectral_theorem
    rw [Unitary.conjStarAlgAut_apply] at hs
    simp only [RCLike.ofReal_real_eq_id, Function.id_comp] at hs
    rw [← hstar]
    exact hs
  set y : Fin r → Fin d → ℝ := fun j => Vᵀ *ᵥ x j with hy
  have hyy : ∀ i j, y i ⬝ᵥ y j = if i = j then 1 else 0 := by
    intro i j
    simp only [hy]
    rw [Matrix.dotProduct_mulVec, ← Matrix.mulVec_transpose, Matrix.transpose_transpose,
      Matrix.mulVec_mulVec, hVV', Matrix.one_mulVec]
    · exact hx i j
  have hquad : ∀ j, x j ⬝ᵥ M *ᵥ x j = ∑ k, lam k * (y j k) ^ 2 := by
    intro j
    rw [hspec, ← Matrix.mulVec_mulVec, ← Matrix.mulVec_mulVec, Matrix.dotProduct_mulVec,
      ← Matrix.mulVec_transpose]
    simp only [hy, Matrix.mulVec_diagonal, dotProduct]
    exact Finset.sum_congr rfl fun k _ => by ring
  have hw1 : ∀ k, ∑ j, (y j k) ^ 2 ≤ 1 := by
    intro k
    have := bessel y hyy (Pi.single k 1)
    simpa [dotProduct, Pi.single_apply] using this
  have hw0 : ∀ k, 0 ≤ ∑ j, (y j k) ^ 2 := fun k => Finset.sum_nonneg fun j _ => sq_nonneg _
  have hwsum : ∑ k, ∑ j, (y j k) ^ 2 = r := by
    rw [Finset.sum_comm]
    have : ∀ j, ∑ k, (y j k) ^ 2 = 1 := by
      intro j; have := hyy j j; simp only [if_true, dotProduct] at this
      rw [← this]; exact Finset.sum_congr rfl fun k _ => by ring
    simp [this]
  calc ∑ j, x j ⬝ᵥ M *ᵥ x j = ∑ k, lam k * ∑ j, (y j k) ^ 2 := by
        simp only [hquad, Finset.mul_sum]; exact Finset.sum_comm
    _ ≤ ∑ k, (c * ∑ j, (y j k) ^ 2 + max (lam k - c) 0) := by
        refine Finset.sum_le_sum fun k _ => ?_
        have h1 := hw1 k; have h0 := hw0 k
        have hm1 := le_max_left (lam k - c) 0; have hm2 := le_max_right (lam k - c) 0
        nlinarith
    _ = r * c + ∑ k, max (lam k - c) 0 := by
        rw [Finset.sum_add_distrib, ← Finset.mul_sum, hwsum]; ring

/-! ## Against an explicit eigenbasis, for any positive symmetric bilinear form

The form L237 needs: the operator `-ad_X²` on bivectors, with the `Λ²` pairing `inner2`, and an
eigenbasis written down rather than taken from `IsHermitian.eigenvalues`, whose ordering is by
choice. -/

section Eigen

variable {E : Type*} [AddCommGroup E] [Module ℝ E]

/-- **Bessel** for a positive symmetric bilinear form. -/
theorem bessel_bilin (B : LinearMap.BilinForm ℝ E) (hsymm : ∀ x y, B x y = B y x)
    (hpos : ∀ x, 0 ≤ B x x) {r : ℕ} (y : Fin r → E)
    (hy : ∀ i j, B (y i) (y j) = if i = j then 1 else 0) (z : E) :
    ∑ j, (B z (y j)) ^ 2 ≤ B z z := by
  have h0 := hpos (z - ∑ j, B z (y j) • y j)
  have hexp : B (z - ∑ j, B z (y j) • y j) (z - ∑ j, B z (y j) • y j) =
      B z z - ∑ j, (B z (y j)) ^ 2 := by
    simp only [map_sub, map_sum, map_smul, LinearMap.sub_apply, LinearMap.sum_apply,
      Finset.sum_apply, LinearMap.smul_apply, smul_eq_mul, hy, mul_ite, mul_one, mul_zero,
      Finset.sum_ite_eq', Finset.mem_univ, if_true]
    simp only [fun j => hsymm (y j) z, sq]
    ring_nf
    simp
  linarith

/-- **Ky Fan against an explicit orthonormal eigenbasis**, in dual form. -/
theorem kyFan_eigen (B : LinearMap.BilinForm ℝ E) (hsymm : ∀ x y, B x y = B y x)
    (hpos : ∀ x, 0 ≤ B x x) {κ : Type*} [Fintype κ] [DecidableEq κ] (b : κ → E)
    (hb : ∀ k l, B (b k) (b l) = if k = l then 1 else 0)
    (M : E →ₗ[ℝ] E) (μ : κ → ℝ) (hM : ∀ k, M (b k) = μ k • b k)
    {r : ℕ} (y : Fin r → E) (hy : ∀ i j, B (y i) (y j) = if i = j then 1 else 0)
    (hspan : ∀ j, y j = ∑ k, B (b k) (y j) • b k) (c : ℝ) :
    ∑ j, B (y j) (M (y j)) ≤ r * c + ∑ k, max (μ k - c) 0 := by
  set w : Fin r → κ → ℝ := fun j k => B (b k) (y j) with hw
  have hquad : ∀ j, B (y j) (M (y j)) = ∑ k, μ k * (w j k) ^ 2 := by
    intro j
    conv_lhs => rw [hspan j, hspan j]
    simp only [map_sum, map_smul, hM, LinearMap.sum_apply,
      LinearMap.smul_apply, smul_eq_mul, hb, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq',
      Finset.mem_univ, if_true]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [Finset.sum_eq_single k]
    · simp [hw, sq]; ring
    · intro l _ hl; simp [hb, Ne.symm hl]
    · simp
  have hw1 : ∀ k, ∑ j, (w j k) ^ 2 ≤ 1 := by
    intro k
    have := bessel_bilin B hsymm hpos y hy (b k)
    simpa [hw, hb] using this
  have hw0 : ∀ k, 0 ≤ ∑ j, (w j k) ^ 2 := fun k => Finset.sum_nonneg fun j _ => sq_nonneg _
  have hwsum : ∑ k, ∑ j, (w j k) ^ 2 = r := by
    rw [Finset.sum_comm]
    have : ∀ j, ∑ k, (w j k) ^ 2 = 1 := by
      intro j
      have h1 := hy j j
      simp only [if_true] at h1
      rw [← h1]
      conv_rhs => rw [hspan j, hspan j]
      simp only [map_sum, map_smul, LinearMap.sum_apply, LinearMap.smul_apply,
        smul_eq_mul, hb, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true]
      refine Finset.sum_congr rfl fun k _ => ?_
      rw [Finset.sum_eq_single k]
      · simp [hw, sq]
      · intro l _ hl; simp [hb, Ne.symm hl]
      · simp
    simp [this]
  calc ∑ j, B (y j) (M (y j)) = ∑ k, μ k * ∑ j, (w j k) ^ 2 := by
        simp only [hquad, Finset.mul_sum]; exact Finset.sum_comm
    _ ≤ ∑ k, (c * ∑ j, (w j k) ^ 2 + max (μ k - c) 0) := by
        refine Finset.sum_le_sum fun k _ => ?_
        have h1 := hw1 k; have h0 := hw0 k
        have hm1 := le_max_left (μ k - c) 0; have hm2 := le_max_right (μ k - c) 0
        nlinarith
    _ = r * c + ∑ k, max (μ k - c) 0 := by
        rw [Finset.sum_add_distrib, ← Finset.mul_sum, hwsum]; ring

end Eigen

end HamiltonsCubic.Results
