import Mathlib

/-!
# L70, the deficiency identity in general, with its equality case

[findings/bounds.md](../../../findings/bounds.md), Lemma L70: at every critical point and every unit
`v ∈ E_min`, `θ = λ_min + (n − 2) λ_max − D(v)/|λ_min|` with
`D(v) = ½ ∑_{a,b} (λ_a λ_b − λ_min λ_max) c²_{vab} ≥ 0`.

In the per-vector rows (L244 (i)) at a unit eigenvector of `λ_min`, over any number of classes, with
`b_ij = ½ ∑ c²` the class masses: row (A) is `∑ b = n − 2` and row (C) is
`∑ λ_i λ_j b_ij = λ_min (θ − λ_min)`. Then `D = ∑ (λ_i λ_j − λ_min λ_max) b_ij` satisfies
`D = λ_min θ − λ_min² − (n − 2) λ_min λ_max` (`deficiency_eq`), hence the boxed identity when
`λ_min < 0` (`deficiency_identity`); `D ≥ 0` when `λ_min ≤ 0 ≤ λ_max` (`deficiency_nonneg`, the
corner minimum of `xy`); and `D = 0` iff every class pair carrying mass has `λ_i λ_j = λ_min λ_max`
(`deficiency_zero_iff`), the block's equality case. The rows enter as hypotheses.
-/

namespace HamiltonsCubic.L70Identity

variable {k : ℕ}

/-- The deficiency. -/
noncomputable def D (b : Fin k → Fin k → ℝ) (lam : Fin k → ℝ) (lmin lmax : ℝ) : ℝ :=
  ∑ i, ∑ j, (lam i * lam j - lmin * lmax) * b i j

theorem deficiency_eq (b : Fin k → Fin k → ℝ) (lam : Fin k → ℝ) (lmin lmax θ n : ℝ)
    (hA : ∑ i, ∑ j, b i j = n - 2)
    (hC : ∑ i, ∑ j, lam i * lam j * b i j = lmin * (θ - lmin)) :
    D b lam lmin lmax = lmin * θ - lmin ^ 2 - (n - 2) * (lmin * lmax) := by
  unfold D
  simp only [sub_mul, Finset.sum_sub_distrib, ← Finset.mul_sum]
  rw [hC, hA]; ring

/-- **The boxed identity.** -/
theorem deficiency_identity (b : Fin k → Fin k → ℝ) (lam : Fin k → ℝ) (lmin lmax θ n : ℝ)
    (hneg : lmin < 0)
    (hA : ∑ i, ∑ j, b i j = n - 2)
    (hC : ∑ i, ∑ j, lam i * lam j * b i j = lmin * (θ - lmin)) :
    θ = lmin + (n - 2) * lmax - D b lam lmin lmax / |lmin| := by
  rw [deficiency_eq b lam lmin lmax θ n hA hC, abs_of_neg hneg]
  have hne : lmin ≠ 0 := hneg.ne
  rw [show (lmin * θ - lmin ^ 2 - (n - 2) * (lmin * lmax)) / -lmin
      = -(θ - lmin - (n - 2) * lmax) by field_simp]
  ring

/-- The corner minimum: `λ_min λ_max ≤ xy` on `[λ_min, λ_max]²` when `λ_min ≤ 0 ≤ λ_max`. -/
theorem corner (lmin lmax x y : ℝ) (h0 : lmin ≤ 0) (h1 : 0 ≤ lmax)
    (hx0 : lmin ≤ x) (hx1 : x ≤ lmax) (hy0 : lmin ≤ y) (hy1 : y ≤ lmax) :
    lmin * lmax ≤ x * y := by
  rcases le_total 0 x with hx | hx
  · have a1 : x * lmin ≤ x * y := mul_le_mul_of_nonneg_left hy0 hx
    have a2 : lmax * lmin ≤ x * lmin := mul_le_mul_of_nonpos_right hx1 h0
    linarith
  · have a1 : x * lmax ≤ x * y := mul_le_mul_of_nonpos_left hy1 hx
    have a2 : lmin * lmax ≤ x * lmax := mul_le_mul_of_nonneg_right hx0 h1
    linarith

theorem deficiency_nonneg (b : Fin k → Fin k → ℝ) (lam : Fin k → ℝ) (lmin lmax : ℝ)
    (hb : ∀ i j, 0 ≤ b i j) (h0 : lmin ≤ 0) (h1 : 0 ≤ lmax)
    (hlo : ∀ i, lmin ≤ lam i) (hhi : ∀ i, lam i ≤ lmax) :
    0 ≤ D b lam lmin lmax :=
  Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ =>
    mul_nonneg (sub_nonneg.mpr
      (corner lmin lmax _ _ h0 h1 (hlo i) (hhi i) (hlo j) (hhi j))) (hb i j)

/-- **The equality case**: `D = 0` iff no class pair carrying mass has `λ_i λ_j ≠ λ_min λ_max`. -/
theorem deficiency_zero_iff (b : Fin k → Fin k → ℝ) (lam : Fin k → ℝ) (lmin lmax : ℝ)
    (hb : ∀ i j, 0 ≤ b i j) (h0 : lmin ≤ 0) (h1 : 0 ≤ lmax)
    (hlo : ∀ i, lmin ≤ lam i) (hhi : ∀ i, lam i ≤ lmax) :
    D b lam lmin lmax = 0 ↔ ∀ i j, (lam i * lam j - lmin * lmax) * b i j = 0 := by
  have hterm : ∀ i j, 0 ≤ (lam i * lam j - lmin * lmax) * b i j := fun i j =>
    mul_nonneg (sub_nonneg.mpr
      (corner lmin lmax _ _ h0 h1 (hlo i) (hhi i) (hlo j) (hhi j))) (hb i j)
  unfold D
  constructor
  · intro h i j
    have hi := (Finset.sum_eq_zero_iff_of_nonneg fun i _ =>
      Finset.sum_nonneg fun j _ => hterm i j).mp h i (Finset.mem_univ _)
    exact (Finset.sum_eq_zero_iff_of_nonneg fun j _ => hterm i j).mp hi j (Finset.mem_univ _)
  · intro h
    exact Finset.sum_eq_zero fun i _ => Finset.sum_eq_zero fun j _ => h i j

end HamiltonsCubic.L70Identity
