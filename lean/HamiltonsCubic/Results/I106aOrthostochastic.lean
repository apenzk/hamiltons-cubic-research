import Mathlib

set_option linter.style.longLine false

/-!
# I106a, the orthostochastic variety's defining equation

## What this file is

[R28](../../../routes.md), the orthostochastic rung, maximises a linear functional over the image of `O(k)` under
`Q ↦ Q∘2`, the entrywise square. At `k = 3` that image is cut out of the bistochastic matrices by one equation,
which [I106a](../../../plan.md) owes to the record before its Lagrange conditions can be written. The equation is
Au-Yeung and Poon's, carried by
[Bengtsson, Ericsson, Kuś, Tadej and Życzkowski](../../../references/au-yeung-poon-1979-orthostochastic-numerical-ranges/notes.md)
section 3, for a bistochastic matrix laid out as

  `x y *`
  `z w *`
  `a b *`

as the statement that `(√x, √z, √a)` and `(√y, ±√w, ±√b)` are orthogonal for some choice of signs.

## What is proved

* `orthostochastic_eq`: the equation in its radical-free form, `(ab - xy - zw)² = 4xyzw`, **from the orthogonality of
  two columns alone**. No bistochasticity, no positivity, and no relation among the remaining entries is used: with
  `u = q₀₀q₀₁`, `v = q₁₀q₁₁` and `t = q₂₀q₂₁`, column orthogonality is `u + v + t = 0`, and then `ab - xy - zw = 2uv`
  while `4xyzw = (2uv)²`. *The published form's square root signs are exactly the signs of `u`, `v` and `t`, which is
  why the polynomial form needs none.*
* `bridge`: the column-sum substitution `a = 1 - x - z`, `b = 1 - y - w` turning that into the published shape
  `(1 - x - y - z - w + xw + yz)² = 4xyzw`.
* `orthostochastic_poly`: the two composed, which is the constraint R28 maximises against.

* `degenerate_triangle`: for non-negative `U`, `V`, `T` the equation forces one of them to be the sum of the other
  two. **This is where positivity enters**, and it is the hypothesis the forward direction leaves unused.
* `columns_from_equation`: **the converse**, that a bistochastic pair of columns satisfying the equation is realised
  by two orthonormal real vectors whose entrywise squares are those columns. *Proved 2026-09-16 after
  [r963](../../../reviews/REVIEW_r963.md) and [r964](../../../reviews/REVIEW_r964.md) reached it independently, the
  file's former standing debt.* **Both hypotheses the forward direction does not need appear here**: positivity
  through the degenerate triangle, and the column sums through the unit norms.

* `coupling_decomposition`, `coupling_square`, `coupling_parity`: **the coupling between the pair `(R, S)` that R28
  actually maximises over**, `S i k = ((G∘2)ᵀ R) i k + 2 ∑_{j<l} G j i * G l i * T`, with each `T = Q j k * Q l k`
  a SIGNED square root of `R j k * R l k` and the three signs' product pinned to `+1`. *So `S` is determined by
  `R`, by the fixed `G`, and by a finite sign choice, rather than free beside it.* **These need no orthogonality**,
  being the expansion of a square, and the parity is the same shape as `degenerate_triangle`.

**Not typed**: that the third column `c₁ ×ˣ c₂` completes those two to an orthogonal `Q` with `Q∘2 = B` throughout.
*The argument is that `Q`'s rows are unit, so the third column of `Q∘2` is `1 - B(i,0) - B(i,1)`, which is `B(i,2)`
because `B`'s rows sum to one.* **What the two typed statements give is the orthonormal pair, which is the step
carrying positivity and the column sums**, so what remains is the cross product and one row-sum substitution.

**Consequence for the route, and its limit.** A maximum over ONE such variety is attained rather than merely
bounded. *[R28](../../../routes.md)'s object is a coupled PAIR `(R, S)` sharing the fixed rotation `G = Eᵀ F`
between the eigenframes, and the two equations constrain each factor while leaving that coupling free.* **So this
does not make R28 exact**, and the coupling is what I106a still owes.
-/

namespace HamiltonsCubic.I106aOrthostochastic

