import Mathlib

set_option linter.style.longLine false

/-!
# L157, the reach parameter is a fixed point, stated and proved

**The record's statement, quoted verbatim from [second-order.md](../../../findings/second-order.md):**

> > **LEMMA L157.** *In units of $\rho$ the two coupled branches are $\eta$ and $t(1-\eta)^2$ with $t=\lambda\sqrt{c_p+\rho^{\text{eff}}_nw^2}/(2J\gamma)$; they cross at the unique root in $(0,1)$*
> > $$\eta^*(t)=\frac{2t+1-\sqrt{4t+1}}{2t},$$
> > *the other root being its reciprocal and spurious, and the minimum of the two is maximised there. The exact identity at the crossing is*
> > $$\eta^*\gamma=\frac{\lambda\sqrt{c_p+\rho^{\text{eff}}_nw^2}}{2J}\,(1-\eta^*)^2 .$$
>
> **The $(1-\eta^*)^2$ does not drop.** ... **it does not vanish with $n$**: $\sup_wt\to\tfrac18$ at $w=1$, so $(1-\eta^*)^2\to0.808$ at every dimension.

## What this file states

Every algebraic clause of the boxed lemma, proved with no `sorry`, with the two branches `η` and `t(1-η)²` taken
as the setting and their derivation from the reach problem left to the record: the crossing, the location and
uniqueness in `(0,1)`,
the reciprocal second root, the fact that the minimum of the two branches is maximised at the
crossing, the identity in the form the record writes it, and the numerical floor `0.808` at
`t = 1/8` together with the monotonicity that makes `t ≤ 1/8` enough to give it.

**The whole lemma is rational in `s = √(4t+1)`**, since `η* = (s-1)/(s+1)` and `t = (s²-1)/4`;
`etaStar_eq` is that rewriting, and every later proof runs through it.

**`t` enters as a real parameter, not as the analytic expression it abbreviates.** The record's
`t = λ√(c_p + ρ^eff w²)/(2Jγ)` names three constants (`λ`, `J`, and the margin), whose values are
open on the record's own account, and none of them is used by the lemma: what the lemma says about
`t` holds for every positive real. `crossing_identity` therefore takes the numerator `A = λ√(c_p +
ρ^eff w²)` as a real and the defining relation `t = A/(2Jγ)` as a hypothesis, which is exactly the
shape the record's display has.
-/

namespace HamiltonsCubic.L157

/-- The crossing root, `η*(t) = (2t+1-√(4t+1))/(2t)`. -/
noncomputable def etaStar (t : ℝ) : ℝ := (2 * t + 1 - Real.sqrt (4 * t + 1)) / (2 * t)

private theorem sqrt_sq_val {t : ℝ} (ht : 0 < t) : Real.sqrt (4 * t + 1) ^ 2 = 4 * t + 1 :=
  Real.sq_sqrt (by linarith)

private theorem one_lt_sqrt {t : ℝ} (ht : 0 < t) : 1 < Real.sqrt (4 * t + 1) := by
  have h : Real.sqrt 1 < Real.sqrt (4 * t + 1) := by
    apply Real.sqrt_lt_sqrt (by norm_num)
    linarith
  simpa using h

/-- **`η*` is `(s-1)/(s+1)` in `s = √(4t+1)`**, which is what makes every clause below rational. -/
theorem etaStar_eq {t : ℝ} (ht : 0 < t) : etaStar t = (Real.sqrt (4 * t + 1) - 1) / (Real.sqrt (4 * t + 1) + 1) := by
  have hs := sqrt_sq_val ht
  have h1 := one_lt_sqrt ht
  have hne : Real.sqrt (4 * t + 1) + 1 ≠ 0 := by linarith
  have h2t : (2 : ℝ) * t ≠ 0 := by linarith
  rw [etaStar, div_eq_div_iff h2t hne]
  nlinarith [hs, h1]

/-- **`1 - η* = 2/(s+1)`**, the rationalised form the record uses to read off the log-derivative. -/
theorem one_sub_etaStar {t : ℝ} (ht : 0 < t) : 1 - etaStar t = 2 / (Real.sqrt (4 * t + 1) + 1) := by
  have h1 := one_lt_sqrt ht
  have hne : Real.sqrt (4 * t + 1) + 1 ≠ 0 := by linarith
  rw [etaStar_eq ht]
  field_simp
  ring

/-- **`η*` lies strictly inside `(0,1)`**, the location half of the lemma's *"the unique root in `(0,1)`"*,
whose uniqueness half is `unique_root`. -/
theorem etaStar_mem_Ioo {t : ℝ} (ht : 0 < t) : 0 < etaStar t ∧ etaStar t < 1 := by
  have h1 := one_lt_sqrt ht
  rw [etaStar_eq ht]
  constructor
  · apply div_pos <;> linarith
  · rw [div_lt_one (by linarith)]; linarith

