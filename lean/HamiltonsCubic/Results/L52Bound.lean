import HamiltonsCubic.Results.SchurMajor
import HamiltonsCubic.Results.CubicConvexity

set_option linter.style.longLine false

/-!
# L52, the shared-frame bound, for any two real symmetric matrices

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L52: with `K` the diagonal of `M`
and `K'` that of `W̊` in the stipulated basis, `μ_i ≤ M₊`, `ω_i ≥ −m`, `∑ μ² = 1`, `∑ ω² = 3`,

`(3/2) p₃(μ) − (1/2) p₃(ω) ≤ (3/2)[p₃(K) + 3M₊(1 − p₂(K))] − (1/2)[p₃(K') + 3m(p₂(K') − 3)]`,

the left side being `θ` by [L50](L50Spectra.lean). **This file proves the inequality for any two
real symmetric matrices `A`, `B`** with those spectral bounds, the record's own argument:

- `convexOn_g`: `t³ + 3mt²` is convex on `[−m, ∞)`, from
  [CubicConvexity.lean](CubicConvexity.lean)'s `gap_factors`, whose last factor is `≥ 0` there;
- `concaveOn_h`: `t³ − 3M₊t²` is concave on `(−∞, M₊]`, the reflection of the same;
- `sum_convexOn_diag`: Jensen row by row over the doubly stochastic `P` of
  [SchurMajor.lean](SchurMajor.lean)'s `diag_doublyStochastic`, collapsing by column sums;
- `L52_matrix_bound`: the display.

The instantiation at the record's objects is [L52Frame.lean](L52Frame.lean)'s `L52_record` and
[L52S20.lean](L52S20.lean)'s `L52_record_S20`, and the equality clause's matrix form is
[L52Equality.lean](L52Equality.lean).
-/

namespace HamiltonsCubic.L52Bound

open Finset HamiltonsCubic.L54Statement

variable {N : Type*} [Fintype N] [DecidableEq N]

/-- **`t³ + 3mt²` is convex on `[−m, ∞)`.** -/
theorem convexOn_g (m : ℝ) : ConvexOn ℝ (Set.Ici (-m)) (CubicConvexity.g m) := by
  refine ⟨convex_Ici _, fun x hx y hy a b ha hb hab => ?_⟩
  simp only [Set.mem_Ici] at hx hy
  simp only [smul_eq_mul]
  have hgap := CubicConvexity.gap_factors m x y a b hab
  have hu : -m ≤ a * x + b * y := by
    have : a * x + b * y + m = a * (x + m) + b * (y + m) := by
      have hb' : b = 1 - a := by linarith
      subst hb'; ring
    nlinarith [mul_nonneg ha (by linarith : (0:ℝ) ≤ x + m), mul_nonneg hb (by linarith : (0:ℝ) ≤ y + m)]
  have hfac : 0 ≤ x + y + (a * x + b * y) + 3 * m := by linarith
  have := mul_nonneg (mul_nonneg (mul_nonneg ha hb) (sq_nonneg (x - y))) hfac
  linarith

/-- **`t³ − 3M₊t²` is concave on `(−∞, M₊]`**, the reflection `t ↦ −t` of `convexOn_g M₊`. -/
theorem concaveOn_h (Mp : ℝ) : ConcaveOn ℝ (Set.Iic Mp) (fun t => t ^ 3 - 3 * Mp * t ^ 2) := by
  refine ⟨convex_Iic _, fun x hx y hy a b ha hb hab => ?_⟩
  simp only [Set.mem_Iic] at hx hy
  simp only [smul_eq_mul]
  have hc := (convexOn_g Mp).2 (x := -x) (y := -y) (by simp; linarith) (by simp; linarith) ha hb hab
  simp only [smul_eq_mul, CubicConvexity.g] at hc
  nlinarith [hc]

