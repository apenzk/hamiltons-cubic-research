import HamiltonsCubic.Base.WeylReal
import HamiltonsCubic.Results.L225Matrix

set_option linter.style.longLine false

/-!
# L178 at `n = 4` for real Weyl operators

[diagonal-half.md](../../../findings/diagonal-half.md), Lemma L178 at `V = ℝ⁴`. [L178N4.lean](L178N4.lean) and
[L178Eq.lean](L178Eq.lean) prove it on [Sharp.lean](../Base/Sharp.lean)'s `n = 4` model, whose matrices are rational.
This file carries Sharp.lean's definitions verbatim over `ℝ` (`basis4`, `coord4`, `toMat4`, `sharpQF`, `sharpMat`,
`Qop`, `Pcubic`, `IsBianchi`, `Ric`, `IsWeyl`), on [WeylReal.lean](../Base/WeylReal.lean)'s `phi`, `br` and `inner2`,
anchored by the same normalisation `sharpQF_one_basis` (`Id# = 2 Id`), and reproves the chain there:

- `sharp_sd`, `sharp_asd`, `sharpMat_Rp`, `Pcubic_Rp`, `normSq_Rp` and their mirrors: `#` on `Λ^±` is twice the
  adjugate and `P(R) = tr B³ + 6 det B`;
- `disc_nonneg`, `L178_theta_sd`, `L178_theta_asd`: `P(R)² ≤ (3/2)‖R‖⁶` for a trace-free block;
- `mixed_zero4`, `trace4`, `decomp4`, `rank4`, **`L178_n4`**: every real `n = 4` Weyl operator of rank at most three
  has `P(R)² ≤ (3/2)‖R‖⁶`, that is `|θ| ≤ √(3/2)` at unit norm;
- **`L178_n4_form`**, **`L178_n4_eq`**, **`L178_n4_attained`**: the equality clause in spectral form, both directions.

The proofs are those of the rational files with `ℚ` read as `ℝ`, the tactics being symbolic.
-/

-- The symbolic expansions unfold six-by-six products through `Fin.sum_univ_six`, as in Sharp.lean.
set_option maxRecDepth 100000

namespace HamiltonsCubic.L178Real

open Matrix Finset HamiltonsCubic.RealLayer

noncomputable section

/-- The six basis bivectors of `Λ²ℝ⁴`, in the pair order `curvature_operator.py` uses. -/
def basis4 : Fin 6 → Matrix (Fin 4) (Fin 4) ℝ
  | 0 => phi 0 1
  | 1 => phi 0 2
  | 2 => phi 0 3
  | 3 => phi 1 2
  | 4 => phi 1 3
  | 5 => phi 2 3

/-- The pair `(i,j)` carried by each basis index. -/
def pair4 : Fin 6 → Fin 4 × Fin 4
  | 0 => (0, 1) | 1 => (0, 2) | 2 => (0, 3)
  | 3 => (1, 2) | 4 => (1, 3) | 5 => (2, 3)

/-- Coordinates of a bivector: `v a = A (j, i)` for the pair `(i,j)`, matching
`matrix_to_vec`. -/
def coord4 (A : Matrix (Fin 4) (Fin 4) ℝ) (a : Fin 6) : ℝ :=
  A (pair4 a).2 (pair4 a).1

/-- A coordinate vector as a bivector. -/
def toMat4 (v : Fin 6 → ℝ) : Matrix (Fin 4) (Fin 4) ℝ := ∑ a, v a • basis4 a

/-- `⟨R# η, η⟩`, exactly `R_sharp_quadform`. -/
def sharpQF (R : Matrix (Fin 6) (Fin 6) ℝ) (η : Fin 6 → ℝ) : ℝ :=
  -(1/2) * ∑ i : Fin 6,
    coord4 (br (toMat4 η) (toMat4 (R *ᵥ coord4 (br (toMat4 η) (toMat4 (R *ᵥ Pi.single i 1)))))) i

set_option maxHeartbeats 4000000 in
-- Six `fin_cases` branches, each unfolding a doubly-nested `Λ²` bracket over `Fin 4`
-- into literal arithmetic. The default limit is reached on branch three.
/-- **The normalisation anchor at `n = 4`.** `⟨Id# φ, φ⟩ = n - 2 = 2` on every
basis bivector, so `Id# = (n-2) Id`.

**PROVED IN THE KERNEL** by `norm_num`, which emits a certificate the kernel checks, since real
equality is undecidable and `decide` has no instance on `ℝ`. The unfold set is Sharp.lean's, `Fin.sum_univ_six`
rather than `Fin.sum_univ_succ` so the `pair4` match meets literal indices, and `Fin.ext_iff` so the
residual `Fin` equalities decide. -/
theorem sharpQF_one_basis (a : Fin 6) : sharpQF 1 (Pi.single a 1) = 2 := by
  fin_cases a <;>
    simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, Matrix.mul_apply,
      Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
      Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
      Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply] <;>
    norm_num [Fin.ext_iff]

/-- `R#` as a matrix, recovered from the quadratic form by polarisation,
exactly `R_sharp_matrix`. -/
def sharpMat (R : Matrix (Fin 6) (Fin 6) ℝ) : Matrix (Fin 6) (Fin 6) ℝ :=
  Matrix.of fun a b =>
    if a = b then sharpQF R (Pi.single a 1)
    else (1/2) * (sharpQF R (Pi.single a 1 + Pi.single b 1)
                  - sharpQF R (Pi.single a 1) - sharpQF R (Pi.single b 1))

/-- Hamilton's map `Q(R) = R² + R#`. -/
def Qop (R : Matrix (Fin 6) (Fin 6) ℝ) : Matrix (Fin 6) (Fin 6) ℝ := R * R + sharpMat R

/-- The cubic form `P(R) = ⟨R, Q(R)⟩`, plain Frobenius at the operator level,
the `½` already lives at the `Λ²` level and is not applied twice. -/
def Pcubic (R : Matrix (Fin 6) (Fin 6) ℝ) : ℝ := (Rᵀ * Qop R).trace

