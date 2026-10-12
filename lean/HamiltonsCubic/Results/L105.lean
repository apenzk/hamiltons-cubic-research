import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L105, the dimension cap, and what `t₁₁₂ = 0` buys

[bounds-relaxations.md](../../../findings/bounds-relaxations.md)'s Lemma L105. The audit says the block is
understated and that **the dimension cap needs `t₁₁₂ = 0`**, since `T ≥ 0` alone gives only
`r ≤ 8` at `n = 6` against the true `r ≤ 6`.

**That gap is not two integers, it is the difference between clearing `3/2` and not.**
Through [L23](../../../results.md)'s closed form `θ² = (4/n²)·rN/(N-r)` with `N = C(n,2)`, at
`n = 6`:

* `r = 6` gives `θ² = 10/9`, which is `θ₀(6)²` and **below** `3/2`;
* `r = 8` gives `θ² = 40/21`, which is **above** `3/2`.

So the weaker cap admits points over the target and the stronger does not: `t₁₁₂ = 0` is
load-bearing for the bound, not merely for the count. The audit reports the two caps and
leaves that consequence unstated. **And the bite is at one value, not two**: `r = 7` gives
`35/24 < 3/2` and stays under, so only `r = 8` breaks the target.

**And `S_{𝔪𝔪𝔪} = (N-r)(N-r-1)(N-r-2)·t₂₂₂` is a falling factorial**, so it vanishes exactly
when `N - r ≤ 2`. In the admissible range at `n = 6` we have `N - r ≥ 9`, so it is nonzero
throughout, the sum-of-squares structure is non-degenerate where the lemma lives.
-/

namespace HamiltonsCubic.DimensionCap

/-- `N = C(n,2)`. -/
def N (n : ℚ) : ℚ := n * (n - 1) / 2

/-- [L23](../../../results.md)'s closed form `θ² = (4/n²)·rN/(N-r)`. -/
def thetaSq (n r : ℚ) : ℚ := 4 / n ^ 2 * (r * N n / (N n - r))

/-! ## The two caps at `n = 6` -/

theorem N_six : N 6 = 15 := by unfold N; norm_num

/-- **The true cap `r ≤ 6` gives `θ² = 10/9`**, which is `θ₀(6)²`. -/
theorem theta_at_six : thetaSq 6 6 = 10 / 9 := by unfold thetaSq N; norm_num

/-- **The weaker cap `r ≤ 8` reaches `θ² = 40/21`.** -/
theorem theta_at_eight : thetaSq 6 8 = 40 / 21 := by unfold thetaSq N; norm_num

/-- **And `3/2` lies strictly between them**, so the cap decides whether the bound clears the
target, not merely how many values `r` may take. -/
theorem cap_decides_the_bound : (10 : ℚ) / 9 < 3 / 2 ∧ (3 : ℚ) / 2 < 40 / 21 := by
  constructor <;> norm_num

/-- The gap in `r` is two values, `7` and `8`. -/
theorem gap_values : (8 : ℕ) - 6 = 2 := by decide

/-- **`r = 7` does not break the target**: `θ² = 35/24 < 3/2`. So of the two values the
weaker cap admits, **only `r = 8` exceeds it**, the cap difference bites at exactly one
value, which is sharper than "two values". -/
theorem seven_still_under : thetaSq 6 7 = 35 / 24 ∧ (35 : ℚ) / 24 < 3 / 2 := by
  refine ⟨by unfold thetaSq N; norm_num, by norm_num⟩

/-! ## `θ²` is increasing in `r`, which is why the cap is the whole content -/

/-- **`θ²` is strictly increasing in `r`** below `N`, so a looser cap is strictly weaker and
the two caps cannot agree on the supremum. -/
theorem theta_mono {n r r' : ℚ} (hn : 0 < n) (hr : 0 < r) (hlt : r < r') (hhi : r' < N n) :
    thetaSq n r < thetaSq n r' := by
  unfold thetaSq
  have hN : 0 < N n := by unfold N at hhi ⊢; linarith
  have h1 : 0 < N n - r := by linarith
  have h2 : 0 < N n - r' := by linarith
  have hcoef : 0 < 4 / n ^ 2 := div_pos (by norm_num) (by positivity)
  apply mul_lt_mul_of_pos_left _ hcoef
  rw [div_lt_div_iff₀ h1 h2]
  nlinarith [hlt, hN, mul_pos hN hN]

/-! ## The falling factorial -/

/-- **`S_{𝔪𝔪𝔪}`'s coefficient vanishes exactly when `N - r ≤ 2`.** -/
theorem falling_zero (k : ℚ) (h : k = 0 ∨ k = 1 ∨ k = 2) : k * (k - 1) * (k - 2) = 0 := by
  rcases h with h | h | h <;> rw [h] <;> ring

/-- **And it is positive from `N - r ≥ 3` on**, so the structure is non-degenerate in the
admissible range, at `n = 6` with `r ≤ 6` we have `N - r ≥ 9`. -/
theorem falling_pos (k : ℚ) (hk : 3 ≤ k) : 0 < k * (k - 1) * (k - 2) := by
  have h0 : (0:ℚ) < k := by linarith
  have h1 : (0:ℚ) < k - 1 := by linarith
  have h2 : (0:ℚ) < k - 2 := by linarith
  exact mul_pos (mul_pos h0 h1) h2

theorem admissible_gap : (15 : ℚ) - 6 = 9 ∧ (3 : ℚ) ≤ 9 := by
  constructor <;> norm_num

end HamiltonsCubic.DimensionCap
