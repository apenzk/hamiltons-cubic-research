import Mathlib

set_option linter.style.longLine false

/-!
# L100, the dichotomy, in the parts that do not need the curvature layer

## The record's statement, quoted verbatim from [route-a.md](../../../findings/route-a.md)

> #### Lemma L100 (the $8\le n\le11$ dichotomy), either $\max P\le\sqrt{3/2}$, or every maximizer
> sits farther than $0.5748$ from the $\mathbb{CP}^2$ orbit

and, from the Gate 2 verdict in the same block, the corrections that fix what the statement is:

> **"UNCONDITIONAL" IS REFUTED, AND THE RANGE STARTS TOO LOW.** The one unproved input is
> $\alpha\le\tfrac13$, and **its supports do not cover $n=8$** […] **Only floating point covers
> $n=8$.** […] **the honest lower endpoint is $9$**

> **THE DICHOTOMY IS ONE IMPLICATION, NOT A CASE SPLIT.** Padding gives $M(n)\ge\sqrt{3/2}$ at
> every $n\ge5$, so the first horn is **forced to an equality**, $M(n)=\sqrt{3/2}$, and the horns
> are mutually exclusive. The content is: $M(n)>\sqrt{3/2}\Rightarrow$ every maximiser is far from
> the orbit.

> **THE CONSTANT IS DERIVED** […] $0.5748$ is the root of $\sin^3\varphi=1-\cos\varphi$, truncated
> in the safe direction […] **The metric was unstated and is load-bearing**: geodesic angular
> distance, of diameter $\pi$, making the radius $18.3\%$ of the maximum and so non-vacuous. *A
> chord reading fails.*

and the surviving form of the statement:

> **A bonus at $9\le n\le11$.** The same machinery […] yields, **wherever $\alpha\le\tfrac13$
> holds**, a dichotomy below the crossover: either $\max P\le\sqrt{3/2}$, or every maximizer sits
> farther than $0.5748$ in geodesic angular distance from the $\mathbb{CP}^2$ orbit.

## What is typed here

* `horns_forced_to_equality`, `horns_exclusive`, `dichotomy_is_one_implication`, the Gate 2
  correction to the statement's shape: with `M(n) ≥ √(3/2)` from padding, the first horn is an
  equality, the horns cannot both hold, and the whole content is the single implication
  `M(n) > √(3/2) ⇒ every maximiser is far`.
* `radius_fraction_of_diameter`, the radius `0.5748` against the geodesic diameter `π` is
  between `18.29%` and `18.3%`, which is the record's non-vacuity claim, checked.
* `root_equation`, the equation `sin³φ = 1 - cos φ` that defines the constant, named so that the
  numeric clause below can be stated against it.

Everything below is proved; there is no `sorry`.

## What is NOT typed here

**The dichotomy itself is not stated, in any form.** Its subject is `P`, the record's cubic
functional on the unit sphere of `𝒲ₙ`, together with the `ℂP²` orbit and geodesic angular distance
on that sphere, which is the curvature layer this record has not built in Lean. Stating it against
an *arbitrary* real-valued function and an arbitrary subset would be stating a different and false
proposition, so it is left out rather than weakened: `dichotomy_is_one_implication` types the shape
of the claim, not the claim.

**The numeric clause `0.5748 < φ*` is not typed either.** `φ*` is the positive root of
`sin³φ = 1 - cos φ`, and at `φ = 0.5748` the two sides differ by about `2·10⁻⁵`, a margin far below
what Mathlib's elementary `sin` and `cos` bounds resolve; establishing it needs interval arithmetic
this file does not perform.

**And the unproved input `α ≤ 1/3` is not discharged.** The record's own Gate 2 records that it
holds at `n ≥ 9` from a cited source, and that only floating point covers `n = 8`, so the
statement is conditional on it, and typing the conditional would still need `P`.
-/

namespace HamiltonsCubic.L100Statement

/-! ## The shape of the claim

*`M` is `max P` at the dimension in question, `Far` the proposition that every maximiser sits
farther than `0.5748` in geodesic angular distance from the `ℂP²` orbit.* -/

/-- **Padding forces the first horn to an equality.** With `√(3/2) ≤ M` from the padded
competitor, the horn `M ≤ √(3/2)` is `M = √(3/2)`. -/
theorem horns_forced_to_equality {M : ℝ} (hpad : Real.sqrt (3 / 2) ≤ M) :
    M ≤ Real.sqrt (3 / 2) ↔ M = Real.sqrt (3 / 2) :=
  ⟨fun h => le_antisymm h hpad, fun h => h.le⟩

/-- **The horns are mutually exclusive.** -/
theorem horns_exclusive {M : ℝ} : ¬(M ≤ Real.sqrt (3 / 2) ∧ Real.sqrt (3 / 2) < M) := by
  rintro ⟨h1, h2⟩
  exact absurd h1 (not_le.mpr h2)

/-- **The dichotomy is one implication.** A disjunction whose first horn is `M ≤ √(3/2)` says
exactly that `M > √(3/2)` forces the second horn, which is the record's correction to reading it
as a case split. -/
theorem dichotomy_is_one_implication {M : ℝ} {Far : Prop} :
    (M ≤ Real.sqrt (3 / 2) ∨ Far) ↔ (Real.sqrt (3 / 2) < M → Far) := by
  constructor
  · rintro (h | h) hgt
    · exact absurd h (not_le.mpr hgt)
    · exact h
  · intro h
    rcases le_or_gt M (Real.sqrt (3 / 2)) with hle | hgt
    · exact Or.inl hle
    · exact Or.inr (h hgt)

/-! ## The radius against the geodesic diameter -/

/-- The equation the constant `0.5748` is a truncation of the root of. -/
def root_equation (φ : ℝ) : Prop := Real.sin φ ^ 3 = 1 - Real.cos φ

/-- **The radius is about `18.3%` of the geodesic diameter**, which is the record's non-vacuity
claim: the metric is geodesic angular distance, of diameter `π`. *A chord reading, of diameter `2`,
would make the fraction `28.7%` instead, and the record records that reading as failing.* -/
theorem radius_fraction_of_diameter :
    0.1829 < 0.5748 / Real.pi ∧ 0.5748 / Real.pi < 0.183 := by
  have hlo : (3.141592 : ℝ) < Real.pi := Real.pi_gt_d6
  have hhi : Real.pi < (3.141593 : ℝ) := Real.pi_lt_d6
  have hpos : (0 : ℝ) < Real.pi := by linarith
  constructor
  · rw [lt_div_iff₀ hpos]; nlinarith
  · rw [div_lt_iff₀ hpos]; nlinarith

/-- **The chord reading the record rejects** gives a materially different fraction, `28.7%` against
`18.3%`, which is why the metric is load-bearing. -/
theorem chord_reading_differs : (0.287 : ℝ) < 0.5748 / 2 ∧ (0.5748 : ℝ) / 2 < 0.288 := by
  refine ⟨by norm_num, by norm_num⟩

end HamiltonsCubic.L100Statement
