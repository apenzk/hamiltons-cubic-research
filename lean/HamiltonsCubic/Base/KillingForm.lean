import HamiltonsCubic.Base.PhiPairing

/-!
# The Killing contraction at ℚ

`∑_{i,j} ⟨ad_X ad_Y φ_ij, φ_ij⟩ = 2(n-2) tr(XY)`, which is `𝔰𝔬(n)`'s Killing form
carrying the ordered-pair doubling.

**This is the rational twin of the chain in [StructureConstants.lean](StructureConstants.lean)**,
which states the same five steps over `ℝ`. *Every proof there is `ring`, `simp`, `noncomm_ring` or
`linarith`, none of which uses an order or a completeness*, so the port changes the field and
nothing else. What it buys is the anchor `⟨Id# φ, φ⟩ = n-2` at every `n` in the rational layer,
where [Curvature.lean](Curvature.lean) had it at three dimensions by `native_decide`.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

omit [DecidableEq ι] in
/-- `inner2` is additive on the left, the companion of `inner2_sub_left`. -/
theorem inner2_add_left (X Y Z : Matrix ι ι ℚ) :
    inner2 (X + Y) Z = inner2 X Z + inner2 Y Z := by
  simp [inner2, Matrix.transpose_add, Matrix.add_mul, Matrix.trace_add]; ring

/-- Contracting any `f` against `φ_ij` reads off two entries.

**THE COLUMN INDEX IS THE OUTER SUM**, which is the one place the rational layer differs from the
real one: `inner2_eq_sum` at `ℚ` reads `∑ a, ∑ b, X b a * Y b a` where its real twin reads
`X a b * Y a b`. *A port that keeps the real order type-checks everywhere except here, and fails
with `rewrite` unable to find a pattern that is present under a different binder order.* -/
theorem sum_mul_phi (f : ι → ι → ℚ) (i j : ι) :
    ∑ b : ι, ∑ a : ι, f a b * (phi i j a b) = f j i - f i j := by
  simp [phi, Matrix.single_apply, ite_and, mul_sub, Finset.sum_sub_distrib,
    Finset.sum_ite_eq, Finset.sum_ite_eq']

/-- **`A φᵢⱼ B` entrywise**: the conjugation moves one index of `A` and one of `B`. -/
theorem conj_apply (A B : Matrix ι ι ℚ) (i j a b : ι) :
    (A * phi i j * B) a b = A a j * B i b - A a i * B j b := by
  simp [Matrix.mul_apply, phi, Matrix.single_apply, ite_and, Finset.sum_ite_eq,
    Finset.sum_ite_eq', Finset.sum_sub_distrib, sub_mul, mul_sub]

/-- **The conjugation sum over the whole `φ` family.** -/
theorem sum_inner2_conj (A B : Matrix ι ι ℚ) :
    ∑ i : ι, ∑ j : ι, inner2 (A * phi i j * B) (phi i j)
      = A.trace * B.trace - (A * Matrix.transpose B).trace := by
  have key : ∀ i j : ι, inner2 (A * phi i j * B) (phi i j)
      = (1/2) * (A j j * B i i + A i i * B j j - A i j * B i j - A j i * B j i) := by
    intro i j
    rw [inner2_eq_sum]
    simp only [conj_apply]
    rw [sum_mul_phi (fun a b => A a j * B i b - A a i * B j b) i j]
    ring
  have hA : A.trace = ∑ a : ι, A a a := by simp [Matrix.trace, Matrix.diag]
  have hB : B.trace = ∑ a : ι, B a a := by simp [Matrix.trace, Matrix.diag]
  have htr : (A * Matrix.transpose B).trace = ∑ a : ι, ∑ b : ι, A a b * B a b := by
    simp [Matrix.trace, Matrix.diag, Matrix.mul_apply]
  have s1 : ∑ i : ι, ∑ j : ι, (1/2:ℚ) * (A j j * B i i)
      = ∑ i : ι, ∑ j : ι, (1/2:ℚ) * (A i i * B j j) := Finset.sum_comm
  have s2 : ∑ i : ι, ∑ j : ι, (1/2:ℚ) * (A j i * B j i)
      = ∑ i : ι, ∑ j : ι, (1/2:ℚ) * (A i j * B i j) := Finset.sum_comm
  have s3 : ∑ i : ι, ∑ j : ι, (1/2:ℚ) * (A i i * B j j)
      = (1/2:ℚ) * ((∑ a : ι, A a a) * (∑ a : ι, B a a)) := by
    rw [Finset.sum_mul_sum, Finset.mul_sum]
    exact Finset.sum_congr rfl fun i _ => by rw [Finset.mul_sum]
  have s4 : ∑ i : ι, ∑ j : ι, (1/2:ℚ) * (A i j * B i j)
      = (1/2:ℚ) * (∑ a : ι, ∑ b : ι, A a b * B a b) := by
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun i _ => by rw [Finset.mul_sum]
  simp only [key, mul_add, mul_sub, Finset.sum_add_distrib, Finset.sum_sub_distrib]
  rw [s1, s2, s3, s4, hA, hB, htr]
  ring

/-- **`ad_X ad_Y` written as four conjugations**, which is the form `sum_inner2_conj` reads. -/
theorem br_br_eq (X Y Z : Matrix ι ι ℚ) :
    br X (br Y Z) = (X * Y) * Z * 1 - X * Z * Y - Y * Z * X + 1 * Z * (Y * X) := by
  simp only [br]; noncomm_ring

/-- **The Killing contraction on the `φ` family**: `∑ ⟨ad_X ad_Y φ, φ⟩ = 2(n-2) tr(XY)`. -/
theorem sum_inner2_ad2 (X Y : Matrix ι ι ℚ) (hX : IsSkew X) (hY : IsSkew Y) :
    ∑ i : ι, ∑ j : ι, inner2 (br X (br Y (phi i j))) (phi i j)
      = 2 * ((Fintype.card ι : ℚ) - 2) * (X * Y).trace := by
  have hXt : Matrix.transpose X = -X := hX
  have hYt : Matrix.transpose Y = -Y := hY
  have htrX : X.trace = 0 := by
    have := congrArg Matrix.trace hXt
    simp [Matrix.trace_transpose, Matrix.trace_neg] at this
    linarith
  have htrY : Y.trace = 0 := by
    have := congrArg Matrix.trace hYt
    simp [Matrix.trace_transpose, Matrix.trace_neg] at this
    linarith
  have hsum : ∀ i j : ι, inner2 (br X (br Y (phi i j))) (phi i j)
      = inner2 ((X * Y) * phi i j * 1) (phi i j) - inner2 (X * phi i j * Y) (phi i j)
        - inner2 (Y * phi i j * X) (phi i j) + inner2 (1 * phi i j * (Y * X)) (phi i j) := by
    intro i j
    rw [br_br_eq, inner2_add_left, inner2_sub_left, inner2_sub_left]
  simp only [hsum, Finset.sum_add_distrib, Finset.sum_sub_distrib,
    sum_inner2_conj]
  simp only [Matrix.transpose_one, Matrix.mul_one, Matrix.one_mul, Matrix.trace_one,
    hXt, hYt, Matrix.transpose_mul, Matrix.mul_neg, Matrix.neg_mul, Matrix.trace_neg,
    htrX, htrY]
  rw [Matrix.trace_mul_comm Y X]
  ring

end HamiltonsCubic.Base
