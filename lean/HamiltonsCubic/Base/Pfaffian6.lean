import HamiltonsCubic.Base.SelfDual

/-!
# The Pfaffian on `Λ²ℝ⁶`, and the trilinear form the wedge is

**Why this file exists.** [L192](../Results/L192Statement.lean) says both Weyl conditions read on
the span of a rank-three tensor as harmonicity for one weighted Laplacian, and its second half needs
the Pfaffian of a `2`-form on `ℝ⁶`. *The layer carried `levi6`, `star6` and the wedge and stopped
short of the Pfaffian*, so that half was recorded as a debt rather than typed, and a reviewer had to
check by hand what the kernel could have checked.

**`triple6` is the trilinear contraction against `levi6`**, which is `(α ∧ β ∧ γ)/vol` up to the
normalisation fixed here, and `pf6 X = triple6 X X X` is the Pfaffian at the standard `1/48`:
`Pf = (2^m m!)⁻¹ ∑ sgn ∏` reads `1/48` at `m = 3`.

*Trilinearity is what the second-difference identity needs and is all this file proves about it.*
**Symmetry of `triple6` in its three slots is TRUE and NOT proved here**, it is an even permutation
of `levi6`'s six slots, and the statements below are written so that none of them assumes it.
-/

set_option linter.style.longLine false
set_option maxHeartbeats 1000000

namespace HamiltonsCubic.SelfDualLayer

open Matrix Finset

/-- **The trilinear contraction of three bivectors against `levi6`.** *This is the wedge
`α ∧ β ∧ γ` read as a scalar at `dim 6`, with the normalisation that makes `triple6 X X X` the
Pfaffian.* -/
noncomputable def triple6 (X Y Z : Matrix (Fin 6) (Fin 6) ℝ) : ℝ :=
  (1 / 48 : ℝ) * ∑ a : Fin 6, ∑ b : Fin 6, ∑ c : Fin 6, ∑ d : Fin 6, ∑ e : Fin 6, ∑ f : Fin 6,
    levi6 a b c d e f * X a b * Y c d * Z e f

/-! ### The equivariance route to `pf6 J = ±1`, split 2026-09-23

*`pf6 J = ±1` is what [StarWedgeIdentity](SelfDual.lean) rested on, and it is PROVED*, as
`pf6_complexStructure` in [I67PfSign.lean](../Results/I67PfSign.lean). **The route never expands
anything: `Pf(Q X Qᵀ) = det Q · Pf X` together with an orthogonal normal form**, and the pieces
are named below.

**WHAT IS ALREADY HERE**: `triple6` is trilinear, proved in all three slots by `triple6_add_left`,
`triple6_smul_left` and their `mid` and `right` counterparts, and `levi6`'s swap lemmas are in
[SelfDual.lean](SelfDual.lean).

**WHAT MATHLIB HAS**, checked by object rather than by name: `AlternatingMap.eq_smul_basis_det` in
`LinearAlgebra/Determinant.lean` is top-degree uniqueness, `f = f e • e.det`, which IS the
transformation law `∑ ε Q ⋯ Q = det Q · ε` once the contraction is presented as an alternating map.

**WHAT IS OWED IS THE BRIDGE, AND IT IS MOST BUT NOT ALL OF THE WORK** ([r1089](../../../reviews/REVIEW_r1089.md) corrects the earlier "whole"): *the bridge gives $\varepsilon$-equivariance on $\mathbb R^6$, and carrying that to $\mathrm{Pf}(QXQ^{\mathsf T})=\det Q\cdot\mathrm{Pf}(X)$ is a further `Finset.sum` resummation over six indices.*: nothing here presents the `levi6`
contraction as a `Mathlib` `AlternatingMap`, so the uniqueness theorem has nothing to apply to.
*That is a construction rather than a search, and it is bounded, which is what distinguishes it
from the staged expansion the other route needs.*

**THE SPLIT ABOVE NAMED A HARDER TOOL THAN THE ROUTE NEEDS, AND THIS CORRECTS IT, 2026-09-23.**

*`levi6` is a product of pairwise `sgnR` factors, so it IS the permutation sign and vanishes on
any repeated index.* **A full-index contraction against it is therefore a DETERMINANT**: Mathlib's
`Matrix.det_apply` writes `det M` as exactly that sum over permutations, and the sum over all
tuples collapses onto it because the repeats contribute nothing.

**So the transformation law is `Matrix.det_mul`, not alternating-map uniqueness.** *Writing the
six vectors as the columns of a matrix, `∑ ε (Qx¹) ⋯ (Qx⁶) = det (Q · [x¹ ⋯ x⁶]) = det Q · det
[x¹ ⋯ x⁶]`, which is `det_mul` and nothing more.* `AlternatingMap.eq_smul_basis_det` would prove
the same thing through a construction that is not needed.

**THE TRANSFORMATION LAW IS PROVED**: `pf6_conj`, `Pf(QXQᵀ) = det Q · Pf X`, in
[Pfaffian6Conj.lean](Pfaffian6Conj.lean), from `levi6_contract` in [Levi6Det.lean](Levi6Det.lean)
and the resummation carried out there. **The normal form is `complexStructure_normalForm` and
`pf6 stdJ6 = -1` is `pf6_stdJ6`**, both in [I67PfSign.lean](../Results/I67PfSign.lean).