/-! ## The Weyl conditions at `n = 4` -/

/-- First Bianchi. At `n = 4` there is one four-subset, so one equation. -/
def IsBianchi (R : Matrix (Fin 6) (Fin 6) ℝ) : Prop :=
  R 0 5 - R 1 4 + R 2 3 = 0

/-- The Ricci contraction, built through `Λ²` so the orientation signs come out
of the basis rather than being asserted. -/
def Ric (R : Matrix (Fin 6) (Fin 6) ℝ) (a b : Fin 4) : ℝ :=
  ∑ c : Fin 4, inner2 (toMat4 (R *ᵥ coord4 (phi a c))) (phi b c)

def IsRicciFlat (R : Matrix (Fin 6) (Fin 6) ℝ) : Prop := ∀ a b, Ric R a b = 0

/-- `𝒲₄`: symmetric, first Bianchi, Ricci-flat. -/
def IsWeyl (R : Matrix (Fin 6) (Fin 6) ℝ) : Prop :=
  R.IsSymm ∧ IsBianchi R ∧ IsRicciFlat R


/-- The self-dual coordinate vectors. -/
def wp : Fin 3 → Fin 6 → ℝ
  | 0, 0 => 1 | 0, 5 => 1 | 1, 1 => 1 | 1, 4 => -1 | 2, 2 => 1 | 2, 3 => 1 | _, _ => 0

/-- The operator supported on `Λ⁺` with block `B`. -/
def Rp (a b c d e f : ℝ) : Matrix (Fin 6) (Fin 6) ℝ :=
  Matrix.of fun p q => (1/2) * (a * wp 0 p * wp 0 q + d * wp 1 p * wp 1 q + f * wp 2 p * wp 2 q
    + b * (wp 0 p * wp 1 q + wp 1 p * wp 0 q) + c * (wp 0 p * wp 2 q + wp 2 p * wp 0 q)
    + e * (wp 1 p * wp 2 q + wp 2 p * wp 1 q))

/-- The quadratic form of the cofactor matrix of `B = [[a,b,c],[b,d,e],[c,e,f]]`. -/
def cofQF (a b c d e f x y z : ℝ) : ℝ :=
  x ^ 2 * (d * f - e ^ 2) + y ^ 2 * (a * f - c ^ 2) + z ^ 2 * (a * d - b ^ 2)
    + 2 * x * y * (c * e - b * f) + 2 * x * z * (b * e - c * d) + 2 * y * z * (b * c - a * e)

set_option maxHeartbeats 8000000 in
-- The symbolic expansion of the nested `Λ²` brackets over six `η` and six block entries exceeds the default.
/-- **`#` on the self-dual summand**: `⟨R# η, η⟩ = 4 · cof(B)` at `η`'s `Λ⁺` coordinates. -/
theorem sharp_sd (a b c d e f : ℝ) (η : Fin 6 → ℝ) :
    sharpQF (Rp a b c d e f) η =
      4 * cofQF a b c d e f ((η 0 + η 5) / 2) ((η 1 - η 4) / 2) ((η 2 + η 3) / 2) := by
  simp only [sharpQF, Rp, wp, toMat4, coord4, basis4, pair4, br, phi, Matrix.mul_apply,
      Matrix.single, Matrix.mulVec, dotProduct, Matrix.of_apply,
      Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
      Matrix.add_apply, Matrix.smul_apply, Fin.isValue, cofQF]
  norm_num [Fin.ext_iff]
  ring

/-- The anti-self-dual coordinate vectors `e₀₁ − e₂₃`, `e₀₂ + e₁₃`, `e₀₃ − e₁₂`. -/
def wm : Fin 3 → Fin 6 → ℝ
  | 0, 0 => 1 | 0, 5 => -1 | 1, 1 => 1 | 1, 4 => 1 | 2, 2 => 1 | 2, 3 => -1 | _, _ => 0

/-- The operator supported on `Λ⁻` with block `B`. -/
def Rm (a b c d e f : ℝ) : Matrix (Fin 6) (Fin 6) ℝ :=
  Matrix.of fun p q => (1/2) * (a * wm 0 p * wm 0 q + d * wm 1 p * wm 1 q + f * wm 2 p * wm 2 q
    + b * (wm 0 p * wm 1 q + wm 1 p * wm 0 q) + c * (wm 0 p * wm 2 q + wm 2 p * wm 0 q)
    + e * (wm 1 p * wm 2 q + wm 2 p * wm 1 q))

set_option maxHeartbeats 8000000 in
-- The symbolic expansion of the nested `Λ²` brackets over six `η` and six block entries exceeds the default.
/-- **The anti-self-dual mirror**: `⟨R# η, η⟩ = 4 · cof(B)` at `η`'s `Λ⁻` coordinates. -/
theorem sharp_asd (a b c d e f : ℝ) (η : Fin 6 → ℝ) :
    sharpQF (Rm a b c d e f) η =
      4 * cofQF a b c d e f ((η 0 - η 5) / 2) ((η 1 + η 4) / 2) ((η 2 - η 3) / 2) := by
  simp only [sharpQF, Rm, wm, toMat4, coord4, basis4, pair4, br, phi, Matrix.mul_apply,
      Matrix.single, Matrix.mulVec, dotProduct, Matrix.of_apply,
      Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
      Matrix.add_apply, Matrix.smul_apply, Fin.isValue, cofQF]
  norm_num [Fin.ext_iff]
  ring


/-- `tr B³` for `B = [[a,b,c],[b,d,e],[c,e,f]]`. -/
def tr3 (a b c d e f : ℝ) : ℝ :=
  a ^ 3 + d ^ 3 + f ^ 3 + 3 * b ^ 2 * (a + d) + 3 * c ^ 2 * (a + f) + 3 * e ^ 2 * (d + f) + 6 * b * c * e

/-- `det B`. -/
def det3 (a b c d e f : ℝ) : ℝ := a * d * f + 2 * b * c * e - a * e ^ 2 - d * c ^ 2 - f * b ^ 2

