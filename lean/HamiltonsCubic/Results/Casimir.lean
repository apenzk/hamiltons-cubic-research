import Mathlib
import HamiltonsCubic.Results.ClassTraceTest
import HamiltonsCubic.Base.WeylReal

/-!
# The Casimir identity on symmetric matrices

For the basis bivectors `φ_ij = E_ji − E_ij` of `𝔰𝔬(n)` and symmetric `h`,
`∑_{i,j} ‖[φ_ij, h]‖_F² = 4n tr(h²) − 4 (tr h)²` (ordered pairs; half of it over `i < j`), the
Casimir mass behind [r1160](../../../reviews/REVIEW_r1160.md)'s `|⟨h, e̊h⟩| ≤ (n/κ)|h|²` used in
[the per-vector note](../../../reviews/2026-09-25-I73c-per-vector-rows.md). The route is the
completeness relation `∑ φ_ab φ_cd = 2(δ_ac δ_bd − δ_ad δ_bc)` and its operator form
`∑ φ M φ = 2(Mᵀ − (tr M) I)`.
-/

namespace HamiltonsCubic.Casimir

open Matrix

variable {n : ℕ}

/-- `φ_ij = E_ji − E_ij`. -/
def phi (i j : Fin n) : Matrix (Fin n) (Fin n) ℝ :=
  Matrix.of fun a b => (if a = j ∧ b = i then 1 else 0) - (if a = i ∧ b = j then 1 else 0)

theorem completeness (a b c d : Fin n) :
    ∑ i, ∑ j, phi i j a b * phi i j c d
      = 2 * ((if a = c ∧ b = d then 1 else 0) - (if a = d ∧ b = c then 1 else 0)) := by
  simp only [phi, Matrix.of_apply]
  simp only [mul_sub, sub_mul, ite_and, mul_ite, ite_mul, mul_one, one_mul, mul_zero, zero_mul,
    Finset.sum_sub_distrib]
  simp only [Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true, Finset.sum_const_zero]
  by_cases h1 : a = c <;> by_cases h2 : b = d <;> by_cases h3 : a = d <;> by_cases h4 : b = c <;>
    by_cases h5 : a = b <;> by_cases h6 : c = d <;> simp_all <;> ring

