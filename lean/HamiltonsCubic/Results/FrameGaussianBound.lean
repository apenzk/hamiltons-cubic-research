import Mathlib

/-!
# L238, the Gaussian form of a frame's bracket total, and the isotropic bound 42

[findings/second-order.md](../../../findings/second-order.md), Lemma L238.

For orthonormal `X₁,…,X₇ ∈ 𝔰𝔬(n)` (record norm `⟨X,Y⟩ = −½ tr XY`), `Q_i = −X_i²`, `P = Σ Q_i`,
`S_ij = X_iX_j + X_jX_i`, and `G(v)` the Gram matrix of `X₁v,…,X₇v` for standard Gaussian `v`,
the lemma reads
`T = Σ_{i≠j} ‖[X_i,X_j]‖² = E[(tr G)² − ‖G‖²] − 168 ≤ (1 − 1/r)(196 + 2 tr P²) − 168`,
`r = min(7, d − 1)`, `d = rank P`; when `P` is a multiple of the identity on its range,
`tr P² = 196/d` and `T ≤ 42`, with equality at `d = 7, 8`.

**Typed here**: `frame_identity` and `frame_bound`, (ii) at `r = 7` for every family with no
Gaussian (section `FrameIdentity` below); the per-pair matrix identity `bracket_quad` (the trace form of
`‖[X,Y]‖² = 2 tr(Q_X Q_Y) − ½‖S_XY‖²`), the pointwise step `sigma2_le`, and the closing
arithmetic `isotropic_frame_bound`. **Not typed**: the Gaussian fourth moment
`E[(vᵀAv)(vᵀBv)] = tr A tr B + 2 tr AB` (Isserlis), which turns the per-pair identity into
`T = E[2σ₂(G)] − 168`, and the rank bound `rank G(v) ≤ min(7, d − 1)` from `X_i v ⊥ v`.
They enter `isotropic_frame_bound` as the hypotheses `hT` and `hM`.
-/

namespace HamiltonsCubic.Results

open Matrix

/-- **The per-pair identity, in trace form.** With `‖[X,Y]‖² = tr(X²Y²) − tr(XYXY)` for skew
`X, Y`, the left side is the bracket norm and the right side is `2 tr(Q_X Q_Y) − ½ ‖S‖²`. It holds
for all square matrices, by cyclicity alone. -/
theorem bracket_quad {n : ℕ} (X Y : Matrix (Fin n) (Fin n) ℝ) :
    trace (X * X * (Y * Y)) - trace (X * Y * (X * Y)) =
      2 * trace (X * X * (Y * Y)) - (1 / 2) * trace ((X * Y + Y * X) * (X * Y + Y * X)) := by
  have h1 : trace (X * Y * (Y * X)) = trace (X * X * (Y * Y)) := by
    rw [show X * Y * (Y * X) = X * Y * Y * X by simp [Matrix.mul_assoc], Matrix.trace_mul_comm]
    simp [Matrix.mul_assoc]
  have h2 : trace (Y * X * (X * Y)) = trace (X * X * (Y * Y)) := by
    rw [show Y * X * (X * Y) = Y * (X * X * Y) by simp [Matrix.mul_assoc], Matrix.trace_mul_comm]
    simp [Matrix.mul_assoc]
  have h3 : trace (Y * X * (Y * X)) = trace (X * Y * (X * Y)) := by
    rw [show Y * X * (Y * X) = Y * (X * Y * X) by simp [Matrix.mul_assoc], Matrix.trace_mul_comm]
    simp [Matrix.mul_assoc]
  simp only [Matrix.add_mul, Matrix.mul_add, Matrix.trace_add]
  rw [h1, h2, h3]
  ring

