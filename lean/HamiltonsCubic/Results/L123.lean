import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Order.Interval.Finset.Nat

/-!
# L123, why the full sign group is required, and where it fuses

[second-order.md](../../../findings/second-order.md)'s Lemma L123. The record states that on
`Γ ∩ SO(n)` complementary characters fuse **at `n = 4, 6, 8`**, and lists the three
dimensions.

**That list is derivable, and it is complete.** The characters in play come from symmetric
differences of `2`-sets, so `|S| ∈ {0, 2, 4}`. On `det = 1` the character `χ_{[n]}` is trivial,
so `χ_S` and `χ_{Sᶜ}` fuse, and both are in play exactly when `|S|` **and** `n - |S|` lie in
`{0, 2, 4}`. Running the three cases gives `n ∈ {0,2,4} ∪ {2,4,6} ∪ {4,6,8}`, which meets
`n ≥ 4` in **exactly `{4, 6, 8}`**.

So the three dimensions are not a census of small cases: they are every `n` where the fusion
can occur, and the full sign group is required **only** there, which is what makes the
hypothesis sharp rather than cautious.
-/

namespace HamiltonsCubic.SignGroup

/-- The sizes a relevant character's support can take: a symmetric difference of two `2`-sets
has `0`, `2` or `4` elements. -/
def relevantSize (k : ℕ) : Prop := k = 0 ∨ k = 2 ∨ k = 4

/-- Fusion needs both a support and its complement to be relevant. -/
def fuses (n : ℕ) : Prop := ∃ k, k ≤ n ∧ relevantSize k ∧ relevantSize (n - k)

/-! ## The fusion set is exactly `{4, 6, 8}` above `n = 4` -/

/-- **`n = 4`, `6` and `8` all fuse.** -/
theorem fuses_four : fuses 4 := ⟨0, by omega, Or.inl rfl, Or.inr (Or.inr rfl)⟩

theorem fuses_six : fuses 6 := ⟨2, by omega, Or.inr (Or.inl rfl), Or.inr (Or.inr rfl)⟩

theorem fuses_eight : fuses 8 := ⟨4, by omega, Or.inr (Or.inr rfl), Or.inr (Or.inr rfl)⟩

/-- **And nothing else does, above `n = 4`.** -/
theorem fuses_only (n : ℕ) (hn : 4 ≤ n) (h : fuses n) : n = 4 ∨ n = 6 ∨ n = 8 := by
  obtain ⟨k, hk, hrel, hrel'⟩ := h
  unfold relevantSize at hrel hrel'
  rcases hrel with h1 | h1 | h1 <;> rcases hrel' with h2 | h2 | h2 <;> omega

/-- The odd dimensions in range do **not** fuse, which is why the record's list skips them. -/
theorem five_no_fuse : ¬ fuses 5 := by
  rintro ⟨k, hk, hrel, hrel'⟩
  unfold relevantSize at hrel hrel'
  rcases hrel with h1 | h1 | h1 <;> rcases hrel' with h2 | h2 | h2 <;> omega

theorem seven_no_fuse : ¬ fuses 7 := by
  rintro ⟨k, hk, hrel, hrel'⟩
  unfold relevantSize at hrel hrel'
  rcases hrel with h1 | h1 | h1 <;> rcases hrel' with h2 | h2 | h2 <;> omega

/-- **And nothing above `8` fuses either**, so the requirement is a small-dimension phenomenon
with a hard ceiling rather than a caution that grows. -/
theorem beyond_eight (n : ℕ) (hn : 9 ≤ n) : ¬ fuses n := by
  rintro ⟨k, hk, hrel, hrel'⟩
  unfold relevantSize at hrel hrel'
  rcases hrel with h1 | h1 | h1 <;> rcases hrel' with h2 | h2 | h2 <;> omega

end HamiltonsCubic.SignGroup