/-- The cofactor matrix of `B`, as a function. -/
def cofB (a b c d e f : ℝ) : Fin 3 → Fin 3 → ℝ
  | 0, 0 => d * f - e ^ 2 | 1, 1 => a * f - c ^ 2 | 2, 2 => a * d - b ^ 2
  | 0, 1 => c * e - b * f | 1, 0 => c * e - b * f
  | 0, 2 => b * e - c * d | 2, 0 => b * e - c * d
  | 1, 2 => b * c - a * e | 2, 1 => b * c - a * e
  | _, _ => 0

set_option maxHeartbeats 16000000 in
-- Thirty-six entries, each a polarised cofactor form in six symbolic block entries.
/-- **`R# = W cof(B) Wᵀ`** in `basis4` coordinates, `W` the matrix of `ω⁺`. -/
theorem sharpMat_Rp (a b c d e f : ℝ) :
    sharpMat (Rp a b c d e f) = Matrix.of fun p q => ∑ i : Fin 3, ∑ j : Fin 3, cofB a b c d e f i j * wp i p * wp j q := by
  ext p q
  simp only [sharpMat, Matrix.of_apply, sharp_sd]
  fin_cases p <;> fin_cases q <;>
    simp only [Fin.sum_univ_three, Pi.single_apply, Pi.add_apply, cofB, wp, cofQF, Fin.isValue, Fin.zero_eta,
      Fin.mk_one, Fin.reduceFinMk] <;> norm_num [Fin.ext_iff] <;> ring

set_option maxHeartbeats 16000000 in
-- A trace over `6 × 6` products of symbolic matrices.
/-- **Step 4 on the layer's objects**: `P(R) = tr B³ + 6 det B` for `R` supported on `Λ⁺` with block `B`. -/
theorem Pcubic_Rp (a b c d e f : ℝ) : Pcubic (Rp a b c d e f) = tr3 a b c d e f + 6 * det3 a b c d e f := by
  rw [Pcubic, Qop, sharpMat_Rp]
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply, Matrix.add_apply, Matrix.of_apply,
    Fin.sum_univ_six, Fin.sum_univ_three, Rp, wp, cofB, tr3, det3, Fin.isValue]
  norm_num
  ring

set_option maxHeartbeats 4000000 in
-- A trace over `6 × 6` products of symbolic matrices.
/-- The square norm of `R` is `tr B²`. -/
theorem normSq_Rp (a b c d e f : ℝ) :
    ((Rp a b c d e f)ᵀ * Rp a b c d e f).trace = a ^ 2 + d ^ 2 + f ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2) := by
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply, Matrix.of_apply,
    Fin.sum_univ_six, Rp, wp, Fin.isValue]
  norm_num
  ring

set_option maxHeartbeats 16000000 in
-- Thirty-six entries, each a polarised cofactor form in six symbolic block entries.
/-- **`R# = W cof(B) Wᵀ`** in `basis4` coordinates, `W` the matrix of `ω⁻`. -/
theorem sharpMat_Rm (a b c d e f : ℝ) :
    sharpMat (Rm a b c d e f) = Matrix.of fun p q => ∑ i : Fin 3, ∑ j : Fin 3, cofB a b c d e f i j * wm i p * wm j q := by
  ext p q
  simp only [sharpMat, Matrix.of_apply, sharp_asd]
  fin_cases p <;> fin_cases q <;>
    simp only [Fin.sum_univ_three, Pi.single_apply, Pi.add_apply, cofB, wm, cofQF, Fin.isValue, Fin.zero_eta,
      Fin.mk_one, Fin.reduceFinMk] <;> norm_num [Fin.ext_iff] <;> ring

set_option maxHeartbeats 16000000 in
-- A trace over `6 × 6` products of symbolic matrices.
/-- **Step 4 on the layer's objects**: `P(R) = tr B³ + 6 det B` for `R` supported on `Λ⁻` with block `B`. -/
theorem Pcubic_Rm (a b c d e f : ℝ) : Pcubic (Rm a b c d e f) = tr3 a b c d e f + 6 * det3 a b c d e f := by
  rw [Pcubic, Qop, sharpMat_Rm]
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply, Matrix.add_apply, Matrix.of_apply,
    Fin.sum_univ_six, Fin.sum_univ_three, Rm, wm, cofB, tr3, det3, Fin.isValue]
  norm_num
  ring

set_option maxHeartbeats 4000000 in
-- A trace over `6 × 6` products of symbolic matrices.
/-- The square norm of `R` is `tr B²`. -/
theorem normSq_Rm (a b c d e f : ℝ) :
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
theorem L178_theta_sd (a b c d e : ℝ) :
    Pcubic (Rp a b c d e (-a - d)) = 9 * det3 a b c d e (-a - d) ∧
      Pcubic (Rp a b c d e (-a - d)) ^ 2 ≤ (3 / 2) * (((Rp a b c d e (-a - d))ᵀ * Rp a b c d e (-a - d)).trace) ^ 3 := by
  have hP : Pcubic (Rp a b c d e (-a - d)) = 9 * det3 a b c d e (-a - d) := by
    rw [Pcubic_Rp]; simp only [tr3, det3]; ring
  refine ⟨hP, ?_⟩
  rw [hP, normSq_Rp]
  have hd : (54 : ℝ) * (det3 a b c d e (-a - d)) ^ 2 ≤ (a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2)) ^ 3 := by
    have := disc_nonneg (a : ℝ) b c d e
    simp only [det3]
    exact_mod_cast this
  nlinarith [hd]

