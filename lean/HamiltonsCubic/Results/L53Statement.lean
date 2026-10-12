import Mathlib

set_option linter.style.longLine false

/-!
# L53, the champion split

## The record's statement, verbatim

[bispectral.md](../../../findings/bispectral.md)'s *Observation L53, the champion split*:

> Ascent in a direction $(a,b)$, maximizing $a\,p_3(\mu)+b\,p_3(\omega)$ over $\mathcal W_n$ from
> six starts each:
>
> | direction | what it maximizes | where the ascent lands, $n=6,8,10$ |
> |---|---|---|
> | $(0,-1)$ | the second-kind cubic alone | the **balanced sphere product**, at all three, and at $n=12$ |
> | $(\tfrac32,-\tfrac12)$ | $\theta$ itself | $W_{\mathbb{CP}^2}$, at $\theta^\star=1.224745$ |
> | $(1,0)$ | the $\Lambda^2$ cubic alone | $\theta_0(6)$ at $n=6$; $\mathbb{CP}^4$'s $0.986013$ at $n=8$ |

with, from the same block's Gate 2, the closed forms that *"convert the whole table to closed
form"*:

> $$p_3(\mu)\big|_{\mathbb{CP}^m}=\frac{4m^2+2m-11}{3\sqrt{3m(m^2-1)(2m-1)}},\qquad p_3(\omega)\big|_{\mathbb{CP}^m}=-\frac9{\sqrt{3m(m^2-1)(2m-1)}}.$$

> **ROW 3 DOES NOT IDENTIFY ITS LANDING POINT** [...] At **both** dimensions the $\theta$-value is
> degenerate between two named objects: $\theta_0(6)=\sqrt{10}/3$ is also $\theta(\mathbb{CP}^3)$
> exactly, and $0.986013$ is also $\theta(S^2\times S^6)=\sqrt{35}/6$ exactly.

> **A SENTENCE IN THIS FILE IS REFUTED BY THIS TABLE'S OWN ROW.** *"$W_{\mathbb{CP}^2}$ wins the
> $\Lambda^2$ cubic"* is false: within $\mathbb{CP}^m$, $\theta$ **decreases** in $m$ while
> $p_3(\mu)$ rises to a maximum at $m=6$.

> **THE CHAMPION SPLIT AT $n=6,8,10$ HOLDS WHEREVER $M(n)<\tfrac{13\sqrt{10}}{24}$.** A common
> maximiser of the two extreme directions would need $\theta\ge\tfrac{13\sqrt{10}}{24}=1.7129$,
> above padded $W_{\mathbb{CP}^2}$'s $\sqrt{3/2}$. *The record proves $M(n)\ge\sqrt{3/2}$ and no
> ceiling below $1.7129$ at these dimensions (r649, r1941), so the split is conditional on one.*

## What is NOT typed here

**The observation's own content is a record of six numerical ascents**, and an ascent landing is
not a proposition about `𝒲ₙ` that Lean can carry, it is a report of where a search stopped.
Neither `p₃(μ)` nor `p₃(ω)` can be named either: both are power sums of the spectra of `W` on
`Λ²` and of `W̊` on `S²₀`, and the real Weyl layer ([WeylReal.lean](../Base/WeylReal.lean))
carries `IsWeyl`, `Qop`, `IsCritical`, `Pcubic` and `theta` with no spectral theory and no
second-kind operator. **So the three table rows are absent from this file.**

**The champion-split step is absent.** *"A common maximiser of the two extreme directions would
need `θ ≥ 13√10/24`"* is the substance of that paragraph, and deriving it needs the two
directional maxima over `𝒲₆`, which the block does not record and this file cannot name. What is
typed is the arithmetic the step is spent on (`13√10/24 > √(3/2)`) and **that inequality alone
is not the champion split.**

**`θ(S²×S⁶) = √35/6`** needs the unbalanced sphere-product family. Only the decimal identity
`√35/6 = 0.986013…` is checked below.

**`p₃(μ)` rising to a maximum at `m = 6`** is a comparison across integer `m` that the record
establishes numerically; it is not typed.

## What IS typed here, and it is new to the record

The closed forms **do** convert to a statement about `θ` on the `ℂPᵐ` family, using the
direction `(3/2, −1/2)` the table names as *"what maximizes `θ` itself"*:
`θ = (3/2)p₃(μ) − (1/2)p₃(ω)`. Under that relation the two closed forms collapse to

  `θ(ℂPᵐ) = √( (2m−1)(m+1) / (3m(m−1)) )`,

