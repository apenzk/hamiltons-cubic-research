import Mathlib

set_option linter.style.longLine false

/-!
# L88, `dim Sym² = 65`, `dim Λ² = 24`, and the `24` are gauge

[sym3-blocks.md](../../../findings/sym3-blocks.md)'s Lemma L88, quoted verbatim:

> `dim Sym²(Sym³𝒲₅)^{O(5)} = 65`, `dim Λ²(Sym³𝒲₅)^{O(5)} = 24`, `65 + 24 = 89`,
>
> and those are exactly `∑ m(m+1)/2`, `∑ m(m-1)/2` and `∑ m²` on the measured multiplicities,
> twelve blocks with `m = 1`, nine with `m = 2`, one with `m = 3`, two with `m = 4`. **So the
> `24` directions a Hermitian ansatz offers beyond the `65` are genuine `O(5)`-invariants, of
> `Λ²`. An antisymmetric form contributes nothing to a quadratic, hence nothing to the sextic, and
> they are gauge.**

with the audit's four corrections, each of which is typed below:

> **ALL THREE NUMBERS ARE HAND-DERIVABLE IN SIX LINES AND NO RUN IS NEEDED.** Schur plus real type
> gives `Sym²(U)^{O(5)} = ⊕ Sym² M_λ` and `Λ²(U)^{O(5)} = ⊕ Λ² M_λ`.
>
> **`65 + 24 = 89` CARRIES ZERO INFORMATION.** It is the termwise identity
> `C(m+1,2) + C(m,2) = m²`, **true of any multiplicity list**, so it cannot catch an error.
>
> **"GAUGE" IS HALF-DERIVED.** True for the Gram-to-sextic map, which the block gives; **false for
> the PSD cone**, `S = I₂` with `A = [[0,2],[-2,0]]` has `spec(S + iA) = {-1,3}`, so the fibres
> are bounded, not free.
>
> **THE TWO `24`s COLLIDE BY ACCIDENT.** [L83](L83.lean)'s is `∑ m⁰`, this one is `∑ C(m,2)`; they
> agree because `∑ (m-2)(m+1) = 0` here, **with no structural reason**.

## What is NOT typed here

**The three dimensions themselves, and the Schur step that produces them.** `𝒲₅`, `Sym³𝒲₅`, the
`O(5)`-action and the isotypic decomposition are not constructed in this file, so the equalities
`dim Sym²(Sym³𝒲₅)^{O(5)} = 65` and `dim Λ²(Sym³𝒲₅)^{O(5)} = 24` are **not** stated as facts about
those spaces. What is typed is the arithmetic the record says those numbers *are*, the three
sums over the measured multiplicity table, and the gauge clause, in full.

**The multiplicity table is a measurement, imported as data.** `table` below is the record's
*"twelve blocks with `m = 1`, nine with `m = 2`, one with `m = 3`, two with `m = 4`"*, and this
file does not derive it; [L83](L83.lean) carries the block census it comes from.

**The transport to `47 = 36 + 11`.** The audit's headline, that the orbit-restricted counts are
the same theorem through [L86](../../../findings/sym3-blocks.md)'s parity rule and
[L87](../../../findings/sym3-blocks.md)'s rank-one step, needs those two lemmas and is absent.
[L88.lean](L88.lean) already does the restricted arithmetic.
-/

namespace HamiltonsCubic.L88Statement

open Matrix

/-! ## The measured multiplicity table

A pair `(m, c)` reads *`c` blocks of multiplicity `m`*. -/

/-- The record's measured multiplicities: twelve blocks with `m = 1`, nine with `m = 2`, one with
`m = 3`, two with `m = 4`. -/
def table : List (ℕ × ℕ) := [(1, 12), (2, 9), (3, 1), (4, 2)]

/-- `∑ C(m+1,2)`, the real symmetric count. -/
def symCount (t : List (ℕ × ℕ)) : ℕ := (t.map (fun p => p.2 * Nat.choose (p.1 + 1) 2)).sum

/-- `∑ C(m,2)`, the antisymmetric count. -/
def altCount (t : List (ℕ × ℕ)) : ℕ := (t.map (fun p => p.2 * Nat.choose p.1 2)).sum

/-- `∑ m²`, the Hermitian count. -/
def hermCount (t : List (ℕ × ℕ)) : ℕ := (t.map (fun p => p.2 * p.1 ^ 2)).sum

/-- `∑ m⁰`, the block count, which is [L83](L83.lean)'s `24`. -/
def blockCount (t : List (ℕ × ℕ)) : ℕ := (t.map (fun p => p.2)).sum

/-! ## The three numbers -/

/-- **`∑ C(m+1,2) = 65`** on the measured table. -/
theorem symCount_table : symCount table = 65 := by decide

/-- **`∑ C(m,2) = 24`** on the measured table. -/
theorem altCount_table : altCount table = 24 := by decide

/-- **`∑ m² = 89`** on the measured table. -/
theorem hermCount_table : hermCount table = 89 := by decide

/-- **`65 + 24 = 89`.** -/
theorem sum_table : symCount table + altCount table = hermCount table := by decide

/-! ## And that sum carries zero information -/