/-- **The anti-self-dual mirror of steps 4 and 5.** -/
theorem L178_theta_asd (a b c d e : ℝ) :
    Pcubic (Rm a b c d e (-a - d)) = 9 * det3 a b c d e (-a - d) ∧
      Pcubic (Rm a b c d e (-a - d)) ^ 2 ≤ (3 / 2) * (((Rm a b c d e (-a - d))ᵀ * Rm a b c d e (-a - d)).trace) ^ 3 := by
  have hP : Pcubic (Rm a b c d e (-a - d)) = 9 * det3 a b c d e (-a - d) := by
    rw [Pcubic_Rm]; simp only [tr3, det3]; ring
  refine ⟨hP, ?_⟩
  rw [hP, normSq_Rm]
  have hd : (54 : ℝ) * (det3 a b c d e (-a - d)) ^ 2 ≤ (a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2)) ^ 3 := by
    have := disc_nonneg (a : ℝ) b c d e
    simp only [det3]
    exact_mod_cast this
  nlinarith [hd]


variable {R : Matrix (Fin 6) (Fin 6) ℝ}

set_option maxHeartbeats 16000000 in
-- Ten Ricci contractions, each a double sum over `Λ²ℝ⁴`, expanded symbolically.
/-- **Ricci-flatness kills the mixed block** in the layer's `n = 4` model. -/
theorem mixed_zero4 (hS : R.IsSymm) (hR : IsRicciFlat R) (i j : Fin 3) : wp i ⬝ᵥ (R *ᵥ wm j) = 0 := by
  have hs : ∀ p q, R q p = R p q := fun p q => by
    have := congrFun (congrFun hS p) q; simpa [Matrix.transpose_apply] using this
  have r00 := hR 0 0; have r01 := hR 0 1; have r02 := hR 0 2; have r03 := hR 0 3; have r11 := hR 1 1
  have r12 := hR 1 2; have r13 := hR 1 3; have r22 := hR 2 2; have r23 := hR 2 3; have r33 := hR 3 3
  simp only [Ric, toMat4, coord4, basis4, pair4, phi, inner2, Matrix.mulVec, dotProduct, Fin.sum_univ_six,
    Fin.sum_univ_four, Matrix.single, Matrix.sub_apply, Matrix.add_apply, Matrix.smul_apply, Fin.isValue,
    Matrix.of_apply, Matrix.transpose_apply, Matrix.mul_apply, Matrix.trace, Matrix.diag] at r00 r01 r02 r03 r11 r12 r13 r22 r23 r33
  norm_num [Fin.ext_iff] at r00 r01 r02 r03 r11 r12 r13 r22 r23 r33
  fin_cases i <;> fin_cases j <;>
    simp only [wp, wm, dotProduct, Matrix.mulVec, Fin.sum_univ_six, Fin.isValue, Fin.zero_eta, Fin.mk_one,
      Fin.reduceFinMk] <;> norm_num <;>
    linarith [hs 0 1, hs 0 2, hs 0 3, hs 0 4, hs 0 5, hs 1 2, hs 1 3, hs 1 4, hs 1 5, hs 2 3, hs 2 4, hs 2 5,
      hs 3 4, hs 3 5, hs 4 5]

theorem symm_entries (hS : R.IsSymm) (p q : Fin 6) : R q p = R p q := by
  have := congrFun (congrFun hS p) q; simpa [Matrix.transpose_apply] using this

set_option maxHeartbeats 16000000 in
-- Four Ricci contractions expanded symbolically.
/-- **Each summand is trace-free**: Ricci-flatness gives the sum, first Bianchi the difference. -/
theorem trace4 (hS : R.IsSymm) (hB : IsBianchi R) (hR : IsRicciFlat R) :
    wp 0 ⬝ᵥ (R *ᵥ wp 0) + wp 1 ⬝ᵥ (R *ᵥ wp 1) + wp 2 ⬝ᵥ (R *ᵥ wp 2) = 0 ∧
      wm 0 ⬝ᵥ (R *ᵥ wm 0) + wm 1 ⬝ᵥ (R *ᵥ wm 1) + wm 2 ⬝ᵥ (R *ᵥ wm 2) = 0 := by
  have hs := symm_entries hS
  have r00 := hR 0 0; have r11 := hR 1 1; have r22 := hR 2 2; have r33 := hR 3 3
  simp only [Ric, toMat4, coord4, basis4, pair4, phi, inner2, Matrix.mulVec, dotProduct, Fin.sum_univ_six, Fin.sum_univ_four, Matrix.single, Matrix.sub_apply, Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.transpose_apply, Matrix.mul_apply, Matrix.trace, Matrix.diag] at r00 r11 r22 r33
  norm_num [Fin.ext_iff] at r00 r11 r22 r33
  unfold IsBianchi at hB
  simp only [wp, wm, dotProduct, Matrix.mulVec, Fin.sum_univ_six, Fin.isValue]
  norm_num
  constructor <;> linarith [hs 0 1, hs 0 2, hs 0 3, hs 0 4, hs 0 5, hs 1 2, hs 1 3, hs 1 4, hs 1 5, hs 2 3, hs 2 4, hs 2 5, hs 3 4, hs 3 5, hs 4 5]

/-- The block of `R` on `Λ⁺` in the orthonormal basis `ω⁺/√2`. -/
def blkP (R : Matrix (Fin 6) (Fin 6) ℝ) (i j : Fin 3) : ℝ := (wp i ⬝ᵥ (R *ᵥ wp j)) / 2
/-- The block of `R` on `Λ⁻`. -/
def blkM (R : Matrix (Fin 6) (Fin 6) ℝ) (i j : Fin 3) : ℝ := (wm i ⬝ᵥ (R *ᵥ wm j)) / 2

