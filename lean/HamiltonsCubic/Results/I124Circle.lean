import Mathlib

/-!
# I124: the great circle through the diagonal part is a strict descent direction above `θ₀`

[The I124 working note](../../../reviews/2026-09-28q-I124-ascent.md), batch 1. In any orthonormal
frame write a unit critical Weyl tensor `W = a Â + b ν` with `Â` the unit diagonal part and `ν` the
unit off-diagonal part, `a² + b² = 1`, `a, b > 0`. The diagonal Weyl tensors of a frame are closed
under `Q`, so `⟨Q(Â), ν⟩ = 0`, and along the great circle through `Â` and `ν`
`P = p cos³φ + 3r cos φ sin²φ + q sin³φ`, `p = P(Â)`, `r = ⟨Â ∘ ν, ν⟩`, `q = P(ν)`. At `W`
(`cos φ = a`, `sin φ = b`) its second derivative is `3E` with
`E = p(2ab² − a³) + r(2a³ − 7ab²) + q(2a²b − b³)`. The components of `Q(W) = θW` along `Â` and `ν`
read `θa = a²p + b²r` and `θb = 2abr + b²q`, and they give `b² E = 2ap − θ(1 + a²)`
(`circle_second`), so `P'' ≤ −3θ(1 − a)²/b² < 0` as soon as `p ≤ θ` (`circle_descent`), which
[L57](../../../findings/problem.md) supplies at every `θ ≥ Θ_n`. The identity is L214's two
relations and its inequality in circle coordinates (`L214_frame`, `L214_frame_cap`); what is new is the
strict bound at every critical point above `Θ_n` (Gate 2 r1916, r1918).

**Typed**: the identity and the descent bound. **Not typed**: `⟨Q(Â), ν⟩ = 0`, the cubic's
restriction to the circle, and the second derivative of that trigonometric polynomial; they enter as
the definition of `E` and the two component equations.
-/

namespace HamiltonsCubic.I124Circle

/-- `P''/3` on the great circle through the diagonal part, at the point `(cos φ, sin φ) = (a, b)`. -/
def E (a b p r q : ℝ) : ℝ :=
  p * (2 * a * b ^ 2 - a ^ 3) + r * (2 * a ^ 3 - 7 * a * b ^ 2) + q * (2 * a ^ 2 * b - b ^ 3)

/-- **The circle's second variation in closed form**: the two components of `Q(W) = θW` and
`a² + b² = 1` give `b² E = 2ap − θ(1 + a²)`. -/
theorem circle_second (a b p r q θ : ℝ) (hab : a ^ 2 + b ^ 2 = 1)
    (h1 : θ * a = a ^ 2 * p + b ^ 2 * r) (h2 : θ * b = 2 * a * b * r + b ^ 2 * q) :
    b ^ 2 * E a b p r q = 2 * a * p - θ * (1 + a ^ 2) := by
  unfold E
  linear_combination (a * (2 * a ^ 2 + 5 * b ^ 2)) * h1 - (2 * a ^ 2 * b - b ^ 3) * h2 +
    (2 * a * p * (a ^ 2 + b ^ 2 + 1) - θ * (2 * a ^ 2 + b ^ 2 + 1)) * hab

/-- **Strict descent above the diagonal value**: with `p = P(Â) ≤ θ`, `0 ≤ a < 1` and `θ > 0`,
`b² E ≤ −θ(1 − a)² < 0`. -/
theorem circle_descent (a b p r q θ : ℝ) (hab : a ^ 2 + b ^ 2 = 1)
    (h1 : θ * a = a ^ 2 * p + b ^ 2 * r) (h2 : θ * b = 2 * a * b * r + b ^ 2 * q)
    (ha0 : 0 ≤ a) (ha1 : a < 1) (hθ : 0 < θ) (hp : p ≤ θ) :
    b ^ 2 * E a b p r q ≤ -θ * (1 - a) ^ 2 ∧ b ^ 2 * E a b p r q < 0 := by
  rw [circle_second a b p r q θ hab h1 h2]
  have h3 : 2 * a * p ≤ 2 * a * θ := by nlinarith
  refine ⟨by nlinarith, ?_⟩
  have h4 : 0 < θ * (1 - a) ^ 2 := by
    have : 0 < (1 - a) ^ 2 := by nlinarith
    positivity
  nlinarith

