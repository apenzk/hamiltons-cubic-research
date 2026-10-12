import Mathlib
import HamiltonsCubic.Results.L240NormalForm

/-!
# L237, the Ky Fan bracket cap: the reduction to slot sets

[findings/second-order.md](../../../findings/second-order.md), Lemma L237: for a unit `X₀` and
orthonormal `X₁,…,X_r` in `𝔰𝔬(n)`, `∑ⱼ ‖[X₀, Xⱼ]‖² ≤ κ_r`, the largest sum of `r` top eigenvalues
of `-ad_X²`, with `κ₆ = 8`.

**Phase 1 split.** The structural half is that Ky Fan's dual form, minimised over `c`, is the sum of
the top `r` values, so the cap needs only a bound on every set of at most `r` slot eigenvalues
(`exists_c_topSum`, `rowSum_le_of_slotSets`). The combinatorial half, that any six slots of a unit
normal form sum to at most `8` (slots paired into types of multiplicity two, three types sent to the
nineteen `slot3_*` configurations of [KyFanBracketCap.lean](KyFanBracketCap.lean) in the first
proof), is `slot_set_bound` in [L237SlotCounts.lean](L237SlotCounts.lean), by the uniform proof
`κ_r ≤ r + 2`, and the cap itself is `kappa_cap` and `kappa_cap_norm` there.
-/

open HamiltonsCubic.RealLayer Matrix

namespace HamiltonsCubic.L237Cap

