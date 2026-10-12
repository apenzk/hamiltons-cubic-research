import Mathlib

set_option linter.style.longLine false

/-!
# I104's `x → κᵢ` link, as scalar algebra

## What this file is

[I104](../../../plan.md)'s remaining live source is the coupling bound
`κᵢ ≤ (uᵢ/√3)(t - uᵢ²)`, whose slack its [note](../../../reviews/2026-09-14-I104-tau-positive.md)
describes as `rᵢ` still carrying the other two patterns, *"confined by the rank-one structure to the
single `êᵢ` channel"*. **That confinement is a number, and this file types it.**

With `Q₁ = {i,j,k,l}`, `Q₂ = {i,j,m,p}`, `Q₃ = {k,l,m,p}`, write `xₐ` for each plane's coefficient on
its first pairing, `c` for `q₁`'s, and `p = r₁[i,j]`, `p' = r₁[k,l]` with `r₁ = D - q₁`.

**The geometry the record already proves**, and which this file takes as HYPOTHESES rather than
establishing: `q₁ ∈ Π_{Q₁}` has equal entries at `ij` and `kl`, since those two pairs share one
pairing; `D_{ij} = x₁ + x₂` and `D_{kl} = x₁ + x₃`, since `Q₃` misses `ij` and `Q₂` misses `kl`; and
`c = x₁ + (x₂ + x₃)/3`, which is the cross-Gram having rank one with principal cosine exactly `1/3`.

## What is proved

* `shared_channel_sum`: `p + p' = (x₂ + x₃)/3`. *The link itself.*
* `channel_norm_lower`: `(x₂ + x₃)²/18 ≤ p² + p'²`. **This is the form step 8 can consume**, since its
  quadratic form carries `p² + p'²` against `x̂`, not `p + p'`. *The constant is `1/18` because
  `p² + p'² ≥ (p+p')²/2` and the link divides by three, so `1/2 · 1/9`.*
* `channel_bound_sharp`: the inequality is attained exactly at `p = p'`, so nothing is lost by it
  beyond the split between the two channels, which is genuinely unpinned.

## What Gate 2 changed, and it changed three things

**Gate 2 landed** ([r986](../../../reviews/REVIEW_r986.md), [r987](../../../reviews/REVIEW_r987.md),
identical cold briefs).

* **The link is STRONGER than first stated.** Both readers refuted the claim that only `p + p'` is
  determined. `shared_channels` and `channel_norm_exact` below carry the identity that replaces it,
  and `exact_implies_bound` shows the inequality throws away `(x₂-x₃)²/2`.
* **The SCOPE was coordinates, not mathematics.** Written in the pairing sums the relation is
  unconditional, which is `shared_channel_sum_unconditional` below. `hD_ij` and `hD_kl` are where the
  span hypothesis enters the `x`-form, and that form alone is scoped.
* **A SYMBOL COLLISION, and it is this file's as much as the brief's.** The record's cross-Gram
  statement `⟪q₁,q₂⟫ = x₁x₂` is true of the PROJECTION coefficients, `⟪q₁,q₂⟫ = c₁c₂`, while the `xₐ`
  of the derivation here are COMPONENT coefficients, the two related by `cₐ = (2/3)xₐ + (1/3)S` with
  `S = x₁+x₂+x₃`. *Confirmed independently, 600 of 600 draws each way.* **The `x₂`, `x₃` in every
  statement below are COMPONENT coefficients.**

## What is NOT stated

The hypotheses above, which are the record's own plane geometry, and the orthogonality that
`shared_channel_sum_unconditional` takes as `h₁` and `h₂`.

**AND THE ROUTE THIS FED IS RETIRED ON SIZE, which no declaration here shows.** *Spent inside the
coupling expansion the gain is `(μ - x)(p² + p'²)‖q‖` with `μ = max(x,y,z)`, so its coefficient is
never negative and the sign worry does not bite. But with every factor at its own extreme the ceiling
is `0.0090` against a `0.0148` deficit, `60.8%` of it.* **So these identities are correct, sharp, and
insufficient for the item that motivated them**, which is a fact about the item and not about them.
-/

namespace HamiltonsCubic.I104XKappaLink

/-- **The link.** The shared-channel content of `r₁` is `(x₂ + x₃)/3`.

