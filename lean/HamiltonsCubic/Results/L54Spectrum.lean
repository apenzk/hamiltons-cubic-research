import HamiltonsCubic.Results.L54Split

set_option linter.style.longLine false

/-!
# L54's spectra over `𝟏^⊥` and `S²₀`: the full spectrum is the record's plus one `0`

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L54, reads the `ψ`-block's spectrum on `𝟏^⊥` and
`W̊`'s on `S²₀`, where the layer computes on `ℝⁿ` and `S²`. **This file proves the passage as a multiset identity**:

* **`charpoly_null_split`**: a symmetric operator `T` on a finite-dimensional real inner product space with `T g = 0`
  preserves `g^⊥`, and `charpoly T = X ^ dim(ℝ g) · charpoly (T|g^⊥)`;
* **`eigenvalues_null_split`**: for a real symmetric matrix `B` with `B g = 0`, `g ≠ 0`, **the multiset of `B`'s
  eigenvalues is `0 ::ₘ` the multiset of the eigenvalues of `B` restricted to `g^⊥`**, whatever eigenbasis Mathlib
  chose, which is what [L54Split.lean](L54Split.lean) left to reading;
* **`K_spectrum_split`**: at a Ricci-flat `R`, `K`'s spectrum on `ℝⁿ` is its spectrum on `𝟏^⊥` plus one `0`;
* **`Bw_gCoord`**, **`ringW_spectrum_split`**: in any orthonormal basis `ew w` of `S²`, `W̊` kills the metric's
  coordinates, and its spectrum on `S²` is its spectrum on `S²₀ = g^⊥` plus one `0`;
* **`Bmat_eq_Bw_std`**, **`Bmat_spectrum_split`**: [SecondKindMatrix.lean](SecondKindMatrix.lean)'s `Bmat`, which
  [L50Split.lean](L50Split.lean) works with, is `Bw` at the standard family, so the same holds for it.
-/

namespace HamiltonsCubic.SecondKind

open Polynomial Module Matrix

section General

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

omit [FiniteDimensional ℝ E] in
theorem null_perp_invariant {T : E →ₗ[ℝ] E} (hT : T.IsSymmetric) {g : E} (hTg : T g = 0) :
    ∀ x ∈ (ℝ ∙ g)ᗮ, T x ∈ (ℝ ∙ g)ᗮ := by
  intro x hx
  rw [Submodule.mem_orthogonal_singleton_iff_inner_right] at hx ⊢
  rw [← hT, hTg, inner_zero_left]

omit [FiniteDimensional ℝ E] in
theorem null_span_invariant {T : E →ₗ[ℝ] E} {g : E} (hTg : T g = 0) :
    ∀ x ∈ (ℝ ∙ g), T x ∈ (ℝ ∙ g) := by
  intro x hx
  obtain ⟨c, rfl⟩ := Submodule.mem_span_singleton.mp hx
  rw [map_smul, hTg, smul_zero]; exact Submodule.zero_mem _

/-- **`charpoly T = X ^ dim(ℝ g) · charpoly (T|g^⊥)`** for a symmetric `T` killing `g`. -/
theorem charpoly_null_split {T : E →ₗ[ℝ] E} (hT : T.IsSymmetric) {g : E} (hTg : T g = 0) :
    T.charpoly = X ^ finrank ℝ (ℝ ∙ g) * (T.restrict (null_perp_invariant hT hTg)).charpoly := by
  set V := (ℝ ∙ g)
  set W := (ℝ ∙ g)ᗮ
  have hVW : IsCompl V W := V.isCompl_orthogonal
  let F := T.restrict (null_span_invariant (T := T) hTg)
  let G := T.restrict (null_perp_invariant hT hTg)
  have hF : F = 0 := by
    ext ⟨x, hx⟩
    obtain ⟨c, rfl⟩ := Submodule.mem_span_singleton.mp hx
    simp [F, LinearMap.restrict_apply, hTg]
  let e := Submodule.prodEquivOfIsCompl V W hVW
  have hψ : F.prodMap G = e.symm.conj T := by
    apply LinearMap.ext
    rintro ⟨v, w⟩
    rw [LinearEquiv.conj_apply, LinearMap.comp_apply, LinearMap.comp_apply, LinearEquiv.symm_symm,
      LinearEquiv.coe_coe, LinearEquiv.coe_coe, LinearEquiv.eq_symm_apply]
    simp [e, F, G, LinearMap.restrict_apply]
  rw [← e.symm.charpoly_conj T, ← hψ, LinearMap.charpoly_prodMap, hF, LinearMap.charpoly_zero]

end General

section Matrix

variable {m : Type*} [Fintype m] [DecidableEq m]

