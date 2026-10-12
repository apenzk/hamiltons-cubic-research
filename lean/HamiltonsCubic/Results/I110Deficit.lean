import Mathlib

set_option linter.style.longLine false

/-!
# I110: I104's deficit in closed form, and the corner where both constraints are active

## What this file is

[I104](../../../plan.md)'s chain, on the equal-`Nᵢ` diagonal with `τ` at its bound `½Nᵢ^{3/2}`,
leaves a deficit against the record's `0.0148`. The [working note](../../../reviews/2026-09-14-I104-tau-positive.md)
located that deficit by sweeping `Nᵢ`. **It is a CUBIC in `s = √Nᵢ`, so the sweep was never needed**,
and every quantity at the worst configuration is an algebraic number written here in radicals.

With `θ = √6/2` (so `θ² = 3/2`), `t = 1 - 3s²`, `τ = s³/2` and the chain's

  `F(u) = θu² - u³/(2√3) - (u/√3)(t + Nᵢ) - Nᵢθ/2 + τ`,

the criticality bound's lower end is `u_lo = (θ - s)/√3`, because `2τ/Nᵢ = s` exactly.

## What is proved

* `deficit_eq`: `-F(u_lo) = s³/9 - √6 s²/6 + 5s/12 - √6/24`. **The closed form, and the file's
  point**: the deficit is a cubic in `s` with no `√3` left in it.
* `deficit_sub`: the difference `d b - d a` factors as `(b - a)` times an explicit bracket.
* `deficit_strictMonoOn`: `d` is strictly increasing on `[0, 1/2]`, which contains the whole
  Gram-feasible range. *`d' = ((2s - √6)² - 1)/12` is positive below `s = (√6-1)/2 ≈ 0.7247`, and
  the feasible range stops at `0.4677`, so the sign is not delicate.*
* `chainFderiv_at_uLo`, `chainFderiv_at_uLo_pos`, `chainFderiv_sub`, `chainFderiv_pos`,
  `chainF_sub`, `chainF_strictMonoOn`: **`F` is strictly increasing on `[u_lo, 1]`**, which
  contains the admissible interval, so its minimum there is at `u_lo`. *That is the step the
  closed form rests on, and it is what makes `deficit_eq` a statement about the interval.*

**THE WHOLE FILE IS THE EQUAL-`Nᵢ` DIAGONAL**, which enters at `chainF`'s `1 - 2s²`, the value of
`t + (N - Nᵢ)/2` only when the three block masses agree. *Off the diagonal `F`'s minimum can be
INTERIOR, so nothing here may be applied by evaluating at the interval's lower end.*
* `gram_boundary_eq`: `sStar = (√6 + √10)/12` solves `36s² - 6√6 s - 1 = 0`, the equation saying
  the criticality bound and the Gram bound meet.
* `both_constraints_active`: at `sStar`, `u_lo² = 5t/9` EXACTLY. **Both constraints bind at the
  corner**, which is what [I110](../../../plan.md) asks about.
* `deficit_at_sStar`: `d(sStar) = 11√10/486 - 5√6/216`, numerically `0.0148730342706614`,
  against the record's `0.0148`.

## What is NOT stated

That `F` is the chain, that `u_lo` is where the criticality bound sits, or that `5t/9` is the Gram
bound. Those identify this algebra with the configuration it came from, and the objects they
quantify over (four-sets, pattern planes, their cross-Grams) are the ones this layer does not
define. **What is typed here is that the algebra is what the note says it is.**

That the corner satisfies the FULL criticality system, which is [I110](../../../plan.md)'s own
question and is open.
-/

namespace HamiltonsCubic.I110Deficit

/-- `θ = √6/2`, so `θ² = 3/2`. -/
noncomputable def theta : ℝ := Real.sqrt 6 / 2

theorem theta_sq : theta ^ 2 = 3 / 2 := by
  have h : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  unfold theta
  field_simp
  linarith [h]

