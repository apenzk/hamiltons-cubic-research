import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

/-!
# L62, `F₅(W₀) = 0`, exactly over `ℤ`, and the surd is only a normalisation

`F₅ = (3/2)‖W‖⁶ - 9 tr(W³)²`, and the certificate's whole conclusion about the
equality point is that `F₅` vanishes at `W₀`, the zero-padding of `W_{ℂP²}` into
`𝒲₅`. The record carries this at the normalised point, where the spectrum is
`(2, -1, -1, 0⁷)/√6` and the statement reads `θ² = 3/2`.

**The surd is entirely in the normalisation.** `W₀` unnormalised has integer spectrum
`(4, -2, -2, 0⁷)` on `Λ²ℝ⁵`, and there `‖W₀‖² = 24` and `tr(W₀³) = 48` are integers.
`F₅` is homogeneous of degree six, so its vanishing is scale-free and the normalised
claim follows from an identity in `ℤ`.

This is the shape the loop's phase 1 names: a figure written with a radical is a
measurement, the same figure as an integer identity is a theorem.

Everything is `norm_num` or `ring`, kernel-checked.
-/

namespace HamiltonsCubic.CP2

/-- The unnormalised spectrum of `W₀` on `Λ²ℝ⁵`: the padded `W_{ℂP²}` acts with
eigenvalues `4, -2, -2` on the `ℂP²` block and `0` on the seven padded directions. -/
def spec : List ℤ := [4, -2, -2, 0, 0, 0, 0, 0, 0, 0]

/-- `Λ²ℝ⁵` is ten-dimensional, and the padding accounts for seven of the ten. -/
theorem spec_length : spec.length = 10 := by decide

theorem padded_directions : (spec.filter (fun x => x == 0)).length = 7 := by decide

/-- `‖W₀‖² = Σ λᵢ² = 24`. -/
theorem norm_sq : (spec.map (fun x => x * x)).sum = 24 := by decide

/-- `tr(W₀³) = Σ λᵢ³ = 48`. -/
theorem trace_cube : (spec.map (fun x => x * x * x)).sum = 48 := by decide

/-- `W₀` is trace-free, as a curvature operator must be. -/
theorem trace_zero : spec.sum = 0 := by decide

/-- **`F₅(W₀) = 0`, over `ℤ`.** Written `2 F₅ = 3‖W‖⁶ - 18 tr(W³)²` to clear the
half, so no division enters: `3 · 24³ = 18 · 48²`, both `41472`. -/
theorem F5_vanishes :
    3 * ((spec.map (fun x => x * x)).sum) ^ 3
      = 18 * ((spec.map (fun x => x * x * x)).sum) ^ 2 := by decide

theorem F5_both_sides : 3 * (24 : ℤ) ^ 3 = 41472 ∧ 18 * (48 : ℤ) ^ 2 = 41472 := by
  norm_num

/-- **`θ² = 3/2` at `W₀`**, in the form that avoids the radical: `θ = P/‖W‖³` with
`P = 3 tr(W³)` on `𝒲₅`, so `2 P² = 3 ‖W‖⁶` is the equality statement. -/
theorem theta_sq_at_W0 :
    2 * (3 * ((spec.map (fun x => x * x * x)).sum)) ^ 2
      = 3 * ((spec.map (fun x => x * x)).sum) ^ 3 := by decide

/-- **Homogeneity, which is why the integer identity settles the normalised claim.**
`F₅` is homogeneous of degree six in the spectrum, so scaling `W₀` to unit norm
multiplies both sides by the same `c⁶` and cannot change whether they are equal. -/
theorem F5_homogeneous (c : ℤ) (n t : ℤ) :
    3 * ((c * c) * n) ^ 3 - 18 * ((c * c * c) * t) ^ 2 = c ^ 6 * (3 * n ^ 3 - 18 * t ^ 2) := by
  ring

/-! ## What this settles, and what it does not

**Settled**: the equality point's arithmetic, exactly and without a radical, together
with the reason the normalised statement follows from it.

**Not settled here**: that `W₀` is an algebraic Weyl operator at `n = 5`, the padding
lemmas carry that, and that `P(W) = 3 tr(W³)` holds on `𝒲₅`, which is L50's collapse
and is imported. Neither is arithmetic, and neither is claimed above.

**Deliberately absent**: the inference from `tr(W₀³) = 48 ≠ 0` to *"the trivial block's
evaluation map has rank 1"*. That step was produced inside a verification round and has
had no Gate 2; the arithmetic is here, and the inference is not.
-/

end HamiltonsCubic.CP2