/-- **The multiset of eigenvalues of a real symmetric `B` with `B g = 0`, `g ≠ 0`, is `0` together with those of `B`
on `g^⊥`.** -/
theorem eigenvalues_null_split {B : Matrix m m ℝ} (hB : B.IsHermitian) {g : m → ℝ} (hg : g ≠ 0)
    (hBg : B *ᵥ g = 0) :
    let T := Matrix.toEuclideanLin B
    let hT : T.IsSymmetric := Matrix.isSymmetric_toEuclideanLin_iff.mpr hB
    let g' : EuclideanSpace ℝ m := WithLp.toLp 2 g
    ∃ hW : ∀ x ∈ (ℝ ∙ g')ᗮ, T x ∈ (ℝ ∙ g')ᗮ,
      Multiset.map hB.eigenvalues Finset.univ.val
        = 0 ::ₘ Multiset.map ((hT.restrict_invariant hW).eigenvalues rfl) Finset.univ.val := by
  intro T hT g'
  have hTg : T g' = 0 := by
    simp only [T, g', Matrix.toLpLin_toLp, Matrix.toLin'_apply, hBg]; rfl
  have hg' : g' ≠ 0 := fun h => hg (by simpa [g'] using congrArg (WithLp.ofLp) h)
  refine ⟨null_perp_invariant hT hTg, ?_⟩
  have hc : B.charpoly = T.charpoly :=
    (Matrix.charpoly_toLin B (EuclideanSpace.basisFun m ℝ).toBasis).symm
  have hsplit := charpoly_null_split hT hTg
  rw [finrank_span_singleton hg', pow_one] at hsplit
  have hroots := hB.roots_charpoly_eq_eigenvalues
  rw [hc, hsplit, Polynomial.roots_mul (by
    rw [← hsplit]; exact (LinearMap.charpoly_monic T).ne_zero), Polynomial.roots_X,
    (hT.restrict_invariant _).roots_charpoly_eq_eigenvalues rfl] at hroots
  simpa [Multiset.singleton_add] using hroots.symm

end Matrix

section Std

open HamiltonsCubic.RealLayer HamiltonsCubic.Results

/-- The standard family `w_k = e_k`. -/
def wStd {n : ℕ} : Fin n → Fin n → ℝ := fun k a => if k = a then 1 else 0

theorem wStd_complete {n : ℕ} (i j : Fin n) : ∑ k, wStd k i * wStd k j = if i = j then 1 else 0 := by
  simp only [wStd, mul_ite, mul_one, mul_zero]
  by_cases hij : i = j
  · subst hij; simp
  · simp [hij, Ne.symm hij]

theorem e_eq_ew_std {n : ℕ} : (e : S2Idx n → Matrix (Fin n) (Fin n) ℝ) = ew wStd := by
  funext u
  cases u with
  | inl p => rfl
  | inr a =>
    change symB a a = Matrix.diagonal (wStd a)
    ext i j
    rw [symB_apply]
    simp only [wStd, Matrix.diagonal_apply]
    by_cases hij : i = j
    · subst hij; by_cases hai : a = i <;> simp [hai]; norm_num
    · simp only [if_neg hij]
      have : ¬(a = i ∧ a = j) := fun h => hij (h.1.symm.trans h.2)
      simp [this]

/-- **`Bmat` is `Bw` at the standard family**, so everything proved for `Bw` holds for `Bmat`. -/
theorem Bmat_eq_Bw_std {n : ℕ} (L : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) : Bmat L = Bw wStd L := by
  ext u v; simp only [Bmat, Bw]; rw [e_eq_ew_std]

end Std

section L54

open HamiltonsCubic.RealLayer HamiltonsCubic.Results

variable {n : ℕ} (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
include hR hskew hsym

/-- **`K`'s spectrum on `ℝⁿ` is its spectrum on `𝟏^⊥` plus one `0`**, at a Ricci-flat `R` and `n ≥ 1`. -/
theorem K_spectrum_split (hn : 0 < n) (hRic : ∀ a b, Ric R a b = 0) :
    let hB := Kmat_isHermitian R hR hskew hsym
    let T := Matrix.toEuclideanLin (Kmat R)
    let hT : T.IsSymmetric := Matrix.isSymmetric_toEuclideanLin_iff.mpr hB
    let g' : EuclideanSpace ℝ (Fin n) := WithLp.toLp 2 (fun _ => 1)
    ∃ hW : ∀ x ∈ (ℝ ∙ g')ᗮ, T x ∈ (ℝ ∙ g')ᗮ,
      Multiset.map hB.eigenvalues Finset.univ.val
        = 0 ::ₘ Multiset.map ((hT.restrict_invariant hW).eigenvalues rfl) Finset.univ.val :=
  eigenvalues_null_split (Kmat_isHermitian R hR hskew hsym)
    (fun h => by have := congrFun h ⟨0, hn⟩; simp at this) (K_one R hRic)

/-- The coordinates of the metric `g = 1` in the basis `ew w` of `S²`. -/
noncomputable def gCoord (w : Fin n → Fin n → ℝ) : S2Idx n → ℝ := fun u => frob 1 (ew w u)

variable (w : Fin n → Fin n → ℝ) (hw : ∀ i j, ∑ k, w k i * w k j = if i = j then 1 else 0)

include hw in
/-- **`W̊ g = 0` in the basis `ew w`**: the matrix `Bw` kills the metric's coordinates at a Ricci-flat `R`. -/
theorem Bw_gCoord (hRic : ∀ a b, Ric R a b = 0) : Bw w (ringW R) *ᵥ gCoord w = 0 := by
  ext u
  simp only [Matrix.mulVec, dotProduct, Bw, gCoord, Pi.zero_apply]
  have h1 : ∑ v, frob (ringW R (ew w u)) (ew w v) * frob 1 (ew w v)
      = frob (∑ v, frob 1 (ew w v) • ew w v) (ringW R (ew w u)) := by
    rw [frob_sum_left]
    exact Finset.sum_congr rfl fun v _ => by rw [frob_smul_left, frob_comm']; ring
  rw [h1, expand_sym_w w hw 1 (Matrix.isSymm_one), frob_comm', ringW_selfAdjoint R hR hskew hsym]
  have h0 : ringW R 1 = 0 := by ext i j; rw [ringW_one R hR, hRic]; simp
  rw [h0]; simp [frob]

omit hR hskew hsym in
include hw in
/-- The metric's coordinates are nonzero at `n ≥ 1`. -/
theorem gCoord_ne_zero (hn : 0 < n) : gCoord w ≠ 0 := by
  intro h
  have h1 := expand_sym_w w hw 1 Matrix.isSymm_one
  have h0 : ∀ u, frob 1 (ew w u) = 0 := fun u => by
    have := congrFun h u; simpa [gCoord] using this
  simp only [h0, zero_smul, Finset.sum_const_zero] at h1
  have := congrFun (congrFun h1 ⟨0, hn⟩) ⟨0, hn⟩
  simp at this

include hw in
/-- **`W̊`'s spectrum on `S²` is its spectrum on `S²₀ = g^⊥` plus one `0`**, at a Ricci-flat `R` and `n ≥ 1`. -/
theorem ringW_spectrum_split (hn : 0 < n) (hRic : ∀ a b, Ric R a b = 0) :
    let hB := Bw_isHermitian R hR hskew hsym w hw
    let T := Matrix.toEuclideanLin (Bw w (ringW R))
    let hT : T.IsSymmetric := Matrix.isSymmetric_toEuclideanLin_iff.mpr hB
    let g' : EuclideanSpace ℝ (S2Idx n) := WithLp.toLp 2 (gCoord w)
    ∃ hW : ∀ x ∈ (ℝ ∙ g')ᗮ, T x ∈ (ℝ ∙ g')ᗮ,
      Multiset.map hB.eigenvalues Finset.univ.val
        = 0 ::ₘ Multiset.map ((hT.restrict_invariant hW).eigenvalues rfl) Finset.univ.val :=
  eigenvalues_null_split _ (gCoord_ne_zero w hw hn) (Bw_gCoord R hR hskew hsym w hw hRic)

/-- **`W̊`'s spectrum on `S²` is its spectrum on `S²₀` plus one `0`, for `Bmat`, the matrix [L50Split.lean](L50Split.lean) works with.** -/
theorem Bmat_spectrum_split (hn : 0 < n) (hRic : ∀ a b, Ric R a b = 0) :
    let hB : (Bmat (ringW R)).IsHermitian :=
      (Bmat_eq_Bw_std (ringW R)).symm ▸ Bw_isHermitian R hR hskew hsym wStd wStd_complete
    let T := Matrix.toEuclideanLin (Bmat (ringW R))
    let hT : T.IsSymmetric := Matrix.isSymmetric_toEuclideanLin_iff.mpr hB
    let g' : EuclideanSpace ℝ (S2Idx n) := WithLp.toLp 2 (gCoord wStd)
    ∃ hW : ∀ x ∈ (ℝ ∙ g')ᗮ, T x ∈ (ℝ ∙ g')ᗮ,
      Multiset.map hB.eigenvalues Finset.univ.val
        = 0 ::ₘ Multiset.map ((hT.restrict_invariant hW).eigenvalues rfl) Finset.univ.val :=
  eigenvalues_null_split _ (gCoord_ne_zero wStd wStd_complete hn)
    (by rw [Bmat_eq_Bw_std]; exact Bw_gCoord R hR hskew hsym wStd wStd_complete hRic)

end L54

end HamiltonsCubic.SecondKind
