import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L64 / post F32, the transfer mechanism, and what `k_B ≥ 24` is a fact about

[fence-posts.md](../../../findings/fence-posts.md)'s post F32 and the lemma built on it. The
representation theory stays imported; the counting is here, and it is where the audit's
correction bites.

**The two counts concern different objects.** `k_B(6) ≥ 4·6 = 24` comes from a module
element: six Weyl blocks on disjoint `4`-subsets, a product of degree `6` and support `24` that
witnesses the generation degree and is not `B_n`-invariant. The sign subgroup of `B_n` forces
every coordinate index of a `B_n`-**invariant** to even multiplicity, so an invariant of degree
`d` has support at most `2d`, which at `d = 6` is `12`. The theorems below are that arithmetic.

**Transfer moves an element, never an inequality.** The mechanism says a `B_n`-invariant
extension of an `O(n₀)`-invariant is `O(n)`-invariant, a predicate carried along a map. That
a predicate transfers does not make an order relation transfer. `transfer_not_order` below is
the abstract shape of that gap, and the instance with a certified form lifting to a negative
value is in the lemma's block.
-/

namespace HamiltonsCubic.Transfer

/-! ## The generation-degree arithmetic -/

/-- Generation degree `4` for `{𝒲ₙ}` gives `4ℓ` for `Symˡ`, so the degree-`6` certificate
reads `4·6 = 24`. -/
theorem generation_degree : 4 * 6 = 24 := by decide

/-- And `24 > 12`, which is what the headline uses. -/
theorem exceeds_twelve : 12 < 24 := by decide

/-- Six Weyl blocks on disjoint `4`-subsets carry support `24`. -/
theorem six_blocks_support : 6 * 4 = 24 := by decide

/-! ## The even-multiplicity cap, and the tension -/

/-- **The sign subgroup caps support at `2d`.** At degree `6` that is `12`. -/
theorem support_cap_at_six : 2 * 6 = 12 := by decide

/-- **At degree `6` the invariant cap `12` lies below the six-block element's support `24`.** -/
theorem counts_disagree : 2 * 6 < 6 * 4 := by decide

/-- **A `B_n`-invariant of support `24` has degree at least `12`**, support at most `2d` giving
`2d ≥ 24`. The six-block element has degree `6` and is not `B_n`-invariant, so this bound
concerns invariants alone. -/
theorem support_forces_degree (d : ℕ) (h : 24 ≤ 2 * d) : 12 ≤ d := by omega

/-- The two supports differ by a factor of two. -/
theorem overstatement_factor : 24 = 2 * 12 := by decide

/-! ## `k_B` grows with `d`, so a bare `k_B` names nothing -/

/-- A quantity indexed by `d` and strictly increasing in it has no single value, so a
statement quantifying over *"the* presentation degree`"` needs the index. This is that, with
nothing else in it. -/
theorem indexed_not_scalar (k : ℕ → ℕ) (hmono : ∀ d, k d < k (d + 1)) (d : ℕ) :
    k d ≠ k (d + 1) := by
  have := hmono d
  omega

/-- **A strictly increasing family is unbounded**: for every `N` some degree exceeds it, so one
bound on `n₀` meets the hypothesis at finitely many degrees at most. Strict increase of `k_B`
in `d` is an assumption here, and the record proves only `k_B(d) ≥ 4d`. -/
theorem unbounded (k : ℕ → ℕ) (hmono : ∀ d, k d < k (d + 1)) : ∀ N, ∃ d, N < k d := by
  intro N
  have h : ∀ d, d ≤ k d := by
    intro d
    induction d with
    | zero => exact Nat.zero_le _
    | succ n ih => have := hmono n; omega
  exact ⟨N + 1, by have := h (N + 1); omega⟩

/-! ## Transfer moves an element, never an inequality -/

/-- **A map carrying a predicate need not carry an order relation.** Negation preserves
*"is a rational"* and reverses every inequality, so predicate transfer gives no inequality
transfer, which is why the mechanism transfers an element and never a bound. -/
theorem transfer_not_order :
    ∃ (T : ℚ → ℚ) (P : ℚ → Prop), (∀ x, P x → P (T x)) ∧ ∃ x, 0 ≤ x ∧ ¬ (0 ≤ T x) := by
  refine ⟨fun x => -x, fun _ => True, fun _ _ => trivial, 1, by norm_num, by norm_num⟩

/-- Step 1 being unconditional means the conditional statement is weaker than what holds:
`P → Q` where `Q` holds outright advertises a hypothesis that buys nothing. -/
theorem conditional_of_free {P Q : Prop} (hQ : Q) : P → Q := fun _ => hQ

end HamiltonsCubic.Transfer
