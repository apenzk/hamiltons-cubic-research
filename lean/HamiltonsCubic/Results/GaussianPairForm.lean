import HamiltonsCubic.Results.GaussianMoment
import HamiltonsCubic.Results.L243GaussianSubspaceCap

set_option linter.style.longLine false

/-!
# The Gaussian form of one pair's bracket, the per-pair half of L238 (i)

## The record's statement, quoted from [second-order.md](../../../findings/second-order.md), Lemma L238 (i)

> For each pair $i\neq j$, $\lVert[X_i,X_j]\rVert^2=2\operatorname{tr}(Q_iQ_j)-\tfrac12\lVert S_{ij}\rVert_F^2=
> \mathbb E\,\lvert X_iv\wedge X_jv\rvert^2-4$ … Isserlis' fourth moment
> $\mathbb E[(v^{\mathsf T}Av)(v^{\mathsf T}Bv)]=\operatorname{tr}A\operatorname{tr}B+2\operatorname{tr}AB$ for symmetric
> $A,B$ gives $\mathbb E[G_{ii}G_{jj}]=4+2\operatorname{tr}Q_iQ_j$ and … $\mathbb E G_{ij}^2=\tfrac12\lVert S_{ij}\rVert_F^2$.

## What is typed here

`gram_pair_expectation`: for any real `d × d` matrices `X, Y`, with `Q_X = XᵀX`, `Q_Y = YᵀY` and
`S = (XᵀY + YᵀX)/2`, the Gaussian expectation of `G_XX G_YY − G_XY²`, where `G_XY = ⟨Xv, Yv⟩`, is
`tr Q_X tr Q_Y + 2 tr(Q_X Q_Y) − (tr S)² − 2 tr(S²)`. This is the two Isserlis applications of L238's proof,
with nothing assumed about `X, Y`.

## What is NOT typed here

**Typed and proved here now as well**: `gaussian_pair_form`, the per-pair identity at orthonormal skew `X, Y`;
`frame_gaussian_form`, L238 (i) at every frame size, which is the `hT` of FrameGaussianBound.lean and
L243GaussianSubspaceCap.lean; and `frame_cap`, L243 with `hT` discharged. **Still a hypothesis**: the rank step
`E[(tr G)² − ‖G‖²_F] ≤ (1 − 1/r)(4k² + 2 tr P²)` (Cauchy–Schwarz on the Gram eigenvalues, `rank G ≤ min(k, n−1)`,
and Isserlis on `(v ⬝ᵥ P v)²`).
-/

namespace HamiltonsCubic.GaussianPairForm

open MeasureTheory ProbabilityTheory Matrix HamiltonsCubic.Results

variable {d : ℕ}

/-- `⟨Xv, Yv⟩ = v ⬝ᵥ (XᵀY) v`. -/
theorem inner_eq_quad (X Y : Matrix (Fin d) (Fin d) ℝ) (v : Fin d → ℝ) :
    (X.mulVec v) ⬝ᵥ (Y.mulVec v) = v ⬝ᵥ ((Xᵀ * Y).mulVec v) := by
  conv_rhs => rw [← Matrix.mulVec_mulVec, Matrix.dotProduct_mulVec, Matrix.vecMul_transpose]

/-- A quadratic form only sees the symmetric part: `v ⬝ᵥ M v = v ⬝ᵥ ((M + Mᵀ)/2) v`. -/
theorem quad_symm_part (M : Matrix (Fin d) (Fin d) ℝ) (v : Fin d → ℝ) :
    v ⬝ᵥ M.mulVec v = v ⬝ᵥ ((1/2 : ℝ) • (M + Mᵀ)).mulVec v := by
  have h : v ⬝ᵥ Mᵀ.mulVec v = v ⬝ᵥ M.mulVec v := by
    rw [Matrix.mulVec_transpose, dotProduct_comm, Matrix.dotProduct_mulVec]
  rw [Matrix.smul_mulVec, Matrix.add_mulVec, dotProduct_smul, dotProduct_add, h, smul_eq_mul]
  ring

theorem symm_part_isSymm (M : Matrix (Fin d) (Fin d) ℝ) : ((1/2 : ℝ) • (M + Mᵀ)).IsSymm := by
  unfold Matrix.IsSymm; rw [Matrix.transpose_smul, Matrix.transpose_add, Matrix.transpose_transpose, add_comm]

theorem gram_isSymm (X : Matrix (Fin d) (Fin d) ℝ) : (Xᵀ * X).IsSymm := by
  unfold Matrix.IsSymm; rw [Matrix.transpose_mul, Matrix.transpose_transpose]

/-- The Gaussian product measure on `ℝ^d`. -/
noncomputable abbrev μ (d : ℕ) := Measure.pi fun _ : Fin d => gaussianReal 0 1

