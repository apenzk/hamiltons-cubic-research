import Mathlib

/-!
# L182, stated with its own constants

[second-order.md](../../../findings/second-order.md)'s Lemma L182 says the product `λ(n) F(n)` is
bounded below uniformly in `n`, so the `Ω(1/n)` radius needs no separate argument at large `n`.
**Every constant in it is closed-form real analysis and needs no curvature base layer**, which is
why it is typed here rather than waiting on [B1](../../../plan.md).

*One of the four results an audit found typable all along, against nine that were written as
files of constants with no statement.*
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L182

open Real

/-- `θ₀(n)² = 2(n-1)(n-2)/n²`. -/
noncomputable def theta0sq (n : ℝ) : ℝ := 2 * (n - 1) * (n - 2) / n ^ 2

/-- `θ₀(n)`. -/
noncomputable def theta0 (n : ℝ) : ℝ := Real.sqrt (theta0sq n)

/-- `λ(n) = 2 / √(9(θ₀(n) - √(3/2)))`, defined where `θ₀(n) > √(3/2)`. -/
noncomputable def lam (n : ℝ) : ℝ := 2 / Real.sqrt (9 * (theta0 n - Real.sqrt (3 / 2)))

/-- The chain [L162](../../../findings/second-order.md) composes into `F`. -/
noncomputable def cp (n : ℝ) : ℝ := 3 * theta0 n / (n - 2)
noncomputable def rhoEff (n : ℝ) : ℝ := Real.sqrt 6 - theta0 n * (n + 16) / (2 * (n - 2))
noncomputable def w0 (n : ℝ) : ℝ := (n - 4) / n
noncomputable def s0 (n : ℝ) : ℝ := Real.sqrt (cp n + rhoEff n * w0 n ^ 2)
noncomputable def Cn (n : ℝ) : ℝ := 2 * (2 * n - 3) / (n - 1)
noncomputable def beta (n : ℝ) : ℝ := lam n / (2 * Cn n)

/-- `F(n) = 4 s₀ / (√(4 β s₀ + 1) + 1)²`. -/
noncomputable def F (n : ℝ) : ℝ :=
  4 * s0 n / (Real.sqrt (4 * beta n * s0 n + 1) + 1) ^ 2

/-- `λ∞ = 2 / √(9(√2 - √(3/2)))`, the limit `λ(n)` decreases towards. -/
noncomputable def lamInf : ℝ := 2 / Real.sqrt (9 * (Real.sqrt 2 - Real.sqrt (3 / 2)))

/-! ## What is proved -/

/-- **The algebra the monotonicity is read off**: `θ₀(n)² = 2(1 - 3/n + 2/n²)`. -/
theorem theta0sq_eq (n : ℝ) (hn : n ≠ 0) :
    theta0sq n = 2 * (1 - 3 / n + 2 / n ^ 2) := by
  unfold theta0sq; field_simp; ring

/-- **The linear inequality the derivative argument reduces to**: `2(-3 + 4u) < 0` below `u = 3/4`.
*It is that inequality and not a derivative computation; `θ₀²`'s monotonicity in `n` is read off it
elsewhere, and the reversal from `u` to `n` is a step this statement does not take.* -/
theorem deriv_in_u_neg {u : ℝ} (h : u < 3 / 4) : 2 * (-3 + 4 * u) < 0 := by linarith

/-- **The crude product bound, which is the whole instrument**: `λ > λ∞` and `F ≥ F(12)` give
`λF > λ∞ F(12)` with no monotonicity of the product, which a decreasing function times an
increasing one need not have. -/
theorem product_bound {a b c d : ℝ} (hab : a < b) (hcd : c ≤ d) (ha : 0 < a) (hc : 0 < c) :
    a * c < b * d := by nlinarith

