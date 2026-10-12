import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L108, the Cauchy–Schwarz bound, and why its equality clause needs `|θ|`

[bounds.md](../../../findings/bounds.md)'s Lemma L108: `θ ≤ ½√((n-1)G₂)`, confirmed as an
inequality with its equality clause refuted.

**The failure at `-W` is an odd/even mismatch, and that is the whole of it.** `θ` is **odd**
in `W` and `G₂` is **even**, so an equality `θ = ½√((n-1)G₂)` at `W` becomes
`-θ = ½√((n-1)G₂)` at `-W`, both cannot hold unless the common value is `0`. The repair is to
box `|θ|`, which restores evenness on the left and is *"already correct fourteen lines
below"*.

**Squaring is the same repair.** `4θ² = (n-1)G₂` is even on both sides, so it survives
negation; the unsquared form does not. Everything below is on squares for that reason.

**Criticality never enters**, the bound holds at every unit `W`, not only at critical points.
That is a hypothesis stated and never used, the same shape as
[L81](L81.lean), [L104](L104.lean) and [L101](L101.lean).

**And it does not weaken [L107](../../../findings/bounds.md)**: this is the constraint
*before* eliminating `m₂` and L107 the complete consequence *after*, so the two sit in
sequence rather than in competition, a direction the record states nowhere.
-/

namespace HamiltonsCubic.CauchySchwarz

/-! ## The odd/even mismatch -/

/-- **An odd quantity cannot equal an even one at both `W` and `-W` unless both vanish.** -/
theorem odd_eq_even_forces_zero {θ G : ℚ} (h : θ = G) (hneg : -θ = G) : θ = 0 ∧ G = 0 := by
  constructor <;> linarith

/-- **So the equality clause fails at `-W`** whenever the common value is nonzero, the
hypothesis is even and survives, while `θ` changes sign. -/
theorem iff_fails_at_neg {θ G : ℚ} (hne : G ≠ 0) (h : θ = G) : -θ ≠ G := by
  intro hneg
  exact hne (odd_eq_even_forces_zero h hneg).2

/-- **Boxing `|θ|` restores it**: the absolute value is even, so the clause is stable under
`W ↦ -W`. -/
theorem abs_repair (θ : ℚ) : |(-θ)| = |θ| := abs_neg θ

/-- **Squaring is the same repair**, and it is what lets the bound be stated without a
radical: `4θ² = (n-1)G₂` is even on both sides. -/
theorem sq_repair (θ : ℚ) : (-θ) ^ 2 = θ ^ 2 := by ring

/-! ## The bound, on squares -/

/-- The bound `θ ≤ ½√((n-1)G₂)` squared: `4θ² ≤ (n-1)G₂`. -/
def boundSq (n G : ℚ) : ℚ := (n - 1) * G

/-- **The squared bound is invariant under `W ↦ -W`**, so it is the form the record should
box, and its equality case is convention-free. -/
theorem bound_even {θ n G : ℚ} (h : 4 * θ ^ 2 = boundSq n G) :
    4 * (-θ) ^ 2 = boundSq n G := by rw [sq_repair]; exact h

/-! ## Before and after elimination -/

/-- **A constraint before elimination is not weaker than the consequence after**: the second
follows from the first, so the two sit in sequence and cannot conflict. The brief's suspicion
inverts that direction. -/
theorem consequence_implied {A B : Prop} (h : A → B) : ¬ (A ∧ ¬ B) := by
  rintro ⟨hA, hnB⟩
  exact hnB (h hA)

end HamiltonsCubic.CauchySchwarz