/-- **A product of two quadratic forms is integrable** against the Gaussian, by the monomial expansion
the Isserlis proof uses. -/
theorem integrable_quad_mul (A B : Matrix (Fin d) (Fin d) ℝ) :
    Integrable (fun v : Fin d → ℝ => (v ⬝ᵥ A.mulVec v) * (v ⬝ᵥ B.mulVec v)) (μ d) := by
  have q : ∀ (C : Matrix (Fin d) (Fin d) ℝ) (v : Fin d → ℝ), v ⬝ᵥ C.mulVec v = ∑ i, ∑ j, C i j * (v i * v j) := by
    intro C v
    simp only [dotProduct, Matrix.mulVec, Finset.mul_sum]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring
  have hexp : (fun v : Fin d → ℝ => (v ⬝ᵥ A.mulVec v) * (v ⬝ᵥ B.mulVec v))
      = fun v => ∑ i, ∑ j, ∑ k, ∑ l, A i j * B k l * (v i * v j * v k * v l) := by
    funext v
    rw [q A, q B, Finset.sum_mul]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.sum_mul]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun l _ => by ring
  rw [hexp]
  exact integrable_finset_sum _ fun i _ => integrable_finset_sum _ fun j _ => integrable_finset_sum _
    fun k _ => integrable_finset_sum _ fun l _ =>
      (HamiltonsCubic.Results.Isserlis.integrable_mono i j k l).const_mul _

/-- **The per-pair Gaussian form.** With `G_XY = ⟨Xv, Yv⟩` and `S` the symmetric part of `XᵀY`,
`E[G_XX G_YY − G_XY²] = tr(XᵀX) tr(YᵀY) + 2 tr(XᵀX YᵀY) − (tr S)² − 2 tr(S²)`, for any real matrices. -/
theorem gram_pair_expectation (X Y : Matrix (Fin d) (Fin d) ℝ) :
    ∫ v, ((X.mulVec v ⬝ᵥ X.mulVec v) * (Y.mulVec v ⬝ᵥ Y.mulVec v) - (X.mulVec v ⬝ᵥ Y.mulVec v) ^ 2) ∂(μ d)
      = (Xᵀ * X).trace * (Yᵀ * Y).trace + 2 * (Xᵀ * X * (Yᵀ * Y)).trace
        - ((1/2 : ℝ) • (Xᵀ * Y + (Xᵀ * Y)ᵀ)).trace ^ 2
        - 2 * ((1/2 : ℝ) • (Xᵀ * Y + (Xᵀ * Y)ᵀ) * ((1/2 : ℝ) • (Xᵀ * Y + (Xᵀ * Y)ᵀ))).trace := by
  set S := (1/2 : ℝ) • (Xᵀ * Y + (Xᵀ * Y)ᵀ)
  have h : ∀ v : Fin d → ℝ, (X.mulVec v ⬝ᵥ X.mulVec v) * (Y.mulVec v ⬝ᵥ Y.mulVec v) - (X.mulVec v ⬝ᵥ Y.mulVec v) ^ 2
      = (v ⬝ᵥ (Xᵀ * X).mulVec v) * (v ⬝ᵥ (Yᵀ * Y).mulVec v) - (v ⬝ᵥ S.mulVec v) * (v ⬝ᵥ S.mulVec v) := by
    intro v
    rw [inner_eq_quad X X, inner_eq_quad Y Y, inner_eq_quad X Y, quad_symm_part (Xᵀ * Y), sq]
  simp_rw [h]
  rw [integral_sub (integrable_quad_mul _ _) (integrable_quad_mul _ _),
    integral_quadForm_mul_quadForm _ _ (gram_isSymm X) (gram_isSymm Y),
    integral_quadForm_mul_quadForm _ _ (symm_part_isSymm _) (symm_part_isSymm _)]
  ring

