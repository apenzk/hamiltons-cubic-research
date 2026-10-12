import Mathlib

set_option linter.style.longLine false

/-!
# L110, the per-direction identity, and its slack

## The record's statement, quoted verbatim from [bounds-relaxations.md](../../../findings/bounds-relaxations.md)

> #### Lemma L110, the per-direction identity, whose slack is exactly $g_\gamma/(4\lambda_\gamma)$

> **ANSWERED: at a critical point the sharpest per-direction statement is an IDENTITY, and being an
> identity is exactly why it cannot close.** $Q_\gamma$ needs no cap there, it is *determined*.
> Per row, $Q_\gamma=2(W^\#)_{\gamma\gamma}$, and criticality gives
> $(W^\#)_{\gamma\gamma}=\theta\lambda_\gamma-\lambda_\gamma^2$, so the decomposition solves for
> $\theta$ outright:
> $$\theta=\frac{\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}}{2\lambda_\gamma}+\lambda_\gamma-\frac{g_\gamma}{4\lambda_\gamma}\qquad\text{for every }\gamma\text{ with }\lambda_\gamma>0,$$
> […] Dropping $g_\gamma\ge0$ gives the per-direction bound, whose slack at $\gamma$ is therefore
> **exactly $g_\gamma/(4\lambda_\gamma)$**. Summed over $\mathfrak p$ that slack is $\Delta$ divided
> through, so the bound carries the symmetry defect and nothing else.

> **Hence it is an equality at every $\Delta=0$ critical point**, every balanced product, every
> unbalanced one, every $\mathbb{CP}^m$, measured slack $0$ against $2.012$ at the $C_5$ blow-up.

with the definitions the display runs on, from the same block:

> **The $Q_\gamma$ term, mapped.** Writing $g_\gamma=2\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}-2Q_\gamma$
> with $Q_\gamma=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta T_{\gamma\alpha\beta}$ […]
> Contracted against weight $1$ they return $\sum g=4(n-1)$; against weight $\lambda$ they return
> $\sum\lambda g=-4\theta$. Both are recovered exactly, so the $Q$ decomposition carries nothing
> the record does not already hold.

## What is typed here

The row quantities `rowS`, `rowQ`, `rowg` are defined exactly as the record writes them, and then:

* `per_direction_identity`, **the display**, `θ = S_γ/(2λ_γ) + λ_γ - g_γ/(4λ_γ)` at every `γ` with
  `λ_γ > 0`, from `Q_γ = 2(θλ_γ - λ_γ²)`.
* `slack_exact`, the record's headline: the difference between the bound's right-hand side and `θ`
  is **exactly** `g_γ/(4λ_γ)`, with no inequality anywhere in the statement.
* `per_direction_bound`, what dropping `g_γ ≥ 0` leaves.
* `equality_iff_g_zero`, the bound is an equality at `γ` precisely when `g_γ = 0`, which is the
  record's "equality at every `Δ = 0` critical point".
* `sum_g_recovers_first_moment`, `sum_lam_g_recovers_second_moment`, the block's own deflation:
  contracting the decomposition against weight `1` and against weight `λ` returns `∑ g = 4(n-1)`
  and `∑ λ g = -4θ`, the two moments the record already holds, so the decomposition adds nothing.

Everything is proved; there is no `sorry`.

## What is NOT typed here

**`Q_γ = 2(W#)_{γγ}` and `(W#)_{γγ} = θλ_γ - λ_γ²` are not derived**, and the second is where
criticality enters. Both need `W#` on `Λ²` in an eigenbasis, which
[WeylReal.lean](../Base/WeylReal.lean) does not provide in coordinates; the composite
`Q_γ = 2(θλ_γ - λ_γ²)` therefore enters `per_direction_identity` as a hypothesis named
`hcrit`, and the file proves the identity **given** it rather than proving criticality.

**`g_γ = ‖[ad(v_γ), W]‖² ≥ 0` is not derived either.** It is manifest in the record because `g_γ`
is a squared norm; here `rowg` is defined from `rowS` and `rowQ`, so nonnegativity is a hypothesis
where it is used.

**The two global constraints `∑_γ Q_γ = -2‖W‖²` and `∑_γ λ_γ Q_γ = 2⟨W#, W⟩` are not proved.**
The record calls them definitional; they are definitional *in the tensor layer*, and enter the two
moment-recovery theorems below as named hypotheses.