/-- The chain's `F`, on the equal-`Nᵢ` diagonal with `Nᵢ = s²`, `t = 1 - 3s²` and `τ = s³/2`
at its bound. *`t + Nᵢ = 1 - 2s²` is the only place the two enter together.* -/
noncomputable def chainF (s u : ℝ) : ℝ :=
  theta * u ^ 2 - u ^ 3 / (2 * Real.sqrt 3) - u / Real.sqrt 3 * (1 - 2 * s ^ 2)
    - s ^ 2 * theta / 2 + s ^ 3 / 2

/-- The lower end of the admissible interval, `u_lo = (θ - s)/√3`. *It is this simple because
`2τ/Nᵢ = s³/s² = s` exactly on the diagonal.* -/
noncomputable def uLo (s : ℝ) : ℝ := (theta - s) / Real.sqrt 3

/-- The deficit, in closed form: a cubic in `s = √Nᵢ`. -/
noncomputable def deficit (s : ℝ) : ℝ :=
  s ^ 3 / 9 - Real.sqrt 6 * s ^ 2 / 6 + 5 * s / 12 - Real.sqrt 6 / 24

/-- **Every `√3` leaves at `u_lo`.** `u_lo² = (θ-s)²/3`, `u_lo/√3 = (θ-s)/3` and
`u_lo³/(2√3) = (θ-s)³/18`, so the chain's value there is a polynomial in `θ` and `s`.

*This is the step that makes the closed form a cubic rather than an expression in two surds.* -/
theorem chainF_uLo (s : ℝ) :
    chainF s (uLo s)
      = theta * (theta - s) ^ 2 / 3 - (theta - s) ^ 3 / 18
        - (theta - s) * (1 - 2 * s ^ 2) / 3 - s ^ 2 * theta / 2 + s ^ 3 / 2 := by
  have h3 : Real.sqrt 3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have e2 : uLo s ^ 2 = (theta - s) ^ 2 / 3 := by
    rw [uLo, div_pow, h3]
  have e1 : uLo s / Real.sqrt 3 = (theta - s) / 3 := by
    rw [uLo, div_div, Real.mul_self_sqrt (by norm_num : (0:ℝ) ≤ 3)]
  have e3 : uLo s ^ 3 / (2 * Real.sqrt 3) = (theta - s) ^ 3 / 18 := by
    rw [uLo, div_pow, div_div]
    congr 1
    linear_combination (2 * Real.sqrt 3 ^ 2 + 6) * h3
  rw [chainF, e2, e1, e3]
  ring

/-- **The closed form.** `-F(u_lo) = s³/9 - √6 s²/6 + 5s/12 - √6/24`, with no `√3` in it. -/
theorem deficit_eq (s : ℝ) : deficit s = -chainF s (uLo s) := by
  have h6 : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  rw [chainF_uLo]
  unfold deficit theta
  linear_combination (-s / 8 + 5 * Real.sqrt 6 / 144) * h6

/-- The difference of the cubic at two points, factored. *This is the whole of the monotonicity
argument: the bracket is what has to be positive.* -/
theorem deficit_sub (a b : ℝ) :
    deficit b - deficit a
      = (b - a) * ((a ^ 2 + a * b + b ^ 2) / 9 - Real.sqrt 6 * (a + b) / 6 + 5 / 12) := by
  unfold deficit
  ring

/-- **The deficit is strictly increasing on `[0, 1/2]`**, which contains the whole Gram-feasible
range of `s`. *So its maximum there is at the right-hand end, and the corner is a boundary point
rather than an interior critical point.* -/
theorem deficit_strictMonoOn : StrictMonoOn deficit (Set.Icc (0:ℝ) (1/2)) := by
  have h6 : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  have h6n : (0:ℝ) ≤ Real.sqrt 6 := Real.sqrt_nonneg 6
  have hlt : Real.sqrt 6 < 5 / 2 := by nlinarith [h6, h6n]
  intro a ha b hb hab
  obtain ⟨ha0, ha1⟩ := ha
  obtain ⟨hb0, hb1⟩ := hb
  have key : 0 < (a ^ 2 + a * b + b ^ 2) / 9 - Real.sqrt 6 * (a + b) / 6 + 5 / 12 := by
    nlinarith [hlt, h6n, sq_nonneg (a - b), sq_nonneg (a + b), mul_nonneg ha0 hb0]
  nlinarith [deficit_sub a b, key, sub_pos.mpr hab]

