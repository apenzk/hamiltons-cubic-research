import Mathlib.Tactic

/-!
# L247: the class-trace form of the leading pair test on the symmetric family

[findings/second-order.md](../../../findings/second-order.md), Lemma L247.

[reviews/2026-09-25-I73c-per-vector-rows.md](../../../reviews/2026-09-25-I73c-per-vector-rows.md),
the class-trace paragraph, with the identity found by [r1149](../../../reviews/REVIEW_r1149.md).

On the symmetric family `λ = (-a, 0, a)` with `dim E₀ = dim E₂ = p`, `dim E₁ = m`, the traces
`t_abc = tr(P_a B_bc)` are totally symmetric and satisfy the nine traced rows (A), (B), (C). With
`κ = θ/a = θ√(2p)` and `D = (t₂₂₂ - t₀₀₂ + p)/2`, the rank certificate for the bracket part of the
pair operator fires exactly when `D < 0`.

**Typed here**: from the nine rows, `16 D = (n - 5 - κ) p - 4 t₀₀₀ - t₀₁₁ - 4 t₁₂₂`
(`sixteenD_identity`), hence `D < 0` whenever `κ > n - 5` and the three traces are nonnegative
(`D_neg_of_kappa`). The rows are hypotheses; the objects `t_abc` are reals here, since the layer has
no declaration for `B_ab = P_a # P_b` on eigenspace projections.
-/

namespace HamiltonsCubic.ClassTraceTest

variable (t000 t001 t002 t011 t012 t022 t111 t112 t122 t222 n p m κ : ℝ)

/-- The nine traced rows, `κ = θ/a`. -/
def Rows (t000 t001 t002 t011 t012 t022 t111 t112 t122 t222 n p m κ : ℝ) : Prop :=
  t000 + 2*t001 + 2*t002 + t011 + 2*t012 + t022 = (n-2)*p ∧
  t001 + 2*t011 + 2*t012 + t111 + 2*t112 + t122 = (n-2)*m ∧
  t002 + 2*t012 + 2*t022 + t112 + 2*t122 + t222 = (n-2)*p ∧
  t022 - t000 + t012 - t001 = p ∧
  t122 - t001 + t112 - t011 = 0 ∧
  t222 - t002 + t122 - t012 = -p ∧
  t000 - 2*t002 + t022 = -(κ+1)*p ∧
  t001 - 2*t012 + t122 = 0 ∧
  t002 - 2*t022 + t222 = (κ-1)*p

/-- **r1149's identity**: `16 D = (n - 5 - κ) p - 4 t₀₀₀ - t₀₁₁ - 4 t₁₂₂`. -/
theorem sixteenD_identity
    (h : Rows t000 t001 t002 t011 t012 t022 t111 t112 t122 t222 n p m κ) :
    16 * ((t222 - t002 + p) / 2) = (n - 5 - κ) * p - 4*t000 - t011 - 4*t122 := by
  obtain ⟨hA0, _, hA2, _, hB1, hB2, hC0, hC1, hC2⟩ := h
  linarith

/-- **The certificate fires by nonnegativity alone when `κ > n - 5`.** -/
theorem D_neg_of_kappa
    (h : Rows t000 t001 t002 t011 t012 t022 t111 t112 t122 t222 n p m κ)
    (hp : 0 < p) (hκ : n - 5 < κ) (h000 : 0 ≤ t000) (h011 : 0 ≤ t011) (h122 : 0 ≤ t122) :
    (t222 - t002 + p) / 2 < 0 := by
  have hid := sixteenD_identity t000 t001 t002 t011 t012 t022 t111 t112 t122 t222 n p m κ h
  nlinarith [mul_pos hp (sub_pos.mpr hκ)]

/-- **The test in the `E₀` form**: `D < 0` iff `t₀₀₁ < t₀₁₂`. -/
theorem D_neg_iff (h : Rows t000 t001 t002 t011 t012 t022 t111 t112 t122 t222 n p m κ) :
    (t222 - t002 + p) / 2 < 0 ↔ t001 < t012 := by
  obtain ⟨_, _, _, _, _, hB2, _, hC1, _⟩ := h
  constructor <;> intro <;> linarith

/-- **Nonvacuity**: r1149's witness at `D = 0` (`t₁₂₂ = 0`) satisfies the rows. -/
theorem witness_rows (n p m κ : ℝ) :
    Rows ((n-κ-5)*p/4) 0 ((n+κ-1)*p/4) 0 0 ((n-κ-1)*p/4) ((n-2)*m) 0 0 ((n+κ-5)*p/4)
      n p m κ := by
  unfold Rows; refine ⟨?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩ <;> ring

/-- **The absolute margin in the forced region**: the certificate's excess over `½`, which is
`-D/(pκ)`, is at least `(κ - (n - 5))/(16 κ)`, independent of `p`. -/
theorem margin_lower
    (h : Rows t000 t001 t002 t011 t012 t022 t111 t112 t122 t222 n p m κ)
    (hp : 0 < p) (hκ : 0 < κ) (h000 : 0 ≤ t000) (h011 : 0 ≤ t011) (h122 : 0 ≤ t122) :
    (κ - (n - 5)) / (16 * κ) ≤ -((t222 - t002 + p) / 2) / (p * κ) := by
  have hid := sixteenD_identity t000 t001 t002 t011 t012 t022 t111 t112 t122 t222 n p m κ h
  rw [div_le_div_iff₀ (by positivity) (by positivity)]
  nlinarith [mul_pos hp hκ]