set_option maxHeartbeats 16000000 in
-- Thirty-six entries, each a linear identity in the entries of `R`.
/-- **`R = R⁺ ⊕ R⁻`** once the mixed block vanishes. -/
theorem decomp4 (hS : R.IsSymm) (hmix : ∀ i j, wp i ⬝ᵥ (R *ᵥ wm j) = 0) :
    R = Rp (blkP R 0 0) (blkP R 0 1) (blkP R 0 2) (blkP R 1 1) (blkP R 1 2) (blkP R 2 2) +
      Rm (blkM R 0 0) (blkM R 0 1) (blkM R 0 2) (blkM R 1 1) (blkM R 1 2) (blkM R 2 2) := by
  have hs := symm_entries hS
  have m00 := hmix 0 0; have m01 := hmix 0 1; have m02 := hmix 0 2; have m10 := hmix 1 0; have m11 := hmix 1 1
  have m12 := hmix 1 2; have m20 := hmix 2 0; have m21 := hmix 2 1; have m22 := hmix 2 2
  simp only [wp, wm, dotProduct, Matrix.mulVec, Fin.sum_univ_six, Fin.isValue] at m00 m01 m02 m10 m11 m12 m20 m21 m22
  norm_num at m00 m01 m02 m10 m11 m12 m20 m21 m22
  ext p q
  fin_cases p <;> fin_cases q <;>
    simp only [Matrix.add_apply, Rp, Rm, Matrix.of_apply, blkP, blkM, wp, wm, dotProduct, Matrix.mulVec,
      Fin.sum_univ_six, Fin.isValue, Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk] <;> norm_num <;>
    linarith [hs 0 1, hs 0 2, hs 0 3, hs 0 4, hs 0 5, hs 1 2, hs 1 3, hs 1 4, hs 1 5, hs 2 3, hs 2 4, hs 2 5, hs 3 4, hs 3 5, hs 4 5]

theorem dot_symm (hS : R.IsSymm) (u v : Fin 6 → ℝ) : u ⬝ᵥ (R *ᵥ v) = v ⬝ᵥ (R *ᵥ u) := by
  rw [Matrix.dotProduct_mulVec]; nth_rewrite 1 [← hS.eq]; rw [Matrix.vecMul_transpose, dotProduct_comm]

/-- A symmetric trace-free `3 × 3` array with every `2 × 2` minor zero vanishes, over `ℝ`. -/
theorem eq_zero_of_minorsQ {B : Fin 3 → Fin 3 → ℝ} (hB : ∀ i j, B i j = B j i) (htr : B 0 0 + B 1 1 + B 2 2 = 0)
    (hm : ∀ i₁ i₂ j₁ j₂, B i₁ j₁ * B i₂ j₂ - B i₁ j₂ * B i₂ j₁ = 0) : ∀ i j, B i j = 0 := by
  have m01 := hm 0 1 0 1; have m02 := hm 0 2 0 2; have m12 := hm 1 2 1 2
  rw [hB 1 0] at m01; rw [hB 2 0] at m02; rw [hB 2 1] at m12
  have h2 : B 2 2 = -B 0 0 - B 1 1 := by linarith
  rw [h2] at m02 m12
  have ha : B 0 0 = 0 := by
    nlinarith [sq_nonneg (B 0 0 + B 1 1), sq_nonneg (B 0 0), sq_nonneg (B 1 1), sq_nonneg (B 0 1), sq_nonneg (B 0 2), sq_nonneg (B 1 2)]
  have hd : B 1 1 = 0 := by
    nlinarith [sq_nonneg (B 0 0 + B 1 1), sq_nonneg (B 0 0), sq_nonneg (B 1 1), sq_nonneg (B 0 1), sq_nonneg (B 0 2), sq_nonneg (B 1 2)]
  have hb : B 0 1 = 0 := by nlinarith [sq_nonneg (B 0 1)]
  have hc : B 0 2 = 0 := by nlinarith [sq_nonneg (B 0 2)]
  have he : B 1 2 = 0 := by nlinarith [sq_nonneg (B 1 2)]
  intro i j
  fin_cases i <;> fin_cases j <;> simp only [Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Fin.isValue] <;>
    first | assumption | (rw [hB]; assumption) | linarith

theorem exists_minorQ {B : Fin 3 → Fin 3 → ℝ} (hB : ∀ i j, B i j = B j i) (htr : B 0 0 + B 1 1 + B 2 2 = 0)
    (hne : ∃ i j, B i j ≠ 0) : ∃ i₁ i₂ j₁ j₂, B i₁ j₁ * B i₂ j₂ - B i₁ j₂ * B i₂ j₁ ≠ 0 := by
  by_contra h
  push Not at h
  obtain ⟨i, j, hij⟩ := hne
  exact hij (eq_zero_of_minorsQ hB htr h i j)

theorem two_by_twoQ {a b c d x y : ℝ} (hdet : a * d - b * c ≠ 0) (h1 : x * a + y * b = 0) (h2 : x * c + y * d = 0) :
    x = 0 ∧ y = 0 := by
  constructor
  · have : x * (a * d - b * c) = 0 := by linear_combination d * h1 - b * h2
    exact (mul_eq_zero.mp this).resolve_right hdet
  · have : y * (a * d - b * c) = 0 := by linear_combination a * h2 - c * h1
    exact (mul_eq_zero.mp this).resolve_right hdet

