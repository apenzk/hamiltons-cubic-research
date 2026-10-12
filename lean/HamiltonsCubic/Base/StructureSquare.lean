import HamiltonsCubic.Base.StructureConstants

/-!
# `T` by its definition, so a bound about it cannot treat it as opaque

**Why this file exists.** The record's `T_{αβγ} = ⟨[v_α,v_β],v_γ⟩²` is the squared structure
constant in an eigenbasis, and every bound the programme states about it is stated about a
NONNEGATIVE SYMMETRIC MATRIX WITH BOUNDED ROW SUMS. *That description is true and strictly weaker
than `T`.* **`T` is also HOLLOW**: `c` is totally antisymmetric, so `T` vanishes whenever two of its
three indices agree, and the matrix `T⁽ᵏ⁾_{αγ} = T_{αkγ}` therefore has zero row `k`, zero column `k`
and zero diagonal.

**A block that reached for the abstract description lost exactly that**, bounding a quadratic form by
`2‖λ‖²` where the truth is `2(1-λ_k²)`, the difference between `θ ≤ λ_max + 1/λ_max`, whose ceiling
is `2`, and `θ ≤ 1/λ_max`, which is `√(3/2)` exactly at padded `W_ℂP²`. *Two reviewers found it
independently.* **So the definition and its vanishing live here, in the base layer, where anything
stating a bound about `T` has them in scope.**
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.RealLayer

open Matrix Finset

variable {ι κ : Type*} [Fintype ι] [DecidableEq ι] [Fintype κ] [DecidableEq κ]

/-- **The structure constant of a family of bivectors**, `c_{abc} = ⟨[v_a, v_b], v_c⟩`. -/
noncomputable def sConst (v : κ → Matrix ι ι ℝ) (a b c : κ) : ℝ := inner2 (br (v a) (v b)) (v c)

/-- **Its square, the record's `T`.** *Nonnegative by construction, which is the half every bound
uses, and HOLLOW, which is the half they drop.* -/
noncomputable def tSq (v : κ → Matrix ι ι ℝ) (a b c : κ) : ℝ := sConst v a b c ^ 2

theorem tSq_nonneg (v : κ → Matrix ι ι ℝ) (a b c : κ) : 0 ≤ tSq v a b c := sq_nonneg _

/-- `[x, x] = 0`, which is where every vanishing below comes from. -/
theorem br_self (X : Matrix ι ι ℝ) : br X X = 0 := by
  simp [br]

/-- **`T` vanishes when its first two indices agree.** -/
theorem tSq_first_eq (v : κ → Matrix ι ι ℝ) (a c : κ) : tSq v a a c = 0 := by
  simp [tSq, sConst, br_self, inner2]

/-- `tr([a,b]·a) = 0`, by cyclicity of the trace and nothing else. -/
theorem trace_br_mul_self (a b : Matrix ι ι ℝ) : (br a b * a).trace = 0 := by
  simp only [br, Matrix.sub_mul, Matrix.trace_sub, Matrix.mul_assoc]
  rw [Matrix.trace_mul_comm a (b * a), ← Matrix.mul_assoc]
  simp [Matrix.mul_assoc]

/-- **`T` vanishes when its outer indices agree**, so `T⁽ᵏ⁾` has zero DIAGONAL.

*This is the one the abstract description loses, and it is what turns `2‖λ‖²` into `2(1-λ_k²)`.*
**Skewness enters only through the transpose**; the vanishing itself is cyclicity of the trace. -/
theorem tSq_outer_eq (v : κ → Matrix ι ι ℝ) (a b : κ) (hskew : ∀ x, IsSkew (v x)) :
    tSq v a b a = 0 := by
  have hT : (br (v a) (v b))ᵀ = - br (v a) (v b) := by
    have ha := hskew a
    have hb := hskew b
    simp only [br, Matrix.transpose_sub, Matrix.transpose_mul]
    rw [show (v a)ᵀ = -(v a) from ha, show (v b)ᵀ = -(v b) from hb]
    simp [Matrix.mul_neg]
  have : sConst v a b a = 0 := by
    simp only [sConst, inner2, hT, Matrix.neg_mul, Matrix.trace_neg, trace_br_mul_self]
    ring
  simp [tSq, this]

end HamiltonsCubic.RealLayer
