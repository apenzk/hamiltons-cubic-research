import Mathlib

set_option linter.style.longLine false

/-!
# L135, the great-circle and straight-line second-order coefficients differ by `δ²(u)`

## The record's statement, quoted verbatim from [route-a.md](../../../findings/route-a.md)

> For a unit $H\in T_uS$ write $c_2(H)$ for the one-sided second-order coefficient of $\delta^2$
> along the **great circle** $\cos t\,u+\sin t\,H$, and $\Delta_2(H)$ for the same coefficient along
> the **straight line** $u+tH$.
>
> **Statement.**
>
> > **(a) The two differ by a constant, and the constant is the whole of $\delta^2(u)$:**
> > $$c_2(H)\;=\;\Delta_2(H)\;-\;\tfrac19\qquad\text{for every }H\in T_uS .$$
> >
> > **(b) Hence [I3](../../../plan.md), $c_2\le\theta^*/(2\lvert\kappa_n\rvert)$ for every $n\ge12$
> > and every $H\perp T_u\mathcal O$, is exactly**
> > $$\Delta_2(H)\;\le\;\tfrac19+\frac{\theta^*}{2\lvert\kappa_n\rvert}\qquad\text{on }\{F=0\},$$
> > **whose binding case is $\Delta_2\le0.4702$ as $n\to\infty$; and the candidate
> > $c_2\le\tfrac5{36}$ is exactly $\Delta_2\le\tfrac14$, the record's own unconditional ceiling
> > $\delta^2\le\tfrac14$, asked of a second-order coefficient rather than of a value.**

and the proof of (a) the record keeps, its own alternative having been withdrawn:

> **A second proof of (a), from homogeneity alone.** $\delta^2$ is $2$-homogeneous, so
> $\delta^2(u+tH)=(1+t^2)\,\delta^2\big((u+tH)/\sqrt{1+t^2}\big)$ because
> $\lVert u+tH\rVert^2=1+t^2$ for $H\perp u$ of unit norm; and the normalised point is
> $\cos\tau\,u+\sin\tau\,H$ with $\tan\tau=t$, so $\tau=t+O(t^3)$. Matching $t^2$ coefficients gives
> $\Delta_2=c_2+\delta^2(u)$. *This is the **only** proof […] the clean form
> $\cos t\,u+\sin t\,H=\cos t\,(u+\tan t\,H)$, whence
> $\delta^2(t)=\cos^2t\cdot\delta^2(u+\tan t\,H)$ and the $\arctan$'s $O(t^3)$ cannot reach the
> $t^2$ coefficient.*

## What is typed here

**(a) in full, and proved**, `line_coeff_eq` and `coeff_identity`. `δ²` enters only through
`2`-homogeneity, which is the sole property the record's surviving proof uses; the base point is a
unit vector `u`, the direction a unit `H ⊥ u`, and `δ²(u)` is written `A` rather than fixed at
`1/9`, so the identity is the general one and `c₂ = Δ₂ - 1/9` is the instance `A = 1/9`.