/-- **Rank at most three forces one block to vanish**, in the layer's `n = 4` model. -/
theorem rank4 (hS : R.IsSymm) (hB : IsBianchi R) (hR : IsRicciFlat R) (hrank : R.rank ≤ 3) :
    (∀ i j, blkP R i j = 0) ∨ (∀ i j, blkM R i j = 0) := by
  by_contra h
  push Not at h
  obtain ⟨hp, hm⟩ := h
  have hmix := mixed_zero4 hS hR
  have hmix' : ∀ i j, wm i ⬝ᵥ (R *ᵥ wp j) = 0 := fun i j => by rw [dot_symm hS]; exact hmix j i
  obtain ⟨htp, htm⟩ := trace4 hS hB hR
  have symP : ∀ i j, blkP R i j = blkP R j i := fun i j => by simp only [blkP, dot_symm hS (wp i)]
  have symM : ∀ i j, blkM R i j = blkM R j i := fun i j => by simp only [blkM, dot_symm hS (wm i)]
  have trP : blkP R 0 0 + blkP R 1 1 + blkP R 2 2 = 0 := by simp only [blkP]; linarith
  have trM : blkM R 0 0 + blkM R 1 1 + blkM R 2 2 = 0 := by simp only [blkM]; linarith
  obtain ⟨i₁, i₂, j₁, j₂, hdp⟩ := exists_minorQ symP trP hp
  obtain ⟨k₁, k₂, l₁, l₂, hdm⟩ := exists_minorQ symM trM hm
  simp only [blkP, blkM] at hdp hdm
  let v : Fin 4 → LinearMap.range R.mulVecLin := ![⟨R *ᵥ wp j₁, ⟨_, rfl⟩⟩, ⟨R *ᵥ wp j₂, ⟨_, rfl⟩⟩,
    ⟨R *ᵥ wm l₁, ⟨_, rfl⟩⟩, ⟨R *ᵥ wm l₂, ⟨_, rfl⟩⟩]
  have hli : LinearIndependent ℝ v := by
    rw [Fintype.linearIndependent_iff]
    intro c hc
    have hc' : c 0 • (R *ᵥ wp j₁) + c 1 • (R *ᵥ wp j₂) + c 2 • (R *ᵥ wm l₁) + c 3 • (R *ᵥ wm l₂) = 0 := by
      have := congrArg Subtype.val hc
      simpa [Fin.sum_univ_four, v] using this
    have e : ∀ x : Fin 6 → ℝ, x ⬝ᵥ (c 0 • (R *ᵥ wp j₁) + c 1 • (R *ᵥ wp j₂) + c 2 • (R *ᵥ wm l₁) + c 3 • (R *ᵥ wm l₂)) = 0 :=
      fun x => by rw [hc', dotProduct_zero]
    have ep1 := e (wp i₁); have ep2 := e (wp i₂); have em1 := e (wm k₁); have em2 := e (wm k₂)
    simp only [dotProduct_add, dotProduct_smul, smul_eq_mul, hmix, hmix', mul_zero, add_zero, zero_add] at ep1 ep2 em1 em2
    have hdp' : (wp i₁ ⬝ᵥ (R *ᵥ wp j₁)) * (wp i₂ ⬝ᵥ (R *ᵥ wp j₂)) - (wp i₁ ⬝ᵥ (R *ᵥ wp j₂)) * (wp i₂ ⬝ᵥ (R *ᵥ wp j₁)) ≠ 0 := by
      intro h0; apply hdp; field_simp; linarith
    have hdm' : (wm k₁ ⬝ᵥ (R *ᵥ wm l₁)) * (wm k₂ ⬝ᵥ (R *ᵥ wm l₂)) - (wm k₁ ⬝ᵥ (R *ᵥ wm l₂)) * (wm k₂ ⬝ᵥ (R *ᵥ wm l₁)) ≠ 0 := by
      intro h0; apply hdm; field_simp; linarith
    obtain ⟨h0, h1⟩ := two_by_twoQ hdp' ep1 ep2
    obtain ⟨h2, h3⟩ := two_by_twoQ hdm' em1 em2
    intro t; fin_cases t <;> assumption
  have := hli.fintype_card_le_finrank
  simp only [Fintype.card_fin] at this
  unfold Matrix.rank at hrank
  omega

theorem Rm_zero : Rm 0 0 0 0 0 0 = 0 := by ext p q; simp [Rm]
theorem Rp_zero : Rp 0 0 0 0 0 0 = 0 := by ext p q; simp [Rp]

/-- **L178 at `n = 4`**: a Weyl operator on `Λ²ℝ⁴` of rank at most three has `P(R)² ≤ (3/2) ‖R‖⁶`, that is
`|θ| ≤ √(3/2)` at unit norm. -/
theorem L178_n4 (hW : IsWeyl R) (hrank : R.rank ≤ 3) :
    Pcubic R ^ 2 ≤ (3 / 2) * ((Rᵀ * R).trace) ^ 3 := by
  obtain ⟨hS, hB, hR⟩ := hW
  have hd := decomp4 hS (mixed_zero4 hS hR)
  obtain ⟨htp, htm⟩ := trace4 hS hB hR
  rcases rank4 hS hB hR hrank with h | h
  · have hf : blkM R 2 2 = -blkM R 0 0 - blkM R 1 1 := by simp only [blkM]; linarith
    rw [show blkP R 0 0 = 0 from h 0 0, show blkP R 0 1 = 0 from h 0 1, show blkP R 0 2 = 0 from h 0 2,
      show blkP R 1 1 = 0 from h 1 1, show blkP R 1 2 = 0 from h 1 2, show blkP R 2 2 = 0 from h 2 2, Rp_zero,
      zero_add, hf] at hd
    rw [hd]
    exact (L178_theta_asd _ _ _ _ _).2
  · have hf : blkP R 2 2 = -blkP R 0 0 - blkP R 1 1 := by simp only [blkP]; linarith
    rw [show blkM R 0 0 = 0 from h 0 0, show blkM R 0 1 = 0 from h 0 1, show blkM R 0 2 = 0 from h 0 2,
      show blkM R 1 1 = 0 from h 1 1, show blkM R 1 2 = 0 from h 1 2, show blkM R 2 2 = 0 from h 2 2, Rm_zero,
      add_zero, hf] at hd
    rw [hd]
    exact (L178_theta_sd _ _ _ _ _).2


/-- The trace-free block `[[a,b,c],[b,d,e],[c,e,−a−d]]` as a real matrix. -/
def blockR (a b c d e : ℝ) : Matrix (Fin 3) (Fin 3) ℝ :=
  Matrix.of fun i j => (match i, j with
    | 0, 0 => a | 0, 1 => b | 0, 2 => c | 1, 0 => b | 1, 1 => d | 1, 2 => e
    | 2, 0 => c | 2, 1 => e | 2, 2 => -a - d : ℝ)

theorem blockR_hermitian (a b c d e : ℝ) : (blockR a b c d e).IsHermitian := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [blockR, Matrix.conjTranspose_apply]

theorem blockR_trace (a b c d e : ℝ) : (blockR a b c d e).trace = 0 := by
  simp [blockR, Matrix.trace, Fin.sum_univ_three]

theorem blockR_trace_sq (a b c d e : ℝ) :
    ((blockR a b c d e) ^ 2).trace = ((a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2) : ℝ) : ℝ) := by
  simp [blockR, Matrix.trace, pow_two, Matrix.mul_apply, Fin.sum_univ_three]; ring

theorem blockR_trace_cube (a b c d e : ℝ) :
    ((blockR a b c d e) ^ 3).trace = ((3 * det3 a b c d e (-a - d) : ℝ) : ℝ) := by
  simp [blockR, Matrix.trace, pow_succ, pow_zero, Matrix.mul_apply, Fin.sum_univ_three, det3]; ring

/-- **L178's equality clause for a trace-free block, in spectral form**: if `(9 det B)² = (3/2)(tr B²)³` with
`det B > 0`, the normalised block `B/√(tr B²)` has eigenvalues `2/√6` once and `−1/√6` twice, the `ℂP²` spectrum. -/
theorem L178_eq_block (a b c d e : ℝ) (hs : 0 < a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2))
    (heq : (9 * det3 a b c d e (-a - d)) ^ 2 = (3 / 2) * (a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2)) ^ 3)
    (hpos : 0 < det3 a b c d e (-a - d)) :
    let M := (1 / Real.sqrt ((a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2) : ℝ) : ℝ)) • blockR a b c d e
    ∃ hM : M.IsHermitian, (∀ i, hM.eigenvalues i = 2 / Real.sqrt 6 ∨ hM.eigenvalues i = -1 / Real.sqrt 6) ∧
      (univ.filter fun i => hM.eigenvalues i = 2 / Real.sqrt 6).card = 1 := by
  intro M
  set s : ℝ := a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2) with hsdef
  set D : ℝ := det3 a b c d e (-a - d) with hD
  have hsR : (0 : ℝ) < s := by exact_mod_cast hs
  set t := Real.sqrt (s : ℝ) with ht
  have ht0 : 0 < t := Real.sqrt_pos.mpr hsR
  have hts : t ^ 2 = s := Real.sq_sqrt hsR.le
  have h6 : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  have h60 : 0 < Real.sqrt 6 := by positivity
  -- `D = t³ / (3√6)`
  have hDR : (D : ℝ) = t ^ 3 / (3 * Real.sqrt 6) := by
    have heqR : (81 : ℝ) * (D : ℝ) ^ 2 = (3 / 2) * (s : ℝ) ^ 3 := by
      have := congrArg (fun q : ℝ => (q : ℝ)) heq; linarith
    have hDp : (0 : ℝ) < D := by exact_mod_cast hpos
    have key : ((D : ℝ) - t ^ 3 / (3 * Real.sqrt 6)) * ((D : ℝ) + t ^ 3 / (3 * Real.sqrt 6)) = 0 := by
      have : (t ^ 3 / (3 * Real.sqrt 6)) ^ 2 = (s : ℝ) ^ 3 / 54 := by
        rw [div_pow, mul_pow, h6, ← hts]; ring
      nlinarith [this]
    have hpos2 : 0 < (D : ℝ) + t ^ 3 / (3 * Real.sqrt 6) := by positivity
    have := (mul_eq_zero.mp key).resolve_right hpos2.ne'
    linarith
  have hM : M.IsHermitian := Matrix.IsHermitian.smul (blockR_hermitian a b c d e) (IsSelfAdjoint.all _)
  refine ⟨hM, ?_⟩
  have hr : (1 / t) ^ 2 * (s : ℝ) = 1 := by rw [div_pow, one_pow, hts]; field_simp
  have h1 : M.trace = 0 := by simp only [M, Matrix.trace_smul, blockR_trace, smul_zero]
  have h2 : (M ^ 2).trace = 1 := by
    simp only [M, smul_pow, Matrix.trace_smul, blockR_trace_sq, smul_eq_mul]
    rw [← ht]; exact hr
  have h3 : (M ^ 3).trace = ((Fintype.card (Fin 3) : ℝ) - 2) / Real.sqrt 6 := by
    simp only [M, smul_pow, Matrix.trace_smul, blockR_trace_cube, smul_eq_mul, Fintype.card_fin]
    rw [← ht]; push_cast; rw [← hD, hDR]
    field_simp
    ring
  have hc : Real.sqrt 6 ^ 2 = (Fintype.card (Fin 3) : ℝ) * ((Fintype.card (Fin 3) : ℝ) - 1) := by
    rw [h6]; norm_num
  obtain ⟨hev, hcard⟩ := HamiltonsCubic.L225Statement.matrix_cube_eq M hM (Real.sqrt 6) h60 hc (by simp) h1 h2 h3
  simp only [Fintype.card_fin] at hev hcard
  norm_num at hev hcard
  exact ⟨hev, hcard⟩

