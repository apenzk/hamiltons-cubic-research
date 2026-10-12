import HamiltonsCubic.Results.L186Proof
import HamiltonsCubic.Results.L185Proof

set_option linter.style.longLine false

/-!
# L186's rank count, unconditional

[diagonal-half.md](../../../findings/diagonal-half.md), Lemma L186: *"If `ω₁, ω₂` are both non-decomposable with
`λ₁, λ₂` of one sign, `∑ λ_i = 0` puts `ω₃` alone on the other side and Ricci-flatness reads
`|λ₁|ω₁ω₁ᵀ + |λ₂|ω₂ω₂ᵀ = |λ₃|Π₃`, rank at least four against rank two."* [L186Statement.lean](L186Statement.lean)
types the count with the ranks as hypotheses. This file proves the ranks.

- **`det_skew4`**: a `4 × 4` skew matrix has `det = Pf²`;
- **`rank_ge_four`**: a non-decomposable skew form has rank at least four, its nonzero `ω ∧ ω` entry being a principal
  Pfaffian of nonzero square;
- `rank_le_two`: a decomposable form has rank at most two, through a `n × 2` factorisation;
- `gram_quad`, `gram_quad_nonneg`, **`rank_le_of_pos`**: a positive combination of Gram matrices `ω ωᵀ` has rank at
  least each summand's, since its kernel lies in each summand's;
- **`same_sign_rank_impossible`**: `∑ λ_i ω_i ω_iᵀ = 0` with `ω₁` non-decomposable, `ω₃` decomposable and `λ₁, λ₂` of
  one sign is impossible. Only `ω₁` needs to be non-decomposable, and no orthonormality or Bianchi is used.
-/

namespace HamiltonsCubic.L186Proof

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.SelfDualLayer

variable {n : ℕ}

/-- The determinant of a `4 × 4` skew matrix is the square of its Pfaffian. -/
theorem det_skew4 (M : Matrix (Fin 4) (Fin 4) ℝ) (hM : Mᵀ = -M) :
    M.det = (M 0 1 * M 2 3 - M 0 2 * M 1 3 + M 0 3 * M 1 2) ^ 2 := by
  have hs : ∀ a b, M b a = -M a b := fun a b => by
    have := congrFun (congrFun hM a) b; simpa [Matrix.transpose_apply] using this
  have hd : ∀ a, M a a = 0 := fun a => by have := hs a a; linarith
  simp [Matrix.det_succ_row_zero, Fin.sum_univ_succ, Fin.succAbove]
  simp only [hd, hs 1 0, hs 2 0, hs 3 0, hs 2 1, hs 3 1, hs 3 2]
  ring

/-- **A non-decomposable skew form has rank at least four**: a nonzero `ω ∧ ω` entry is a `4 × 4` principal
Pfaffian, whose square is a nonzero principal minor. -/
theorem rank_ge_four {w : Matrix (Fin n) (Fin n) ℝ} (hskew : wᵀ = -w) (hnd : ¬ IsDecomp w) : 4 ≤ w.rank := by
  rw [isDecomp_iff] at hnd
  push Not at hnd
  obtain ⟨a, b, c, d, h⟩ := hnd
  have hw : wedgeSelf w a b c d = 2 * (w a b * w c d - w a c * w b d + w a d * w b c) := by
    simp only [wedgeSelf, wedge2, halfw, Pi.add_apply]; ring
  rw [hw] at h
  let e : Fin 4 → Fin n := ![a, b, c, d]
  let M := w.submatrix e e
  have hM : Mᵀ = -M := by
    ext i j; simp only [M, Matrix.transpose_apply, Matrix.submatrix_apply, Matrix.neg_apply]
    have := congrFun (congrFun hskew (e i)) (e j); simpa [Matrix.transpose_apply] using this
  have key : M 0 1 * M 2 3 - M 0 2 * M 1 3 + M 0 3 * M 1 2 = w a b * w c d - w a c * w b d + w a d * w b c := by
    simp [M, e]
  have hdet : M.det ≠ 0 := by
    rw [det_skew4 M hM, key]
    exact pow_ne_zero 2 (fun h0 => h (by rw [h0, mul_zero]))
  have hrank : M.rank = 4 := by
    rw [Matrix.rank_of_isUnit M ((Matrix.isUnit_iff_isUnit_det M).mpr (isUnit_iff_ne_zero.mpr hdet)), Fintype.card_fin]
  rw [← hrank]
  exact Matrix.rank_submatrix_le w e e

/-- **A decomposable form has rank at most two.** -/
theorem rank_le_two {w : Matrix (Fin n) (Fin n) ℝ} (h : IsDecomp w) : w.rank ≤ 2 := by
  obtain ⟨u, v, rfl⟩ := h
  let U : Matrix (Fin n) (Fin 2) ℝ := Matrix.of fun i k => ![u i, v i] k
  let K : Matrix (Fin 2) (Fin n) ℝ := Matrix.of fun k j => ![v j, -u j] k
  have e : vecMulVec u v - vecMulVec v u = U * K := by
    ext i j; simp [U, K, Matrix.mul_apply, Fin.sum_univ_two, vecMulVec_apply]; ring
  rw [e]
  exact (Matrix.rank_mul_le_left U K).trans (by simpa using Matrix.rank_le_card_width U)

