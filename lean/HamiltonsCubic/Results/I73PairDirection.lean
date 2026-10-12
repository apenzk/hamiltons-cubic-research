import Mathlib

set_option linter.style.longLine false

/-!
# The pair direction's `#` term, the load-bearing algebraic step of route R33

Route [R33](../../../routes.md) tests second-order optimality at a maximiser along the **pair
direction** built from two orthonormal eigenvectors `u`, `v` of `W`. *An earlier version of this
line said "lying in distinct eigenspaces", which the round's own worked example violates: at the
(4,4) split the two disjoint coordinate planes carry the SAME eigenvalue.* **What the identity
consumes is orthonormality and nothing else** ([r1083](../../../reviews/REVIEW_r1083.md),
[r1084](../../../reviews/REVIEW_r1084.md), agreeing). Writing
`Y = (u vᵀ + v uᵀ)/2`, the `#` half of `⟪Y, e ∘ Y⟫` reduces through the identity
`⟪Y, sharpBil E Y⟫ = -(1/2) ∑ a, ε a * tr ((ad a * Y)^2)` to one trace per basis element, and
this file proves the trace.

**THE HYPOTHESES ARE FEWER THAN THE APPLICATION SUPPLIES, AND THAT IS THE POINT.** *Neither
`u` nor `v` need be a unit vector, and they need not be orthogonal: antisymmetry of `A` alone
carries the identity.* The application's orthonormality is consumed elsewhere, in the
`W²`-half and in the norm `‖Y‖² = 1/2`, so stating it here would hide which hypothesis does
the work.

The scalar `u ⬝ᵥ (A *ᵥ v)` is the structure constant `⟪[φ_a, v], u⟫`, so the identity says the
`#` term is quadratic in the commutator `[u, v]`, which is what makes it VANISH on two
commuting directions. *Two disjoint coordinate planes commute, so the unprojected pair
direction carries no `#` content at all and the whole of it is carried by the projection onto
`Weyl_n`, which is the finding this file's application rests on.*
-/

namespace HamiltonsCubic.Results

open Matrix

variable {N : Type*} [Fintype N] [DecidableEq N]

/-- **THE ANTISYMMETRIC FORM SWAPS SIGN**, `y ⬝ A x = -(x ⬝ A y)`. -/
theorem dotProduct_mulVec_swap {A : Matrix N N ℝ} (hA : Aᵀ = -A) (x y : N → ℝ) :
    y ⬝ᵥ (A *ᵥ x) = -(x ⬝ᵥ (A *ᵥ y)) := by
  rw [dotProduct_mulVec, ← mulVec_transpose, hA, neg_mulVec, neg_dotProduct,
    dotProduct_comm]

/-- **An antisymmetric matrix has zero quadratic form**, the swap at `x = y`. -/
theorem dotProduct_mulVec_self_eq_zero {A : Matrix N N ℝ} (hA : Aᵀ = -A) (x : N → ℝ) :
    x ⬝ᵥ (A *ᵥ x) = 0 := by
  have h := dotProduct_mulVec_swap hA x x
  linarith

/-- **THE PAIR DIRECTION'S TRACE, AT EVERY ANTISYMMETRIC `A`.**

`tr ((A Y)²) = (1/2) (u ⬝ A v)²` for `Y = (u vᵀ + v uᵀ)/2`.

*Antisymmetry is the only hypothesis: the two cross terms die because `A`'s quadratic form
vanishes, and the two surviving terms are equal because the form swaps sign.* -/
theorem trace_sq_pair_direction {A : Matrix N N ℝ} (hA : Aᵀ = -A) (u v : N → ℝ) :
    trace ((A * ((1/2 : ℝ) • (vecMulVec u v + vecMulVec v u))) *
           (A * ((1/2 : ℝ) • (vecMulVec u v + vecMulVec v u))))
      = (1/2) * (u ⬝ᵥ (A *ᵥ v))^2 := by
  have hmul : ∀ a b c d : N → ℝ,
      vecMulVec a b * vecMulVec c d = (b ⬝ᵥ c) • vecMulVec a d := by
    intro a b c d
    ext i j
    simp [vecMulVec_apply, mul_apply, dotProduct, Finset.sum_mul, Finset.mul_sum,
      mul_comm, mul_left_comm, mul_assoc]
  have hAv : ∀ a b : N → ℝ, A * vecMulVec a b = vecMulVec (A *ᵥ a) b := by
    intro a b
    ext i j
    simp [vecMulVec_apply, mul_apply, mulVec, dotProduct, Finset.sum_mul, mul_assoc]
  have huu := dotProduct_mulVec_self_eq_zero hA u
  have hvv := dotProduct_mulVec_self_eq_zero hA v
  have hsw : v ⬝ᵥ (A *ᵥ u) = -(u ⬝ᵥ (A *ᵥ v)) := dotProduct_mulVec_swap hA u v
  have hc1 : (A *ᵥ u) ⬝ᵥ v = -(u ⬝ᵥ (A *ᵥ v)) := by rw [dotProduct_comm]; exact hsw
  have hc2 : (A *ᵥ v) ⬝ᵥ u = u ⬝ᵥ (A *ᵥ v) := dotProduct_comm _ _
  have hc3 : (A *ᵥ u) ⬝ᵥ u = 0 := by rw [dotProduct_comm]; exact huu
  have hc4 : (A *ᵥ v) ⬝ᵥ v = 0 := by rw [dotProduct_comm]; exact hvv
  rw [Matrix.mul_smul, Matrix.mul_add, hAv, hAv, smul_mul_smul_comm,
    add_mul, mul_add, mul_add, hmul, hmul, hmul, hmul]
  simp only [trace_smul, trace_add, trace_vecMulVec, smul_eq_mul]
  rw [hvv, huu, hsw, hc1, hc2, hc3, hc4]
  ring