/-- **The band is empty**: the rows give `4 t₀₀₀ + 4 t₀₀₁ + t₀₁₁ = (n − 5 − κ) p`, so nonnegative
traces force `κ ≤ n − 5`, L244's `x`-free ceiling in traced form. The region `κ > n − 5` where
`D_neg_of_kappa` fires holds no point of the rows with nonnegative traces. -/
theorem rows_trace_ceiling (h : Rows t000 t001 t002 t011 t012 t022 t111 t112 t122 t222 n p m κ) :
    4*t000 + 4*t001 + t011 = (n - 5 - κ) * p := by
  obtain ⟨hA0, _, _, hB0, _, _, hC0, _, _⟩ := h
  linarith

theorem band_empty (h : Rows t000 t001 t002 t011 t012 t022 t111 t112 t122 t222 n p m κ)
    (hp : 0 < p) (h000 : 0 ≤ t000) (h001 : 0 ≤ t001) (h011 : 0 ≤ t011) : κ ≤ n - 5 := by
  have hid := rows_trace_ceiling t000 t001 t002 t011 t012 t022 t111 t112 t122 t222 n p m κ h
  by_contra hc
  push_neg at hc
  nlinarith [mul_pos hp (sub_pos.mpr hc)]

/-- **The trace identity behind the Ricci correction**: `tr(ψhψh) = ½ tr([ψ,h]²) + tr(ψ²h²)` for any
square matrices. Summed over an eigenspace it splits `Q_c(h)` into a commutator mass and
`tr(A_c h²)`, and Ricci-flatness (`A₀ = A₂` on the symmetric family) cancels the second part. -/
theorem trace_psi_h {m : Type*} [Fintype m] [DecidableEq m] (ψ h : Matrix m m ℝ) :
    (ψ * h * ψ * h).trace
      = (1 / 2) * ((ψ * h - h * ψ) * (ψ * h - h * ψ)).trace + (ψ * ψ * h * h).trace := by
  have e1 : ((ψ * h - h * ψ) * (ψ * h - h * ψ)).trace
      = (ψ * h * ψ * h).trace - (ψ * h * h * ψ).trace - (h * ψ * ψ * h).trace
        + (h * ψ * h * ψ).trace := by
    simp only [Matrix.sub_mul, Matrix.mul_sub, Matrix.trace_sub, Matrix.mul_assoc]; ring
  have e2 : (ψ * h * h * ψ).trace = (ψ * ψ * h * h).trace := by
    rw [show ψ * h * h * ψ = (ψ * h * h) * ψ from rfl, Matrix.trace_mul_comm]
    simp only [Matrix.mul_assoc]
  have e3 : (h * ψ * ψ * h).trace = (ψ * ψ * h * h).trace := by
    rw [show h * ψ * ψ * h = h * (ψ * ψ * h) by simp only [Matrix.mul_assoc],
      Matrix.trace_mul_comm]
  have e4 : (h * ψ * h * ψ).trace = (ψ * h * ψ * h).trace := by
    rw [show h * ψ * h * ψ = (h * ψ * h) * ψ from rfl, Matrix.trace_mul_comm]
    simp only [Matrix.mul_assoc]
  rw [e1, e2, e3, e4]; ring

/-- **The skew and symmetric parts of a matrix are orthogonal**: `tr(XᵀX) = tr(AᵀA) + tr(SᵀS)` with
`A = (X − Xᵀ)/2`, `S = (X + Xᵀ)/2`. Applied to `X = ∑ x_uv u v`, the skew part is half the bracket
`∑ x_uv [u,v]` and the symmetric part is `−h_x`, so `|h_x|² = ‖X‖² − ¼‖∑ x_uv [u,v]‖²`. -/
theorem skew_sym_split {m : Type*} [Fintype m] [DecidableEq m] (X : Matrix m m ℝ) :
    (X.transpose * X).trace = (((1/2 : ℝ) • (X - X.transpose)).transpose * ((1/2 : ℝ) • (X - X.transpose))).trace
      + (((1/2 : ℝ) • (X + X.transpose)).transpose * ((1/2 : ℝ) • (X + X.transpose))).trace := by
  simp only [Matrix.transpose_smul, Matrix.transpose_sub, Matrix.transpose_add,
    Matrix.transpose_transpose, Matrix.smul_mul, Matrix.mul_smul, Matrix.trace_smul,
    Matrix.sub_mul, Matrix.mul_sub, Matrix.add_mul, Matrix.mul_add, Matrix.trace_sub,
    Matrix.trace_add, smul_eq_mul]
  have h1 : (X * X).trace = (X.transpose * X.transpose).trace := by
    rw [← Matrix.trace_transpose, Matrix.transpose_mul]
  have h2 : (X * X.transpose).trace = (X.transpose * X).trace := Matrix.trace_mul_comm _ _
  rw [h1, h2]; ring

end HamiltonsCubic.ClassTraceTest
