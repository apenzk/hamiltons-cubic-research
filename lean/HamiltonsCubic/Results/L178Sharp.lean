import HamiltonsCubic.Base.Sharp

set_option linter.style.longLine false
set_option maxRecDepth 100000

/-!
# L178, step 2: `#` on `𝔰𝔲(2)` is twice the adjugate

[diagonal-half.md](../../../findings/diagonal-half.md), Lemma L178, step 2: with `Λ^± ≅ 𝔰𝔲(2)` and the record's anchor
`id# = (n − 2) id`, *"`γ² = 2`"* and *"`W^# = 2 cof W` on `𝔰𝔲(2)`"*. This file computes the layer's own `#`
([Sharp.lean](../Base/Sharp.lean)'s `sharpQF`, the record's `R_sharp_quadform`, anchored by `sharpQF_one_basis`) at
`n = 4` on an operator supported on one of `Λ^±`.

- `wp`, `wm`: the coordinates of `ω⁺ = e₀₁ + e₂₃, e₀₂ − e₁₃, e₀₃ + e₁₂` and `ω⁻ = e₀₁ − e₂₃, e₀₂ + e₁₃, e₀₃ − e₁₂` in
  `basis4`, each of square norm `2`;
- `Rp`, `Rm`: the operator with block `B = [[a,b,c],[b,d,e],[c,e,f]]` on `Λ^±` in the orthonormal basis `ω^±/√2`,
  and zero on the other summand;
- `cofQF`: the quadratic form of `B`'s cofactor matrix;
- **`sharp_sd`**, **`sharp_asd`**: `⟨R# η, η⟩ = 4 cofQF(B)(x)` with `x_i = ⟨η, ω_i⟩/2` the `ω`-coordinates of `η`. In the
  orthonormal coordinates `ξ = √2 x` this is `2 ξᵀ cof(B) ξ`: `R#` vanishes off `Λ^±` and is `2 cof(B)` on it, the
  record's `γ² = 2`. Both are symbolic identities in `B` and `η`, checked by `norm_num` and `ring`.
-/

namespace HamiltonsCubic.Base

open Matrix

/-- The self-dual coordinate vectors. -/
def wp : Fin 3 → Fin 6 → ℚ
  | 0, 0 => 1 | 0, 5 => 1 | 1, 1 => 1 | 1, 4 => -1 | 2, 2 => 1 | 2, 3 => 1 | _, _ => 0

/-- The operator supported on `Λ⁺` with block `B`. -/
def Rp (a b c d e f : ℚ) : Matrix (Fin 6) (Fin 6) ℚ :=
  Matrix.of fun p q => (1/2) * (a * wp 0 p * wp 0 q + d * wp 1 p * wp 1 q + f * wp 2 p * wp 2 q
    + b * (wp 0 p * wp 1 q + wp 1 p * wp 0 q) + c * (wp 0 p * wp 2 q + wp 2 p * wp 0 q)
    + e * (wp 1 p * wp 2 q + wp 2 p * wp 1 q))

/-- The quadratic form of the cofactor matrix of `B = [[a,b,c],[b,d,e],[c,e,f]]`. -/
def cofQF (a b c d e f x y z : ℚ) : ℚ :=
  x ^ 2 * (d * f - e ^ 2) + y ^ 2 * (a * f - c ^ 2) + z ^ 2 * (a * d - b ^ 2)
    + 2 * x * y * (c * e - b * f) + 2 * x * z * (b * e - c * d) + 2 * y * z * (b * c - a * e)

set_option maxHeartbeats 8000000 in
-- The symbolic expansion of the nested `Λ²` brackets over six `η` and six block entries exceeds the default.
/-- **`#` on the self-dual summand**: `⟨R# η, η⟩ = 4 · cof(B)` at `η`'s `Λ⁺` coordinates. -/
theorem sharp_sd (a b c d e f : ℚ) (η : Fin 6 → ℚ) :
    sharpQF (Rp a b c d e f) η =
      4 * cofQF a b c d e f ((η 0 + η 5) / 2) ((η 1 - η 4) / 2) ((η 2 + η 3) / 2) := by
  simp only [sharpQF, Rp, wp, toMat4, coord4, basis4, pair4, br, phi, Matrix.mul_apply,
      Matrix.single, Matrix.mulVec, dotProduct, Matrix.of_apply,
      Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
      Matrix.add_apply, Matrix.smul_apply, Fin.isValue, cofQF]
  norm_num [Fin.ext_iff]
  ring

/-- The anti-self-dual coordinate vectors `e₀₁ − e₂₃`, `e₀₂ + e₁₃`, `e₀₃ − e₁₂`. -/
def wm : Fin 3 → Fin 6 → ℚ
  | 0, 0 => 1 | 0, 5 => -1 | 1, 1 => 1 | 1, 4 => 1 | 2, 2 => 1 | 2, 3 => -1 | _, _ => 0

/-- The operator supported on `Λ⁻` with block `B`. -/
def Rm (a b c d e f : ℚ) : Matrix (Fin 6) (Fin 6) ℚ :=
  Matrix.of fun p q => (1/2) * (a * wm 0 p * wm 0 q + d * wm 1 p * wm 1 q + f * wm 2 p * wm 2 q
    + b * (wm 0 p * wm 1 q + wm 1 p * wm 0 q) + c * (wm 0 p * wm 2 q + wm 2 p * wm 0 q)
    + e * (wm 1 p * wm 2 q + wm 2 p * wm 1 q))

set_option maxHeartbeats 8000000 in
-- The symbolic expansion of the nested `Λ²` brackets over six `η` and six block entries exceeds the default.
/-- **The anti-self-dual mirror**: `⟨R# η, η⟩ = 4 · cof(B)` at `η`'s `Λ⁻` coordinates. -/
theorem sharp_asd (a b c d e f : ℚ) (η : Fin 6 → ℚ) :
    sharpQF (Rm a b c d e f) η =
      4 * cofQF a b c d e f ((η 0 - η 5) / 2) ((η 1 + η 4) / 2) ((η 2 - η 3) / 2) := by
  simp only [sharpQF, Rm, wm, toMat4, coord4, basis4, pair4, br, phi, Matrix.mul_apply,
      Matrix.single, Matrix.mulVec, dotProduct, Matrix.of_apply,
      Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
      Matrix.add_apply, Matrix.smul_apply, Fin.isValue, cofQF]
  norm_num [Fin.ext_iff]
  ring

end HamiltonsCubic.Base
