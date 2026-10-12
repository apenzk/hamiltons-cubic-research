import HamiltonsCubic.Base.WeylReal

/-!
# A row of the criticality relation bounds one eigenvalue's product

**What this is for.** [I71](../../../plan.md) asks what the `N-1` uncontracted rows of
`Q(W) = θW` carry beyond the spectrum, since contracting them can only return relations among power
sums. *The first use of a single row is here.*

Relation (C) reads `λᵀ T⁽ᵏ⁾ λ = 2 λ_k (θ - λ_k)` at the symmetric nonnegative matrix
`T⁽ᵏ⁾_{αγ} = T_{αkγ}`, whose row sums are `‖[v_α, v_k]‖² ≤ 2`, the pair cap. **A symmetric matrix
with nonnegative entries and row sums bounded by `c` has `|xᵀAx| ≤ c‖x‖²`**, which is the step this
file carries, and it gives `|λ_k(θ - λ_k)| ≤ 1`.

**Its ceiling is `2`**, since `λ + 1/λ ≥ 2`, so this use alone cannot reach `√(3/2)`. *The loss is
in bounding the largest eigenvalue of `T⁽ᵏ⁾` by one row at its maximum, while relation (A) says the
whole matrix sums to `2(n-2)` and so almost every row is far below the cap.*

**WHAT THIS FILE DOES NOT COVER**: relation (C) itself, the pair cap, or that `T` is the square of a
structure constant. It carries the inequality those three feed.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.RealLayer

open Finset

/-- **A nonnegative symmetric matrix with bounded row sums has a bounded quadratic form.**

*Stated with `|x α|` on both sides of the entry, which is what makes the bound hold at a mixed-sign
`x`, the eigenvalues of a Weyl tensor sum to zero, so `λ` always has both signs.* -/
theorem abs_quadratic_le_of_rowsum {ι : Type*} [Fintype ι] [DecidableEq ι]
    (A : ι → ι → ℝ) (c : ℝ) (x : ι → ℝ)
    (hnn : ∀ a b, 0 ≤ A a b) (hsym : ∀ a b, A a b = A b a)
    (hrow : ∀ a, ∑ b, A a b ≤ c) (hx : ∀ a, 0 ≤ x a ^ 2) :
    |∑ a, ∑ b, A a b * (x a * x b)| ≤ c * ∑ a, x a ^ 2 := by
  classical
  have key : ∀ a b, A a b * |x a * x b| ≤ A a b * ((x a ^ 2 + x b ^ 2) / 2) := by
    intro a b
    refine mul_le_mul_of_nonneg_left ?_ (hnn a b)
    rw [abs_mul]
    nlinarith [sq_nonneg (|x a| - |x b|), abs_nonneg (x a), abs_nonneg (x b),
      sq_abs (x a), sq_abs (x b)]
  have habs : |∑ a, ∑ b, A a b * (x a * x b)| ≤ ∑ a, ∑ b, A a b * ((x a ^ 2 + x b ^ 2) / 2) := by
    refine (Finset.abs_sum_le_sum_abs _ _).trans ?_
    refine Finset.sum_le_sum fun a _ => ?_
    refine (Finset.abs_sum_le_sum_abs _ _).trans ?_
    refine Finset.sum_le_sum fun b _ => ?_
    rw [abs_mul, abs_of_nonneg (hnn a b)]
    exact key a b
  refine habs.trans ?_
  have step : ∀ a, ∑ b, A a b * ((x a ^ 2 + x b ^ 2) / 2)
      = (x a ^ 2 * (∑ b, A a b) + ∑ b, A a b * x b ^ 2) / 2 := by
    intro a
    rw [Finset.mul_sum, ← Finset.sum_add_distrib, Finset.sum_div]
    exact Finset.sum_congr rfl fun b _ => by ring
  rw [Finset.sum_congr rfl fun a _ => step a, ← Finset.sum_div]
  have h1 : ∑ a, (x a ^ 2 * (∑ b, A a b) + ∑ b, A a b * x b ^ 2)
      ≤ 2 * (c * ∑ a, x a ^ 2) := by
    have hA : ∑ a, x a ^ 2 * (∑ b, A a b) ≤ c * ∑ a, x a ^ 2 := by
      rw [Finset.mul_sum]
      refine Finset.sum_le_sum fun a _ => ?_
      rw [mul_comm c]
      exact mul_le_mul_of_nonneg_left (hrow a) (hx a)
    have hB : ∑ a, ∑ b, A a b * x b ^ 2 ≤ c * ∑ a, x a ^ 2 := by
      rw [Finset.sum_comm, Finset.mul_sum]
      refine Finset.sum_le_sum fun b _ => ?_
      have : ∑ a, A a b * x b ^ 2 = (∑ a, A b a) * x b ^ 2 := by
        rw [Finset.sum_mul]
        exact Finset.sum_congr rfl fun a _ => by rw [hsym a b]
      rw [this, mul_comm c, mul_comm (∑ a, A b a) (x b ^ 2)]
      exact mul_le_mul_of_nonneg_left (hrow b) (hx b)
    rw [Finset.sum_add_distrib]
    linarith
  linarith


/-- **[L198](../../../findings/bounds.md)'s first display**: at a positive eigenvalue, the row
bound `|λ_k(θ - λ_k)| ≤ 1 - λ_k²` gives `θ λ_k ≤ 1`.

*The hollowness of `T` is what supplies `1 - λ_k²` in place of `1`, and it is proved in
[StructureSquare.lean](../Base/StructureSquare.lean); this file carries only the arithmetic step.* -/
theorem theta_mul_le_one (θ lam : ℝ) (hrow : |lam * (θ - lam)| ≤ 1 - lam ^ 2) :
    θ * lam ≤ 1 := by
  have h := (abs_le.mp hrow).2
  nlinarith [h]

/-- **[L198](../../../findings/bounds.md)'s corollary**, from crossing the two bounds.

*`hL107` is `θ ≤ c·m` and `hrow` is `θ·m ≤ 1 - 2m²` at `m = |λ_min|`.* **Stated squared, so no root
appears**: `θ²(c+2) ≤ c²` is `θ ≤ c/√(c+2)`, and at `c = n-1` that is `θ ≤ (n-1)/√(n+1)`. -/
theorem theta_sq_le_of_cross (θ m c : ℝ) (hm : 0 < m) (hc : 0 < c) (hθ : 0 ≤ θ)
    (hL107 : θ ≤ c * m) (hrow : θ * m ≤ 1 - 2 * m ^ 2) :
    θ ^ 2 * (c + 2) ≤ c ^ 2 := by
  have h1 : θ ^ 2 ≤ c * m * θ := by nlinarith [hL107, hθ]
  have h2 : c * m * θ ≤ c * (1 - 2 * m ^ 2) := by nlinarith [hrow, hc]
  have h3 : θ ^ 2 ≤ c - 2 * c * m ^ 2 := by nlinarith [h1, h2]
  have h4 : θ ≤ c * m := hL107
  nlinarith [h3, h4, hm, hc, hθ, sq_nonneg (θ - c * m), sq_nonneg (c * m - θ)]

end HamiltonsCubic.RealLayer