**THE EQUIVARIANCE ROUTE CLOSED `pf6 J = ±1`**, and the `720`-term expansion stays the route to the
general identity `Pf(X)² = det X`, which [I67PfSquared.lean](../Results/I67PfSquared.lean) states.
-/

/-- **The Pfaffian of a `2`-form on `ℝ⁶`.** *`Pf = (2^m·m!)⁻¹ ∑ sgn ∏`, which is `1/48` at `m = 3`.* -/
noncomputable def pf6 (X : Matrix (Fin 6) (Fin 6) ℝ) : ℝ := triple6 X X X

theorem triple6_add_left (X Y Z W : Matrix (Fin 6) (Fin 6) ℝ) :
    triple6 (X + Y) Z W = triple6 X Z W + triple6 Y Z W := by
  simp only [triple6, Matrix.add_apply, add_mul, mul_add, Finset.sum_add_distrib]

theorem triple6_smul_left (r : ℝ) (X Z W : Matrix (Fin 6) (Fin 6) ℝ) :
    triple6 (r • X) Z W = r * triple6 X Z W := by
  unfold triple6
  simp only [Matrix.smul_apply, smul_eq_mul]
  rw [show (∑ a : Fin 6, ∑ b : Fin 6, ∑ c : Fin 6, ∑ d : Fin 6, ∑ e : Fin 6, ∑ f : Fin 6,
        levi6 a b c d e f * (r * X a b) * Z c d * W e f)
      = r * ∑ a : Fin 6, ∑ b : Fin 6, ∑ c : Fin 6, ∑ d : Fin 6, ∑ e : Fin 6, ∑ f : Fin 6,
        levi6 a b c d e f * X a b * Z c d * W e f from ?_]
  · ring
  · simp only [Finset.mul_sum]
    exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
      Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ =>
      Finset.sum_congr rfl fun e _ => Finset.sum_congr rfl fun f _ => by ring

theorem triple6_add_mid (X Y Z W : Matrix (Fin 6) (Fin 6) ℝ) :
    triple6 Z (X + Y) W = triple6 Z X W + triple6 Z Y W := by
  simp only [triple6, Matrix.add_apply, add_mul, mul_add, Finset.sum_add_distrib]

theorem triple6_smul_mid (r : ℝ) (X Z W : Matrix (Fin 6) (Fin 6) ℝ) :
    triple6 Z (r • X) W = r * triple6 Z X W := by
  unfold triple6
  simp only [Matrix.smul_apply, smul_eq_mul]
  rw [show (∑ a : Fin 6, ∑ b : Fin 6, ∑ c : Fin 6, ∑ d : Fin 6, ∑ e : Fin 6, ∑ f : Fin 6,
        levi6 a b c d e f * Z a b * (r * X c d) * W e f)
      = r * ∑ a : Fin 6, ∑ b : Fin 6, ∑ c : Fin 6, ∑ d : Fin 6, ∑ e : Fin 6, ∑ f : Fin 6,
        levi6 a b c d e f * Z a b * X c d * W e f from ?_]
  · ring
  · simp only [Finset.mul_sum]
    exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
      Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ =>
      Finset.sum_congr rfl fun e _ => Finset.sum_congr rfl fun f _ => by ring

theorem triple6_add_right (X Y Z W : Matrix (Fin 6) (Fin 6) ℝ) :
    triple6 Z W (X + Y) = triple6 Z W X + triple6 Z W Y := by
  simp only [triple6, Matrix.add_apply, add_mul, mul_add, Finset.sum_add_distrib]

theorem triple6_smul_right (r : ℝ) (X Z W : Matrix (Fin 6) (Fin 6) ℝ) :
    triple6 Z W (r • X) = r * triple6 Z W X := by
  unfold triple6
  simp only [Matrix.smul_apply, smul_eq_mul]
  rw [show (∑ a : Fin 6, ∑ b : Fin 6, ∑ c : Fin 6, ∑ d : Fin 6, ∑ e : Fin 6, ∑ f : Fin 6,
        levi6 a b c d e f * Z a b * W c d * (r * X e f))
      = r * ∑ a : Fin 6, ∑ b : Fin 6, ∑ c : Fin 6, ∑ d : Fin 6, ∑ e : Fin 6, ∑ f : Fin 6,
        levi6 a b c d e f * Z a b * W c d * X e f from ?_]
  · ring
  · simp only [Finset.mul_sum]
    exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
      Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ =>
      Finset.sum_congr rfl fun e _ => Finset.sum_congr rfl fun f _ => by ring

/-- **THE SECOND DIFFERENCE OF THE PFAFFIAN CUBIC**, which is what `∂ᵢ²` reads off it.

*Stated without assuming `triple6` symmetric*: the three mixed terms are kept apart, and their sum is
what a symmetric reading would write as `6·triple6 ω ω w`. **That is the whole of
[L192](../Results/L192Statement.lean)'s step 2 at one form**, and summing it against the weights is
first Bianchi tested against the span. -/
theorem pf6_second_diff (w ω : Matrix (Fin 6) (Fin 6) ℝ) :
    pf6 (w + ω) - 2 * pf6 w + pf6 (w - ω)
      = 2 * (triple6 ω ω w + triple6 ω w ω + triple6 w ω ω) := by
  have hs : w - ω = w + (-1 : ℝ) • ω := by module
  simp only [pf6, hs, triple6_add_left, triple6_add_mid, triple6_add_right,
    triple6_smul_left, triple6_smul_mid, triple6_smul_right]
  ring

end HamiltonsCubic.SelfDualLayer
