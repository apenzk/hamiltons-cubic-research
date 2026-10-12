import Mathlib

/-!
# L22, the estimate the localization theorem needs, STATED in the part that is statable

[route-a.md](../../../findings/route-a.md)'s Observation L22, quoted verbatim from
[results.md](../../../results.md)'s canonical statement:

> Nienhaus's localization theorem holds for `10 ≤ n ≤ 11`, and what stops it above `11` is a
> single estimate inside his Theorem 4.17, which he states and records that he could not supply.
> **At `n = 12,14,16` that estimate holds, conditionally**: at the maximiser of the inner problem
> the configuration is forced, so both couplings are evaluated at one pair, the inner
> maximisation is a hard-case trust-region problem with a closed-form frontier, and two branches
> cover complementary intervals of the parameter at every `n`. **Lemma L20's bootstrap does not
> consume it.**

The estimate itself, as the block displays it:

> `γ_max(α) < (3 − 5α)/√3` for every `α < 1/3`.

and the closed-form frontier:

> `V(t) = √(5/6)` for `t ≤ t*`, `= 5/(16t) + 2t/3` for `t > t*`, with `t* = ¾√(5/6) = √30/8`.

## What is NOT typed here

**`γ_max` itself, and therefore the estimate as a free-standing claim.** `γ_max(α)` is the
maximum of `√(2/3) P(W)` over the unit sphere of a subspace cut out at the padded competitor by
the linearisation `F_u` of `Q`, it needs `𝒲ₙ`, `Q`, `F_u`, its `⅓θ*`-eigenspace and `ker F_u`,
none of which has a Lean base layer here. **Stating the estimate against an abstract `γ_max`
would produce a proposition true of no particular function and false of many**, so what is typed
instead is the chain the block runs on:

* the requirement and the frontier, defined exactly as displayed;
* `requirement_of_frontier_bound`, **the block's own reduction**, that an upper bound on
  `γ_max(α)` of the frontier shape, together with positivity of `H_θ`, gives the requirement.
  *This is the step the record describes as "multiplying `γ_max(α) < (3−5α)/√3` through by
  `√(3/2)`", and it is proved;*