/-- **The crossing**: `t(1-η*)² = η*`, so `η*` is where the two branches meet. -/
theorem crossing {t : ℝ} (ht : 0 < t) : t * (1 - etaStar t) ^ 2 = etaStar t := by
  obtain ⟨s, hs1, hst⟩ : ∃ s : ℝ, 1 < s ∧ Real.sqrt (4 * t + 1) = s :=
    ⟨_, one_lt_sqrt ht, rfl⟩
  have hts : 4 * t + 1 = s ^ 2 := by rw [← hst]; exact (sqrt_sq_val ht).symm
  have ht4 : t = (s ^ 2 - 1) / 4 := by linarith
  have hne : s + 1 ≠ 0 := by linarith
  rw [one_sub_etaStar ht, etaStar_eq ht, hst, ht4]
  field_simp
  ring

/-- **The other root is the reciprocal**, and it lies above `1`, so it is spurious. -/
theorem other_root {t : ℝ} (ht : 0 < t) : (2 * t + 1 + Real.sqrt (4 * t + 1)) / (2 * t) = 1 / etaStar t := by
  obtain ⟨s, hs1, hst⟩ : ∃ s : ℝ, 1 < s ∧ Real.sqrt (4 * t + 1) = s :=
    ⟨_, one_lt_sqrt ht, rfl⟩
  have hts : 4 * t + 1 = s ^ 2 := by rw [← hst]; exact (sqrt_sq_val ht).symm
  have ht4 : t = (s ^ 2 - 1) / 4 := by linarith
  have hne2 : s - 1 ≠ 0 := by intro h; linarith [h]
  have h2t : (2 : ℝ) * t ≠ 0 := by positivity
  rw [etaStar_eq ht, hst, one_div_div, div_eq_div_iff h2t hne2]
  linear_combination -hts

/-- **Both are roots of the same quadratic** `tη² - (2t+1)η + t = 0`, which is what
`t(1-η)² = η` clears to. -/
theorem etaStar_root {t : ℝ} (ht : 0 < t) : t * etaStar t ^ 2 - (2 * t + 1) * etaStar t + t = 0 := by
  have h := crossing ht
  nlinarith [h]

/-- **The other root is a root, and lies above `1`**: `1/η*` solves the same quadratic, the quadratic being
palindromic, and exceeds `1` since `η* ∈ (0,1)`. So it is spurious for a branch parameter in `(0,1)`. -/
theorem other_root_is_root {t : ℝ} (ht : 0 < t) :
    t * (1 / etaStar t) ^ 2 - (2 * t + 1) * (1 / etaStar t) + t = 0 ∧ 1 < 1 / etaStar t := by
  obtain ⟨h0, h1⟩ := etaStar_mem_Ioo ht
  have hr := etaStar_root ht
  refine ⟨?_, by rw [lt_div_iff₀ h0]; linarith⟩
  have hne : etaStar t ≠ 0 := h0.ne'
  field_simp
  linear_combination hr

/-- **`η*` is the unique root in `(0,1)`**: any root `η` of `tη² - (2t+1)η + t = 0` with `0 < η < 1` is `η*`.
The two roots multiply to `1`, so a second root in `(0,1)` would make their product less than `1`. -/
theorem unique_root {t η : ℝ} (ht : 0 < t) (h0 : 0 < η) (h1 : η < 1)
    (hη : t * η ^ 2 - (2 * t + 1) * η + t = 0) : η = etaStar t := by
  obtain ⟨e0, e1⟩ := etaStar_mem_Ioo ht
  have hr := etaStar_root ht
  have hfac : t * (η - etaStar t) * (η * etaStar t - 1) = 0 := by
    have : t * (η - etaStar t) * (η * etaStar t - 1) =
        etaStar t * (t * η ^ 2 - (2 * t + 1) * η + t) - η * (t * etaStar t ^ 2 - (2 * t + 1) * etaStar t + t) := by
      ring
    rw [this, hη, hr]; ring
  rcases mul_eq_zero.mp hfac with h | h
  · rcases mul_eq_zero.mp h with h' | h'
    · exact absurd h' ht.ne'
    · linarith
  · nlinarith