/-- `F`'s derivative in `u`, written out as a function rather than through `deriv`.
*`chainF_sub` below is the mean-value identity that makes this the derivative, and no
declaration here connects it to Mathlib's `deriv`.* -/
noncomputable def chainFderiv (s u : ℝ) : ℝ :=
  2 * theta * u - Real.sqrt 3 * u ^ 2 / 2 - (1 - 2 * s ^ 2) / Real.sqrt 3

/-- The difference of `chainF` at two points, factored. *The bracket is the mean-value slope,
and it reduces to `chainFderiv` when the two points meet.* -/
theorem chainF_sub (s a b : ℝ) :
    chainF s b - chainF s a
      = (b - a) * (theta * (a + b) - (a ^ 2 + a * b + b ^ 2) / (2 * Real.sqrt 3)
          - (1 - 2 * s ^ 2) / Real.sqrt 3) := by
  have h3 : Real.sqrt 3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have h3' : Real.sqrt 3 ≠ 0 := ne_of_gt (Real.sqrt_pos.mpr (by norm_num))
  unfold chainF
  field_simp
  ring

/-- **The derivative at the lower end is bounded below by `1/√3`, for EVERY `s`.**
`F'(u_lo) = (3(s - √6/6)²/2 + 1)/√3`, whose bracket has discriminant `-6`.

*This is the step the closed form rests on, and sampling it at five points is what this
replaces.* -/
theorem chainFderiv_at_uLo (s : ℝ) :
    chainFderiv s (uLo s) = (3 * (s - Real.sqrt 6 / 6) ^ 2 / 2 + 1) / Real.sqrt 3 := by
  have h3 : Real.sqrt 3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have h3' : Real.sqrt 3 ≠ 0 := ne_of_gt (Real.sqrt_pos.mpr (by norm_num))
  have h6 : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  unfold chainFderiv uLo theta
  field_simp
  ring_nf
  nlinarith [h3, h6, Real.sqrt_nonneg 3, Real.sqrt_nonneg 6]

/-- `F'(u_lo) > 0`, from the previous identity. -/
theorem chainFderiv_at_uLo_pos (s : ℝ) : 0 < chainFderiv s (uLo s) := by
  rw [chainFderiv_at_uLo]
  have h3' : (0:ℝ) < Real.sqrt 3 := Real.sqrt_pos.mpr (by norm_num)
  positivity

/-- `F'` at two points, factored. *`F'` is a downward parabola in `u`, and this says its
slope between two points is `2θ - √3(a+b)/2`.* -/
theorem chainFderiv_sub (s a b : ℝ) :
    chainFderiv s b - chainFderiv s a = (b - a) * (2 * theta - Real.sqrt 3 * (a + b) / 2) := by
  unfold chainFderiv
  ring

/-- **`F' > 0` on the whole admissible interval**, not just at its lower end. *`F'` is
increasing in `u` as long as `√3(a+b)/2 < 2θ`, and `u ≤ √t ≤ 1` keeps it there with room:
`√3 < √6`.* -/
theorem chainFderiv_pos (s a : ℝ) (hs : s ≤ theta) (hlo : uLo s ≤ a) (ha1 : a ≤ 1) :
    0 < chainFderiv s a := by
  have h3p : (0:ℝ) < Real.sqrt 3 := Real.sqrt_pos.mpr (by norm_num)
  have h36 : Real.sqrt 3 < Real.sqrt 6 := by
    apply Real.sqrt_lt_sqrt (by norm_num) (by norm_num)
  have h0 : 0 ≤ uLo s := div_nonneg (by unfold theta at hs ⊢; linarith) h3p.le
  have hb : 0 < 2 * theta - Real.sqrt 3 * (uLo s + a) / 2 := by
    have : uLo s + a ≤ 2 := by linarith
    have h2t : 2 * theta = Real.sqrt 6 := by unfold theta; ring
    nlinarith [h3p, h36, h0, this]
  have key := chainFderiv_sub s (uLo s) a
  nlinarith [chainFderiv_at_uLo_pos s, key, hb, sub_nonneg.mpr hlo]

