import HamiltonsCubic.Base.Bivectors

/-!
# B1, part 2: the `#` operator at `n = 4`

`#` is defined here by the quadratic form the record's own machinery uses
(`scripts/lib/curvature_operator.py`, `R_sharp_quadform`):

`⟨R# η, η⟩ = -½ Σᵢ ⟨[η, R([η, R(ωᵢ)])], ωᵢ⟩`

equivalently `(R#)_{ab} = ½ c_{aγδ} c_{bεζ} R_{γε} R_{δζ}`, which
[fence-posts.md](../../../findings/fence-posts.md) records as matching
Böhm–Wilking eq. (4) **with no rescaling**.

The quadratic form is a sum over the `N` basis bivectors rather than a
quadruple contraction, so it is `N` terms rather than `N⁴`.

> **THIS FILE IS FREE OF `native_decide` AS OF 2026-09-20**, the anchor and the three `diagTest`
> entries all proved in the kernel on the standard three axioms. *A first version of this note said
> the kernel routes "were tried first and both failed", `decide` stalling on `Rat` equality and
> `norm_num` exceeding the heartbeat limit.* **The first half is right and the second was a route
> recorded closed from one attempt.** `decide` does wall, `Rat.normalize` being what the kernel
> will not unfold cheaply. **`norm_num` does not**: it emits a certificate. *What the first attempt
> lacked was `Fin.sum_univ_six`, without which the `pair4` match meets `Fin.succ` terms rather than
> literal indices and never reduces, and the entry values of the weight vector supplied as `rfl`
> facts, without which `norm_num` cannot evaluate `![1,2,3,4,5,6] 3`.*

**The anchor** is `Id# = (n-2) Id`, which the record reports holding at
`n = 3,4,5,6`. If `#` were normalised wrong, everything downstream would be
wrong by a constant, so the anchor is proved before anything is built on it.
-/

set_option linter.style.longLine false
set_option maxRecDepth 100000

namespace HamiltonsCubic.Base

open Matrix

/-- The six basis bivectors of `Λ²ℝ⁴`, in the pair order `curvature_operator.py` uses. -/
def basis4 : Fin 6 → Matrix (Fin 4) (Fin 4) ℚ
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
def coord4 (A : Matrix (Fin 4) (Fin 4) ℚ) (a : Fin 6) : ℚ :=
  A (pair4 a).2 (pair4 a).1

/-- A coordinate vector as a bivector. -/
def toMat4 (v : Fin 6 → ℚ) : Matrix (Fin 4) (Fin 4) ℚ := ∑ a, v a • basis4 a

/-- `⟨R# η, η⟩`, exactly `R_sharp_quadform`. -/
def sharpQF (R : Matrix (Fin 6) (Fin 6) ℚ) (η : Fin 6 → ℚ) : ℚ :=
  -(1/2) * ∑ i : Fin 6,
    coord4 (br (toMat4 η) (toMat4 (R *ᵥ coord4 (br (toMat4 η) (toMat4 (R *ᵥ Pi.single i 1)))))) i

set_option maxHeartbeats 4000000 in
-- Six `fin_cases` branches, each unfolding a doubly-nested `Λ²` bracket over `Fin 4`
-- into literal rational arithmetic; the default limit is reached on branch three.
/-- **The normalisation anchor at `n = 4`.** `⟨Id# φ, φ⟩ = n - 2 = 2` on every
basis bivector, so `Id# = (n-2) Id`.

**PROVED IN THE KERNEL, WHERE THIS WAS `native_decide` UNTIL 2026-09-20.** *`decide` walls on `ℚ`
because `Rat.normalize` is what the kernel will not unfold cheaply, and `norm_num` does not: it
emits a certificate the kernel checks.* **The unfold set is what took the work**, `Fin.sum_univ_six`
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
def sharpMat (R : Matrix (Fin 6) (Fin 6) ℚ) : Matrix (Fin 6) (Fin 6) ℚ :=
  Matrix.of fun a b =>
    if a = b then sharpQF R (Pi.single a 1)
    else (1/2) * (sharpQF R (Pi.single a 1 + Pi.single b 1)
                  - sharpQF R (Pi.single a 1) - sharpQF R (Pi.single b 1))

/-- Hamilton's map `Q(R) = R² + R#`. -/
def Qop (R : Matrix (Fin 6) (Fin 6) ℚ) : Matrix (Fin 6) (Fin 6) ℚ := R * R + sharpMat R

/-- The cubic form `P(R) = ⟨R, Q(R)⟩`, plain Frobenius at the operator level,
the `½` already lives at the `Λ²` level and is not applied twice. -/
def Pcubic (R : Matrix (Fin 6) (Fin 6) ℚ) : ℚ := (Rᵀ * Qop R).trace

/-! ## The Weyl conditions at `n = 4` -/

/-- First Bianchi. At `n = 4` there is one four-subset, so one equation. -/
def IsBianchi (R : Matrix (Fin 6) (Fin 6) ℚ) : Prop :=
  R 0 5 - R 1 4 + R 2 3 = 0