/-- **The termwise identity `C(m+1,2) + C(m,2) = m²`**, at every `m`. -/
theorem choose_identity (m : ℕ) : Nat.choose (m + 1) 2 + Nat.choose m 2 = m ^ 2 := by
  induction m with
  | zero => decide
  | succ k ih =>
      have e1 : Nat.choose (k + 1 + 1) 2 = (k + 1) + Nat.choose (k + 1) 2 := by
        rw [Nat.choose_succ_succ (k + 1) 1]; simp
      have e2 : Nat.choose (k + 1) 2 = k + Nat.choose k 2 := by
        rw [Nat.choose_succ_succ k 1]; simp
      have hsq : (k + 1) ^ 2 = k ^ 2 + 2 * k + 1 := by ring
      rw [hsq, e1, e2]
      rw [e2] at ih
      generalize k ^ 2 = s at ih ⊢
      omega

/-- **So `65 + 24 = 89` holds of *any* multiplicity list**, and cannot catch an error in this
one. This is the audit's *"two moments and a tautology, not three facts"*. -/
theorem sum_carries_no_information (t : List (ℕ × ℕ)) :
    symCount t + altCount t = hermCount t := by
  induction t with
  | nil => rfl
  | cons p t ih =>
      simp only [symCount, altCount, hermCount, List.map_cons, List.sum_cons] at *
      have := choose_identity p.1
      nlinarith [this, ih]

/-! ## The two `24`s collide by accident

[L83](L83.lean)'s `24` is the number of blocks, `∑ m⁰`; this file's is `∑ C(m,2)`. They agree
here because `∑ (m-2)(m+1) = 0` on this table, an accident of the multiplicities, with no
structural reason, and the difference is computed over `ℤ` because the factor is negative at
`m = 1`. -/

/-- The collision, and the exact quantity that makes it happen. -/
theorem collision :
    blockCount table = altCount table ∧
      ((table.map (fun p => (p.2 : ℤ) * ((p.1 : ℤ) - 2) * ((p.1 : ℤ) + 1))).sum = 0) := by
  constructor
  · decide
  · decide

/-- **The collision is not an identity.** A table of one block of multiplicity `3` separates the
two counts, so their agreement above says nothing about either. -/
theorem collision_is_accidental :
    blockCount [(3, 1)] ≠ altCount [(3, 1)] := by decide

/-! ## The gauge clause, the half that is true

An antisymmetric bilinear form has identically zero associated quadratic form, so the `Λ²`
directions cannot move the sextic a Gram produces. -/

variable {M : Type*} [AddCommGroup M] [Module ℝ M]

/-- **"An antisymmetric form contributes nothing to a quadratic."** -/
theorem alt_quadratic_zero (B : M →ₗ[ℝ] M →ₗ[ℝ] ℝ) (halt : ∀ x y, B x y = - B y x) (x : M) :
    B x x = 0 := by
  have h := halt x x
  linarith

/-- **Hence two Grams differing by an antisymmetric form have the same quadratic form**, which is
the record's *"hence nothing to the sextic"* at the level the block argues it. -/
theorem gauge_direction (B A : M →ₗ[ℝ] M →ₗ[ℝ] ℝ) (halt : ∀ x y, A x y = - A y x) (x : M) :
    (B + A) x x = B x x := by
  simp [alt_quadratic_zero A halt x]

/-! ## The gauge clause, the half that is false

The audit's witness: on the PSD cone the antisymmetric directions are **not** free. With
`S = I₂` and `A = [[0,2],[-2,0]]`, the Hermitian matrix `S + iA` has determinant `-3`, hence a
negative eigenvalue, so it leaves the cone, the fibres are bounded, not free. -/

/-- `S + iA` for the audit's witness. -/
noncomputable def witness : Matrix (Fin 2) (Fin 2) ℂ :=
  Matrix.of ![![1, 2 * Complex.I], ![-2 * Complex.I, 1]]

/-- **The witness is Hermitian**, so it is a legitimate point of the Hermitian ansatz. -/
theorem witness_isHermitian : witness.IsHermitian := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [witness, Matrix.conjTranspose_apply]

/-- **And its determinant is `-3`**, which is the record's `spec = {-1, 3}` read as a product. -/
theorem witness_det : witness.det = -3 := by
  rw [Matrix.det_fin_two]
  simp only [witness, Matrix.of_apply, Matrix.cons_val', Matrix.cons_val_zero, Matrix.cons_val_one,
    Matrix.head_cons]
  have : Complex.I * Complex.I = -1 := Complex.I_mul_I
  ring_nf
  rw [show Complex.I ^ 2 = -1 by simp [pow_two, this]]
  ring

/-- **The negative eigenvalue, exhibited.** `(-i, 1)` is an eigenvector of `S + iA` at `-1`, so
the antisymmetric direction leaves the PSD cone: the `Λ²` direction that is free for the
Gram-to-sextic map is bounded on the cone. -/
theorem witness_eigen_neg :
    witness *ᵥ ![-Complex.I, 1] = -(![-Complex.I, 1] : Fin 2 → ℂ) := by
  funext i
  fin_cases i <;>
    simp [witness, Matrix.mulVec, dotProduct, Fin.sum_univ_two, Complex.ext_iff] <;> ring_nf

/-- **And the other eigenvalue is `3`**, at `(i, 1)`, together these are the record's
`spec(S + iA) = {-1, 3}`. -/
theorem witness_eigen_pos :
    witness *ᵥ ![Complex.I, 1] = (3 : ℂ) • (![Complex.I, 1] : Fin 2 → ℂ) := by
  funext i
  fin_cases i <;>
    simp [witness, Matrix.mulVec, dotProduct, Fin.sum_univ_two, Complex.ext_iff] <;> ring_nf

end HamiltonsCubic.L88Statement