/-- **`F` IS STRICTLY INCREASING ON `[u_lo, 1]`, so its minimum there is at `u_lo`.**
*This is the step the closed form rests on. The mean-value bracket beats `F'(a)` because
`2a + b ≤ 3 < 3√2 = 2√3 θ`, and `F'(a) > 0` by the previous theorem.* -/
theorem chainF_strictMonoOn (s : ℝ) (hs : s ≤ theta) :
    StrictMonoOn (chainF s) (Set.Icc (uLo s) 1) := by
  have h3p : (0:ℝ) < Real.sqrt 3 := Real.sqrt_pos.mpr (by norm_num)
  have h3 : Real.sqrt 3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have h6 : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  have h6p : (0:ℝ) < Real.sqrt 6 := Real.sqrt_pos.mpr (by norm_num)
  have h0lo : 0 ≤ uLo s := div_nonneg (by unfold theta at hs ⊢; linarith) h3p.le
  have h18 : (Real.sqrt 3 * Real.sqrt 6) ^ 2 = 18 := by rw [mul_pow, h3, h6]; norm_num
  have h4 : (3:ℝ) < Real.sqrt 3 * Real.sqrt 6 := by nlinarith [h18, mul_pos h3p h6p]
  intro a ha b hb hab
  obtain ⟨ha0, ha1⟩ := ha
  obtain ⟨hb0, hb1⟩ := hb
  have hda : 0 < chainFderiv s a := chainFderiv_pos s a hs ha0 ha1
  have hd : (0:ℝ) < 2 * Real.sqrt 3 := by positivity
  have hsplit : (2 * a + b) / (2 * Real.sqrt 3) * (2 * Real.sqrt 3) = 2 * a + b := by
    field_simp
  have hnum : 2 * a + b < theta * (2 * Real.sqrt 3) := by
    have : theta * (2 * Real.sqrt 3) = Real.sqrt 3 * Real.sqrt 6 := by unfold theta; ring
    nlinarith [h4, this, ha1, hb1, ha0, hb0, h0lo]
  have hgap : 0 < theta - (2 * a + b) / (2 * Real.sqrt 3) := by
    nlinarith [hsplit, hnum, hd]
  have hbrk : theta * (a + b) - (a ^ 2 + a * b + b ^ 2) / (2 * Real.sqrt 3)
      - (1 - 2 * s ^ 2) / Real.sqrt 3 - chainFderiv s a
      = (b - a) * (theta - (2 * a + b) / (2 * Real.sqrt 3)) := by
    unfold chainFderiv
    field_simp
    ring_nf
    nlinarith [h3, h3p]
  have hBpos : 0 < theta * (a + b) - (a ^ 2 + a * b + b ^ 2) / (2 * Real.sqrt 3)
      - (1 - 2 * s ^ 2) / Real.sqrt 3 := by
    have hprod : 0 < (b - a) * (theta - (2 * a + b) / (2 * Real.sqrt 3)) :=
      mul_pos (sub_pos.mpr hab) hgap
    linarith [hbrk, hda, hprod]
  have hfin : 0 < (b - a) * (theta * (a + b) - (a ^ 2 + a * b + b ^ 2) / (2 * Real.sqrt 3)
      - (1 - 2 * s ^ 2) / Real.sqrt 3) := mul_pos (sub_pos.mpr hab) hBpos
  linarith [chainF_sub s a b, hfin]

/-- The Gram-feasibility boundary, `s* = (√6 + √10)/12`. -/
noncomputable def sStar : ℝ := (Real.sqrt 6 + Real.sqrt 10) / 12

/-- **`s*` solves the boundary equation.** *The cross term `√6·√10` cancels, so no `√15` is
needed and the identity is `√6² = 6` twice over.* -/
theorem gram_boundary_eq : 36 * sStar ^ 2 - 6 * Real.sqrt 6 * sStar - 1 = 0 := by
  have h6 : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  have h10 : Real.sqrt 10 ^ 2 = 10 := Real.sq_sqrt (by norm_num)
  unfold sStar
  field_simp
  nlinarith [h6, h10]

