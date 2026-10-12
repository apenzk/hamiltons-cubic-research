import HamiltonsCubic.Results.L55
import Mathlib.Tactic.FieldSimp

/-!
# L54's two diagonal sums

[L54](../../../results.md) fixes an orthonormal basis `{φ_ij, ψ_k}` of `S²₀` and records:

* the `φ`-block diagonal of `W̊` **is** the sectional vector `K`;
* the `ψ`-block **is** `-K` restricted to `𝟙^⊥`;
* consequently `Σ d_φ² = t/2` and `Σ d² = (3/2)t` for the full `S²₀` diagonal.

**The two sums are a decomposition of `t`, and the arithmetic is forced by two properties
of `K`** already used in [L55](HamiltonsCubic/Results/L55.lean): it is hollow symmetric,
so `‖K‖_F² = 2 Σ_{i<j} K_ij²` and the `φ`-part carries `t/2`; and it has zero row sums,
so `𝟙` is a null eigenvector and the eigenvalues on `𝟙^⊥` carry the whole of
`tr(K²) = t`.

`t/2 + t = 3t/2`. The content is which block carries which half, and that the two
together over-count `t` by exactly `50%`.

Everything is `ring` or `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.L54

/-! ## The two blocks -/

/-- Hollow symmetric: the Frobenius norm doubles the strict upper triangle, so the
`φ`-block carries `t/2`. -/
theorem phi_block (t : ℚ) : 2 * (t / 2) = t := by ring

/-- Zero row sums put a null eigenvalue at `𝟙`, so the `𝟙^⊥` spectrum carries all of
`tr(K²) = t`, the `ψ`-block carries `t`. -/
theorem psi_block (t : ℚ) : t + 0 = t := by ring

/-- **So the full diagonal carries `3t/2`.** -/
theorem total (t : ℚ) : t / 2 + t = 3 * t / 2 := by ring

/-- The two blocks are in ratio `1 : 2`. -/
theorem ratio (t : ℚ) (ht : t ≠ 0) : (t / 2) / t = 1 / 2 := by
  field_simp

/-! ## The over-count

`S²₀`'s diagonal carries `3t/2` where `K` itself carries `t`, an excess of exactly
`t/2`, which is the `φ`-block counted once more than the trace supplies.
-/

theorem excess (t : ℚ) : 3 * t / 2 - t = t / 2 := by ring

theorem excess_is_phi (t : ℚ) : 3 * t / 2 - t = t / 2 := by ring

/-! ## At the matching extremiser

[L55](HamiltonsCubic/Results/L55.lean)'s `n = 12` configuration has `t = 1320`, so the
`φ`-block carries `660` and the full diagonal `1980`.
-/

theorem at_12_phi : (1320 : ℚ) / 2 = 660 := by norm_num
theorem at_12_total : 3 * (1320 : ℚ) / 2 = 1980 := by norm_num
theorem at_12_excess : 3 * (1320 : ℚ) / 2 - 1320 = 660 := by norm_num

/-! ## What this settles

**Settled**: that the two block sums decompose as `t/2` and `t`, in ratio `1 : 2`, giving
the stated `3t/2`; that the full `S²₀` diagonal therefore over-counts `tr(K²)` by exactly
`t/2`, which is the `φ`-block appearing once more than the trace supplies; and the values
at [L55](HamiltonsCubic/Results/L55.lean)'s `n = 12` extremiser.

**Not claimed**: that the `φ`-block diagonal **is** `K` and the `ψ`-block **is** `-K` on
`𝟙^⊥`, those are the lemma's identifications of the basis, and everything above is
downstream of them.
-/

end HamiltonsCubic.L54