from which every numeric claim in the block follows exactly: `θ(ℂP²) = √(3/2)`,
`θ(ℂP³) = √10/3 = θ₀(6)` (*the collision the block says row 3 fails to identify*) and the
strict decrease of `θ` in `m`, which is the half of the refuted sentence the block asserts.

## Convention

`θ₀(n) = √(2(n−1)(n−2))/n`, as fixed in
[conventions.md](../../../findings/conventions.md); `p₃(μ)` and `p₃(ω)` in the normalisation of
[bispectral.md](../../../findings/bispectral.md), where `Σμ² = 1` and `Σω² = 3`. The relation
`θ = (3/2)p₃(μ) − (1/2)p₃(ω)` is the block's own direction row and is carried here as a
definition, not derived.
-/

namespace HamiltonsCubic.L53Statement

open Real

/-! ## The two closed forms -/

/-- The radicand shared by both closed forms, `3m(m²−1)(2m−1)`. -/
noncomputable def rad (m : ℝ) : ℝ := 3 * m * (m ^ 2 - 1) * (2 * m - 1)

/-- **`p₃(μ)|_{ℂPᵐ} = (4m²+2m−11)/(3√(3m(m²−1)(2m−1)))`.** -/
noncomputable def p3mu (m : ℝ) : ℝ := (4 * m ^ 2 + 2 * m - 11) / (3 * Real.sqrt (rad m))

/-- **`p₃(ω)|_{ℂPᵐ} = −9/√(3m(m²−1)(2m−1))`.** -/
noncomputable def p3om (m : ℝ) : ℝ := -9 / Real.sqrt (rad m)

/-- **`θ = (3/2)p₃(μ) − (1/2)p₃(ω)`**, the direction the table names as *"what maximizes `θ`
itself"*. -/
noncomputable def thetaCP (m : ℝ) : ℝ := (3 / 2) * p3mu m - (1 / 2) * p3om m

/-- **`θ₀(n) = √(2(n−1)(n−2))/n`.** -/
noncomputable def theta0 (n : ℝ) : ℝ := Real.sqrt (2 * (n - 1) * (n - 2)) / n

/-! ## The radicand is positive on the family -/

theorem rad_pos {m : ℝ} (hm : 2 ≤ m) : 0 < rad m := by
  have h1 : (0:ℝ) < m := by linarith
  have h2 : (0:ℝ) < m ^ 2 - 1 := by nlinarith
  have h3 : (0:ℝ) < 2 * m - 1 := by linarith
  unfold rad; positivity

theorem sqrt_rad_pos {m : ℝ} (hm : 2 ≤ m) : 0 < Real.sqrt (rad m) :=
  Real.sqrt_pos.mpr (rad_pos hm)

/-! ## The collapse to one closed form for `θ`

*The two displays and one direction give `θ` on the whole `ℂPᵐ` family, with no residual
radical beyond a single square root.* -/

/-- **`θ = (2m²+m−1)/√(3m(m²−1)(2m−1))`**, the two closed forms combined. -/
theorem thetaCP_eq {m : ℝ} (hm : 2 ≤ m) :
    thetaCP m = (2 * m ^ 2 + m - 1) / Real.sqrt (rad m) := by
  have hs : Real.sqrt (rad m) ≠ 0 := ne_of_gt (sqrt_rad_pos hm)
  unfold thetaCP p3mu p3om
  field_simp
  ring

/-- **`θ(ℂPᵐ) ≥ 0` on the family.** -/
theorem thetaCP_nonneg {m : ℝ} (hm : 2 ≤ m) : 0 ≤ thetaCP m := by
  rw [thetaCP_eq hm]
  have h1 : (0:ℝ) ≤ 2 * m ^ 2 + m - 1 := by nlinarith
  exact div_nonneg h1 (sqrt_rad_pos hm).le

/-- **`θ(ℂPᵐ)² = (2m−1)(m+1)/(3m(m−1))`**, the whole radical collapses, `(2m²+m−1)` factoring as
`(2m−1)(m+1)` against `rad m = 3m(m−1)(m+1)(2m−1)`. -/
theorem thetaCP_sq {m : ℝ} (hm : 2 ≤ m) :
    thetaCP m ^ 2 = (2 * m - 1) * (m + 1) / (3 * m * (m - 1)) := by
  have hradpos := rad_pos hm
  have hsq : Real.sqrt (rad m) ^ 2 = rad m := Real.sq_sqrt hradpos.le
  have hm0 : (0:ℝ) < m := by linarith
  have hm1 : (0:ℝ) < m - 1 := by linarith
  have hm2 : (0:ℝ) < 2 * m - 1 := by linarith
  have hmp : (0:ℝ) < m + 1 := by linarith
  rw [thetaCP_eq hm, div_pow, hsq]
  unfold rad
  rw [div_eq_div_iff (by positivity) (by positivity)]
  ring

