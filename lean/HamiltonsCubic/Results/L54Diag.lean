import HamiltonsCubic.Results.L54Spectrum
import HamiltonsCubic.Results.L50Split

set_option linter.style.longLine false

/-!
# L54's `ψ`-diagonal over `ℝⁿ` is the record's over `𝟏^⊥` plus one `0`

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L54, reads the diagonal `d_ψ` of `W̊` on an eigenbasis
of `K` inside `𝟏^⊥`, and [L54Rigid.lean](L54Rigid.lean) reads it on Mathlib's eigenbasis `wK` of `K` on `ℝⁿ`. On any
orthonormal eigenfamily `d_ψ` is minus the eigenvalues (`psi_block`), so the record's `d_ψ` is minus the spectrum of
`K` on `𝟏^⊥`. **This file proves the passage**:

* **`dpsi_eq_neg_eigen`**: the layer's `d_ψ(k) = -κ_k`, `κ` Mathlib's eigenvalues of `K`;
* **`dpsi_split`**: at a Ricci-flat `R` and `n ≥ 1`, the multiset of the layer's `d_ψ` is `0` together with minus the
  eigenvalues of `K` restricted to `𝟏^⊥`, whatever eigenbasis Mathlib chose;
* **`gCoord_wStd_eq_gvec`**: the metric's coordinates at the standard family are [L50Split.lean](L50Split.lean)'s
  `gvec`, so `Bmat_spectrum_split`'s `g^⊥` is the `S²₀` of `Bmat_compress`.

* **`L54_rigidity_S20`**: L54's (4) on the record's `S²₀`, the spectrum of `W̊` there equal as a multiset to the
  record's `d` at `t_F = 2`, by multiset cancellation of the shared `0`.

* **`L54_majorizes_S20`**: L54's (2) on `S²₀` in the convex form of majorisation, `Σ g(d) ≤ Σ g(ω)` for every convex
  `g`, from SchurMajor's `diag_convex_le_spectrum` on `S²` with the shared `g(0)` removed.

[L54Converse.lean](L54Converse.lean)'s `L54_majorizes_S20_sub` passes from that convex form to the subset-sum `Majorizes`
of L54Statement, through the converse half of Hardy–Littlewood–Pólya and a reindexing of `d` onto `ω`'s type.
-/

namespace HamiltonsCubic.SecondKind

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.Results