/-- **BOTH CONSTRAINTS ARE ACTIVE AT THE CORNER.** At `s*` the criticality bound's lower end
squares to exactly `5t/9`, the Gram bound's pin. *This is [I110](../../../plan.md)'s premise,
and it is an identity rather than a numerical coincidence.* -/
theorem both_constraints_active :
    uLo sStar ^ 2 = 5 * (1 - 3 * sStar ^ 2) / 9 := by
  have h3 : Real.sqrt 3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have h3' : (0:ℝ) < Real.sqrt 3 := Real.sqrt_pos.mpr (by norm_num)
  have hb := gram_boundary_eq
  have h6 : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  unfold uLo theta
  rw [div_pow, h3]
  nlinarith [hb, h6, h3]

/-- **The deficit at the corner**, in radicals: `11√10/486 - 5√6/216 = 0.0148730342706614`,
against the record's `0.0148`. -/
theorem deficit_at_sStar :
    deficit sStar = 11 * Real.sqrt 10 / 486 - 5 * Real.sqrt 6 / 216 := by
  have h6 : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  have h10 : Real.sqrt 10 ^ 2 = 10 := Real.sq_sqrt (by norm_num)
  unfold deficit sStar
  field_simp
  nlinarith [h6, h10, Real.sqrt_nonneg 6, Real.sqrt_nonneg 10]

/-- **The block equation's coefficient at the corner is `s` itself.** `θ - √3 u_lo = s`, at
every `s`, because `u_lo = (θ - s)/√3`.

*This is what turns `(θ - 2e_i) ν_i = 2 ν_j ∘ ν_k` into a norm statement with no surds left:
the pinning being tight makes `e_i = √3 u_i/2`, so the coefficient is `θ - √3 u_i`.* -/
theorem coeff_at_uLo (s : ℝ) : theta - Real.sqrt 3 * uLo s = s := by
  have h3 : Real.sqrt 3 ≠ 0 := ne_of_gt (Real.sqrt_pos.mpr (by norm_num))
  rw [uLo, mul_div_cancel₀ _ h3]
  ring

/-- **The LEFT side of the block equation has norm `s²` at the corner**, on the equal diagonal,
since `s · √(s²) = s²`.

*This types the left side alone. The right side's ceiling `2 · ½√(N N) = N` and the conclusion
drawn from their agreement are NOT here, and the conclusion once drawn from it, that the corner
sits on the boundary of realisability, is REFUTED: the corner is OUTSIDE it, by
[r1062](../../../reviews/REVIEW_r1062.md) and [r1063](../../../reviews/REVIEW_r1063.md).
Requiring `ν_i` to be both the equality case and `L_{q_i}`'s top eigenvector pins `q_i` to the
`P`-MINIMISING shape `(-2,1,1)`, which moves `F` to `+0.1298`.* -/
theorem block_norms_agree (s : ℝ) (hs : 0 ≤ s) :
    (theta - Real.sqrt 3 * uLo s) * Real.sqrt (s ^ 2) = s ^ 2 := by
  rw [coeff_at_uLo, Real.sqrt_sq hs]
  ring

/-! ## Why the corner is excluded

The two conditions that hold at the corner were derived separately, and together they pin the
shape of `q` to the one where `P` is MINIMISED. This section types that step, which is the whole
of the exclusion. -/

/-- [L121](../../../findings/second-order.md)'s operator on a four-set block, in signed
coordinates: `L_M` is `G/2` with `A = M_ij + M_kl`, `B = M_ik + M_jl`, `C = M_il + M_jk`. -/
noncomputable def patternG (A B C : ℝ) : Matrix (Fin 3) (Fin 3) ℝ :=
  !![A, C, B; C, B, A; B, A, C]

