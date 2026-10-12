import HamiltonsCubic.Results.L50Traces

set_option linter.style.longLine false

/-!
# L50's splitting `S² = S²₀ ⊕ ℝg`: `W̊` lives on `S²₀` and kills `g`

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L50, reads `ω` as the spectrum of `W̊` on
`S²₀`. [L50Traces.lean](L50Traces.lean) proves `W̊ g = 0` and `tr W̊ h = 0` at a Ricci-flat `R`. **This file
proves the splitting they support**, in the orthonormal basis `e` of `S²`:

- `frob_one`: `⟨h, g⟩ = tr h`, so **`S²₀ = g^⊥` in the Frobenius pairing**, and `gvec` (the coordinates of
  `g`, `0` on the off-diagonal basis vectors and `1` on `E_aa`) has `coords h ⬝ gvec = tr h` (`coords_dot_g`);
- `Bmat_mulVec_g`: **`W̊ g = 0` in coordinates**, `Bmat *ᵥ gvec = 0`;
- `Bmat_compress`: **`Bmat = P Bmat P`** with `P = 1 − (1/n) gvec gvecᵀ` the orthogonal projector onto `g^⊥`
  (`Pg_idem`, `Pg_g`), so `Bmat` is `W̊ ↾ S²₀` on `g^⊥` and `0` on `ℝg`;
- `Bmat_zero_eigen`: **one eigenvalue of `Bmat` is `0`**, the one carried by `g`.
-/

namespace HamiltonsCubic.SecondKind

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.Results

variable {n : ℕ}

/-- `⟨h, g⟩ = tr h`: `S²₀` is `g^⊥` in the Frobenius pairing. -/
theorem frob_one (h : Matrix (Fin n) (Fin n) ℝ) : frob h 1 = h.trace := by
  unfold frob Matrix.trace
  refine Finset.sum_congr rfl fun i _ => ?_
  simp [Matrix.one_apply, mul_ite, Finset.sum_ite_eq]

/-- The coordinates of `g = 1` in the basis `e`. -/
def gvec : S2Idx n → ℝ := Sum.elim (fun _ => 0) (fun _ => 1)

theorem frob_symB_diag (X : Matrix (Fin n) (Fin n) ℝ) (a : Fin n) : frob X (symB a a) = X a a := by
  unfold frob symB
  rw [Finset.sum_eq_single a (fun i _ hi => Finset.sum_eq_zero fun j _ => by
    simp [Ne.symm hi]) (by simp)]
  rw [Finset.sum_eq_single a (fun j _ hj => by simp [Ne.symm hj]) (by simp)]
  simp; ring

/-- `∑_v X_v · gvec_v`, over the basis, is `∑_a ⟨X, E_aa⟩`, the trace. -/
theorem sum_frob_g (X : Matrix (Fin n) (Fin n) ℝ) :
    ∑ v, frob X (e v) * gvec v = X.trace := by
  rw [Fintype.sum_sum_type]
  simp only [gvec, Sum.elim_inl, Sum.elim_inr, mul_zero, mul_one, Finset.sum_const_zero, zero_add, e,
    frob_symB_diag]
  rfl

/-- The coordinates of a matrix in the basis `e`. -/
noncomputable def coords (h : Matrix (Fin n) (Fin n) ℝ) : S2Idx n → ℝ := fun u => frob h (e u)

/-- `coords h ⬝ gvec = tr h`. -/
theorem coords_dot_g (h : Matrix (Fin n) (Fin n) ℝ) : coords h ⬝ᵥ gvec = h.trace := by
  unfold coords dotProduct; exact sum_frob_g h

theorem gvec_dot_self : (gvec : S2Idx n → ℝ) ⬝ᵥ gvec = (n : ℝ) := by
  unfold dotProduct; rw [Fintype.sum_sum_type]; simp [gvec]

/-- The orthogonal projector onto `g^⊥`, `1 − (1/n) gvec gvecᵀ`. -/
noncomputable def Pg : Matrix (S2Idx n) (S2Idx n) ℝ := 1 - (1 / (n : ℝ)) • vecMulVec gvec gvec

theorem Pg_g (hn : 0 < n) : Pg *ᵥ (gvec : S2Idx n → ℝ) = 0 := by
  have hnR : (n : ℝ) ≠ 0 := by exact_mod_cast hn.ne'
  unfold Pg
  rw [Matrix.sub_mulVec, Matrix.one_mulVec, Matrix.smul_mulVec, Matrix.vecMulVec_mulVec, gvec_dot_self]
  ext u; simp [MulOpposite.smul_eq_mul_unop]; field_simp; ring