/-- **The dual form reaches the top-`r` sum**: if every set of at most `r` values sums to at most
`B`, some `c` has `r c + ∑ₖ max(μₖ - c, 0) ≤ B`. -/
theorem exists_c_topSum {K : Type*} [Fintype K] [DecidableEq K] (μ : K → ℝ) {r : ℕ} (hr : 0 < r)
    (B : ℝ) (h : ∀ S : Finset K, S.card ≤ r → ∑ k ∈ S, μ k ≤ B) :
    ∃ c : ℝ, r * c + ∑ k, max (μ k - c) 0 ≤ B := by
  by_cases hK : Fintype.card K ≤ r
  · refine ⟨0, ?_⟩
    have e : ∑ k, max (μ k - 0) 0 = ∑ k ∈ Finset.univ.filter (fun k => 0 < μ k), μ k := by
      rw [Finset.sum_filter]
      refine Finset.sum_congr rfl fun k _ => ?_
      split_ifs with hk
      · rw [sub_zero, max_eq_left hk.le]
      · rw [sub_zero, max_eq_right (not_lt.mp hk)]
    rw [e, mul_zero, zero_add]
    apply h
    exact (Finset.card_filter_le _ _).trans (by simpa using hK)
  · push Not at hK
    have hne : (Finset.univ.powersetCard r : Finset (Finset K)).Nonempty :=
      Finset.powersetCard_nonempty.mpr (by simpa using hK.le)
    obtain ⟨S, hS, hmax⟩ := Finset.exists_max_image _ (fun S => ∑ k ∈ S, μ k) hne
    have hScard : S.card = r := (Finset.mem_powersetCard.mp hS).2
    have hSne : S.Nonempty := Finset.card_pos.mp (hScard ▸ hr)
    set c := S.inf' hSne μ with hc
    have hin : ∀ k ∈ S, c ≤ μ k := fun k hk => Finset.inf'_le _ hk
    have hout : ∀ k ∉ S, μ k ≤ c := by
      intro k hk
      by_contra hlt; push Not at hlt
      obtain ⟨m, hm, hmc⟩ := Finset.exists_mem_eq_inf' hSne μ
      have hmk : m ≠ k := fun e => hk (e ▸ hm)
      set S' := insert k (S.erase m)
      have hkS' : k ∉ S.erase m := fun h' => hk (Finset.mem_of_mem_erase h')
      have hS'card : S'.card = r := by
        rw [Finset.card_insert_of_notMem hkS', Finset.card_erase_of_mem hm, hScard]
        omega
      have hS' : S' ∈ Finset.univ.powersetCard r :=
        Finset.mem_powersetCard.mpr ⟨Finset.subset_univ _, hS'card⟩
      have hsum : ∑ k' ∈ S', μ k' = ∑ k' ∈ S, μ k' - μ m + μ k := by
        rw [Finset.sum_insert hkS', ← Finset.add_sum_erase S μ hm]; ring
      have := hmax S' hS'
      rw [hsum, ← hmc, ← hc] at this
      linarith
    refine ⟨c, ?_⟩
    have split : ∑ k, max (μ k - c) 0 = ∑ k ∈ S, (μ k - c) := by
      rw [← Finset.sum_add_sum_compl S]
      have h0 : ∑ k ∈ Sᶜ, max (μ k - c) 0 = 0 :=
        Finset.sum_eq_zero fun k hk =>
          max_eq_right (by linarith [hout k (Finset.mem_compl.mp hk)])
      rw [h0, add_zero]
      exact Finset.sum_congr rfl fun k hk => max_eq_left (by linarith [hin k hk])
    rw [split, Finset.sum_sub_distrib, Finset.sum_const, hScard, nsmul_eq_mul]
    have := h S hScard.le
    linarith

variable {ι : Type*} [Fintype ι] [DecidableEq ι] [LinearOrder ι]

/-- **The cap from slot sets**: at a skew `X` orthogonally conjugate to `N.X`, a bound on every set of
at most `r` slot eigenvalues bounds the Rayleigh sum of any `r` orthonormal skew matrices. -/
theorem rowSum_le_of_slotSets {k : ℕ} (N : L240SlotBasis.NormalForm ι k) {O X : Matrix ι ι ℝ}
    (hO : O * Oᵀ = 1) (hO' : Oᵀ * O = 1) (hX : X = O * N.X * Oᵀ) {r : ℕ} (hr : 0 < r) (B : ℝ)
    (h : ∀ S : Finset {x : ι × ι // x.1 < x.2}, S.card ≤ r →
      ∑ ij ∈ S, L240SlotBasis.slotμ N ij ≤ B)
    (y : Fin r → Matrix ι ι ℝ) (hyS : ∀ j, IsSkew (y j))
    (hy : ∀ i j, inner2 (y i) (y j) = if i = j then 1 else 0) :
    ∑ j, inner2 (y j) (-br X (br X (y j))) ≤ B := by
  obtain ⟨c, hc⟩ := exists_c_topSum (L240SlotBasis.slotμ N) hr B h
  exact (L240NormalForm.kyFan_conj N hO hO' hX y hyS hy c).trans hc

/-- **The per-vector bracket cap, at every skew `x`**: for orthonormal skew `ψ₁,…,ψ_r`,
`∑ ‖[x, ψ_γ]‖² ≤ r c + ∑ₖ max(μₖ - c, 0)` over the slot eigenvalues of `x`'s normal form, for every
`c`. This is the Ky Fan cap that [L244](L244SymmetricPerVector.lean) takes as a hypothesis, in its
bracket form, before the eigenspace objects `B_ab` (which the layer does not define) enter. -/
theorem bracket_cap (x : Matrix ι ι ℝ) (hx : IsSkew x) :
    ∃ (k : ℕ) (N : L240SlotBasis.NormalForm ι k) (O : Matrix ι ι ℝ),
      O * Oᵀ = 1 ∧ Oᵀ * O = 1 ∧ x = O * N.X * Oᵀ ∧
      ∀ {r : ℕ} (ψ : Fin r → Matrix ι ι ℝ),
      (∀ γ, IsSkew (ψ γ)) → (∀ i j, inner2 (ψ i) (ψ j) = if i = j then 1 else 0) → ∀ c : ℝ,
      ∑ γ, inner2 (br x (ψ γ)) (br x (ψ γ)) ≤ r * c + ∑ ij, max (L240SlotBasis.slotμ N ij - c) 0 := by
  obtain ⟨k, N, O, hO, hO', hxO, hN⟩ := L240NormalForm.kyFan_skew x hx
  refine ⟨k, N, O, hO, hO', hxO, fun ψ hψS hψ c => ?_⟩
  have e : ∀ γ, inner2 (br x (ψ γ)) (br x (ψ γ)) = inner2 (ψ γ) (-br x (br x (ψ γ))) :=
    fun γ => (KyFanPackaging.inner2_negAdSq x (ψ γ) hx).symm
  simp only [e]
  exact hN ψ hψS hψ c

end HamiltonsCubic.L237Cap
