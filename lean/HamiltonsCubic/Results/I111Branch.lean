import Mathlib

set_option linter.style.longLine false

/-!
# I111: why the `+` branch gives exactly nothing at the Gram boundary

[the I104 note](../../../reviews/2026-09-14-I104-tau-positive.md) screens step 8's second link
across the surviving region and finds the `+` branch's gain crossing the deficit at
`s_c = 0.4261220` and reaching `0` at the Gram boundary `s_*`. **That vanishing is an identity,
not a numerical coincidence**, and this file types it.

The gain is `(1/√3 - x/u) · u(t - u²)`, so it vanishes exactly when `x/u = 1/√3`. With
[r1059](../../../reviews/REVIEW_r1059.md)'s forcing `Σ xᵢ² ≥ (3u² - t)/1.2` at equal `xᵢ`,
`x² = (3u² - t)/3.6`.

## What is proved

* `ratio_sq`: `(x/u)² = 5/6 - 5t/(18u²)`, from the forcing alone.
* `ratio_sq_at_gram`: on the Gram boundary `u² = 5t/9` that is exactly `1/3`.

**WHAT THIS FILE DOES NOT ESTABLISH**: that `u = u_lo` at every surviving configuration. That was
claimed and is refuted. `norm_expand`, `g_closed_form` and `g_at_uLo` are sound algebra and
`g_closed_form` restates L220 step 5 rather than adding to it.

**So the forcing pins `x/u` to `1/√3` precisely where the Gram bound is attained, and the gain it
licenses is exactly zero there.** *The `+` branch is therefore not weak at the corner by accident:
the corner is where the forcing is saturated.*

## What is NOT stated

That the gain has this form, that `x` is the shared-pair coefficient, or anything about the four-set
geometry. These are the two scalar steps the screen turns on.
-/

namespace HamiltonsCubic.I111Branch

/-- `(x/u)²` from [r1059](../../../reviews/REVIEW_r1059.md)'s forcing at equal `xᵢ`, where
`x² = (3u² - t)/3.6`. -/
theorem ratio_sq (t u : ℝ) (hu : u ≠ 0) :
    ((3 * u ^ 2 - t) / (18 / 5)) / u ^ 2 = 5 / 6 - 5 * t / (18 * u ^ 2) := by
  field_simp
  ring

/-- **On the Gram boundary the forcing pins the ratio to `1/3`, so `x/u = 1/√3` exactly.**

*That is why the `+` branch's gain `(1/√3 - x/u) u(t - u²)` is exactly `0` at `s_*`: the corner is
where the forcing saturates, rather than a point where the estimate happens to be weak.* -/
theorem ratio_sq_at_gram (t u : ℝ) (hu : u ≠ 0) (hgram : u ^ 2 = 5 * t / 9) :
    ((3 * u ^ 2 - t) / (18 / 5)) / u ^ 2 = 1 / 3 := by
  rw [ratio_sq t u hu, hgram]
  have ht : t ≠ 0 := by
    intro h; apply hu
    have : u ^ 2 = 0 := by rw [hgram, h]; ring
    exact pow_eq_zero_iff two_ne_zero |>.mp this
  field_simp
  ring

/-! ## The norm constraint pins `u` to `u_lo`

With `ν = cos β f₊ + sin β f₋` in `L_q`'s `±e` eigenbasis, `e = √3 u/2`, pairing the block
equation with `ν` gives `cos 2β = u_lo/u`. Taking its NORM then gives a quantity whose whole
`β`-dependence cancels. -/

/-- **The norm of the block equation's left side, per unit `N`.** `(θ-2e)²cos²β + (θ+2e)²sin²β`
expands to `θ² + 4e² - 4θe cos 2β`, with no cross term surviving. -/
theorem norm_expand (θ e cb sb : ℝ) (hpy : cb ^ 2 + sb ^ 2 = 1) :
    (θ - 2 * e) ^ 2 * cb ^ 2 + (θ + 2 * e) ^ 2 * sb ^ 2
      = θ ^ 2 + 4 * e ^ 2 - 4 * θ * e * (cb ^ 2 - sb ^ 2) := by
  have h : cb ^ 2 = 1 - sb ^ 2 := by linarith
  rw [h]; ring

/-- **THE CANCELLATION.** Substituting `e = √3u/2` and `cos 2β = u_lo/u` removes `u` from the
cross term, leaving `g(u) = θ² + 3u² - 2√3 θ u_lo`.

