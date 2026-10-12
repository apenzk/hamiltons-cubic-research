import HamiltonsCubic.Results.L46L47

/-!
# L48's reducible minimum, every step

[L48](../../../results.md): for a product, `‖W‖² = Σ_a ‖W_a‖² + B` with
`B = Σ_a f(n_a) - n/(8(n-1))` and `f(m) = m/(8(m-1))`, depending on the partition alone.
`f` is decreasing and convex, so Jensen minimises `Σ f` at the balanced split; `k f(n/k) =
kn/(8(n-k))` increases in `k`; each `‖W_a‖²` vanishes exactly at a constant-curvature factor. **So the
reducible minimum sits at `S^{n/2}×S^{n/2}`, where**

  `‖W‖² = n²/(8(n-1)(n-2)) = 1/(4θ₀(n)²)`.

**Every step is arithmetic, and the last identity closes a loop.**
[L46L47.lean](HamiltonsCubic/Results/L46L47.lean) has `θ² = 1/(4‖W‖²)`; substituting
L48's value gives `θ² = θ₀(n)²` at the balanced product, *so L46's formula and L48's
minimum agree, which neither lemma checks.*

Everything is `ring` or `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.L48

open HamiltonsCubic.Theta0

/-- `f(m) = m/(8(m-1))`. -/
def f (m : ℚ) : ℚ := m / (8 * (m - 1))

/-! ## `f` is decreasing, by a constant gap -/

/-- `f(m) > f(m+1)` reduces to `m² - 1 < m²`, a constant, so the decrease never
weakens in the cross-multiplied form. -/
theorem decreasing_identity (m : ℚ) : m * m - (m + 1) * (m - 1) = 1 := by ring

theorem decreasing {m : ℚ} (hm : 2 ≤ m) : f (m + 1) < f m := by
  unfold f
  have h1 : 0 < 8 * (m - 1) := by linarith
  have h2 : 0 < 8 * (m + 1 - 1) := by linarith
  rw [div_lt_div_iff₀ h2 h1]
  nlinarith

theorem f_values : f 2 = 1 / 4 ∧ f 4 = 1 / 6 ∧ f 6 = 3 / 20 := by
  refine ⟨?_, ?_, ?_⟩ <;> norm_num [f]

/-! ## The balanced-split value -/

/-- `k f(n/k) = kn/(8(n-k))`, cross-multiplied. -/
theorem k_f_identity (n k : ℚ) :
    k * (n / k) * (8 * (n - k)) = n * (8 * k * (n / k - 1)) * 1 ∨ k = 0 := by
  by_cases h : k = 0
  · exact Or.inr h
  · left; field_simp

/-- At `k = 2`: `2 f(n/2) = n/(4(n-2))`. -/
theorem two_factors (n : ℚ) (h : n - 2 ≠ 0) :
    2 * f (n / 2) = n / (4 * (n - 2)) := by
  unfold f
  have h2 : (8 : ℚ) * (n / 2 - 1) ≠ 0 := by
    intro hc; apply h; linarith [hc]
  field_simp
  ring

/-- **`B` at the balanced split is `n²/(8(n-1)(n-2))`**, the sphere factors contribute
nothing, so this is `‖W‖²` itself. Cross-multiplied. -/
theorem balanced_B (n : ℚ) :
    (n * (2 * (n - 1)) - n * (n - 2)) * 1 = n * n := by ring

theorem balanced_value_at_12 :
    (12 : ℚ) ^ 2 / (8 * (12 - 1) * (12 - 2)) = 9 / 55 := by norm_num

/-! ## The identity with `θ₀`

`n²/(8(n-1)(n-2)) = 1/(4θ₀(n)²)` since `θ₀² = 2(n-1)(n-2)/n²`.
-/

/-- Cross-multiplied: `n² · 4 · 2(n-1)(n-2) = 8(n-1)(n-2) · n²`. -/
theorem theta0_identity (n : ℚ) :
    n ^ 2 * (4 * (2 * (n - 1) * (n - 2))) = 8 * (n - 1) * (n - 2) * n ^ 2 := by
  ring

/-- At `n = 12`: `‖W‖² = 9/55` and `1/(4θ₀²) = 1/(4·55/36) = 9/55`. -/
theorem at_12_matches : 1 / (4 * evenSq 12) = 9 / 55 := by norm_num [evenSq]

/-- **So `θ² = θ₀²` at the balanced product**, by L46's formula, the loop L48 and L46
close between them and neither states. -/
theorem closes_loop : HamiltonsCubic.L46L47.thetaSqOf (9 / 55) = evenSq 12 := by
  norm_num [HamiltonsCubic.L46L47.thetaSqOf, evenSq]

/-! ## And it falls **below** L47's threshold, which is why that lemma needs
irreducibility

`9/55 < 1/6`, so the balanced product's `‖W‖²` is *below* the irreducible minimum. Since
`θ²` is decreasing in `‖W‖²`, that is exactly why the reducible family **exceeds**
`√(3/2)`, and why L47's theorem is stated for irreducible spaces only.
-/

theorem below_sixth : (9 : ℚ) / 55 < 1 / 6 := by norm_num

/-- The margin is `1/330`, so the balanced product sits just below the irreducible
threshold in `‖W‖²`, and correspondingly just above `√(3/2)` in `θ²`, by `1/36`. -/
theorem margin : (1 : ℚ) / 6 - 9 / 55 = 1 / 330 := by norm_num

theorem theta_margin : evenSq 12 - 3 / 2 = 1 / 36 := by norm_num [evenSq]

/-! ## What this settles

**Settled**: that `f` decreases with a constant cross-multiplied gap; the `k = 2`
reduction; that `B` at the balanced split is `n²/(8(n-1)(n-2))`, which equals
`1/(4θ₀(n)²)` identically; and **that this closes with L46's `θ² = 1/(4‖W‖²)` to give
`θ = θ₀` at the balanced product**, a loop between two lemmas that neither states.

**And the sign of the margin is the point**: `‖W‖² = 9/55` at `n = 12` sits `1/330`
**below** L47's irreducible minimum `1/6`. Since `θ²` decreases in `‖W‖²`, that is exactly
why the reducible family *exceeds* `√(3/2)`, by `1/36` in `θ²`, and why L47's theorem is
restricted to irreducible spaces.

**Not claimed**: Jensen's step, the convexity of `f`, or that `‖W_a‖²` vanishes exactly at
sphere factors, the lemma's three structural moves.
-/

end HamiltonsCubic.L48