theorem Pg_idem (hn : 0 < n) : (Pg : Matrix (S2Idx n) (S2Idx n) ℝ) * Pg = Pg := by
  have hnR : (n : ℝ) ≠ 0 := by exact_mod_cast hn.ne'
  have hG : vecMulVec (gvec (n := n)) (gvec (n := n)) * vecMulVec (gvec (n := n)) (gvec (n := n))
      = (n : ℝ) • vecMulVec (gvec (n := n)) (gvec (n := n)) := by
    rw [Matrix.vecMulVec_mul_vecMulVec, gvec_dot_self]
    ext u v; simp [vecMulVec_apply]; ring
  unfold Pg
  rw [Matrix.sub_mul, Matrix.mul_sub, Matrix.mul_sub, Matrix.one_mul, Matrix.mul_one, Matrix.one_mul,
    Matrix.smul_mul, Matrix.mul_smul, hG, smul_smul]
  rw [smul_smul, show (1 / (n : ℝ)) * (1 / (n : ℝ)) * (n : ℝ) = 1 / (n : ℝ) by field_simp]
  abel

section W

variable (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))

include hR hskew hsym in
/-- **`W̊ g = 0` in coordinates** at a Ricci-flat `R`: `Bmat *ᵥ gvec = 0`, from `tr W̊ h = 0`. -/
theorem Bmat_mulVec_g (hRic : ∀ a b, Ric R a b = 0) : Bmat (ringW R) *ᵥ gvec = 0 := by
  ext u
  simp only [Matrix.mulVec, dotProduct, Bmat, Pi.zero_apply]
  rw [sum_frob_g, trace_ringW_zero R hR hskew hsym hRic]

include hR hskew hsym in
theorem vecMul_Bmat_g (hRic : ∀ a b, Ric R a b = 0) : gvec ᵥ* Bmat (ringW R) = 0 := by
  have hT : (Bmat (ringW R))ᵀ = Bmat (ringW R) := by
    have := Bmat_isHermitian R hR hskew hsym
    rw [Matrix.IsHermitian, Matrix.conjTranspose_eq_transpose_of_trivial] at this; exact this
  rw [← Matrix.mulVec_transpose, hT, Bmat_mulVec_g R hR hskew hsym hRic]

include hR hskew hsym in
/-- **`Bmat = P Bmat P`**: `W̊` on `S²` is its compression to `g^⊥ = S²₀`, and `0` on `ℝg`. -/
theorem Bmat_compress (hRic : ∀ a b, Ric R a b = 0) : Pg * Bmat (ringW R) * Pg = Bmat (ringW R) := by
  have h1 := Bmat_mulVec_g R hR hskew hsym hRic
  have h2 := vecMul_Bmat_g R hR hskew hsym hRic
  have hBP : Bmat (ringW R) * Pg = Bmat (ringW R) := by
    unfold Pg
    rw [Matrix.mul_sub, Matrix.mul_one, Matrix.mul_smul, Matrix.mul_vecMulVec, h1]; simp
  have hPB : Pg * Bmat (ringW R) = Bmat (ringW R) := by
    unfold Pg
    rw [Matrix.sub_mul, Matrix.one_mul, Matrix.smul_mul, Matrix.vecMulVec_mul, h2]; simp
  rw [hPB, hBP]

include hR hskew hsym in
/-- **One eigenvalue of `W̊` on `S²` is `0`**, carried by `g`, at a Ricci-flat `R` and `n ≥ 1`. -/
theorem Bmat_zero_eigen (hn : 0 < n) (hRic : ∀ a b, Ric R a b = 0) :
    ∃ k, (Bmat_isHermitian R hR hskew hsym).eigenvalues k = 0 := by
  have hdet : (Bmat (ringW R)).det = 0 := by
    refine Matrix.exists_mulVec_eq_zero_iff.mp ⟨gvec, fun h => ?_, Bmat_mulVec_g R hR hskew hsym hRic⟩
    have := congrFun h (Sum.inr ⟨0, hn⟩); simp [gvec] at this
  rw [(Bmat_isHermitian R hR hskew hsym).det_eq_prod_eigenvalues] at hdet
  obtain ⟨k, _, hk⟩ := Finset.prod_eq_zero_iff.mp hdet
  exact ⟨k, by exact_mod_cast hk⟩

end W

end HamiltonsCubic.SecondKind
