import Mathlib

set_option linter.style.longLine false

/-!
# L81, the sharp centraliser criterion, STATED here and PROVED in L81Proof

[isotropy-cap.md](../../../findings/isotropy-cap.md)'s Lemma L81, in the corrected form the audit
settles on, quoted verbatim:

> **The criterion is true**: for every nonzero `x ∈ 𝔰𝔬(m)`, `dim(𝔷(𝔠) ∩ 𝔠^⊥) > 1` **iff `x` is a
> multiple of a rank-`4` complex structure**, failing at `m = 3` and nowhere else, the value being
> always `1` or `3`.
>
> **(a) The sharp hypothesis is `m ≠ 3`.** *Both reviewers independently place the only failure at
> `m = 3`; the criterion holds at `m = 2` as well, so the `m ≥ 4` form is conservative by that one
> case.* *"`p ≥ 2`" misquotes its own only source* […] *And `p` is undefined in this block,
> carrying two readings (the torus rank `⌊m/2⌋` and the support rank `½ rank x`) which are
> different hypotheses.*
>
> **THE SAME GAP AS LEMMA L32.** At `x = e₁₂ ∈ 𝔰𝔬(3)` the centraliser `𝔠` is zero, so
> `dim(𝔷(𝔠) ∩ 𝔠^⊥) = 3 > 1` **while `x` is no rank-`4` complex structure**, `𝔰𝔬(3)` has no
> `4`-plane. **The forward direction of the "iff" fails there.**

Here `𝔠 = 𝔷(x) ∩ x^⊥`, which is [L80](L80Statement.lean)'s `ker N_x` under another name.

## What IS typed here

**The criterion in full**, as `L81` in [L81Proof.lean](L81Proof.lean), with both clauses, the `iff` and
*"the value being always `1` or `3`"*, **proved**.

**The reason `m = 3` is excluded, proved.** `no_rank_four_below_four`: a matrix on `ℝ^m` with
`m < 4` has rank `< 4`, so no `x ∈ 𝔰𝔬(3)` is a multiple of a rank-`4` complex structure and the
forward direction has nothing to land on. This is the structural half of the record's witness.

**`p` is not used.** The audit records `p` as undefined in the block and carrying two
incompatible readings; the hypothesis typed here is the sharp one the audit settles on, `m ≠ 3`,
which mentions no `p` at all.

## How it is proved, elementary rather than root-theoretic

*[SkewNormalForm.lean](SkewNormalForm.lean) gives `x = Σ_j a_j R_j`, `R_j = w_j u_jᵀ - u_j w_jᵀ`,
`{u_j, w_j}` orthonormal, `a_j > 0`, and [SkewCentraliser.lean](SkewCentraliser.lean) carries the
steps below.*

1. **`x ∈ zPerp x`** always, so the dimension is at least `1`.
2. **Torus part of `𝔠`.** `Σ b_j R_j ∈ 𝔠` whenever `Σ a_j b_j = 0`, and `𝔰𝔬(K) ⊆ 𝔠` for
   `K = ker x`.
3. **Blocks.** With `P_j = u_ju_jᵀ + w_jw_jᵀ` and `P_K = 1 - Σ P_j`, write `y_{jk} = P_j y P_k` and split
   it as `C + A`, `C = ½(y_{jk} - R_j y_{jk} R_k)` commuting and `A = ½(y_{jk} + R_j y_{jk} R_k)`
   anticommuting with the rotations. Commuting with `Σ b R` gives `(b_j - b_k) R_j C = 0` and
   `(b_j + b_k) R_j A = 0`.
4. **Upper bound.** `a_j > 0` kills every `C_{jk}`, `j ≠ k`, since `e_j - e_k ∝ a` is impossible; `A_{jk}`
   survives only if `e_j + e_k ∝ a`, rank `4` with `a_1 = a_2`. Diagonal blocks are multiples of `R_j`.
   Kernel blocks die by `𝔰𝔬(K)` at `dim K ≥ 2` and by a torus `b` with `b_j ≠ 0` at `dim K = 1` and rank
   `≥ 4` (L160). Orthogonality to `𝔠` then forces the torus part `∝ x` and `y_{KK} = 0`.
5. **Rank `2`.** The torus part of `𝔠` is zero; `𝔰𝔬(K)` with `dim K = m - 2 ≥ 2` does the work, which is
   where `m ≠ 3` enters (`m = 2` has `K = 0`).
6. **Lower bound in the exception.** The anticommuting `A_{12}` blocks, a 2-dimensional space, commute
   with `𝔠` and are orthogonal to it, giving dimension `3`.

