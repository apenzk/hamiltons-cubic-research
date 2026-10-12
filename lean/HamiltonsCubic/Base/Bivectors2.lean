import HamiltonsCubic.Base.WeylReal
import Mathlib.Analysis.InnerProductSpace.Basic
import Mathlib.Analysis.Matrix.Normed
import Mathlib.Analysis.Normed.Operator.Basic
import HamiltonsCubic.Base.StructureConstants
import HamiltonsCubic.Base.FoxProduct
import HamiltonsCubic.Base.Families

set_option linter.style.longLine false

/-!
# `Λ²` as a submodule, the ambient space the operator layer lacks

**[WeylRadical.lean](../Results/WeylRadical.lean) shows why this is needed.** *An operator is
currently a map on ALL matrices while every clause of `IsWeyl` reads it on bivectors alone, so any
linear map killing `Λ²` satisfies all four and the module the layer calls `𝒲ₙ` carries a whole
`Hom(Sym, M)` of them.* **`innerOp` is then a SEMI-inner product, `theta` divides by zero on that
subspace, and the trace and dimension are wrong.**

**The repair is to make `Λ²` itself the domain**, which this file begins. *The spanning fact it
turns on is already proved: `skew_expand` writes every skew matrix in the `φ` family.*

**WHAT THIS FIXES AND WHAT IT DOES NOT, checked rather than assumed.** *It fixes DEFINITENESS:
`eq_zero_of_phi` says a linear map out of `Λ²` killing every `φ_ij` is zero, which is exactly the
property `weylModule` lacks and the engine a definite pairing needs.* **It does NOT supply a
topology**: `TopologicalSpace (Module.End ℝ (skewSub (Fin n)))` fails to synthesize just as
`CurvLin`'s does, Mathlib carrying topologies on `ContinuousLinearMap` and not on `LinearMap`.
*The chain is definiteness first, then an inner product, then a norm, then the topology, and only
the first link is here.* **What makes the chain possible at all is that the pairing on this domain
CAN be definite, where on `weylModule` it provably cannot.**
-/

namespace HamiltonsCubic.RealLayer

open Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`Λ²`, the skew matrices, as a submodule.** -/
def skewSub (ι : Type*) [Fintype ι] [DecidableEq ι] : Submodule ℝ (Matrix ι ι ℝ) where
  carrier := {X | IsSkew X}
  zero_mem' := by
    show (0 : Matrix ι ι ℝ)ᵀ = -0
    simp
  add_mem' := by
    intro X Y hX hY
    show (X + Y)ᵀ = -(X + Y)
    rw [Matrix.transpose_add]
    show Xᵀ + Yᵀ = _
    rw [show Xᵀ = -X from hX, show Yᵀ = -Y from hY]
    abel
  smul_mem' := by
    intro c X hX
    show (c • X)ᵀ = -(c • X)
    rw [Matrix.transpose_smul, show Xᵀ = -X from hX, smul_neg]

theorem mem_skewSub {X : Matrix ι ι ℝ} : X ∈ skewSub ι ↔ IsSkew X := Iff.rfl

/-- **Every `φ_ij` is a bivector.** -/
theorem phi_mem_skewSub (i j : ι) : phi i j ∈ skewSub ι := phi_isSkew i j

/-- **THE PROPERTY `weylModule` LACKS**: a linear map out of `Λ²` that kills every `φ_ij` is zero.
*This is what makes the pairing definite once the domain is `Λ²` rather than every matrix, and it
is `skew_expand` read as a spanning statement.*

**`Fintype ι` IS LOAD-BEARING AND THE STATEMENT IS FALSE WITHOUT IT**
([r1005](../../../reviews/REVIEW_r1005.md)): *at an infinite index the `φ` family spans only the
finitely-supported skew matrices, so a map killing every `φ_ij` can be nonzero elsewhere.*
`DecidableEq` is `Matrix.single`'s indexing alone. -/
theorem eq_zero_of_phi {M : Type*} [AddCommGroup M] [Module ℝ M]
    (T : skewSub ι →ₗ[ℝ] M) (h : ∀ i j : ι, T ⟨phi i j, phi_mem_skewSub i j⟩ = 0) : T = 0 := by
  ext Y
  have hY : IsSkew (Y : Matrix ι ι ℝ) := Y.2
  have hexp : ((1/2 : ℝ) • (∑ i : ι, ∑ j : ι, (inner2 (Y : Matrix ι ι ℝ) (phi i j)) • phi i j))
      = (Y : Matrix ι ι ℝ) := skew_expand _ hY
  have hsub : Y = (1/2 : ℝ) • ∑ i : ι, ∑ j : ι,
      (inner2 (Y : Matrix ι ι ℝ) (phi i j)) • (⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) := by
    apply Subtype.ext
    simpa using hexp.symm
  rw [hsub]
  simp only [map_smul, map_sum, h, smul_zero, Finset.sum_const_zero, LinearMap.zero_apply]

/-! ## The pairing is DEFINITE on this domain, which is the whole point

**The same `innerOp` that [WeylRadical.lean](../Results/WeylRadical.lean) shows semi-definite on
`weylModule` is definite here**, because the only thing that went wrong there was that an operator
had room to be nonzero while vanishing on every `φ_ij`. *On this domain it has none.*
-/

/-- **`⟨X, X⟩ = 0` forces `X = 0`**, the pairing being a sum of squares over `ℝ`. -/
theorem inner2_self_eq_zero {X : Matrix ι ι ℝ} (h : inner2 X X = 0) : X = 0 := by
  have hsum : ∑ p : ι, ∑ q : ι, (X p q) ^ 2 = 0 := by
    rw [inner2_eq_sum] at h
    have h2 : ∑ p : ι, ∑ q : ι, X p q * X p q = 0 := by linarith
    rw [← h2]
    exact Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => sq (X p q)
  ext p q
  have hnn : ∀ x ∈ (Finset.univ : Finset ι), 0 ≤ ∑ y : ι, (X x y) ^ 2 :=
    fun x _ => Finset.sum_nonneg fun y _ => sq_nonneg _
  have hrow := (Finset.sum_eq_zero_iff_of_nonneg hnn).mp hsum p (Finset.mem_univ p)
  have hpt := (Finset.sum_eq_zero_iff_of_nonneg
    (fun y (_ : y ∈ (Finset.univ : Finset ι)) => sq_nonneg (X p y))).mp hrow q (Finset.mem_univ q)
  simpa using pow_eq_zero_iff (n := 2) (by norm_num) |>.mp hpt