/-- **`θ₀(n)² < 2`**, which is what makes `λ` approach `λ∞` from above:
`(n-1)(n-2) = n² - 3n + 2 < n²`. *The inequality holds from `n > 2/3` upward and is stated at
`12 ≤ n`, which is where it is used.* -/
theorem theta0sq_lt_two {n : ℝ} (hn : 12 ≤ n) : theta0sq n < 2 := by
  have hn0 : (0:ℝ) < n := by linarith
  unfold theta0sq
  rw [div_lt_iff₀ (by positivity)]
  nlinarith

/-- **`θ₀(n)² > 3/2` at every `n ≥ 12`.** *This is the crossover `n² - 12n + 8 > 0`, whose roots
are `6 ± 2√7`; the record's crossover `6 + 2√7 = 11.2915` is exactly where it turns, so `n = 12`
is inside by a margin rather than on the boundary.* -/
theorem three_halves_lt_theta0sq {n : ℝ} (hn : 12 ≤ n) : 3 / 2 < theta0sq n := by
  have hn0 : (0:ℝ) < n := by linarith
  unfold theta0sq
  rw [lt_div_iff₀ (by positivity)]
  nlinarith

/-- **`√(3/2) < θ₀(n) < √2` at every `n ≥ 12`**, the two bounds above under the square root. -/
theorem theta0_bounds {n : ℝ} (hn : 12 ≤ n) :
    Real.sqrt (3 / 2) < theta0 n ∧ theta0 n < Real.sqrt 2 := by
  constructor
  · exact Real.sqrt_lt_sqrt (by norm_num) (three_halves_lt_theta0sq hn)
  · exact Real.sqrt_lt_sqrt (by linarith [three_halves_lt_theta0sq hn]) (theta0sq_lt_two hn)

/-- **The gap under `λ`'s square root is positive and below its limiting value.** -/
theorem lam_radicand_bounds {n : ℝ} (hn : 12 ≤ n) :
    0 < 9 * (theta0 n - Real.sqrt (3 / 2)) ∧
      9 * (theta0 n - Real.sqrt (3 / 2)) < 9 * (Real.sqrt 2 - Real.sqrt (3 / 2)) := by
  obtain ⟨h1, h2⟩ := theta0_bounds hn
  exact ⟨by linarith, by linarith⟩

/-- **`λ(n) > λ∞` at every `n ≥ 12`**, half of the product bound, and the half the record calls
*decreasing towards a limit, hence above it*. *`θ₀` increases to `√2` from below, so the radicand
`9(θ₀ - √(3/2))` increases to `9(√2 - √(3/2))` from below and `λ`, its reciprocal square root
doubled, decreases towards `λ∞` from above.* -/
theorem lamInf_lt_lam {n : ℝ} (hn : 12 ≤ n) : lamInf < lam n := by
  obtain ⟨hpos, hlt⟩ := lam_radicand_bounds hn
  unfold lam lamInf
  have hs : Real.sqrt (9 * (theta0 n - Real.sqrt (3 / 2)))
      < Real.sqrt (9 * (Real.sqrt 2 - Real.sqrt (3 / 2))) :=
    Real.sqrt_lt_sqrt hpos.le hlt
  have hspos : 0 < Real.sqrt (9 * (theta0 n - Real.sqrt (3 / 2))) := Real.sqrt_pos.mpr hpos
  exact div_lt_div_of_pos_left (by norm_num) hspos hs

/-- `θ₀(12)² = 55/36`, the one value of `θ₀` the floor below actually evaluates. -/
theorem theta0_twelve_sq : theta0 12 ^ 2 = 55 / 36 := by
  unfold theta0
  rw [Real.sq_sqrt (by unfold theta0sq; norm_num)]
  unfold theta0sq; norm_num

theorem theta0_twelve_pos : 0 < theta0 12 := by
  unfold theta0
  exact Real.sqrt_pos.mpr (by unfold theta0sq; norm_num)

/-! ## Rational bounds on the four surds