/-- **THE CLOSED FORM.** `θ(ℂPᵐ) = √((2m−1)(m+1)/(3m(m−1)))`. -/
theorem thetaCP_closed {m : ℝ} (hm : 2 ≤ m) :
    thetaCP m = Real.sqrt ((2 * m - 1) * (m + 1) / (3 * m * (m - 1))) := by
  rw [← thetaCP_sq hm, Real.sqrt_sq (thetaCP_nonneg hm)]

/-! ## The two values the block names, exactly -/

/-- **`θ(ℂP²) = √(3/2)`**, which is `M(5) = M(4)`, the conjectured maximiser's value. -/
theorem thetaCP_two : thetaCP 2 = Real.sqrt (3 / 2) := by
  rw [thetaCP_closed (le_refl 2)]
  norm_num

/-- **`θ(ℂP³) = √10/3`.** -/
theorem thetaCP_three : thetaCP 3 = Real.sqrt 10 / 3 := by
  rw [thetaCP_closed (by norm_num)]
  rw [show (2 * (3:ℝ) - 1) * (3 + 1) / (3 * 3 * (3 - 1)) = 10 * (1 / 3 : ℝ) ^ 2 by norm_num,
    Real.sqrt_mul (by norm_num : (0:ℝ) ≤ 10), Real.sqrt_sq (by norm_num : (0:ℝ) ≤ 1 / 3)]
  ring

/-- **`θ₀(6) = √10/3`.** -/
theorem theta0_six : theta0 6 = Real.sqrt 10 / 3 := by
  unfold theta0
  rw [show 2 * ((6:ℝ) - 1) * (6 - 2) = 2 ^ 2 * 10 by norm_num,
    Real.sqrt_mul (by norm_num) 10, Real.sqrt_sq (by norm_num : (0:ℝ) ≤ 2)]
  ring

/-- **THE COLLISION ROW 3 DOES NOT IDENTIFY**: `θ₀(6) = θ(ℂP³)` exactly. *The mathematics forces
`ℂP³` if the ascent worked and records a stall if it landed on `S³×S³`, and the two share this
value.* -/
theorem theta0_six_eq_thetaCP_three : theta0 6 = thetaCP 3 := by
  rw [theta0_six, thetaCP_three]

/-! ## `θ` strictly decreases along the family

*"Within `ℂPᵐ`, `θ` **decreases** in `m`"*, the half of the refuted sentence the block asserts
positively. -/

/-- **The radicand of the closed form strictly decreases**, the whole content of the monotonicity:
`(2y−1)(y+1)·3x(x−1) < (2x−1)(x+1)·3y(y−1)` reduces to `3(y−x)(3xy−x−y+1) > 0`. -/
theorem radicand_strict_anti {x y : ℝ} (hx : 2 ≤ x) (hxy : x < y) :
    (2 * y - 1) * (y + 1) / (3 * y * (y - 1)) < (2 * x - 1) * (x + 1) / (3 * x * (x - 1)) := by
  have hx0 : (0:ℝ) < x := by linarith
  have hx1 : (0:ℝ) < x - 1 := by linarith
  have hy0 : (0:ℝ) < y := by linarith
  have hy1 : (0:ℝ) < y - 1 := by linarith
  rw [div_lt_div_iff₀ (by positivity) (by positivity)]
  nlinarith [mul_pos (sub_pos.mpr hxy) (show (0:ℝ) < 3 * x * y - x - y + 1 by nlinarith)]

/-- **`θ(ℂPᵐ)` is strictly decreasing in `m` on `m ≥ 2`.** -/
theorem thetaCP_strict_anti {x y : ℝ} (hx : 2 ≤ x) (hxy : x < y) : thetaCP y < thetaCP x := by
  have hy : (2:ℝ) ≤ y := le_of_lt (lt_of_le_of_lt hx hxy)
  rw [thetaCP_closed hx, thetaCP_closed hy]
  have hnn : (0:ℝ) ≤ (2 * y - 1) * (y + 1) / (3 * y * (y - 1)) := by
    have hy0 : (0:ℝ) < y := by linarith
    have hy1 : (0:ℝ) < y - 1 := by linarith
    have hnum : (0:ℝ) ≤ (2 * y - 1) * (y + 1) := by nlinarith
    have hden : (0:ℝ) ≤ 3 * y * (y - 1) := by nlinarith
    exact div_nonneg hnum hden
  exact Real.sqrt_lt_sqrt hnn (radicand_strict_anti hx hxy)

