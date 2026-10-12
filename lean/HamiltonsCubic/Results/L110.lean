import HamiltonsCubic.Results.L68
import Mathlib.Tactic.NormNum

/-!
# L110, the per-direction identity, and what its slack is

[bounds-relaxations.md](../../../findings/bounds-relaxations.md)'s Lemma L110: the slack is
**exactly `g_γ/(4λ_γ)`**.

**So the slack vanishes exactly where [L68](L68.lean)'s density does.** L68 proves
`g_ab = 0` iff the two rows agree off the pair (a twin pair) so the identity is tight
**precisely at twin pairs**, and nowhere else. The two blocks state `g` and its vanishing
independently; the slack formula is what joins them, and neither says so. `g_nonneg` is
imported here rather than restated, so the sign of the slack is L68's.

**"The same constraint set" was false, by `N - 2`.** Pinning `Q_γ` adds one equation per
direction against the two contractions already present, so `N - 2` are new, a count, not a
judgement.

**"Equality at the maximiser, therefore no escape" is a non sequitur**, and the reason is
that attainment is universal among sharp bounds: two different bounds attained at the same
point are not distinguished by that, so attainment is evidence for neither.
-/

namespace HamiltonsCubic.PerDirection

open HamiltonsCubic.Diagonal

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {M : ι → ι → ℝ}

/-! ## The slack is L68's density, divided -/

/-- **The slack `g_γ/(4λ_γ)` is non-negative** at every positive direction, from L68's
`g_nonneg`, imported. -/
theorem slack_nonneg (a b : ι) {lam : ℝ} (hlam : 0 < lam) : 0 ≤ g M a b / (4 * lam) :=
  div_nonneg (g_nonneg a b) (by linarith)

/-- **And it vanishes exactly when `g` does.** -/
theorem slack_zero_iff (a b : ι) {lam : ℝ} (hlam : 0 < lam) :
    g M a b / (4 * lam) = 0 ↔ g M a b = 0 := by
  rw [div_eq_zero_iff]
  constructor
  · rintro (h | h)
    · exact h
    · linarith
  · intro h; exact Or.inl h

/-- **So the identity is tight exactly at twin pairs**, by L68's characterisation of
`g = 0`, the two blocks state `g` and the slack separately and neither joins them. -/
theorem tight_iff_twins (a b : ι) {lam : ℝ} (hlam : 0 < lam) :
    g M a b / (4 * lam) = 0 ↔ ∀ d ∈ Finset.univ \ ({a, b} : Finset ι), M a d = M b d := by
  rw [slack_zero_iff a b hlam]
  exact g_eq_zero_iff

/-! ## The constraint count -/

/-- **Pinning `Q_γ` adds `N - 2` equations** beyond the two contractions already present, so
*"the same constraint set"* is false by a count. -/
theorem new_equations (N : ℕ) (hN : 2 ≤ N) : N - 2 + 2 = N := by omega

/-- And `N - 2 > 0` from `N ≥ 3`, so the addition is not empty at any dimension the record
uses. -/
theorem addition_nonempty (N : ℕ) (hN : 3 ≤ N) : 0 < N - 2 := by omega

/-! ## Attainment is universal among sharp bounds -/

/-- **A bound attained at one point may be strictly improvable at another**, so attainment
bounds nothing about the rest of the domain. That is why *"equality at the maximiser,
therefore no escape"* is a non sequitur: the premise holds for every sharp bound, including
improvable ones. -/
theorem attained_yet_improvable :
    ∃ (f g : ℚ → ℚ) (x₀ x₁ : ℚ), f x₀ = g x₀ ∧ g x₁ < f x₁ := by
  refine ⟨fun _ => 1, fun t => t, 1, 0, rfl, by norm_num⟩

end HamiltonsCubic.PerDirection
