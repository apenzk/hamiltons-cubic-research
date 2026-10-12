import HamiltonsCubic.Results.SphereTangent
import HamiltonsCubic.Results.Frechet
import HamiltonsCubic.Results.TraceOp

/-!
# Fermat on the unit sphere: a maximiser is critical

**THE THREE PIECES [r1016](../../../reviews/REVIEW_r1016.md) NAMED ARE NOW ALL ON FILE**, so
Mathlib's `IsLocalMaxOn.hasFDerivWithinAt_nonpos` applies: the bundled derivative
([Frechet.lean](Frechet.lean)), Fréchet differentiability at a self-adjoint point, and the
`posTangentConeAt` membership ([SphereTangent.lean](SphereTangent.lean)).

**THE CONE IS CLOSED UNDER NEGATION HERE, AND THAT IS WHAT TURNS AN INEQUALITY INTO AN EQUATION.**
*`y ⊥ a` gives `-y ⊥ a`*, so Fermat applies at both and the two bounds `f' y ≤ 0` and `-f' y ≤ 0`
force `f' y = 0`. **Without that symmetry a maximiser would only give a half-space condition.**

*The derivative is `S ↦ 3⟪S, Q(R)⟫`*, so the conclusion reads `⟪y, Q(a)⟫ = 0` at every `y ⊥ a`:
**`Q(a)` is orthogonal to everything `a` is orthogonal to**, which is the Lagrange condition and,
on this record, criticality.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.RealLayer

open Filter Topology
open scoped NNReal Matrix.Norms.Frobenius OperatorNorm

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **A LOCAL MAXIMISER OF `P` ON THE UNIT SPHERE HAS `⟪y, Q(a)⟫ = 0` AT EVERY `y ⊥ a`.**

**THE CONSTRAINT SET IS THE FULL SPHERE OF `End(Λ²)`, NOT THE WEYL SPHERE, AND THAT IS A REAL
LIMITATION.** *Maximality on the LARGER set is the STRONGER hypothesis*, so a point known only to
maximise on `{IsWeyl2 ∧ normSq2 = 1}`, which is every maximiser the programme reasons about, does
NOT satisfy this. **The Weyl-sphere form is [WeylMaximiser.lean](WeylMaximiser.lean)'s
`innerOp2_Qop2_eq_zero_weyl` and `Qop2_eq_smul_weyl`**, and `exists_weyl_maximiser` there supplies
a maximiser at every `n ≥ 4`, so the programme's own constraint set carries both the existence and
the Lagrange condition. *The full-sphere hypotheses themselves are met only degenerately*: at `ι = Fin 2`
the sphere is two isolated points, and at `|ι| ≥ 3` no object on file maximises `P` on the full
sphere with self-adjointness established; the Weyl maximiser maximises on the smaller set. -/
theorem innerOp2_Qop2_eq_zero_of_isLocalMaxOn {a : CurvOp2 ι} (ha : normSq2 a = 1)
    (hsa : IsSelfAdjoint2 a)
    (hmax : IsLocalMaxOn Pcubic2 {R : CurvOp2 ι | normSq2 R = 1} a)
    {y : CurvOp2 ι} (hy : innerOp2 a y = 0) :
    innerOp2 y (Qop2 a) = 0 := by
  have hd : HasFDerivWithinAt Pcubic2 (PcubicDiffS a) {R : CurvOp2 ι | normSq2 R = 1} a :=
    (hasFDerivAt_Pcubic2 hsa).hasFDerivWithinAt
  have hyneg : innerOp2 a (-y) = 0 := by
    have hneg : (-y : CurvOp2 ι) = (-1 : ℝ) • y := by module
    rw [hneg, innerOp2_smul_right, hy, mul_zero]
  have h1 := hmax.hasFDerivWithinAt_nonpos hd (mem_posTangentConeAt_sphere ha hy)
  have h2 := hmax.hasFDerivWithinAt_nonpos hd (mem_posTangentConeAt_sphere ha hyneg)
  -- `PcubicDiffS_apply` is `rfl`, so these are definitional rather than rewrites
  have h1' : 3 * innerOp2 y (Qop2 a) ≤ 0 := h1
  have h2' : 3 * innerOp2 (-y) (Qop2 a) ≤ 0 := h2
  have hlin : innerOp2 (-y) (Qop2 a) = -innerOp2 y (Qop2 a) := by
    have hneg : (-y : CurvOp2 ι) = (-1 : ℝ) • y := by module
    rw [hneg, innerOp2_smul_left]; ring
  rw [hlin] at h2'
  linarith

/-- **AND THAT IS CRITICALITY: `Q(a) = λ·a` with `λ = ⟪a, Q(a)⟫`.**

*The step needs DEFINITENESS of `innerOp2` and nothing else*: no finite-dimensionality and no
orthogonal-complement theory, because the witness is produced explicitly rather than by a
projection. **Put `z = Q(a) - λ·a`**; then `⟪a, z⟫ = 0`, so the theorem above applies at `y = z`
and gives `⟪z, Q(a)⟫ = 0`, whence `normSq2 z = ⟪z, Q(a)⟫ - λ⟪z, a⟫ = 0`.

*A first version of this file asserted this conclusion in prose and proved only the orthogonality,
which a reviewer caught.* -/
theorem Qop2_eq_smul_of_isLocalMaxOn {ι : Type*} [Fintype ι] [DecidableEq ι]
    {a : CurvOp2 ι} (ha : normSq2 a = 1) (hsa : IsSelfAdjoint2 a)
    (hmax : IsLocalMaxOn Pcubic2 {R : CurvOp2 ι | normSq2 R = 1} a) :
    Qop2 a = innerOp2 a (Qop2 a) • a := by
  set lam : ℝ := innerOp2 a (Qop2 a) with hlam
  set z : CurvOp2 ι := Qop2 a - lam • a with hz
  -- `normSq2` IS `innerOp2 R R` by definition, so no bridging lemma is needed
  have haa : innerOp2 a a = 1 := ha
  have hza : innerOp2 z a = 0 := by
    rw [hz, innerOp2_sub_left, innerOp2_smul_left, innerOp2_comm (Qop2 a) a, ← hlam, haa]
    ring
  have haz : innerOp2 a z = 0 := by rw [innerOp2_comm]; exact hza
  have hzq : innerOp2 z (Qop2 a) = 0 :=
    innerOp2_Qop2_eq_zero_of_isLocalMaxOn ha hsa hmax haz
  have hzz : normSq2 z = 0 := by
    show innerOp2 z z = 0
    nth_rewrite 1 [hz]
    rw [innerOp2_sub_left, innerOp2_smul_left, innerOp2_comm (Qop2 a) z, hzq, haz]
    ring
  have hz0 : z = 0 := normSq2_eq_zero hzz
  rw [hz] at hz0
  -- `linear_combination (norm := module)` fails here: instance search will not chase projections
  -- on the `CurvOp2` abbrev, so the subtraction is rearranged directly instead.
  first
    | exact sub_eq_zero.mp hz0
    | exact sub_eq_zero_iff_eq.mp hz0
    | exact eq_of_sub_eq_zero hz0

end HamiltonsCubic.RealLayer