**EIGHT DIGITS IS THE PRECISION THE FLOOR NEEDS, AND SIX IS NOT ENOUGH.** *Chaining six-digit bounds
through `θ₀(12)`, `s₀`, `λ(12)`, `β` and `F`'s own radicand gives `0.592297845`, which is below the
`0.5923` claimed; eight digits gives `0.5923048`, which is above it.* **The true value is
`0.59230492…`, so the margin is `4.9 × 10⁻⁶`** and the precision is forced rather than chosen.

Each bound is one `nlinarith` from `Real.sq_sqrt` and `Real.sqrt_nonneg`, which is what makes this
ordinary arithmetic rather than the interval machinery it looks like. -/

theorem sqrt_two_lt : Real.sqrt 2 < 141421357 / 100000000 := by
  nlinarith [Real.sq_sqrt (show (0:ℝ) ≤ 2 by norm_num), Real.sqrt_nonneg 2]

theorem lt_sqrt_two : (35355339 / 25000000 : ℝ) < Real.sqrt 2 := by
  nlinarith [Real.sq_sqrt (show (0:ℝ) ≤ 2 by norm_num), Real.sqrt_nonneg 2]

theorem sqrt_three_halves_lt : Real.sqrt (3 / 2) < 15309311 / 12500000 := by
  nlinarith [Real.sq_sqrt (show (0:ℝ) ≤ 3 / 2 by norm_num), Real.sqrt_nonneg (3 / 2 : ℝ)]

theorem lt_sqrt_three_halves : (122474487 / 100000000 : ℝ) < Real.sqrt (3 / 2) := by
  nlinarith [Real.sq_sqrt (show (0:ℝ) ≤ 3 / 2 by norm_num), Real.sqrt_nonneg (3 / 2 : ℝ)]

theorem sqrt_six_lt : Real.sqrt 6 < 244948975 / 100000000 := by
  nlinarith [Real.sq_sqrt (show (0:ℝ) ≤ 6 by norm_num), Real.sqrt_nonneg 6]

theorem lt_sqrt_six : (244948974 / 100000000 : ℝ) < Real.sqrt 6 := by
  nlinarith [Real.sq_sqrt (show (0:ℝ) ≤ 6 by norm_num), Real.sqrt_nonneg 6]

theorem theta0_twelve_lt : theta0 12 < 123603309 / 100000000 := by
  have h : theta0 12 ^ 2 = 55 / 36 := theta0_twelve_sq
  nlinarith [h, theta0_twelve_pos]

theorem lt_theta0_twelve : (30900827 / 25000000 : ℝ) < theta0 12 := by
  have h : theta0 12 ^ 2 = 55 / 36 := theta0_twelve_sq
  nlinarith [h, theta0_twelve_pos]

/-! ## The statement itself -/

/-- `λ∞ > 0`, since `√2 > √(3/2)` makes its radicand positive. -/
theorem lamInf_pos : 0 < lamInf := by
  have h : Real.sqrt (3 / 2) < Real.sqrt 2 := Real.sqrt_lt_sqrt (by norm_num) (by norm_num)
  unfold lamInf
  exact div_pos (by norm_num) (Real.sqrt_pos.mpr (by linarith))

/-- **`s₀(12) > 0`**, which is `40√6 > 29 θ₀(12)` after clearing denominators, and that squares to
`345600 > 46255`. *The margin is enormous, unlike the one in the floor below.* -/
theorem s0_twelve_pos : 0 < s0 12 := by
  have ht : 0 < theta0 12 := theta0_twelve_pos
  have ht2 : theta0 12 ^ 2 = 55 / 36 := theta0_twelve_sq
  have h6 : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  have h6p : 0 < Real.sqrt 6 := Real.sqrt_pos.mpr (by norm_num)
  unfold s0
  apply Real.sqrt_pos.mpr
  unfold cp rhoEff w0
  nlinarith [ht, ht2, h6, h6p]

/-- `F(12) > 0`: the numerator is `4 s₀(12)` and the denominator is a square of something at
least `1`. -/
theorem F_twelve_pos : 0 < F 12 := by
  have hs : 0 < s0 12 := s0_twelve_pos
  have hr : (0:ℝ) ≤ Real.sqrt (4 * beta 12 * s0 12 + 1) := Real.sqrt_nonneg _
  unfold F
  apply div_pos (by linarith)
  nlinarith [hr]

