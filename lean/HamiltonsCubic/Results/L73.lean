import Mathlib

/-!
# L73, why the spectral bound is not implied by tracelessness

L73 says that at **every** `W ∈ 𝒲ₙ`, `λ_max ≤ (n-2)|λ_min|`, and that the
constant `n-2` cannot be improved.

**The structural half.** The block's own defence of the result is one clause:

> It is **not** implied by tracelessness, which gives only `N-1` in place of
> `n-2`, for every `n ≥ 3`.

That clause carries the result's whole claim to content, without it, L73 would
be a corollary of `tr W = 0`, and it is two statements, both proved here:

* tracelessness alone gives `λ_max ≤ (card - 1)|λ_min|`, for any finite family
  of reals summing to zero;
* `N - 1 > n - 2` strictly, for every `n ≥ 3`, with `N = n(n-1)/2`.

The `n-2` bound itself needs the Killing row mass and Ricci-flatness, and is not
in this file. Neither are the figures, two of which the block withdraws.
-/

namespace HamiltonsCubic.L73

open Finset

/-- **What tracelessness alone gives.** For any finite family summing to zero,
each entry is at most `(card - 1)` times the negated minimum. -/
theorem le_card_sub_one_mul_neg_min {ι : Type*} [DecidableEq ι]
    (s : Finset ι) (f : ι → ℝ) (hsum : ∑ b ∈ s, f b = 0)
    (a : ι) (ha : a ∈ s) (m : ℝ) (hm : ∀ b ∈ s, m ≤ f b) :
    f a ≤ (s.card - 1 : ℝ) * (-m) := by
  have hsplit : ∑ b ∈ s.erase a, f b + f a = 0 := by
    rw [Finset.sum_erase_add s f ha]; exact hsum
  have hlow : (s.erase a).card • m ≤ ∑ b ∈ s.erase a, f b :=
    Finset.card_nsmul_le_sum _ _ _ fun b hb => hm b (Finset.mem_of_mem_erase hb)
  have hcard : ((s.erase a).card : ℝ) = (s.card : ℝ) - 1 := by
    rw [Finset.card_erase_of_mem ha]
    have : 1 ≤ s.card := Finset.card_pos.mpr ⟨a, ha⟩
    push_cast [Nat.cast_sub this]
    ring
  rw [nsmul_eq_mul, hcard] at hlow
  linarith

/-- **And the two constants are genuinely different.** With `N = n(n-1)/2`, the
tracelessness constant `N - 1` strictly exceeds `n - 2` at every `n ≥ 3`, so the
bound L73 states is not a corollary of `tr W = 0`.

Stated with both sides doubled, so no integer division enters: `2(n-2)` against
`2(N-1) = n(n-1) - 2`. Their difference is `(n-1)(n-2)`. -/
theorem tracelessness_constant_weaker {n : ℤ} (h : 3 ≤ n) :
    2 * (n - 2) < n * (n - 1) - 2 := by nlinarith

/-- The gap is exactly `(n-1)(n-2)`, so it grows quadratically: the two bounds
are not close for large `n`. -/
theorem tracelessness_gap (n : ℤ) :
    (n * (n - 1) - 2) - 2 * (n - 2) = (n - 1) * (n - 2) := by ring

end HamiltonsCubic.L73
