import HamiltonsCubic.Results.L178Sharp

set_option linter.style.longLine false
-- The symbolic expansions below unfold six-by-six products through `Fin.sum_univ_six`, as in Sharp.lean.
set_option maxRecDepth 100000

/-!
# L178, steps 4 and 5: `θ ≤ √(3/2)` on `Λ^±` at `n = 4`

[diagonal-half.md](../../../findings/diagonal-half.md), Lemma L178: *"`θ = tr(W³) + ⟨W, W^#⟩ = 3e₃ + 6e₃ = 9e₃`"* and
*"the bound is the reality of the roots"*, `|e₃| ≤ 1/(3√6)`. Computed with the layer's own `P` and `#`
([Sharp.lean](../Base/Sharp.lean)'s `Pcubic`, `sharpMat`), on an operator supported on one of `Λ^±` with block `B`, as
in [L178Sharp.lean](L178Sharp.lean).

- `tr3`, `det3`, `cofB`: `tr B³`, `det B` and the cofactor matrix of `B = [[a,b,c],[b,d,e],[c,e,f]]`;
- **`sharpMat_Rp`**, `sharpMat_Rm`: `R# = W cof(B) Wᵀ` in `basis4` coordinates, the polarisation of `sharp_sd`;
- **`Pcubic_Rp`**, `Pcubic_Rm`, `normSq_Rp`, `normSq_Rm`: `P(R) = tr B³ + 6 det B` and `‖R‖² = tr B²`;
- `Bm`, **`disc_nonneg`**: `54 (det B)² ≤ (tr B²)³` for symmetric trace-free `B`, as the Gram determinant of `I, B, B²`
  under the Frobenius pairing (Mathlib's `posSemidef_gram`), which equals `((tr B²)³ − 54 (det B)²)/2`;
- **`L178_theta_sd`**, **`L178_theta_asd`**: for trace-free `B`, `P(R) = 9 det B` and `P(R)² ≤ (3/2) ‖R‖⁶`, so
  `θ ≤ √(3/2)` at unit norm.
-/

namespace HamiltonsCubic.Base

open Matrix

/-- `tr B³` for `B = [[a,b,c],[b,d,e],[c,e,f]]`. -/
def tr3 (a b c d e f : ℚ) : ℚ :=
  a ^ 3 + d ^ 3 + f ^ 3 + 3 * b ^ 2 * (a + d) + 3 * c ^ 2 * (a + f) + 3 * e ^ 2 * (d + f) + 6 * b * c * e

/-- `det B`. -/
def det3 (a b c d e f : ℚ) : ℚ := a * d * f + 2 * b * c * e - a * e ^ 2 - d * c ^ 2 - f * b ^ 2

/-- The cofactor matrix of `B`, as a function. -/
def cofB (a b c d e f : ℚ) : Fin 3 → Fin 3 → ℚ
  | 0, 0 => d * f - e ^ 2 | 1, 1 => a * f - c ^ 2 | 2, 2 => a * d - b ^ 2
  | 0, 1 => c * e - b * f | 1, 0 => c * e - b * f
  | 0, 2 => b * e - c * d | 2, 0 => b * e - c * d
  | 1, 2 => b * c - a * e | 2, 1 => b * c - a * e
  | _, _ => 0

set_option maxHeartbeats 16000000 in
-- Thirty-six entries, each a polarised cofactor form in six symbolic block entries.
/-- **`R# = W cof(B) Wᵀ`** in `basis4` coordinates, `W` the matrix of `ω⁺`. -/
theorem sharpMat_Rp (a b c d e f : ℚ) :
    sharpMat (Rp a b c d e f) = Matrix.of fun p q => ∑ i : Fin 3, ∑ j : Fin 3, cofB a b c d e f i j * wp i p * wp j q := by
  ext p q
  simp only [sharpMat, Matrix.of_apply, sharp_sd]
  fin_cases p <;> fin_cases q <;>
    simp only [Fin.sum_univ_three, Pi.single_apply, Pi.add_apply, cofB, wp, cofQF, Fin.isValue, Fin.zero_eta,
      Fin.mk_one, Fin.reduceFinMk] <;> norm_num [Fin.ext_iff] <;> ring

set_option maxHeartbeats 16000000 in
-- A trace over `6 × 6` products of symbolic matrices.
/-- **Step 4 on the layer's objects**: `P(R) = tr B³ + 6 det B` for `R` supported on `Λ⁺` with block `B`. -/
theorem Pcubic_Rp (a b c d e f : ℚ) : Pcubic (Rp a b c d e f) = tr3 a b c d e f + 6 * det3 a b c d e f := by
  rw [Pcubic, Qop, sharpMat_Rp]
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply, Matrix.add_apply, Matrix.of_apply,
    Fin.sum_univ_six, Fin.sum_univ_three, Rp, wp, cofB, tr3, det3, Fin.isValue]
  norm_num
  ring

set_option maxHeartbeats 4000000 in
-- A trace over `6 × 6` products of symbolic matrices.
/-- The square norm of `R` is `tr B²`. -/
theorem normSq_Rp (a b c d e f : ℚ) :
    ((Rp a b c d e f)ᵀ * Rp a b c d e f).trace = a ^ 2 + d ^ 2 + f ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2) := by
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply, Matrix.of_apply,
    Fin.sum_univ_six, Rp, wp, Fin.isValue]
  norm_num
  ring

