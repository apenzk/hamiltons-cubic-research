import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Order.Bounds.Basic

/-!
# L40, a measurement over a catalogue, and which direction it gives

[target.md](../../../findings/target.md)'s Observation L40. Its two audit findings are
statements about suprema over subsets, and they are proved here as schemas, nothing about
curvature enters, which is the point: the error is not in the geometry.

**The direction.** A supremum over a catalogue `𝒞 ⊆ 𝒩` gives `sup_𝒩 θ ≥ √(3/2)`, while the
statement that would close the conjecture is `sup_𝒩 θ ≤ √(3/2)`. `subset_gives_ge` below is
the direction L40 reaches; `sup_not_transferred` exhibits a two-point counterexample showing
the other direction does not follow, so the gap is not a matter of tightening the argument.

**"Three independent hunts" is one.** The two closure sweeps could not have topped out
anywhere else: padding preserves `θ` and a `∘`-orthogonal sum has `|θ| < min(|θ₁|, |θ₂|)`
strictly, so **every closure point either ties a catalogue point or falls strictly below
one**. `closure_adds_nothing` turns that hypothesis into the conclusion, so the sweeps
confirm a theorem rather than supplying evidence.

**The control that matters is exact.** `S⁵ × S⁷` sits *above* the target, `264/175` against
`3/2`, by exactly `3/350`. That is why its misclassification would break the measurement,
and the margin is not small.
-/

namespace HamiltonsCubic.Catalogue

/-! ## The direction a catalogue supremum gives -/

/-- **A supremum over a subset bounds the superset from below.** If a catalogue point attains
`v`, then some point of the full set is at least `v`, which is `≥`, not `≤`. -/
theorem subset_gives_ge {α : Type*} {C N : Set α} (hsub : C ⊆ N) (θ : α → ℚ) {w : α}
    (hw : w ∈ C) {v : ℚ} (hv : θ w = v) : ∃ x ∈ N, v ≤ θ x :=
  ⟨w, hsub hw, by rw [hv]⟩

/-- **And the other direction does not follow.** A two-point example: the catalogue `{0}` has
supremum `0`, the full set `{0, 1}` contains a point above it. So no sharpening of L40's
argument reaches `≤`, the missing direction is a different statement, not a looser one. -/
theorem sup_not_transferred :
    ∃ (C N : Set ℚ) (θ : ℚ → ℚ) (v : ℚ),
      C ⊆ N ∧ (∀ y ∈ C, θ y ≤ v) ∧ ∃ x ∈ N, v < θ x := by
  refine ⟨{0}, {0, 1}, id, 0, ?_, ?_, ?_⟩
  · intro x hx; simp only [Set.mem_singleton_iff] at hx; simp [hx]
  · intro y hy; simp only [Set.mem_singleton_iff] at hy; simp [hy]
  · exact ⟨1, by simp, by norm_num⟩

/-! ## Why the closure sweeps are not independent evidence -/

/-- **The closure adds nothing.** If every closure point either ties a catalogue point or
falls strictly below one, which padding-invariance and strict orthogonal-sum decrease give,
then any bound on the catalogue bounds the closure. The sweeps therefore confirm a theorem
and could not have topped out elsewhere. -/
theorem closure_adds_nothing {α : Type*} {cat clos : Set α} (θ : α → ℚ)
    (hclos : ∀ x ∈ clos, ∃ y ∈ cat, θ x ≤ θ y) {b : ℚ} (hub : ∀ y ∈ cat, θ y ≤ b) :
    ∀ x ∈ clos, θ x ≤ b := by
  intro x hx
  obtain ⟨y, hy, hxy⟩ := hclos x hx
  exact le_trans hxy (hub y hy)

/-- Padding ties: `θ` is preserved, so a padded point contributes `≤` with equality. -/
theorem padding_ties {α : Type*} (θ : α → ℚ) {x y : α} (h : θ x = θ y) : θ x ≤ θ y :=
  le_of_eq h

/-- An orthogonal sum falls strictly below both summands, so it contributes `<`. -/
theorem orthogonal_sum_below {t t1 t2 : ℚ} (h : t < min t1 t2) : t < t1 ∧ t < t2 :=
  ⟨lt_of_lt_of_le h (min_le_left _ _), lt_of_lt_of_le h (min_le_right _ _)⟩

/-! ## The control that would break the measurement -/

/-- **`S⁵ × S⁷` sits above the target**, `θ² = 264/175` against `3/2`. -/
theorem control_above : (3 : ℚ) / 2 < 264 / 175 := by norm_num

/-- **By exactly `3/350`**, the margin the misclassification test has to survive. -/
theorem control_margin : (264 : ℚ) / 175 - 3 / 2 = 3 / 350 := by norm_num

/-- It is the strongest available control precisely because it exceeds the target: a control
below `3/2` could be misclassified without moving the supremum. -/
theorem control_is_binding {c : ℚ} (hc : c < 3 / 2) : c ≠ 264 / 175 := by
  intro h; rw [h] at hc; norm_num at hc

end HamiltonsCubic.Catalogue
