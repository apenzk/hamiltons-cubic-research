import Mathlib.Tactic

/-!
# Lemma L212, the multi-block vertex solution's second moment and the scale it forces

[findings/graded-half.md](../../../findings/graded-half.md), the L212 block.

**What the block establishes.** For a partition `n = ∑ n_a` with every `n_a ≥ 2`, the coordinate
diagonal Weyl operator with sectional matrix `K` is a critical point, its ordered-pair second
moment is `t = 8R` identically, and at unit norm `θ² = 1/(4R)`, where
`R = (k-1)/8 + (1/8)(∑ 1/(n_a-1) - 1/(n-1))` is the record's multi-block norm identity.

## What is typed here, and what is not

**`second_moment_eq` IS STEP 3 AT EVERY `k`**, over a `Finset` of blocks with real sizes, and it
is the step Gate 2 strengthened from a screen at nine partitions to an identity ([r922], [r923],
each by its own division). Its engine is `block_term_eq`, the exact division that makes
`m(n-m)² - (n-1)²` divisible by `m - 1`. `scale_of_t_eq_two` and `theta_sq_of_unit_norm` then
carry the scale, and `theta_lt_bound` the bound.

**Not typed**: criticality, `Q(W) = θ_g W`, which is the block's step 2 and the thing that lets
the chain stop consuming [L46](../../../findings/problem.md). *It needs the operator `Φ(M) =
M^{∘2} + M²` on a partition-indexed sectional matrix, and the layer carries no such object.*

**And the naming is now honest.** *An earlier version of this file carried
`theta_eq_inv_two_norm`, which was `scale_of_t_eq_two` character for character with the alias as
its proof, while `‖W‖ = √R` lived only in a docstring. Both Gate 2 readers caught it.* The
identification of `c` with `θ` is criticality, and it is absent from this layer, so no theorem
here mentions `W`, `t` or `θ`.
-/

namespace HamiltonsCubic.Results

open Finset

/-- **THE EXACT DIVISION STEP 3 TURNS ON.** `m(n-m)² - (n-1)²` vanishes at `m = 1`, so `m - 1`
divides it, with the quotient below. *This is what makes the second moment rational in each
block size with no remainder, and it is why the identity holds at every `k` rather than at the
partitions a screen reaches.* -/
theorem block_div (n m : ℝ) :
    m * (n - m) ^ 2 - (n - 1) ^ 2 = (m - 1) * (m ^ 2 + (1 - 2 * n) * m + (n - 1) ^ 2) := by
  ring

/-- **The per-block term of the second moment, split.** With `m ≠ 1` and `n ≠ 1`, the block's
contribution is `1/(m-1)` plus a polynomial over `(n-1)²`. *The first piece is what assembles
into `∑ 1/(n_a - 1)`, which is the only part of `R` that is not counting.* -/
theorem block_term_eq {n m : ℝ} (hm : m ≠ 1) (hn : n ≠ 1) :
    m * (n - m) ^ 2 / ((n - 1) ^ 2 * (m - 1))
      = 1 / (m - 1) + (m ^ 2 + (1 - 2 * n) * m + (n - 1) ^ 2) / (n - 1) ^ 2 := by
  have hm' : m - 1 ≠ 0 := sub_ne_zero.mpr hm
  have hn' : n - 1 ≠ 0 := sub_ne_zero.mpr hn
  field_simp
  ring

/-- **STEP 3, AT EVERY `k` AND EVERY PARTITION.** Over a finite set of blocks with sizes `sz`,
each at least two and summing to `n`, the ordered-pair second moment of the vertex solution at
eigenvalue one is
`k - 1 - 1/(n-1) + ∑ 1/(sz a - 1)`,
which is `8R`. *The hypotheses are exactly the block's: every block at least two, and `n` the SUM
of the blocks rather than an ambient dimension, which is the reading the census records as false
at a padded copy.* -/
theorem second_moment_eq {ι : Type*} (s : Finset ι) (sz : ι → ℝ) (n : ℝ)
    (h2 : ∀ a ∈ s, 2 ≤ sz a) (hn : n = ∑ a ∈ s, sz a) (hn1 : 1 < n) :
    (∑ a ∈ s, sz a * (n - sz a) ^ 2 / ((n - 1) ^ 2 * (sz a - 1)))
        + (n ^ 2 - ∑ a ∈ s, sz a ^ 2) / (n - 1) ^ 2
      = (s.card : ℝ) - 1 - 1 / (n - 1) + ∑ a ∈ s, 1 / (sz a - 1) := by
  have hne : n ≠ 1 := ne_of_gt hn1
  have hn' : n - 1 ≠ 0 := sub_ne_zero.mpr hne
  have hsq : (n - 1) ^ 2 ≠ 0 := pow_ne_zero _ hn'
  -- split every block's term through `block_term_eq`
  have hsplit : (∑ a ∈ s, sz a * (n - sz a) ^ 2 / ((n - 1) ^ 2 * (sz a - 1)))
      = (∑ a ∈ s, 1 / (sz a - 1))
        + (∑ a ∈ s, (sz a ^ 2 + (1 - 2 * n) * sz a + (n - 1) ^ 2)) / (n - 1) ^ 2 := by
    rw [sum_div]
    rw [← sum_add_distrib]
    refine sum_congr rfl fun a ha => ?_
    have : sz a ≠ 1 := by have := h2 a ha; intro h; rw [h] at this; norm_num at this
    exact block_term_eq this hne
  rw [hsplit]
  -- the polynomial part sums to a closed form in `n`, `card` and `∑ sz a ^ 2`
  have hpoly : (∑ a ∈ s, (sz a ^ 2 + (1 - 2 * n) * sz a + (n - 1) ^ 2))
      = (∑ a ∈ s, sz a ^ 2) + (1 - 2 * n) * n + (s.card : ℝ) * (n - 1) ^ 2 := by
    rw [sum_add_distrib, sum_add_distrib, ← mul_sum, ← hn, sum_const, nsmul_eq_mul]
  rw [hpoly]
  have key : ((∑ a ∈ s, sz a ^ 2) + (1 - 2 * n) * n + (s.card : ℝ) * (n - 1) ^ 2) / (n - 1) ^ 2
      + (n ^ 2 - ∑ a ∈ s, sz a ^ 2) / (n - 1) ^ 2
      = (s.card : ℝ) - 1 - 1 / (n - 1) := by
    field_simp
    ring
  linarith [key]

