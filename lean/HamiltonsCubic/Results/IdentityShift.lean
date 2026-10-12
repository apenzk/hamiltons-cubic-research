import HamiltonsCubic.Base.StructureConstants

/-!
# The identity on `Λ²` has Ricci `(n-1)·Id`, which is what shifts a census off zero

**Why this file exists.** The two-negative stratum's chain overshoots `√(3/2)` by a fraction of a
percent, and the configuration where it overshoots pushes `σ₂²/p₂` to its Cauchy–Schwarz ceiling.
*Equality there forces every non-top positive eigenvalue equal*, so the tensor is `μ·Id_{Λ²}` plus a
correction of rank at most four, and its Ricci condition becomes an identity with `Id_{Λ²}`'s own
Ricci on the right instead of zero.

**That constant is what this file proves**: summing `ω ωᵀ` over the basis `φᵢⱼ` of `Λ²` returns
`2(n-1)` times the identity on `ℝⁿ`, the `2` being the ordered-pair doubling the record's `inner2`
carries. *The record used the count "about 63 of 66 eigenvalues positive" where the equality case
gives a structure, and this is the constant that structure is stated against.*

**The diagonal is what fixes `n-1` rather than `n`**, `φᵢᵢ` being `0`, and it is carried here by an
unconditional identity with a correction term rather than by a case split on `i = j`.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.RealLayer

open Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`φᵢⱼ φᵢⱼᵀ = Eᵢᵢ + Eⱼⱼ - [i = j]·2Eᵢᵢ`, at every pair.** *The correction makes the identity
unconditional: at `i = j` both sides are `0`, `φᵢᵢ` being `0`.* -/
theorem phi_mul_transpose (i j : ι) :
    phi i j * (phi i j)ᵀ
      = Matrix.single i i (1 : ℝ) + Matrix.single j j (1 : ℝ)
        - (if i = j then (2 : ℝ) • Matrix.single i i (1 : ℝ) else 0) := by
  ext a b
  by_cases hij : i = j
  · subst hij
    simp [phi, Matrix.mul_apply, Matrix.single_apply, Matrix.transpose_apply, ite_and,
      Matrix.sub_apply, Matrix.add_apply, Matrix.smul_apply, mul_sub, sub_mul, mul_ite, ite_mul,
      Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.sum_ite_eq']
    by_cases hab : a = b <;> simp_all <;> first | (split_ifs <;> ring) | ring | aesop
  · simp [phi, Matrix.mul_apply, Matrix.single_apply, Matrix.transpose_apply, ite_and,
      Matrix.sub_apply, Matrix.add_apply, hij, mul_sub, sub_mul, mul_ite, ite_mul,
      Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.sum_ite_eq']
    by_cases hab : a = b <;> simp_all [hij] <;> aesop

/-- `∑ⱼ Eⱼⱼ = Id`. -/
theorem sum_single_diag : ∑ j : ι, Matrix.single j j (1 : ℝ) = (1 : Matrix ι ι ℝ) := by
  ext a b
  simp [Matrix.sum_apply, Matrix.single_apply, Matrix.one_apply, ite_and, Finset.sum_ite_eq]

/-- **`∑ᵢⱼ φᵢⱼ φᵢⱼᵀ = 2(n-1)·Id`.** *The sum runs over ORDERED pairs, which is the doubling the
record's `inner2 X Y = ½tr(XᵀY)` carries, so the constant reads `2(n-1)` here and `(n-1)` against a
basis indexed by unordered pairs.* -/
theorem sum_phi_mul_transpose :
    ∑ i : ι, ∑ j : ι, phi i j * (phi i j)ᵀ
      = (2 * ((Fintype.card ι : ℝ) - 1)) • (1 : Matrix ι ι ℝ) := by
  ext a b
  simp only [Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul, Matrix.one_apply,
    phi_mul_transpose, Matrix.sub_apply, Matrix.add_apply, Matrix.single_apply,
    apply_ite (fun M : Matrix ι ι ℝ => M a b), Matrix.zero_apply, Matrix.smul_apply,
    smul_eq_mul, ite_and]
  by_cases hab : a = b
  · subst hab
    have hnest : ∀ x : ι, (if x = a then (if x = a then (1 : ℝ) else 0) else 0)
        = (if x = a then 1 else 0) := by
      intro x; split_ifs <;> rfl
    simp only [if_pos rfl, hnest, Finset.sum_sub_distrib, Finset.sum_add_distrib,
      mul_ite, ite_mul, mul_zero, zero_mul, mul_one, one_mul,
      Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true,
      Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
    push_cast
    ring
  · have hz : ∀ x : ι, (if x = a then (if x = b then (1 : ℝ) else 0) else 0) = 0 := by
      intro x
      split_ifs with h1 h2
      · exact absurd (h1.symm.trans h2) hab
      all_goals rfl
    simp [hz, hab]

end HamiltonsCubic.RealLayer
