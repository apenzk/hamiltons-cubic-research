import Mathlib

set_option linter.style.longLine false

/-!
# L218, the off-diagonal coupling at a diagonal point is exactly `√3/2`

[second-order.md](../../../findings/second-order.md)'s Lemma L218, which settles [I99](../../../plan.md).
For a unit coordinate-diagonal `D` with sectional matrix `K` (hollow, `Σ_{a<b} K_ab² = 1`), `L_D`
preserves each four-set block and each pair block of `𝒟ₙ^⊥` ([L120](../../../findings/second-order.md)).
The four-set block's eigenvalues are `±½ √(A²+B²+C²-AB-BC-CA)` ([L121](../../../findings/second-order.md)),
and the pair block is `½ [diag(d) - κ Id + S]` with `d_i = K_ji + K_ki`, `κ = K_jk` and `S` the hollow
submatrix off `{j,k}` ([L122](../../../findings/second-order.md)). This file proves the two block bounds
and that each is attained.

* `fourset_disc_le`, `fourset_top_le`: the four-set eigenvalue is at most `√3/2`.
* `pair_block_le_sqrt3`: the pair block's bracketed form is at most `√3` at unit `x`, being a linear
  functional of `K` whose coefficient vector has squared norm exactly `3`.
* `theta_even_sq_gt_three_quarters`, `theta_odd_sq_gt_three_quarters`: `Θₙ² > 3/4` at every `n ≥ 5`,
  from the even and the odd formula, so `Λₙ = √3/2 < Θₙ`.

**Not typed here**: `𝒲ₙ`, `L_D`, the block decomposition and the two block formulas, which enter through
the hypotheses on `(a, …, f)` and on `(a, b, κ, S)`.
-/

namespace HamiltonsCubic.L218

open Finset

/-! ## The four-set block -/

/-- **The four-set discriminant is at most `3`**: with `A = a+b`, `B = c+d`, `C = e+f` the three
opposite-pair sums over six distinct entries whose squares sum to at most `1`. -/
theorem fourset_disc_le {a b c d e f : ℝ} (h : a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2 + e ^ 2 + f ^ 2 ≤ 1) :
    (a + b) ^ 2 + (c + d) ^ 2 + (e + f) ^ 2 - (a + b) * (c + d) - (c + d) * (e + f) - (e + f) * (a + b) ≤ 3 := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (c - d), sq_nonneg (e - f), sq_nonneg (a + b + c + d + e + f)]

/-- **The four-set eigenvalue is at most `√3/2`.** -/
theorem fourset_top_le {a b c d e f : ℝ} (h : a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2 + e ^ 2 + f ^ 2 ≤ 1) :
    (1 / 2) * Real.sqrt ((a + b) ^ 2 + (c + d) ^ 2 + (e + f) ^ 2 - (a + b) * (c + d) - (c + d) * (e + f) - (e + f) * (a + b))
      ≤ Real.sqrt 3 / 2 := by
  have h1 := Real.sqrt_le_sqrt (fourset_disc_le h)
  linarith

/-! ## The pair block -/

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