## What is NOT typed here

**The rest of the `m = 3` witness is proved elsewhere.** That `𝔠 = 0` at every nonzero `x ∈ 𝔰𝔬(3)` is
[L160.lean](L160.lean)'s `cc_three`, and `𝔷(𝔠) ∩ 𝔠^⊥ = 𝔰𝔬(3)` of dimension `3` is
[L81Three.lean](L81Three.lean)'s `finrank_eq_three`, which imports this file. This file proves the half
showing `x` is no rank-`4` complex structure.

**The root-theoretic content.** The audit's *"the singular-value vector is proportional to a root
of `D_p`"*, the `B_p` short-root failure at odd `m` the imported proof does not reach, and the
convex-feasibility route both Gate-2 reviewers used instead, are all absent.

**The comparison with [L32](../../../findings/isotropy-cap.md).** The audit refutes *"wider than
L32"* (L32 states this and more) and that comparison is a claim about two blocks rather than a
mathematical statement, so nothing here encodes it.
-/

namespace HamiltonsCubic.L81Statement

open Matrix Module

variable {m : ℕ}

/-- The `Λ²` inner product `⟨X, Y⟩ = ½ tr(Xᵀ Y)`. -/
noncomputable def inner2 (X Y : Matrix (Fin m) (Fin m) ℝ) : ℝ := (1 / 2) * (Xᵀ * Y).trace

/-- The bracket on `𝔰𝔬(m)`. -/
def br (X Y : Matrix (Fin m) (Fin m) ℝ) : Matrix (Fin m) (Fin m) ℝ := X * Y - Y * X

/-- Membership in `𝔰𝔬(m)`. -/
def Skew (X : Matrix (Fin m) (Fin m) ℝ) : Prop := Xᵀ = -X

/-! ## Linearity, so the two subspaces below are subspaces -/

theorem inner2_add_right (X Y Z : Matrix (Fin m) (Fin m) ℝ) :
    inner2 X (Y + Z) = inner2 X Y + inner2 X Z := by
  unfold inner2; rw [Matrix.mul_add, Matrix.trace_add]; ring

theorem inner2_smul_right (c : ℝ) (X Y : Matrix (Fin m) (Fin m) ℝ) :
    inner2 X (c • Y) = c * inner2 X Y := by
  unfold inner2; rw [Matrix.mul_smul, Matrix.trace_smul]; simp [mul_comm, mul_assoc]

theorem inner2_add_left (X Y Z : Matrix (Fin m) (Fin m) ℝ) :
    inner2 (X + Y) Z = inner2 X Z + inner2 Y Z := by
  unfold inner2; rw [Matrix.transpose_add, Matrix.add_mul, Matrix.trace_add]; ring

theorem inner2_smul_left (c : ℝ) (X Y : Matrix (Fin m) (Fin m) ℝ) :
    inner2 (c • X) Y = c * inner2 X Y := by
  unfold inner2; rw [Matrix.transpose_smul, Matrix.smul_mul, Matrix.trace_smul]
  simp [mul_comm, mul_assoc]

theorem br_add_right (X Y Z : Matrix (Fin m) (Fin m) ℝ) :
    br X (Y + Z) = br X Y + br X Z := by unfold br; noncomm_ring

theorem br_smul_right (c : ℝ) (X Y : Matrix (Fin m) (Fin m) ℝ) :
    br X (c • Y) = c • br X Y := by
  unfold br; rw [Matrix.mul_smul, Matrix.smul_mul, smul_sub]

theorem br_add_left (X Y Z : Matrix (Fin m) (Fin m) ℝ) :
    br (X + Y) Z = br X Z + br Y Z := by unfold br; noncomm_ring

theorem br_smul_left (c : ℝ) (X Y : Matrix (Fin m) (Fin m) ℝ) :
    br (c • X) Y = c • br X Y := by
  unfold br; rw [Matrix.smul_mul, Matrix.mul_smul, smul_sub]

/-! ## `𝔠 = 𝔷(x) ∩ x^⊥`, and `𝔷(𝔠) ∩ 𝔠^⊥` -/

