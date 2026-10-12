import HamiltonsCubic.Results.L54Diag

set_option linter.style.longLine false

/-!
# L52's conditions on `S²` against `S²₀`

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L52, reads its lower bound `ω ≥ -m` on `S²₀` and its
diagonal `K'` on `𝟏^⊥`, where the layer computes on `S²` and `ℝⁿ`. **This file carries the two passages**:

* **`omega_lower_iff`**: at a Ricci-flat `R`, every eigenvalue of `W̊` on `S²` is at least `-m` exactly when every
  eigenvalue on `S²₀` is and `0 ≥ -m`, through `ringW_spectrum_split`'s one extra `0`;
* the diagonal's passage, that at an eigenbasis `wK` of `K` the `ψ`-diagonal is minus the spectrum of `K` on `𝟏^⊥` with
  one extra `0`, which is the record's `ψ`-block of `K'` plus one `0`, is [L54Diag.lean](L54Diag.lean)'s `dpsi_split`;
* **`sum_omega_w_zero`**: `Σ ω = 0` for `Bw w` at any complete `w`, from `Bmat`'s `sum_omega_zero` through `trace_Bw_eq`,
  and `neg_m_le_zero`, with which it supplies `0 ≥ -m` at a Weyl `R` (the least eigenvalue is at most the mean `0`);
* **`sum_diag_split`**, **`L52_record_S20`**: L52's bound with the record's objects on `S²₀`, `ω ≥ -m` on the spectrum of
  `W̊` on `S²₀` and the record's `K'` (the pair diagonal and `-spec(K|𝟏^⊥)`) in `p₂` and `p₃`, composing `L52_record` at
  `wK` with `ringW_spectrum_split` and `sum_diag_split`, the extra `0` adding nothing to either power sum.
-/

namespace HamiltonsCubic.SecondKind

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.Results

