import HamiltonsCubic.Base.WeylReal

/-!
# A vanishing weighted sum splits into two equal signed halves

**What this is for.** [L197](../../../findings/target.md) reads `ker W ⊆ ker W^#` in the record's
own notation as `∑_{α,β} λ_α λ_β T_{αβγ} = 0` at every kernel index `γ`, with `T` nonnegative and
totally symmetric. *Under one sign of the weight products that display would be a positive sum
forced to vanish, which is Hamilton's conclusion; trace-freeness forbids one sign.*

**What remains is a BALANCE**, and this file carries it: the terms with positive weight product and
those with negative weight product carry equal total mass. *In the record's `𝔭 = ran W₊`,
`𝔪 = ran W₋` vocabulary that is the `𝔭𝔭` and `𝔪𝔪` brackets balancing the `𝔭𝔪` ones.*

**WHAT IT DOES NOT COVER**: that the display holds, which is [L197](../../../findings/target.md)'s
and needs the eigenbasis expansion of Wilking's trace form; nor `T`'s nonnegativity, which is not
used here; nor anything about rank.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.RealLayer

open Finset

/-- **A vanishing weighted sum balances its two signed halves.**

*`w` stands for the weight product `λ_α λ_β` and `T` for the nonnegative coefficient, both indexed
by one type standing for the pair.* Terms of zero weight drop out, so the positive and negative
halves carry equal mass. -/
theorem sign_balance_of_sum_zero {ι : Type*} [Fintype ι] [DecidableEq ι]
    (w T : ι → ℝ) (h : ∑ p, w p * T p = 0) :
    ∑ p ∈ Finset.univ.filter (fun p => 0 < w p), w p * T p
      = ∑ p ∈ Finset.univ.filter (fun p => w p < 0), (-(w p)) * T p := by
  classical
  have hsplit : ∑ p, w p * T p
      = (∑ p ∈ Finset.univ.filter (fun p => 0 < w p), w p * T p)
        + ∑ p ∈ Finset.univ.filter (fun p => ¬ 0 < w p), w p * T p :=
    (Finset.sum_filter_add_sum_filter_not _ _ _).symm
  have hneg : ∑ p ∈ Finset.univ.filter (fun p => w p < 0), w p * T p
      = ∑ p ∈ Finset.univ.filter (fun p => ¬ 0 < w p), w p * T p := by
    refine Finset.sum_subset (fun p hp => ?_) (fun p hp hnp => ?_)
    · rw [Finset.mem_filter] at hp ⊢
      exact ⟨hp.1, not_lt.mpr (le_of_lt hp.2)⟩
    · rw [Finset.mem_filter] at hp hnp
      have h1 : w p ≤ 0 := not_lt.mp hp.2
      have h2 : ¬ w p < 0 := fun hlt => hnp ⟨Finset.mem_univ p, hlt⟩
      have : w p = 0 := le_antisymm h1 (not_lt.mp h2)
      rw [this, zero_mul]
  have hz := hsplit.symm.trans h
  rw [← hneg] at hz
  have hnegsum : ∑ p ∈ Finset.univ.filter (fun p => w p < 0), (-(w p)) * T p
      = -∑ p ∈ Finset.univ.filter (fun p => w p < 0), w p * T p := by
    rw [← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun p _ => by ring
  rw [hnegsum]
  linarith [hz]

end HamiltonsCubic.RealLayer
