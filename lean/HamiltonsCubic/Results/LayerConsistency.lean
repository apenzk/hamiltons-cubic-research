import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# The layer against itself, every repeated definition agrees, and nothing enforces that

An audit of this layer rather than of the record. Across its files, twelve definition names occur
more than once. **Every one agrees**, and the two apparent exceptions are not exceptions.

**`ThetaOddSq` is defined four times in two spellings.** [L0](L0.lean) and
[OddWitness](OddWitness.lean) write the denominator `(n+1)(n-2)`; [L16](L16.lean) and
[L18](L18.lean) write `(n-2)(n+1)`. Equal by commutativity, proved below, one function under
four definitions.

**`kappaF` against `kappaFox` is a deliberate distinction, not a clash.** Three files define
`kappaF = (2n-1)(n-1)/4` identically; the `/16` body belongs to `kappaFox`, the same constant in
Fox's normalisation, and the two differ by the recorded factor `4`. A name-only scan reports
these as one name with two bodies, which is how the apparent conflict arose.

**`theta0Sq` is defined eleven times, `cpSq` three, `kappaF` three, and the agreement is
contingent.** Each is an independent copy, so a change of convention would have to be made
eleven times and nothing in the build catches a divergence: the files do not import one another's
definitions, and Lean is content with two namespaces disagreeing. The agreement recorded here is
a fact about the current state, not a property the layer maintains.

**Why the check had to compare bodies rather than values.** Two definitions agreeing at every
value anyone has evaluated can still differ; only the bodies settle it. Below, that gap is
exhibited, which is why this audit read the definitions rather than testing them.
-/

namespace HamiltonsCubic.LayerConsistency

/-! ## The two `ThetaOddSq` spellings are one function -/

def oddA (n : ℚ) : ℚ := 2 * (n - 1) * (n - 3) / ((n + 1) * (n - 2))

def oddB (n : ℚ) : ℚ := 2 * (n - 1) * (n - 3) / ((n - 2) * (n + 1))

/-- **They are equal at every `n`**, by commutativity of the denominator. -/
theorem odd_spellings_agree (n : ℚ) : oddA n = oddB n := by
  unfold oddA oddB; ring

/-! ## `kappaF` and `kappaFox` differ by the recorded factor -/

def kappaF (n : ℚ) : ℚ := (2 * n - 1) * (n - 1) / 4

def kappaFox (n : ℚ) : ℚ := (2 * n - 1) * (n - 1) / 16

/-- **The `/16` body is a different constant, not a competing definition of the same one.** -/
theorem normalisations_differ (n : ℚ) : kappaF n = 4 * kappaFox n := by
  unfold kappaF kappaFox; ring

/-- And they agree nowhere but at the roots, so conflating them is not harmless. -/
theorem normalisations_meet_only_at_roots (n : ℚ) :
    kappaF n = kappaFox n ↔ (2 * n - 1) * (n - 1) = 0 := by
  unfold kappaF kappaFox
  constructor
  · intro h; linarith [h]
  · intro h; rw [h]; norm_num

/-! ## Values do not settle definitional agreement -/

/-- **Two functions can agree wherever anyone has looked and differ elsewhere.** So an audit that
compares evaluations at recorded dimensions establishes nothing about the definitions; this one
compared bodies. -/
theorem values_do_not_settle_definitions :
    ∃ f g : ℚ → ℚ, f 4 = g 4 ∧ f 6 = g 6 ∧ f 8 = g 8 ∧ f 5 ≠ g 5 := by
  refine ⟨fun _ => 0, fun x => (x - 4) * (x - 6) * (x - 8), ?_, ?_, ?_, ?_⟩ <;> norm_num

end HamiltonsCubic.LayerConsistency