* the exact algebra the audit certifies, *"the displayed algebra is exact and stands; `α* =
  32/141` and the tangential meeting of `V(t)`'s branches at `t* = √30/8` were re-derived at
  audit"*, all of it proved below;
* `H_pos_on_cubic_piece`, the frontier branch's coverage claim, proved by a one-point certificate
  on the cubic `Ψ_{√2}`.

**The other branch is Nienhaus's own bound, and the record states it has no closed form**, so the
overlap of the two branches, *"unchecked; neither coverage endpoint has a closed form on the
record"* on Nienhaus's side, is not typed either.

## What the estimate is conditional on, and it is not a formality

The record grades this block an `Observation` at `n = 12,14,16` and names the reasons: the
vanishing `M_{W₁}·Π_ker Q(W₁) = 0` that makes the inner maximisation a hard case is **measured**
at those three dimensions ([Observation L102](../../../findings/route-a.md)); the two suprema
`√(5/6)` and `2/3` were measured at `n = 10`, below the range they cap; and **both branches take
`sup{P(K) : K ∈ ker F_u, ‖K‖ = 1} ≤ θ₀(n)` as their constant**, which carries Conjecture A's
inequality half on a proper subspace. `θ` below is that constant, and it is a free parameter
here for exactly that reason.
-/

set_option linter.style.longLine false
set_option linter.unusedVariables false

namespace HamiltonsCubic.L22Statement

/-! ## The requirement, the frontier, and the two branch points -/

/-- `t* = ¾√(5/6) = √30/8`, where the frontier's two branches meet. -/
noncomputable def tStar : ℝ := Real.sqrt 30 / 8

/-- `σ* = √(15/47)`, the branch point in the `σ` variable, `σ² = 1 − 3α`. -/
noncomputable def sigmaStar : ℝ := Real.sqrt (15 / 47)

/-- `α* = 32/141`, where `V`'s two branches meet, **the point below which `B > 0`, and NOT
where the frontier branch stops covering.** *The record files that misreading as its own.* -/
noncomputable def alphaStar : ℝ := 32 / 141

/-- **The requirement**: `γ_max(α) < (3 − 5α)/√3` for every `α < ⅓`. This is its right side. -/
noncomputable def requirement (α : ℝ) : ℝ := (3 - 5 * α) / Real.sqrt 3

/-- **The closed-form frontier** `V(t)`, the value of the inner maximisation. -/
noncomputable def V (t : ℝ) : ℝ :=
  if t ≤ tStar then Real.sqrt (5 / 6) else 5 / (16 * t) + 2 * t / 3

/-- **`H_θ(σ)`, the requirement's slack after the change of variable `σ² = 1 − 3α`**, with
`c = √(1−σ²)` and `t = σ/c`. *It is a **lower** bound on the slack, the quantity subtracted being
an upper bound on `γ_max`: `H_θ > 0` certifies the requirement, and `H_θ ≤ 0` shows only that
this bound does not deliver it.* -/
noncomputable def H (θ σ : ℝ) : ℝ :=
  (4 + 5 * σ ^ 2) / (3 * Real.sqrt 2)
    - 3 * (1 - σ ^ 2) * σ * V (σ / Real.sqrt (1 - σ ^ 2)) - θ * σ ^ 3

/-! ## The exact algebra, which the audit certifies and which is proved here -/

/-- `t*² = 15/32`, which is `(5/16)/(2/3)`, the minimiser of `a/t + bt`. -/
theorem tStar_sq : tStar ^ 2 = 15 / 32 := by
  unfold tStar
  rw [div_pow, Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 30)]
  norm_num

/-- **The frontier branch never falls below `√(5/6)`**: `5/(16t) + 2t/3 ≥ √(5/6)` for `t > 0`. -/
theorem frontier_branch_ge {t : ℝ} (ht : 0 < t) : Real.sqrt (5 / 6) ≤ 5 / (16 * t) + 2 * t / 3 := by
  have ha : Real.sqrt (5 / 6) ^ 2 = 5 / 6 := Real.sq_sqrt (by norm_num)
  have hpos : 0 ≤ Real.sqrt (5 / 6) := Real.sqrt_nonneg _
  rw [div_add_div _ _ (by positivity) (by norm_num), le_div_iff₀ (by positivity)]
  nlinarith [sq_nonneg (t - 3 * Real.sqrt (5 / 6) / 4)]

/-- **And it meets the constant branch exactly at `t*`**, with the common value `√(5/6)`, so
the two branches meet with **zero slope**, `t*` being the minimiser. -/
theorem frontier_at_tStar : 5 / (16 * tStar) + 2 * tStar / 3 = Real.sqrt (5 / 6) := by
  have h30 : Real.sqrt 30 ^ 2 = 30 := Real.sq_sqrt (by norm_num)
  have h30pos : (0:ℝ) < Real.sqrt 30 := Real.sqrt_pos.mpr (by norm_num)
  have hval : Real.sqrt (5 / 6) = Real.sqrt 30 / 6 := by
    rw [show (5:ℝ) / 6 = (Real.sqrt 30 / 6) ^ 2 by rw [div_pow, h30]; norm_num]
    exact Real.sqrt_sq (by positivity)
  rw [hval]
  unfold tStar
  field_simp
  nlinarith [h30, h30pos]

/-- **`V(1) = 47/48`**, against a minimum of `√(5/6)`, the record's own reading of how far the
frontier rises. -/
theorem V_at_one : V 1 = 47 / 48 := by
  have h30 : Real.sqrt 30 < 8 := by
    nlinarith [Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 30), Real.sqrt_nonneg (30:ℝ)]
  have hlt : ¬ ((1:ℝ) ≤ tStar) := by
    unfold tStar; intro h; linarith
  unfold V
  rw [if_neg hlt]
  norm_num

/-- **`V` is neither the minimum nor the maximum of its two branches.** Below `t*` the frontier
branch also exceeds `√(5/6)` (at `t = 1/2` it is `23/24`) and `V` does not follow it. -/
theorem V_neither_min_nor_max :
    V (1 / 2) = Real.sqrt (5 / 6) ∧ Real.sqrt (5 / 6) < 5 / (16 * (1 / 2)) + 2 * (1 / 2) / 3 := by
  have h30 : (4:ℝ) < Real.sqrt 30 := by
    nlinarith [Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 30), Real.sqrt_nonneg (30:ℝ)]
  have hle : (1:ℝ) / 2 ≤ tStar := by unfold tStar; linarith
  constructor
  · unfold V; rw [if_pos hle]
  · have hb : Real.sqrt (5 / 6) < 23 / 24 := by
      nlinarith [Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 5 / 6), Real.sqrt_nonneg (5 / 6 : ℝ)]
    have hv : (5:ℝ) / (16 * (1 / 2)) + 2 * (1 / 2) / 3 = 23 / 24 := by norm_num
    rw [hv]
    exact hb

/-- **`α*` is recovered rather than assumed.** `σ*² = t*²/(1 + t*²) = 15/47`, hence
`α* = ⅓(1 − 15/47) = 32/141`. -/
theorem alphaStar_recovered :
    sigmaStar ^ 2 = tStar ^ 2 / (1 + tStar ^ 2) ∧ alphaStar = (1 - sigmaStar ^ 2) / 3 := by
  have hs : sigmaStar ^ 2 = 15 / 47 := by
    unfold sigmaStar; exact Real.sq_sqrt (by norm_num)
  constructor
  · rw [hs, tStar_sq]; norm_num
  · rw [hs]; unfold alphaStar; norm_num

/-- **The requirement at `α = ⅓`** reads `4/(3√3)`, which is what Nienhaus's own bound returns,
borderline by construction, which is why the larger constant forced above `n = 11` breaks it,
and only near `⅓`. -/
theorem requirement_at_third : requirement (1 / 3) = 4 / (3 * Real.sqrt 3) := by
  unfold requirement
  rw [show (3:ℝ) - 5 * (1 / 3) = 4 / 3 by norm_num]
  field_simp

/-! ## The block's reduction, proved

*"Multiplying `γ_max(α) < (3−5α)/√3` through by `√(3/2)`"*, the step that turns the requirement
into `H_θ > 0`, run in the direction that certifies. -/

/-- **The requirement follows from `H_θ > 0`.** If `γ_max(α)` is bounded above by the frontier
expression `√(2/3)(3c²σ V(t) + θσ³)` at the corresponding `σ`, and `H_θ(σ) > 0`, then the
requirement holds at `α`.

*The upper bound is a hypothesis because it is what the record's own chain supplies,
`P(W) = 3c²σ[A + tB] + σ³P(K)` with `V(t) = max_K[A + tB]` and `P(K) ≤ θ`. Its conclusion is the
requirement, and nothing in the binder is the requirement.* -/
theorem requirement_of_frontier_bound (gammaMax : ℝ → ℝ) (α σ θ : ℝ)
    (hσ : σ ^ 2 = 1 - 3 * α)
    (hub : gammaMax α ≤ Real.sqrt (2 / 3) *
      (3 * (1 - σ ^ 2) * σ * V (σ / Real.sqrt (1 - σ ^ 2)) + θ * σ ^ 3))
    (hH : 0 < H θ σ) : gammaMax α < requirement α := by
  have h2 : (0:ℝ) < Real.sqrt 2 := Real.sqrt_pos.mpr (by norm_num)
  have h3 : (0:ℝ) < Real.sqrt 3 := Real.sqrt_pos.mpr (by norm_num)
  have h23 : (0:ℝ) < Real.sqrt (2 / 3) := Real.sqrt_pos.mpr (by norm_num)
  have hmul : Real.sqrt (2 / 3) * Real.sqrt 3 = Real.sqrt 2 := by
    rw [← Real.sqrt_mul (by norm_num : (0:ℝ) ≤ 2 / 3)]
    norm_num
  set X : ℝ := 3 * (1 - σ ^ 2) * σ * V (σ / Real.sqrt (1 - σ ^ 2)) + θ * σ ^ 3 with hX
  have hXlt : X < (4 + 5 * σ ^ 2) / (3 * Real.sqrt 2) := by
    unfold H at hH; rw [hX]; linarith
  have hstep : Real.sqrt (2 / 3) * X < Real.sqrt (2 / 3) * ((4 + 5 * σ ^ 2) / (3 * Real.sqrt 2)) :=
    mul_lt_mul_of_pos_left hXlt h23
  have hreq : requirement α = (4 + 5 * σ ^ 2) / (3 * Real.sqrt 3) := by
    unfold requirement
    have hα : α = (1 - σ ^ 2) / 3 := by linarith
    rw [hα]
    field_simp
    ring
  have hkey : Real.sqrt (2 / 3) * ((4 + 5 * σ ^ 2) / (3 * Real.sqrt 2))
      = (4 + 5 * σ ^ 2) / (3 * Real.sqrt 3) := by
    field_simp
    nlinarith [hmul, h2, h3, h23]
  rw [hreq]
  calc gammaMax α ≤ Real.sqrt (2 / 3) * X := hub
    _ < Real.sqrt (2 / 3) * ((4 + 5 * σ ^ 2) / (3 * Real.sqrt 2)) := hstep
    _ = (4 + 5 * σ ^ 2) / (3 * Real.sqrt 3) := hkey

/-! ## The frontier branch's coverage, stated

The half of L22's *"two branches cover complementary intervals"* that has a closed form. The
other half is Nienhaus's own bound, which the record says has no closed form on file. -/

/-- **The cubic piece.** For every constant `θ ≤ √2`, which both parities satisfy strictly,
`θ₀(n)² = 2 − 2(3n−2)/n² < 2`, the slack `H_θ` is positive on `[0, σ*]`, so the requirement
holds for every `α ∈ [32/141, ⅓)`.

**Proved.** On `[0, σ*]` the argument of `V` stays at or below `t*`, so `V = √(5/6)` and
`3√2 H_θ` is exactly the record's cubic `Ψ_θ(σ) = (3√15 − 3√2 θ)σ³ + 5σ² − 3√15 σ + 4`, the step
resting on `√2 · √(5/6) = √15/3`. `θ ≤ √2` bounds it below by `Ψ_{√2}`, and replacing `√15` by
the rational `3873/1000` above it leaves a cubic whose minimum on `σ ≥ 0` is `0.0389…`, attained
at `σ ≈ 0.585 > σ*`, closed by `nlinarith` from `σ(σ − 117/200)² ≥ 0`. *The record's
discriminant argument is replaced by this one-point certificate.* -/
theorem H_pos_on_cubic_piece (θ σ : ℝ) (hθ : θ ≤ Real.sqrt 2) (h0 : 0 ≤ σ)
    (hs : σ ≤ sigmaStar) : 0 < H θ σ := by
  have hσ2 : σ ^ 2 ≤ 15 / 47 := by
    have h1 : sigmaStar ^ 2 = 15 / 47 := by unfold sigmaStar; rw [Real.sq_sqrt (by norm_num)]
    nlinarith [pow_le_pow_left₀ h0 hs 2]
  have hc : 0 < 1 - σ ^ 2 := by linarith
  -- the frontier is flat on this range
  have hV : V (σ / Real.sqrt (1 - σ ^ 2)) = Real.sqrt (5 / 6) := by
    unfold V
    rw [if_pos]
    have hsq : σ / Real.sqrt (1 - σ ^ 2) = Real.sqrt (σ ^ 2 / (1 - σ ^ 2)) := by
      rw [Real.sqrt_div' _ hc.le, Real.sqrt_sq h0]
    rw [hsq, tStar, show Real.sqrt 30 / 8 = Real.sqrt (30 / 64) by
      rw [Real.sqrt_div' _ (by norm_num), show (64 : ℝ) = 8 ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]]
    apply Real.sqrt_le_sqrt
    rw [div_le_div_iff₀ hc (by norm_num)]
    nlinarith
  unfold H
  rw [hV]
  set s2 := Real.sqrt 2 with hs2
  set s15 := Real.sqrt 15 with hs15
  set s56 := Real.sqrt (5 / 6) with hs56
  have e2 : s2 * s2 = 2 := Real.mul_self_sqrt (by norm_num)
  have e15 : s15 * s15 = 15 := Real.mul_self_sqrt (by norm_num)
  have p2 : 0 < s2 := Real.sqrt_pos.mpr (by norm_num)
  have p15 : 0 < s15 := Real.sqrt_pos.mpr (by norm_num)
  have e256 : s2 * s56 = s15 / 3 := by
    rw [hs2, hs56, hs15, ← Real.sqrt_mul (by norm_num)]
    rw [show (2 : ℝ) * (5 / 6) = 15 / 9 by norm_num, Real.sqrt_div' _ (by norm_num),
      show (9 : ℝ) = 3 ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]
  have hs15lt : s15 < 3873 / 1000 := by nlinarith
  have hσ1 : σ ≤ 1 := by nlinarith
  have hθσ : s2 * θ * σ ^ 3 ≤ 2 * σ ^ 3 := by
    have := mul_le_mul_of_nonneg_left hθ p2.le
    rw [e2] at this
    exact mul_le_mul_of_nonneg_right this (pow_nonneg h0 3)
  have hcube : 0 < 4 + 5 * σ ^ 2 - s15 * 3 * σ * (1 - σ ^ 2) - 6 * σ ^ 3 := by
    have hneg : 0 ≤ σ * (1 - σ ^ 2) := mul_nonneg h0 hc.le
    have hb : s15 * 3 * σ * (1 - σ ^ 2) ≤ 3873 / 1000 * 3 * σ * (1 - σ ^ 2) := by
      have := mul_le_mul_of_nonneg_right hs15lt.le (mul_nonneg (by norm_num : (0:ℝ) ≤ 3) hneg)
      nlinarith
    nlinarith [mul_nonneg h0 (sq_nonneg (σ - 117 / 200)), sq_nonneg (σ - 117 / 200)]
  have hkey : 3 * s2 * ((4 + 5 * σ ^ 2) / (3 * s2) - 3 * (1 - σ ^ 2) * σ * s56 - θ * σ ^ 3)
      = 4 + 5 * σ ^ 2 - s15 * 3 * σ * (1 - σ ^ 2) - 3 * (s2 * θ * σ ^ 3) := by
    field_simp
    linear_combination (-(3 : ℝ) ^ 2 * σ * (1 - σ ^ 2)) * e256
  have hpos : 0 < 3 * s2 * ((4 + 5 * σ ^ 2) / (3 * s2) - 3 * (1 - σ ^ 2) * σ * s56 - θ * σ ^ 3) := by
    rw [hkey]; nlinarith
  exact (pos_iff_pos_of_mul_pos hpos).mp (by positivity)


/-! ## Non-vacuity

The range `H_pos_on_cubic_piece` quantifies over is non-empty, and the constants it is stated
for are the ones the record uses. -/

/-- **`σ* > 0`**, so `[0, σ*]` is a genuine interval, and `α* = 32/141` is strictly inside
`(0, ⅓)`, so the two branches have complementary intervals to cover. -/
theorem ranges_nonempty : 0 < sigmaStar ∧ 0 < alphaStar ∧ alphaStar < 1 / 3 := by
  refine ⟨Real.sqrt_pos.mpr (by norm_num), by unfold alphaStar; norm_num, ?_⟩
  unfold alphaStar; norm_num

/-- **And the record's constant is below `√2` at `n = 12`**: `θ₀(12)² = 220/144 < 2`, which is
the hypothesis `H_pos_on_cubic_piece` needs. -/
theorem constant_below_sqrt_two : 2 * (12 - 1) * (12 - 2) / (12 : ℝ) ^ 2 < 2 := by norm_num

end HamiltonsCubic.L22Statement