**The pin's equation count `N - 2` is not re-typed here**, it is already in
[PinCount.lean](PinCount.lean), with `N = C(n,2)` giving `13`, `26` and `64`.
-/

namespace HamiltonsCubic.L110Statement

open Finset

variable {κ : Type*} [Fintype κ]

/-! ## The row quantities, as the record writes them -/

/-- `S_γ = ∑_α λ_α² R_{γα}`, the two-moment quantity in the numerator of the display. -/
def rowS (lam : κ → ℝ) (R : κ → κ → ℝ) (γ : κ) : ℝ := ∑ α, lam α ^ 2 * R γ α

/-- `Q_γ = ∑_{αβ} λ_α λ_β T_{γαβ}`. -/
def rowQ (lam : κ → ℝ) (T : κ → κ → κ → ℝ) (γ : κ) : ℝ :=
  ∑ α, ∑ β, lam α * lam β * T γ α β

/-- `g_γ = 2 S_γ - 2 Q_γ`, the record's own decomposition of the per-direction quantity. -/
def rowg (lam : κ → ℝ) (R : κ → κ → ℝ) (T : κ → κ → κ → ℝ) (γ : κ) : ℝ :=
  2 * rowS lam R γ - 2 * rowQ lam T γ

/-! ## The identity -/

/-- **THE PER-DIRECTION IDENTITY.** With `Q_γ` determined by criticality as `2(θλ_γ - λ_γ²)`, the
decomposition solves for `θ` outright at every `γ` with `λ_γ > 0`. *It is an equation, not a
bound, which is the record's point about why it cannot close.* -/
theorem per_direction_identity {lam : κ → ℝ} {R : κ → κ → ℝ} {T : κ → κ → κ → ℝ} {θ : ℝ} {γ : κ}
    (hpos : 0 < lam γ)
    (hcrit : rowQ lam T γ = 2 * (θ * lam γ - lam γ ^ 2)) :
    θ = rowS lam R γ / (2 * lam γ) + lam γ - rowg lam R T γ / (4 * lam γ) := by
  have hne : lam γ ≠ 0 := ne_of_gt hpos
  unfold rowg
  rw [hcrit]
  field_simp
  ring

/-- **THE SLACK IS EXACTLY `g_γ/(4λ_γ)`.** The record's headline: the per-direction bound's gap
carries the symmetry defect and nothing else. -/
theorem slack_exact {lam : κ → ℝ} {R : κ → κ → ℝ} {T : κ → κ → κ → ℝ} {θ : ℝ} {γ : κ}
    (hpos : 0 < lam γ)
    (hcrit : rowQ lam T γ = 2 * (θ * lam γ - lam γ ^ 2)) :
    (rowS lam R γ / (2 * lam γ) + lam γ) - θ = rowg lam R T γ / (4 * lam γ) := by
  rw [per_direction_identity (R := R) hpos hcrit]; ring

/-- **The per-direction bound**, what is left after `g_γ ≥ 0` is dropped. -/
theorem per_direction_bound {lam : κ → ℝ} {R : κ → κ → ℝ} {T : κ → κ → κ → ℝ} {θ : ℝ} {γ : κ}
    (hpos : 0 < lam γ)
    (hcrit : rowQ lam T γ = 2 * (θ * lam γ - lam γ ^ 2))
    (hg : 0 ≤ rowg lam R T γ) :
    θ ≤ rowS lam R γ / (2 * lam γ) + lam γ := by
  have hslack := slack_exact (R := R) hpos hcrit
  have : 0 ≤ rowg lam R T γ / (4 * lam γ) := div_nonneg hg (by linarith)
  linarith

/-- **THE BOUND IS AN EQUALITY EXACTLY WHERE `g_γ` VANISHES**, the record's "equality at every
`Δ = 0` critical point". -/
theorem equality_iff_g_zero {lam : κ → ℝ} {R : κ → κ → ℝ} {T : κ → κ → κ → ℝ} {θ : ℝ} {γ : κ}
    (hpos : 0 < lam γ)
    (hcrit : rowQ lam T γ = 2 * (θ * lam γ - lam γ ^ 2)) :
    θ = rowS lam R γ / (2 * lam γ) + lam γ ↔ rowg lam R T γ = 0 := by
  have hslack := slack_exact (R := R) hpos hcrit
  have h4 : (4 : ℝ) * lam γ ≠ 0 := by positivity
  constructor
  · intro h
    have : rowg lam R T γ / (4 * lam γ) = 0 := by linarith
    exact (div_eq_zero_iff.mp this).resolve_right h4
  · intro h
    rw [h] at hslack
    simp at hslack
    linarith

