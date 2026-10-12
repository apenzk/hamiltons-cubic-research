import Mathlib.Analysis.Convex.Function
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity

/-!
# `t³ + 3mt²` is strictly convex above `-m`, and the gap factors

[L52](L52.lean)'s equality case rests on the strict convexity of `t³ + 3mt²` above `-m`. **The
convexity is elementary and is carried here**, and the equality case needs no Karamata
([DoublyStochasticEq.lean](DoublyStochasticEq.lean)).

**The gap factors completely.** For weights `a + b = 1` and `u = ax + by`,

`a·g(x) + b·g(y) - g(u) = ab(x-y)²·(x + y + u + 3m)`

with `g(t) = t³ + 3mt²`. No calculus enters: the cubic part contributes `ab(x-y)²(x+y+u)` by the
difference of cubes, and the quadratic part `3m·ab(x-y)²`, and they combine.

**So the support condition is exactly what the convexity needs.** Strictness asks
`x + y + u + 3m > 0`, and `x, y > -m` gives `u > -m` too, hence `x + y + u > -3m`. **The
constant `m` the block carries as a spectral lower bound is precisely the hypothesis that makes
`g` strictly convex**, the two are the same condition, which the block states as two.

`strictConvexOn_g` and `strictConcaveOn_h` below carry the strictness to the closed ranges `[-m, ∞)` and `(-∞, M]`,
which L52's equality clause uses through [DoublyStochasticEq.lean](DoublyStochasticEq.lean) with no Karamata.
-/

namespace HamiltonsCubic.CubicConvexity

/-- The block's `g`. -/
def g (m t : ℝ) : ℝ := t ^ 3 + 3 * m * t ^ 2

/-! ## The gap factors -/

/-- **The convexity gap in closed form.** -/
theorem gap_factors (m x y a b : ℝ) (hab : a + b = 1) :
    a * g m x + b * g m y - g m (a * x + b * y)
      = a * b * (x - y) ^ 2 * (x + y + (a * x + b * y) + 3 * m) := by
  have hb : b = 1 - a := by linarith
  subst hb; unfold g; ring

/-! ## Strictness is the support condition -/

/-- **The interpolant stays above `-m`.** -/
theorem interpolant_above {m x y a b : ℝ} (hx : -m < x) (hy : -m < y)
    (ha : 0 ≤ a) (hb : 0 ≤ b) (hab : a + b = 1) : -m < a * x + b * y := by
  have key : a * x + b * y + m = a * (x + m) + b * (y + m) := by
    have hb' : b = 1 - a := by linarith
    subst hb'; ring
  have hxm : (0:ℝ) < x + m := by linarith
  have hym : (0:ℝ) < y + m := by linarith
  have hpos : 0 < a * (x + m) + b * (y + m) := by
    rcases eq_or_lt_of_le ha with h | h
    · have hb1 : b = 1 := by linarith
      rw [← h, hb1]; linarith
    · nlinarith [mul_nonneg hb (le_of_lt hym)]
  linarith [key, hpos]

/-- **Hence the factor is positive**, which is the whole of strictness. -/
theorem factor_pos {m x y a b : ℝ} (hx : -m < x) (hy : -m < y)
    (ha : 0 ≤ a) (hb : 0 ≤ b) (hab : a + b = 1) :
    0 < x + y + (a * x + b * y) + 3 * m := by
  have hu := interpolant_above hx hy ha hb hab
  linarith

/-- **`g` is strictly convex above `-m`.** -/
theorem strict_convex {m x y a b : ℝ} (hx : -m < x) (hy : -m < y) (hxy : x ≠ y)
    (ha : 0 < a) (hb : 0 < b) (hab : a + b = 1) :
    g m (a * x + b * y) < a * g m x + b * g m y := by
  have hfac := factor_pos hx hy (le_of_lt ha) (le_of_lt hb) hab
  have hsq : (0:ℝ) < (x - y) ^ 2 := by
    have hne : x - y ≠ 0 := sub_ne_zero.2 hxy
    positivity
  have hprod : 0 < a * b * (x - y) ^ 2 * (x + y + (a * x + b * y) + 3 * m) :=
    mul_pos (mul_pos (mul_pos ha hb) hsq) hfac
  linarith [gap_factors m x y a b hab, hprod]

/-- And convex, without strictness, at coincident points or zero weights. -/
theorem convex_nonstrict {m x y a b : ℝ} (hx : -m < x) (hy : -m < y)
    (ha : 0 ≤ a) (hb : 0 ≤ b) (hab : a + b = 1) :
    g m (a * x + b * y) ≤ a * g m x + b * g m y := by
  have hfac := factor_pos hx hy ha hb hab
  have hprod : 0 ≤ a * b * (x - y) ^ 2 * (x + y + (a * x + b * y) + 3 * m) :=
    mul_nonneg (mul_nonneg (mul_nonneg ha hb) (sq_nonneg _)) (le_of_lt hfac)
  linarith [gap_factors m x y a b hab, hprod]

/-! ## Strictness on the closed ranges -/

/-- **`g` is strictly convex on `[-m, ∞)`, endpoint included**: the factor is
`(x + m) + (y + m) + (a(x + m) + b(y + m))`, each term nonnegative and one positive at `x ≠ y`. -/
theorem strictConvexOn_g (m : ℝ) : StrictConvexOn ℝ (Set.Ici (-m)) (g m) := by
  refine ⟨convex_Ici _, fun x hx y hy hxy a b ha hb hab => ?_⟩
  simp only [Set.mem_Ici] at hx hy
  have hfac : 0 < x + y + (a * x + b * y) + 3 * m := by
    have key : x + y + (a * x + b * y) + 3 * m = (x + m) + (y + m) + (a * (x + m) + b * (y + m)) := by
      have hb' : b = 1 - a := by linarith
      subst hb'; ring
    rw [key]
    rcases lt_or_eq_of_le hx with h | h
    · nlinarith [mul_nonneg ha.le (show 0 ≤ x + m by linarith), mul_nonneg hb.le (show 0 ≤ y + m by linarith)]
    · have hy' : -m < y := lt_of_le_of_ne hy (fun e => hxy (h.symm.trans e))
      nlinarith [mul_nonneg ha.le (show 0 ≤ x + m by linarith), mul_nonneg hb.le (show 0 ≤ y + m by linarith)]
  have hsq : (0 : ℝ) < (x - y) ^ 2 := by have : x - y ≠ 0 := sub_ne_zero.2 hxy; positivity
  have hprod : 0 < a * b * (x - y) ^ 2 * (x + y + (a * x + b * y) + 3 * m) :=
    mul_pos (mul_pos (mul_pos ha hb) hsq) hfac
  have := gap_factors m x y a b hab
  simp only [smul_eq_mul]
  linarith

/-- **`t³ − 3M t²` is strictly concave on `(-∞, M]`**, being `-g M (-t)`. -/
theorem strictConcaveOn_h (M : ℝ) : StrictConcaveOn ℝ (Set.Iic M) (fun t => t ^ 3 - 3 * M * t ^ 2) := by
  have hg := strictConvexOn_g M
  refine ⟨convex_Iic _, fun x hx y hy hxy a b ha hb hab => ?_⟩
  simp only [Set.mem_Iic] at hx hy
  have h := hg.2 (show -x ∈ Set.Ici (-M) from by simp; linarith) (show -y ∈ Set.Ici (-M) from by simp; linarith)
    (by intro e; exact hxy (neg_inj.mp e)) ha hb hab
  simp only [smul_eq_mul, g] at h ⊢
  nlinarith [h]

end HamiltonsCubic.CubicConvexity
