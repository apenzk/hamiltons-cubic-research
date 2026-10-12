import Mathlib

set_option linter.style.longLine false

/-!
# I113 (a): the norm of the canonical Weyl tensor `Z(h)`, in `h`'s eigenframe

**With `h = diag(h_i)` traceless and of unit norm, `Z(h)` is the diagonal curvature operator with
entries `z_ij = h_i h_j + (h_i² + h_j²)/(n-2) - 1/((n-1)(n-2))`, and
`2 |Z|² = ∑_{i ≠ j} z_ij² = n/(n-1) · (1 - 2 t₄ + (n-3)/(n-2) · (t₄ - 1/n))`, `t₄ = ∑ h_i⁴`.**
*`Zdiag_normSq` is the norm half of step 2 of [the I113 note](../../../reviews/2026-09-23-I113-audit.md).
The sum is written over ordered pairs `i ≠ j` as the full double sum minus the diagonal.* **`pair_QZ` is the pairing half**: with `w i j = W_ijij` Ricci-flat and `h` its eigenvector, the pairing of `W` against `Q(Z)` is `(n-3)/(2(n-2)) ⟨r₀, W̊ r₀⟩ - μ t₄ + μ/2`. *Together they give step 2, `T(W,Z,Z) = βμ|Z|² - Δ_M`, as a polynomial identity; the Casimir step (1) stays untyped.*
-/

namespace HamiltonsCubic.Results

open Finset

/-- **The ordered-pair sum of `z_ij²` in closed form.** -/
theorem Zdiag_normSq {n : ℕ} (hn : 3 ≤ n) (h : Fin n → ℝ) (h1 : ∑ i, h i = 0)
    (h2 : ∑ i, h i ^ 2 = 1) :
    let a : ℝ := 1 / ((n : ℝ) - 2)
    let b : ℝ := -1 / (((n : ℝ) - 1) * ((n : ℝ) - 2))
    let z : Fin n → Fin n → ℝ := fun i j => h i * h j + a * (h i ^ 2 + h j ^ 2) + b
    (∑ i, ∑ j, z i j ^ 2) - ∑ i, z i i ^ 2
      = (n : ℝ) / ((n : ℝ) - 1) * (1 - 2 * ∑ i, h i ^ 4
          + ((n : ℝ) - 3) / ((n : ℝ) - 2) * (∑ i, h i ^ 4 - 1 / (n : ℝ))) := by
  intro a b z
  have hn2 : (n : ℝ) - 2 ≠ 0 := by
    have : (3 : ℝ) ≤ n := by exact_mod_cast hn
    linarith
  have hn1 : (n : ℝ) - 1 ≠ 0 := by
    have : (3 : ℝ) ≤ n := by exact_mod_cast hn
    linarith
  have hn0 : (n : ℝ) ≠ 0 := by
    have : (3 : ℝ) ≤ n := by exact_mod_cast hn
    linarith
  have hsq : ∀ i j, z i j ^ 2 = (h i ^ 2) * (h j ^ 2) + 2 * a * (h i ^ 3 * h j + h i * h j ^ 3)
      + 2 * b * (h i * h j) + a ^ 2 * (h i ^ 4 + h j ^ 4 + 2 * (h i ^ 2 * h j ^ 2))
      + 2 * a * b * (h i ^ 2 + h j ^ 2) + b ^ 2 := by
    intro i j; simp only [z]; ring
  simp only [hsq, sum_add_distrib, ← mul_sum, ← sum_mul, mul_add, sum_const, card_univ,
    Fintype.card_fin, nsmul_eq_mul]
  simp only [← sum_mul, h1, h2, mul_zero, zero_mul, add_zero, zero_add, mul_one]
  simp only [a, b]
  field_simp
  simp only [h2]
  ring