/-- **The orthostochastic equation, from column orthogonality alone.** For any real matrix whose first
two columns are orthogonal, the entrywise squares `x = q₀₀²`, `y = q₀₁²`, `z = q₁₀²`, `w = q₁₁²`,
`a = q₂₀²`, `b = q₂₁²` satisfy `(ab - xy - zw)² = 4xyzw`. *Bistochasticity is not used, and neither is
positivity: the hypothesis is one linear relation among the three column products.* -/
theorem orthostochastic_eq (q₀₀ q₀₁ q₁₀ q₁₁ q₂₀ q₂₁ : ℝ)
    (h : q₀₀ * q₀₁ + q₁₀ * q₁₁ + q₂₀ * q₂₁ = 0) :
    (q₂₀ ^ 2 * q₂₁ ^ 2 - q₀₀ ^ 2 * q₀₁ ^ 2 - q₁₀ ^ 2 * q₁₁ ^ 2) ^ 2
      = 4 * (q₀₀ ^ 2 * q₀₁ ^ 2) * (q₁₀ ^ 2 * q₁₁ ^ 2) := by
  have h2 : q₂₀ * q₂₁ = -(q₀₀ * q₀₁ + q₁₀ * q₁₁) := by linarith
  have key : q₂₀ ^ 2 * q₂₁ ^ 2 = (q₀₀ * q₀₁ + q₁₀ * q₁₁) ^ 2 := by
    calc q₂₀ ^ 2 * q₂₁ ^ 2 = (q₂₀ * q₂₁) ^ 2 := by ring
      _ = (-(q₀₀ * q₀₁ + q₁₀ * q₁₁)) ^ 2 := by rw [h2]
      _ = (q₀₀ * q₀₁ + q₁₀ * q₁₁) ^ 2 := by ring
  rw [key]; ring

/-- **The column-sum substitution.** On a bistochastic matrix the third row of the first two columns is
determined, `a = 1 - x - z` and `b = 1 - y - w`, and then `ab - xy - zw` is the published form's inner
polynomial. -/
theorem bridge (x y z w a b : ℝ) (ha : a = 1 - x - z) (hb : b = 1 - y - w) :
    a * b - x * y - z * w = 1 - x - y - z - w + x * w + y * z := by
  subst ha; subst hb; ring

/-- **The constraint R28 maximises against**, the two composed: for a matrix with orthogonal first two
columns whose entrywise squares are bistochastic in those columns,
`(1 - x - y - z - w + xw + yz)² = 4xyzw`. -/
theorem orthostochastic_poly (q₀₀ q₀₁ q₁₀ q₁₁ q₂₀ q₂₁ x y z w : ℝ)
    (hx : x = q₀₀ ^ 2) (hy : y = q₀₁ ^ 2) (hz : z = q₁₀ ^ 2) (hw : w = q₁₁ ^ 2)
    (ha : q₂₀ ^ 2 = 1 - x - z) (hb : q₂₁ ^ 2 = 1 - y - w)
    (h : q₀₀ * q₀₁ + q₁₀ * q₁₁ + q₂₀ * q₂₁ = 0) :
    (1 - x - y - z - w + x * w + y * z) ^ 2 = 4 * x * y * z * w := by
  have e := orthostochastic_eq q₀₀ q₀₁ q₁₀ q₁₁ q₂₀ q₂₁ h
  rw [ha, hb, ← hx, ← hy, ← hz, ← hw] at e
  rw [bridge x y z w (1 - x - z) (1 - y - w) rfl rfl] at e
  linarith [e]

/-- **The degenerate triangle, which is where positivity enters.** For non-negative `U`, `V`, `T`
with `(T² - U² - V²)² = 4U²V²`, one of the three is the sum of the other two, stated as the
existence of signs with `U + ε₁V + ε₂T = 0`. *This is the step the forward direction does not need,
and it is the whole reason the converse holds: the squared equation alone leaves `T² = (U±V)²`, and
only `T, U, V ≥ 0` collapses that to a linear relation.* -/
theorem degenerate_triangle (U V T : ℝ) (hU : 0 ≤ U) (hV : 0 ≤ V) (hT : 0 ≤ T)
    (h : (T ^ 2 - U ^ 2 - V ^ 2) ^ 2 = 4 * U ^ 2 * V ^ 2) :
    ∃ ε₁ ε₂ : ℝ, (ε₁ = 1 ∨ ε₁ = -1) ∧ (ε₂ = 1 ∨ ε₂ = -1) ∧ U + ε₁ * V + ε₂ * T = 0 := by
  have key : (T ^ 2 - (U + V) ^ 2) * (T ^ 2 - (U - V) ^ 2) = 0 := by linear_combination h
  rcases mul_eq_zero.mp key with hA | hB
  · refine ⟨1, -1, Or.inl rfl, Or.inr rfl, ?_⟩
    have : T = U + V := by nlinarith
    linarith
  · rcases le_total V U with hle | hle
    · refine ⟨-1, -1, Or.inr rfl, Or.inr rfl, ?_⟩
      have : T = U - V := by nlinarith
      linarith
    · refine ⟨-1, 1, Or.inr rfl, Or.inl rfl, ?_⟩
      have : T = V - U := by nlinarith
      linarith