theorem gram_quad (w : Matrix (Fin n) (Fin n) ℝ) (x : Fin n → ℝ) :
    x ⬝ᵥ ((w * wᵀ) *ᵥ x) = (wᵀ *ᵥ x) ⬝ᵥ (wᵀ *ᵥ x) := by
  rw [← Matrix.mulVec_mulVec, Matrix.dotProduct_mulVec, ← Matrix.mulVec_transpose]

theorem gram_quad_nonneg (w : Matrix (Fin n) (Fin n) ℝ) (x : Fin n → ℝ) : 0 ≤ x ⬝ᵥ ((w * wᵀ) *ᵥ x) := by
  rw [gram_quad]; exact Finset.sum_nonneg fun i _ => mul_self_nonneg _

/-- **A positive combination of Gram matrices has rank at least each summand's.** -/
theorem rank_le_of_pos {w₁ w₂ : Matrix (Fin n) (Fin n) ℝ} {l₁ l₂ : ℝ} (h₁ : 0 < l₁) (h₂ : 0 < l₂) :
    w₁.rank ≤ (l₁ • (w₁ * w₁ᵀ) + l₂ • (w₂ * w₂ᵀ)).rank := by
  rw [← Matrix.rank_self_mul_transpose w₁]
  set S := l₁ • (w₁ * w₁ᵀ) + l₂ • (w₂ * w₂ᵀ)
  have hker : LinearMap.ker S.mulVecLin ≤ LinearMap.ker (w₁ * w₁ᵀ).mulVecLin := by
    intro x hx
    simp only [LinearMap.mem_ker, Matrix.mulVecLin_apply] at hx ⊢
    have hq : l₁ * (x ⬝ᵥ ((w₁ * w₁ᵀ) *ᵥ x)) + l₂ * (x ⬝ᵥ ((w₂ * w₂ᵀ) *ᵥ x)) = 0 := by
      have := congrArg (fun y => x ⬝ᵥ y) hx
      simpa [S, Matrix.add_mulVec, Matrix.smul_mulVec, dotProduct_add, dotProduct_smul] using this
    have n₁ := gram_quad_nonneg w₁ x
    have n₂ := gram_quad_nonneg w₂ x
    have z₁ : x ⬝ᵥ ((w₁ * w₁ᵀ) *ᵥ x) = 0 := by nlinarith
    rw [gram_quad] at z₁
    have hy : w₁ᵀ *ᵥ x = 0 := dotProduct_self_eq_zero.mp z₁
    rw [← Matrix.mulVec_mulVec, hy, Matrix.mulVec_zero]
  have r1 := LinearMap.finrank_range_add_finrank_ker S.mulVecLin
  have r2 := LinearMap.finrank_range_add_finrank_ker (w₁ * w₁ᵀ).mulVecLin
  have hk := Submodule.finrank_mono hker
  unfold Matrix.rank
  omega

/-- **L186's rank count, unconditional**: if `∑ λ_i ω_i ω_iᵀ = 0` (Ricci-flatness for `W = ∑ λ_i ω_i ⊗ ω_i`) with
`ω₁` non-decomposable, `ω₃` decomposable, and `λ₁, λ₂` of one sign, there is no such configuration: rank at least four
on one side, at most two on the other. -/
theorem same_sign_rank_impossible {w₁ w₂ w₃ : Matrix (Fin n) (Fin n) ℝ} (hskew : w₁ᵀ = -w₁) (hnd : ¬ IsDecomp w₁)
    (h₃ : IsDecomp w₃) {l₁ l₂ l₃ : ℝ} (hsign : (0 < l₁ ∧ 0 < l₂) ∨ (l₁ < 0 ∧ l₂ < 0))
    (hsum : l₁ • (w₁ * w₁ᵀ) + l₂ • (w₂ * w₂ᵀ) + l₃ • (w₃ * w₃ᵀ) = 0) : False := by
  have h4 := rank_ge_four hskew hnd
  have h2 : (w₃ * w₃ᵀ).rank ≤ 2 := by rw [Matrix.rank_self_mul_transpose]; exact rank_le_two h₃
  have hr3 : ∀ c : ℝ, (c • (w₃ * w₃ᵀ)).rank ≤ 2 := fun c => by
    have e : c • (w₃ * w₃ᵀ) = (w₃ * w₃ᵀ) * (c • (1 : Matrix (Fin n) (Fin n) ℝ)) := by
      rw [Matrix.mul_smul, Matrix.mul_one]
    rw [e]; exact (Matrix.rank_mul_le_left _ _).trans h2
  rcases hsign with ⟨p₁, p₂⟩ | ⟨p₁, p₂⟩
  · have hS : l₁ • (w₁ * w₁ᵀ) + l₂ • (w₂ * w₂ᵀ) = (-l₃) • (w₃ * w₃ᵀ) := by
      rw [neg_smul, eq_neg_iff_add_eq_zero]; exact hsum
    have := rank_le_of_pos (w₁ := w₁) (w₂ := w₂) p₁ p₂
    rw [hS] at this
    have := hr3 (-l₃)
    omega
  · have hS : (-l₁) • (w₁ * w₁ᵀ) + (-l₂) • (w₂ * w₂ᵀ) = l₃ • (w₃ * w₃ᵀ) := by
      rw [neg_smul, neg_smul, ← neg_add, neg_eq_iff_eq_neg]
      exact eq_neg_of_add_eq_zero_left hsum
    have := rank_le_of_pos (w₁ := w₁) (w₂ := w₂) (neg_pos.mpr p₁) (neg_pos.mpr p₂)
    rw [hS] at this
    have := hr3 l₃
    omega

end HamiltonsCubic.L186Proof
