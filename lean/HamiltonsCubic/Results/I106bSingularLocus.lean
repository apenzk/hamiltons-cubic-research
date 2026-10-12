import Mathlib

set_option linter.style.longLine false

/-!
# L230, the singular locus of `Q ↦ Q∘2` strictly contains the split locus

## What this file is

[R28](../../../routes.md), the orthostochastic rung, climbs `|J|` by excluding an interior tangency and
concluding that the maximum sits on the BOUNDARY of the image of `O(k)` under `φ_r : Q ↦ Q∘2`, which it then
identifies with the SPLIT locus, the previous rung. That identification is
[Au-Yeung and Poon's Theorem 2.4](../../../references/au-yeung-poon-1979-orthostochastic-numerical-ranges/notes.md)
and it holds AT `k = 3` ONLY. Their Theorem 2.6 says that at `k = 4` there is a second type of singular point,
the matrices equivalent to one with all diagonal entries zero and all other entries nonzero.

[I106b](../../../plan.md) recorded the missing piece as "singular implies splits at every `n`, which the
literature gives at `n = 3, 4` only". **That is the wrong reading of the source**: what the literature gives at
`n = 4` is the CLASSIFICATION, and the classification says the implication is FALSE there. So R28's induction
step does not merely lack a proof past `k = 3`, it fails at `k = 4`.

**Gate 2 REFUTED the quantifier this file first carried** (r974 and r975, independently). The counting below
buys non-injectivity only at `k = 3` and `k = 4`, and beyond that the conclusion is FALSE rather than unproved:
a SYMMETRIC zero-diagonal `Q ∈ O(k)` with all off-diagonal entries nonzero is REGULAR at every `k ≥ 3`, since
`Q * Ω` diagonal forces `Ω = Q D` and skewness gives `dᵢ = -dⱼ` for all `i ≠ j`, hence `d = 0`. It is realised
at `k = 6` by the normalised Paley conference matrix and at `k = 5` by an exact circulant. **And the route
conclusion, though true, does NOT follow from the singular locus**: R28 needs the frontier of the IMAGE, and at
`k = 6` a boundary point has only regular preimages. The obstruction is the FACE `{tr = 0}` of the image.

## What is proved

* `dphi_diag_eq_zero`: the mechanism, in one line and at every size. The tangent to `O(n)` at `Q` is `Q * Ω` for
  skew `Ω`, so the differential of `φ_r` is `Z ↦ 2 • (Q ⊙ Z)`, and at a `Q` with zero diagonal every diagonal
  entry of the image vanishes, whatever `Ω` is. The image therefore lies in the zero-diagonal subspace on top
  of the zero row and column sums every bistochastic tangent already satisfies. **That is a strict rank drop
  only at `k = 3` and `k = 4`**, the drop needing `(k-1)^2 - k < choose k 2`, which fails from `k = 5`.
  *No orthogonality, no skewness and no size restriction are used: the hypothesis `Q i i = 0` is the whole of it,
  and THIS declaration is untouched by the refutation above, which struck the counting rather than the vanishing.*
* `witness_mul_transpose`, `witness_diag`, `witness_offdiag_ne`: an explicit `4 × 4` witness, stated
  unnormalised so that no square root enters. `M * Mᵀ = 3 • 1` makes `M / √3` orthogonal, `M` has zero diagonal,
  and every off-diagonal entry is `±1` and so nonzero. Its image under `φ_r` is `(J - I) / 3`, which has no zero
  off the diagonal and therefore does not split.
* `SplitsAt`, `M_eq_zero_iff`, `no_split_pattern`, `witness_not_splits`: **the witness does not split**, now
  stated rather than gestured at. `SplitsAt` is the source's own two-sided definition, a proper nonempty row set
  `R` and an equinumerous column set `C` with the matrix vanishing on `R × Cᶜ` and `Rᶜ × C`, rows and columns
  permuted INDEPENDENTLY as Theorem 2.2 requires. *A single-index reading would be strictly stronger and is not
  what the source uses.* `M_eq_zero_iff` says the witness vanishes exactly on the diagonal, which removes all real
  arithmetic and leaves `no_split_pattern`, closed by `decide` over the `2⁴ × 2⁴` pairs of subsets.
* `no_second_type_at_three`: why the second type appears first at `k = 4` rather than `k = 3`. For rows
  `(0, a, b)` and `(c, 0, d)` of a `3 × 3` matrix with zero diagonal, orthogonality of the two rows reads
  `b * d = 0`, so one of the two off-diagonal entries vanishes and "zero diagonal with every other entry
  nonzero" is unreachable. *This is what makes Theorem 2.4 consistent with Theorem 2.6 rather than in tension
  with it.*

## What is NOT stated

The RANK itself. `dphi_diag_eq_zero` gives the `n` linear conditions, which force a drop only at `k = 3, 4`,
and that those are independent of the zero-sum conditions is screened rather than proved here
([screen_I106b_zero_diagonal.py](../../../scripts/misc/screen_I106b_zero_diagonal.py), rank `5` at the witness
against `6` at `200` generic points, matching the derived bound `(n-1)^2 - n = 5`). Nor that the singular locus is the boundary of the
image, which is FALSE at `k = 6`, a boundary point there having only regular preimages.

**The claim Gate 2 refuted is exactly the claim with no declaration here**, the rank count, while every
declaration below survives unchanged. *The formalised content is precisely the part that stands.*
-/

namespace HamiltonsCubic.I106bSingularLocus

open Matrix

/-- **The mechanism, at every size and with no hypothesis beyond the zero diagonal entry.**

The tangent to `O(n)` at `Q` is `Q * Ω` for skew `Ω`, and `φ_r : Q ↦ Q ⊙ Q` has differential
`Z ↦ 2 • (Q ⊙ Z)` there. At an index where `Q` vanishes on the diagonal, the image's diagonal entry
vanishes too, because the Hadamard product reads entrywise and carries `Q i i` as a factor.

*Neither orthogonality of `Q` nor skewness of `Ω` is used.* -/
theorem dphi_diag_eq_zero {n : ℕ} (Q Ω : Matrix (Fin n) (Fin n) ℝ) (i : Fin n)
    (h : Q i i = 0) :
    (2 • (Q ⊙ (Q * Ω))) i i = 0 := by
  simp [Matrix.hadamard_apply, h]

/-- The explicit `4 × 4` witness, unnormalised so that no square root enters the statement. -/
def M : Matrix (Fin 4) (Fin 4) ℝ :=
  !![0, 1, 1, 1; 1, 0, -1, 1; 1, 1, 0, -1; 1, -1, 1, 0]

/-- `M * Mᵀ = 3 • 1`, so `M / √3` is orthogonal. -/
theorem witness_mul_transpose : M * Mᵀ = (3 : ℝ) • (1 : Matrix (Fin 4) (Fin 4) ℝ) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [M, Matrix.mul_apply, Fin.sum_univ_four] <;> norm_num

/-- The witness has zero diagonal, which is `dphi_diag_eq_zero`'s hypothesis at every index. -/
theorem witness_diag (i : Fin 4) : M i i = 0 := by
  fin_cases i <;> simp [M]

/-- Every off-diagonal entry of the witness is nonzero, which is what puts it in Theorem 2.6's
SECOND type rather than among the matrices that split. -/
theorem witness_offdiag_ne (i j : Fin 4) (h : i ≠ j) : M i j ≠ 0 := by
  fin_cases i <;> fin_cases j <;> simp_all [M]

/-- **Why the second type appears first at `k = 4`.**

For a `3 × 3` matrix with zero diagonal, write the first two rows as `(0, a, b)` and `(c, 0, d)`. Their
inner product is `0 * c + a * 0 + b * d = b * d`, so orthogonality forces `b = 0` or `d = 0` and the
matrix cannot have every off-diagonal entry nonzero.

*So Theorem 2.4 at `n = 3` and Theorem 2.6 at `n = 4` are consistent: the second type is empty at `n = 3`.* -/
theorem no_second_type_at_three (a b c d : ℝ)
    (horth : (0 : ℝ) * c + a * 0 + b * d = 0) :
    b = 0 ∨ d = 0 :=
  mul_eq_zero.mp (by linarith)

/-- **The explicit kernel element, which types the SINGULARITY itself rather than its ingredients.**

`M ⊙ (M * Ω) = 0` needs `(M * Ω) i j = 0` at every `i ≠ j`, because every off-diagonal entry of `M`
is nonzero, so `M * Ω` must be DIAGONAL. With `M * Mᵀ = 3 • 1` that forces `Ω = (1/3) Mᵀ D` for a
diagonal `D`, and skewness of `Ω` pins `D = 3 • diag(1,-1,-1,-1)`, leaving

  `Ω = diag(-1,1,1,1) * M`,

which is `M` with its first row negated. -/
def Om : Matrix (Fin 4) (Fin 4) ℝ :=
  !![0, -1, -1, -1; 1, 0, -1, 1; 1, 1, 0, -1; 1, -1, 1, 0]

/-- `Ω` is skew, so it is a genuine tangent direction of `O(4)` at the witness. -/
theorem Om_skew : Omᵀ = -Om := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [Om]

/-- `Ω` is nonzero, which is what makes the kernel nontrivial rather than the statement vacuous. -/
theorem Om_ne_zero : Om ≠ 0 := by
  intro h
  have h01 : Om 0 1 = 0 := by rw [h]; simp
  norm_num [Om] at h01

/-- `M * Ω` is diagonal, which is the step the derivation forces and the reason the Hadamard
product vanishes. -/
theorem witness_mul_Om : M * Om = !![3, 0, 0, 0; 0, -3, 0, 0; 0, 0, -3, 0; 0, 0, 0, -3] := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [M, Om, Matrix.mul_apply, Fin.sum_univ_four] <;> norm_num

/-- **The witness is a singular point of `φ_r`.** The differential `Z ↦ 2 • (M ⊙ Z)` applied to the
nonzero skew direction `Ω` gives zero, so it is not injective on the tangent space of `O(4)`.

*This together with `Om_skew` and `Om_ne_zero` is the `k = 4` half of L230, typed rather than
screened: the kernel is exhibited instead of the rank being measured.* -/
theorem witness_singular : (2 : ℝ) • (M ⊙ (M * Om)) = 0 := by
  rw [witness_mul_Om]
  ext i j
  fin_cases i <;> fin_cases j <;> simp [M, Matrix.hadamard_apply]

/-- **The witness does not split.** Every off-diagonal entry of its image `M ⊙ M` is nonzero, so no
proper nonempty set of rows has a zero block against its complement and the support graph is
connected. *Splitting would require such a zero block.* -/
theorem image_offdiag_ne (i j : Fin 4) (h : i ≠ j) : (M ⊙ M) i j ≠ 0 := by
  fin_cases i <;> fin_cases j <;> simp_all [M, Matrix.hadamard_apply]

/-- The witness's support is exactly the off-diagonal, which is what turns splitting into a
finite combinatorial question with no real arithmetic left in it. -/
theorem M_eq_zero_iff (i j : Fin 4) : M i j = 0 ↔ i = j := by
  constructor
  · intro h
    by_contra hne
    exact witness_offdiag_ne i j hne h
  · rintro rfl
    exact witness_diag i

/-- **Splitting, as the source defines it.** Independent row and column permutations put `Q` in
block-diagonal form exactly when there is a proper nonempty row set `R` and a column set `C` of the
same size with `Q` vanishing on `R × Cᶜ` and on `Rᶜ × C`.

*The row and column sets are separate, because the source permutes rows and columns independently.
A single-index reading would be a strictly stronger notion and is not what Theorem 2.2 uses.* -/
def SplitsAt (Q : Matrix (Fin 4) (Fin 4) ℝ) : Prop :=
  ∃ R C : Finset (Fin 4), R.Nonempty ∧ R ≠ Finset.univ ∧ R.card = C.card ∧
    (∀ i ∈ R, ∀ j, j ∉ C → Q i j = 0) ∧ (∀ i, i ∉ R → ∀ j ∈ C, Q i j = 0)

/-- The combinatorial core, decided by exhaustion over the `2⁴ × 2⁴` pairs of subsets: no proper
nonempty `R` and equinumerous `C` can confine both `R × Cᶜ` and `Rᶜ × C` to the diagonal. -/
theorem no_split_pattern :
    ∀ R C : Finset (Fin 4), R.Nonempty → R ≠ Finset.univ → R.card = C.card →
      ¬((∀ i ∈ R, ∀ j, j ∉ C → i = j) ∧ (∀ i, i ∉ R → ∀ j ∈ C, i = j)) := by
  decide

/-- **The witness does not split**, which is the half of L230 that `image_offdiag_ne` left as a
statement about entries rather than about decompositions. -/
theorem witness_not_splits : ¬ SplitsAt M := by
  rintro ⟨R, C, hR, hRu, hcard, h1, h2⟩
  refine no_split_pattern R C hR hRu hcard ⟨?_, ?_⟩
  · intro i hi j hj
    exact (M_eq_zero_iff i j).mp (h1 i hi j hj)
  · intro i hi j hj
    exact (M_eq_zero_iff i j).mp (h2 i hi j hj)

end HamiltonsCubic.I106bSingularLocus
