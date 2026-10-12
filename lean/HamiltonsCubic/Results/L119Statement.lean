import Mathlib

set_option linter.style.longLine false

/-!
# L119, stated and proved as a theorem about the `g`-spectrum

## The record's statement, verbatim

> #### Lemma L119, the sharpened $\lambda$-weighted bound
> $\theta\le[\lvert\lambda_{\min}\rvert M-\lambda_{\mathfrak p}^{\min}\Delta]/4$

with the display and its ingredients, from the same file:

> $$4\theta=A-B,\qquad A:=\sum_{\gamma\in\mathfrak m}|\lambda_\gamma|g_\gamma,\qquad
> B:=\sum_{\gamma\in\mathfrak p}\lambda_\gamma g_\gamma,$$
> $$\theta\ \le\ \frac{|\lambda_{\min}|\,M-\lambda_{\mathfrak p}^{\min}\,\Delta}{4},\qquad
> M=4(n-1)-\Delta-G_0 .$$

> **THE BOUND HOLDS AT EVERY UNIT $W\in\mathcal W_n$, $n\ge4$, AND CONSUMES NO CRITICALITY.**
> The identity $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$ needs total symmetry of $T$ with the
> Bianchi and trace relations (that is, $W\in\mathrm{Weyl}_n$) and nothing more. Both discards
> raise the right-hand side, which is the only composable combination. **But the unit-norm
> hypothesis was dropped, in the very sentence widening the scope**: the right-hand side scales
> as $s^3$ while $\theta$ is scale-free, so the bound is false off $\lVert W\rVert=1$.

[bounds-relaxations.md](../../../findings/bounds-relaxations.md), Lemma L119.

## What this file states, and what it takes as given

The two identities are the record's inputs, **Petersen–Wink Proposition 1.3** on the eigenbasis,
holding at every `W ∈ Weyl_n` and consuming no criticality, and they enter as hypotheses,
written at unit norm, which is where `θ = P(W)` and where the record's display is the true one.
`g γ = ‖[ad(v_γ), W]‖²` is nonnegative by construction, and that is the third hypothesis.

**Everything the record derives from them is proved here**: that `M` is the `g`-mass on the
negative eigenspace, the splitting identity `4θ = A - B`, both discards, the bound itself, that
it is never weaker than the recorded `θ ≤ |λ_min| M / 4`, and that it is strictly stronger
wherever `Δ > 0`, the last because `λ_𝔭^min > 0` strictly, `𝔭` being the *strictly* positive
eigenspace, which is the record's own reason.

**The unit-norm hypothesis is kept.** It is carried by `htotal`, whose right-hand side is
`4(n-1)` rather than `4(n-1)‖W‖²`.
-/

namespace HamiltonsCubic.L119

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {n : ℕ} {lam g : ι → ℝ} {θ : ℝ}

/-- `𝔪`, the strictly negative eigenspace. -/
noncomputable def mm (lam : ι → ℝ) : Finset ι := Finset.univ.filter (fun γ => lam γ < 0)

/-- `𝔭`, the strictly positive eigenspace. -/
noncomputable def pp (lam : ι → ℝ) : Finset ι := Finset.univ.filter (fun γ => 0 < lam γ)

/-- The kernel. -/
noncomputable def kk (lam : ι → ℝ) : Finset ι := Finset.univ.filter (fun γ => lam γ = 0)

/-- `Δ`, the `g`-mass on the positive eigenspace. -/
noncomputable def Delta (lam g : ι → ℝ) : ℝ := ∑ γ ∈ pp lam, g γ

/-- `G₀`, the `g`-mass on the kernel. -/
noncomputable def G0 (lam g : ι → ℝ) : ℝ := ∑ γ ∈ kk lam, g γ

/-- `M = 4(n-1) - Δ - G₀`, exactly as the record writes it. -/
noncomputable def Mmass (n : ℕ) (lam g : ι → ℝ) : ℝ :=
  4 * ((n : ℝ) - 1) - Delta lam g - G0 lam g

/-- `A`, the `g`-weighted mass of `|λ|` on `𝔪`. -/
noncomputable def Aterm (lam g : ι → ℝ) : ℝ := ∑ γ ∈ mm lam, |lam γ| * g γ

/-- `B`, the `g`-weighted mass of `λ` on `𝔭`. -/
noncomputable def Bterm (lam g : ι → ℝ) : ℝ := ∑ γ ∈ pp lam, lam γ * g γ