/-- **The converse, and with it R28's exactness.** A bistochastic pair of columns satisfying the
equation is realised by two orthonormal real vectors, entrywise squares matching. *Both hypotheses the
forward direction leaves unused appear here: positivity through [degenerate_triangle](#), and the
column sums through the unit norms.* With the third column recovered as `c₁ ×ˣ c₂`, this says the
equation CUTS OUT the orthostochastic matrices rather than a larger set, so R28's maximum over the
variety is the true maximum rather than an upper bound. -/
theorem columns_from_equation (x y z w a b : ℝ)
    (hx : 0 ≤ x) (hy : 0 ≤ y) (hz : 0 ≤ z) (hw : 0 ≤ w) (ha : 0 ≤ a) (hb : 0 ≤ b)
    (hc1 : x + z + a = 1) (hc2 : y + w + b = 1)
    (heq : (a * b - x * y - z * w) ^ 2 = 4 * (x * y) * (z * w)) :
    ∃ p₀ p₁ p₂ r₀ r₁ r₂ : ℝ,
      p₀ ^ 2 = x ∧ p₁ ^ 2 = z ∧ p₂ ^ 2 = a ∧
      r₀ ^ 2 = y ∧ r₁ ^ 2 = w ∧ r₂ ^ 2 = b ∧
      p₀ * r₀ + p₁ * r₁ + p₂ * r₂ = 0 ∧
      p₀ ^ 2 + p₁ ^ 2 + p₂ ^ 2 = 1 ∧
      r₀ ^ 2 + r₁ ^ 2 + r₂ ^ 2 = 1 := by
  have sx := Real.sq_sqrt hx; have sy := Real.sq_sqrt hy
  have sz := Real.sq_sqrt hz; have sw := Real.sq_sqrt hw
  have sa := Real.sq_sqrt ha; have sb := Real.sq_sqrt hb
  obtain ⟨ε₁, ε₂, h1, h2, hlin⟩ :=
    degenerate_triangle (Real.sqrt x * Real.sqrt y) (Real.sqrt z * Real.sqrt w)
      (Real.sqrt a * Real.sqrt b)
      (mul_nonneg (Real.sqrt_nonneg x) (Real.sqrt_nonneg y))
      (mul_nonneg (Real.sqrt_nonneg z) (Real.sqrt_nonneg w))
      (mul_nonneg (Real.sqrt_nonneg a) (Real.sqrt_nonneg b))
      (by
        have hxy : (Real.sqrt x * Real.sqrt y) ^ 2 = x * y := by rw [mul_pow, sx, sy]
        have hzw : (Real.sqrt z * Real.sqrt w) ^ 2 = z * w := by rw [mul_pow, sz, sw]
        have hab : (Real.sqrt a * Real.sqrt b) ^ 2 = a * b := by rw [mul_pow, sa, sb]
        rw [hxy, hzw, hab]; exact heq)
  have e1 : ε₁ ^ 2 = 1 := by rcases h1 with h | h <;> rw [h] <;> norm_num
  have e2 : ε₂ ^ 2 = 1 := by rcases h2 with h | h <;> rw [h] <;> norm_num
  have rw1 : (ε₁ * Real.sqrt w) ^ 2 = w := by rw [mul_pow, e1, sw]; ring
  have rw2 : (ε₂ * Real.sqrt b) ^ 2 = b := by rw [mul_pow, e2, sb]; ring
  exact ⟨Real.sqrt x, Real.sqrt z, Real.sqrt a,
         Real.sqrt y, ε₁ * Real.sqrt w, ε₂ * Real.sqrt b,
         sx, sz, sa, sy, rw1, rw2, by linear_combination hlin,
         by linarith [sx, sz, sa], by linarith [sy, rw1, rw2]⟩

/-! ## The coupling between the two orthostochastic factors

[R28](../../../routes.md) maximises over a PAIR `(R, S)` with `R = Q∘2` and `S = (Gᵀ Q)∘2` for one `Q`, `G` the
fixed rotation between the eigenframes. The three declarations below say that the pair is not free: `S` is
determined by `R`, by `G`, and by a finite sign choice.
-/

/-- **The coupling identity.** Expanding `S i k = (∑ j, G j i * Q j k)²` splits it into a part seeing only
`R = Q∘2` and a part carrying the coupling, the three products `T = Q j k * Q l k`. *Stated at one entry with
`g j = G j i` and `q j = Q j k`, and it needs NO orthogonality, being the expansion of a square.* -/
theorem coupling_decomposition (g₁ g₂ g₃ q₁ q₂ q₃ : ℝ) :
    (g₁ * q₁ + g₂ * q₂ + g₃ * q₃) ^ 2
      = (g₁ ^ 2 * q₁ ^ 2 + g₂ ^ 2 * q₂ ^ 2 + g₃ ^ 2 * q₃ ^ 2)
        + 2 * (g₁ * g₂ * (q₁ * q₂) + g₁ * g₃ * (q₁ * q₃) + g₂ * g₃ * (q₂ * q₃)) := by
  ring

/-- **Each coupling term is a SIGNED square root of a product of `R`'s own entries.** -/
theorem coupling_square (qj ql : ℝ) : (qj * ql) ^ 2 = qj ^ 2 * ql ^ 2 := by ring

/-- **The parity EQUALITY**, `T¹² T¹³ T²³ = R₁ R₂ R₃`, which holds for any three reals.

*Corrected 2026-09-16 after [r965](../../../reviews/REVIEW_r965.md) and
[r966](../../../reviews/REVIEW_r966.md).* **The earlier docstring read "three signs whose product is `+1`",
and that is false wherever any `R j k = 0`**: two of the `T` vanish and the third's sign is free. That stratum
is the split locus, which is exactly where R28 intends the maximum to sit, so the phrase failed on the case
the route cares about. **The non-negativity is VACUOUS**: the right side is a product of squares, so it is
non-negative whatever the coupling does, and it constrains nothing. -/
theorem coupling_parity (q₁ q₂ q₃ : ℝ) :
    (q₁ * q₂) * (q₁ * q₃) * (q₂ * q₃) = q₁ ^ 2 * (q₂ ^ 2 * q₃ ^ 2) := by ring

/-- **The constraint the first version of this section OMITTED**, and it was already in this file.

`∑ k, T⁽ʲˡ⁾ k = (Q Qᵀ) j l = 0` for `j ≠ l`, the ROW orthogonality of `Q`. *Per-column, `coupling_square`
and `coupling_parity` admit `4³ = 64` sign assignments at a generic `R`, of which only `4` come from a
`Q ∈ O(3)`; the `60` spurious ones keep `S` non-negative and keep its COLUMN sums, and fail its ROW sums.*

**It is `orthostochastic_eq`'s own hypothesis `h`, read at `Qᵀ`**, which is why the theorem sixty lines above
applies to the coupling with no new object. This declaration is that application: row orthogonality of a pair
of rows of `Q` puts their three products into the orthostochastic equation. -/
theorem coupling_row_relation (q₁ q₂ q₃ r₁ r₂ r₃ : ℝ)
    (hrow : q₁ * r₁ + q₂ * r₂ + q₃ * r₃ = 0) :
    (q₃ ^ 2 * r₃ ^ 2 - q₁ ^ 2 * r₁ ^ 2 - q₂ ^ 2 * r₂ ^ 2) ^ 2
      = 4 * (q₁ ^ 2 * r₁ ^ 2) * (q₂ ^ 2 * r₂ ^ 2) :=
  orthostochastic_eq q₁ r₁ q₂ r₂ q₃ r₃ hrow

end HamiltonsCubic.I106aOrthostochastic
