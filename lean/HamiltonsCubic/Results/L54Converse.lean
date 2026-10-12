import HamiltonsCubic.Results.L54Diag

set_option linter.style.longLine false

/-!
# L54's (2) in subset-sum form: the converse half of Hardy–Littlewood–Pólya

[findings/second-order.md](../../../findings/second-order.md), Lemma L54 (2): `ω ≻ d` on `S²₀`.
[L54Diag.lean](L54Diag.lean)'s `L54_majorizes_S20` proves it in convex form, `∑ g(d) ≤ ∑ g(ω)` for every convex `g`, with
`ω` and `d` on different index types. [L54Statement.lean](L54Statement.lean)'s `Majorizes` is the subset-sum form on one
type. This file passes from the first to the second:

* **`majorizes_of_convex`**: on one finite type, `∑ g(y) ≤ ∑ g(x)` for every convex `g` gives `Majorizes x y`. The
  equal sums come from `g = ±id`, and the top-`k` bound from `g(t) = max(t − c, 0)` with `c` the least entry of `x` on a
  top-`k` set `T` (SchurMajor's `exists_top_set`): `∑_S y ≤ k c + ∑ g(y) ≤ k c + ∑ g(x) = ∑_T x`;
* **`majorizes_of_convex'`**: across two finite types the constants `±1` force equal sizes, so some `e : M ≃ N` carries
  `y` onto `x`'s type with `Majorizes x (y ∘ e.symm)`;
* **`L54_majorizes_S20_sub`**: L54's (2) on `S²₀` in the record's subset-sum form, `ω ≻ d` after that reindexing,
  whose existence the same convex inequality supplies.
-/

namespace HamiltonsCubic.L54Statement

open Finset

section generic

variable {N : Type*} [Fintype N] [DecidableEq N]

/-- **The converse half of Hardy–Littlewood–Pólya**, on one finite type. -/
theorem majorizes_of_convex (x y : N → ℝ)
    (h : ∀ g : ℝ → ℝ, ConvexOn ℝ Set.univ g → ∑ i, g (y i) ≤ ∑ i, g (x i)) : Majorizes x y := by
  refine ⟨?_, fun S => ?_⟩
  · have h1 := h id (convexOn_id convex_univ)
    have h2 := h (fun t => -t) (concaveOn_id convex_univ).neg
    simp only [id] at h1
    simp only [Finset.sum_neg_distrib] at h2
    linarith
  · obtain ⟨T, hTc, hT⟩ := exists_top_set x S.card (Finset.card_le_univ S)
    refine ⟨T, hTc, ?_⟩
    rcases Finset.eq_empty_or_nonempty T with hT0 | hTne
    · have : S = ∅ := Finset.card_eq_zero.mp (by rw [← hTc, hT0, Finset.card_empty])
      simp [this, hT0]
    obtain ⟨i0, hi0, hmin⟩ := Finset.exists_min_image T x hTne
    set c := x i0
    let g : ℝ → ℝ := fun t => max (t - c) 0
    have hg : ConvexOn ℝ Set.univ g :=
      ((convexOn_id convex_univ).sub (concaveOn_const c convex_univ)).sup (convexOn_const 0 convex_univ)
    have hgx : ∑ i, g (x i) = ∑ i ∈ T, (x i - c) := by
      rw [← Finset.sum_add_sum_compl T]
      have e1 : ∑ i ∈ T, g (x i) = ∑ i ∈ T, (x i - c) :=
        Finset.sum_congr rfl fun i hi => max_eq_left (by linarith [hmin i hi])
      have e2 : ∑ i ∈ Tᶜ, g (x i) = 0 :=
        Finset.sum_eq_zero fun j hj => max_eq_right (by linarith [hT i0 hi0 j (Finset.mem_compl.mp hj)])
      rw [e1, e2, add_zero]
    have hyS : ∑ i ∈ S, y i ≤ ∑ i ∈ S, (c + g (y i)) :=
      Finset.sum_le_sum fun i _ => by have := le_max_left (y i - c) 0; linarith
    have hgS : ∑ i ∈ S, g (y i) ≤ ∑ i, g (y i) :=
      Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ S) fun i _ _ => le_max_right _ _
    have hconv := h g hg
    rw [Finset.sum_add_distrib, Finset.sum_const, nsmul_eq_mul] at hyS
    have hT' : ∑ i ∈ T, (x i - c) = ∑ i ∈ T, x i - T.card * c := by
      rw [Finset.sum_sub_distrib, Finset.sum_const, nsmul_eq_mul]
    rw [hgx, hT', hTc] at hconv
    linarith

end generic

/-- **Across two finite types**: the convex inequality forces equal sizes, and after reindexing `y` majorisation holds. -/
theorem majorizes_of_convex' {M N : Type*} [Fintype M] [Fintype N] [DecidableEq N] (x : N → ℝ) (y : M → ℝ)
    (h : ∀ g : ℝ → ℝ, ConvexOn ℝ Set.univ g → ∑ j, g (y j) ≤ ∑ i, g (x i)) :
    ∃ e : M ≃ N, Majorizes x (y ∘ e.symm) := by
  have c1 := h (fun _ => 1) (convexOn_const 1 convex_univ)
  have c2 := h (fun _ => -1) (convexOn_const (-1) convex_univ)
  simp only [Finset.sum_const, Finset.card_univ, nsmul_eq_mul, mul_one, mul_neg] at c1 c2
  have hc : Fintype.card M = Fintype.card N := by
    have : (Fintype.card M : ℝ) = Fintype.card N := by linarith
    exact_mod_cast this
  let e := Fintype.equivOfCardEq hc
  refine ⟨e, majorizes_of_convex x (y ∘ e.symm) fun g hg => ?_⟩
  simpa [Function.comp_apply, Equiv.sum_comp e.symm (fun j => g (y j))] using h g hg

end HamiltonsCubic.L54Statement

namespace HamiltonsCubic.SecondKind

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.Results

variable {n : ℕ} (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
include hR hskew hsym

/-- **L54's (2) on `S²₀` in subset-sum form**: at a Ricci-flat `R`, the record's diagonal `d` (`d_φ` on the pairs,
`d_ψ = −spec(K on 𝟏^⊥)`), reindexed onto the spectrum's type, is majorised by the spectrum `ω` of `W̊` on `S²₀`. -/
theorem L54_majorizes_S20_sub (hn : 0 < n) (hRic : ∀ a b, Ric R a b = 0) :
    let w := wK R hR hskew hsym
    let TW := Matrix.toEuclideanLin (Bw w (ringW R))
    let hTW : TW.IsSymmetric :=
      Matrix.isSymmetric_toEuclideanLin_iff.mpr (Bw_isHermitian R hR hskew hsym w (wK_complete R hR hskew hsym))
    let gW : EuclideanSpace ℝ (S2Idx n) := WithLp.toLp 2 (gCoord w)
    let TK := Matrix.toEuclideanLin (Kmat R)
    let hTK : TK.IsSymmetric := Matrix.isSymmetric_toEuclideanLin_iff.mpr (Kmat_isHermitian R hR hskew hsym)
    let gK : EuclideanSpace ℝ (Fin n) := WithLp.toLp 2 (fun _ => 1)
    ∃ (hWW : ∀ x ∈ (ℝ ∙ gW)ᗮ, TW x ∈ (ℝ ∙ gW)ᗮ) (hWK : ∀ x ∈ (ℝ ∙ gK)ᗮ, TK x ∈ (ℝ ∙ gK)ᗮ)
      (e : (Pairs n ⊕ Fin (Module.finrank ℝ ↥(ℝ ∙ gK)ᗮ)) ≃ Fin (Module.finrank ℝ ↥(ℝ ∙ gW)ᗮ)),
      HamiltonsCubic.L54Statement.Majorizes ((hTW.restrict_invariant hWW).eigenvalues rfl)
        (Sum.elim (fun p : Pairs n => Bw w (ringW R) (Sum.inl p) (Sum.inl p))
          (fun i => -(hTK.restrict_invariant hWK).eigenvalues rfl i) ∘ e.symm) := by
  intro w TW hTW gW TK hTK gK
  obtain ⟨hWW, hWK, hconv⟩ := L54_majorizes_S20 R hR hskew hsym hn hRic
  obtain ⟨e, he⟩ := HamiltonsCubic.L54Statement.majorizes_of_convex' ((hTW.restrict_invariant hWW).eigenvalues rfl)
    (Sum.elim (fun p : Pairs n => Bw w (ringW R) (Sum.inl p) (Sum.inl p))
      (fun i => -(hTK.restrict_invariant hWK).eigenvalues rfl i)) (fun g hg => by
        have := hconv hg
        simp only [Multiset.map_add, Multiset.sum_add, Multiset.map_map, Function.comp_def] at this
        rw [Fintype.sum_sum_type]
        exact this)
  exact ⟨hWW, hWK, e, he⟩

end HamiltonsCubic.SecondKind
