import HamiltonsCubic.Results.CubicBridge
import HamiltonsCubic.Results.FirstVariation

set_option linter.style.longLine false

/-!
# The Fox product across the two operator layers

**[r1019](../../../reviews/REVIEW_r1019.md) found the record claiming that `foxTri2_symm_right`
discharges [FoxProduct.lean](../Base/FoxProduct.lean)'s recorded debt**, *and it did not*: that
file's `foxTri` is over BARE operators with `sharpOp` where `foxTri2` is over `CurvOp2` with
`sharpMapCL`, and **no file in the tree named both.** *The reviewer also named what was missing,
`extend_add`.*

**This file crosses them.** `foxTri_extend` says `T(extend A, extend B, extend C) = T₂(A,B,C)`, so
the symmetry proved on `CurvOp2` transfers to the bare form AT EXTENSIONS. *What it does NOT give
is the symmetry at an arbitrary bare operator*, since `extend` is not surjective.

**ITS IMAGE IS A PROPER SUBSET OF THE OPERATORS FACTORING THROUGH `skewProj`, AND A FIRST VERSION
SAID IT WAS ALL OF THEM** ([r1020](../../../reviews/REVIEW_r1020.md), screened in the kernel):
*the constant map to the identity at `n = 2` factors through `skewProj` while every value of
`extend A` is SKEW, so it is not `extend A` for any `A`.* **The error flattered the theorem.**

**THE EXTENSION FORM DOES NOT DISCHARGE THE DEBT, AND A FIRST VERSION CLAIMED IT DID**
([r1019](../../../reviews/REVIEW_r1019.md), [r1020](../../../reviews/REVIEW_r1020.md)):
*[FoxProduct.lean](../Base/FoxProduct.lean)'s consumers, `RayleighLE` and `RayleighGE`, quantify
over BARE `IsWeylOp` operators and evaluate `foxTri` at `idemOf W θ`, none of which is `extend` of
anything.*

**THE LEMMA THEY NEED IS `foxTri_eq_foxTri2_restrict`, AND IT IS BELOW.** *The route is that
`foxTri` reads its three arguments ONLY on bivectors*, which `foxTri_congr_on_skew` establishes
through `sharpQF`, `sharpBil`, `sharpOp`, `Qop` and `foxProd` in turn, *and there
`extend (restrict hW)` agrees with `R`.* **So `foxTri_symm_right` holds at record-Weyl bare
operators**, which is what that section records as owed.
-/

namespace HamiltonsCubic.TensorBridge

open Matrix Finset
open HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

open scoped Matrix.Norms.Frobenius

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`extend` OF A SUM IS THE SUM OF THE EXTENSIONS**, as bare operators. -/
theorem extend_add' (A B : CurvOp2 ι) :
    extend (A + B) = extend A + extend B := funext (extend_add A B)