/-- **The product bound's equality case is an eigenvector exactly when `B = C`**, and its
eigenvalue is `B - A`. -/
theorem patternG_apply_equalityCase (A B : ℝ) :
    Matrix.mulVec (patternG A B B) ![0, 1, -1] = (B - A) • ![0, 1, -1] := by
  funext i
  fin_cases i <;>
    simp [patternG, Matrix.mulVec, dotProduct, Fin.sum_univ_three, Matrix.of_apply,
      Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons] <;> ring

/-- **The `P`-maximising shape is the OTHER eigenvector**, with eigenvalue `A - B`. -/
theorem patternG_apply_shape (A B : ℝ) :
    Matrix.mulVec (patternG A B B) ![2, -1, -1] = (A - B) • ![2, -1, -1] := by
  funext i
  fin_cases i <;>
    simp [patternG, Matrix.mulVec, dotProduct, Fin.sum_univ_three, Matrix.of_apply,
      Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons] <;> ring

/-- **THE EXCLUSION, as an implication about signs.** The two eigenvalues on the Bianchi plane
are exactly `±(B - A)`, so demanding that the equality case be the TOP eigenvector forces
`A < B`, and then `q`'s component in that plane is a POSITIVE multiple of `(-2, 1, 1)`.

*That is the NEGATIVE of the `P`-maximising shape, so `P(q)` sits at its minimum where the
chain's step 7 allowed its maximum. This is what excludes I110's corner.* -/
theorem forced_shape_of_top (A B : ℝ) (htop : A - B < B - A) :
    0 < (B - A) / 3 ∧
      ![A, B, B] - (fun _ => (A + 2 * B) / 3) = ((B - A) / 3) • ![-2, 1, 1] := by
  refine ⟨by linarith, ?_⟩
  funext i
  fin_cases i <;>
    simp [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Pi.sub_apply,
      Pi.smul_apply, smul_eq_mul] <;> ring


/-! ## The deficit cubic factors completely, so the window's endpoints are radicals

*The record carried the lower endpoint only as the decimal `0.358719467607`, described as "the
root of `d(s)=0`". All three roots are `θ` and `θ ± √3/2`.*
-/

/-- **THE DEFICIT FACTORS OVER `ℚ(√2,√3)`.** `d(s) = (1/9)(s-θ)(s-θ-√3/2)(s-θ+√3/2)`.

*Purely an identity between polynomials once `√6 = √2·√3` and `(√3)² = 3` are supplied, so it
needs no root-finding and no bound on `s`.* -/
theorem deficit_factors (s : ℝ) :
    deficit s
      = (1 / 9) * (s - theta) * (s - theta - Real.sqrt 3 / 2) * (s - theta + Real.sqrt 3 / 2) := by
  have h3 : Real.sqrt 3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have h6 : Real.sqrt 6 = Real.sqrt 2 * Real.sqrt 3 := by
    rw [← Real.sqrt_mul (by norm_num : (0:ℝ) ≤ 2)]; norm_num
  have h2 : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have hth : theta = Real.sqrt 2 * Real.sqrt 3 / 2 := by rw [theta, h6]
  rw [deficit, hth, h6]
  -- exact certificate, `nlinarith` is the wrong instrument for an equality:
  --   LHS - RHS = [b²(ab - 6s)/72]·(a² - 2) + [ab/72 - 5s/36]·(b² - 3)
  linear_combination
    (Real.sqrt 3 ^ 2 * (Real.sqrt 2 * Real.sqrt 3 - 6 * s) / 72) * h2
      + (Real.sqrt 2 * Real.sqrt 3 / 72 - 5 * s / 36) * h3

/-- **The lower endpoint of the surviving window, in radicals**: `s_lo = θ - √3/2`, which is
`(√6 - √3)/2`. *It is a root of the deficit by `deficit_factors`.* -/
theorem deficit_at_sLo : deficit (theta - Real.sqrt 3 / 2) = 0 := by
  rw [deficit_factors]; ring

/-- **And it equals `(√6 - √3)/2`.** -/
theorem sLo_eq : theta - Real.sqrt 3 / 2 = (Real.sqrt 6 - Real.sqrt 3) / 2 := by
  rw [theta]; ring


end HamiltonsCubic.I110Deficit