/-- The three eigenvalue signs partition the index set. -/
theorem sum_split (f : ι → ℝ) :
    ∑ γ, f γ = (∑ γ ∈ mm lam, f γ) + (∑ γ ∈ pp lam, f γ) + ∑ γ ∈ kk lam, f γ := by
  classical
  have h : ∀ γ : ι, γ ∈ (Finset.univ : Finset ι) →
      f γ = (if lam γ < 0 then f γ else 0) + (if 0 < lam γ then f γ else 0)
        + (if lam γ = 0 then f γ else 0) := by
    intro γ _
    rcases lt_trichotomy (lam γ) 0 with h1 | h1 | h1
    · simp [h1, not_lt.mpr h1.le, ne_of_lt h1]
    · simp [h1]
    · simp [not_lt.mpr h1.le, h1, ne_of_gt h1]
  rw [Finset.sum_congr rfl h]
  simp [Finset.sum_add_distrib, mm, pp, kk, Finset.sum_filter]

/-- **`M` is the `g`-mass on the negative eigenspace**, which is what makes the first discard
`A ≤ |λ_min| M` available. -/
theorem Mmass_eq (htotal : ∑ γ, g γ = 4 * ((n : ℝ) - 1)) :
    Mmass n lam g = ∑ γ ∈ mm lam, g γ := by
  have := sum_split (lam := lam) g
  rw [htotal] at this
  unfold Mmass Delta G0
  linarith

/-- **The splitting identity `4θ = A - B`.** It is an identity, not an inequality: the kernel
contributes nothing because `λ` vanishes there. -/
theorem four_theta (hmoment : ∑ γ, lam γ * g γ = -4 * θ) :
    4 * θ = Aterm lam g - Bterm lam g := by
  have hs := sum_split (lam := lam) (fun γ => lam γ * g γ)
  have hker : ∑ γ ∈ kk lam, lam γ * g γ = 0 := by
    refine Finset.sum_eq_zero fun γ hγ => ?_
    have : lam γ = 0 := by simpa [kk, Finset.mem_filter] using hγ
    simp [this]
  have hneg : ∑ γ ∈ mm lam, lam γ * g γ = -Aterm lam g := by
    unfold Aterm
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun γ hγ => ?_
    have : lam γ < 0 := by simpa [mm, Finset.mem_filter] using hγ
    rw [abs_of_neg this]; ring
  rw [hmoment, hker, hneg] at hs
  unfold Bterm
  linarith

/-- **The first discard: `A ≤ |λ_min| M`.** Every negative eigenvalue has modulus at most
`|λ_min|`, and `M` is the `g`-mass carrying them. -/
theorem Aterm_le (hg : ∀ γ, 0 ≤ g γ) (lmin : ℝ) (hlmin : ∀ γ, lmin ≤ lam γ)
    (htotal : ∑ γ, g γ = 4 * ((n : ℝ) - 1)) :
    Aterm lam g ≤ |lmin| * Mmass n lam g := by
  rw [Mmass_eq htotal, Finset.mul_sum]
  refine Finset.sum_le_sum fun γ hγ => ?_
  have hneg : lam γ < 0 := by simpa [mm, Finset.mem_filter] using hγ
  have hlm : lmin < 0 := lt_of_le_of_lt (hlmin γ) hneg
  have : |lam γ| ≤ |lmin| := by
    rw [abs_of_neg hneg, abs_of_neg hlm]
    linarith [hlmin γ]
  exact mul_le_mul_of_nonneg_right this (hg γ)

/-- **The second discard: `λ_𝔭^min Δ ≤ B`.** -/
theorem le_Bterm (hg : ∀ γ, 0 ≤ g γ) (lp : ℝ) (hlp : ∀ γ ∈ pp lam, lp ≤ lam γ) :
    lp * Delta lam g ≤ Bterm lam g := by
  unfold Bterm Delta
  rw [Finset.mul_sum]
  exact Finset.sum_le_sum fun γ hγ => mul_le_mul_of_nonneg_right (hlp γ hγ) (hg γ)

/-- **L119.** At every unit `W ∈ 𝒲ₙ`, `θ ≤ [|λ_min| M - λ_𝔭^min Δ] / 4`.

`htotal` and `hmoment` are the record's two Petersen–Wink identities, written at unit norm;
`hlmin` says `lmin` is a lower bound for the spectrum and `hlp` that `lp` is a lower bound for
its strictly positive part. -/
theorem sharpened_bound (hg : ∀ γ, 0 ≤ g γ)
    (htotal : ∑ γ, g γ = 4 * ((n : ℝ) - 1))
    (hmoment : ∑ γ, lam γ * g γ = -4 * θ)
    (lmin lp : ℝ) (hlmin : ∀ γ, lmin ≤ lam γ) (hlp : ∀ γ ∈ pp lam, lp ≤ lam γ) :
    θ ≤ (|lmin| * Mmass n lam g - lp * Delta lam g) / 4 := by
  have hid := four_theta (lam := lam) (g := g) (θ := θ) hmoment
  have h1 := Aterm_le (n := n) hg lmin hlmin htotal
  have h2 := le_Bterm (lam := lam) (g := g) hg lp hlp
  linarith

