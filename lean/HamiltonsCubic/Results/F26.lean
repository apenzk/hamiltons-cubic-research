import HamiltonsCubic.Results.Theta0

/-!
# Fence post 26, the one-sided improvement cannot close, exactly

[INDEX-traps.md](../../../findings/INDEX-traps.md) records post 26:

> **One-sided improvement on the second-kind cubic cannot close**, `(3/2) max p₃(μ) =
> 1.4657` already exceeding `θ₀(12)`.

The post is a **closed route**, and what closes it is a comparison of two numbers, one
printed to four places, the other the irrational `θ₀(12) = √55/6`. A route closed on a
decimal comparison is closed on a rounding until someone checks it.

It clears, and with a very large margin: squared, `1.4657² > 2.148` against
`θ₀(12)² = 55/36 ≈ 1.528`. **The excess is not marginal, it is over `40%` in the
square**, so no sharpening of a rounding could reopen the route.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.F26

open HamiltonsCubic.Theta0

/-- `θ₀(12)² = 55/36`, from [Theta0.lean](HamiltonsCubic/Results/Theta0.lean). -/
theorem target : evenSq 12 = 55 / 36 := by norm_num [evenSq]

/-- **The post's value clears the target**, squared so no root is taken. -/
theorem post26_clears : evenSq 12 < (1.4657 : ℚ) ^ 2 := by norm_num [evenSq]

/-- **And it clears by more than `40%`**, so the route is not closed on a rounding. -/
theorem margin : (1.4 : ℚ) * evenSq 12 < (1.4657 : ℚ) ^ 2 := by norm_num [evenSq]

/-- Even the crudest lower bound on the printed value, `1.46`, clears the target. -/
theorem robust_to_rounding : evenSq 12 < (1.46 : ℚ) ^ 2 := by norm_num [evenSq]

/-! ## An identification, offered rather than asserted

The classical maximum of `Σμ³` subject to `Σμ = 0`, `Σμ² = 1` over `N` entries is
`(N-2)/√(N(N-1))`, attained at one large entry against `N-1` equal small ones. At
`N = 66 = dim Λ²ℝ¹²` that gives `(3/2)·64/√4290`, whose square is `1536/715`.

`√(1536/715) = 1.465685…`, which reproduces the recorded `1.4657` at every printed
place. **This is a reconstruction from the printed value and is recorded as a candidate,
not as the record's own derivation**, the loop checks what the record states, and the
record states the decimal.
-/

/-- The candidate exact value, and that it clears the target. -/
theorem candidate_clears : evenSq 12 < 1536 / 715 := by norm_num [evenSq]

/-- The candidate agrees with the printed value to the places printed: it lies strictly
between `1.4657²` rounded down and up. -/
theorem candidate_matches :
    (1.46565 : ℚ) ^ 2 < 1536 / 715 ∧ (1536 : ℚ) / 715 < (1.46575 : ℚ) ^ 2 := by
  constructor <;> norm_num

/-! ## What this settles

**Settled**: that post 26's closure survives its own rounding, by a margin over `40%`
in the square, so the route it closes stays closed however the decimal is refined.

**Not settled here**: the value `max p₃(μ) = 0.977…` itself, which needs the extremal
problem the record does not state at this post; the identification above reproduces the
printed digits and is offered for the record to confirm or reject.
-/

end HamiltonsCubic.F26
