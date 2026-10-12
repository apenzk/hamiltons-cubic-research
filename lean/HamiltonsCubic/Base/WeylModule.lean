import Mathlib.Tactic
import HamiltonsCubic.Base.WeylReal
import HamiltonsCubic.Base.FoxProduct
import HamiltonsCubic.Base.StructureConstants

/-!
# `𝒲ₙ` as a module, and the trace on its operators

[plan.md](../../../plan.md)'s item I82, and the one blocker the base layer's own
"what is owed" section names: *the trace identities need a trace on the operators of `𝒲ₙ`
and so a basis of `𝒲ₙ`, and this layer has neither.*

**NO EXPLICIT BASIS IS NEEDED, AND THAT IS WHY THE BLOCKER STOOD SO LONG.** A trace needs
the module to be finite-dimensional and free, and Mathlib supplies both for any submodule of
a finite-dimensional space. *`Module.Free.of_divisionRing` is `of_basis (ofVectorSpace ..)` and
`LinearMap.trace` is the matrix trace in a chosen basis, so a basis is used throughout: what is
dispensed with is WRITING ONE DOWN, which is convenience rather than content*
([r898](../../../reviews/REVIEW_r898.md)). So the whole of the construction is the observation that `𝒲ₙ`
IS a submodule, which holds because **every one of `IsWeyl`'s four clauses is linear in `R`**:
skew-to-skew is a linear condition, the symmetry clause equates two expressions each linear
in `R`, and `bianchi` and `Ric` are linear functionals of `R`. Nothing here writes down a
basis element, and nothing needs to.

**What DID block it is the representation, not the mathematics.** `CurvOp ι` is
`Matrix ι ι ℝ → Matrix ι ι ℝ` as BARE FUNCTIONS, and that type is infinite-dimensional over
`ℝ`, since its domain is infinite. No trace can exist on it, so `IsLinOp` as a side predicate
cannot be repaired by any amount of work about `𝒲ₙ`. *Bundling the linearity into the arrow
is the step, and it is one line.*

What this file gives:

`CurvLin` is a curvature operator with its linearity bundled, `Matrix ι ι ℝ →ₗ[ℝ] Matrix ι ι ℝ`.
`weylModule` is `𝒲ₙ` as a `Submodule ℝ (CurvLin ι)`.
`weylTrace` is the trace of an operator on `𝒲ₙ`, which is what `tr L e = 0` and
`tr (L e * L f) = κ ⟨e, f⟩` are statements about.

**What this file does NOT state**: the two trace identities themselves, which need `foxProd`
transported onto `weylModule` and are the next item. Nor `dim 𝒲ₙ = n(n+1)(n+2)(n-3)/12`,
which needs the explicit basis this construction shows the TRACE does not need.
-/

set_option linter.style.longLine false
-- `haveI` is what supplies the two instances `LinearMap.trace_id` needs, and the instance path
-- for a `Submodule` coercion does not resolve without them being named.
set_option linter.style.haveILetI false

namespace HamiltonsCubic.RealLayer

open Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-! ## `inner2` is bilinear, which is what makes the clauses linear -/

theorem inner2_smul_right' (c : ℝ) (X Y : Matrix ι ι ℝ) :
    inner2 X (c • Y) = c * inner2 X Y := by
  simp only [inner2, Matrix.mul_smul, Matrix.trace_smul, smul_eq_mul]
  ring

theorem inner2_zero_left' (X : Matrix ι ι ℝ) : inner2 0 X = 0 := by
  simp [inner2]

theorem inner2_zero_right' (X : Matrix ι ι ℝ) : inner2 X 0 = 0 := by
  simp [inner2]

/-! ## Curvature operators with their linearity bundled -/

/-- **A curvature operator whose linearity is in the ARROW rather than in a side predicate.**
`CurvOp ι` is a bare function type and is infinite-dimensional over `ℝ`, so no trace exists on
it however much is proved about `𝒲ₙ`. This is the type on which one does. -/
abbrev CurvLin (ι : Type*) [Fintype ι] [DecidableEq ι] :=
  Matrix ι ι ℝ →ₗ[ℝ] Matrix ι ι ℝ

/-- `IsWeyl` read on a bundled map, so the two layers agree by definition rather than by a bridge. -/
def IsWeylL (R : CurvLin ι) : Prop := IsWeyl (fun X => R X)