/-- **The per-pair identity, L238 (i).** For skew `X, Y` orthonormal in the record's norm
(`tr X² = tr Y² = −2`, `tr XY = 0`), `E[G_XX G_YY − G_XY²] = ‖[X,Y]‖² + 4`, the norm being
`‖C‖² = −½ tr C²`. So a `k`-frame's ordered bracket total is `E[(tr G)² − ‖G‖²_F] − 4k(k−1)`. -/
theorem gaussian_pair_form (X Y : Matrix (Fin d) (Fin d) ℝ) (hX : Xᵀ = -X) (hY : Yᵀ = -Y)
    (hXX : (X * X).trace = -2) (hYY : (Y * Y).trace = -2) (hXY : (X * Y).trace = 0) :
    ∫ v, ((X.mulVec v ⬝ᵥ X.mulVec v) * (Y.mulVec v ⬝ᵥ Y.mulVec v) - (X.mulVec v ⬝ᵥ Y.mulVec v) ^ 2) ∂(μ d)
      = -(1/2) * ((X * Y - Y * X) * (X * Y - Y * X)).trace + 4 := by
  rw [gram_pair_expectation, hX, hY]
  have c1 : (Y * X).trace = (X * Y).trace := Matrix.trace_mul_comm Y X
  have c2 : (Y * X * (Y * X)).trace = (X * Y * (X * Y)).trace := by
    have h := Matrix.trace_mul_comm Y (X * (Y * X))
    simp only [Matrix.mul_assoc] at h ⊢; exact h
  have c3 : (X * Y * (Y * X)).trace = (X * X * (Y * Y)).trace := by
    have h1 := Matrix.trace_mul_comm X (Y * (Y * X))
    have h2 := Matrix.trace_mul_comm (Y * Y) (X * X)
    simp only [Matrix.mul_assoc] at h1 h2 ⊢; rw [h1, h2]
  have c4 : (Y * X * (X * Y)).trace = (X * X * (Y * Y)).trace := by
    have h := Matrix.trace_mul_comm Y (X * (X * Y))
    simp only [Matrix.mul_assoc] at h ⊢; exact h
  have hT : (X * Y)ᵀ = Y * X := by
    rw [Matrix.transpose_mul, hY, hX]; simp
  simp only [Matrix.neg_mul, Matrix.mul_neg, neg_neg, Matrix.transpose_neg, hT, Matrix.trace_neg,
    Matrix.trace_smul, Matrix.smul_mul, Matrix.mul_smul, Matrix.trace_add, Matrix.add_mul, Matrix.mul_add,
    Matrix.trace_sub, Matrix.sub_mul, Matrix.mul_sub, smul_eq_mul, hXX, hYY, hXY, c1, c2, c3, c4]
  ring

/-- The pair integrand is integrable. -/
theorem integrable_pair (X Y : Matrix (Fin d) (Fin d) ℝ) :
    Integrable (fun v : Fin d → ℝ => (X.mulVec v ⬝ᵥ X.mulVec v) * (Y.mulVec v ⬝ᵥ Y.mulVec v)
      - (X.mulVec v ⬝ᵥ Y.mulVec v) ^ 2) (μ d) := by
  have h : (fun v : Fin d → ℝ => (X.mulVec v ⬝ᵥ X.mulVec v) * (Y.mulVec v ⬝ᵥ Y.mulVec v)
      - (X.mulVec v ⬝ᵥ Y.mulVec v) ^ 2) = fun v => (v ⬝ᵥ (Xᵀ * X).mulVec v) * (v ⬝ᵥ (Yᵀ * Y).mulVec v)
        - (v ⬝ᵥ (Xᵀ * Y).mulVec v) * (v ⬝ᵥ (Xᵀ * Y).mulVec v) := by
    funext v; rw [inner_eq_quad X X, inner_eq_quad Y Y, inner_eq_quad X Y, sq]
  rw [h]; exact (integrable_quad_mul _ _).sub (integrable_quad_mul _ _)