set_option maxHeartbeats 16000000 in
-- Thirty-six entries, each a polarised cofactor form in six symbolic block entries.
/-- **`R# = W cof(B) Wᵀ`** in `basis4` coordinates, `W` the matrix of `ω⁻`. -/
theorem sharpMat_Rm (a b c d e f : ℚ) :
    sharpMat (Rm a b c d e f) = Matrix.of fun p q => ∑ i : Fin 3, ∑ j : Fin 3, cofB a b c d e f i j * wm i p * wm j q := by
  ext p q
  simp only [sharpMat, Matrix.of_apply, sharp_asd]
  fin_cases p <;> fin_cases q <;>
    simp only [Fin.sum_univ_three, Pi.single_apply, Pi.add_apply, cofB, wm, cofQF, Fin.isValue, Fin.zero_eta,
      Fin.mk_one, Fin.reduceFinMk] <;> norm_num [Fin.ext_iff] <;> ring

set_option maxHeartbeats 16000000 in
-- A trace over `6 × 6` products of symbolic matrices.
/-- **Step 4 on the layer's objects**: `P(R) = tr B³ + 6 det B` for `R` supported on `Λ⁻` with block `B`. -/
theorem Pcubic_Rm (a b c d e f : ℚ) : Pcubic (Rm a b c d e f) = tr3 a b c d e f + 6 * det3 a b c d e f := by
  rw [Pcubic, Qop, sharpMat_Rm]
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply, Matrix.add_apply, Matrix.of_apply,
    Fin.sum_univ_six, Fin.sum_univ_three, Rm, wm, cofB, tr3, det3, Fin.isValue]
  norm_num
  ring

set_option maxHeartbeats 4000000 in
-- A trace over `6 × 6` products of symbolic matrices.
/-- The square norm of `R` is `tr B²`. -/
theorem normSq_Rm (a b c d e f : ℚ) :
    ((Rm a b c d e f)ᵀ * Rm a b c d e f).trace = a ^ 2 + d ^ 2 + f ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2) := by
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply, Matrix.of_apply,
    Fin.sum_univ_six, Rm, wm, Fin.isValue]
  norm_num
  ring


/-- The symmetric trace-free array `[[a,b,c],[b,d,e],[c,e,−a−d]]`. -/
def Bm (a b c d e : ℝ) : Fin 3 → Fin 3 → ℝ
  | 0, 0 => a | 0, 1 => b | 0, 2 => c | 1, 0 => b | 1, 1 => d | 1, 2 => e
  | 2, 0 => c | 2, 1 => e | 2, 2 => -a - d