variable {n : ℕ} (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
    (w : Fin n → Fin n → ℝ) (hw : ∀ i j, ∑ k, w k i * w k j = if i = j then 1 else 0)
include hR hskew hsym hw

/-- **`ω ≥ -m` on `S²` is `ω ≥ -m` on `S²₀` plus `0 ≥ -m`.** -/
theorem omega_lower_iff (hn : 0 < n) (hRic : ∀ a b, Ric R a b = 0) (m : ℝ) :
    let hB := Bw_isHermitian R hR hskew hsym w hw
    let T := Matrix.toEuclideanLin (Bw w (ringW R))
    let hT : T.IsSymmetric := Matrix.isSymmetric_toEuclideanLin_iff.mpr hB
    let g' : EuclideanSpace ℝ (S2Idx n) := WithLp.toLp 2 (gCoord w)
    ∃ hW : ∀ x ∈ (ℝ ∙ g')ᗮ, T x ∈ (ℝ ∙ g')ᗮ,
      ((∀ u, -m ≤ hB.eigenvalues u) ↔ ((∀ i, -m ≤ (hT.restrict_invariant hW).eigenvalues rfl i) ∧ -m ≤ 0)) := by
  intro hB T hT g'
  obtain ⟨hW, h⟩ := ringW_spectrum_split R hR hskew hsym w hw hn hRic
  refine ⟨hW, ?_⟩
  have key : ∀ x : ℝ, x ∈ Multiset.map hB.eigenvalues Finset.univ.val ↔
      x = 0 ∨ x ∈ Multiset.map ((hT.restrict_invariant hW).eigenvalues rfl) Finset.univ.val := by
    intro x; rw [h, Multiset.mem_cons]
  constructor
  · intro hall
    refine ⟨fun i => ?_, ?_⟩
    · obtain ⟨u, _, hu⟩ := Multiset.mem_map.mp ((key _).mpr (Or.inr (Multiset.mem_map_of_mem _ (Finset.mem_univ_val i))))
      rw [← hu]; exact hall u
    · obtain ⟨u, _, hu⟩ := Multiset.mem_map.mp ((key 0).mpr (Or.inl rfl))
      rw [← hu]; exact hall u
  · rintro ⟨hall, h0⟩ u
    rcases (key _).mp (Multiset.mem_map_of_mem _ (Finset.mem_univ_val u)) with hz | hmem
    · rw [hz]; exact h0
    · obtain ⟨i, _, hi⟩ := Multiset.mem_map.mp hmem
      rw [← hi]; exact hall i

/-- **`Σ ω = 0` in any complete basis `ew w`**, from `Bmat`'s `sum_omega_zero` through `trace_Bw_eq`. -/
theorem sum_omega_w_zero (hRic : ∀ a b, Ric R a b = 0) :
    ∑ j, (Bw_isHermitian R hR hskew hsym w hw).eigenvalues j = 0 := by
  have h1 := trace_pow_eq_sum_eigenvalues (Bw w (ringW R)) (Bw_isHermitian R hR hskew hsym w hw) 1
  have h2 := trace_pow_eq_sum_eigenvalues (Bmat (ringW R)) (Bmat_isHermitian R hR hskew hsym) 1
  simp only [pow_one] at h1 h2
  rw [← h1, trace_Bw_eq w hw (ringW R) (fun c => ringW_sum_smul R _ c _), h2]
  exact sum_omega_zero R hR hskew hsym hRic

omit hR hskew hsym hw in
/-- **A lower bound on a mean-zero family is nonpositive**: `-m ≤ x_u` for all `u` and `Σ x = 0` over a non-empty index
give `-m ≤ 0`. -/
theorem neg_m_le_zero {N : Type*} [Fintype N] [Nonempty N] (x : N → ℝ) (hs : ∑ u, x u = 0) {m : ℝ}
    (hm : ∀ u, -m ≤ x u) : -m ≤ 0 := by
  have hc : (0 : ℝ) < Fintype.card N := by exact_mod_cast Fintype.card_pos
  have : (Fintype.card N : ℝ) * (-m) ≤ ∑ u, x u := by
    rw [← nsmul_eq_mul, ← Finset.card_univ, ← Finset.sum_const]; exact Finset.sum_le_sum fun u _ => hm u
  rw [hs] at this
  nlinarith

omit hw in
/-- A sum over `S²` of `g(d_u)` with `g 0 = 0` is the sum over the record's `K'`: the pair diagonal plus `-spec(K|𝟏^⊥)`. -/
theorem sum_diag_split (hn : 0 < n) (hRic : ∀ a b, Ric R a b = 0) (g : ℝ → ℝ) (hg : g 0 = 0) :
    let w := wK R hR hskew hsym
    let TK := Matrix.toEuclideanLin (Kmat R)
    let hTK : TK.IsSymmetric := Matrix.isSymmetric_toEuclideanLin_iff.mpr (Kmat_isHermitian R hR hskew hsym)
    let gK : EuclideanSpace ℝ (Fin n) := WithLp.toLp 2 (fun _ => 1)
    ∃ hWK : ∀ x ∈ (ℝ ∙ gK)ᗮ, TK x ∈ (ℝ ∙ gK)ᗮ,
      ∑ u, g (Bw w (ringW R) u u)
        = (Multiset.map g (Multiset.map (fun p : Pairs n => Bw w (ringW R) (Sum.inl p) (Sum.inl p)) Finset.univ.val
          + Multiset.map (fun i => -(hTK.restrict_invariant hWK).eigenvalues rfl i) Finset.univ.val)).sum := by
  intro w TK hTK gK
  obtain ⟨hWK, hd⟩ := dpsi_split R hR hskew hsym hn hRic
  refine ⟨hWK, ?_⟩
  have hsplit : Multiset.map (fun u => Bw w (ringW R) u u) (Finset.univ : Finset (S2Idx n)).val
      = Multiset.map (fun p : Pairs n => Bw w (ringW R) (Sum.inl p) (Sum.inl p)) Finset.univ.val
        + Multiset.map (fun k => Bw w (ringW R) (Sum.inr k) (Sum.inr k)) Finset.univ.val := by
    rw [← Finset.univ_disjSum_univ, Finset.val_disjSum, Multiset.disjSum, Multiset.map_add, Multiset.map_map,
      Multiset.map_map]
    rfl
  have hL : ∑ u, g (Bw w (ringW R) u u)
      = (Multiset.map g (Multiset.map (fun u => Bw w (ringW R) u u) (Finset.univ : Finset (S2Idx n)).val)).sum := by
    rw [Multiset.map_map]; rfl
  rw [hL, hsplit, hd]
  simp only [Multiset.map_add, Multiset.map_cons, Multiset.sum_add, Multiset.sum_cons, hg, zero_add]
  rfl

omit hw in
/-- **L52 at the record's objects on `S²₀`**: with `ω ≥ -m` on the spectrum of `W̊` on `S²₀`, the bound holds with the
record's `K'` (the pair diagonal and `-spec(K|𝟏^⊥)`) in its `p₂` and `p₃`. The extra `0` on `S²` is supplied, and
`0 ≥ -m` follows from `Σ ω = 0` on a non-empty `S²₀`. -/
theorem L52_record_S20 (hn : 0 < n) (hB : ∀ i j k l, bianchi R i j k l = 0) (hunit : normSq R = 1)
    (hRic : ∀ a b, Ric R a b = 0) (Mp m : ℝ)
    (hμ : ∀ j, (Mpair_isHermitian R hR hskew hsym).eigenvalues j ≤ Mp) :
    let w := wK R hR hskew hsym
    let TW := Matrix.toEuclideanLin (Bw w (ringW R))
    let hTW : TW.IsSymmetric :=
      Matrix.isSymmetric_toEuclideanLin_iff.mpr (Bw_isHermitian R hR hskew hsym w (wK_complete R hR hskew hsym))
    let gW : EuclideanSpace ℝ (S2Idx n) := WithLp.toLp 2 (gCoord w)
    let TK := Matrix.toEuclideanLin (Kmat R)
    let hTK : TK.IsSymmetric := Matrix.isSymmetric_toEuclideanLin_iff.mpr (Kmat_isHermitian R hR hskew hsym)
    let gK : EuclideanSpace ℝ (Fin n) := WithLp.toLp 2 (fun _ => 1)
    ∃ (hWW : ∀ x ∈ (ℝ ∙ gW)ᗮ, TW x ∈ (ℝ ∙ gW)ᗮ) (hWK : ∀ x ∈ (ℝ ∙ gK)ᗮ, TK x ∈ (ℝ ∙ gK)ᗮ),
      (∀ i, -m ≤ (hTW.restrict_invariant hWW).eigenvalues rfl i) →
      let K' := Multiset.map (fun p : Pairs n => Bw w (ringW R) (Sum.inl p) (Sum.inl p)) Finset.univ.val
          + Multiset.map (fun i => -(hTK.restrict_invariant hWK).eigenvalues rfl i) Finset.univ.val
      Pcubic R ≤ (3 / 2) * (∑ p : Pairs n, Kmat R p.1.1 p.1.2 ^ 3
            + 3 * Mp * (1 - ∑ p : Pairs n, Kmat R p.1.1 p.1.2 ^ 2))
          - (1 / 2) * ((Multiset.map (· ^ 3) K').sum + 3 * m * ((Multiset.map (· ^ 2) K').sum - 3)) := by
  intro w TW hTW gW TK hTK gK
  have hwc := wK_complete R hR hskew hsym
  obtain ⟨hWW, hω⟩ := ringW_spectrum_split R hR hskew hsym w hwc hn hRic
  obtain ⟨hWK, h3⟩ := sum_diag_split R hR hskew hsym hn hRic (· ^ 3) (by norm_num)
  obtain ⟨_, h2⟩ := sum_diag_split R hR hskew hsym hn hRic (· ^ 2) (by norm_num)
  refine ⟨hWW, hWK, fun hω20 => ?_⟩
  intro K'
  have hB' := Bw_isHermitian R hR hskew hsym w hwc
  set rest := Multiset.map ((hTW.restrict_invariant hWW).eigenvalues rfl) Finset.univ.val with hrest
  -- `Σ` of the restricted spectrum vanishes
  have hsum0 : rest.sum = 0 := by
    have hz := sum_omega_w_zero R hR hskew hsym w hwc hRic
    have : ∑ j, hB'.eigenvalues j = (Multiset.map hB'.eigenvalues Finset.univ.val).sum := rfl
    rw [this, hω, Multiset.sum_cons, zero_add] at hz
    exact hz
  -- and it is non-empty, `Σ ω² = 3`
  have hne : rest ≠ 0 := by
    intro h0
    have hsq := sum_omega_w_sq R hR hskew hsym w hwc hB
    rw [hunit] at hsq
    have : ∑ j, hB'.eigenvalues j ^ 2 = (Multiset.map (· ^ 2) (Multiset.map hB'.eigenvalues Finset.univ.val)).sum := by
      rw [Multiset.map_map]; rfl
    rw [this, hω, h0] at hsq
    norm_num at hsq
  obtain ⟨x, hx⟩ := Multiset.exists_mem_of_ne_zero hne
  obtain ⟨i0, _, _⟩ := Multiset.mem_map.mp hx
  haveI : Nonempty (Fin (Module.finrank ℝ (ℝ ∙ gW)ᗮ)) := ⟨i0⟩
  have hm0 : -m ≤ 0 := neg_m_le_zero _ hsum0 hω20
  -- `ω ≥ -m` on `S²`
  have hωfull : ∀ j, -m ≤ hB'.eigenvalues j := by
    intro j
    have hmem : hB'.eigenvalues j ∈ Multiset.map hB'.eigenvalues Finset.univ.val :=
      Multiset.mem_map_of_mem _ (Finset.mem_univ_val j)
    rw [hω, Multiset.mem_cons] at hmem
    rcases hmem with h | h
    · rw [h]; exact hm0
    · obtain ⟨i, _, hi⟩ := Multiset.mem_map.mp h
      rw [← hi]; exact hω20 i
  have h := L52_record R hR hskew hsym w hwc hB hunit Mp m hμ hωfull
  rw [h3, h2] at h
  exact h

end HamiltonsCubic.SecondKind