/-- **L238 (i) at every frame size.** For `k` skew matrices orthonormal in the record's norm, the ordered
bracket total `∑_{i≠j} ‖[X_i, X_j]‖²` equals `E[∑_{i≠j}(G_ii G_jj − G_ij²)] − 4k(k−1)`, with
`G_ij = ⟨X_i v, X_j v⟩` and `v` standard Gaussian. This is the hypothesis `hT` that
[FrameGaussianBound.lean](FrameGaussianBound.lean) and [L243GaussianSubspaceCap.lean](L243GaussianSubspaceCap.lean)
take, now proved. -/
theorem frame_gaussian_form {k : ℕ} (X : Fin k → Matrix (Fin d) (Fin d) ℝ)
    (hskew : ∀ i, (X i)ᵀ = -X i) (hnorm : ∀ i, (X i * X i).trace = -2)
    (horth : ∀ i j, i ≠ j → (X i * X j).trace = 0) :
    ∑ i, ∑ j, (if i = j then (0 : ℝ) else -(1/2) * ((X i * X j - X j * X i) * (X i * X j - X j * X i)).trace)
      = ∫ v, ∑ i, ∑ j, (if i = j then (0 : ℝ) else
          ((X i).mulVec v ⬝ᵥ (X i).mulVec v) * ((X j).mulVec v ⬝ᵥ (X j).mulVec v)
            - ((X i).mulVec v ⬝ᵥ (X j).mulVec v) ^ 2) ∂(μ d)
        - 4 * k * (k - 1) := by
  have hI : ∀ i j, Integrable (fun v : Fin d → ℝ => if i = j then (0 : ℝ) else
      ((X i).mulVec v ⬝ᵥ (X i).mulVec v) * ((X j).mulVec v ⬝ᵥ (X j).mulVec v)
        - ((X i).mulVec v ⬝ᵥ (X j).mulVec v) ^ 2) (μ d) := by
    intro i j; by_cases h : i = j
    · simp [h]
    · simp only [h, if_false]; exact integrable_pair _ _
  rw [integral_finset_sum _ fun i _ => integrable_finset_sum _ fun j _ => hI i j]
  rw [Finset.sum_congr rfl fun i _ => integral_finset_sum _ fun j _ => hI i j]
  have hpair : ∀ i j, ∫ v, (if i = j then (0 : ℝ) else
      ((X i).mulVec v ⬝ᵥ (X i).mulVec v) * ((X j).mulVec v ⬝ᵥ (X j).mulVec v)
        - ((X i).mulVec v ⬝ᵥ (X j).mulVec v) ^ 2) ∂(μ d)
      = (if i = j then (0 : ℝ) else -(1/2) * ((X i * X j - X j * X i) * (X i * X j - X j * X i)).trace + 4) := by
    intro i j; by_cases h : i = j
    · simp [h]
    · simp only [h, if_false]
      exact gaussian_pair_form _ _ (hskew i) (hskew j) (hnorm i) (hnorm j) (horth i j h)
  simp_rw [hpair]
  have hcount : ∑ i : Fin k, ∑ j : Fin k, (if i = j then (0 : ℝ) else 4) = 4 * k * (k - 1) := by
    have : ∀ i : Fin k, ∑ j : Fin k, (if i = j then (0 : ℝ) else 4) = 4 * (k - 1) := by
      intro i
      have hc : (Finset.univ.filter fun x : Fin k => ¬ i = x).card = k - 1 := by
        rw [Finset.filter_not, Finset.card_sdiff]
        simp [Finset.filter_eq]
      have hk : 1 ≤ k := Nat.one_le_iff_ne_zero.mpr (fun h => by subst h; exact i.elim0)
      rw [Finset.sum_ite, Finset.sum_const_zero, zero_add, Finset.sum_const, nsmul_eq_mul, hc]
      push_cast [Nat.cast_sub hk]; ring
    simp_rw [this]; rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]; ring
  have split : ∀ i j : Fin k, (if i = j then (0 : ℝ) else -(1/2) * ((X i * X j - X j * X i) * (X i * X j - X j * X i)).trace + 4)
      = (if i = j then (0 : ℝ) else -(1/2) * ((X i * X j - X j * X i) * (X i * X j - X j * X i)).trace)
        + (if i = j then (0 : ℝ) else 4) := by
    intro i j; split_ifs <;> ring
  simp_rw [split, Finset.sum_add_distrib, hcount]
  ring

/-- **L243 with its Gaussian-form hypothesis discharged.** For a `k`-frame of orthonormal skew matrices,
the ordered bracket total is at most `(1 − 1/r)(4k² + 2 tr P²) − 4k(k−1)` as soon as the Gaussian mean
of `(tr G)² − ‖G‖²_F` is at most `(1 − 1/r)(4k² + 2 tr P²)`, which is the rank step, still a hypothesis. -/
theorem frame_cap {k : ℕ} (X : Fin k → Matrix (Fin d) (Fin d) ℝ)
    (hskew : ∀ i, (X i)ᵀ = -X i) (hnorm : ∀ i, (X i * X i).trace = -2)
    (horth : ∀ i j, i ≠ j → (X i * X j).trace = 0) (r trP2 : ℝ)
    (hE : ∫ v, ∑ i, ∑ j, (if i = j then (0 : ℝ) else
          ((X i).mulVec v ⬝ᵥ (X i).mulVec v) * ((X j).mulVec v ⬝ᵥ (X j).mulVec v)
            - ((X i).mulVec v ⬝ᵥ (X j).mulVec v) ^ 2) ∂(μ d)
        ≤ (1 - 1 / r) * (4 * (k : ℝ) ^ 2 + 2 * trP2)) :
    ∑ i, ∑ j, (if i = j then (0 : ℝ) else -(1/2) * ((X i * X j - X j * X i) * (X i * X j - X j * X i)).trace)
      ≤ (1 - 1 / r) * (4 * (k : ℝ) ^ 2 + 2 * trP2) - 4 * k * (k - 1) :=
  HamiltonsCubic.L243GaussianSubspaceCap.gaussian_cap _ _ _ _ _ (frame_gaussian_form X hskew hnorm horth) hE

end HamiltonsCubic.GaussianPairForm