The chain is: `reparam` and `line_eq`, the record's clean form `cos τ · u + sin τ · H =
cos τ · (u + tan τ · H)` and its `t`-side consequence `h t = (1 + t²) · k (arctan t)`; then
`arctan_bounds`, the `O(t³)` the record's proof asserts, proved as `t - t³/2 ≤ arctan t ≤ t`; then
`line_coeff_eq`, which converts a second-order expansion along the great circle into one along the
line; then `coeff_identity`, which is (a).

**(b), and proved**, `target_translation` and `binding_case`: the two arithmetic translations,
`c₂ ≤ β ↔ Δ₂ ≤ 1/9 + β`, and `1/9 + 5/36 = 1/4`.

There is no `sorry`.

## What is NOT typed here

**(c) is not typed, and the record marks it INCOMPLETE in its own text**, *"It omits the frame-tilt
term, the same omission that killed L137 […] Both reviewers refuted it as complete."* Its content is
the block decomposition of the second-order expansion of `Alt(W₋)`, which needs the curvature layer;
and the record's own verdict is that the display is not a complete account of `Δ₂`.

**The value `δ²(u) = 1/9` is not derived here**, nor is `θ*/(2|κₙ|) ↓ 0.3591`; both are inputs from
elsewhere in the record, so they appear as the numeral `A` and as a hypothesis rather than as
theorems.
-/

namespace HamiltonsCubic.L135Statement

open Filter Topology

/-! ## The reparametrisation

*The record's clean form. `δ²` is used only through `2`-homogeneity.* -/

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

/-- **`δ²(cos τ · u + sin τ · H) = cos²τ · δ²(u + tan τ · H)`** for `τ` in the principal branch,
the record's `cos t · u + sin t · H = cos t · (u + tan t · H)`, with `2`-homogeneity applied. -/
theorem reparam (δ2 : V → ℝ) (hom : ∀ c : ℝ, 0 ≤ c → ∀ W, δ2 (c • W) = c ^ 2 * δ2 W)
    (u H : V) {τ : ℝ} (hτ : τ ∈ Set.Ioo (-(Real.pi / 2)) (Real.pi / 2)) :
    δ2 (Real.cos τ • u + Real.sin τ • H) = Real.cos τ ^ 2 * δ2 (u + Real.tan τ • H) := by
  have hc : 0 < Real.cos τ := Real.cos_pos_of_mem_Ioo hτ
  have hsplit : Real.cos τ • (u + Real.tan τ • H) = Real.cos τ • u + Real.sin τ • H := by
    rw [smul_add, smul_smul, Real.tan_eq_sin_div_cos]
    congr 2
    field_simp
  rw [← hsplit, hom _ hc.le]

/-- **`h t = (1 + t²) · k (arctan t)`**, the same identity read along the line: the straight-line
value at `t` is the great-circle value at `arctan t`, inflated by `1 + t²`. -/
theorem line_eq (δ2 : V → ℝ) (hom : ∀ c : ℝ, 0 ≤ c → ∀ W, δ2 (c • W) = c ^ 2 * δ2 W)
    (u H : V) (t : ℝ) :
    δ2 (u + t • H)
      = (1 + t ^ 2) * δ2 (Real.cos (Real.arctan t) • u + Real.sin (Real.arctan t) • H) := by
  have h := reparam δ2 hom u H (Real.arctan_mem_Ioo t)
  rw [Real.tan_arctan] at h
  rw [h, Real.cos_sq_arctan]
  have hpos : (0 : ℝ) < 1 + t ^ 2 := by positivity
  field_simp

/-! ## The `O(t³)` the proof asserts -/

/-- **`t - t³/2 ≤ arctan t ≤ t`** for `t ≥ 0`. The upper bound is `x ≤ tan x`; the lower comes from
`sin θ ≤ θ` at `θ = arctan t`, where `sin (arctan t) = t/√(1+t²)` and `√(1+t²) ≤ 1 + t²/2`. -/
theorem arctan_bounds {t : ℝ} (ht : 0 ≤ t) :
    t - t ^ 3 / 2 ≤ Real.arctan t ∧ Real.arctan t ≤ t := by
  have hnn : 0 ≤ Real.arctan t := by
    have h := Real.arctan_le_arctan_iff (x := 0) (y := t) |>.mpr ht
    simpa using h
  constructor
  · have hsin : Real.sin (Real.arctan t) ≤ Real.arctan t := Real.sin_le hnn
    rw [Real.sin_arctan] at hsin
    have hs : Real.sqrt (1 + t ^ 2) ≤ 1 + t ^ 2 / 2 := by
      have h1 : (0 : ℝ) ≤ 1 + t ^ 2 / 2 := by positivity
      have h2 : (1 : ℝ) + t ^ 2 ≤ (1 + t ^ 2 / 2) ^ 2 := by nlinarith [sq_nonneg t]
      calc Real.sqrt (1 + t ^ 2) ≤ Real.sqrt ((1 + t ^ 2 / 2) ^ 2) := Real.sqrt_le_sqrt h2
        _ = 1 + t ^ 2 / 2 := Real.sqrt_sq h1
    have hspos : (0 : ℝ) < Real.sqrt (1 + t ^ 2) := Real.sqrt_pos.mpr (by positivity)
    have hlow : t - t ^ 3 / 2 ≤ t / Real.sqrt (1 + t ^ 2) := by
      rw [le_div_iff₀ hspos]
      rcases le_or_gt 0 (t - t ^ 3 / 2) with hc | hc
      · calc (t - t ^ 3 / 2) * Real.sqrt (1 + t ^ 2)
            ≤ (t - t ^ 3 / 2) * (1 + t ^ 2 / 2) := by nlinarith
          _ ≤ t := by nlinarith [sq_nonneg t, mul_nonneg ht (sq_nonneg t)]
      · nlinarith
    linarith
  · rcases eq_or_lt_of_le ht with h | h
    · simp [← h]
    · have := Real.le_tan hnn (Real.arctan_lt_pi_div_two t)
      rwa [Real.tan_arctan] at this

/-! ## Matching the `t²` coefficients -/

/-- **The reparametrisation does not move the second-order coefficient, beyond adding `δ²(u)`.**

Given a one-sided second-order expansion of the great-circle function `k` at `0` with value `A`,
linear coefficient `B` and quadratic coefficient `c₂`, the straight-line function `h`, related to
`k` by `h t = (1 + t²) k (arctan t)`, has the expansion with the same `A` and `B` and quadratic
coefficient `c₂ + A`. -/
theorem line_coeff_eq {h k : ℝ → ℝ} {A B c₂ : ℝ}
    (hrel : ∀ t : ℝ, 0 < t → h t = (1 + t ^ 2) * k (Real.arctan t))
    (hk : Tendsto (fun τ => (k τ - A - B * τ) / τ ^ 2) (𝓝[>] (0 : ℝ)) (𝓝 c₂)) :
    Tendsto (fun t => (h t - A - B * t) / t ^ 2) (𝓝[>] (0 : ℝ)) (𝓝 (c₂ + A)) := by
  -- `arctan` maps the right-hand neighbourhood of `0` to itself
  have harct : Tendsto Real.arctan (𝓝[>] (0 : ℝ)) (𝓝[>] (0 : ℝ)) := by
    refine tendsto_nhdsWithin_of_tendsto_nhds_of_eventually_within _ ?_ ?_
    · have : Tendsto Real.arctan (𝓝 (0 : ℝ)) (𝓝 (Real.arctan 0)) :=
        Real.continuous_arctan.tendsto 0
      rw [Real.arctan_zero] at this
      exact this.mono_left nhdsWithin_le_nhds
    · filter_upwards [self_mem_nhdsWithin] with t ht
      exact Real.arctan_pos.mpr ht
  -- the three elementary limits
  have hlin : Tendsto (fun t : ℝ => (Real.arctan t - t) / t ^ 2) (𝓝[>] (0 : ℝ)) (𝓝 0) := by
    refine tendsto_of_tendsto_of_tendsto_of_le_of_le' (g := fun t : ℝ => -t / 2)
      (h := fun _ : ℝ => (0 : ℝ)) ?_ tendsto_const_nhds ?_ ?_
    · have : Tendsto (fun t : ℝ => -t / 2) (𝓝 (0 : ℝ)) (𝓝 (-(0 : ℝ) / 2)) :=
        (continuous_neg.div_const 2).tendsto 0
      simp only [neg_zero, zero_div] at this
      exact this.mono_left nhdsWithin_le_nhds
    · filter_upwards [self_mem_nhdsWithin] with t ht
      have ht' : (0 : ℝ) < t := ht
      have hsq : (0 : ℝ) < t ^ 2 := pow_pos ht' 2
      obtain ⟨hlo, -⟩ := arctan_bounds ht'.le
      rw [div_le_div_iff₀ (by norm_num) hsq]
      nlinarith
    · filter_upwards [self_mem_nhdsWithin] with t ht
      have ht' : (0 : ℝ) < t := ht
      have hsq : (0 : ℝ) < t ^ 2 := pow_pos ht' 2
      obtain ⟨-, hhi⟩ := arctan_bounds ht'.le
      rw [div_nonpos_iff]
      exact Or.inr ⟨by linarith, hsq.le⟩
  have hratio : Tendsto (fun t : ℝ => Real.arctan t / t) (𝓝[>] (0 : ℝ)) (𝓝 1) := by
    refine tendsto_of_tendsto_of_tendsto_of_le_of_le' (g := fun t : ℝ => 1 - t ^ 2 / 2)
      (h := fun _ : ℝ => (1 : ℝ)) ?_ tendsto_const_nhds ?_ ?_
    · have : Tendsto (fun t : ℝ => 1 - t ^ 2 / 2) (𝓝 (0 : ℝ)) (𝓝 (1 - (0:ℝ) ^ 2 / 2)) := by
        exact (continuous_const.sub ((continuous_pow 2).div_const 2)).tendsto 0
      norm_num at this
      exact this.mono_left nhdsWithin_le_nhds
    · filter_upwards [self_mem_nhdsWithin] with t ht
      obtain ⟨hlo, -⟩ := arctan_bounds ht.le
      rw [le_div_iff₀ ht]
      nlinarith
    · filter_upwards [self_mem_nhdsWithin] with t ht
      obtain ⟨-, hhi⟩ := arctan_bounds ht.le
      rw [div_le_one ht]
      exact hhi
  have hone : Tendsto (fun t : ℝ => (1 : ℝ) + t ^ 2) (𝓝[>] (0 : ℝ)) (𝓝 1) := by
    have : Tendsto (fun t : ℝ => (1 : ℝ) + t ^ 2) (𝓝 (0 : ℝ)) (𝓝 (1 + (0:ℝ) ^ 2)) :=
      (continuous_const.add (continuous_pow 2)).tendsto 0
    norm_num at this
    exact this.mono_left nhdsWithin_le_nhds
  have harctzero : Tendsto Real.arctan (𝓝[>] (0 : ℝ)) (𝓝 0) :=
    harct.mono_right nhdsWithin_le_nhds
  -- the assembled limit
  have hG : Tendsto (fun t : ℝ =>
      (1 + t ^ 2) * ((k (Real.arctan t) - A - B * Real.arctan t) / (Real.arctan t) ^ 2)
        * (Real.arctan t / t) ^ 2 + A + B * ((Real.arctan t - t) / t ^ 2)
        + B * Real.arctan t) (𝓝[>] (0 : ℝ)) (𝓝 (c₂ + A)) := by
    have := ((hone.mul (hk.comp harct)).mul (hratio.mul hratio)).add_const A
      |>.add ((tendsto_const_nhds (x := B) (f := 𝓝[>] (0:ℝ))).mul hlin)
      |>.add ((tendsto_const_nhds (x := B) (f := 𝓝[>] (0:ℝ))).mul harctzero)
    simp only [Function.comp] at this
    convert this using 2
    · ring
    · ring
  -- and it computes the straight-line quotient
  refine hG.congr' ?_
  filter_upwards [self_mem_nhdsWithin] with t ht
  have htne : t ≠ 0 := ne_of_gt ht
  have hτpos : 0 < Real.arctan t := Real.arctan_pos.mpr ht
  have hτne : Real.arctan t ≠ 0 := ne_of_gt hτpos
  rw [hrel t ht]
  field_simp
  ring

/-- **L135(a).** With `A = δ²(u)`, the straight-line second-order coefficient exceeds the
great-circle one by exactly `A`: `Δ₂ = c₂ + A`, i.e. `c₂ = Δ₂ - A`. At `A = 1/9` this is the
record's `c₂(H) = Δ₂(H) - 1/9`. -/
theorem coeff_identity {h k : ℝ → ℝ} {A B c₂ Δ₂ : ℝ}
    (hrel : ∀ t : ℝ, 0 < t → h t = (1 + t ^ 2) * k (Real.arctan t))
    (hk : Tendsto (fun τ => (k τ - A - B * τ) / τ ^ 2) (𝓝[>] (0 : ℝ)) (𝓝 c₂))
    (hh : Tendsto (fun t => (h t - A - B * t) / t ^ 2) (𝓝[>] (0 : ℝ)) (𝓝 Δ₂)) :
    c₂ = Δ₂ - A := by
  have h1 := line_coeff_eq hrel hk
  have := tendsto_nhds_unique h1 hh
  linarith

/-! ## (b): the two translations -/

/-- **The target translation.** `c₂ ≤ β` is exactly `Δ₂ ≤ 1/9 + β`. -/
theorem target_translation {c₂ Δ₂ β : ℝ} (hdef : c₂ = Δ₂ - 1 / 9) :
    c₂ ≤ β ↔ Δ₂ ≤ 1 / 9 + β := by
  rw [hdef]; constructor <;> intro h <;> linarith

/-- **The candidate `c₂ ≤ 5/36` is exactly `Δ₂ ≤ 1/4`**, `1/9 + 5/36 = 1/4`, the record's
unconditional ceiling on `δ²`, asked of a coefficient. -/
theorem candidate_is_quarter {c₂ Δ₂ : ℝ} (hdef : c₂ = Δ₂ - 1 / 9) :
    c₂ ≤ 5 / 36 ↔ Δ₂ ≤ 1 / 4 := by
  rw [target_translation hdef]; norm_num

/-- **The binding case.** With the threshold decreasing in `n` to `0.3591`, the requirement is
`Δ₂ ≤ 0.4702`, and `1/4` clears it. -/
theorem binding_case {Δ₂ : ℝ} (h : Δ₂ ≤ 1 / 4) : Δ₂ ≤ 1 / 9 + 0.3591 := by
  norm_num at *
  linarith

end HamiltonsCubic.L135Statement