/-- **The minimum of the two branches is maximised at the crossing.** For every `η` in `[0,1]`,
`min(η, t(1-η)²) ≤ η*`, with equality at `η = η*`. -/
theorem min_le_etaStar {t η : ℝ} (ht : 0 < t) (h0 : 0 ≤ η) (h1 : η ≤ 1) :
    min η (t * (1 - η) ^ 2) ≤ etaStar t := by
  rcases le_or_gt η (etaStar t) with h | h
  · exact le_trans (min_le_left _ _) h
  · have hstar := (etaStar_mem_Ioo ht).2
    have hb : t * (1 - η) ^ 2 ≤ t * (1 - etaStar t) ^ 2 := by
      apply mul_le_mul_of_nonneg_left _ ht.le
      nlinarith
    rw [crossing ht] at hb
    exact le_trans (min_le_right _ _) hb

/-- **Equality at the crossing.** -/
theorem min_at_etaStar {t : ℝ} (ht : 0 < t) : min (etaStar t) (t * (1 - etaStar t) ^ 2) = etaStar t := by
  rw [crossing ht, min_self]

/-! ## The identity as the record writes it -/

/-- **The exact identity at the crossing**, `η*γ = (A/(2J))(1-η*)²` with `A` the numerator
`λ√(c_p + ρ^eff w²)`. It is the crossing multiplied through by `γ`. -/
theorem crossing_identity {A J γ t : ℝ} (hJ : 0 < J) (hγ : 0 < γ) (ht : 0 < t)
    (htdef : t = A / (2 * J * γ)) :
    etaStar t * γ = A / (2 * J) * (1 - etaStar t) ^ 2 := by
  have hc := crossing ht
  have h : t * γ = A / (2 * J) := by
    rw [htdef]; field_simp
  calc etaStar t * γ = t * (1 - etaStar t) ^ 2 * γ := by rw [hc]
    _ = t * γ * (1 - etaStar t) ^ 2 := by ring
    _ = A / (2 * J) * (1 - etaStar t) ^ 2 := by rw [h]

/-! ## The factor `(1-η*)²` does not vanish -/

/-- **`η*` is monotone in `t`**, so `(1-η*)²` is largest at the smallest `t` and the bound at
`t = 1/8` covers the whole range `0 < t ≤ 1/8`. -/
theorem etaStar_mono {t₁ t₂ : ℝ} (h1 : 0 < t₁) (h12 : t₁ ≤ t₂) : etaStar t₁ ≤ etaStar t₂ := by
  have h2 : 0 < t₂ := lt_of_lt_of_le h1 h12
  have hs : Real.sqrt (4 * t₁ + 1) ≤ Real.sqrt (4 * t₂ + 1) :=
    Real.sqrt_le_sqrt (by linarith)
  have ha := one_lt_sqrt h1
  have hb := one_lt_sqrt h2
  rw [etaStar_eq h1, etaStar_eq h2, div_le_div_iff₀ (by linarith) (by linarith)]
  nlinarith

/-- **At `sup_w t = 1/8` the factor is `0.808…`**, so it does not vanish with the dimension, and
the record's `(1-η*)² → 0.808` is exact to the digits printed. -/
theorem factor_at_one_eighth :
    (0.808 : ℝ) < (1 - etaStar (1 / 8)) ^ 2 ∧ (1 - etaStar (1 / 8)) ^ 2 < 0.8082 := by
  have ht : (0 : ℝ) < 1 / 8 := by norm_num
  have hval : (4 : ℝ) * (1 / 8) + 1 = 3 / 2 := by norm_num
  have hs2 : Real.sqrt (3 / 2) ^ 2 = 3 / 2 := Real.sq_sqrt (by norm_num)
  have hspos : 0 < Real.sqrt (3 / 2) := Real.sqrt_pos.mpr (by norm_num)
  have hlo : (1.2247448 : ℝ) < Real.sqrt (3 / 2) := by nlinarith
  have hhi : Real.sqrt (3 / 2) < 1.2247449 := by nlinarith
  rw [one_sub_etaStar ht, hval, div_pow]
  constructor
  · rw [lt_div_iff₀ (by positivity)]
    nlinarith
  · rw [div_lt_iff₀ (by positivity)]
    nlinarith

/-- **And the factor is at least `0.808` throughout `0 < t ≤ 1/8`**, which is the range the
record's `sup_w t → 1/8` puts it in. -/
theorem factor_floor {t : ℝ} (ht : 0 < t) (hle : t ≤ 1 / 8) :
    (0.808 : ℝ) < (1 - etaStar t) ^ 2 := by
  have hmono := etaStar_mono ht hle
  have h0 := (etaStar_mem_Ioo ht).2
  have h1 := (etaStar_mem_Ioo (show (0:ℝ) < 1/8 by norm_num)).2
  have hbase := factor_at_one_eighth.1
  nlinarith