/-- **Every `n = 4` Weyl operator of rank at most three is a trace-free block on `Λ⁺` or on `Λ⁻`.** -/
theorem L178_n4_form {R : Matrix (Fin 6) (Fin 6) ℝ} (hW : IsWeyl R) (hrank : R.rank ≤ 3) :
    ∃ a b c d e : ℝ, R = Rp a b c d e (-a - d) ∨ R = Rm a b c d e (-a - d) := by
  obtain ⟨hS, hB, hR⟩ := hW
  have hd := decomp4 hS (mixed_zero4 hS hR)
  obtain ⟨htp, htm⟩ := trace4 hS hB hR
  rcases rank4 hS hB hR hrank with h | h
  · have hf : blkM R 2 2 = -blkM R 0 0 - blkM R 1 1 := by simp only [blkM]; linarith
    rw [show blkP R 0 0 = 0 from h 0 0, show blkP R 0 1 = 0 from h 0 1, show blkP R 0 2 = 0 from h 0 2,
      show blkP R 1 1 = 0 from h 1 1, show blkP R 1 2 = 0 from h 1 2, show blkP R 2 2 = 0 from h 2 2, Rp_zero,
      zero_add, hf] at hd
    exact ⟨_, _, _, _, _, Or.inr hd⟩
  · have hf : blkP R 2 2 = -blkP R 0 0 - blkP R 1 1 := by simp only [blkP]; linarith
    rw [show blkM R 0 0 = 0 from h 0 0, show blkM R 0 1 = 0 from h 0 1, show blkM R 0 2 = 0 from h 0 2,
      show blkM R 1 1 = 0 from h 1 1, show blkM R 1 2 = 0 from h 1 2, show blkM R 2 2 = 0 from h 2 2, Rm_zero,
      add_zero, hf] at hd
    exact ⟨_, _, _, _, _, Or.inl hd⟩

