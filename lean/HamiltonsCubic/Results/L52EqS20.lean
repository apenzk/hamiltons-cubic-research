import HamiltonsCubic.Results.L52RecordEq
import HamiltonsCubic.Results.L52S20

set_option linter.style.longLine false

/-!
# L52's "only if" half on `S²₀`

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L52's equality clause, read on the record's `S²₀`.
[L52S20.lean](L52S20.lean)'s `L52_record_S20` states the bound with the record's `K'` on `S²₀` and `ω ≥ −m` on the spectrum
of `W̊` on `S²₀`. This file gives its equality case:

* **`L52_eq_S20`**: at a first-Bianchi, unit-norm, Ricci-flat `W`, with `μ ≤ M₊` and `ω ≥ −m` on `S²₀`, equality in the
  `S²₀` display makes `M` diagonal in the pair basis and `W̊` diagonal in `{φ_ab} ∪ {diag (wK k)}`, the basis of `S²`
  at `wK`. The `S²₀` equality is the `S²` equality at `wK` through `sum_diag_split`, and the `S²`
  lower bound follows from the `S²₀` one as in `L52_record_S20`.

* **`diag_zero_of_complete`**, **`S20_basis_diag`**: the restriction to the record's basis of `S²₀`. Once `W̊` is
  diagonal in the basis of `S²` at `wK`, its pair–pair block stays diagonal, and every pair–`ψ` entry `∑_a (W̊ φ_p)_aa v(a)`
  (`frob_diag_left`) vanishes for every `v`. Separately, with no equality needed, the `ψ`–`ψ` block is `diag(−κ)` at every
  orthonormal eigenfamily of `K` (`psi_block`).
-/

namespace HamiltonsCubic.SecondKind

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.Results

variable {n : ℕ} (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
include hR hskew hsym

/-- **The "only if" half on `S²₀`.** -/
theorem L52_eq_S20 (hn : 0 < n) (hB : ∀ i j k l, bianchi R i j k l = 0) (hunit : normSq R = 1)
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
      Pcubic R = (3 / 2) * (∑ p : Pairs n, Kmat R p.1.1 p.1.2 ^ 3
            + 3 * Mp * (1 - ∑ p : Pairs n, Kmat R p.1.1 p.1.2 ^ 2))
          - (1 / 2) * ((Multiset.map (· ^ 3) (Multiset.map (fun p : Pairs n => Bw w (ringW R) (Sum.inl p) (Sum.inl p))
                Finset.univ.val + Multiset.map (fun i => -(hTK.restrict_invariant hWK).eigenvalues rfl i) Finset.univ.val)).sum
            + 3 * m * ((Multiset.map (· ^ 2) (Multiset.map (fun p : Pairs n => Bw w (ringW R) (Sum.inl p) (Sum.inl p))
                Finset.univ.val + Multiset.map (fun i => -(hTK.restrict_invariant hWK).eigenvalues rfl i) Finset.univ.val)).sum
              - 3)) →
      (∀ p q, p ≠ q → Mpair R p q = 0) ∧ (∀ u v, u ≠ v → Bw w (ringW R) u v = 0) := by
  intro w TW hTW gW TK hTK gK
  have hwc := wK_complete R hR hskew hsym
  obtain ⟨hWW, hω⟩ := ringW_spectrum_split R hR hskew hsym w hwc hn hRic
  obtain ⟨hWK, h3⟩ := sum_diag_split R hR hskew hsym hn hRic (· ^ 3) (by norm_num)
  obtain ⟨_, h2⟩ := sum_diag_split R hR hskew hsym hn hRic (· ^ 2) (by norm_num)
  refine ⟨hWW, hWK, fun hω20 heq => ?_⟩
  have hB' := Bw_isHermitian R hR hskew hsym w hwc
  set rest := Multiset.map ((hTW.restrict_invariant hWW).eigenvalues rfl) Finset.univ.val with hrest
  have hsum0 : rest.sum = 0 := by
    have hz := sum_omega_w_zero R hR hskew hsym w hwc hRic
    have : ∑ j, hB'.eigenvalues j = (Multiset.map hB'.eigenvalues Finset.univ.val).sum := rfl
    rw [this, hω, Multiset.sum_cons, zero_add] at hz
    exact hz
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
  have : Nonempty (Fin (Module.finrank ℝ (ℝ ∙ gW)ᗮ)) := ⟨i0⟩
  have hm0 : -m ≤ 0 := neg_m_le_zero _ hsum0 hω20
  have hωfull : ∀ j, -m ≤ hB'.eigenvalues j := by
    intro j
    have hmem : hB'.eigenvalues j ∈ Multiset.map hB'.eigenvalues Finset.univ.val :=
      Multiset.mem_map_of_mem _ (Finset.mem_univ_val j)
    rw [hω, Multiset.mem_cons] at hmem
    rcases hmem with h | h
    · rw [h]; exact hm0
    · obtain ⟨i, _, hi⟩ := Multiset.mem_map.mp h
      rw [← hi]; exact hω20 i
  simp only at h3 h2
  rw [← h3, ← h2] at heq
  exact L52_record_eq R hR hskew hsym w hwc hB hunit Mp m hμ hωfull heq

