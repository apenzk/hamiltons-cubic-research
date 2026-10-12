import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L132, why the trace is strictly weaker, and why the second proof returns its own input

[ungraded-slack.md](../../../findings/ungraded-slack.md)'s Lemma L132, withdrawn because the
record already carried a stronger decomposition. Three of the withdrawal's claims are arithmetic
and are checked here.

**Summing the three terms discards information that cannot be recovered.** The surviving
decomposition is `S = T₁ + 2T₂ + T₃` with each `Tₖ` a compression of a PSD operator, hence
nonnegative, which gives `S ≥ 0` *and* a lower bound by each term separately. The withdrawn
statement is that sum's trace, and from `S ≥ 0` alone nothing follows about the parts:
`(T₁,T₂,T₃) = (-1,1,0)` has `S = 1 ≥ 0` with `T₁ < 0`. So *"strictly stronger"* is exact rather
than a preference between two true statements.

**The sentence *"the two forms agree exactly when the compression is lossless"* is false in the
direction that matters.** At a graded point `S = 0 = T₃` while `tr(W₋^#) = ½Σμᵢ(θ-μᵢ) > 0`, the
compression loses everything and the two forms agree anyway. One witness with `μ = (1,1)` and
`θ = 3` gives the loss quantity `2` alongside agreement at `0`, so the `⟸` direction fails and
the biconditional collapses to at most an implication.

**And the offered second proof is a round trip.** Polarisation and its diagonal are mutually
inverse: for `q(x) = cx²` the polarisation is `B(x,y) = cxy` and `B(x,x) = q(x)` identically. So
pairing a polarised identity with its own argument returns the identity it came from, which is
why the second proof carries no content beyond the first.
-/

namespace HamiltonsCubic.SlackDecomposition

/-! ## The sum is strictly weaker than the parts -/

/-- **Nonnegative parts give the sum and every part**, which is the surviving form's strength. -/
theorem parts_give_sum {T₁ T₂ T₃ : ℚ} (h₁ : 0 ≤ T₁) (h₂ : 0 ≤ T₂) (h₃ : 0 ≤ T₃) :
    0 ≤ T₁ + 2 * T₂ + T₃ ∧ 2 * T₂ ≤ T₁ + 2 * T₂ + T₃ ∧ T₁ ≤ T₁ + 2 * T₂ + T₃ := by
  refine ⟨by linarith, by linarith, by linarith⟩

/-- **But a nonnegative sum says nothing about the parts.** `(-1,1,0)` sums to `1` with a
negative first term, so the trace cannot recover what the decomposition asserts. -/
theorem sum_does_not_give_parts :
    ∃ T₁ T₂ T₃ : ℚ, 0 ≤ T₁ + 2 * T₂ + T₃ ∧ T₁ < 0 := by
  refine ⟨-1, 1, 0, by norm_num, by norm_num⟩

/-- So the withdrawn statement is implied by the surviving one and does not imply it back. -/
theorem strictly_stronger :
    (∀ T₁ T₂ T₃ : ℚ, 0 ≤ T₁ → 0 ≤ T₂ → 0 ≤ T₃ → 0 ≤ T₁ + 2 * T₂ + T₃)
      ∧ ¬ (∀ T₁ T₂ T₃ : ℚ, 0 ≤ T₁ + 2 * T₂ + T₃ → 0 ≤ T₁) := by
  constructor
  · intro T₁ T₂ T₃ h₁ h₂ h₃; linarith
  · intro h
    have := h (-1) 1 0 (by norm_num)
    norm_num at this

/-! ## The `"exactly when"` fails -/

/-- The loss quantity at a graded point, `½Σμᵢ(θ-μᵢ)`, with `μ = (1,1)` and `θ = 3`. -/
theorem loss_is_positive : (1 / 2 : ℚ) * (1 * (3 - 1) + 1 * (3 - 1)) = 2 := by norm_num

/-- **And it is positive whenever `0 < μᵢ < θ`**, so the graded case is not special. -/
theorem loss_positive_general {μ θ : ℚ} (hμ : 0 < μ) (hθ : μ < θ) :
    0 < (1 / 2 : ℚ) * (μ * (θ - μ) + μ * (θ - μ)) := by nlinarith

/-- **So agreement coexists with total loss**, refuting *"exactly when"*. At a graded point the
record gives `S = 0` and `T₃ = 0`, so the two forms agree; the compression's loss `μ(θ-μ)` is
strictly positive there all the same. -/
theorem exactly_when_fails {S T₃ μ θ : ℚ} (hS : S = 0) (hT : T₃ = 0)
    (hμ : 0 < μ) (hθ : μ < θ) : S = T₃ ∧ 0 < μ * (θ - μ) := by
  refine ⟨by rw [hS, hT], ?_⟩
  nlinarith

/-! ## The second proof is a round trip -/

/-- The polarisation of `q(x) = cx²`. -/
def polar (c x y : ℚ) : ℚ := (c * (x + y) ^ 2 - c * x ^ 2 - c * y ^ 2) / 2

/-- **It is `cxy`**, identically. -/
theorem polar_eq (c x y : ℚ) : polar c x y = c * x * y := by
  unfold polar; ring

/-- **And its diagonal returns `q`**, so depolarising a polarised identity recovers the input,
which is why pairing a polarised lemma with its own argument establishes nothing new. -/
theorem polar_diagonal (c x : ℚ) : polar c x x = c * x ^ 2 := by
  unfold polar; ring

end HamiltonsCubic.SlackDecomposition