*So `g` depends on `u` only through `3u²`, which is what pins `u`.* -/
theorem g_closed_form (θ u L r3 : ℝ) (hu : u ≠ 0) (hr3 : r3 ^ 2 = 3) :
    θ ^ 2 + 4 * (r3 * u / 2) ^ 2 - 4 * θ * (r3 * u / 2) * (L / u)
      = θ ^ 2 + 3 * u ^ 2 - 2 * r3 * θ * L := by
  field_simp
  nlinarith [hr3, sq_nonneg u]

/-- **`g` at `u = u_lo` is exactly `(θ - √3 u_lo)²`**, which `coeff_at_uLo` identifies with `s²`,
which is `N`. -/
theorem g_at_uLo (θ L r3 : ℝ) (hr3 : r3 ^ 2 = 3) :
    θ ^ 2 + 3 * L ^ 2 - 2 * r3 * θ * L = (θ - r3 * L) ^ 2 := by
  nlinarith [hr3]

/-- **Monotonicity of `g`, stated as an implication.** From `g(u) ≤ g(L)` and `L ≤ u` it follows
that `u = L`.

**THIS IS NOT THE PINNING THE PROSE ONCE CLAIMED**, and the claim that `u = u_lo` is forced at every
surviving configuration is REFUTED ([r1067](../../../reviews/REVIEW_r1067.md),
[r1068](../../../reviews/REVIEW_r1068.md)). *The hypothesis `hbound` is exactly where `τ = s³/2`
hides: carrying `τ` free, the gap between the norm test and criticality is `(NₐN_bN_c - 4τ²)/Nₐ²`,
the product bound written as a width, which vanishes only when `τ` saturates. So `hbound` assumes
what the pinning was meant to prove.* **`L` here is a free variable, and the prose used one symbol
for two different lower bounds.** -/
theorem u_eq_uLo (θ u L r3 : ℝ) (hL : 0 < L) (hu : L ≤ u) (hr3 : r3 ^ 2 = 3)
    (hbound : θ ^ 2 + 3 * u ^ 2 - 2 * r3 * θ * L ≤ (θ - r3 * L) ^ 2) : u = L := by
  have h : 3 * u ^ 2 ≤ 3 * L ^ 2 := by nlinarith [hr3]
  nlinarith [hu, hL, h]

/-- **THE WIDTH IS THE PRODUCT BOUND.** The norm test's upper bound on `3u²` minus criticality's
lower bound is exactly `(Nₐ N_b N_c - 4τ²)/Nₐ²`.

*So the two constraints the withdrawn argument played against each other differ by the product
bound `|τ| ≤ √(Nₐ N_b N_c)/2` written as a width, and it vanishes exactly when `τ` saturates.*
**That is why the pin appeared: it is the equality case of a bound on `τ`, read as a statement
about `u`.** ([r1067](../../../reviews/REVIEW_r1067.md), whose form needs neither the equal-`Nᵢ`
diagonal nor `θ² = 3/2`.) -/
theorem width_is_product_bound (θ τ Na Nb Nc : ℝ) (hNa : Na ≠ 0) :
    (Nb * Nc / Na + θ ^ 2 - 4 * θ * τ / Na) - (θ - 2 * τ / Na) ^ 2
      = (Na * Nb * Nc - 4 * τ ^ 2) / Na ^ 2 := by
  field_simp
  ring

/-- **The band, when `τ` does not saturate.** Writing `τ = f·s³/2` on the equal diagonal,
`g(u_lo(f)) = f²N`, so `g ≤ N` permits `u² ≤ u_lo(f)² + s²(1-f²)/3`.

*It collapses to a point at `f = 1` and nowhere else, and the surviving set reaches `f ≈ 0.8917`
by this record's own earlier derivation.* -/
theorem band_width (θ s f r3 : ℝ) (hr3 : r3 ^ 2 = 3) :
    (θ - r3 * ((θ - f * s) / r3)) ^ 2 = (f * s) ^ 2 ∧
      ((f * s) ^ 2 - s ^ 2) / 3 = -(s ^ 2 * (1 - f ^ 2) / 3) := by
  have h3 : r3 ≠ 0 := by intro h; rw [h] at hr3; norm_num at hr3
  constructor
  · field_simp; ring
  · ring

end HamiltonsCubic.I111Branch