/-- **The pointwise step**: for any `r` reals (applied to the eigenvalues of `G`), `(Σg)² − Σg² ≤ (1 − 1/r)(Σg)²`. -/
theorem sigma2_le {r : ℕ} (hr : 0 < r) (g : Fin r → ℝ) :
    (∑ k, g k) ^ 2 - ∑ k, g k ^ 2 ≤ (1 - 1 / (r : ℝ)) * (∑ k, g k) ^ 2 := by
  have hcs := sq_sum_le_card_mul_sum_sq (s := (Finset.univ : Finset (Fin r))) (f := g)
  simp only [Finset.card_univ, Fintype.card_fin] at hcs
  have hr' : (0 : ℝ) < r := by exact_mod_cast hr
  have : (∑ k, g k) ^ 2 / r ≤ ∑ k, g k ^ 2 := by
    rw [div_le_iff₀ hr']; linarith
  have e : (1 - 1 / (r : ℝ)) * (∑ k, g k) ^ 2 = (∑ k, g k) ^ 2 - (∑ k, g k) ^ 2 / r := by
    field_simp
  linarith

/-- **The isotropic bound.** `hT` is the Gaussian form of the total, `hM` the averaged pointwise
step with `r = rank G ≤ min(7, d − 1)` and `tr P² = 196/d`. Then `T ≤ 42` in every dimension. -/
theorem isotropic_frame_bound (d r : ℕ) (hd : 5 ≤ d) (hr1 : 1 ≤ r) (hr7 : r ≤ 7)
    (hrd : r + 1 ≤ d) (T M : ℝ) (hT : T = M - 168)
    (hM : M ≤ (1 - 1 / (r : ℝ)) * (196 + 2 * (196 / (d : ℝ)))) : T ≤ 42 := by
  subst hT
  have hdR : (5 : ℝ) ≤ d := by exact_mod_cast hd
  have hrR : (1 : ℝ) ≤ r := by exact_mod_cast hr1
  by_cases h8 : 8 ≤ d
  · have h8R : (8 : ℝ) ≤ d := by exact_mod_cast h8
    have hr7R : (r : ℝ) ≤ 7 := by exact_mod_cast hr7
    have a1 : 1 - 1 / (r : ℝ) ≤ 6 / 7 := by
      have : 1 / (7 : ℝ) ≤ 1 / r := one_div_le_one_div_of_le (by linarith) hr7R
      linarith
    have a2 : 196 + 2 * (196 / (d : ℝ)) ≤ 245 := by
      have : 196 / (d : ℝ) ≤ 49 / 2 := by
        rw [div_le_div_iff₀ (by linarith) (by norm_num)]; linarith
      linarith
    have a0 : 0 ≤ 1 - 1 / (r : ℝ) := by
      rw [sub_nonneg, div_le_one (by linarith)]; exact hrR
    have : (1 - 1 / (r : ℝ)) * (196 + 2 * (196 / (d : ℝ))) ≤ 6 / 7 * 245 :=
      mul_le_mul a1 a2 (by positivity) (by norm_num)
    linarith
  · have h8 : d < 8 := by omega
    interval_cases d <;> interval_cases r <;> norm_num at hM ⊢ <;> linarith

/-- **Sharpness at `d = 8`**: `r = 7` and `tr P² = 196/8` give exactly `42`, the octonion frame. -/
theorem isotropic_frame_d8 : (1 - 1 / (7 : ℝ)) * (196 + 2 * (196 / 8)) - 168 = 42 := by norm_num

/-- **Sharpness at `d = 7`**: `r = 6` and `tr P² = 28` give exactly `42`, the `𝔤₂` complement. -/
theorem isotropic_frame_d7 : (1 - 1 / (6 : ℝ)) * (196 + 2 * (196 / 7)) - 168 = 42 := by norm_num

/-! ### (ii) at `r = 7` without the Gaussian: an exact trace identity

For any family `X₀,…,X_{k-1}` of square matrices, with `Q_i = −X_i²`, `P = Σ Q_i` and
`M_ij = −½(X_iX_j + X_jX_i)` off the diagonal, `M_ii = Q_i − P/k`,
`Σ_{i,j} (tr(X_i²X_j²) − tr(X_iX_jX_iX_j)) = 2(1 − 1/k) tr P² − 2 Σ_{i,j} tr M_ij²`.
For skew `X_i` the left side is the ordered bracket total in the record norm and each `M_ij` is
symmetric, so the subtracted sum is a sum of squares. -/

section FrameIdentity

variable {n k : ℕ}

/-- `Q_i = −X_i²`. -/
def frameQ (X : Fin k → Matrix (Fin n) (Fin n) ℝ) (i : Fin k) : Matrix (Fin n) (Fin n) ℝ :=
  -(X i * X i)

/-- `P = Σ_i Q_i`. -/
def frameP (X : Fin k → Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  ∑ i, frameQ X i

/-- The deficiency matrices: the symmetrised Gram block, centred on the diagonal. -/
noncomputable def frameM (X : Fin k → Matrix (Fin n) (Fin n) ℝ) (i j : Fin k) :
    Matrix (Fin n) (Fin n) ℝ :=
  if i = j then frameQ X i - (1 / (k : ℝ)) • frameP X
  else (-(1 / 2 : ℝ)) • (X i * X j + X j * X i)

/-- The ordered bracket total in trace form. -/
def frameT (X : Fin k → Matrix (Fin n) (Fin n) ℝ) : ℝ :=
  ∑ i, ∑ j, (trace (X i * X i * (X j * X j)) - trace (X i * X j * (X i * X j)))

lemma trace_cyc4 (A B C D : Matrix (Fin n) (Fin n) ℝ) :
    trace (A * B * (C * D)) = trace (B * C * (D * A)) := by
  rw [show A * B * (C * D) = A * (B * C * D) by simp [Matrix.mul_assoc], Matrix.trace_mul_comm]
  simp [Matrix.mul_assoc]

/-- The off-diagonal term. -/
lemma frame_offdiag (X : Fin k → Matrix (Fin n) (Fin n) ℝ) (i j : Fin k) :
    trace (X i * X i * (X j * X j)) - trace (X i * X j * (X i * X j)) =
      2 * trace (frameQ X i * frameQ X j) -
        2 * trace (((-(1 / 2 : ℝ)) • (X i * X j + X j * X i)) *
          ((-(1 / 2 : ℝ)) • (X i * X j + X j * X i))) := by
  have hq : frameQ X i * frameQ X j = X i * X i * (X j * X j) := by
    simp [frameQ]
  rw [hq, Matrix.smul_mul, Matrix.mul_smul, smul_smul, Matrix.trace_smul, smul_eq_mul]
  have h := bracket_quad (X i) (X j)
  linarith

/-- The diagonal terms sum to `Σ tr Q_i² − (1/k) tr P²`. -/
lemma frame_diag (X : Fin k → Matrix (Fin n) (Fin n) ℝ) (hk : 0 < k) :
    ∑ i, trace ((frameQ X i - (1 / (k : ℝ)) • frameP X) *
        (frameQ X i - (1 / (k : ℝ)) • frameP X)) =
      ∑ i, trace (frameQ X i * frameQ X i) - (1 / (k : ℝ)) * trace (frameP X * frameP X) := by
  have hkR : (k : ℝ) ≠ 0 := by exact_mod_cast hk.ne'
  simp only [Matrix.sub_mul, Matrix.mul_sub, Matrix.smul_mul, Matrix.mul_smul, Matrix.trace_sub,
    Matrix.trace_smul, smul_eq_mul, Finset.sum_sub_distrib]
  have h1 : ∑ i, trace (frameQ X i * frameP X) = trace (frameP X * frameP X) := by
    rw [← Matrix.trace_sum, ← Finset.sum_mul]; rfl
  have h2 : ∑ i, trace (frameP X * frameQ X i) = trace (frameP X * frameP X) := by
    rw [← Matrix.trace_sum, ← Finset.mul_sum]; rfl
  rw [← Finset.mul_sum, h2, ← Finset.mul_sum, Finset.sum_sub_distrib, h1]
  simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  field_simp
  ring

/-- **The frame identity.** -/
theorem frame_identity (X : Fin k → Matrix (Fin n) (Fin n) ℝ) (hk : 0 < k) :
    frameT X = 2 * (1 - 1 / (k : ℝ)) * trace (frameP X * frameP X) -
      2 * ∑ i, ∑ j, trace (frameM X i j * frameM X i j) := by
  have hdiag0 : ∀ i, trace (X i * X i * (X i * X i)) - trace (X i * X i * (X i * X i)) = 0 :=
    fun i => sub_self _
  -- split every double sum into its off-diagonal and diagonal parts
  have key : ∀ i j, trace (X i * X i * (X j * X j)) - trace (X i * X j * (X i * X j)) =
      2 * trace (frameQ X i * frameQ X j) - 2 * trace (frameM X i j * frameM X i j) +
        (if i = j then 2 * trace ((frameQ X i - (1 / (k : ℝ)) • frameP X) *
          (frameQ X i - (1 / (k : ℝ)) • frameP X)) - 2 * trace (frameQ X i * frameQ X i)
         else 0) := by
    intro i j
    by_cases hij : i = j
    · subst hij; simp only [frameM, if_true, hdiag0]; ring
    · simp only [frameM, if_neg hij, add_zero]; exact frame_offdiag X i j
  unfold frameT
  simp_rw [key, Finset.sum_add_distrib, Finset.sum_sub_distrib, Finset.sum_ite_eq,
    Finset.mem_univ, if_true]
  have hP : ∑ i, ∑ j, trace (frameQ X i * frameQ X j) = trace (frameP X * frameP X) := by
    simp only [frameP, Finset.sum_mul, Finset.mul_sum, Matrix.trace_sum]
    exact Finset.sum_comm
  simp only [← Finset.mul_sum, Finset.sum_sub_distrib]
  rw [hP, frame_diag X hk]
  ring

/-- For skew `X_i`, each deficiency matrix is symmetric, so `tr M² = Σ M_ab² ≥ 0`. -/
lemma trace_sq_nonneg_of_symm (M : Matrix (Fin n) (Fin n) ℝ) (hM : M.transpose = M) :
    0 ≤ trace (M * M) := by
  have : trace (M * M) = ∑ a, ∑ b, M a b ^ 2 := by
    simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply]
    rw [Finset.sum_congr rfl]; intro a _
    exact Finset.sum_congr rfl fun b _ => by
      have := congrFun (congrFun hM b) a; simp [Matrix.transpose_apply] at this; rw [this]; ring
  rw [this]; positivity

lemma frameM_symm (X : Fin k → Matrix (Fin n) (Fin n) ℝ) (hX : ∀ i, (X i).transpose = -X i)
    (i j : Fin k) : (frameM X i j).transpose = frameM X i j := by
  unfold frameM frameP frameQ
  split_ifs
  · simp [Matrix.transpose_smul, Matrix.transpose_neg, Matrix.transpose_mul,
      Matrix.transpose_sum, hX]
  · simp [Matrix.transpose_smul, Matrix.transpose_add, Matrix.transpose_mul, hX, add_comm]

/-- **(ii) at `r = 7`, typed whole**: for skew `X_i`, the ordered bracket total is at most
`2(1 − 1/k) tr P²`. At `k = 7` that is `(12/7) tr P²`, and an orthonormal frame isotropic on a
`d`-dimensional range has `tr P² = 196/d`, giving `T ≤ 336/d`, which is `42` at `d = 8`. -/
theorem frame_bound (X : Fin k → Matrix (Fin n) (Fin n) ℝ) (hk : 0 < k)
    (hX : ∀ i, (X i).transpose = -X i) :
    frameT X ≤ 2 * (1 - 1 / (k : ℝ)) * trace (frameP X * frameP X) := by
  rw [frame_identity X hk]
  have : 0 ≤ ∑ i, ∑ j, trace (frameM X i j * frameM X i j) :=
    Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ =>
      trace_sq_nonneg_of_symm _ (frameM_symm X hX i j)
  linarith

end FrameIdentity

end HamiltonsCubic.Results