/-- **Jensen over a doubly stochastic diagonal**: for `f` convex on `S` and every `x_j ∈ S`,
`∑_i f(∑_j P_ij x_j) ≤ ∑_j f(x_j)`. -/
theorem sum_convexOn_diag {S : Set ℝ} {f : ℝ → ℝ} (hf : ConvexOn ℝ S f)
    {P : N → N → ℝ} (hP : DoublyStochastic.IsDoublyStochastic P) (x : N → ℝ) (hx : ∀ j, x j ∈ S) :
    ∑ i, f (∑ j, P i j * x j) ≤ ∑ j, f (x j) := by
  calc ∑ i, f (∑ j, P i j * x j) ≤ ∑ i, ∑ j, P i j * f (x j) := by
        refine sum_le_sum fun i _ => ?_
        have := hf.map_sum_le (t := univ) (w := P i) (p := x) (fun j _ => hP.nonneg i j) (hP.rows i)
          (fun j _ => hx j)
        simpa [smul_eq_mul] using this
    _ = ∑ j, f (x j) := by
        rw [sum_comm]
        exact sum_congr rfl fun j _ => by rw [← sum_mul, hP.cols j, one_mul]

/-- The concave form. -/
theorem sum_concaveOn_diag {S : Set ℝ} {f : ℝ → ℝ} (hf : ConcaveOn ℝ S f)
    {P : N → N → ℝ} (hP : DoublyStochastic.IsDoublyStochastic P) (x : N → ℝ) (hx : ∀ j, x j ∈ S) :
    ∑ j, f (x j) ≤ ∑ i, f (∑ j, P i j * x j) := by
  have := sum_convexOn_diag hf.neg hP x hx
  simp only [Pi.neg_apply, sum_neg_distrib, neg_le_neg_iff] at this
  exact this

/-- **L52's DISPLAY**, for real symmetric `A` (spectrum `μ ≤ M₊`, `∑ μ² = 1`) and `B` (spectrum
`ω ≥ −m`, `∑ ω² = 3`) with diagonals `K`, `K'`. -/
theorem L52_matrix_bound {P Q : Type*} [Fintype P] [DecidableEq P] [Fintype Q] [DecidableEq Q]
    (A : Matrix P P ℝ) (hA : A.IsHermitian) (B : Matrix Q Q ℝ) (hB : B.IsHermitian) (Mp m : ℝ)
    (hμ : ∀ j, hA.eigenvalues j ≤ Mp) (hω : ∀ j, -m ≤ hB.eigenvalues j)
    (hμ2 : ∑ j, hA.eigenvalues j ^ 2 = 1) (hω2 : ∑ j, hB.eigenvalues j ^ 2 = 3) :
    (3 / 2) * ∑ j, hA.eigenvalues j ^ 3 - (1 / 2) * ∑ j, hB.eigenvalues j ^ 3
      ≤ (3 / 2) * (∑ i, A i i ^ 3 + 3 * Mp * (1 - ∑ i, A i i ^ 2))
        - (1 / 2) * (∑ i, B i i ^ 3 + 3 * m * (∑ i, B i i ^ 2 - 3)) := by
  obtain ⟨PA, hPA, hdA⟩ := diag_doublyStochastic A hA
  obtain ⟨PB, hPB, hdB⟩ := diag_doublyStochastic B hB
  -- `M`: concavity of `t³ − 3M₊t²` on `(−∞, M₊]`
  have h1 := sum_concaveOn_diag (concaveOn_h Mp) hPA hA.eigenvalues (fun j => hμ j)
  simp only [← hdA] at h1
  -- `W̊`: convexity of `t³ + 3mt²` on `[−m, ∞)`
  have h2 := sum_convexOn_diag (convexOn_g m) hPB hB.eigenvalues (fun j => hω j)
  simp only [← hdB, CubicConvexity.g] at h2
  simp only [sum_sub_distrib, sum_add_distrib, ← mul_sum] at h1 h2
  rw [hμ2] at h1
  rw [hω2] at h2
  nlinarith [h1, h2]

end HamiltonsCubic.L52Bound