/-- **The single-character decoupled value** (the note's batch 6): with `q = 0` the component
equations give `a²(3r − p) = r` and `θ = 2ar`, so `θ²(3r − p) = 4r³`. -/
theorem single_char_value (a b p r θ : ℝ) (hab : a ^ 2 + b ^ 2 = 1) (hb : b ≠ 0)
    (h1 : θ * a = a ^ 2 * p + b ^ 2 * r) (h2 : θ * b = 2 * a * b * r + b ^ 2 * 0) :
    θ = 2 * a * r ∧ a ^ 2 * (3 * r - p) = r ∧ θ ^ 2 * (3 * r - p) = 4 * r ^ 3 := by
  have hθ : θ = 2 * a * r := by
    have : (θ - 2 * a * r) * b = 0 := by linear_combination h2
    rcases mul_eq_zero.mp this with h | h
    · linarith
    · exact absurd h hb
  have ha : a ^ 2 * (3 * r - p) = r := by
    rw [hθ] at h1
    linear_combination h1 + r * hab
  refine ⟨hθ, ha, ?_⟩
  rw [hθ]
  linear_combination (4 * r ^ 2) * ha

/-- **Batch 8's coefficient**: above the diagonal value (`p ≤ θ`, `θ > 0`) and off the diagonal locus
(`0 < a < 1`), the `D` component of criticality `b²π_D(ν∘ν) = a(θ − ap)Â` has a positive coefficient,
so `Â` is a positive multiple of `π_D(ν∘ν)`. -/
theorem diag_coeff_pos (a p θ : ℝ) (ha0 : 0 < a) (ha1 : a < 1) (hθ : 0 < θ) (hp : p ≤ θ) :
    0 < a * (θ - a * p) := by
  apply mul_pos ha0
  rcases le_or_gt p 0 with h | h
  · nlinarith
  · nlinarith

/-- **Batch 9, the pair-character elimination**: two distinct nonzero values `u ≠ v` of `x`, both
roots of `t³ + (s + μ)t − 2σ₃` (the `(j,i)` rows of the diagonal criticality equation), with the
`(i,i')` row `μ = 3uv + 2s − 2(u² + v²)` and `s = ‖x‖² ≥ u² + v²`, force `v = −u` and
`s = u² + v²`: the support of `x` is those two indices. -/
theorem pair_char_supp (u v s μ σ : ℝ) (huv : u ≠ v)
    (hA1 : u ^ 3 + (s + μ) * u - 2 * σ = 0) (hA2 : v ^ 3 + (s + μ) * v - 2 * σ = 0)
    (hB : μ = 3 * u * v + 2 * s - 2 * (u ^ 2 + v ^ 2)) (hs : u ^ 2 + v ^ 2 ≤ s) :
    v = -u ∧ s = u ^ 2 + v ^ 2 := by
  have h1 : (u - v) * (u ^ 2 + u * v + v ^ 2 + s + μ) = 0 := by linear_combination hA1 - hA2
  have h2 : u ^ 2 + u * v + v ^ 2 + s + μ = 0 := by
    rcases mul_eq_zero.mp h1 with h | h
    · exact absurd (sub_eq_zero.mp h) huv
    · exact h
  have h3 : 3 * s = u ^ 2 - 4 * u * v + v ^ 2 := by rw [hB] at h2; linarith
  have h4 : (u + v) ^ 2 = 0 := by nlinarith [sq_nonneg (u + v)]
  have h5 : u + v = 0 := by simpa using h4
  refine ⟨by linarith, ?_⟩
  have hv : v = -u := by linarith
  subst hv
  nlinarith

/-- Non-vacuity of `pair_char_supp`: `x = (1, −1)`, `s = 2`, `μ = −3`, `σ₃ = 0`. -/
example : (-1 : ℝ) = -1 ∧ (2 : ℝ) = 1 ^ 2 + (-1) ^ 2 :=
  pair_char_supp 1 (-1) 2 (-3) 0 (by norm_num) (by norm_num) (by norm_num) (by norm_num) (by norm_num)

/-- **Batch 10, the superposition bound**: `P(W) = Σ_χ w_χ² P(W_χ) + P(N)` with `Σ w_χ² = 1`, and each
single-character value `P(W_χ) ≤ Θ` (L224 for a pair character, L220 with L57 for a four-set, at
`n ≥ 12`), give `P(W) ≤ Θ + P(N)`. -/
theorem superposition_bound {ι : Type*} (s : Finset ι) (w vals : ι → ℝ) (Θ PW PN : ℝ)
    (hsum : ∑ i ∈ s, w i ^ 2 = 1) (hcap : ∀ i ∈ s, vals i ≤ Θ)
    (hid : PW = ∑ i ∈ s, w i ^ 2 * vals i + PN) : PW ≤ Θ + PN := by
  have h : ∑ i ∈ s, w i ^ 2 * vals i ≤ ∑ i ∈ s, w i ^ 2 * Θ :=
    Finset.sum_le_sum fun i hi => mul_le_mul_of_nonneg_left (hcap i hi) (sq_nonneg _)
  rw [← Finset.sum_mul, hsum, one_mul] at h
  linarith

/-- Non-vacuity: the hypotheses of `circle_descent` hold together, at `a = 3/5`, `b = 4/5`,
`p = 1`, `θ = 2`, with `r` and `q` solved from the two component equations. -/
example : ((3 : ℝ) / 5) ^ 2 + (4 / 5) ^ 2 = 1 ∧
    (2 : ℝ) * (3 / 5) = (3 / 5) ^ 2 * 1 + (4 / 5) ^ 2 * (21 / 16) ∧
    (2 : ℝ) * (4 / 5) = 2 * (3 / 5) * (4 / 5) * (21 / 16) + (4 / 5) ^ 2 * (17 / 32) := by
  norm_num

end HamiltonsCubic.I124Circle