/-- **`𝔠 = 𝔷(x) ∩ x^⊥`**, inside `𝔰𝔬(m)`, [L80](L80Statement.lean)'s `ker N_x`. -/
def cc (x : Matrix (Fin m) (Fin m) ℝ) : Submodule ℝ (Matrix (Fin m) (Fin m) ℝ) where
  carrier := {u | Skew u ∧ inner2 x u = 0 ∧ br x u = 0}
  add_mem' := by
    rintro a b ⟨hsa, hia, hba⟩ ⟨hsb, hib, hbb⟩
    refine ⟨?_, ?_, ?_⟩
    · unfold Skew at *; rw [Matrix.transpose_add, hsa, hsb]; abel
    · rw [inner2_add_right, hia, hib]; ring
    · rw [br_add_right, hba, hbb]; abel
  zero_mem' := by
    refine ⟨?_, ?_, ?_⟩
    · unfold Skew; simp
    · unfold inner2; simp
    · unfold br; simp
  smul_mem' := by
    rintro c a ⟨hsa, hia, hba⟩
    refine ⟨?_, ?_, ?_⟩
    · unfold Skew at *; rw [Matrix.transpose_smul, hsa]; module
    · rw [inner2_smul_right, hia]; ring
    · rw [br_smul_right, hba]; simp

/-- **`𝔷(𝔠) ∩ 𝔠^⊥`**, the subspace whose dimension the criterion reads. -/
def zPerp (x : Matrix (Fin m) (Fin m) ℝ) : Submodule ℝ (Matrix (Fin m) (Fin m) ℝ) where
  carrier := {u | Skew u ∧ (∀ w ∈ cc x, br u w = 0) ∧ (∀ w ∈ cc x, inner2 u w = 0)}
  add_mem' := by
    rintro a b ⟨hsa, hza, hpa⟩ ⟨hsb, hzb, hpb⟩
    refine ⟨?_, ?_, ?_⟩
    · unfold Skew at *; rw [Matrix.transpose_add, hsa, hsb]; abel
    · intro w hw; rw [br_add_left, hza w hw, hzb w hw]; abel
    · intro w hw; rw [inner2_add_left, hpa w hw, hpb w hw]; ring
  zero_mem' := by
    refine ⟨?_, ?_, ?_⟩
    · unfold Skew; simp
    · intro w _; unfold br; simp
    · intro w _; unfold inner2; simp
  smul_mem' := by
    rintro c a ⟨hsa, hza, hpa⟩
    refine ⟨?_, ?_, ?_⟩
    · unfold Skew at *; rw [Matrix.transpose_smul, hsa]; module
    · intro w hw; rw [br_smul_left, hza w hw]; simp
    · intro w hw; rw [inner2_smul_left, hpa w hw]; ring

/-! ## Rank-`4` complex structures -/

/-- **A rank-`4` complex structure**: a skew `J` with `J³ = -J`, so `J` is an orthogonal complex
structure on its support and zero off it, of rank exactly `4`. -/
def RankFourComplexStructure (J : Matrix (Fin m) (Fin m) ℝ) : Prop :=
  Skew J ∧ J * J * J = -J ∧ J.rank = 4

/-- `x` is a multiple of one. -/
def MultipleOfRankFour (x : Matrix (Fin m) (Fin m) ℝ) : Prop :=
  ∃ (c : ℝ) (J : Matrix (Fin m) (Fin m) ℝ), c ≠ 0 ∧ RankFourComplexStructure J ∧ x = c • J

/-- **Why `m = 3` is excluded, structurally**: a matrix on `ℝ^m` has rank at most `m`, so at
`m < 4` nothing is a rank-`4` complex structure and the criterion's right-hand side is empty
while its left-hand side is not, the record's `x = φ₀₁ ∈ 𝔰𝔬(3)`, where the dimension is `3`
([L81Three.lean](L81Three.lean)'s `finrank_eq_three`). -/
theorem no_rank_four_below_four (hm : m < 4) (J : Matrix (Fin m) (Fin m) ℝ) :
    ¬ RankFourComplexStructure J := by
  rintro ⟨-, -, hrank⟩
  have hle : J.rank ≤ m := by
    simpa using J.rank_le_card_width
  omega

/-- Hence no element of `𝔰𝔬(3)` is a multiple of a rank-`4` complex structure. -/
theorem no_multiple_in_so_three (x : Matrix (Fin 3) (Fin 3) ℝ) : ¬ MultipleOfRankFour x := by
  rintro ⟨c, J, -, hJ, -⟩
  exact no_rank_four_below_four (by norm_num) J hJ

/-! ## The statement -/

/-! ## The statement

**`L81` itself is stated and proved in [L81Proof.lean](L81Proof.lean)**, in this namespace, because its
proof runs through [SkewCentraliser.lean](SkewCentraliser.lean), which imports the definitions above. -/

end HamiltonsCubic.L81Statement