/-- **THE PAYOFF: the pairing is DEFINITE on operators whose domain is `Λ²`.**
*It is NOT stated about [innerOp](WeylReal.lean), which takes bare functions that a map out of a
submodule is not, so nothing here connects to `normSq` or `theta` yet*
([r1005](../../../reviews/REVIEW_r1005.md)). **Under the evident identification the hypothesis is
`2·normSq = 0`.** *The hypothesis is met by zero alone, which is what a definiteness theorem says
rather than a defect in it, and the sum is `n(n-1)` at the identity, so the pairing does separate.* *An operator with
`∑ ⟨T φ_ij, T φ_ij⟩ = 0` is zero, where on [weylModule](WeylModule.lean) the same sum vanishes on a
whole `Hom(Sym, M)` of nonzero operators.* **The difference is entirely the domain**: there an
operator could be nonzero while killing every bivector, and here `eq_zero_of_phi` forbids it. -/
theorem eq_zero_of_phi_sq_sum (T : skewSub ι →ₗ[ℝ] skewSub ι)
    (h : ∑ i : ι, ∑ j : ι,
      inner2 ((T ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ)
        ((T ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ) = 0) : T = 0 := by
  refine eq_zero_of_phi T fun i j => ?_
  have hnn : ∀ x ∈ (Finset.univ : Finset ι), 0 ≤ ∑ y : ι,
      inner2 ((T ⟨phi x y, phi_mem_skewSub x y⟩ : skewSub ι) : Matrix ι ι ℝ)
        ((T ⟨phi x y, phi_mem_skewSub x y⟩ : skewSub ι) : Matrix ι ι ℝ) := by
    intro x _
    refine Finset.sum_nonneg fun y _ => ?_
    rw [inner2_eq_sum]
    have : ∀ a : ι, (0:ℝ) ≤ ∑ b : ι,
        ((T ⟨phi x y, phi_mem_skewSub x y⟩ : skewSub ι) : Matrix ι ι ℝ) a b *
        ((T ⟨phi x y, phi_mem_skewSub x y⟩ : skewSub ι) : Matrix ι ι ℝ) a b :=
      fun a => Finset.sum_nonneg fun b _ => mul_self_nonneg _
    have := Finset.sum_nonneg fun a (_ : a ∈ (Finset.univ : Finset ι)) => this a
    linarith
  have hrow := (Finset.sum_eq_zero_iff_of_nonneg hnn).mp h i (Finset.mem_univ i)
  have hj := (Finset.sum_eq_zero_iff_of_nonneg
    (fun y (_ : y ∈ (Finset.univ : Finset ι)) => by
      rw [inner2_eq_sum]
      have : ∀ a : ι, (0:ℝ) ≤ ∑ b : ι,
          ((T ⟨phi i y, phi_mem_skewSub i y⟩ : skewSub ι) : Matrix ι ι ℝ) a b *
          ((T ⟨phi i y, phi_mem_skewSub i y⟩ : skewSub ι) : Matrix ι ι ℝ) a b :=
        fun a => Finset.sum_nonneg fun b _ => mul_self_nonneg _
      have := Finset.sum_nonneg fun a (_ : a ∈ (Finset.univ : Finset ι)) => this a
      linarith)).mp hrow j (Finset.mem_univ j)
  exact Subtype.ext (inner2_self_eq_zero hj)

/-! ## The norm, from the record's OWN pairing

**[r1005](../../../reviews/REVIEW_r1005.md) ranks this first among what remains**, *because the
operator norm and Frobenius state different unit spheres and the topology cannot tell them apart,
so leaving it unchosen leaves every unit-norm hypothesis ambiguous.*

**The record has already chosen.** `inner2` is its pairing, and under it `⟨φ_ij, φ_ij⟩ = 1`, so the
`φ` family is orthonormal and `‖diagOp w‖² = 1` is the record's `tr M² = 2`. *Taking anything else
would state a different unit sphere from the one every recorded value was computed on.*
-/

/-- **`Λ²` as an inner product space, over the record's own pairing.** -/
noncomputable def skewCore : InnerProductSpace.Core ℝ (skewSub ι) where
  inner X Y := inner2 (X : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ)
  conj_inner_symm X Y := by simpa using inner2_comm (Y : Matrix ι ι ℝ) (X : Matrix ι ι ℝ)
  re_inner_nonneg X := by simpa using inner2_self_nonneg (X : Matrix ι ι ℝ)
  add_left X Y Z := by simpa using inner2_add_left (X : Matrix ι ι ℝ) Y Z
  smul_left X Y r := by simpa using inner2_smul_left (X : Matrix ι ι ℝ) Y r
  definite X h := Subtype.ext (inner2_self_eq_zero h)

/-! **THE INSTANCES ARE NOT REGISTERED, AND A FIRST VERSION REGISTERED THEM**
([r1006](../../../reviews/REVIEW_r1006.md)). *`toNormedAddCommGroup` builds its own topology, which
is NOT the subtype one already on `skewSub`, so registering it left `TopologicalSpace` and
`UniformSpace` resolving to the subtype instances while `Bornology` came from the new metric.*
**Nothing carried a `Bornology` before, at `Matrix` or at `skewSub`** ([r1007](../../../reviews/REVIEW_r1007.md)),
*so the instance filled an empty level inconsistently rather than shadowing a populated one.*
**That is harmless as mathematics, `Λ²` being finite-dimensional, and a hazard as plumbing.**

**The repair is `toNormedAddCommGroupOfTopology`**, which adjusts the topology to the existing one,
at the price of two side conditions: `ContinuousAt (fun v => ⟪v, v⟫) 0`, *which `fun_prop` closes
once `inner2` is unfolded*, and `IsVonNBounded ℝ {v | ⟪v, v⟫ < 1}`, which is locally-convex
machinery and is what remains.

**`skewCore` stays as a definition**, so the pairing and its five properties are on file and the
instance is one lemma away. *Nothing mathematical is lost: `inner2_self_phi` already states
`⟪φ_ij, φ_ij⟫ = 1`, which is what `‖φ_ij‖ = 1` would have said.*

**And the instance would not have supplied the operator norm in any case**
([r1006](../../../reviews/REVIEW_r1006.md)): *Mathlib's `ContinuousLinearMap` norm is the SUP norm
where the record's is Hilbert-Schmidt, and the two disagree on this file's own witness.* -/

/-! ## The operator type [I36](../../../plan.md) can be stated over

**`IsLocalMaxOn` elaborates over `CurvOp2` and over neither `CurvLin` nor `Module.End`**, because
Mathlib puts no topology on `LinearMap`. *That much is true and is what the change is for on the
statement side.*

**WHAT SUPPLIES THE TOPOLOGY IS THE ARROW, NOT THE DOMAIN, AND A FIRST VERSION OF THIS SECTION SAID
OTHERWISE** ([r1005](../../../reviews/REVIEW_r1005.md)). *`CurvOp2` carries no `Norm` at all: it
elaborates through the subtype instance of the global product topology on matrices, and the
`open scoped Matrix.Norms.Frobenius` a first version opened was INERT, the same type being
`rfl`-equal declared outside it.* **The old domain would have served equally**, `Matrix →L[ℝ]
Matrix` carrying a topology and `IsLocalMaxOn` elaborating over it.

**The product topology is the right one here, for a reason the earlier objection did not reach.**
*`skewSub (Fin n)` is finite-dimensional, which synthesizes free, and a finite-dimensional real
vector space carries exactly one Hausdorff linear topology, so there is nothing to choose.* **The
coarseness that made `IsLocalMaxOn` wrong on the bare function type came from its INFINITE domain**,
which this type does not have.

**So the change of domain buys DEFINITENESS and not the topology**, and definiteness is what
[WeylRadical.lean](../Results/WeylRadical.lean) shows the old domain cannot have.

**THE NORM ON `Λ²` IS BUILT ABOVE, AND THE OPERATOR NORM ON `CurvOp2` IS NOT.** *`skewCore` carries the record's own pairing and is NOT registered as an instance, for the reason
above.*

**A FIRST VERSION CLAIMED THE TOPOLOGIES AGREED AND CHECKED IT WITH A BLIND `rfl`**
([r1006](../../../reviews/REVIEW_r1006.md)). *The check compared `inferInstance` against
`instTopologicalSpaceSubtype`, and `inferInstance` RESOLVES to that subtype instance, so it compared
one thing with itself and could not fail.* **Against the norm's own topology it fails**, which
`with_unfolding_all rfl` reports. *A control that cannot distinguish the claim from its competitor
is not a control, and this is the second time that shape has been recorded here.*

**A `Norm` INSTANCE IS ON THE CRITICAL PATH, AND A VERSION OF THIS SECTION ARGUED IT WAS NOT**
([r1007](../../../reviews/REVIEW_r1007.md)). *Both facts that argument rested on are true:
`IsLocalMaxOn` over `CurvOp2` elaborates with no `Norm`, and the `RealLayer` files state unit norm
as `normSq R = 1` rather than `‖R‖ = 1`.* **The INFERENCE fails, on Fermat's theorem.**
`IsLocalMaxOn.fderivWithin_nonpos` and its siblings sit under `[NormedAddCommGroup E]
[NormedSpace ℝ E]`, so they are rejected at `CurvOp2` and accepted at `EuclideanSpace`, which is
the control. *So the step from a local maximiser to a critical point, which is the whole of
[I75](../../../plan.md) and hence [I36](../../../plan.md), needs a topology before it can be
written at all.* **HAVING ONE IS NOT THE STEP**, and a first version of this note said it was
([r1012](../../../reviews/REVIEW_r1012.md)): *the form that elaborates once the topology arrives
is the `fderivWithin` one, which the constraint set makes unusable, see the note under it below.*

**The error was asking whether `IsLocalMaxOn` could be STATED and never whether it could be USED.**
*What survives the attack is the calculus vocabulary: `fderivWithin`, `posTangentConeAt` and
`DifferentiableAt` are TVS-general here and do elaborate with no norm. The gap is Fermat alone.*

**And "never as `‖R‖ = 1`" is true of the `RealLayer` files and false of the layer read whole**:
[L13Statement.lean](../Results/L13Statement.lean) states the record's own unit sphere that way,
over `[NormedAddCommGroup V] [InnerProductSpace ℝ V]`.

**A scoped matrix norm is diamond-free, and the property is not special to the elementwise one.**
*`Matrix.Norms.Elementwise` has topology DEFEQ to the instance already on `Matrix` and at `skewSub`,
each checked against a control that fails on `⊥`.* **Frobenius passes the same check**
([r1007](../../../reviews/REVIEW_r1007.md)), *so what the property names is Mathlib's Pi-based
construction rather than the elementwise norm.* **Neither scope makes `Norm (CurvOp2)`
synthesize**, so neither closes the gap Fermat leaves.
-/

/-- **A curvature operator with `Λ²` as its domain.** *Continuous-linear, which is what carries the
topology. In finite dimensions every linear map is continuous, `T.continuous_of_finiteDimensional`,
so this holds every operator the linear type did.* -/
abbrev CurvOp2 (ι : Type*) [Fintype ι] [DecidableEq ι] := skewSub ι →L[ℝ] skewSub ι

/-- **`IsLocalMaxOn` is writable over `CurvOp2`**, which fails over both of the layer's existing
operator types. *Stated as a definition rather than asserted in prose, so the elaborator is what
confirms it.* -/
def IsLocalMaxOver {ι : Type*} [Fintype ι] [DecidableEq ι]
    (f : CurvOp2 ι → ℝ) (s : Set (CurvOp2 ι)) (R : CurvOp2 ι) : Prop :=
  IsLocalMaxOn f s R

/-- **`Λ²` is finite-dimensional**, which is the real justification for the topology above and which
a first version neither proved nor invoked ([r1005](../../../reviews/REVIEW_r1005.md)). -/
theorem finiteDimensional_skewSub (ι : Type*) [Fintype ι] [DecidableEq ι] :
    FiniteDimensional ℝ (skewSub ι) := inferInstance

/-! ## `normSq` transported, which is what `CurvOp2` actually owed

**The record states unit norm as `normSq R = 1`, so this is the definition that carries every such
hypothesis across.** *It is `innerOp` with the domain changed and nothing else, the `½` being the
ordered-pair doubling exactly as in [WeylReal.lean](WeylReal.lean).*

**And here it is DEFINITE, which is the whole of what the change of domain bought.**
-/

section Transport

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- `R` evaluated on the basis bivector `φ_ij`, as a matrix. -/
abbrev applyPhi (R : CurvOp2 ι) (i j : ι) : Matrix ι ι ℝ :=
  ((R ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ)

/-- **`⟨R, S⟩` on `Λ²`**, the record's `innerOp` with the domain changed. -/
noncomputable def innerOp2 (R S : CurvOp2 ι) : ℝ :=
  (1/2) * ∑ i : ι, ∑ j : ι, inner2 (applyPhi R i j) (applyPhi S i j)

/-- **`‖R‖²` on `Λ²`**, which is how the record writes a unit-norm hypothesis. -/
noncomputable def normSq2 (R : CurvOp2 ι) : ℝ := innerOp2 R R

/-- **AND IT IS DEFINITE**: `‖R‖² = 0` forces `R = 0`. *This is what
[WeylRadical.lean](../Results/WeylRadical.lean) shows the old domain cannot have, where a whole
`Hom(Sym, M)` of nonzero operators has `normSq = 0`.* -/
theorem normSq2_eq_zero {R : CurvOp2 ι} (h : normSq2 R = 0) : R = 0 := by
  have hsum : ∑ i : ι, ∑ j : ι, inner2 (applyPhi R i j) (applyPhi R i j) = 0 := by
    unfold normSq2 innerOp2 at h
    linarith
  have hlin : (R : skewSub ι →ₗ[ℝ] skewSub ι) = 0 := eq_zero_of_phi_sq_sum _ hsum
  refine ContinuousLinearMap.ext fun x => ?_
  have hx := congrArg (fun T : skewSub ι →ₗ[ℝ] skewSub ι => T x) hlin
  simpa using hx

/-- **THE BRACKET RESTRICTS TO `Λ²`**, which is the gateway to `sharpQF` on this domain.
*`(XY - YX)ᵀ = YᵀXᵀ - XᵀYᵀ = YX - XY` at skew `X` and `Y`, the two signs cancelling.*
**IT IS ENOUGH ON ITS OWN TO WRITE `sharpQF` HERE** ([r1007](../../../reviews/REVIEW_r1007.md)),
*only the bundling of `sharpOp` remaining owed after it.* -/
theorem br_mem_skewSub {X Y : Matrix ι ι ℝ} (hX : IsSkew X) (hY : IsSkew Y) :
    br X Y ∈ skewSub ι := by
  show (br X Y)ᵀ = -br X Y
  unfold br
  rw [Matrix.transpose_sub, Matrix.transpose_mul, Matrix.transpose_mul,
    show Xᵀ = -X from hX, show Yᵀ = -Y from hY]
  simp only [Matrix.neg_mul, Matrix.mul_neg, neg_neg]
  abel

/-- **`R ∘ R` on `Λ²`**, which is `compOp` with the domain changed. -/
noncomputable def compOp2 (R : CurvOp2 ι) : CurvOp2 ι := R.comp R

/-- **`⟨R², R⟩` on `Λ²`**, the record's `trCube` with the domain changed. *And the change of domain
makes it a FUNCTION OF THE OPERATOR'S RESTRICTION to `Λ²`, which on the bare type it is not*
([r1007](../../../reviews/REVIEW_r1007.md)). **IT IS `tr R³` AT A SELF-ADJOINT `R`, AND THE NAME
SAID SO UNCONDITIONALLY** ([r1012](../../../reviews/REVIEW_r1012.md)): *`innerOp2 A C` is
`tr(A* C)` for the adjoint taken against `inner2`, so the trace reading is licensed by `R* = R`,
which `IsWeyl2`'s second clause supplies and the bare definition does not.*

**"AND NOT OTHERWISE" WOULD BE FALSE, AND A FIRST REPAIR OF THIS DOCSTRING WROTE IT**
([r1013](../../../reviews/REVIEW_r1013.md)): *at a SKEW-adjoint `R` both sides are `0`, since
`(R²)* = R²` and `tr R³ = -tr R³`.* **What self-adjointness buys is that the identity holds at
EVERY `R`, not that it fails elsewhere**, which is a correction overcorrecting. -/
noncomputable def trCube2 (R : CurvOp2 ι) : ℝ := innerOp2 (compOp2 R) R

/-- **`innerOp2` is symmetric**, as the record's pairing is. -/
theorem innerOp2_comm (R S : CurvOp2 ι) : innerOp2 R S = innerOp2 S R := by
  unfold innerOp2
  congr 1
  exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
    inner2_comm (applyPhi R i j) (applyPhi S i j)

end Transport

/-! ## `IsWeyl` native to this domain

**The record's `IsWeyl` has four clauses and the FIRST IS FREE HERE**, the codomain being `Λ²`.
*[WeylReal.lean](WeylReal.lean) records that clause as load-bearing and once absent, and that an
audit built a symmetric-valued operator satisfying every other clause with `Pcubic = 3` against
`√(3/2)`, which made `ProblemP` a FALSE proposition.* **On this domain no such operator can be
written**, so the trap is closed by the type rather than by a hypothesis a reader must remember.

**The other three are the record's, verbatim.**
-/

section Weyl

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`𝒲ₙ` on `Λ²`.** *Three clauses where the record has four: the first, that bivectors go to
bivectors, is the type.* -/
structure IsWeyl2 (R : CurvOp2 ι) : Prop where
  /-- Self-adjoint against the pairing, on bivectors. -/
  selfAdjoint : ∀ X Y : skewSub ι,
    inner2 ((R X : skewSub ι) : Matrix ι ι ℝ) ((Y : skewSub ι) : Matrix ι ι ℝ)
      = inner2 ((X : skewSub ι) : Matrix ι ι ℝ) ((R Y : skewSub ι) : Matrix ι ι ℝ)
  /-- First Bianchi. -/
  bianchi : ∀ i j k l : ι,
    inner2 (applyPhi R i j) (phi k l) + inner2 (applyPhi R i k) (phi l j)
      + inner2 (applyPhi R i l) (phi j k) = 0
  /-- Ricci-flat. -/
  ric : ∀ a b : ι, ∑ c : ι, inner2 (applyPhi R a c) (phi b c) = 0

/-! **THE RECORD'S `IsWeyl` FORCES LINEARITY ON `Λ²`, AND THE REACH IS EXACTLY THAT.** *The
argument is the one `Rphi_swap` uses: the defect is skew by clause one, self-adjointness at three
arguments collapses its self-pairing to `⟨0, R Z⟩`, and the pairing is a sum of squares.*

**IT DOES NOT MAKE [FoxProduct.lean](FoxProduct.lean)'s `IsLinOp` REDUNDANT, AND A FIRST VERSION OF
THIS NOTE SAID IT DID** ([r1010](../../../reviews/REVIEW_r1010.md)). *`IsLinOp` quantifies over ALL
matrices, so `IsWeylOp` is strictly stronger than `IsWeyl`*: at `n = 2` the operator sending every
skew matrix to `0` and everything else to `1` satisfies all four `IsWeyl` clauses and fails
additivity at the identity, and `compOp_smul` with its hypothesis deleted is FALSE there.
**So the predicate is load-bearing off `Λ²`**, and the saving is the one already banked in
`CurvOp2`'s type rather than one available to the existing layer. -/

/-- **Additive on `Λ²`**, from `IsWeyl` alone. -/
theorem isWeyl_add {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl R)
    {X Y : Matrix ι ι ℝ} (hX : IsSkew X) (hY : IsSkew Y) :
    R (X + Y) = R X + R Y := by
  have hXY : IsSkew (X + Y) := (skewSub ι).add_mem hX hY
  set Z := R (X + Y) - R X - R Y with hZ
  have hs : IsSkew Z := by
    have h1 := hW.1 _ hXY
    have h2 := hW.1 _ hX
    have h3 := hW.1 _ hY
    show Matrix.transpose Z = -Z
    rw [hZ, Matrix.transpose_sub, Matrix.transpose_sub,
      show Matrix.transpose (R (X + Y)) = -R (X + Y) from h1,
      show Matrix.transpose (R X) = -R X from h2,
      show Matrix.transpose (R Y) = -R Y from h3]
    abel
  have hzero : inner2 Z Z = 0 := by
    have e : inner2 Z Z
        = inner2 (R (X + Y)) Z - inner2 (R X) Z - inner2 (R Y) Z := by
      nth_rewrite 1 [hZ]
      rw [inner2_sub_left, inner2_sub_left]
    rw [e, hW.2.1 _ _ hXY hs, hW.2.1 _ _ hX hs, hW.2.1 _ _ hY hs,
      inner2_comm, inner2_comm X, inner2_comm Y, inner2_add_right]
    ring
  have := inner2_self_eq_zero hzero
  rw [hZ] at this
  have h : R (X + Y) - R X - R Y = 0 := this
  linear_combination (norm := abel) h

/-- **Homogeneous on `Λ²`**, from `IsWeyl` alone. -/
theorem isWeyl_smul {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl R)
    (c : ℝ) {X : Matrix ι ι ℝ} (hX : IsSkew X) : R (c • X) = c • R X := by
  have hcX : IsSkew (c • X) := (skewSub ι).smul_mem c hX
  set Z := R (c • X) - c • R X with hZ
  have hs : IsSkew Z := by
    have h1 := hW.1 _ hcX
    have h2 := hW.1 _ hX
    show Matrix.transpose Z = -Z
    rw [hZ, Matrix.transpose_sub, Matrix.transpose_smul,
      show Matrix.transpose (R (c • X)) = -R (c • X) from h1,
      show Matrix.transpose (R X) = -R X from h2, smul_neg]
    abel
  have hzero : inner2 Z Z = 0 := by
    have e : inner2 Z Z = inner2 (R (c • X)) Z - c * inner2 (R X) Z := by
      nth_rewrite 1 [hZ]
      rw [inner2_sub_left, HamiltonsCubic.RealLayer.inner2_smul_left]
    rw [e, hW.2.1 _ _ hcX hs, hW.2.1 _ _ hX hs, inner2_comm, inner2_comm X,
      HamiltonsCubic.FamilyLayer.inner2_smul_right]
    ring
  have h := inner2_self_eq_zero hzero
  rw [hZ] at h
  have h' : R (c • X) - c • R X = 0 := h
  linear_combination (norm := module) h'

/-- **The clause the type supplies**, stated so the saving is visible rather than implicit. -/
theorem curvOp2_maps_bivectors (R : CurvOp2 ι) (X : skewSub ι) :
    IsSkew ((R X : skewSub ι) : Matrix ι ι ℝ) := (R X).2

/-- **The zero operator is a Weyl operator**, so the class is inhabited. -/
theorem isWeyl2_zero : IsWeyl2 (0 : CurvOp2 ι) where
  selfAdjoint X Y := by simp [inner2]
  bianchi i j k l := by
    have h : ∀ p q : ι, applyPhi (0 : CurvOp2 ι) p q = 0 := by
      intro p q; show ((0 : skewSub ι) : Matrix ι ι ℝ) = 0; rfl
    rw [h, h, h]
    simp [inner2]
  ric a b := by
    have h : ∀ c : ι, inner2 (applyPhi (0 : CurvOp2 ι) a c) (phi b c) = 0 := by
      intro c
      rw [show applyPhi (0 : CurvOp2 ι) a c = 0 from rfl]
      simp [inner2]
    simp [h]

end Weyl

/-! ## `sharpQF` on the new domain

**[r1007](../../../reviews/REVIEW_r1007.md) found `br_mem_skewSub` already enough for this**, which
the file had not claimed. *`sharpQF` is a double bracket with the operator between the brackets, so
once the bracket returns a bivector the whole expression stays inside `Λ²` and nothing further is
needed.*
-/

section Sharp

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The bracket as an operation on `Λ²`**, which `br_mem_skewSub` licenses. -/
noncomputable def brS (X Y : skewSub ι) : skewSub ι :=
  ⟨br (X : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ), br_mem_skewSub X.2 Y.2⟩

/-- **The bracket is additive in its first slot**, on `Λ²`. -/
theorem brS_add_left (X Y Z : skewSub ι) : brS (X + Y) Z = brS X Z + brS Y Z := by
  apply Subtype.ext
  show br ((X : Matrix ι ι ℝ) + (Y : Matrix ι ι ℝ)) (Z : Matrix ι ι ℝ) = _
  show _ = br (X : Matrix ι ι ℝ) (Z : Matrix ι ι ℝ) + br (Y : Matrix ι ι ℝ) (Z : Matrix ι ι ℝ)
  simp [br, Matrix.add_mul, Matrix.mul_add]
  abel

/-- **And additive in its second slot.** -/
theorem brS_add_right (X Y Z : skewSub ι) : brS X (Y + Z) = brS X Y + brS X Z := by
  apply Subtype.ext
  show br (X : Matrix ι ι ℝ) ((Y : Matrix ι ι ℝ) + (Z : Matrix ι ι ℝ)) = _
  show _ = br (X : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) + br (X : Matrix ι ι ℝ) (Z : Matrix ι ι ℝ)
  simp [br, Matrix.add_mul, Matrix.mul_add]
  abel

/-- **The bracket is homogeneous in its first slot**, the scalar half of bilinearity. -/
theorem brS_smul_left (c : ℝ) (X Y : skewSub ι) : brS (c • X) Y = c • brS X Y := by
  apply Subtype.ext
  show br (c • (X : Matrix ι ι ℝ)) (Y : Matrix ι ι ℝ) = c • br (X : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ)
  simp [br, Matrix.smul_mul, Matrix.mul_smul, smul_sub]

/-- **And in its second.** -/
theorem brS_smul_right (c : ℝ) (X Y : skewSub ι) : brS X (c • Y) = c • brS X Y := by
  apply Subtype.ext
  show br (X : Matrix ι ι ℝ) (c • (Y : Matrix ι ι ℝ)) = c • br (X : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ)
  simp [br, Matrix.smul_mul, Matrix.mul_smul, smul_sub]

/-- **`⟨R# η, η⟩` on `Λ²`**, the record's `sharpQF` with the domain changed. *The `¼` is the `½` of
the definition times the `½` paying for the ordered-pair double count, exactly as in
[WeylReal.lean](WeylReal.lean).* -/
noncomputable def sharpQF2 (R : CurvOp2 ι) (η : skewSub ι) : ℝ :=
  -(1/4) * ∑ i : ι, ∑ j : ι,
    inner2 ((brS η (R (brS η (R ⟨phi i j, phi_mem_skewSub i j⟩)))) : Matrix ι ι ℝ) (phi i j)

/-- **The composite `sharpQF2` sums**, named so its expansion can be stated. -/
noncomputable def sharpTerm (R : CurvOp2 ι) (η : skewSub ι) (i j : ι) : skewSub ι :=
  brS η (R (brS η (R ⟨phi i j, phi_mem_skewSub i j⟩)))

/-- **THE COMPOSITE IS QUADRATIC IN `η`, AND HERE IS THE EXPANSION.** *Both brackets are additive
in their own slots and `R` is additive, so the composite at `X + Y` is the two pure terms plus the
two crossed ones.*

**IT GIVES `sharpBil2` ADDITIVITY IN BOTH SLOTS AND NOT BILINEARITY**
([r1010](../../../reviews/REVIEW_r1010.md)): *homogeneity needs the bracket's scalar half as well,
`brS_smul_left` and `brS_smul_right` above.* **BOTH HALVES ARE NOW PROVED**, by the crossed term
below rather than by this expansion, as `sharpBil2_add_left` and `sharpBil2_smul_left`, and
`sharpMapL` is the bundling they carry. -/
theorem sharpTerm_add (R : CurvOp2 ι) (X Y : skewSub ι) (i j : ι) :
    sharpTerm R (X + Y) i j
      = sharpTerm R X i j + brS X (R (brS Y (R ⟨phi i j, phi_mem_skewSub i j⟩)))
        + brS Y (R (brS X (R ⟨phi i j, phi_mem_skewSub i j⟩))) + sharpTerm R Y i j := by
  unfold sharpTerm
  simp only [brS_add_left, map_add, brS_add_right]
  abel

/-- **`⟨R# X, Y⟩` by polarisation**, the record's `sharpBil` with the domain changed. -/
noncomputable def sharpBil2 (R : CurvOp2 ι) (X Y : skewSub ι) : ℝ :=
  (1/2) * (sharpQF2 R (X + Y) - sharpQF2 R X - sharpQF2 R Y)

/-- **`sharpQF2` vanishes at `0`**, the bracket with `0` being `0`. -/
theorem sharpQF2_zero (R : CurvOp2 ι) : sharpQF2 R 0 = 0 := by
  unfold sharpQF2
  have h : ∀ i j : ι,
      inner2 ((brS (0 : skewSub ι) (R (brS (0 : skewSub ι)
        (R ⟨phi i j, phi_mem_skewSub i j⟩)))) : Matrix ι ι ℝ) (phi i j) = 0 := by
    intro i j
    have hz : ((brS (0 : skewSub ι) (R (brS (0 : skewSub ι)
        (R ⟨phi i j, phi_mem_skewSub i j⟩)))) : Matrix ι ι ℝ) = 0 := by
      show br (0 : Matrix ι ι ℝ) _ = 0
      simp [br]
    rw [hz]
    simp [inner2]
  simp [h]

/-! ### Bilinearity, and the bundling of `sharpMap`

**`sharpTerm_add` gives ADDITIVITY alone** ([r1010](../../../reviews/REVIEW_r1010.md)), *so the
route to a `LinearMap` runs through the crossed term rather than through that expansion.* **Name
the crossed term, show it is linear in each slot, and `sharpBil2` is the symmetrised sum of two
of them**, at which point each half of bilinearity is one rewrite.
-/

/-- **The crossed term of the expansion**, `[X, R[Y, Rφ]]`, with `sharpTerm` its diagonal. -/
noncomputable def crossTerm2 (R : CurvOp2 ι) (X Y : skewSub ι) (i j : ι) : skewSub ι :=
  brS X (R (brS Y (R ⟨phi i j, phi_mem_skewSub i j⟩)))

/-- **`sharpTerm` is the crossed term on the diagonal.** -/
theorem sharpTerm_eq_cross (R : CurvOp2 ι) (X : skewSub ι) (i j : ι) :
    sharpTerm R X i j = crossTerm2 R X X i j := rfl

/-- **Additive in the outer slot**, by the bracket's own first slot. -/
theorem crossTerm2_add_left (R : CurvOp2 ι) (X X' Y : skewSub ι) (i j : ι) :
    crossTerm2 R (X + X') Y i j = crossTerm2 R X Y i j + crossTerm2 R X' Y i j := by
  unfold crossTerm2
  rw [brS_add_left]

/-- **Additive in the inner slot**, which passes through `R`. -/
theorem crossTerm2_add_right (R : CurvOp2 ι) (X Y Y' : skewSub ι) (i j : ι) :
    crossTerm2 R X (Y + Y') i j = crossTerm2 R X Y i j + crossTerm2 R X Y' i j := by
  unfold crossTerm2
  rw [brS_add_left, map_add, brS_add_right]

/-- **Homogeneous in the outer slot.** -/
theorem crossTerm2_smul_left (R : CurvOp2 ι) (c : ℝ) (X Y : skewSub ι) (i j : ι) :
    crossTerm2 R (c • X) Y i j = c • crossTerm2 R X Y i j := by
  unfold crossTerm2
  rw [brS_smul_left]

/-- **Homogeneous in the inner slot.** -/
theorem crossTerm2_smul_right (R : CurvOp2 ι) (c : ℝ) (X Y : skewSub ι) (i j : ι) :
    crossTerm2 R X (c • Y) i j = c • crossTerm2 R X Y i j := by
  unfold crossTerm2
  rw [brS_smul_left, map_smul, brS_smul_right]

/-- **`sharpQF2`'s summand with the two slots separated.** -/
noncomputable def crossPair2 (R : CurvOp2 ι) (X Y : skewSub ι) : ℝ :=
  -(1/4) * ∑ i : ι, ∑ j : ι,
    inner2 ((crossTerm2 R X Y i j : skewSub ι) : Matrix ι ι ℝ) (phi i j)

/-- **`sharpQF2` is the crossed pairing on the diagonal.** -/
theorem sharpQF2_eq_crossPair2 (R : CurvOp2 ι) (X : skewSub ι) :
    sharpQF2 R X = crossPair2 R X X := rfl

theorem crossPair2_add_left (R : CurvOp2 ι) (X X' Y : skewSub ι) :
    crossPair2 R (X + X') Y = crossPair2 R X Y + crossPair2 R X' Y := by
  unfold crossPair2
  rw [← mul_add, ← Finset.sum_add_distrib]
  congr 1
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [crossTerm2_add_left, Submodule.coe_add]
  exact inner2_add_left _ _ _

theorem crossPair2_add_right (R : CurvOp2 ι) (X Y Y' : skewSub ι) :
    crossPair2 R X (Y + Y') = crossPair2 R X Y + crossPair2 R X Y' := by
  unfold crossPair2
  rw [← mul_add, ← Finset.sum_add_distrib]
  congr 1
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [crossTerm2_add_right, Submodule.coe_add]
  exact inner2_add_left _ _ _

theorem crossPair2_smul_left (R : CurvOp2 ι) (c : ℝ) (X Y : skewSub ι) :
    crossPair2 R (c • X) Y = c * crossPair2 R X Y := by
  unfold crossPair2
  have h : ∀ i : ι, (∑ j : ι, inner2 ((crossTerm2 R (c • X) Y i j : skewSub ι) : Matrix ι ι ℝ) (phi i j))
      = c * ∑ j : ι, inner2 ((crossTerm2 R X Y i j : skewSub ι) : Matrix ι ι ℝ) (phi i j) := by
    intro i
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [crossTerm2_smul_left, Submodule.coe_smul]
    exact inner2_smul_left _ _ c
  rw [Finset.sum_congr rfl fun i _ => h i, ← Finset.mul_sum]
  ring

theorem crossPair2_smul_right (R : CurvOp2 ι) (c : ℝ) (X Y : skewSub ι) :
    crossPair2 R X (c • Y) = c * crossPair2 R X Y := by
  unfold crossPair2
  have h : ∀ i : ι, (∑ j : ι, inner2 ((crossTerm2 R X (c • Y) i j : skewSub ι) : Matrix ι ι ℝ) (phi i j))
      = c * ∑ j : ι, inner2 ((crossTerm2 R X Y i j : skewSub ι) : Matrix ι ι ℝ) (phi i j) := by
    intro i
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [crossTerm2_smul_right, Submodule.coe_smul]
    exact inner2_smul_left _ _ c
  rw [Finset.sum_congr rfl fun i _ => h i, ← Finset.mul_sum]
  ring

/-- **THE POLARISATION IS THE SYMMETRISED CROSSED PAIRING.** *`crossPair2` at `X + Y` expands into
four terms by linearity in each slot, the two pure ones cancel against the definition's two
subtractions, and the two crossed ones remain.* **THE PROOF USES `sharpTerm_add` NOWHERE, AND A
FIRST VERSION OF THIS DOCSTRING CREDITED IT** ([r1011](../../../reviews/REVIEW_r1011.md)): *that
expansion is at a single index pair and additive by construction, which is the reach
[r1010](../../../reviews/REVIEW_r1010.md) established, and the route here replaces it rather than
building on it.* -/
theorem sharpBil2_eq (R : CurvOp2 ι) (X Y : skewSub ι) :
    sharpBil2 R X Y = (1/2) * (crossPair2 R X Y + crossPair2 R Y X) := by
  unfold sharpBil2
  rw [sharpQF2_eq_crossPair2, sharpQF2_eq_crossPair2, sharpQF2_eq_crossPair2,
    crossPair2_add_left, crossPair2_add_right, crossPair2_add_right]
  ring

/-- **`sharpBil2` is symmetric**, the polarisation of a quadratic form. -/
theorem sharpBil2_comm (R : CurvOp2 ι) (X Y : skewSub ι) :
    sharpBil2 R X Y = sharpBil2 R Y X := by
  rw [sharpBil2_eq, sharpBil2_eq]
  ring

/-- **Additive in its first slot.** -/
theorem sharpBil2_add_left (R : CurvOp2 ι) (X X' Y : skewSub ι) :
    sharpBil2 R (X + X') Y = sharpBil2 R X Y + sharpBil2 R X' Y := by
  rw [sharpBil2_eq, sharpBil2_eq, sharpBil2_eq, crossPair2_add_left, crossPair2_add_right]
  ring

/-- **Homogeneous in its first slot.** *With `sharpBil2_add_left` this is the bilinearity
[r1010](../../../reviews/REVIEW_r1010.md) found the expansion alone does not give.* -/
theorem sharpBil2_smul_left (R : CurvOp2 ι) (c : ℝ) (X Y : skewSub ι) :
    sharpBil2 R (c • X) Y = c * sharpBil2 R X Y := by
  rw [sharpBil2_eq, sharpBil2_eq, crossPair2_smul_left, crossPair2_smul_right]
  ring

/-! **AND THE SECOND SLOT COMES FREE FROM `sharpBil2_comm`**, which is worth stating because
[WeylReal.lean](WeylReal.lean) records linearity of `sharpBil` in its second slot as a debt and says
it is *not visible here* ([r1012](../../../reviews/REVIEW_r1012.md)). *On `Λ²` the symmetric
polarisation plus left-linearity IS that debt discharged, so `sharpMap` earns the name `R#`: it
reassembles a genuinely linear functional's coordinates rather than an arbitrary one's.* -/

/-- **Additive in its second slot.** -/
theorem sharpBil2_add_right (R : CurvOp2 ι) (X Y Y' : skewSub ι) :
    sharpBil2 R X (Y + Y') = sharpBil2 R X Y + sharpBil2 R X Y' := by
  rw [sharpBil2_comm, sharpBil2_add_left, sharpBil2_comm R Y X, sharpBil2_comm R Y' X]

/-- **And homogeneous in it.** -/
theorem sharpBil2_smul_right (R : CurvOp2 ι) (c : ℝ) (X Y : skewSub ι) :
    sharpBil2 R X (c • Y) = c * sharpBil2 R X Y := by
  rw [sharpBil2_comm, sharpBil2_smul_left, sharpBil2_comm R Y X]

/-- **`R#` as a map on `Λ²`**, expanded in the `φ` family with the ordered-pair doubling.
*It lands in `Λ²` by construction, the `φ` being bivectors.* **THAT IS NOT A CONTRAST WITH THE
RECORD'S VERSION, AND A FIRST VERSION CLAIMED IT WAS** ([r1008](../../../reviews/REVIEW_r1008.md)):
`sharpOp` lands there too, at an ARBITRARY bare operator and an ARBITRARY matrix, with no
hypothesis to drop. *What the change of domain buys here is that arguments where the coordinate
reading is unlicensed, `skew_expand` needing `IsSkew`, are removed from the type.* -/
noncomputable def sharpMap (R : CurvOp2 ι) (X : skewSub ι) : skewSub ι :=
  (1/2 : ℝ) • ∑ i : ι, ∑ j : ι,
    (sharpBil2 R X ⟨phi i j, phi_mem_skewSub i j⟩) • (⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι)

/-- **`R#` AS A LINEAR MAP**, linear in its BIVECTOR argument. *Both halves come from `sharpBil2`,
additive by `sharpBil2_add_left` and homogeneous by `sharpBil2_smul_left`.*

**WHAT IT BUYS IS THAT `Q(R) = R² + R#` IS AN OPERATOR**, so `Q(R) = θ R` can be stated as an
equation in `CurvOp2` rather than pointwise on the `φ` family as the record's `IsCritical` states
it. **IT IS NOT WHAT FERMAT'S OUTPUT IS READ AGAINST, AND A FIRST VERSION SAID IT WAS**
([r1011](../../../reviews/REVIEW_r1011.md)): *Fermat differentiates `Pcubic2` in `R`, where the
form is CUBIC, and linearity in `X` says nothing about that derivative.* **The type also stops one
constructor short of `CurvOp2`**, which is `→L[ℝ]`; `sharpMapCL` below closes it. -/
noncomputable def sharpMapL (R : CurvOp2 ι) : skewSub ι →ₗ[ℝ] skewSub ι where
  toFun := sharpMap R
  map_add' X X' := by
    unfold sharpMap
    rw [← smul_add, ← Finset.sum_add_distrib]
    congr 1
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [sharpBil2_add_left, add_smul]
  map_smul' c X := by
    unfold sharpMap
    have h : ∀ i : ι,
        (∑ j : ι, (sharpBil2 R (c • X) ⟨phi i j, phi_mem_skewSub i j⟩) •
          (⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι))
        = c • ∑ j : ι, (sharpBil2 R X ⟨phi i j, phi_mem_skewSub i j⟩) •
          (⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) := by
      intro i
      rw [Finset.smul_sum]
      refine Finset.sum_congr rfl fun j _ => ?_
      rw [sharpBil2_smul_left, smul_smul]
    rw [Finset.sum_congr rfl fun i _ => h i, ← Finset.smul_sum, smul_comm]
    rfl

/-- **The bundling computes the map it bundles.** -/
theorem sharpMapL_apply (R : CurvOp2 ι) (X : skewSub ι) : sharpMapL R X = sharpMap R X := rfl


/-- **`⟨R, R#⟩` on `Λ²`**, the record's `sharpPair` with the domain changed. -/
noncomputable def sharpPair2 (R : CurvOp2 ι) : ℝ :=
  (1/2) * ∑ i : ι, ∑ j : ι,
    inner2 (applyPhi R i j) ((sharpMap R ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ)

/-- **`P(R) = ⟨R, R² + R#⟩` ON `Λ²`**, the cubic form the programme maximises, with its domain
changed to the one where the pairing under it is definite. -/
noncomputable def Pcubic2 (R : CurvOp2 ι) : ℝ := trCube2 R + sharpPair2 R

/-- **`P` splits as the record splits it.** *This is `rfl` and carries no content, the split being
the definition* ([r1008](../../../reviews/REVIEW_r1008.md)). **`sharpPair2` inlines the pairing
rather than calling `innerOp2`**, so the record's `P = ⟨R, Q(R)⟩` has no analogue here until a
`Qop` is transported. -/
theorem Pcubic2_eq (R : CurvOp2 ι) : Pcubic2 R = trCube2 R + sharpPair2 R := rfl

/-- **`θ` on `Λ²`**, the record's `theta` with the domain changed. *[r1009](../../../reviews/REVIEW_r1009.md)
found the layer carrying no `θ` here, so a threshold hypothesis written as `t < Pcubic2 R` was the
item's `θ > t` only by an identity nothing stated.* -/
noncomputable def theta2 (R : CurvOp2 ι) : ℝ := Pcubic2 R / Real.sqrt (normSq2 R) ^ 3

/-- **At unit norm `θ` IS `P`**, which is what makes a threshold on one a threshold on the other. -/
theorem theta2_of_unit {R : CurvOp2 ι} (h : normSq2 R = 1) : theta2 R = Pcubic2 R := by
  unfold theta2
  rw [h, Real.sqrt_one, one_pow, div_one]

end Sharp

/-! ## The norm that makes Fermat's theorem apply

**[r1007](../../../reviews/REVIEW_r1007.md) pinned the blocker to a named theorem**:
`IsLocalMaxOn.fderivWithin_nonpos` and its siblings sit under `[NormedAddCommGroup E]
[NormedSpace ℝ E]`, so the step from a local maximiser to a critical point is unavailable at an
operator type carrying no norm.

**It takes three registrations and no new mathematics.** *Mathlib's matrix norms are scoped, and
the Frobenius one has topology DEFEQ to the instance already on `Matrix`, so opening it creates no
diamond. `skewSub` inherits from the submodule, and `ContinuousLinearMap`'s own seminormed and
normed structures then apply to the operators.*

**The instances exist and instance SEARCH does not reach them**, which is why an earlier attempt
read as a missing import and then as library plumbing. *Naming them is the whole repair.*
-/

section Fermat

open scoped Matrix.Norms.Frobenius

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-! **THESE ARE SCOPED, AND A FIRST VERSION REGISTERED THEM GLOBALLY**
([r1008](../../../reviews/REVIEW_r1008.md)). *Their value comes from a SCOPED matrix norm, so a
global registration left `Norm (CurvOp2 ι)` synthesizing outside the scope while
`Norm (skewSub ι)` did not: the operators carried a norm their own domain lacked.*

**The norm they carry is the SUP OPERATOR norm and NOT the record's**: `‖id‖ = 1` against
`normSq2 id = ½n(n-1)`, so `‖R‖ = 1` and `normSq2 R = 1` are different spheres from `n = 3`. *They
are here to discharge Fermat's typeclass hypotheses and for nothing else, and no statement below
reads `‖·‖`.*

**The repair that would close both at once** is an `InnerProductSpace ℝ (CurvOp2 ι)` over
`innerOp2`, whose definiteness is `normSq2_eq_zero` above, built with
`toNormedAddCommGroupOfTopology` so the existing topology is kept. -/

namespace OperatorNorm

/-- **The operators, normed.** -/
noncomputable scoped instance : NormedAddCommGroup (CurvOp2 ι) :=
  ContinuousLinearMap.toNormedAddCommGroup

/-- **And a normed space over `ℝ`**, which is Fermat's other hypothesis. -/
noncomputable scoped instance : NormedSpace ℝ (CurvOp2 ι) := ContinuousLinearMap.toNormedSpace

end OperatorNorm

open scoped OperatorNorm

/-- **`R#` AS A `CurvOp2`**, the type both sides of the eigen-equation live in. *`sharpMapL` is
`→ₗ[ℝ]` where `CurvOp2` is `→L[ℝ]`, so the bundled linear map did not inhabit the type its consumer
needs* ([r1011](../../../reviews/REVIEW_r1011.md)). **Finite dimensionality supplies the
continuity**, as it does for `restrict` below. -/
noncomputable def sharpMapCL (R : CurvOp2 ι) : CurvOp2 ι :=
  LinearMap.toContinuousLinearMap (sharpMapL R)

/-- **And it computes `sharpMap`**, so nothing changed but the type. -/
theorem sharpMapCL_apply (R : CurvOp2 ι) (X : skewSub ι) : sharpMapCL R X = sharpMap R X := rfl

/-- **HAMILTON'S MAP ON `Λ²`**, `Q(R) = R² + R#`, as an OPERATOR. *Both summands are `CurvOp2`,
which is what `sharpMapCL` buys*, so the criticality equation below is an equation between
operators rather than the family of equations on the `φ` that the record's `IsCritical` has to use.
-/
noncomputable def Qop2 (R : CurvOp2 ι) : CurvOp2 ι := compOp2 R + sharpMapCL R

/-- **`Q(R)` on the basis splits into its two summands.** -/
theorem applyPhi_Qop2 (R : CurvOp2 ι) (i j : ι) :
    applyPhi (Qop2 R) i j
      = applyPhi (compOp2 R) i j
        + ((sharpMap R ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ) := rfl

/-- **`P(R) = ⟨R, Q(R)⟩`**, the cubic form as a pairing against Hamilton's map.
*[Pcubic2_eq](Bivectors2.lean) gives it as a SUM of two scalars, which is not a shape a criticality
equation can be read out of: the record's `IsCritical` exists because `Pcubic = ⟨R, Qop R⟩` holds
there, and this is that identity on `Λ²`.* -/
theorem Pcubic2_eq_innerOp2 (R : CurvOp2 ι) : Pcubic2 R = innerOp2 R (Qop2 R) := by
  have h : innerOp2 R (Qop2 R) = innerOp2 R (compOp2 R) + sharpPair2 R := by
    unfold innerOp2 sharpPair2
    rw [← mul_add, ← Finset.sum_add_distrib]
    congr 1
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [applyPhi_Qop2, inner2_add_right]
  rw [h, Pcubic2_eq]
  unfold trCube2
  rw [innerOp2_comm]

/-- **THE EIGEN-EQUATION `Q(R) = th·R`**, as an equation in `CurvOp2`. *The record states the same
equation pointwise on the `φ` family, which is what an unbundled `R#` forces.*

**IT IS NAMED FOR CRITICALITY AND NOTHING ON FILE CONNECTS IT TO A CRITICAL POINT OF `P`, AND A
FIRST VERSION OF THIS DOCSTRING ASSERTED THAT IT WAS ONE** ([r1012](../../../reviews/REVIEW_r1012.md)).
*That link is Fermat's theorem applied to `Pcubic2` on `{normSq2 = 1}`, which needs the full first
variation `DP(R)[S] = 3⟨S, Q(R)⟩` and the differentiability of `Pcubic2`, both owed.* -/
def IsCritical2 (R : CurvOp2 ι) (th : ℝ) : Prop := Qop2 R = th • R

/-- **A record-Weyl bare operator, RESTRICTED to `Λ²` as a bundled operator.** *`isWeyl_add` and
`isWeyl_smul` supply the linearity, which `IsWeyl` forces rather than assumes, and finite
dimensionality supplies the continuity.* **This is the converse direction
[r1009](../../../reviews/REVIEW_r1009.md) found the layer carrying only one half of.** -/
noncomputable def restrict {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl R) : CurvOp2 ι :=
  LinearMap.toContinuousLinearMap
    { toFun := fun X => ⟨R (X : Matrix ι ι ℝ), hW.1 _ X.2⟩
      map_add' := fun X Y => Subtype.ext (isWeyl_add hW X.2 Y.2)
      map_smul' := fun c X => Subtype.ext (isWeyl_smul hW c X.2) }

/-- **It agrees with `R` on `Λ²`**, which is what makes it a restriction. -/
theorem restrict_apply {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl R) (X : skewSub ι) :
    ((restrict hW X : skewSub ι) : Matrix ι ι ℝ) = R (X : Matrix ι ι ℝ) := rfl

/-- **AND IT IS `IsWeyl2`**, so the two classes match in both directions. -/
theorem isWeyl2_restrict {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl R) :
    IsWeyl2 (restrict hW) where
  selfAdjoint X Y := hW.2.1 _ _ X.2 Y.2
  bianchi i j k l := hW.2.2.1 i j k l
  ric a b := hW.2.2.2 a b

/-- **FERMAT'S THEOREM AT A CURVATURE OPERATOR ON `Λ²`.** *At a local maximum of `f` on `s`, the
derivative is nonpositive along every direction of the positive tangent cone. This is the step
[I75](../../../plan.md) and hence [I36](../../../plan.md) wait on, and it was unavailable at every
operator type the layer carried.* -/
theorem isLocalMaxOn_fderivWithin_nonpos {f : CurvOp2 ι → ℝ} {s : Set (CurvOp2 ι)}
    {a y : CurvOp2 ι} (h : IsLocalMaxOn f s a) (hy : y ∈ posTangentConeAt s a) :
    (fderivWithin ℝ f s a : CurvOp2 ι → ℝ) y ≤ 0 :=
  h.fderivWithin_nonpos hy

/-- **And the two-sided form**, which is criticality in the directions the cone contains both ways. -/
theorem isLocalMaxOn_fderivWithin_eq_zero {f : CurvOp2 ι → ℝ} {s : Set (CurvOp2 ι)}
    {a y : CurvOp2 ι} (h : IsLocalMaxOn f s a) (hy : y ∈ posTangentConeAt s a)
    (hy' : -y ∈ posTangentConeAt s a) : (fderivWithin ℝ f s a : CurvOp2 ι → ℝ) y = 0 :=
  h.fderivWithin_eq_zero hy hy'

/-! **THE TWO ABOVE ARE TRUE AND UNUSABLE ON THE CONSTRAINT SET**
([r1012](../../../reviews/REVIEW_r1012.md)). *`fderivWithin` names ONE derivative chosen by
`Classical.choice`, and on `{normSq2 = 1}` it is not the only one: with `B` the pairing and
`B(a,a) = 1`, every `x` in the set has `B(x-a, a) = B(x,a) - 1 = -½ B(x-a, x-a)`, so the linear
functional `B(·, a)` is `o(‖x-a‖)` ALONG the set and can be added to any within-derivative.*
**`UniqueDiffWithinAt` therefore fails there**, the tangent cone spanning a hyperplane rather than
the space, so nothing said about `fderivWithin ℝ Pcubic2 s R` transfers to a derivative one has
computed. **The usable form takes the derivative as a hypothesis**, and is below. -/

/-- **FERMAT AT A GIVEN DERIVATIVE**, which is the form a computed `DP` can be fed to. -/
theorem isLocalMaxOn_hasFDerivWithinAt_nonpos {f : CurvOp2 ι → ℝ} {s : Set (CurvOp2 ι)}
    {a y : CurvOp2 ι} {f' : StrongDual ℝ (CurvOp2 ι)} (h : IsLocalMaxOn f s a)
    (hf : HasFDerivWithinAt f f' s a) (hy : y ∈ posTangentConeAt s a) : f' y ≤ 0 :=
  h.hasFDerivWithinAt_nonpos hf hy

/-- **And its two-sided form.** -/
theorem isLocalMaxOn_hasFDerivWithinAt_eq_zero {f : CurvOp2 ι → ℝ} {s : Set (CurvOp2 ι)}
    {a y : CurvOp2 ι} {f' : StrongDual ℝ (CurvOp2 ι)} (h : IsLocalMaxOn f s a)
    (hf : HasFDerivWithinAt f f' s a) (hy : y ∈ posTangentConeAt s a)
    (hy' : -y ∈ posTangentConeAt s a) : f' y = 0 :=
  h.hasFDerivWithinAt_eq_zero hf hy hy'

end Fermat

end HamiltonsCubic.RealLayer