/-- **L182, the product bound, with its one imported inequality as a BINDER.**

At every `n ≥ 12`, `λ(n) F(n) > λ∞ F(12)` once `F(12) ≤ F(n)`.

**`hF` is the whole of what this lemma imports, and it is L162's**, recorded at
[second-order.md](../../../findings/second-order.md) as `F(n) > F(12)` at every even `n ≥ 14` and
audited there by four reviewers. *[r778](../../../reviews/REVIEW_r778.md) states L182's own
contribution as localising every falsifier onto exactly this inequality*, so carrying it as a
hypothesis is what the lemma says rather than a weakening of it: `λ` imports nothing, and the
product step is `product_bound` above, which needs no monotonicity of `λF` itself.

**The type says `n : ℝ` with `12 ≤ n`, which is wider than the record's claim**: it admits odd and
non-integer `n`, which the record declines to cover because `F`'s monotonicity is given only at
even `n`. *The parity restriction lived entirely in `hF`, which [L182Bridge.lean](L182Bridge.lean) discharges at every
real `n ≥ 12` from L162's proved monotonicity.* -/
theorem lam_mul_F_gt (n : ℝ) (hn : 12 ≤ n) (hF : F 12 ≤ F n) :
    lamInf * F 12 < lam n * F n :=
  product_bound (lamInf_lt_lam hn) hF lamInf_pos F_twelve_pos

/-! ## The floor, carried through five nested square roots

**THE CHAIN IS INTERVAL ARITHMETIC DONE BY HAND, AND EVERY NUMERAL BELOW IS EMITTED FROM
[l182_emit.py](../../../scripts/misc/l182_emit.py) RATHER THAN TYPED.** *The margin is
`4.77e-06`, so a bound rounded the wrong way loses the theorem rather than weakening it.*

The quantities, in dependency order: `G = 9(θ₀(12) - √(3/2))`, its root `R`, `λ(12) = 2/R`,
`β(12) = 11λ(12)/84`, the radicand `X` of `s₀(12)`, `s₀(12)`, the radicand `Y = 4βs₀ + 1` of `F`'s
own root, `V = √Y`, then `F(12) = 4s₀/(V+1)²`. `λ∞` needs only `W = 9(√2 - √(3/2))` and `U = √W`. -/

/-- **The one instrument the chain uses**: a rational interval for `x` gives one for `√x`. -/
theorem sqrt_bounds_of {x a b : ℝ} (ha : 0 ≤ a) (hb : 0 ≤ b) (h1 : a ^ 2 ≤ x) (h2 : x ≤ b ^ 2) :
    a ≤ Real.sqrt x ∧ Real.sqrt x ≤ b := by
  refine ⟨?_, ?_⟩
  · calc a = Real.sqrt (a ^ 2) := (Real.sqrt_sq ha).symm
      _ ≤ Real.sqrt x := Real.sqrt_le_sqrt h1
  · calc Real.sqrt x ≤ Real.sqrt (b ^ 2) := Real.sqrt_le_sqrt h2
      _ = b := Real.sqrt_sq hb

/-- `Cn(12) = 42/11`, so `β(12) = 11 λ(12) / 84` with no surd of its own. -/
theorem Cn_twelve : Cn 12 = 42 / 11 := by unfold Cn; norm_num

/-- `G = 9(θ₀(12) - √(3/2))`, the radicand under `λ(12)`. -/
theorem lam_radicand_twelve_bounds :
    (507969/5000000 : ℝ) ≤ 9 * (theta0 12 - Real.sqrt (3 / 2)) ∧
      9 * (theta0 12 - Real.sqrt (3 / 2)) ≤ 5079699/50000000 := by
  have h1 := lt_theta0_twelve
  have h2 := theta0_twelve_lt
  have h3 := lt_sqrt_three_halves
  have h4 := sqrt_three_halves_lt
  constructor <;> linarith

