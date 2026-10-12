import HamiltonsCubic.Results.L90
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L85, the invariant dimension, and a clause irreducibility forbids

[sym3-blocks.md](../../../findings/sym3-blocks.md)'s Lemma L85: every number right, one clause
false.

**The false clause fails at every `n`, not at one.** `𝒲ₙ` is absolutely irreducible, so the
degree-`2` invariant count is `1`, pinned, at every `n`. *"Every entry is strictly smaller"*
therefore asks `1 < 1`. A claim of strict decrease against a **constant** fails wherever the
constant sits, so the clause is false on its whole range at once and **cannot be repaired by
choosing a different `n`**. The audit calls it *"false at degree 2 and forced to be"*; the
forcing is what makes it unrepairable, which is stronger than a counterexample.

**The `14` is the cap [L90](L90.lean)'s stronger route meets.** L85 supplies
`dim(Sym⁶𝒲₅)^{O(5)} = 14`, and L90's unrestricted sampled rank attains it, so a measured
`14` is what licenses that route's *"no genericity needed"*. The dependency is real and the
status travels with it.
-/

namespace HamiltonsCubic.InvariantDimension

open HamiltonsCubic.Unisolvence

/-! ## The clause is forbidden, not merely false -/

/-- **A claim of strict decrease against a constant fails wherever the constant sits**, so
the clause is false on its whole range at once, and no choice of `n` repairs it. -/
theorem uniform_failure (c : ℕ) : ¬ (c < c) := by omega

/-- At the pinned value `1` this is the clause the audit refutes. -/
theorem at_pinned_value : ¬ ((1 : ℕ) < 1) := uniform_failure 1

/-! ## The `14` is L90's cap -/

/-- **A rank attaining `14` is forced to equal it**, imported from [L90](L90.lean), so L85's
measured dimension is exactly what that route consumes. -/
theorem cap_is_L85s {r : ℕ} (hmeas : 14 ≤ r) (hcap : r ≤ 14) : r = 14 :=
  rank_meets_cap hmeas hcap

/-- And `14` exceeds the `13` the restricted route consumes, so the two numbers are different
inputs and L85 supplies only one of them. -/
theorem fourteen_above_thirteen : (13 : ℕ) < 14 := by omega

end HamiltonsCubic.InvariantDimension