set_option maxHeartbeats 4000000 in
-- The Gram determinant of `I, B, B²` over nine Frobenius coordinates is a large symbolic expansion.
/-- **The discriminant of a symmetric trace-free `3 × 3` array is nonnegative**: `54 (det B)² ≤ (tr B²)³`, as the
Gram determinant of `I, B, B²` under the Frobenius pairing, which Mathlib's `posSemidef_gram` makes nonnegative. -/
theorem disc_nonneg (a b c d e : ℝ) :
    54 * (a * d * (-a - d) + 2 * b * c * e - a * e ^ 2 - d * c ^ 2 - (-a - d) * b ^ 2) ^ 2 ≤
      (a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2)) ^ 3 := by
  let v : Fin 3 → EuclideanSpace ℝ (Fin 3 × Fin 3) := fun r => WithLp.toLp 2 (fun p =>
    match r with
    | 0 => if p.1 = p.2 then 1 else 0
    | 1 => Bm a b c d e p.1 p.2
    | 2 => ∑ k, Bm a b c d e p.1 k * Bm a b c d e k p.2)
  have h := (Matrix.posSemidef_gram ℝ v).det_nonneg
  rw [Matrix.det_fin_three] at h
  simp only [Matrix.gram_apply, v, PiLp.inner_apply, RCLike.inner_apply, conj_trivial, Fintype.sum_prod_type,
    Fin.sum_univ_three, Fin.isValue, Bm] at h
  norm_num [Fin.ext_iff] at h
  linarith [h]

/-- **L178, steps 4 and 5 on `Λ⁺`**: for `R` supported on `Λ⁺` with trace-free block `B`, `P(R) = 9 det B` and
`P(R)² ≤ (3/2) ‖R‖⁶`, that is `θ(R) ≤ √(3/2)` at unit norm. -/
theorem L178_theta_sd (a b c d e : ℚ) :
    Pcubic (Rp a b c d e (-a - d)) = 9 * det3 a b c d e (-a - d) ∧
      Pcubic (Rp a b c d e (-a - d)) ^ 2 ≤ (3 / 2) * (((Rp a b c d e (-a - d))ᵀ * Rp a b c d e (-a - d)).trace) ^ 3 := by
  have hP : Pcubic (Rp a b c d e (-a - d)) = 9 * det3 a b c d e (-a - d) := by
    rw [Pcubic_Rp]; simp only [tr3, det3]; ring
  refine ⟨hP, ?_⟩
  rw [hP, normSq_Rp]
  have hd : (54 : ℚ) * (det3 a b c d e (-a - d)) ^ 2 ≤ (a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2)) ^ 3 := by
    have := disc_nonneg (a : ℝ) b c d e
    simp only [det3]
    exact_mod_cast this
  nlinarith [hd]

/-- **The anti-self-dual mirror of steps 4 and 5.** -/
theorem L178_theta_asd (a b c d e : ℚ) :
    Pcubic (Rm a b c d e (-a - d)) = 9 * det3 a b c d e (-a - d) ∧
      Pcubic (Rm a b c d e (-a - d)) ^ 2 ≤ (3 / 2) * (((Rm a b c d e (-a - d))ᵀ * Rm a b c d e (-a - d)).trace) ^ 3 := by
  have hP : Pcubic (Rm a b c d e (-a - d)) = 9 * det3 a b c d e (-a - d) := by
    rw [Pcubic_Rm]; simp only [tr3, det3]; ring
  refine ⟨hP, ?_⟩
  rw [hP, normSq_Rm]
  have hd : (54 : ℚ) * (det3 a b c d e (-a - d)) ^ 2 ≤ (a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2)) ^ 3 := by
    have := disc_nonneg (a : ℝ) b c d e
    simp only [det3]
    exact_mod_cast this
  nlinarith [hd]

end HamiltonsCubic.Base
