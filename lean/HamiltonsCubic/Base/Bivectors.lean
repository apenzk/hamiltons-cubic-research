import Mathlib

/-!
# B1, the base layer, part 1: `Λ²ℝⁿ` and its normalisation

Bivectors are skew-symmetric rational matrices, and the pairing is the one
[findings/conventions.md](../../../findings/conventions.md) fixes:

> **The `½` goes at the `Λ²` level, not the operator level.** The inner product
> is `½ tr(Xᵀ Y)` at the `Λ²` level and plain Frobenius on the pair matrix.
> *Applying the `½` at the operator level instead inflates every `θ` by `√2`.*

That convention is the record's most expensive one, so it is pinned here as a
theorem rather than carried as a comment: `φ_{ij}` is a **unit** bivector, and
`{φ_{ij}}_{i<j}` is orthonormal.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

/-- **`![x, …] 5`, WHICH MATHLIB DOES NOT CARRY.** *It has `Matrix.cons_val_two`, `_three` and
`_four` and stops there, so every index-5 lookup in this layer's `Fin 6` vectors was unreachable by
`simp` and the computations that need one fell back on `native_decide`.* **It is `rfl`**, exactly as
its four predecessors are, and adding it is what let the `ℚ` layer's rational computations be
retired into the kernel on 2026-09-20. -/
theorem cons_val_five {α : Type*} {m : ℕ} (x : α) (u : Fin m.succ.succ.succ.succ.succ → α) :
    Matrix.vecCons x u 5 = Matrix.vecHead (Matrix.vecTail (Matrix.vecTail
      (Matrix.vecTail (Matrix.vecTail u)))) := rfl

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {n : ℕ}

/-- A bivector is a skew-symmetric matrix. -/
def IsSkew (X : Matrix ι ι ℚ) : Prop := Xᵀ = -X

/-- The `Λ²` inner product, `½ tr(Xᵀ Y)`. **The `½` lives here.** -/
def inner2 (X Y : Matrix ι ι ℚ) : ℚ := (1 / 2) * (Xᵀ * Y).trace

/-- The bracket on `𝔰𝔬(n)`. -/
def br (X Y : Matrix ι ι ℚ) : Matrix ι ι ℚ := X * Y - Y * X

/-- The basis bivector `φ_{ij}`, matching `scripts/lib/curvature_operator.py`:
entry `-1` at `(i,j)` and `+1` at `(j,i)`. -/
def phi (i j : ι) : Matrix ι ι ℚ :=
  Matrix.single j i 1 - Matrix.single i j 1

theorem phi_isSkew (i j : ι) : IsSkew (phi i j) := by
  unfold IsSkew phi
  simp [Matrix.transpose_sub, Matrix.transpose_single]

/-- **THE BRACKET OF TWO BIVECTORS IS A BIVECTOR.** *The real layer's `br_mem_skewSub` in
[Bivectors2.lean](Bivectors2.lean) says this on the bundled subtype; the rational layer needed it
on bare matrices and had it nowhere.* -/
theorem br_isSkew {X Y : Matrix ι ι ℚ} (hX : IsSkew X) (hY : IsSkew Y) :
    IsSkew (br X Y) := by
  show Matrix.transpose (br X Y) = -(br X Y)
  unfold br
  rw [Matrix.transpose_sub, Matrix.transpose_mul, Matrix.transpose_mul,
    show Matrix.transpose X = -X from hX, show Matrix.transpose Y = -Y from hY]
  simp [Matrix.neg_mul, Matrix.mul_neg]

theorem phi_swap (i j : ι) : phi j i = -phi i j := by
  unfold phi; abel

/-- **The normalisation, pinned.** `φ_{ij}` is a unit bivector under the
half-trace pairing, the choice every result in the record uses. Under plain
Frobenius the same matrix has norm `2`, and taking that reading inflates every
`θ` by `√2`. -/
theorem inner2_phi_self {i j : ι} (h : i ≠ j) : inner2 (phi i j) (phi i j) = 1 := by
  unfold inner2 phi
  simp [Matrix.transpose_sub, Matrix.transpose_single, Matrix.sub_mul, Matrix.mul_sub,
    Matrix.single_mul_single_same, Matrix.single_mul_single_of_ne, Matrix.trace_sub, Matrix.trace_add, h, Ne.symm h]
  norm_num

set_option maxHeartbeats 2000000 in
-- Sixteen index cases, each an entrywise comparison of two `Λ²` bracket expansions.
/-- **THE STRUCTURE-CONSTANT EXPANSION, AT `ℚ`.** *The real layer has carried this as
`br_phi_phi` in [StructureConstants.lean](StructureConstants.lean) at every `n`, and the rational
layer did not*, *and it is one of the pieces those layers' general-`n` statements need*, the anchor checks in
[Curvature.lean](Curvature.lean) and the row mass in [KillingRow.lean](KillingRow.lean) among them.
**IT IS NOT THE ONLY MISSING PIECE AND A FIRST VERSION OF THIS DOCSTRING SAID IT WAS.** *The
pairing machinery the rational layer was claimed to lack is in [PhiPairing.lean](PhiPairing.lean)
and always was*, `inner2_eq_sum`, `inner2_phi` and the four-index form all present; the claim came
from grepping ONE file and reading the result as a statement about the layer. **What the anchor
still waits on is `sum_inner2_ad2` at `ℚ`**, which [Curvature.lean](Curvature.lean) records.
*The proof here is the real layer's verbatim, no step of it being field-specific.* -/
theorem br_phi_phi (a b c d : ι) :
    br (phi a b) (phi c d) =
      (if a = c then (1:ℚ) else 0) • phi b d + (if b = d then (1:ℚ) else 0) • phi a c
        - (if a = d then (1:ℚ) else 0) • phi b c - (if b = c then (1:ℚ) else 0) • phi a d := by
  ext p q
  simp only [br, phi, Matrix.sub_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.mul_apply,
             Matrix.single_apply, smul_eq_mul, ite_and]
  simp only [Finset.mem_univ, if_true, mul_ite, mul_one, mul_zero, ite_mul, zero_mul, one_mul]
  by_cases hac : a = c <;> by_cases hbd : b = d <;> by_cases had : a = d <;>
    by_cases hbc : b = c <;> simp_all <;> split_ifs <;> simp_all
  all_goals first
    | ring
    | (intro h; simp_all)
    | tauto

/-- Plain Frobenius gives `2` on the same matrix: both numbers are true, of
different pairings, and the record runs on the first. -/
theorem frobenius_phi_self {i j : ι} (h : i ≠ j) : ((phi i j)ᵀ * phi i j).trace = 2 := by
  have := inner2_phi_self h
  unfold inner2 at this
  linarith

end HamiltonsCubic.Base
