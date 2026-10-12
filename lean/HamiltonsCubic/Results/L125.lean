import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L125, a restatement, not a strengthening

[second-order.md](../../../findings/second-order.md)'s Lemma L125: `L_e ≤ ½(Id + W⊗W)` with
equality along `W`, confirmed and **restated rather than strengthened**.

**The collapse is one cancellation.** `L_e` is self-adjoint with `L_e W = W`, so splitting
`Y = aW + Z` with `Z ⊥ W` and `‖W‖ = 1` gives

* left side `⟨L_e Y, Y⟩ = a² + ⟨L_e Z, Z⟩`,
* right side `⟨½(Id + W⊗W)Y, Y⟩ = a² + ½‖Z‖²`.

The `a²` is **the same term on both sides**, so the inequality holds iff
`⟨L_e Z, Z⟩ ≤ ½‖Z‖²`, which is [L24](../../../findings/second-order.md) on `W^⊥`. Nothing is
gained in either direction, and the equivalence is `collapse` below: `a² + s ≤ a² + t ↔ s ≤ t`.

**Equality along `W` is the `Z = 0` case**, where both sides are `a²`, so the equality clause
is where the collapse leaves nothing rather than a separate rigidity.
-/

namespace HamiltonsCubic.Restatement

/-! ## The collapse -/

/-- **The `a²` cancels, in both directions.** So `L_e ≤ ½(Id + W⊗W)` and L24's bound on
`W^⊥` are the same statement. -/
theorem collapse (a s t : ℚ) : a ^ 2 + s ≤ a ^ 2 + t ↔ s ≤ t := by
  constructor <;> intro h <;> linarith

/-- **The two sides differ by exactly `½‖Z‖² - ⟨L_e Z, Z⟩`**, so the slack lives entirely on
`W^⊥`, and equality along `W` is the `Z = 0` case, where the difference is zero. -/
theorem slack_on_perp (a s t : ℚ) : (a ^ 2 + t) - (a ^ 2 + s) = t - s := by ring

/-! ## What a restatement cannot do -/

/-- **An equivalence transmits no extra reach**: anything the restated form proves, the
original proves. So *"strengthening"* was the wrong word, and the withdrawal the block carries
is the right one. -/
theorem no_extra_reach {P Q R : Prop} (h : P ↔ Q) (hQR : Q → R) : P → R :=
  fun hp => hQR (h.1 hp)

end HamiltonsCubic.Restatement
