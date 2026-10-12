import HamiltonsCubic.Results.Frechet

set_option linter.style.longLine false

/-!
# The unit sphere of `normSq2`, and the curve through a point in a tangent direction

**[r1016](../../../reviews/REVIEW_r1016.md)'s THIRD piece is a `posTangentConeAt {normSq2 = 1} R`
membership**, *which nothing in the layer computes and which no owed list outside
[plan.md](../../../plan.md) names.* **This file builds the object such a membership needs.**

**THE CONSTRUCTION.** *For `a` on the sphere and `y` orthogonal to it, `normSq2 (a + t·y)` is
`1 + t²‖y‖²` exactly, the cross term vanishing by orthogonality*, so dividing by the square root of
that puts the whole line back on the sphere. **`sphereCurve a y t` is that normalised point**, and
`sphereCurve_mem` says it has `normSq2 = 1` at every `t`, with no smallness hypothesis.

**WHAT IS PROVED HERE AND WHAT IS NOT.** *The algebra is proved: the quadratic expansion, the
scaling law, the sphere membership and the value at `t = 0`.* **THREE OBLIGATIONS REMAIN, AND A
FIRST VERSION OF THIS PARAGRAPH NAMED TWO** ([r1027](../../../reviews/REVIEW_r1027.md)):
`d n → 0`, which `mem_tangentConeAt_of_seq` wants and which that version omitted; and the two limits
making `n · (γ(1/n) − a) → y`, *whose scalar part is `n((1 + k/n²)^(−1/2) − 1) → 0` and whose vector
part is `(1 + k/n²)^(−1/2) · y → y`.* **`sphereCurve_mem` discharges the MIDDLE obligation**, that
the points lie in the set. **Nothing here claims the membership**, only the curve it would be built
from.

**`posTangentConeAt s x` IS `tangentConeAt NNReal s x`, AND THAT IS A `ClusterPt` DEFINITION**,
`{y | ClusterPt y ((⊤ : Filter R) • 𝓝[(x + ·) ⁻¹' s] 0)}`. *A first version of this paragraph said
a membership supplies `c : ℕ → NNReal` with `‖c n‖ → ∞`, and called that "checked rather than
recalled"* ([r1026](../../../reviews/REVIEW_r1026.md), [r1027](../../../reviews/REVIEW_r1027.md),
agreeing). **IT WAS RECALLED, FROM A MATHLIB OLDER THAN THIS ONE**, *and `Norm NNReal` does not
synthesize, so the condition asserted was not merely absent but untypeable.* **The sequential route
in is `mem_tangentConeAt_of_seq`**, whose obligations are the ones to discharge, and
`sphereCurve_mem` discharges its middle one.
-/

namespace HamiltonsCubic.RealLayer

open Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **THE QUADRATIC EXPANSION ALONG A LINE.** *`normSq2` is the diagonal of a symmetric bilinear
form, so this is the polarisation and nothing more.* -/
theorem normSq2_add_smul (a y : CurvOp2 ι) (t : ℝ) :
    normSq2 (a + t • y) = normSq2 a + 2 * t * innerOp2 a y + t^2 * normSq2 y := by
  unfold normSq2
  rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right,
    innerOp2_smul_left, innerOp2_smul_right, innerOp2_smul_left, innerOp2_smul_right,
    innerOp2_comm y a]
  ring

/-- **`normSq2` is nonnegative**, being a sum of self-pairings. -/
theorem normSq2_nonneg (R : CurvOp2 ι) : 0 ≤ normSq2 R := by
  show (0:ℝ) ≤ (1/2) * ∑ i : ι, ∑ j : ι, inner2 (applyPhi R i j) (applyPhi R i j)
  have : (0:ℝ) ≤ ∑ i : ι, ∑ j : ι, inner2 (applyPhi R i j) (applyPhi R i j) :=
    Finset.sum_nonneg fun _ _ => Finset.sum_nonneg fun _ _ => inner2_self_nonneg _
  linarith

/-- **THE NORMALISED CURVE THROUGH `a` IN THE DIRECTION `y`.** *The scaling is by the square root
of `normSq2 (a + t·y)`, which at an orthogonal `y` is `1 + t²‖y‖²`.* -/
noncomputable def sphereCurve (a y : CurvOp2 ι) (t : ℝ) : CurvOp2 ι :=
  (Real.sqrt (1 + t^2 * normSq2 y))⁻¹ • (a + t • y)

/-- **AND IT IS HOMOGENEOUS OF DEGREE TWO.** -/
theorem normSq2_smul (c : ℝ) (R : CurvOp2 ι) : normSq2 (c • R) = c^2 * normSq2 R := by
  unfold normSq2
  rw [innerOp2_smul_left, innerOp2_smul_right]
  ring

/-- **IT LIES ON THE SPHERE AT EVERY `t`**, with no smallness hypothesis. *The cross term vanishes
by orthogonality, which is the whole of why the normalisation is a closed form rather than an
implicit function.* -/
theorem sphereCurve_mem {a y : CurvOp2 ι} (ha : normSq2 a = 1) (hy : innerOp2 a y = 0) (t : ℝ) :
    normSq2 (sphereCurve a y t) = 1 := by
  have hk : (0:ℝ) < 1 + t^2 * normSq2 y := by
    have := normSq2_nonneg y; nlinarith [sq_nonneg t, this]
  have hq : normSq2 (a + t • y) = 1 + t^2 * normSq2 y := by
    rw [normSq2_add_smul, ha, hy]; ring
  unfold sphereCurve
  rw [normSq2_smul, hq, inv_pow, Real.sq_sqrt hk.le]
  field_simp

/-- **AND IT PASSES THROUGH `a`.** -/
theorem sphereCurve_zero (a y : CurvOp2 ι) : sphereCurve a y 0 = a := by
  unfold sphereCurve
  simp only [ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, zero_mul, add_zero,
    Real.sqrt_one, inv_one, one_smul]
  module

end HamiltonsCubic.RealLayer