/-- **The pairing half of I113 (a)'s step 2**, in `h`'s eigenframe: with `w i j = W_ijij`
symmetric, zero on the diagonal, Ricci-flat (`∑_j w i j = 0`), and `h` an eigenvector of the
second-kind operator's diagonal (`∑_j w i j h j = μ h i`), the pairing of `W` against `Q(Z)` is
`(n-3)/(2(n-2)) ⟨r₀, W̊ r₀⟩ - μ t₄ + μ/2`. Stated with the sum over ALL `m` in `Q(Z)`'s `#` term
corrected by its `m = i` and `m = j` terms, which is `∑_{m ≠ i,j}`. -/
theorem pair_QZ {n : ℕ} (hn : 3 ≤ n) (h : Fin n → ℝ) (w : Fin n → Fin n → ℝ) (μ : ℝ)
    (h1 : ∑ i, h i = 0) (h2 : ∑ i, h i ^ 2 = 1)
    (hsym : ∀ i j, w i j = w j i) (hric : ∀ i, ∑ j, w i j = 0)
    (heig : ∀ i, ∑ j, w i j * h j = μ * h i) :
    let a : ℝ := 1 / ((n : ℝ) - 2)
    let b : ℝ := -1 / (((n : ℝ) - 1) * ((n : ℝ) - 2))
    let z : Fin n → Fin n → ℝ := fun i j => h i * h j + a * (h i ^ 2 + h j ^ 2) + b
    (1 / 2 : ℝ) * ∑ i, ∑ j, w i j * (z i j ^ 2
        + (∑ m, z i m * z j m) - z i i * z j i - z i j * z j j)
      = ((n : ℝ) - 3) / (2 * ((n : ℝ) - 2)) * ∑ i, ∑ j, w i j * h i ^ 2 * h j ^ 2
        - μ * ∑ i, h i ^ 4 + μ / 2 := by
  intro a b z
  set S3 := ∑ m, h m ^ 3
  set S4 := ∑ m, h m ^ 4
  -- the # term summed over all m, in closed form
  have hm : ∀ i j, ∑ m, z i m * z j m = h i * h j + a * S3 * (h i + h j)
      + (n : ℝ) * (a * h i ^ 2 + b) * (a * h j ^ 2 + b) + a * (a * h i ^ 2 + b) + a * (a * h j ^ 2 + b)
      + a ^ 2 * S4 := by
    intro i j
    have e : ∀ m, z i m * z j m = h i * h j * h m ^ 2 + a * h i * h m ^ 3 + a * h j * h m ^ 3
        + (h i * (a * h j ^ 2 + b) + h j * (a * h i ^ 2 + b)) * h m
        + (a * h i ^ 2 + b) * (a * h j ^ 2 + b)
        + (a * (a * h i ^ 2 + b) + a * (a * h j ^ 2 + b)) * h m ^ 2 + a ^ 2 * h m ^ 4 := by
      intro m; simp only [z]; ring
    simp only [e, sum_add_distrib, ← mul_sum, ← sum_mul, h1, h2, sum_const, card_univ,
      Fintype.card_fin, nsmul_eq_mul, mul_zero, zero_mul, add_zero, mul_one]
    ring
  -- the four sum rules
  have R1 : ∀ f : Fin n → ℝ, ∑ i, ∑ j, w i j * f i = 0 := by
    intro f; simp_rw [mul_comm (w _ _) (f _), ← mul_sum, hric, mul_zero, sum_const_zero]
  have R2 : ∀ g : Fin n → ℝ, ∑ i, ∑ j, w i j * g j = 0 := by
    intro g; rw [sum_comm]; simp_rw [hsym _ _, mul_comm (w _ _) (g _), ← mul_sum, hric, mul_zero,
      sum_const_zero]
  have E1 : ∀ f : Fin n → ℝ, ∑ i, ∑ j, w i j * (h j * f i) = μ * ∑ i, h i * f i := by
    intro f
    simp_rw [show ∀ i j, w i j * (h j * f i) = f i * (w i j * h j) from fun i j => by ring,
      ← mul_sum, heig, mul_sum]
    exact sum_congr rfl fun i _ => by ring
  have E2 : ∀ g : Fin n → ℝ, ∑ i, ∑ j, w i j * (h i * g j) = μ * ∑ j, h j * g j := by
    intro g; rw [sum_comm]
    simp_rw [hsym _ _]
    exact E1 g
  have hn2 : (n : ℝ) - 2 ≠ 0 := by
    have : (3 : ℝ) ≤ n := by exact_mod_cast hn
    linarith
  have hn1 : (n : ℝ) - 1 ≠ 0 := by
    have : (3 : ℝ) ≤ n := by exact_mod_cast hn
    linarith
  set K : ℝ := ((n : ℝ) - 3) / ((n : ℝ) - 2) with hK
  set c0 : ℝ := (S4 * n - S4 - 1) / (((n : ℝ) - 2) ^ 2 * ((n : ℝ) - 1)) with hc0
  set f : Fin n → ℝ := fun x => (1 - (n : ℝ)) / ((n : ℝ) - 2) ^ 2 * h x ^ 4
      + h x ^ 2 / ((n : ℝ) - 2) ^ 2 + S3 / ((n : ℝ) - 2) * h x + c0 / 2 with hf
  -- pointwise decomposition of the summand
  have hpt : ∀ i j, w i j * (z i j ^ 2 + (∑ m, z i m * z j m) - z i i * z j i - z i j * z j j)
      = K * (w i j * (h i ^ 2 * h j ^ 2)) - w i j * (h j * h i ^ 3) - w i j * (h i * h j ^ 3)
        + w i j * (h j * h i) + w i j * f i + w i j * f j := by
    intro i j
    rw [hm]
    simp only [z, a, b, hK, hf, hc0]
    field_simp
    ring
  simp_rw [hpt, sum_add_distrib, sum_sub_distrib, ← mul_sum]
  rw [R1 f, R2 f, E1 (fun i => h i ^ 3), E2 (fun j => h j ^ 3), E1 (fun i => h i)]
  have eq : ∑ i, ∑ j, w i j * (h i ^ 2 * h j ^ 2) = ∑ i, ∑ j, w i j * h i ^ 2 * h j ^ 2 :=
    sum_congr rfl fun i _ => sum_congr rfl fun j _ => by ring
  rw [eq]
  simp only [show ∀ i, h i * h i ^ 3 = h i ^ 4 from fun i => by ring,
    show ∀ i, h i * h i = h i ^ 2 from fun i => by ring, h2]
  rw [hK]
  field_simp
  ring

end HamiltonsCubic.Results