/-- **THE FOX PRODUCT CROSSES**, on `Λ²`. -/
theorem foxProd_extend (A B : CurvOp2 ι) (W : skewSub ι) :
    HamiltonsCubic.RealLayer.foxProd (extend A) (extend B) (W : Matrix ι ι ℝ)
      = ((foxProd2 A B W : skewSub ι) : Matrix ι ι ℝ) := by
  unfold HamiltonsCubic.RealLayer.foxProd
  rw [← extend_add' A B, Qop_extend (A + B) W, Qop_extend A W, Qop_extend B W]
  show _ = ((((1 / 2 : ℝ) • (Qop2 (A + B) - Qop2 A - Qop2 B)) W : skewSub ι) :
      Matrix ι ι ℝ)
  rw [_root_.smul_apply, Submodule.coe_smul]
  congr 1

/-- **AND SO DOES THE TRILINEAR FORM**: `T(extend A, extend B, extend C) = T₂(A,B,C)`.
*This is the bridge [r1019](../../../reviews/REVIEW_r1019.md) found missing, and it is what lets
`foxTri2`'s symmetry say anything about [FoxProduct.lean](../Base/FoxProduct.lean)'s `foxTri`.* -/
theorem foxTri_extend (A B C : CurvOp2 ι) :
    HamiltonsCubic.RealLayer.foxTri (extend A) (extend B) (extend C) = foxTri2 A B C := by
  have h : ∀ i j : ι,
      inner2 (HamiltonsCubic.RealLayer.foxProd (extend A) (extend B) (phi i j))
          (extend C (phi i j))
        = inner2 (applyPhi (foxProd2 A B) i j) (applyPhi C i j) := by
    intro i j
    rw [foxProd_extend A B ⟨phi i j, phi_mem_skewSub i j⟩,
      show extend C (phi i j) = applyPhi C i j from
        extend_apply C ⟨phi i j, phi_mem_skewSub i j⟩]
  unfold HamiltonsCubic.RealLayer.foxTri foxTri2 HamiltonsCubic.RealLayer.innerOp innerOp2
  rw [Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => h i j]

/-- **THE FULL SYMMETRY OF `T` ON THE BARE LAYER, AT EXTENSIONS.** *This is what
[FoxProduct.lean](../Base/FoxProduct.lean)'s `foxTri_comm` leaves owed, transported across
`foxTri_extend`.* **Its reach is the image of `extend`** and not every bare operator, *a PROPER
subset even of the operators factoring through `skewProj`*
([r1020](../../../reviews/REVIEW_r1020.md)). -/
theorem foxTri_symm_right_extend (A B C : CurvOp2 ι)
    (hB : IsSelfAdjoint2 B) (hC : IsSelfAdjoint2 C) :
    HamiltonsCubic.RealLayer.foxTri (extend A) (extend B) (extend C)
      = HamiltonsCubic.RealLayer.foxTri (extend A) (extend C) (extend B) := by
  rw [foxTri_extend, foxTri_extend]
  exact foxTri2_symm_right A B C hB hC

/-- **AND AT A RECORD-WEYL OPERATOR**, through `restrict` and `restrict_extend`. *`IsWeyl R` forces
linearity on `Λ²`, so `restrict` is defined, and `extend (restrict hW)` agrees with `R` on every
bivector, which is all `foxTri` reads.* -/
theorem isSelfAdjoint2_restrict {R : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hW : HamiltonsCubic.RealLayer.IsWeyl R) : IsSelfAdjoint2 (restrict hW) :=
  fun X Y => hW.2.1 (X : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) X.2 Y.2

/-! ## `foxTri` reads its arguments only on bivectors

**That is what would discharge the debt** ([r1020](../../../reviews/REVIEW_r1020.md)): the missing
lemma is `foxTri X Y Z = foxTri2 (restrict hX) (restrict hY) (restrict hZ)` at record-Weyl
arguments, *and it follows once each ingredient is shown to depend on its operator only through
that operator's values on `Λ²`.*
-/

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`sharpQF` reads `R` only on bivectors.** *Every argument `R` meets inside it is a bivector:
the `φ` are, and the bracket of two bivectors is one.* -/
theorem sharpQF_congr_on_skew {R S : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hR : ∀ X, IsSkew X → IsSkew (R X))
    (hRS : ∀ X, IsSkew X → R X = S X) (η : Matrix ι ι ℝ) (hη : IsSkew η) :
    sharpQF R η = sharpQF S η := by
  unfold sharpQF
  congr 1
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  have hp : IsSkew (phi i j) := phi_isSkew i j
  have h1 : R (phi i j) = S (phi i j) := hRS _ hp
  have h2 : IsSkew (br η (R (phi i j))) :=
    HamiltonsCubic.L76Statement.br_isSkew hη (hR _ hp)
  rw [h1] at h2 ⊢
  rw [hRS _ h2]

/-- **And so does `sharpBil`.** -/
theorem sharpBil_congr_on_skew {R S : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hR : ∀ X, IsSkew X → IsSkew (R X))
    (hRS : ∀ X, IsSkew X → R X = S X) (X Y : Matrix ι ι ℝ) (hX : IsSkew X) (hY : IsSkew Y) :
    sharpBil R X Y = sharpBil S X Y := by
  unfold sharpBil
  have hXY : IsSkew (X + Y) := by
    unfold IsSkew at hX hY ⊢
    rw [Matrix.transpose_add, hX, hY]
    abel
  rw [sharpQF_congr_on_skew hR hRS (X + Y) hXY, sharpQF_congr_on_skew hR hRS X hX,
    sharpQF_congr_on_skew hR hRS Y hY]

/-- **And `sharpOp`, at a bivector.** -/
theorem sharpOp_congr_on_skew {R S : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hR : ∀ X, IsSkew X → IsSkew (R X))
    (hRS : ∀ X, IsSkew X → R X = S X) (X : Matrix ι ι ℝ) (hX : IsSkew X) :
    sharpOp R X = sharpOp S X := by
  unfold sharpOp
  have h : ∀ i j : ι, (sharpBil R X (phi i j)) • (phi i j)
      = (sharpBil S X (phi i j)) • (phi i j) := by
    intro i j
    rw [sharpBil_congr_on_skew hR hRS X (phi i j) hX (phi_isSkew i j)]
  rw [Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => h i j]

/-- **And `Qop`.** -/
theorem Qop_congr_on_skew {R S : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hR : ∀ X, IsSkew X → IsSkew (R X))
    (hRS : ∀ X, IsSkew X → R X = S X) (X : Matrix ι ι ℝ) (hX : IsSkew X) :
    Qop R X = Qop S X := by
  unfold Qop compOp
  rw [sharpOp_congr_on_skew hR hRS X hX, hRS (R X) (hR X hX), hRS X hX]

/-- **And `foxProd`, at a bivector**, given both operators preserve bivectors and agree there. -/
theorem foxProd_congr_on_skew {X Y X' Y' : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hX : ∀ Z, IsSkew Z → IsSkew (X Z)) (hY : ∀ Z, IsSkew Z → IsSkew (Y Z))
    (hXX : ∀ Z, IsSkew Z → X Z = X' Z) (hYY : ∀ Z, IsSkew Z → Y Z = Y' Z)
    (Z : Matrix ι ι ℝ) (hZ : IsSkew Z) :
    foxProd X Y Z = foxProd X' Y' Z := by
  have hsum : ∀ W, IsSkew W → IsSkew ((X + Y) W) := by
    intro W hW
    show IsSkew (X W + Y W)
    unfold IsSkew at *
    rw [Matrix.transpose_add, hX W hW, hY W hW]
    abel
  have hsum' : ∀ W, IsSkew W → (X + Y) W = (X' + Y') W := by
    intro W hW
    show X W + Y W = X' W + Y' W
    rw [hXX W hW, hYY W hW]
  unfold foxProd
  rw [Qop_congr_on_skew hsum hsum' Z hZ, Qop_congr_on_skew hX hXX Z hZ,
    Qop_congr_on_skew hY hYY Z hZ]

/-- **AND SO `foxTri` READS ITS ARGUMENTS ONLY ON BIVECTORS**, since `innerOp` evaluates them at
the `φ` family and nowhere else. -/
theorem foxTri_congr_on_skew {X Y Z X' Y' Z' : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hX : ∀ W, IsSkew W → IsSkew (X W)) (hY : ∀ W, IsSkew W → IsSkew (Y W))
    (hXX : ∀ W, IsSkew W → X W = X' W) (hYY : ∀ W, IsSkew W → Y W = Y' W)
    (hZZ : ∀ W, IsSkew W → Z W = Z' W) :
    foxTri X Y Z = foxTri X' Y' Z' := by
  unfold foxTri innerOp
  have h : ∀ i j : ι, inner2 (foxProd X Y (phi i j)) (Z (phi i j))
      = inner2 (foxProd X' Y' (phi i j)) (Z' (phi i j)) := by
    intro i j
    rw [foxProd_congr_on_skew hX hY hXX hYY (phi i j) (phi_isSkew i j),
      hZZ (phi i j) (phi_isSkew i j)]
  rw [Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => h i j]

/-! ## The lemma that discharges the debt -/

/-- **`extend (restrict hW)` AGREES WITH `R` ON EVERY BIVECTOR**, which is all `foxTri` reads. -/
theorem extend_restrict_on_skew {R : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hW : HamiltonsCubic.RealLayer.IsWeyl R) (Z : Matrix ι ι ℝ) (hZ : IsSkew Z) :
    extend (restrict hW) Z = R Z := by
  rw [show Z = ((⟨Z, hZ⟩ : skewSub ι) : Matrix ι ι ℝ) from rfl,
    extend_apply (restrict hW) ⟨Z, hZ⟩]
  rfl

/-- **AND IT PRESERVES BIVECTORS.** -/
theorem extend_restrict_isSkew {R : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hW : HamiltonsCubic.RealLayer.IsWeyl R) (Z : Matrix ι ι ℝ) :
    IsSkew (extend (restrict hW) Z) :=
  (restrict hW ⟨skewProj Z, skewProj_mem Z⟩).2

/-- **THE DEBT, DISCHARGED**: `T` at three record-Weyl BARE operators is `T₂` at their
restrictions. *[r1020](../../../reviews/REVIEW_r1020.md) named this as the absent lemma, the one
`FoxProduct.lean`'s own consumers need, since they quantify over bare `IsWeylOp` operators and none
of those is `extend` of anything.* **The route is that `foxTri` reads its arguments only on
bivectors**, where `extend (restrict hW)` agrees with `R`. -/
theorem foxTri_eq_foxTri2_restrict     {X Y Z : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hX : HamiltonsCubic.RealLayer.IsWeyl X) (hY : HamiltonsCubic.RealLayer.IsWeyl Y)
    (hZ : HamiltonsCubic.RealLayer.IsWeyl Z) :
    foxTri X Y Z = foxTri2 (restrict hX) (restrict hY) (restrict hZ) := by
  rw [← foxTri_extend (restrict hX) (restrict hY) (restrict hZ)]
  exact foxTri_congr_on_skew hX.1 hY.1
    (fun W hW => (extend_restrict_on_skew hX W hW).symm)
    (fun W hW => (extend_restrict_on_skew hY W hW).symm)
    (fun W hW => (extend_restrict_on_skew hZ W hW).symm)

/-- **SO THE FULL SYMMETRY OF `T` HOLDS AT RECORD-WEYL BARE OPERATORS**, which with `foxTri_comm`
is what [FoxProduct.lean](../Base/FoxProduct.lean)'s *what is owed* section records. -/
theorem foxTri_symm_right     {X Y Z : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hX : HamiltonsCubic.RealLayer.IsWeyl X) (hY : HamiltonsCubic.RealLayer.IsWeyl Y)
    (hZ : HamiltonsCubic.RealLayer.IsWeyl Z) :
    foxTri X Y Z = foxTri X Z Y := by
  rw [foxTri_eq_foxTri2_restrict hX hY hZ, foxTri_eq_foxTri2_restrict hX hZ hY]
  exact foxTri2_symm_right (restrict hX) (restrict hY) (restrict hZ)
    (isSelfAdjoint2_restrict hY) (isSelfAdjoint2_restrict hZ)

/-! ## What the consumers actually evaluate

**[r1021](../../../reviews/REVIEW_r1021.md) found the discharge short by two reach gaps, and both
were accidents rather than mathematics.** *The index type was a section variable: `skewProj` and
`extend` never needed `Fin n`, and every declaration above now carries a general `ι`, which is what
[RayleighLE](../Base/FoxProduct.lean) and [RayleighGE](../Base/FoxProduct.lean) quantify over.*
**The second was that those consumers evaluate `T` at `idemOf W θ = θ⁻¹ • W` rather than at `W`**,
and no declaration closed `IsWeyl` under scaling the operator. *`isWeyl_smul_op` closes it.*
-/

/-- **THE SYMMETRY AT THE IDEMPOTENT**, which is the operator the consumers name. -/
theorem foxTri_symm_right_idemOf {W X Y : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hW : HamiltonsCubic.RealLayer.IsWeyl W) (hX : HamiltonsCubic.RealLayer.IsWeyl X)
    (hY : HamiltonsCubic.RealLayer.IsWeyl Y) (θ : ℝ) :
    foxTri (idemOf W θ) X Y = foxTri (idemOf W θ) Y X :=
  foxTri_symm_right (isWeyl_idemOf hW θ) hX hY

/-- **`L_e` IS SELF-ADJOINT**, which is the consequence [FoxProduct.lean](../Base/FoxProduct.lean)'s
*what is owed* section draws from the full symmetry of `T`, and the thing three earlier claims of
discharge did not reach. *`⟨L_e X, Y⟩` is `T(e,X,Y)` by definition, `⟨X, L_e Y⟩` is `T(e,Y,X)` through
`innerOp_comm`, and the two are equal by the symmetry above.* -/
theorem lidem_isSelfAdjoint {W X Y : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hW : HamiltonsCubic.RealLayer.IsWeyl W) (hX : HamiltonsCubic.RealLayer.IsWeyl X)
    (hY : HamiltonsCubic.RealLayer.IsWeyl Y) (θ : ℝ) :
    HamiltonsCubic.RealLayer.innerOp (Lidem W θ X) Y
      = HamiltonsCubic.RealLayer.innerOp X (Lidem W θ Y) := by
  rw [HamiltonsCubic.RealLayer.innerOp_comm X (Lidem W θ Y)]
  exact foxTri_symm_right_idemOf hW hX hY θ

end HamiltonsCubic.TensorBridge