set_option linter.unusedDecidableInType false in
/-- **The pair block's bracketed form is at most `√3` at unit `x`.** With `a i = K_ji`, `b i = K_ki`,
`κ = K_jk` and `S` the hollow symmetric submatrix off `{j,k}`, the unit normalisation
`Σ_{a<b} K_ab² = 1` bounds `Σ a² + Σ b² + κ² + ½ Σ_{i,l} S_il²`. The form is `⟨K, G_x⟩` with `G_x`
carrying `x_i²` on `K_ji` and `K_ki`, `-1` on `K_jk` and `2 x_i x_l` on `K_il`, and
`‖G_x‖² = 2Σx⁴ + 1 + 2(1 - Σx⁴) = 3`; the proof is Cauchy–Schwarz in its AM–GM form, term by term. -/
theorem pair_block_le_sqrt3 (a b x : ι → ℝ) (κ : ℝ) (S : ι → ι → ℝ)
    (hS : ∀ i, S i i = 0) (hx : ∑ i, x i ^ 2 = 1)
    (hK : ∑ i, a i ^ 2 + ∑ i, b i ^ 2 + κ ^ 2 + (1 / 2) * ∑ i, ∑ l, S i l ^ 2 ≤ 1) :
    ∑ i, (a i + b i) * x i ^ 2 - κ * ∑ i, x i ^ 2 + ∑ i, ∑ l, S i l * x i * x l ≤ Real.sqrt 3 := by
  set r := Real.sqrt 3 with hrdef
  have hr : r ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have hr0 : 0 < r := Real.sqrt_pos.mpr (by norm_num)
  have h1 : ∀ i, r * ((a i + b i) * x i ^ 2) ≤ 3 / 2 * a i ^ 2 + 3 / 2 * b i ^ 2 + x i ^ 4 := fun i => by
    have ha : (r * a i) ^ 2 = 3 * a i ^ 2 := by rw [mul_pow, hr]
    have hb : (r * b i) ^ 2 = 3 * b i ^ 2 := by rw [mul_pow, hr]
    nlinarith [sq_nonneg (r * a i - x i ^ 2), sq_nonneg (r * b i - x i ^ 2)]
  have h3 : ∀ i l, r * (S i l * x i * x l)
      ≤ 3 / 4 * S i l ^ 2 + x i ^ 2 * x l ^ 2 - (if i = l then x l ^ 4 else 0) := by
    intro i l
    split_ifs with h
    · subst h
      rw [hS]
      nlinarith
    · have hy : (r * S i l / 2) ^ 2 = 3 / 4 * S i l ^ 2 := by rw [div_pow, mul_pow, hr]; ring
      nlinarith [sq_nonneg (r * S i l / 2 - x i * x l)]
  have hk : -(r * κ) ≤ 3 / 2 * κ ^ 2 + 1 / 2 := by
    have hkk : (r * κ) ^ 2 = 3 * κ ^ 2 := by rw [mul_pow, hr]
    nlinarith [sq_nonneg (r * κ + 1)]
  have s1 : r * ∑ i, (a i + b i) * x i ^ 2 ≤ 3 / 2 * ∑ i, a i ^ 2 + 3 / 2 * ∑ i, b i ^ 2 + ∑ i, x i ^ 4 := by
    have := Finset.sum_le_sum (fun i (_ : i ∈ (univ : Finset ι)) => h1 i)
    simp only [Finset.sum_add_distrib, ← Finset.mul_sum] at this
    linarith
  have e1 : ∑ i, ∑ l, x i ^ 2 * x l ^ 2 = 1 := by
    rw [← Finset.sum_mul_sum, hx]; norm_num
  have e2 : ∑ i, ∑ l, (if i = l then x l ^ 4 else 0) = ∑ i, x i ^ 4 := by
    simp [Finset.sum_ite_eq]
  have s3 : r * ∑ i, ∑ l, S i l * x i * x l ≤ 3 / 4 * ∑ i, ∑ l, S i l ^ 2 + 1 - ∑ i, x i ^ 4 := by
    calc r * ∑ i, ∑ l, S i l * x i * x l = ∑ i, ∑ l, r * (S i l * x i * x l) := by
          simp only [Finset.mul_sum]
      _ ≤ ∑ i, ∑ l, (3 / 4 * S i l ^ 2 + x i ^ 2 * x l ^ 2 - (if i = l then x l ^ 4 else 0)) :=
          Finset.sum_le_sum fun i _ => Finset.sum_le_sum fun l _ => h3 i l
      _ = 3 / 4 * ∑ i, ∑ l, S i l ^ 2 + ∑ i, ∑ l, x i ^ 2 * x l ^ 2
            - ∑ i, ∑ l, (if i = l then x l ^ 4 else 0) := by
          simp only [Finset.sum_sub_distrib, Finset.sum_add_distrib, Finset.mul_sum]
      _ = 3 / 4 * ∑ i, ∑ l, S i l ^ 2 + 1 - ∑ i, x i ^ 4 := by rw [e1, e2]
  have key : r * (∑ i, (a i + b i) * x i ^ 2 - κ * ∑ i, x i ^ 2 + ∑ i, ∑ l, S i l * x i * x l) ≤ r * r := by
    have hexp : r * (∑ i, (a i + b i) * x i ^ 2 - κ * ∑ i, x i ^ 2 + ∑ i, ∑ l, S i l * x i * x l)
        = r * ∑ i, (a i + b i) * x i ^ 2 - r * κ * ∑ i, x i ^ 2 + r * ∑ i, ∑ l, S i l * x i * x l := by ring
    rw [hexp, hx]
    nlinarith [s1, s3, hk, hK, hr]
  exact le_of_mul_le_mul_left key hr0

/-! ## Against the diagonal maximum -/

/-- **`θ₀(n)² = 2(n-1)(n-2)/n² > 3/4` at every `n ≥ 5`**, the even formula for `Θₙ`: it is `(5n-4)(n-4) > 0`. -/
theorem theta_even_sq_gt_three_quarters {n : ℝ} (hn : 5 ≤ n) : (3 : ℝ) / 4 < 2 * (n - 1) * (n - 2) / n ^ 2 := by
  have hpos : 0 < n ^ 2 := by positivity
  rw [lt_div_iff₀ hpos]
  nlinarith

/-- **`2(n-1)(n-3)/((n+1)(n-2)) > 3/4` at every `n ≥ 5`**, the odd formula for `Θₙ`: it is `5n² - 29n + 30 > 0`. -/
theorem theta_odd_sq_gt_three_quarters {n : ℝ} (hn : 5 ≤ n) :
    (3 : ℝ) / 4 < 2 * (n - 1) * (n - 3) / ((n + 1) * (n - 2)) := by
  have hpos : 0 < (n + 1) * (n - 2) := by nlinarith
  rw [lt_div_iff₀ hpos]
  nlinarith

/-- The four-set bound is attained at padded `S² × S²`: `K₁₂ = K₃₄ = 2/√12`, cross entries `-1/√12`,
unit and Ricci-flat, with discriminant `3`, in the scaled form `a = b = 2`, the four cross entries `-1`, over `12`. -/
example : ((2 : ℝ) + 2) ^ 2 + (-1 + -1) ^ 2 + (-1 + -1) ^ 2 - (2 + 2) * (-1 + -1) - (-1 + -1) * (-1 + -1) - (-1 + -1) * (2 + 2) = 3 * 12
    ∧ (2 : ℝ) ^ 2 + 2 ^ 2 + 4 * (-1) ^ 2 = 12 := by
  norm_num

/-- The pair bound is attained at `K = G_x/√3` for unit `x ⊥ 𝟏`; at two indices, `x = (1,-1)/√2`, scaled by
`√3`: `a = b = (1/2, 1/2)`, `κ = -1`, `S₀₁ = S₁₀ = -1` give form `3` and normalisation `3`. -/
example : (1 / 2 + 1 / 2 : ℝ) * (1 / 2) * 2 - (-1) * 1 + 2 * ((-1) * (1 / 2) * (-1)) = 3
    ∧ (4 * (1 / 2 : ℝ) ^ 2 + (-1) ^ 2 + (1 / 2) * (2 * (-1) ^ 2) = 3 * (1 / 2) * 2) := by
  norm_num

end HamiltonsCubic.L218