variable {n : ℕ} (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
include hR hskew hsym

/-- **The layer's `d_ψ(k)` is `-κ_k`.** -/
theorem dpsi_eq_neg_eigen (k : Fin n) :
    Bw (wK R hR hskew hsym) (ringW R) (Sum.inr k) (Sum.inr k)
      = -(Kmat_isHermitian R hR hskew hsym).eigenvalues k := by
  rw [Bw_diag_psi R hR hskew hsym (wK R hR hskew hsym) k,
    wK_eigen R hR hskew hsym k, dotProduct_smul, wK_norm R hR hskew hsym k, smul_eq_mul, mul_one]

/-- **The layer's `d_ψ` is the record's `d_ψ` on `𝟏^⊥` plus one `0`**, as multisets. -/
theorem dpsi_split (hn : 0 < n) (hRic : ∀ a b, Ric R a b = 0) :
    let T := Matrix.toEuclideanLin (Kmat R)
    let hT : T.IsSymmetric := Matrix.isSymmetric_toEuclideanLin_iff.mpr (Kmat_isHermitian R hR hskew hsym)
    let g' : EuclideanSpace ℝ (Fin n) := WithLp.toLp 2 (fun _ => 1)
    ∃ hW : ∀ x ∈ (ℝ ∙ g')ᗮ, T x ∈ (ℝ ∙ g')ᗮ,
      Multiset.map (fun k => Bw (wK R hR hskew hsym) (ringW R) (Sum.inr k) (Sum.inr k)) Finset.univ.val
        = 0 ::ₘ Multiset.map (fun i => -(hT.restrict_invariant hW).eigenvalues rfl i) Finset.univ.val := by
  intro T hT g'
  obtain ⟨hW, h⟩ := K_spectrum_split R hR hskew hsym hn hRic
  refine ⟨hW, ?_⟩
  calc Multiset.map (fun k => Bw (wK R hR hskew hsym) (ringW R) (Sum.inr k) (Sum.inr k)) Finset.univ.val
        = Multiset.map (fun x : ℝ => -x)
            (Multiset.map (Kmat_isHermitian R hR hskew hsym).eigenvalues Finset.univ.val) := by
          rw [Multiset.map_map]
          exact Multiset.map_congr rfl fun k _ => dpsi_eq_neg_eigen R hR hskew hsym k
    _ = _ := by
          rw [h]
          simp only [Fin.univ_val_map, Multiset.cons_coe, Multiset.map_coe, List.map_cons, neg_zero,
            List.map_ofFn, Function.comp_def, Multiset.coe_eq_coe, List.perm_cons]
          exact List.Perm.refl _

omit hR hskew hsym in
/-- **`gCoord wStd = gvec`**: at the standard family the metric's coordinates are `0` on pairs and `1` on the diagonal. -/
theorem gCoord_wStd_eq_gvec : gCoord (wStd (n := n)) = gvec := by
  funext u
  rw [gCoord, ← e_eq_ew_std, frob_comm', frob_one]
  cases u with
  | inl p =>
    have hp := p.2
    simp only [e, gvec, Sum.elim_inl, Matrix.trace, Matrix.diag, Matrix.smul_apply, smul_eq_mul, symB_apply]
    refine Finset.sum_eq_zero fun i _ => ?_
    have h1 : ¬(p.1.1 = i ∧ p.1.2 = i) := fun h => absurd (h.1 ▸ h.2 ▸ hp) (lt_irrefl _)
    have h2 : ¬(p.1.2 = i ∧ p.1.1 = i) := fun h => h1 ⟨h.2, h.1⟩
    rw [if_neg h1, if_neg h2]; ring
  | inr a =>
    simp only [e, gvec, Sum.elim_inr, Matrix.trace, Matrix.diag, symB_apply]
    rw [Finset.sum_eq_single a (fun b _ hb => by simp [Ne.symm hb]) (by simp)]
    simp; norm_num

omit hR hskew hsym in
/-- A permutation does not change the multiset of values. -/
theorem sameSorted_multiset {N : Type*} [Fintype N] {x y : N → ℝ} (h : HamiltonsCubic.L54Statement.SameSorted x y) :
    Multiset.map x Finset.univ.val = Multiset.map y Finset.univ.val := by
  obtain ⟨σ, hσ⟩ := h
  have : y = x ∘ σ := funext hσ
  rw [this, ← Multiset.map_map]
  congr 1
  exact (Finset.map_univ_equiv σ).symm ▸ by simp [Finset.map_val]

/-- **L54 (4) on `S²₀`**: at `t_F = 2`, unit norm, first Bianchi and Ricci-flatness, the spectrum of `W̊` on `S²₀` is,
as a multiset, the record's diagonal `d`: `d_φ` on the pairs and `d_ψ = -spec(K|𝟏^⊥)`. -/
theorem L54_rigidity_S20 (hn : 0 < n) (hB : ∀ i j k l, bianchi R i j k l = 0) (hunit : normSq R = 1)
    (ht : tF R = 2) (hRic : ∀ a b, Ric R a b = 0) :
    let w := wK R hR hskew hsym
    let TW := Matrix.toEuclideanLin (Bw w (ringW R))
    let hTW : TW.IsSymmetric :=
      Matrix.isSymmetric_toEuclideanLin_iff.mpr (Bw_isHermitian R hR hskew hsym w (wK_complete R hR hskew hsym))
    let gW : EuclideanSpace ℝ (S2Idx n) := WithLp.toLp 2 (gCoord w)
    let TK := Matrix.toEuclideanLin (Kmat R)
    let hTK : TK.IsSymmetric := Matrix.isSymmetric_toEuclideanLin_iff.mpr (Kmat_isHermitian R hR hskew hsym)
    let gK : EuclideanSpace ℝ (Fin n) := WithLp.toLp 2 (fun _ => 1)
    ∃ (hWW : ∀ x ∈ (ℝ ∙ gW)ᗮ, TW x ∈ (ℝ ∙ gW)ᗮ) (hWK : ∀ x ∈ (ℝ ∙ gK)ᗮ, TK x ∈ (ℝ ∙ gK)ᗮ),
      Multiset.map ((hTW.restrict_invariant hWW).eigenvalues rfl) Finset.univ.val
        = Multiset.map (fun p : Pairs n => Bw w (ringW R) (Sum.inl p) (Sum.inl p)) Finset.univ.val
          + Multiset.map (fun i => -(hTK.restrict_invariant hWK).eigenvalues rfl i) Finset.univ.val := by
  intro w TW hTW gW TK hTK gK
  obtain ⟨hWW, hω⟩ := ringW_spectrum_split R hR hskew hsym w (wK_complete R hR hskew hsym) hn hRic
  obtain ⟨hWK, hd⟩ := dpsi_split R hR hskew hsym hn hRic
  refine ⟨hWW, hWK, ?_⟩
  have hsame := sameSorted_multiset (L54_rigidity R hR hskew hsym hB hunit ht).2
  have hsplit : Multiset.map (fun u => Bw w (ringW R) u u) (Finset.univ : Finset (S2Idx n)).val
      = Multiset.map (fun p : Pairs n => Bw w (ringW R) (Sum.inl p) (Sum.inl p)) Finset.univ.val
        + Multiset.map (fun k => Bw w (ringW R) (Sum.inr k) (Sum.inr k)) Finset.univ.val := by
    rw [← Finset.univ_disjSum_univ, Finset.val_disjSum, Multiset.disjSum, Multiset.map_add, Multiset.map_map,
      Multiset.map_map]
    rfl
  rw [hω, hsplit, hd, Multiset.add_cons] at hsame
  exact Multiset.cons_inj_right 0 |>.mp hsame

/-- **L54 (2) on `S²₀`, in the convex form of majorisation**: for every convex `g`, the record's diagonal `d` on `S²₀`
(`d_φ` on the pairs, `d_ψ = -spec(K|𝟏^⊥)`) satisfies `Σ g(d) ≤ Σ g(ω)`, `ω` the spectrum of `W̊` on `S²₀`, at a
Ricci-flat `R`. Schur's inequality on `S²` with the shared `g(0)` removed. -/
theorem L54_majorizes_S20 (hn : 0 < n) (hRic : ∀ a b, Ric R a b = 0) :
    let w := wK R hR hskew hsym
    let TW := Matrix.toEuclideanLin (Bw w (ringW R))
    let hTW : TW.IsSymmetric :=
      Matrix.isSymmetric_toEuclideanLin_iff.mpr (Bw_isHermitian R hR hskew hsym w (wK_complete R hR hskew hsym))
    let gW : EuclideanSpace ℝ (S2Idx n) := WithLp.toLp 2 (gCoord w)
    let TK := Matrix.toEuclideanLin (Kmat R)
    let hTK : TK.IsSymmetric := Matrix.isSymmetric_toEuclideanLin_iff.mpr (Kmat_isHermitian R hR hskew hsym)
    let gK : EuclideanSpace ℝ (Fin n) := WithLp.toLp 2 (fun _ => 1)
    ∃ (hWW : ∀ x ∈ (ℝ ∙ gW)ᗮ, TW x ∈ (ℝ ∙ gW)ᗮ) (hWK : ∀ x ∈ (ℝ ∙ gK)ᗮ, TK x ∈ (ℝ ∙ gK)ᗮ),
      ∀ {g : ℝ → ℝ}, ConvexOn ℝ Set.univ g →
        (Multiset.map g (Multiset.map (fun p : Pairs n => Bw w (ringW R) (Sum.inl p) (Sum.inl p)) Finset.univ.val
          + Multiset.map (fun i => -(hTK.restrict_invariant hWK).eigenvalues rfl i) Finset.univ.val)).sum
        ≤ (Multiset.map g (Multiset.map ((hTW.restrict_invariant hWW).eigenvalues rfl) Finset.univ.val)).sum := by
  intro w TW hTW gW TK hTK gK
  obtain ⟨hWW, hω⟩ := ringW_spectrum_split R hR hskew hsym w (wK_complete R hR hskew hsym) hn hRic
  obtain ⟨hWK, hd⟩ := dpsi_split R hR hskew hsym hn hRic
  refine ⟨hWW, hWK, fun {g} hg => ?_⟩
  have hB := Bw_isHermitian R hR hskew hsym w (wK_complete R hR hskew hsym)
  have hS := HamiltonsCubic.L54Statement.diag_convex_le_spectrum _ hB hg
  have hsplit : Multiset.map (fun u => Bw w (ringW R) u u) (Finset.univ : Finset (S2Idx n)).val
      = Multiset.map (fun p : Pairs n => Bw w (ringW R) (Sum.inl p) (Sum.inl p)) Finset.univ.val
        + Multiset.map (fun k => Bw w (ringW R) (Sum.inr k) (Sum.inr k)) Finset.univ.val := by
    rw [← Finset.univ_disjSum_univ, Finset.val_disjSum, Multiset.disjSum, Multiset.map_add, Multiset.map_map,
      Multiset.map_map]
    rfl
  have hL : ∑ u, g (Bw w (ringW R) u u)
      = (Multiset.map g (Multiset.map (fun u => Bw w (ringW R) u u) (Finset.univ : Finset (S2Idx n)).val)).sum := by
    rw [Multiset.map_map]; rfl
  have hR' : ∑ j, g (hB.eigenvalues j) = (Multiset.map g (Multiset.map hB.eigenvalues Finset.univ.val)).sum := by
    rw [Multiset.map_map]; rfl
  rw [hL, hR', hsplit, hd, hω] at hS
  simp only [Multiset.map_add, Multiset.map_cons, Multiset.sum_add, Multiset.sum_cons] at hS ⊢
  linarith

end HamiltonsCubic.SecondKind