/-- **The operator form**: `∑_{i,j} φ_ij M φ_ij = 2(Mᵀ − (tr M) I)`. -/
theorem sum_phi_M_phi (M : Matrix (Fin n) (Fin n) ℝ) :
    ∑ i, ∑ j, phi i j * M * phi i j = (2 : ℝ) • (Mᵀ - M.trace • (1 : Matrix (Fin n) (Fin n) ℝ)) := by
  ext a d
  simp only [Matrix.sum_apply, Matrix.mul_apply, Matrix.smul_apply, Matrix.sub_apply,
    Matrix.transpose_apply, Matrix.one_apply, smul_eq_mul, Matrix.trace, Matrix.diag]
  set F : Fin n → Fin n → Fin n → Fin n → ℝ := fun i j c b => M b c * (phi i j a b * phi i j c d)
  have e : ∀ i j : Fin n, ∑ c, (∑ b, phi i j a b * M b c) * phi i j c d = ∑ c, ∑ b, F i j c b := by
    intro i j; refine Finset.sum_congr rfl fun c _ => ?_
    rw [Finset.sum_mul]; refine Finset.sum_congr rfl fun b _ => ?_; simp only [F]; ring
  have s1 : ∀ i, ∑ j, ∑ c, ∑ b, F i j c b = ∑ c, ∑ b, ∑ j, F i j c b := fun i => by
    rw [Finset.sum_comm]; exact Finset.sum_congr rfl fun c _ => Finset.sum_comm
  have s2 : ∑ i, ∑ c, ∑ b, ∑ j, F i j c b = ∑ c, ∑ b, ∑ i, ∑ j, F i j c b := by
    rw [Finset.sum_comm]; exact Finset.sum_congr rfl fun c _ => Finset.sum_comm
  have s3 : ∀ c b, ∑ i, ∑ j, F i j c b
      = M b c * (2 * ((if a = c ∧ b = d then 1 else 0) - (if a = d ∧ b = c then 1 else 0))) := by
    intro c b; simp only [F, ← Finset.mul_sum]; rw [completeness]
  simp only [e, s1]
  rw [s2]; simp only [s3]
  simp only [mul_sub, mul_ite, mul_one, mul_zero, ite_and, Finset.sum_sub_distrib,
    Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  by_cases had : a = d
  · subst had; simp [Finset.mul_sum]; ring
  · simp [had, Ne.symm had]; ring

theorem phi_transpose (i j : Fin n) : (phi i j)ᵀ = -phi i j := by
  ext a b; simp only [phi, Matrix.transpose_apply, Matrix.of_apply, Matrix.neg_apply, neg_sub]
  congr 1 <;> simp only [and_comm]

theorem trace_sum {ι : Type*} [Fintype ι] (f : ι → Matrix (Fin n) (Fin n) ℝ) :
    (∑ i, f i).trace = ∑ i, (f i).trace := Matrix.trace_sum _ _

/-- **The Casimir identity**: for symmetric `h`, `∑_{i,j} ‖[φ_ij, h]‖_F² = 4n tr(h²) − 4(tr h)²`. -/
theorem casimir (h : Matrix (Fin n) (Fin n) ℝ) (hs : hᵀ = h) :
    ∑ i, ∑ j, ((phi i j * h - h * phi i j)ᵀ * (phi i j * h - h * phi i j)).trace
      = 4 * n * (h * h).trace - 4 * h.trace ^ 2 := by
  have hsym : ∀ i j, (phi i j * h - h * phi i j)ᵀ = phi i j * h - h * phi i j := by
    intro i j
    rw [transpose_sub, transpose_mul, transpose_mul, hs, phi_transpose]
    simp [Matrix.neg_mul, Matrix.mul_neg]; abel
  have hterm : ∀ i j, ((phi i j * h - h * phi i j)ᵀ * (phi i j * h - h * phi i j)).trace
      = 2 * (phi i j * h * phi i j * h).trace - 2 * (phi i j * phi i j * h * h).trace := by
    intro i j
    rw [hsym, HamiltonsCubic.ClassTraceTest.trace_psi_h (phi i j) h]; ring
  simp only [hterm, Finset.sum_sub_distrib, ← Finset.mul_sum]
  have A : ∑ i, ∑ j, (phi i j * h * phi i j * h).trace = 2 * ((h * h).trace - h.trace ^ 2) := by
    have := congrArg (fun M => (M * h).trace) (sum_phi_M_phi h)
    simp only [Finset.sum_mul, Matrix.trace_sum] at this
    rw [this, hs]
    simp [Matrix.smul_mul, Matrix.sub_mul, Matrix.trace_sub, Matrix.trace_smul, sq]
  have B : ∑ i, ∑ j, (phi i j * phi i j * h * h).trace = 2 * (1 - n) * (h * h).trace := by
    have := congrArg (fun M => (M * (h * h)).trace) (sum_phi_M_phi (1 : Matrix (Fin n) (Fin n) ℝ))
    simp only [Finset.sum_mul, Matrix.trace_sum, Matrix.mul_one] at this
    simp only [Matrix.mul_assoc] at this ⊢
    rw [this]
    simp [Matrix.smul_mul, Matrix.sub_mul, Matrix.trace_sub, Matrix.trace_smul, Matrix.trace_one]
    ring
  rw [A, B]; ring

/-- **This file's `φ` is the layer's**: `Casimir.phi i j = RealLayer.phi i j` (`single j i 1 − single i j 1`). -/
theorem phi_eq_layer (i j : Fin n) : phi i j = HamiltonsCubic.RealLayer.phi i j := by
  ext a b; simp [phi, HamiltonsCubic.RealLayer.phi, Matrix.single_apply, eq_comm]

/-- **The traceless form**: for symmetric traceless `h`, `∑_{i,j} ‖[φ_ij, h]‖_F² = 4n tr(h²)`; over
`i < j` (half, since `φ_ii = 0` and `φ_ji = −φ_ij`) this is r1160's `2n |h|²`. -/
theorem casimir_traceless (h : Matrix (Fin n) (Fin n) ℝ) (hs : hᵀ = h) (ht : h.trace = 0) :
    ∑ i, ∑ j, ((phi i j * h - h * phi i j)ᵀ * (phi i j * h - h * phi i j)).trace
      = 4 * n * (h * h).trace := by
  rw [casimir h hs, ht]; ring

/-- **The Casimir identity on skew matrices**, row (A) of the per-vector rows in trace form: for skew
`x`, `∑_{i,j} ‖[φ_ij, x]‖_F² = 4(n − 2) ‖x‖_F²` over ordered pairs. -/
theorem casimir_skew (x : Matrix (Fin n) (Fin n) ℝ) (hx : xᵀ = -x) :
    ∑ i, ∑ j, ((phi i j * x - x * phi i j)ᵀ * (phi i j * x - x * phi i j)).trace
      = 4 * ((n : ℝ) - 2) * (xᵀ * x).trace := by
  have htr : x.trace = 0 := by
    have := congrArg Matrix.trace hx
    rw [Matrix.trace_transpose, Matrix.trace_neg] at this; linarith
  have hskew : ∀ i j, (phi i j * x - x * phi i j)ᵀ = -(phi i j * x - x * phi i j) := by
    intro i j
    rw [transpose_sub, transpose_mul, transpose_mul, hx, phi_transpose]
    simp [Matrix.neg_mul, Matrix.mul_neg]
  have hterm : ∀ i j, ((phi i j * x - x * phi i j)ᵀ * (phi i j * x - x * phi i j)).trace
      = -(2 * (phi i j * x * phi i j * x).trace - 2 * (phi i j * phi i j * x * x).trace) := by
    intro i j
    rw [hskew, Matrix.neg_mul, Matrix.trace_neg,
      HamiltonsCubic.ClassTraceTest.trace_psi_h (phi i j) x]; ring
  simp only [hterm, Finset.sum_neg_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum]
  have A : ∑ i, ∑ j, (phi i j * x * phi i j * x).trace = 2 * (xᵀ * x).trace := by
    have := congrArg (fun M => (M * x).trace) (sum_phi_M_phi x)
    simp only [Finset.sum_mul, Matrix.trace_sum] at this
    rw [this, htr]
    simp [Matrix.smul_mul, Matrix.trace_smul]
  have B : ∑ i, ∑ j, (phi i j * phi i j * x * x).trace = 2 * ((n : ℝ) - 1) * (xᵀ * x).trace := by
    have := congrArg (fun M => (M * (x * x)).trace) (sum_phi_M_phi (1 : Matrix (Fin n) (Fin n) ℝ))
    simp only [Finset.sum_mul, Matrix.trace_sum, Matrix.mul_one] at this
    simp only [Matrix.mul_assoc] at this ⊢
    rw [this, hx]
    simp [Matrix.smul_mul, Matrix.sub_mul, Matrix.trace_sub, Matrix.trace_smul, Matrix.trace_one,
      Matrix.neg_mul, Matrix.trace_neg]
    ring
  rw [A, B]; ring

/-- **Halving**: for `f` symmetric with zero diagonal, the ordered sum is twice the sum over `i < j`. -/
theorem sum_halve (f : Fin n → Fin n → ℝ) (hs : ∀ i j, f i j = f j i) (hd : ∀ i, f i i = 0) :
    ∑ i, ∑ j, f i j = 2 * ∑ i, ∑ j, if i < j then f i j else 0 := by
  have pw : ∀ i j, f i j = (if i < j then f i j else 0) + (if j < i then f j i else 0) := by
    intro i j
    rcases lt_trichotomy i j with h | h | h
    · simp [h, not_lt.mpr h.le]
    · subst h; simp [hd]
    · simp [h, not_lt.mpr h.le, hs i j]
  have e : ∑ i, ∑ j, (if j < i then f j i else (0:ℝ)) = ∑ i, ∑ j, if i < j then f i j else 0 := by
    rw [Finset.sum_comm]
  calc ∑ i, ∑ j, f i j
      = ∑ i, ∑ j, ((if i < j then f i j else 0) + (if j < i then f j i else 0)) :=
        Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => pw i j
    _ = _ := by simp only [Finset.sum_add_distrib, e]; ring

theorem phi_swap (i j : Fin n) : phi j i = -phi i j := by
  ext a b; simp only [phi, Matrix.of_apply, Matrix.neg_apply, neg_sub]

theorem phi_diag (i : Fin n) : phi i i = 0 := by
  ext a b; simp [phi]

/-- **Row (A) over the basis `i < j`**: for skew `x`, `∑_{i<j} ‖[φ_ij, x]‖_F² = 2(n − 2) ‖x‖_F²`, i.e.
`∑_{i<j} ⟨[φ_ij, x], [φ_ij, x]⟩ = 2(n − 2) ⟨x, x⟩` in the record's `½ tr` norm. -/
theorem casimir_skew_lt (x : Matrix (Fin n) (Fin n) ℝ) (hx : xᵀ = -x) :
    ∑ i, ∑ j, (if i < j then ((phi i j * x - x * phi i j)ᵀ * (phi i j * x - x * phi i j)).trace
      else 0) = 2 * ((n : ℝ) - 2) * (xᵀ * x).trace := by
  have h := casimir_skew x hx
  have hh := sum_halve (fun i j => ((phi i j * x - x * phi i j)ᵀ * (phi i j * x - x * phi i j)).trace)
    (fun i j => by
      have e : phi j i * x - x * phi j i = -(phi i j * x - x * phi i j) := by
        rw [phi_swap]; simp only [Matrix.neg_mul, Matrix.mul_neg]; abel
      rw [e, Matrix.transpose_neg, Matrix.neg_mul, Matrix.mul_neg, neg_neg])
    (fun i => by simp [phi_diag])
  beta_reduce at hh
  linarith

end HamiltonsCubic.Casimir