theorem isWeylL_zero : IsWeylL (0 : CurvLin ι) := by
  refine ⟨fun X _ => ?_, fun X Y _ _ => ?_, fun i j k l => ?_, fun a b => ?_⟩
  · show ((0 : CurvLin ι) X)ᵀ = -((0 : CurvLin ι) X)
    simp
  · show inner2 ((0 : CurvLin ι) X) Y = inner2 X ((0 : CurvLin ι) Y)
    simp [inner2_zero_left', inner2_zero_right']
  · simp [bianchi, inner2_zero_left']
  · simp [Ric, inner2_zero_left']

/-! ## `𝒲ₙ` as a submodule

**Each clause is linear in `R`, and that is the whole content.** -/

/-- **`𝒲ₙ`, as a submodule of the linear operators on bivectors.** -/
def weylModule (ι : Type*) [Fintype ι] [DecidableEq ι] : Submodule ℝ (CurvLin ι) where
  carrier := {R | IsWeylL R}
  zero_mem' := isWeylL_zero
  add_mem' := by
    rintro R S ⟨hR1, hR2, hR3, hR4⟩ ⟨hS1, hS2, hS3, hS4⟩
    refine ⟨?_, ?_, ?_, ?_⟩
    · intro X hX
      have hr := hR1 X hX
      have hs := hS1 X hX
      change ((R + S) X)ᵀ = -((R + S) X)
      rw [LinearMap.add_apply, Matrix.transpose_add, hr, hs, neg_add]
    · intro X Y hX hY
      change inner2 ((R + S) X) Y = inner2 X ((R + S) Y)
      rw [LinearMap.add_apply, LinearMap.add_apply, inner2_add_left, inner2_add_right,
        hR2 X Y hX hY, hS2 X Y hX hY]
    · intro i j k l
      have hr := hR3 i j k l
      have hs := hS3 i j k l
      simp only [bianchi, LinearMap.add_apply, inner2_add_left] at hr hs ⊢
      linarith
    · intro a b
      have hr := hR4 a b
      have hs := hS4 a b
      simp only [Ric, LinearMap.add_apply, inner2_add_left] at hr hs ⊢
      rw [Finset.sum_add_distrib]
      linarith
  smul_mem' := by
    rintro c R ⟨hR1, hR2, hR3, hR4⟩
    refine ⟨?_, ?_, ?_, ?_⟩
    · intro X hX
      have hr := hR1 X hX
      change ((c • R) X)ᵀ = -((c • R) X)
      rw [LinearMap.smul_apply, Matrix.transpose_smul, hr, smul_neg]
    · intro X Y hX hY
      change inner2 ((c • R) X) Y = inner2 X ((c • R) Y)
      rw [LinearMap.smul_apply, LinearMap.smul_apply, inner2_smul_left, inner2_smul_right',
        hR2 X Y hX hY]
    · intro i j k l
      have hr := hR3 i j k l
      simp only [bianchi, LinearMap.smul_apply, inner2_smul_left] at hr ⊢
      linear_combination c * hr
    · intro a b
      have hr := hR4 a b
      simp only [Ric, LinearMap.smul_apply, inner2_smul_left, ← Finset.mul_sum] at hr ⊢
      rw [hr, mul_zero]

/-! ## The trace, which needs no basis -/

/-- **`𝒲ₙ` is finite-dimensional**, being a submodule of the operators on a finite matrix
space. *This is the instance the trace needs, and it arrives without an explicit basis.* -/
instance : FiniteDimensional ℝ (weylModule ι) := by
  have : FiniteDimensional ℝ (CurvLin ι) := inferInstance
  exact FiniteDimensional.finiteDimensional_submodule _

/-- **THE TRACE ON THE OPERATORS OF `𝒲ₙ`**, which the record recorded as out of reach.
`tr (L e) = 0` and `tr (L e ∘ L f) = κ ⟨e, f⟩` are statements about this function. -/
noncomputable def weylTrace (L : weylModule ι →ₗ[ℝ] weylModule ι) : ℝ :=
  LinearMap.trace ℝ (weylModule ι) L

/-- The trace is linear, which is every property the two identities use of it. -/
theorem weylTrace_add (L M : weylModule ι →ₗ[ℝ] weylModule ι) :
    weylTrace (L + M) = weylTrace L + weylTrace M := by
  simp [weylTrace]

theorem weylTrace_smul (c : ℝ) (L : weylModule ι →ₗ[ℝ] weylModule ι) :
    weylTrace (c • L) = c * weylTrace L := by
  simp [weylTrace]

theorem weylTrace_zero : weylTrace (0 : weylModule ι →ₗ[ℝ] weylModule ι) = 0 := by
  simp [weylTrace]

/-- **The trace of the identity is the dimension.** *This is the hook by which `dim 𝒲ₙ` becomes a
statement about `weylTrace`, once a basis is built for the counting.*

**IT DOES NOT ESTABLISH NON-VACUITY, AND AN EARLIER VERSION OF THIS COMMENT CLAIMED IT DID**
([r898](../../../reviews/REVIEW_r898.md)). *The debt it named was that the only member of
`weylModule` exhibited anywhere was `0`, so every statement here was consistent with
`dim 𝒲ₙ = 0`, where this theorem reads `0 = 0`.*

**THE WITNESS IS BUILT**, `sphereWeight_diagOpL_ne_zero` in
[WeylRadical.lean](../Results/WeylRadical.lean): the diagonal operator of the record's own sphere
weight lies in `weylModule` and moves `φ_ab`, so `dim 𝒲ₙ ≥ 1` at every split into two blocks of at
least two. **A NONZERO MEMBER IS NOT ENOUGH ON ITS OWN, WHICH IS WHY THE WITNESS IS THIS ONE**
([r1004](../../../reviews/REVIEW_r1004.md)): the same file's `symOp` is nonzero and lies in the
RADICAL, so it witnesses that the module is nonzero while saying nothing about the Weyl space the
module is meant to be. *The witness has to survive restriction to `Λ²`, and a diagonal operator
does.* -/
theorem weylTrace_id :
    weylTrace (LinearMap.id : weylModule ι →ₗ[ℝ] weylModule ι)
      = (Module.finrank ℝ (weylModule ι) : ℝ) := by
  -- BOTH HINTS ARE LOAD-BEARING HERE, and r898 reported them removable at this project's
  -- synthesis depth. Removing them fails: `Module.Free ℝ ↥(weylModule ι)` does not synthesize,
  -- because the instance path for a `Submodule` coercion differs from the one `of_divisionRing`
  -- produces. The explicit coercion in the first hint is what makes the two agree.
  haveI : Module.Free ℝ ↑↑(weylModule ι) := Module.Free.of_divisionRing ℝ ↑↑(weylModule ι)
  haveI : Module.Finite ℝ (weylModule ι) := inferInstance
  exact LinearMap.trace_id ℝ (weylModule ι)

end HamiltonsCubic.RealLayer
