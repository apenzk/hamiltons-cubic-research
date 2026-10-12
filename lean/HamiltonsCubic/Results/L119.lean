import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.FieldSimp

/-!
# L119, the sharpened `λ`-weighted bound

[bounds-relaxations.md](../../../findings/bounds-relaxations.md)'s Lemma L119. Two of its
audit points are structural and are carried here.

**The sharpening is strict exactly where `Δ > 0`, and that is a coefficient comparison.** Two
bounds of the form `A - cΔ` and `A - c'Δ` are ordered by their coefficients, strictly once
`Δ > 0` and identically at `Δ = 0`. So *"strictly stronger wherever `Δ > 0` is forced, with no
exceptional points"* is not a survey of points, it is what the two shapes do, and the
"no exceptional points" clause is the `Δ = 0` case being an equality rather than a failure.

**The dropped unit-norm hypothesis is a homogeneity failure, not an oversight of degree.** A
bound between quantities of different homogeneity degrees is false at large scale whatever the
constants: if the left side is cubic and the right quadratic, scaling by `t` defeats it once
`t` passes the ratio. That is `homogeneity_needs_normalisation` below, and it shows the
hypothesis cannot be dropped rather than merely that it was.
-/

namespace HamiltonsCubic.SharpenedBound

/-! ## The sharpening is a coefficient comparison -/

/-- **Two bounds `A - cΔ` and `A - c'Δ` are ordered by their coefficients**, strictly once
`Δ > 0`. -/
theorem sharper_when_delta_pos {A c c' Δ : ℚ} (hcc : c < c') (hΔ : 0 < Δ) :
    A - c' * Δ < A - c * Δ := by nlinarith [hcc, hΔ]

/-- The improvement is exactly `(c' - c)Δ`, so it is measured by the coefficient gap. -/
theorem improvement {A c c' Δ : ℚ} : (A - c * Δ) - (A - c' * Δ) = (c' - c) * Δ := by ring

/-! ## The dropped hypothesis cannot be dropped -/

/-- **A bound between different homogeneity degrees fails at large scale.** With the left side
cubic and the right quadratic, scaling by `t` defeats it once `t` passes `g/f`, so the
unit-norm hypothesis is load-bearing, not decorative. -/
theorem homogeneity_needs_normalisation {f g : ℚ} (hf : 0 < f) (t : ℚ) (ht : g / f < t)
    (htpos : 0 < t) : ¬ (t ^ 3 * f ≤ t ^ 2 * g) := by
  intro h
  have ht2 : (0:ℚ) < t ^ 2 := by positivity
  have hg : t * f ≤ g := by nlinarith [h, ht2]
  have : g / f < t := ht
  rw [div_lt_iff₀ hf] at this
  linarith

end HamiltonsCubic.SharpenedBound