omit hR hskew hsym in
/-- A matrix whose diagonal is orthogonal to every member of a complete family has zero diagonal. -/
theorem diag_zero_of_complete (X : Matrix (Fin n) (Fin n) ℝ) (w : Fin n → Fin n → ℝ)
    (hw : ∀ i j, ∑ k, w k i * w k j = if i = j then 1 else 0) (h : ∀ k, ∑ a, X a a * w k a = 0) (a : Fin n) :
    X a a = 0 := by
  have e : X a a = ∑ b, X b b * (if b = a then 1 else 0) := by
    rw [Finset.sum_eq_single a (fun b _ hb => by rw [if_neg hb, mul_zero]) (by simp)]; simp
  rw [e]
  simp only [← hw]
  simp only [Finset.mul_sum]
  rw [Finset.sum_comm]
  exact Finset.sum_eq_zero fun k _ => by
    rw [show ∑ b, X b b * (w k b * w k a) = (∑ b, X b b * w k b) * w k a by
      rw [Finset.sum_mul]; exact Finset.sum_congr rfl fun b _ => by ring, h k, zero_mul]

/-- **The restriction to the record's basis of `S²₀`**: once `W̊` is diagonal in the basis of `S²` at `wK` (as
`L52_eq_S20` concludes at equality), its pair–pair block stays diagonal and every pair–`ψ` entry `⟨W̊ φ_p, diag v⟩`
vanishes for every vector `v`. With the `ψ`–`ψ` block `diag(−κ)` at any orthonormal eigenfamily `v` of `K`, which
`psi_block` gives with no equality, `W̊` is diagonal in `{φ_ab} ∪ {diag v_k}`, the record's basis of `S²₀` when the `v_k`
span `𝟏^⊥`. -/
theorem S20_basis_diag (hW : ∀ u v, u ≠ v → Bw (wK R hR hskew hsym) (ringW R) u v = 0) :
    (∀ p q : Pairs n, p ≠ q → Bw (wK R hR hskew hsym) (ringW R) (Sum.inl p) (Sum.inl q) = 0) ∧
    (∀ (p : Pairs n) (v : Fin n → ℝ), frob (ringW R ((Real.sqrt 2) • symB p.1.1 p.1.2)) (Matrix.diagonal v) = 0) ∧
    (∀ {m : Type*} [DecidableEq m] (v : m → Fin n → ℝ) (κ : m → ℝ), (∀ k, Kmat R *ᵥ v k = κ k • v k) →
      (∀ j k, v j ⬝ᵥ v k = if j = k then 1 else 0) → ∀ j k, j ≠ k →
        frob (ringW R (Matrix.diagonal (v j))) (Matrix.diagonal (v k)) = 0) := by
  refine ⟨fun p q hpq => hW _ _ (fun e => hpq (Sum.inl_injective e)), fun p v => ?_,
    fun v κ heig horth j k hjk => ?_⟩
  · set X := ringW R ((Real.sqrt 2) • symB p.1.1 p.1.2)
    have hk : ∀ k, ∑ a, X a a * wK R hR hskew hsym k a = 0 := fun k => by
      rw [← frob_diag_left]
      exact hW (Sum.inl p) (Sum.inr k) (fun e => by cases e)
    have hd := diag_zero_of_complete X _ (wK_complete R hR hskew hsym) hk
    rw [frob_diag_left]
    exact Finset.sum_eq_zero fun a _ => by rw [hd a, zero_mul]
  · rw [psi_block R hR hskew hsym v κ heig horth j k, if_neg hjk]

end HamiltonsCubic.SecondKind