/-- `R = √G`. -/
theorem sqrt_lam_radicand_twelve_bounds :
    (15936891/50000000 : ℝ) ≤ Real.sqrt (9 * (theta0 12 - Real.sqrt (3 / 2))) ∧
      Real.sqrt (9 * (theta0 12 - Real.sqrt (3 / 2))) ≤ 31873811/100000000 := by
  obtain ⟨h1, h2⟩ := lam_radicand_twelve_bounds
  exact sqrt_bounds_of (by norm_num) (by norm_num) (by nlinarith) (by nlinarith)

/-- `λ(12) = 2 / R`. -/
theorem lam_twelve_bounds : (784342983/125000000 : ℝ) ≤ lam 12 ∧ lam 12 ≤ 3137374787/500000000 := by
  obtain ⟨h1, h2⟩ := sqrt_lam_radicand_twelve_bounds
  have hpos : (0:ℝ) < Real.sqrt (9 * (theta0 12 - Real.sqrt (3 / 2))) := by linarith
  unfold lam
  constructor
  · rw [le_div_iff₀ hpos]; nlinarith
  · rw [div_le_iff₀ hpos]; nlinarith

/-- `β(12) = λ(12) / (2 Cn(12))`, which is `11 λ(12) / 84`. -/
theorem beta_twelve_bounds : (102711581/125000000 : ℝ) ≤ beta 12 ∧ beta 12 ≤ 821693397/1000000000 := by
  obtain ⟨h1, h2⟩ := lam_twelve_bounds
  unfold beta
  rw [Cn_twelve]
  constructor <;> [skip; skip] <;> rw [show (2 : ℝ) * (42 / 11) = 84 / 11 by norm_num] <;>
    rw [div_div_eq_mul_div] <;> [rw [le_div_iff₀ (by norm_num)]; rw [div_le_iff₀ (by norm_num)]] <;>
    linarith

/-- `X = cp(12) + ρ_eff(12) w₀(12)²`, the radicand under `s₀(12)`. -/
theorem s0_radicand_twelve_bounds :
    (345192387/500000000 : ℝ) ≤ cp 12 + rhoEff 12 * w0 12 ^ 2 ∧
      cp 12 + rhoEff 12 * w0 12 ^ 2 ≤ 690384789/1000000000 := by
  have h1 := lt_theta0_twelve
  have h2 := theta0_twelve_lt
  have h3 := lt_sqrt_six
  have h4 := sqrt_six_lt
  unfold cp rhoEff w0
  norm_num
  constructor <;> linarith

/-- `s₀(12) = √X`. -/
theorem s0_twelve_bounds : (20772349/25000000 : ℝ) ≤ s0 12 ∧ s0 12 ≤ 83089397/100000000 := by
  obtain ⟨h1, h2⟩ := s0_radicand_twelve_bounds
  unfold s0
  exact sqrt_bounds_of (by norm_num) (by norm_num) (by nlinarith) (by nlinarith)

/-- `Y = 4 β(12) s₀(12) + 1`, the radicand inside `F(12)`. -/
theorem F_radicand_twelve_bounds :
    (466369729/125000000 : ℝ) ≤ 4 * beta 12 * s0 12 + 1 ∧ 4 * beta 12 * s0 12 + 1 ≤ 932740089/250000000 := by
  obtain ⟨hb1, hb2⟩ := beta_twelve_bounds
  obtain ⟨hs1, hs2⟩ := s0_twelve_bounds
  constructor <;> nlinarith

/-- `V = √Y`. -/
theorem sqrt_F_radicand_twelve_bounds :
    (96578437/50000000 : ℝ) ≤ Real.sqrt (4 * beta 12 * s0 12 + 1) ∧
      Real.sqrt (4 * beta 12 * s0 12 + 1) ≤ 193156941/100000000 := by
  obtain ⟨h1, h2⟩ := F_radicand_twelve_bounds
  exact sqrt_bounds_of (by norm_num) (by norm_num) (by nlinarith) (by nlinarith)