/-- **L178's equality clause at `n = 4`, in spectral form**: an `n = 4` Weyl operator of rank at most three with
`θ = +√(3/2)`, that is `P(R)² = (3/2)‖R‖⁶` and `P(R) > 0`, is a trace-free block on `Λ⁺` or on `Λ⁻` whose normalised
spectrum is `(2, −1, −1)/√6`, the `ℂP²` spectrum. -/
theorem L178_n4_eq {R : Matrix (Fin 6) (Fin 6) ℝ} (hW : IsWeyl R) (hrank : R.rank ≤ 3)
    (heq : Pcubic R ^ 2 = (3 / 2) * ((Rᵀ * R).trace) ^ 3) (hpos : 0 < Pcubic R) :
    ∃ a b c d e : ℝ, (R = Rp a b c d e (-a - d) ∨ R = Rm a b c d e (-a - d)) ∧
      let M := (1 / Real.sqrt ((a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2) : ℝ) : ℝ)) • blockR a b c d e
      ∃ hM : M.IsHermitian, (∀ i, hM.eigenvalues i = 2 / Real.sqrt 6 ∨ hM.eigenvalues i = -1 / Real.sqrt 6) ∧
        (univ.filter fun i => hM.eigenvalues i = 2 / Real.sqrt 6).card = 1 := by
  obtain ⟨a, b, c, d, e, hR⟩ := L178_n4_form hW hrank
  refine ⟨a, b, c, d, e, hR, ?_⟩
  have hPs : Pcubic R = 9 * det3 a b c d e (-a - d) ∧
      (Rᵀ * R).trace = a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2) := by
    rcases hR with hR | hR <;> subst hR
    · exact ⟨(L178_theta_sd a b c d e).1, normSq_Rp _ _ _ _ _ _⟩
    · exact ⟨(L178_theta_asd a b c d e).1, normSq_Rm _ _ _ _ _ _⟩
  obtain ⟨hP, hN⟩ := hPs
  rw [hP, hN] at heq
  rw [hP] at hpos
  have hD : 0 < det3 a b c d e (-a - d) := by linarith
  have hs : 0 < a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2) := by
    by_contra hle
    push Not at hle
    have h0 : 0 ≤ a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2) := by positivity
    have hz : a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2) = 0 := le_antisymm hle h0
    rw [hz] at heq
    nlinarith [hD]
  exact L178_eq_block a b c d e hs heq hD

set_option maxHeartbeats 16000000 in
-- Ten Ricci contractions of the witness, expanded symbolically.
/-- **The converse: the `ℂP²` block attains the bound.** `R = R⁺(diag(2, −1, −1))` is an `n = 4` Weyl operator of rank
at most three with `P(R)² = (3/2)‖R‖⁶` and `P(R) > 0`. -/
theorem L178_n4_attained :
    IsWeyl (Rp 2 0 0 (-1) 0 (-1)) ∧ (Rp 2 0 0 (-1) 0 (-1)).rank ≤ 3 ∧ 0 < Pcubic (Rp 2 0 0 (-1) 0 (-1)) ∧
      Pcubic (Rp 2 0 0 (-1) 0 (-1)) ^ 2 = (3 / 2) * (((Rp 2 0 0 (-1) 0 (-1))ᵀ * Rp 2 0 0 (-1) 0 (-1)).trace) ^ 3 := by
  have hP : Pcubic (Rp 2 0 0 (-1) 0 (-1)) = 18 := by
    have := (L178_theta_sd 2 0 0 (-1) 0).1
    norm_num at this; rw [this]; norm_num [det3]
  have hN := normSq_Rp 2 0 0 (-1) 0 (-1)
  refine ⟨⟨?_, ?_, ?_⟩, ?_, by rw [hP]; norm_num, by rw [hP, hN]; norm_num⟩
  · ext p q; fin_cases p <;> fin_cases q <;> simp [Rp, wp, Matrix.transpose_apply]
  · simp [IsBianchi, Rp, wp]; norm_num
  · intro a b
    fin_cases a <;> fin_cases b <;>
      simp only [Ric, toMat4, coord4, basis4, pair4, phi, inner2, Matrix.mulVec, dotProduct, Fin.sum_univ_six,
        Fin.sum_univ_four, Matrix.single, Matrix.sub_apply, Matrix.add_apply, Matrix.smul_apply, Fin.isValue,
        Matrix.of_apply, Matrix.transpose_apply, Matrix.mul_apply, Matrix.trace, Matrix.diag, Rp, wp, Fin.zero_eta,
        Fin.mk_one, Fin.reduceFinMk] <;> norm_num [Fin.ext_iff]
  · -- `R = W N` with `W` the `6 × 3` matrix of `ω⁺`
    let Wm : Matrix (Fin 6) (Fin 3) ℝ := Matrix.of fun p i => wp i p
    let Nm : Matrix (Fin 3) (Fin 6) ℝ := Matrix.of fun i q => (1 / 2 : ℝ) * (match i with
      | 0 => 2 * wp 0 q | 1 => -wp 1 q | 2 => -wp 2 q)
    have e : Rp 2 0 0 (-1) 0 (-1) = Wm * Nm := by
      ext p q; fin_cases p <;> fin_cases q <;> simp [Rp, Wm, Nm, wp, Matrix.mul_apply, Fin.sum_univ_three]
    rw [e]
    exact (Matrix.rank_mul_le_left Wm Nm).trans (by simpa using Matrix.rank_le_width Wm)


end

end HamiltonsCubic.L178Real