/-- **The scale that unit norm forces**, from `t = 8R` at eigenvalue one, `t` scaling as `c²`,
and `t = 2‖W‖²` on the coordinate-diagonal locus. -/
theorem scale_of_t_eq_two {R c : ℝ} (hR : 0 < R) (hc : 0 < c) (ht : 8 * R * c ^ 2 = 2) :
    c = 1 / (2 * Real.sqrt R) := by
  have hsr : 0 < Real.sqrt R := Real.sqrt_pos.mpr hR
  have hsq : Real.sqrt R ^ 2 = R := Real.sq_sqrt hR.le
  have h4 : (2 * Real.sqrt R) ^ 2 * c ^ 2 = 1 := by
    have : (2 * Real.sqrt R) ^ 2 = 4 * R := by rw [mul_pow]; rw [hsq]; ring
    rw [this]; nlinarith [ht]
  have hpos : 0 < 2 * Real.sqrt R := by positivity
  have : (2 * Real.sqrt R * c) ^ 2 = 1 ^ 2 := by rw [mul_pow]; simpa using h4
  have hprod : 2 * Real.sqrt R * c = 1 :=
    by nlinarith [this, mul_pos hpos hc]
  field_simp at hprod ⊢
  linarith [hprod]

/-- **THE CONCLUSION, WITH THE NORM RELATION AS A BINDER RATHER THAN A DOCSTRING.** `hnorm` is
`‖W‖² = 4Rc²`, which is `t = 8Rc²` read through `‖W‖² = t/2` on the diagonal locus, so unit norm
says `4Rc² = 1`. The eigenvalue there squares to `1/(4R)`.

*This is the statement the block makes. What it is NOT is `θ = 1/(2‖W‖)`: at unit norm `‖W‖ = 1`,
and `‖W‖² = R` holds at a different representative of the same family, which is the confusion
Gate 2 refuted.* -/
theorem theta_sq_of_unit_norm {R c : ℝ} (hR : 0 < R) (hnorm : 4 * R * c ^ 2 = 1) :
    c ^ 2 = 1 / (4 * R) := by
  have : (4 : ℝ) * R ≠ 0 := by positivity
  field_simp
  linarith [hnorm]

/-- **And the bound follows from `R > (k-1)/8`**, which every `n_a ≥ 2` supplies. *At `k ≥ 2` the
inequality is strict, so the bound is `<` rather than `≤`.* -/
theorem theta_lt_bound {R k : ℝ} (hk : 1 < k) (hR : (k - 1) / 8 < R) :
    1 / (2 * Real.sqrt R) < Real.sqrt (2 / (k - 1)) := by
  have hk1 : 0 < k - 1 := by linarith
  have hRpos : 0 < R := lt_trans (by positivity) hR
  have hsr : 0 < Real.sqrt R := Real.sqrt_pos.mpr hRpos
  have hsq : Real.sqrt R ^ 2 = R := Real.sq_sqrt hRpos.le
  have key : 2 / (k - 1) > (1 / (2 * Real.sqrt R)) ^ 2 := by
    have : (1 / (2 * Real.sqrt R)) ^ 2 = 1 / (4 * R) := by
      rw [div_pow, one_pow, mul_pow]; rw [hsq]; norm_num
    rw [this]
    have hgap : 2 / (k - 1) - 1 / (4 * R) = (8 * R - (k - 1)) / (4 * R * (k - 1)) := by
      field_simp; ring
    have hnum : 0 < 8 * R - (k - 1) := by linarith
    have : 0 < 2 / (k - 1) - 1 / (4 * R) := by
      rw [hgap]; positivity
    linarith
  have hlhs : 0 < 1 / (2 * Real.sqrt R) := by positivity
  nlinarith [Real.sq_sqrt (le_of_lt (show (0:ℝ) < 2 / (k - 1) by positivity)),
    Real.sqrt_pos.mpr (show (0:ℝ) < 2 / (k - 1) by positivity), key, hlhs]

end HamiltonsCubic.Results

#print axioms HamiltonsCubic.Results.block_div
#print axioms HamiltonsCubic.Results.block_term_eq
#print axioms HamiltonsCubic.Results.second_moment_eq
#print axioms HamiltonsCubic.Results.scale_of_t_eq_two
#print axioms HamiltonsCubic.Results.theta_sq_of_unit_norm
#print axioms HamiltonsCubic.Results.theta_lt_bound