/-- **`F(12) > 0.386727655`**, the half of the product the record never bounded. -/
theorem F_twelve_gt : (77345531/200000000 : ℝ) < F 12 := by
  obtain ⟨hv1, hv2⟩ := sqrt_F_radicand_twelve_bounds
  obtain ⟨hs1, hs2⟩ := s0_twelve_bounds
  unfold F
  rw [lt_div_iff₀ (by nlinarith)]
  nlinarith

/-- `W = 9(√2 - √(3/2))`, the radicand under `λ∞`. -/
theorem lamInf_radicand_bounds :
    (42630453/25000000 : ℝ) ≤ 9 * (Real.sqrt 2 - Real.sqrt (3 / 2)) ∧
      9 * (Real.sqrt 2 - Real.sqrt (3 / 2)) ≤ 17052183/10000000 := by
  have h1 := lt_sqrt_two
  have h2 := sqrt_two_lt
  have h3 := lt_sqrt_three_halves
  have h4 := sqrt_three_halves_lt
  constructor <;> linarith

/-- `U = √W`. -/
theorem sqrt_lamInf_radicand_bounds :
    (16323/12500 : ℝ) ≤ Real.sqrt (9 * (Real.sqrt 2 - Real.sqrt (3 / 2))) ∧
      Real.sqrt (9 * (Real.sqrt 2 - Real.sqrt (3 / 2))) ≤ 16323001/12500000 := by
  obtain ⟨h1, h2⟩ := lamInf_radicand_bounds
  exact sqrt_bounds_of (by norm_num) (by norm_num) (by nlinarith) (by nlinarith)

/-- **`λ∞ > 1.531581110`.** *The record first wrote `1.53157`, which rounds the wrong way.* -/
theorem lamInf_gt : (153158111/100000000 : ℝ) < lamInf := by
  obtain ⟨h1, h2⟩ := sqrt_lamInf_radicand_bounds
  have hpos : (0:ℝ) < Real.sqrt (9 * (Real.sqrt 2 - Real.sqrt (3 / 2))) := by linarith
  unfold lamInf
  rw [lt_div_iff₀ hpos]
  nlinarith

/-- **`λ∞ F(12) > 5923/10000`**, the numeral the floor turns on, with `4.77e-06` to spare. -/
theorem lamInf_mul_F_twelve_gt : (5923 : ℝ) / 10000 < lamInf * F 12 := by
  have h1 := lamInf_gt
  have h2 := F_twelve_gt
  nlinarith

/-- **And the floor the lemma is for**, which the theorem above does not carry: the product
exceeds `0.5923`, so the constant is bounded away from zero uniformly.

*`lamInf * F 12 < lam n * F n` alone says the product beats one value, not that it beats a
positive one, the second is the lemma's point and was untyped.*

**PROVED**, by `lamInf_mul_F_twelve_gt` and the product bound above. *The constant is
`λ∞ F(12) = 0.59230492…`, so the margin over `0.5923` is `4.9 × 10⁻⁶` and the proved chain reaches
`4.77 × 10⁻⁶` of it.* **Eight rigorous digits are needed and six are not enough**: six-digit surds
give `0.592297845`, below the claimed floor.

*This docstring is the THIRD recording of this constant in this file's history and the first correct
one. The block first wrote `λ∞ = 1.53157`, which rounds the wrong way; a later version wrote
`0.5923041` as an equality with a margin of `4 × 10⁻⁵` and asked for six significant figures*
([r1042](../../../reviews/REVIEW_r1042.md)). **A numeral that survives being written down wrongly
twice is one to emit from the computation rather than to restate.** -/
theorem lam_mul_F_floor (n : ℝ) (hn : 12 ≤ n) (hF : F 12 ≤ F n) :
    (5923 : ℝ) / 10000 < lam n * F n :=
  lt_trans lamInf_mul_F_twelve_gt (lam_mul_F_gt n hn hF)

end HamiltonsCubic.L182