/-- **The pair direction itself**, `Y = (u vᵀ + v uᵀ)/2`. -/
noncomputable def pairDir (u v : N → ℝ) : Matrix N N ℝ :=
  (1/2 : ℝ) • (vecMulVec u v + vecMulVec v u)

/-- **THE PAIR DIRECTION SQUARES TO A SUM OF PROJECTIONS**, at orthonormal `u`, `v`.

*This is the whole of the anticommutator half: `⟪Y, (EY+YE)/2⟫ = tr (E Y²)`, so the half is
read off this square and needs nothing about `E`.* -/
theorem pairDir_sq {u v : N → ℝ} (huu : u ⬝ᵥ u = 1) (hvv : v ⬝ᵥ v = 1) (huv : u ⬝ᵥ v = 0) :
    pairDir u v * pairDir u v = (1/4 : ℝ) • (vecMulVec u u + vecMulVec v v) := by
  have hmul : ∀ a b c d : N → ℝ,
      vecMulVec a b * vecMulVec c d = (b ⬝ᵥ c) • vecMulVec a d := by
    intro a b c d
    ext i j
    simp [vecMulVec_apply, mul_apply, dotProduct, Finset.sum_mul, Finset.mul_sum,
      mul_comm, mul_left_comm, mul_assoc]
  have hvu : v ⬝ᵥ u = 0 := by rw [dotProduct_comm]; exact huv
  simp only [pairDir, Matrix.smul_mul, Matrix.mul_smul, Matrix.add_mul, Matrix.mul_add,
    hmul, huu, hvv, huv, hvu]
  module

/-- **THE ANTICOMMUTATOR HALF OF THE PAIR DIRECTION'S QUOTIENT.**

`⟪Y, (EY + YE)/2⟫ = tr (E Y²) = (u ⬝ E u + v ⬝ E v)/4` at orthonormal `u`, `v`.

*At eigenvectors with eigenvalues `a`, `b` this is `(a+b)/4`, and dividing by `‖Y‖² = 1/2`
gives the `(ε_α + ε_β)/2` of the record's Lemma L233.* -/
theorem trace_mul_pairDir_sq (E : Matrix N N ℝ) {u v : N → ℝ}
    (huu : u ⬝ᵥ u = 1) (hvv : v ⬝ᵥ v = 1) (huv : u ⬝ᵥ v = 0) :
    trace (E * (pairDir u v * pairDir u v))
      = (1/4 : ℝ) * (u ⬝ᵥ (E *ᵥ u) + v ⬝ᵥ (E *ᵥ v)) := by
  have hEv : ∀ a b : N → ℝ, E * vecMulVec a b = vecMulVec (E *ᵥ a) b := by
    intro a b
    ext i j
    simp [vecMulVec_apply, mul_apply, mulVec, dotProduct, Finset.sum_mul, mul_assoc]
  rw [pairDir_sq huu hvv huv, Matrix.mul_smul, Matrix.mul_add, hEv, hEv]
  simp only [trace_smul, trace_add, trace_vecMulVec, smul_eq_mul]
  rw [dotProduct_comm (E *ᵥ u) u, dotProduct_comm (E *ᵥ v) v]

/-- **`‖Y‖² = 1/2` at orthonormal `u`, `v`**, the normalisation the quotient divides by. -/
theorem trace_pairDir_sq {u v : N → ℝ} (huu : u ⬝ᵥ u = 1) (hvv : v ⬝ᵥ v = 1)
    (huv : u ⬝ᵥ v = 0) : trace (pairDir u v * pairDir u v) = 1/2 := by
  rw [pairDir_sq huu hvv huv]
  simp only [trace_smul, trace_add, trace_vecMulVec, smul_eq_mul, huu, hvv]
  norm_num

end HamiltonsCubic.Results