/-- **The recorded, unsharpened bound `θ ≤ |λ_min| M / 4`**, which is L119 with `B` discarded
outright. -/
theorem recorded_bound (hg : ∀ γ, 0 ≤ g γ)
    (htotal : ∑ γ, g γ = 4 * ((n : ℝ) - 1))
    (hmoment : ∑ γ, lam γ * g γ = -4 * θ)
    (lmin : ℝ) (hlmin : ∀ γ, lmin ≤ lam γ) :
    θ ≤ |lmin| * Mmass n lam g / 4 := by
  have hid := four_theta (lam := lam) (g := g) (θ := θ) hmoment
  have h1 := Aterm_le (n := n) hg lmin hlmin htotal
  have h2 : 0 ≤ Bterm lam g := by
    unfold Bterm
    refine Finset.sum_nonneg fun γ hγ => ?_
    have : 0 < lam γ := by simpa [pp, Finset.mem_filter] using hγ
    exact mul_nonneg this.le (hg γ)
  linarith

/-- **`Δ ≥ 0`**, so the sharpened bound is never weaker than the recorded one. -/
theorem Delta_nonneg (hg : ∀ γ, 0 ≤ g γ) : 0 ≤ Delta lam g :=
  Finset.sum_nonneg fun γ _ => hg γ

/-- **Never weaker**: the gap between the two right-hand sides is `λ_𝔭^min Δ / 4 ≥ 0`. -/
theorem sharpened_le_recorded (hg : ∀ γ, 0 ≤ g γ) (lmin lp : ℝ) (hlp0 : 0 ≤ lp) :
    (|lmin| * Mmass n lam g - lp * Delta lam g) / 4 ≤ |lmin| * Mmass n lam g / 4 := by
  have := mul_nonneg hlp0 (Delta_nonneg (lam := lam) hg)
  linarith

/-- **Strictly stronger wherever `Δ > 0`, with no exceptional points.** The record's reason is
that `𝔭` is the *strictly* positive eigenspace, so its minimum is strictly positive. -/
theorem sharpened_lt_recorded (lmin lp : ℝ) (hlp : 0 < lp) (hDelta : 0 < Delta lam g) :
    (|lmin| * Mmass n lam g - lp * Delta lam g) / 4 < |lmin| * Mmass n lam g / 4 := by
  have := mul_pos hlp hDelta
  linarith

/-- **`λ_𝔭^min > 0` whenever `𝔭` is nonempty**, which is what makes the previous theorem's
hypothesis automatic. Tracelessness supplies the nonemptiness, proved as
[L119Gain.lean](L119Gain.lean)'s `p_nonempty`. -/
theorem inf_pos_of_nonempty (h : (pp lam).Nonempty) : 0 < (pp lam).inf' h lam := by
  rw [Finset.lt_inf'_iff]
  intro γ hγ
  simpa [pp, Finset.mem_filter] using hγ

/-! ## A witness, so the hypotheses are not empty

*Two indices at `n = 4`, spectrum `(1,-1)` and `g = (6,6)`. Both identities hold with `θ = 0`,
the positive eigenspace is nonempty, and the bound is attained: `Δ = 6`, `G₀ = 0`, `M = 6`,
`|λ_min| = 1`, `λ_𝔭^min = 1`, right-hand side `(6 - 6)/4 = 0 = θ`.*

**This is a witness for the hypotheses as stated, not a Weyl tensor.** -/

/-- The witness spectrum. -/
def witLam : Fin 2 → ℝ := ![1, -1]

/-- The witness `g`-vector. -/
def witG : Fin 2 → ℝ := ![6, 6]

theorem wit_nonneg : ∀ γ, 0 ≤ witG γ := by
  intro γ; fin_cases γ <;> norm_num [witG]

theorem wit_total : ∑ γ, witG γ = 4 * ((4 : ℕ) - 1 : ℝ) := by
  norm_num [witG, Fin.sum_univ_two]

theorem wit_moment : ∑ γ, witLam γ * witG γ = -4 * (0 : ℝ) := by
  norm_num [witLam, witG, Fin.sum_univ_two]

/-- **The witness attains the bound**, so the inequality is not vacuously loose. -/
theorem wit_saturates :
    (|(-1 : ℝ)| * Mmass 4 witLam witG - 1 * Delta witLam witG) / 4 = 0 := by
  have hp : pp witLam = {0} := by
    ext γ
    simp only [pp, Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_singleton]
    fin_cases γ <;> norm_num [witLam]
  have hk : kk witLam = ∅ := by
    ext γ
    simp only [kk, Finset.mem_filter, Finset.mem_univ, true_and, Finset.notMem_empty,
      iff_false]
    fin_cases γ <;> norm_num [witLam]
  norm_num [Mmass, Delta, G0, hp, hk, witG]

end HamiltonsCubic.L119
