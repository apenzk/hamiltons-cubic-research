import Mathlib

/-!
# The matching rotation at a general angle, per block

[reviews/2026-09-28c-LIT-step8-sweep.md](../../../reviews/2026-09-28c-LIT-step8-sweep.md), "the
separator made precise".

**The source's statement.** For a pair-free `W`, rotating every plane of a matching by `φ`, with
`c = cos 2φ` and `s = sin 2φ`, sends `α_IZ, α_ZI` to `c α_IZ, c α_ZI` and `α_ZZ` to
`α_ZZ c² + α_XX s²`, so the block's diagonal mass changes by `4 s² g_block(s²)` with
`g_block` linear.

**What is typed.** `block_angle`: with `c² + s² = 1`, the change
`(c a)² + (c b)² + (z c² + x s²)² - (a² + b² + z²)` equals
`s² · (-(a² + b²) - z² (2 - s²) + 2 z x (1 - s²) + x² s²)`. `block_linear`: the bracket is affine
in `u = s²`, so its maximum over `u ∈ [0,1]` is at an endpoint.

**Not typed**: the block decomposition of the rotated operator and the vanishing of the pair
components, which are the note's structural half.
-/

namespace HamiltonsCubic.MatchingAngle

/-- **THE BLOCK AT ANGLE `φ`.** -/
theorem block_angle (a b z x c s : ℝ) (hcs : c ^ 2 + s ^ 2 = 1) :
    (c * a) ^ 2 + (c * b) ^ 2 + (z * c ^ 2 + x * s ^ 2) ^ 2 - (a ^ 2 + b ^ 2 + z ^ 2)
      = s ^ 2 * (-(a ^ 2 + b ^ 2) - z ^ 2 * (2 - s ^ 2) + 2 * z * x * (1 - s ^ 2)
          + x ^ 2 * s ^ 2) := by
  have hc : c ^ 2 = 1 - s ^ 2 := by linarith
  have hc4 : c ^ 4 = (1 - s ^ 2) ^ 2 := by rw [show c ^ 4 = (c ^ 2) ^ 2 by ring, hc]
  have e : (c * a) ^ 2 + (c * b) ^ 2 + (z * c ^ 2 + x * s ^ 2) ^ 2
      = c ^ 2 * (a ^ 2 + b ^ 2) + z ^ 2 * c ^ 4 + 2 * z * x * c ^ 2 * s ^ 2
          + x ^ 2 * s ^ 4 := by ring
  rw [e, hc4, hc]
  ring

/-- **AFFINE IN `u = s²`.** An affine function of `u` on `[0,1]` is at most its larger
endpoint value. -/
theorem block_linear (p q u : ℝ) (hu0 : 0 ≤ u) (hu1 : u ≤ 1) :
    p + q * u ≤ max p (p + q) := by
  rcases le_total 0 q with hq | hq
  · exact le_max_of_le_right (by nlinarith)
  · exact le_max_of_le_left (by nlinarith)

end HamiltonsCubic.MatchingAngle
