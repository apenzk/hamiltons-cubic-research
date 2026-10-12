import Mathlib.Data.Rat.Defs
import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

/-!
# L19b, the four rigidity lists are not four claims about one object

A correction to [L19](L19.lean), which computed the intersection of
[problem.md](../../../findings/problem.md)'s four rigidity dimension lists on the audit's
framing that they disagree. **They do not disagree, and three of them are one formula.**

**The `ℂP²` orbit dimension is `4n - 14`, uniformly.** The record writes it as
`C(n,2) - 4 - C(n-4,2)`, the stabiliser `U(2) × SO(n-4)` having dimension `4 + C(n-4,2)`. That
binomial expression collapses:

`n(n-1)/2 - 4 - (n-4)(n-5)/2 = 4n - 14`,

linear in `n`, so **no dimension list is needed at all**, the formula covers every `n ≥ 4` at
once. It returns `2, 10, 18, 26, 34` at `n = 4, 6, 8, 10, 12`.

**So the two lists that look incompatible are the same formula on overlapping ranges.**
[nondegeneracy.md](../../../findings/nondegeneracy.md) verifies `{6,8,10}` and records `10` at
`n = 6` and `18` at `n = 8`; [second-order.md](../../../findings/second-order.md) verifies
`{8,10,12}` giving `18, 26, 34` and states in the same sentence that the formula returns `10` at
`n = 6`. Their union is `{6,8,10,12}` and they agree wherever both speak. **And `n = 4` is
confirmed independently**: [L25](L25.lean)'s witness has `dim E(½) = 2 = dim 𝒪`, which is
`4·4 - 14`.

**The fourth list is about different orbits.** [ATTEMPTS.md](../../../ATTEMPTS.md)'s `{8,12,14}`
certifies *Fox and every sphere split*, plus `ℍP²`/`ℍP³` at `n = 12`, nineteen orbits, by exact
integer arithmetic over `𝔽ₚ`. It never claimed the `ℂP²` orbit, so its silence at `n = 6, 10` is
scope rather than conflict.

**Hence [L19](L19.lean)'s intersection `{8}` answers a question that does not arise.** That
computation is correct and its premise is not: the lists were never four readings of one claim.
The audit's *"four incompatible dimension lists"* and its *"cannot stay in disagreement"* are
both withdrawn here.
-/

namespace HamiltonsCubic.OrbitDimension

/-! ## The stabiliser formula is linear -/

/-- **`C(n,2) - 4 - C(n-4,2) = 4n - 14`**, so the orbit dimension is linear in `n` and no list
is required. -/
theorem orbit_dim_linear (n : ℚ) :
    n * (n - 1) / 2 - 4 - (n - 4) * (n - 5) / 2 = 4 * n - 14 := by ring

/-- The stabiliser `U(2) × SO(n-4)` has dimension `4 + C(n-4,2)`, and that is what is subtracted
from `C(n,2)`. -/
theorem stabiliser_dim (n : ℚ) :
    n * (n - 1) / 2 - (4 + (n - 4) * (n - 5) / 2) = 4 * n - 14 := by ring

/-! ## Every recorded value is the same formula -/

/-- **`n = 4` gives `2`**, which is [L25](L25.lean)'s independently recorded `dim E(½) = dim 𝒪`. -/
theorem at_four : 4 * (4 : ℚ) - 14 = 2 := by norm_num

/-- **`n = 6` gives `10`**, recorded by both lists that reach it. -/
theorem at_six : 4 * (6 : ℚ) - 14 = 10 ∧ Nat.choose 6 2 - 4 - Nat.choose 2 2 = 10 := by
  refine ⟨by norm_num, by decide⟩

/-- **`n = 8` gives `18`**, the value both lists record. -/
theorem at_eight : 4 * (8 : ℚ) - 14 = 18 ∧ Nat.choose 8 2 - 4 - Nat.choose 4 2 = 18 := by
  refine ⟨by norm_num, by decide⟩

/-- **`n = 10` gives `26` and `n = 12` gives `34`.** -/
theorem at_ten_and_twelve :
    4 * (10 : ℚ) - 14 = 26 ∧ Nat.choose 10 2 - 4 - Nat.choose 6 2 = 26
      ∧ 4 * (12 : ℚ) - 14 = 34 ∧ Nat.choose 12 2 - 4 - Nat.choose 8 2 = 34 := by
  refine ⟨by norm_num, by decide, by norm_num, by decide⟩

/-! ## The two lists agree wherever both speak -/

/-- **`{6,8,10} ∩ {8,10,12} = {8,10}`, and the formula gives the same value at each**, so the
overlap is agreement, not conflict, and the union `{6,8,10,12}` is covered without dispute. -/
theorem overlap_agrees :
    (4 * (8 : ℚ) - 14 = 18 ∧ 4 * (10 : ℚ) - 14 = 26) ∧ (4 * (6 : ℚ) - 14 = 10) := by
  refine ⟨⟨by norm_num, by norm_num⟩, by norm_num⟩

/-- **A list is unnecessary for a claim that holds at every `n`.** The formula is defined and
positive for every `n ≥ 4`, so enumerating dimensions records where it was *checked*, never where
it *holds*. -/
theorem formula_positive_throughout {n : ℚ} (hn : 4 ≤ n) : 0 < 4 * n - 14 := by linarith

end HamiltonsCubic.OrbitDimension