/-! ## The decomposition returns the two moments the record already holds -/

/-- **Weight `1` returns `∑ g = 4(n-1)`.** With every row marginal equal to `2(n-2)`
([Lemma L153](../../../findings/bounds.md), the Killing mass), unit norm, and the definitional
`∑_γ Q_γ = -2‖W‖²`, the contraction gives `2·2(n-2) + 4 = 4(n-1)`. -/
theorem sum_g_recovers_first_moment {lam : κ → ℝ} {R : κ → κ → ℝ} {T : κ → κ → κ → ℝ} {n : ℝ}
    (hmarg : ∀ α, ∑ γ, R γ α = 2 * (n - 2))
    (hnorm : ∑ α, lam α ^ 2 = 1)
    (hQsum : ∑ γ, rowQ lam T γ = -2) :
    ∑ γ, rowg lam R T γ = 4 * (n - 1) := by
  have hS : ∑ γ, rowS lam R γ = 2 * (n - 2) := by
    unfold rowS
    rw [Finset.sum_comm]
    have : ∀ α ∈ (Finset.univ : Finset κ), ∑ γ, lam α ^ 2 * R γ α = lam α ^ 2 * (2 * (n - 2)) := by
      intro α _
      rw [← Finset.mul_sum, hmarg α]
    rw [Finset.sum_congr rfl this, ← Finset.sum_mul, hnorm, one_mul]
  unfold rowg
  rw [Finset.sum_sub_distrib, ← Finset.mul_sum, ← Finset.mul_sum, hS, hQsum]
  ring

/-- **Weight `λ` returns `∑ λ g = -4θ`.** With the per-row identity `∑_γ λ_γ R_{γα} = -2λ_α`, the
definitional `∑_γ λ_γ Q_γ = 2⟨W#, W⟩`, and `θ = tr W³ + ⟨W#, W⟩` at unit norm, the contraction
gives `-4θ` exactly. -/
theorem sum_lam_g_recovers_second_moment {lam : κ → ℝ} {R : κ → κ → ℝ} {T : κ → κ → κ → ℝ}
    {θ trCubeVal sharpPairVal : ℝ}
    (hrow : ∀ α, ∑ γ, lam γ * R γ α = -2 * lam α)
    (hcube : ∑ α, lam α ^ 3 = trCubeVal)
    (hQlam : ∑ γ, lam γ * rowQ lam T γ = 2 * sharpPairVal)
    (hP : θ = trCubeVal + sharpPairVal) :
    ∑ γ, lam γ * rowg lam R T γ = -4 * θ := by
  have hS : ∑ γ, lam γ * rowS lam R γ = -2 * trCubeVal := by
    unfold rowS
    have h1 : ∀ γ, lam γ * ∑ α, lam α ^ 2 * R γ α = ∑ α, lam α ^ 2 * (lam γ * R γ α) := by
      intro γ; rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun α _ => by ring
    rw [Finset.sum_congr rfl fun γ _ => h1 γ, Finset.sum_comm]
    have h2 : ∀ α ∈ (Finset.univ : Finset κ),
        ∑ γ, lam α ^ 2 * (lam γ * R γ α) = lam α ^ 2 * (-2 * lam α) := by
      intro α _
      rw [← Finset.mul_sum, hrow α]
    rw [Finset.sum_congr rfl h2]
    have : ∀ α ∈ (Finset.univ : Finset κ), lam α ^ 2 * (-2 * lam α) = -2 * lam α ^ 3 := by
      intro α _; ring
    rw [Finset.sum_congr rfl this, ← Finset.mul_sum, hcube]
  have hsplit : ∀ γ, lam γ * rowg lam R T γ
      = 2 * (lam γ * rowS lam R γ) - 2 * (lam γ * rowQ lam T γ) := by
    intro γ; unfold rowg; ring
  rw [Finset.sum_congr rfl fun γ _ => hsplit γ, Finset.sum_sub_distrib,
    ← Finset.mul_sum, ← Finset.mul_sum, hS, hQlam, hP]
  ring

end HamiltonsCubic.L110Statement
