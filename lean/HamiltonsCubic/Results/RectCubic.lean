import Mathlib

/-!
# The rectangle cubic, its scalar core

[The working note](../../../reviews/2026-09-28d-I121-smallmass-direct.md) on I121's
small-mass node, the rectangle identity.

**The source's statement.** "For three disjoint edges `e₁, e₂, e₃` and four-set blocks
`ν_ab ∈ V_{e_a ∪ e_b}` with coordinates `J_ab = W_{e_a,e_b}` and
`X_ab = ½(W_{ik,jl} + W_{il,jk})` relative to the rectangle's pairing,
`τ = ⟨ν₁₂ ∘ ν₁₃, ν₂₃⟩ = (3/2) J₁₂ J₁₃ J₂₃ + 4 X₁₂ X₁₃ X₂₃`, and `‖ν‖² = 4X² + 3J²`."

**What is typed.** The scalar steps: `rect_norm`, the block norm in `(X, J)` from the raw
entries under Bianchi `a = b - c`; `rect_bits`, the sum over the eight orientation bits in the
`#` part; `rect_raw`, the record's raw-coordinate bilinear formula equals `(3/2)JJJ + 4XXX`;
`rect_unit`, the normalised coupling is at most `1` in absolute value.

**Not typed**: the operator identity itself (the character selection of rectangle triples and
the two index contractions), which is prose in the source.
-/

/-- **THE BLOCK NORM IN `(X, J)`.** With raw entries `a, b, c` under Bianchi `a = b - c`,
`X = (b + c)/2` and `J = a`, the operator norm `2(a² + b² + c²)` is `4X² + 3J²`. -/
theorem rect_norm (a b c : ℝ) (h : a = b - c) :
    2 * (a ^ 2 + b ^ 2 + c ^ 2) = 4 * ((b + c) / 2) ^ 2 + 3 * a ^ 2 := by
  subst h; ring

/-- **THE EIGHT ORIENTATION BITS.** Each factor of the `#` contraction on a rectangle is a
crossing entry `X + (J/2)σ`, the three signs multiplying to `1`; summed over the bits the
product is `8XXX + JJJ`. -/
theorem rect_bits (X₁ X₂ X₃ J₁ J₂ J₃ : ℝ) :
    ∑ s : Fin 2 × Fin 2 × Fin 2,
      (X₁ + J₁ / 2 * (-1) ^ (s.1.val + s.2.1.val))
        * (X₂ + J₂ / 2 * (-1) ^ (s.2.1.val + s.2.2.val))
        * (X₃ + J₃ / 2 * (-1) ^ (s.2.2.val + s.1.val))
      = 8 * (X₁ * X₂ * X₃) + J₁ * J₂ * J₃ := by
  simp [Fin.sum_univ_two, Fintype.sum_prod_type]
  ring

/-- **THE RAW BILINEAR FORMULA IS THE RECTANGLE CUBIC.** With `a = J`, `b = X + J/2`,
`c = X - J/2` on each block, `a₁a₂a₃ + (b₁b₂ + c₁c₂)b₃ + (b₁c₂ + c₁b₂)c₃` is
`(3/2)J₁J₂J₃ + 4X₁X₂X₃`. -/
theorem rect_raw (X₁ X₂ X₃ J₁ J₂ J₃ : ℝ) :
    J₁ * J₂ * J₃
      + ((X₁ + J₁ / 2) * (X₂ + J₂ / 2) + (X₁ - J₁ / 2) * (X₂ - J₂ / 2)) * (X₃ + J₃ / 2)
      + ((X₁ + J₁ / 2) * (X₂ - J₂ / 2) + (X₁ - J₁ / 2) * (X₂ + J₂ / 2)) * (X₃ - J₃ / 2)
      = 3 / 2 * (J₁ * J₂ * J₃) + 4 * (X₁ * X₂ * X₃) := by
  ring

/-- **THE NORMALISED COUPLING.** On three unit circles `xᵢ² + jᵢ² = 1` and for `0 ≤ c ≤ 1`,
`|c j₁j₂j₃ + x₁x₂x₃| ≤ 1`. At `c = 1/√3` this is `|τ| ≤ ½√(N₁N₂N₃)`. -/
theorem rect_unit (x₁ x₂ x₃ j₁ j₂ j₃ c : ℝ) (h₁ : x₁ ^ 2 + j₁ ^ 2 = 1)
    (h₂ : x₂ ^ 2 + j₂ ^ 2 = 1) (h₃ : x₃ ^ 2 + j₃ ^ 2 = 1) (hc0 : 0 ≤ c) (hc1 : c ≤ 1) :
    |c * (j₁ * j₂ * j₃) + x₁ * x₂ * x₃| ≤ 1 := by
  have hx3 : |x₃| ≤ 1 := by
    rw [← abs_one, ← sq_le_sq]; nlinarith [sq_nonneg j₃]
  have hj3 : |j₃| ≤ 1 := by
    rw [← abs_one, ← sq_le_sq]; nlinarith [sq_nonneg x₃]
  have hj12 : |j₁ * j₂| ≤ (j₁ ^ 2 + j₂ ^ 2) / 2 := by
    rw [abs_le]; constructor <;> nlinarith [sq_nonneg (j₁ + j₂), sq_nonneg (j₁ - j₂)]
  have hx12 : |x₁ * x₂| ≤ (x₁ ^ 2 + x₂ ^ 2) / 2 := by
    rw [abs_le]; constructor <;> nlinarith [sq_nonneg (x₁ + x₂), sq_nonneg (x₁ - x₂)]
  calc |c * (j₁ * j₂ * j₃) + x₁ * x₂ * x₃|
      ≤ |c * (j₁ * j₂ * j₃)| + |x₁ * x₂ * x₃| := abs_add_le _ _
    _ = c * (|j₁ * j₂| * |j₃|) + |x₁ * x₂| * |x₃| := by
        rw [abs_mul, abs_of_nonneg hc0, abs_mul (j₁ * j₂), abs_mul (x₁ * x₂)]
    _ ≤ 1 * (|j₁ * j₂| * 1) + |x₁ * x₂| * 1 := by
        gcongr
    _ ≤ (j₁ ^ 2 + j₂ ^ 2) / 2 + (x₁ ^ 2 + x₂ ^ 2) / 2 := by linarith
    _ = 1 := by linarith