*`hc` is the cross-Gram's rank-one structure at principal cosine `1/3`; `hD_ij` and `hD_kl` are where
the hypothesis that `D` lies in the span of the three planes enters, and they are false off it.* -/
theorem shared_channel_sum (x₁ x₂ x₃ c p p' D_ij D_kl : ℝ)
    (hc : c = x₁ + (x₂ + x₃) / 3)
    (hD_ij : D_ij = x₁ + x₂) (hD_kl : D_kl = x₁ + x₃)
    (hp : p = D_ij - c) (hp' : p' = D_kl - c) :
    p + p' = (x₂ + x₃) / 3 := by
  subst hc; subst hD_ij; subst hD_kl; subst hp; subst hp'; ring

/-- **The form step 8 can consume.** Its quadratic form carries `p² + p'²`, not `p + p'`, so the
link is spent through `p² + p'² ≥ (p+p')²/2`.

*The constant is `1/18`: one half from the two channels, one ninth from the link's `1/3`.* -/
theorem channel_norm_lower (x₂ x₃ p p' : ℝ) (h : p + p' = (x₂ + x₃) / 3) :
    (x₂ + x₃) ^ 2 / 18 ≤ p ^ 2 + p' ^ 2 := by
  have key : (x₂ + x₃) ^ 2 / 18 = (p + p') ^ 2 / 2 := by rw [h]; ring
  rw [key]
  nlinarith [sq_nonneg (p - p')]

/-- **And the bound is attained exactly at `p = p'`**, so it gives away only the split between the
two channels, which the geometry genuinely does not pin. -/
theorem channel_bound_sharp (x₂ x₃ p p' : ℝ) (h : p + p' = (x₂ + x₃) / 3) (hpp : p = p') :
    (x₂ + x₃) ^ 2 / 18 = p ^ 2 + p' ^ 2 := by
  have key : (x₂ + x₃) ^ 2 / 18 = (p + p') ^ 2 / 2 := by rw [h]; ring
  rw [key, hpp]; ring

/-- **`p` and `p'` SEPARATELY**, which the parent recorded as impossible and both Gate 2 readers
refuted. *The parent tested one guess, `p = x₂/3`, and read its failure as non-existence.* -/
theorem shared_channels (x₁ x₂ x₃ c p p' D_ij D_kl : ℝ)
    (hc : c = x₁ + (x₂ + x₃) / 3)
    (hD_ij : D_ij = x₁ + x₂) (hD_kl : D_kl = x₁ + x₃)
    (hp : p = D_ij - c) (hp' : p' = D_kl - c) :
    p = (2 * x₂ - x₃) / 3 ∧ p' = (2 * x₃ - x₂) / 3 := by
  subst hc; subst hD_ij; subst hD_kl; subst hp; subst hp'
  constructor <;> ring

/-- **So the channel norm is an IDENTITY, not merely a lower bound.** -/
theorem channel_norm_exact (x₂ x₃ p p' : ℝ)
    (hp : p = (2 * x₂ - x₃) / 3) (hp' : p' = (2 * x₃ - x₂) / 3) :
    p ^ 2 + p' ^ 2 = (5 * x₂ ^ 2 + 5 * x₃ ^ 2 - 8 * x₂ * x₃) / 9 := by
  subst hp; subst hp'; ring

/-- **And the identity implies `channel_norm_lower`, throwing away exactly `(x₂-x₃)²/2`**, which
vanishes precisely at `x₂ = x₃`, agreeing with `channel_bound_sharp`. -/
theorem exact_implies_bound (x₂ x₃ : ℝ) :
    (x₂ + x₃) ^ 2 / 18 + (x₂ - x₃) ^ 2 / 2
      = (5 * x₂ ^ 2 + 5 * x₃ ^ 2 - 8 * x₂ * x₃) / 9 := by
  ring

/-- **THE UNCONDITIONAL FORM, which needs no hypothesis on `D` at all.** With `S₁, S₂, S₃` the three
pairing sums of `D` on `Q₁`, orthogonality of `D - q₁` to `Π_{Q₁}` says `2a - S₁`, `2b - S₂`,
`2c' - S₃` are all equal, and `a + b + c' = 0` because `q₁ ∈ Π_{Q₁}`. Then `p + p' = (S₁+S₂+S₃)/3`.

*This retires the SCOPE the parent recorded: the relation fails off the span only when written in
`x₂ + x₃`, and holds everywhere when written in the pairing sums.* -/
theorem shared_channel_sum_unconditional (S₁ S₂ S₃ a b c' p p' : ℝ)
    (hsum : a + b + c' = 0)
    (h₁ : 2 * a - S₁ = 2 * b - S₂) (h₂ : 2 * b - S₂ = 2 * c' - S₃)
    (hp : p + p' = S₁ - 2 * a) :
    p + p' = (S₁ + S₂ + S₃) / 3 := by
  linarith

end HamiltonsCubic.I104XKappaLink
