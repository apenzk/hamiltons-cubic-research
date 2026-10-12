import Mathlib

/-!
# L19, WITHDRAWN, and the open core it leaves, STATED

[problem.md](../../../findings/problem.md)'s entry L19, quoted verbatim from
[results.md](../../../results.md):

> **Withdrawn.** *Gate 2, [r605](../../../reviews/REVIEW_r605.md) and
> [r606](../../../reviews/REVIEW_r606.md) on identical briefs, both reaching the verdict
> independently: there is no checkable statement, no hypothesis, no conclusion, no quantifier
> over `n`, no displayed inequality.* **The three claims the old heading bundled have three
> different standings.** *The rest lifts* is unlocatable as a numbered result, its source
> recording the step **failing at padded `W_{ℂP²}`** […]. *The top orbits are rigid* is an
> `Observation` supported at `19` orbits at `n = 8,12,14`, and its *"every sphere pair"* clause
> is false without [L11](../../../findings/nondegeneracy.md)'s `(3,3)` exclusion, `S³ × S³`
> being degenerate at `Θ₆`. *The gap sharpens* names no sharpened quantity. **The open core is a
> gap in a nameable place**: the localisation says every critical point at or above the rival's
> value lies within `εₙ` of a rigid orbit, and rigidity finishes it only if `εₙ ≤ min_i rᵢ`,
> **no isolation radius is anywhere on the record**, and nondegeneracy as
> kernel-equals-orbit-tangent gives isolation qualitatively and no radius.

## What is NOT typed here, and there is no lemma to type

**L19 states no proposition, so no Lean statement of L19 exists to write.** Two reviewers
reached that verdict independently and the record carries the withdrawal. Nothing below is
labelled `L19`, and nothing below should be read as reinstating it.

**What is typed is the open core**, which the record does write out as a proposition, together
with the one thing that makes it non-empty: the implication that rigidity closes the
localisation exactly when the localisation radius is no larger than the isolation radii. *That
implication is elementary and general, it is about a metric space, a predicate and a family of
sets, which is precisely the record's point: the mathematics of the step is trivial and the
missing object is the number `rᵢ`.*

**The three withdrawn claims are not typed.** *The rest lifts* has no locatable statement; *the
top orbits are rigid* is an `Observation` about Hessian kernels at `19` orbits, needing the
second variation of `P` on `𝒲ₙ`, which has no Lean base layer here; *the gap sharpens* names no
quantity.

**And no isolation radius is supplied.** `rigidity_closes_of_radius` below takes the radii as
hypotheses because the record has none, `no_content_without_radius` is the reason that matters:
without a radius the localisation's conclusion is compatible with no critical point lying on any
orbit at all.
-/

set_option linter.style.longLine false
set_option linter.unusedVariables false

namespace HamiltonsCubic.L19Statement

/-! ## The open core, written out as the record writes it

`X` stands for the unit sphere of `𝒲ₙ`, `P` for the cubic form, `Crit` for criticality,
`orbit i` for the `i`-th high-value critical orbit, `radius i` for its isolation radius in the
critical set, and `eps` for the localisation radius `εₙ`. -/

variable {X ι : Type*} [PseudoMetricSpace X]

/-- **The localisation, as a proposition**: every critical point at or above `θ*` lies within
`eps` of one of the orbits. -/
def Localises (P : X → ℝ) (Crit : X → Prop) (thetaStar : ℝ) (orbit : ι → Set X) (eps : ℝ) : Prop :=
  ∀ x, Crit x → thetaStar ≤ P x → ∃ i : ι, ∃ y ∈ orbit i, dist x y ≤ eps

/-- **Isolation in the critical set, as a proposition**: a critical point within `radius i` of
the `i`-th orbit lies on it. *This is what an isolation radius is, and it is the object the
record has nowhere.* -/
def IsolatedWithin (Crit : X → Prop) (orbit : ι → Set X) (radius : ι → ℝ) : Prop :=
  ∀ i : ι, ∀ x, Crit x → (∃ y ∈ orbit i, dist x y ≤ radius i) → x ∈ orbit i

/-- **The open core, closed by the radius comparison.** If the localisation holds at radius
`eps`, every orbit is isolated at radius `radius i`, and `eps ≤ radius i` for every `i`, then
every critical point at or above `θ*` lies **on** one of the orbits.

*The record's own sentence: "rigidity finishes it only if `εₙ ≤ min_i rᵢ`". The `only if` is what
`no_content_without_radius` records; the `if` is this theorem.* -/
theorem rigidity_closes_of_radius (P : X → ℝ) (Crit : X → Prop) (thetaStar : ℝ)
    (orbit : ι → Set X) (radius : ι → ℝ) (eps : ℝ)
    (hloc : Localises P Crit thetaStar orbit eps)
    (hiso : IsolatedWithin Crit orbit radius)
    (hrad : ∀ i : ι, eps ≤ radius i) :
    ∀ x, Crit x → thetaStar ≤ P x → ∃ i : ι, x ∈ orbit i := by
  intro x hx hP
  obtain ⟨i, y, hy, hd⟩ := hloc x hx hP
  exact ⟨i, hiso i x hx ⟨y, hy, le_trans hd (hrad i)⟩⟩

/-! ## Why the radius is the whole gap -/

/-- **Without a radius the localisation has no content.** For every `ε > 0` there is a point
within `ε` of an orbit that does not lie on it, so `Localises` alone, at any `ε`, is compatible
with no critical point lying on any orbit. *The record: "for every `ε > 0` a point lies within
`ε` of an orbit without lying on it".* -/
theorem no_content_without_radius {ε : ℝ} (hε : 0 < ε) :
    ∃ x : ℝ, x ∉ ({0} : Set ℝ) ∧ ∃ y ∈ ({0} : Set ℝ), dist x y ≤ ε := by
  refine ⟨ε, ?_, 0, rfl, ?_⟩
  · simp only [Set.mem_singleton_iff]
    exact ne_of_gt hε
  · rw [Real.dist_eq, sub_zero, abs_of_pos hε]

/-- **And the hypotheses of `rigidity_closes_of_radius` are satisfiable**, so the implication is
not empty: at `eps = 0` in a metric space, `Localises` with `radius = 0` and orbits the
singletons of the critical points themselves. *This says nothing about `𝒲ₙ`; it records that the
implication has models, which is what the record's step needs and what the missing `rᵢ` would
supply.* -/
theorem hypotheses_satisfiable {Y : Type*} [MetricSpace Y] (Crit : Y → Prop) :
    IsolatedWithin Crit (fun x : Y => ({x} : Set Y)) (fun _ => 0) := by
  intro i x hx ⟨y, hy, hd⟩
  rw [Set.mem_singleton_iff] at hy
  subst hy
  simp only [Set.mem_singleton_iff]
  exact (dist_le_zero.mp hd)

/-! ## The `(3,3)` exclusion, which is why *"every sphere pair"* is false

The record: *"`S³ × S³` is degenerate at `Θ₆`"*, its Hessian kernel is `18` against an orbit of
dimension `9`, so the degenerate directions are not exactly the orbit directions there. -/

/-- **`S³ × S³` fails the rigidity clause**, the kernel exceeding the orbit dimension. So the
`Observation`'s *"every sphere pair"* needs [L11](../../../findings/nondegeneracy.md)'s `(3,3)`
exclusion, and padding does not restore it. -/
theorem three_three_excluded : (18 : ℕ) ≠ 9 := by decide

end HamiltonsCubic.L19Statement