/-- The Ricci contraction, built through `Λ²` so the orientation signs come out
of the basis rather than being asserted. -/
def Ric (R : Matrix (Fin 6) (Fin 6) ℚ) (a b : Fin 4) : ℚ :=
  ∑ c : Fin 4, inner2 (toMat4 (R *ᵥ coord4 (phi a c))) (phi b c)

def IsRicciFlat (R : Matrix (Fin 6) (Fin 6) ℚ) : Prop := ∀ a b, Ric R a b = 0

/-- `𝒲₄`: symmetric, first Bianchi, Ricci-flat. -/
def IsWeyl (R : Matrix (Fin 6) (Fin 6) ℚ) : Prop :=
  R.IsSymm ∧ IsBianchi R ∧ IsRicciFlat R

/-! ## Cross-check against the record's own validation

`curvature_operator.py`'s `test_diagonal_formula` asserts that for `M` diagonal
with entries `λ_{ij}` on the coordinate 2-planes, `Q(M)` is **diagonal** with

`Q_{(ij),(ij)} = λ_{ij}² + Σ_{k ≠ i,j} λ_{ik} λ_{jk}`.

Checked here at a concrete rational diagonal, which tests `sharpMat`, the
polarisation and `Qop` together. -/

/-- A diagonal operator with entries `1,2,3,4,5,6` on the six coordinate planes. -/
def diagTest : Matrix (Fin 6) (Fin 6) ℚ :=
  Matrix.diagonal ![1, 2, 3, 4, 5, 6]

set_option maxHeartbeats 4000000 in
set_option maxRecDepth 8000 in
-- Unfolds a doubly-nested `Λ²` bracket over `Fin 4` into literal rational arithmetic.
/-- Pair `(0,1)` has index `0`; the complementary index `k` runs over `2,3`,
giving `λ₀₁² + λ₀₂λ₁₂ + λ₀₃λ₁₃ = 1 + 2·4 + 3·5 = 24`. -/
theorem Qop_diagTest_00 : Qop diagTest 0 0 = 24 := by
  have e2 : (![1, 2, 3, 4, 5, 6] : Fin 6 → ℚ) 2 = 3 := rfl
  have e3 : (![1, 2, 3, 4, 5, 6] : Fin 6 → ℚ) 3 = 4 := rfl
  have e4 : (![1, 2, 3, 4, 5, 6] : Fin 6 → ℚ) 4 = 5 := rfl
  have e5 : (![1, 2, 3, 4, 5, 6] : Fin 6 → ℚ) 5 = 6 := rfl
  simp only [Qop, sharpMat, sharpQF, toMat4, coord4, basis4, pair4, br, phi, diagTest,
    Matrix.mul_apply, Matrix.single, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.diagonal]
  norm_num [e2, e3, e4, e5, Fin.ext_iff]

set_option maxHeartbeats 4000000 in
set_option maxRecDepth 8000 in
-- Unfolds a doubly-nested `Λ²` bracket over `Fin 4` into literal rational arithmetic.
/-- Pair `(2,3)` has index `5`: `λ₂₃² + λ₀₂λ₀₃ + λ₁₂λ₁₃ = 36 + 2·3 + 4·5 = 62`. -/
theorem Qop_diagTest_55 : Qop diagTest 5 5 = 62 := by
  have e2 : (![1, 2, 3, 4, 5, 6] : Fin 6 → ℚ) 2 = 3 := rfl
  have e3 : (![1, 2, 3, 4, 5, 6] : Fin 6 → ℚ) 3 = 4 := rfl
  have e4 : (![1, 2, 3, 4, 5, 6] : Fin 6 → ℚ) 4 = 5 := rfl
  have e5 : (![1, 2, 3, 4, 5, 6] : Fin 6 → ℚ) 5 = 6 := rfl
  simp only [Qop, sharpMat, sharpQF, toMat4, coord4, basis4, pair4, br, phi, diagTest,
    Matrix.mul_apply, Matrix.single, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.diagonal]
  norm_num [e2, e3, e4, e5, Fin.ext_iff]

set_option maxHeartbeats 4000000 in
set_option maxRecDepth 8000 in
-- Unfolds a doubly-nested `Λ²` bracket over `Fin 4` into literal rational arithmetic.
/-- And `Q` is diagonal there, as the reference asserts. -/
theorem Qop_diagTest_offdiag : Qop diagTest 0 5 = 0 := by
  have e2 : (![1, 2, 3, 4, 5, 6] : Fin 6 → ℚ) 2 = 3 := rfl
  have e3 : (![1, 2, 3, 4, 5, 6] : Fin 6 → ℚ) 3 = 4 := rfl
  have e4 : (![1, 2, 3, 4, 5, 6] : Fin 6 → ℚ) 4 = 5 := rfl
  have e5 : (![1, 2, 3, 4, 5, 6] : Fin 6 → ℚ) 5 = 6 := rfl
  simp (config := { maxSteps := 4000000 }) only [Qop, sharpMat, sharpQF, toMat4, coord4, basis4, pair4, br, phi, diagTest,
    Matrix.mul_apply, Matrix.single, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.diagonal]
  norm_num [e2, e3, e4, e5, Fin.ext_iff]

end HamiltonsCubic.Base
