import HamiltonsCubic.Results.L127DnTwo
import HamiltonsCubic.Results.L127DnCount

set_option linter.style.longLine false

/-!
# L127's `𝒟ₙ` count at `p = 2`

[findings/second-order.md](../../../findings/second-order.md), Lemma L127's table, `𝒟ₙ` row. At `p = 2`,
[L127DnTwo.lean](L127DnTwo.lean) declares the eigenspaces of `M ∘` on `𝒟ₙ`. This file adds their dimensions up:

* **`dn_dim_sum_two`**: `1 + (q − 1) + (q − 1) + (binom q 2 − q) = binom (q + 2) 2 − (q + 2)` at `q ≥ 3`;
* **`dn_finrank_sum_two`**: at `p = 2`, `q ≥ 3`, `t ≠ 0` the `θ`-, `θ(−μ)`-, `θ λ_q`- and `0`-eigenspaces' dimensions sum to
  `dim 𝒟ₙ` (L120DiagDim's `finrank_weights`);
* **`dn_finrank_sum_two_two`**: at `p = q = 2`, `t ≠ 0` the `θ`- and `θ(−μ)`-eigenspaces' dimensions sum to `dim 𝒟₄ = 2`.

* **`dn_finrank_sum_two'`**: the mirror at `q = 2`, `p ≥ 3`, through [L127DnTwo.lean](L127DnTwo.lean)'s primed theorems;
* **`weightsMap`**, **`dnWeights_eq_range`**, **`finrank_dnWeights`**: `dnWeights` has the dimension of
  `ker rowSumL`, so each sum above is `dim 𝒟ₙ` for the subspace the eigenspaces are cut from.
-/

namespace HamiltonsCubic.Results

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem dn_dim_sum_two {q : ℕ} (hq : 3 ≤ q) :
    1 + (q - 1) + (q - 1) + (q.choose 2 - q) = (q + 2).choose 2 - (q + 2) := by
  have hQ := two_mul_choose_two_sub hq
  have hN := two_mul_choose_two_sub (show 3 ≤ q + 2 by omega)
  obtain ⟨b, rfl⟩ : ∃ b, q = b + 3 := ⟨q - 3, by omega⟩
  rw [show b + 3 - 3 = b by omega] at hQ
  rw [show b + 3 + 2 - 3 = b + 2 by omega] at hN
  rw [show b + 3 - 1 = b + 2 by omega]
  apply Nat.eq_of_mul_eq_mul_left (show 0 < 2 by norm_num)
  rw [hN, mul_add, mul_add, mul_add, hQ]
  ring

/-- **At `p = 2`, `q ≥ 3` the eigenspace dimensions sum to `dim 𝒟ₙ`.** -/
theorem dn_finrank_sum_two (T : Finset ι) (hp : T.card = 2) (hq : 3 ≤ Tᶜ.card) (t : ℝ) (ht : t ≠ 0) :
    Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * 1))
      + Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnMu T))
      + Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnLq T))
      + Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace 0)
      = Module.finrank ℝ (LinearMap.ker (rowSumL (ι := ι))) := by
  have hn : T.card + Tᶜ.card = Fintype.card ι := by rw [Finset.card_add_card_compl]
  rw [finrank_eig_line_two T hp (by omega) t ht, finrank_eig_cross_two T hp (by omega) t ht,
    finrank_eig_lamq_two T hp (by omega) t ht hq, finrank_eig_zero_two T hp (by omega) t ht,
    finrank_weights (by omega), ← hn, hp, add_comm 2, dn_dim_sum_two hq]

/-- **At `q = 2`, `p ≥ 3` the eigenspace dimensions sum to `dim 𝒟ₙ`**, the mirror of `dn_finrank_sum_two`. -/
theorem dn_finrank_sum_two' (T : Finset ι) (hq : Tᶜ.card = 2) (hp : 3 ≤ T.card) (t : ℝ) (ht : t ≠ 0) :
    Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * 1))
      + Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnMu T))
      + Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnLp T))
      + Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace 0)
      = Module.finrank ℝ (LinearMap.ker (rowSumL (ι := ι))) := by
  have hn : T.card + Tᶜ.card = Fintype.card ι := by rw [Finset.card_add_card_compl]
  rw [finrank_eig_line_two' T hq (by omega) t ht, finrank_eig_cross_two' T hq (by omega) t ht,
    finrank_eig_lamp_two' T hq (by omega) t ht hp, finrank_eig_zero_two' T hq (by omega) t ht,
    finrank_weights (by omega), ← hn, hq, dn_dim_sum_two hp]

/-- **At `p = q = 2` the line and the cross family fill `𝒟₄`.** -/
theorem dn_finrank_sum_two_two (T : Finset ι) (hp : T.card = 2) (hq : Tᶜ.card = 2) (t : ℝ) (ht : t ≠ 0) :
    Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * 1))
      + Module.finrank ℝ ↥(dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnMu T))
      = Module.finrank ℝ (LinearMap.ker (rowSumL (ι := ι))) := by
  have hn : T.card + Tᶜ.card = Fintype.card ι := by rw [Finset.card_add_card_compl]
  rw [finrank_eig_line_two T hp (by omega) t ht, finrank_eig_cross_two T hp (by omega) t ht,
    finrank_weights (by omega), ← hn, hp, hq]
  rfl

/-! ## `𝒟ₙ` as a subspace has the weights' dimension -/

/-- The weights of L120DiagDim, as matrices. -/
def weightsMap : LinearMap.ker (rowSumL (ι := ι)) →ₗ[ℝ] Matrix ι ι ℝ :=
  (symHollow ι).subtype ∘ₗ (LinearMap.ker (rowSumL (ι := ι))).subtype

theorem dnWeights_eq_range : dnWeights ι = LinearMap.range (weightsMap (ι := ι)) := by
  ext u
  constructor
  · intro hu
    have hs : u ∈ symHollow ι := ⟨hu.symm, hu.hollow⟩
    refine ⟨⟨⟨u, hs⟩, ?_⟩, rfl⟩
    rw [LinearMap.mem_ker]; funext a; exact hu.rowSum a
  · rintro ⟨w, rfl⟩
    exact isWeight_of_ker w

/-- **`𝒟ₙ` as a subspace of matrices has the dimension of L120DiagDim's weights.** -/
theorem finrank_dnWeights : Module.finrank ℝ (dnWeights ι) = Module.finrank ℝ (LinearMap.ker (rowSumL (ι := ι))) := by
  rw [dnWeights_eq_range, LinearMap.finrank_range_of_inj (f := weightsMap)
    (Subtype.val_injective.comp Subtype.val_injective)]

end HamiltonsCubic.Results