/-! ## Two anchors the block quotes as decimals -/

/-- **`p₃(ω)|_{ℂP²} = −√(3/2)` and `p₃(μ)|_{ℂP²} = 1/√6`**, the two closed forms at the
conjectured maximiser. *Their combination is `θ(ℂP²) = √(3/2) = 1.224745`, the table's
`θ⋆`.* -/
theorem cp2_values : p3om 2 = -Real.sqrt (3 / 2) ∧ p3mu 2 = 1 / Real.sqrt 6 := by
  have hrad : rad 2 = 54 := by unfold rad; norm_num
  have h54 : Real.sqrt 54 = 3 * Real.sqrt 6 := by
    rw [show (54:ℝ) = 3 ^ 2 * 6 by norm_num, Real.sqrt_mul (by positivity) 6,
      Real.sqrt_sq (by norm_num : (0:ℝ) ≤ 3)]
  have h6pos : (0:ℝ) < Real.sqrt 6 := Real.sqrt_pos.mpr (by norm_num)
  constructor
  · unfold p3om
    rw [hrad, h54, show (3:ℝ) / 2 = 6 * (1 / 2 : ℝ) ^ 2 by norm_num,
      Real.sqrt_mul (by norm_num : (0:ℝ) ≤ 6), Real.sqrt_sq (by norm_num : (0:ℝ) ≤ 1 / 2)]
    have h6 : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
    field_simp
    nlinarith [h6, h6pos]
  · unfold p3mu
    rw [hrad, h54]
    field_simp
    ring

/-- **`√35/6 = 0.986013…`**, the decimal the block gives for the `n = 8` landing. -/
theorem sqrt35_div6_value :
    |Real.sqrt 35 / 6 - 0.986013| < 1 / 1000000 := by
  have h1 : Real.sqrt 35 ^ 2 = 35 := Real.sq_sqrt (by norm_num)
  have h2 : (0:ℝ) ≤ Real.sqrt 35 := Real.sqrt_nonneg 35
  rw [abs_lt]
  constructor <;> nlinarith

/-! ## The champion split's arithmetic

*"A common maximiser of the two extreme directions would need `θ ≥ 13√10/24 = 1.7129 >
√(3/2) = M(6)`,"* as the block read before r1941; the record proves only `M(6) ≥ √(3/2)`. The implication is not typed (see the heading above); the inequality it is
spent on is. -/

/-- **`13√10/24 > √(3/2)`.** *This is the arithmetic the champion split consumes, and it is not
the champion split: the step that produces `13√10/24` from a common maximiser is absent.* -/
theorem champion_constant_gt_M6 : Real.sqrt (3 / 2) < 13 * Real.sqrt 10 / 24 := by
  have h10 : Real.sqrt 10 ^ 2 = 10 := Real.sq_sqrt (by norm_num)
  have h10n : (0:ℝ) ≤ Real.sqrt 10 := Real.sqrt_nonneg 10
  have h32 : Real.sqrt (3 / 2) ^ 2 = 3 / 2 := Real.sq_sqrt (by norm_num)
  have h32n : (0:ℝ) ≤ Real.sqrt (3 / 2) := Real.sqrt_nonneg _
  nlinarith [h10, h32, h10n, h32n]

/-- **`13√10/24 = 1.7129…`**, the decimal the block prints. -/
theorem champion_constant_value : |13 * Real.sqrt 10 / 24 - 1.7129| < 1 / 10000 := by
  have h1 : Real.sqrt 10 ^ 2 = 10 := Real.sq_sqrt (by norm_num)
  have h2 : (0:ℝ) ≤ Real.sqrt 10 := Real.sqrt_nonneg 10
  rw [abs_lt]
  constructor <;> nlinarith

/-! ## Non-vacuity

`m = 2` is in range, so the family is not empty and every statement above has a point. -/

/-- **A witness**: at `m = 2` the radicand is `54 > 0`, `θ(ℂP²) = √(3/2)`, and the family is
strictly decreasing from there, `θ(ℂP³) < θ(ℂP²)`. -/
example : rad 2 = 54 ∧ thetaCP 2 = Real.sqrt (3 / 2) ∧ thetaCP 3 < thetaCP 2 := by
  refine ⟨by unfold rad; norm_num, thetaCP_two, thetaCP_strict_anti (le_refl 2) (by norm_num)⟩

end HamiltonsCubic.L53Statement
