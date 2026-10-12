import HamiltonsCubic.Base.Families
import HamiltonsCubic.Base.Bivectors2
import HamiltonsCubic.Base.WeylModule
import HamiltonsCubic.Results.L94Statement

set_option linter.style.longLine false

/-!
# [I108](../../../plan.md): the bridge between the two Lean layers

**The layers did not meet.** [L94Statement.lean](L94Statement.lean)'s objects live on `Tensor4 n`,
four-index arrays, carrying `κ²`, `normM2`, `IsFrame`, `rotate` and `CoordinateDiagonal`. The
record's `θ`, `P`, `‖·‖` and the whole diagonal-locus development live on OPERATORS,
`Matrix ι ι ℝ → Matrix ι ι ℝ`. *Three files mentioned `Tensor4` and none of them mentioned
`RealLayer`, so no declaration converted one to the other.*

**`toTensor R a b c d = ⟨R φ_ab, φ_cd⟩` is the map**, and the correspondence is closer than the
separation suggested: **the operator layer's `bianchi` clause IS the tensor layer's Bianchi identity
term for term**, and its `Ric = 0` is the tensor layer's tracelessness once `φ_ba = -φ_ab` is used
twice.

**LINEARITY IS NOT NEEDED, and a first version of this file asserted that it was**
([r1003](../../../reviews/REVIEW_r1003.md)). *Antisymmetry in the first pair looks like it wants
`R(-X) = -R X`, and `RealLayer.IsWeyl` supplies the whole of it on its own*: with
`Z = R φ_ba + R φ_ab`, which is skew by the first clause, self-adjointness at `(φ_ba, Z)` and
`(φ_ab, Z)` together with `φ_ba + φ_ab = 0` give `⟨Z, Z⟩ = 0`, and that pairing is a sum of squares
over `ℝ`. **So `Z = 0`.** *Dropping the hypothesis also lets the bridge consume `diagOp_isWeyl`
directly, and removes the [FoxProduct.lean](../Base/FoxProduct.lean) import.*
-/

namespace HamiltonsCubic.TensorBridge

open HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L94Statement

variable {n : ℕ}

/-- **The four-index tensor of a curvature operator**, `W_abcd = ⟨R φ_ab, φ_cd⟩`. -/
noncomputable def toTensor (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) : Tensor4 n :=
  fun a b c d => inner2 (R (phi a b)) (phi c d)

variable {R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ}

/-- **`R φ_ba = -R φ_ab` FROM `IsWeyl` ALONE**, with no linearity.
*[r1003](../../../reviews/REVIEW_r1003.md) found the linearity hypothesis a first version carried
here to be unnecessary, and this is the argument.* **`Z = R φ_ba + R φ_ab` is skew by the first
clause**, which is why BOTH of `IsWeyl`'s first two clauses are used and not the second alone
([r1004](../../../reviews/REVIEW_r1004.md)). *Self-adjointness at `(φ_ba, Z)` and at `(φ_ab, Z)` turns `⟨Z, Z⟩` into
`⟨φ_ba + φ_ab, R Z⟩`, which is `⟨0, R Z⟩`, and `⟨·,·⟩` is a sum of squares over `ℝ`.* -/
theorem Rphi_swap (hW : IsWeyl R) (a b : Fin n) : R (phi b a) = -R (phi a b) := by
  set Z := R (phi b a) + R (phi a b) with hZ
  have hskew : IsSkew Z := by
    have h1 : Matrix.transpose (R (phi b a)) = -R (phi b a) := hW.1 _ (phi_isSkew b a)
    have h2 : Matrix.transpose (R (phi a b)) = -R (phi a b) := hW.1 _ (phi_isSkew a b)
    show Matrix.transpose Z = -Z
    rw [hZ, Matrix.transpose_add, h1, h2]
    abel
  have hzero : inner2 Z Z = 0 := by
    have e1 : inner2 Z Z = inner2 (R (phi b a)) Z + inner2 (R (phi a b)) Z := by
      nth_rewrite 2 [hZ]
      rw [inner2_add_right, inner2_comm Z, inner2_comm Z]
    rw [e1, hW.2.1 _ _ (phi_isSkew b a) hskew, hW.2.1 _ _ (phi_isSkew a b) hskew,
      inner2_comm, inner2_comm (phi a b), ← inner2_add_right, phi_swap a b]
    simp [inner2]
  have hZ0 : Z = 0 := by
    have hsum : ∑ p : Fin n, ∑ q : Fin n, (Z p q) ^ 2 = 0 := by
      have h := hzero
      rw [inner2_eq_sum] at h
      have h2 : ∑ p : Fin n, ∑ q : Fin n, Z p q * Z p q = 0 := by linarith
      rw [← h2]
      exact Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => sq (Z p q)
    ext p q
    have hnn : ∀ x ∈ (Finset.univ : Finset (Fin n)), 0 ≤ ∑ y : Fin n, (Z x y) ^ 2 :=
      fun x _ => Finset.sum_nonneg fun y _ => sq_nonneg _
    have hrow := (Finset.sum_eq_zero_iff_of_nonneg hnn).mp hsum p (Finset.mem_univ p)
    have hpt := (Finset.sum_eq_zero_iff_of_nonneg
      (fun y (_ : y ∈ (Finset.univ : Finset (Fin n))) => sq_nonneg (Z p y))).mp hrow q
      (Finset.mem_univ q)
    simpa using pow_eq_zero_iff (n := 2) (by norm_num) |>.mp hpt
  rw [hZ] at hZ0
  exact add_eq_zero_iff_eq_neg.mp hZ0

/-- **Antisymmetry in the first pair**, from `Rphi_swap`. -/
theorem toTensor_antisym12 (hW : IsWeyl R) (a b c d : Fin n) :
    toTensor R a b c d = -toTensor R b a c d := by
  unfold toTensor
  rw [Rphi_swap hW b a]
  simp [inner2, Matrix.transpose_neg, Matrix.neg_mul, Matrix.mul_neg, Matrix.trace_neg]

/-- **Antisymmetry in the second pair**, from `φ_dc = -φ_cd` alone. -/
theorem toTensor_antisym34 (a b c d : Fin n) :
    toTensor R a b c d = -toTensor R a b d c := by
  unfold toTensor
  rw [phi_swap c d]
  simp [inner2, Matrix.transpose_neg, Matrix.neg_mul, Matrix.mul_neg, Matrix.trace_neg]

/-- **Pair symmetry is the self-adjointness clause**, read through `inner2_comm`. -/
theorem toTensor_pairSym (hW : IsWeyl R) (a b c d : Fin n) :
    toTensor R a b c d = toTensor R c d a b := by
  unfold toTensor
  rw [hW.2.1 _ _ (phi_isSkew a b) (phi_isSkew c d), inner2_comm]

/-- **Bianchi is the operator layer's own `bianchi` clause**, term for term. -/
theorem toTensor_bianchi (hW : IsWeyl R) (a b c d : Fin n) :
    toTensor R a b c d + toTensor R a c d b + toTensor R a d b c = 0 :=
  hW.2.2.1 a b c d

/-- **Tracelessness is `Ric = 0`**, once `φ_ba = -φ_ab` is used on both slots. *The index orders
differ: `Ric` contracts the SECOND index of each `φ` and the tensor layer contracts slots 1 and 3,
so the double swap below is the permutation between them and is written in the open.* -/
theorem toTensor_traceless (hW : IsWeyl R) (b d : Fin n) :
    ∑ a : Fin n, toTensor R a b a d = 0 := by
  have hstep : ∀ a : Fin n, toTensor R a b a d = inner2 (R (phi b a)) (phi d a) := by
    intro a
    unfold toTensor
    rw [Rphi_swap hW a b, phi_swap d a]
    simp [inner2, Matrix.transpose_neg, Matrix.neg_mul, Matrix.mul_neg, Matrix.trace_neg]
  rw [Finset.sum_congr rfl fun a _ => hstep a]
  exact hW.2.2.2 b d

/-- **I108, THE BRIDGE.** *Every Weyl operator's four-index tensor is a Weyl tensor in
[L94Statement.lean](L94Statement.lean)'s sense, so `κ²`, `normM2` and coordinate-diagonality are
all defined at it and L94 applies to the record's own objects.* -/
theorem isWeyl_toTensor (hW : IsWeyl R) : HamiltonsCubic.L94Statement.IsWeyl (toTensor R) where
  antisym12 := toTensor_antisym12 hW
  antisym34 := toTensor_antisym34
  pairSym := toTensor_pairSym hW
  bianchi := toTensor_bianchi hW
  traceless := toTensor_traceless hW

/-- **THE BRIDGE IS AN ISOMETRY**, `‖R‖² = normM2 (toTensor R)`, with no factor.
*[r1003](../../../reviews/REVIEW_r1003.md) named this as the piece the first version omitted:
without it L94's `normM2 W = 1` and the record's `‖R‖² = 1` are two unrelated unit spheres, and
every statement carrying a unit-norm hypothesis across the bridge is void.* **What it pins is that
`inner2`'s constant EQUALS `innerOp`'s, not that either is a half**
([r1004](../../../reviews/REVIEW_r1004.md)): it holds verbatim under plain Frobenius at both
levels, and rescaling `inner2` alone breaks it, the tensor side moving as the square.

*`sum_inner2_phi` collapses the inner pair of sums to `2⟨R φ_ab, R φ_ab⟩`, `normM2_quarter` turns
the outer pair into `normSq`, and the four cancels.* -/
theorem normM2_toTensor (hW : IsWeyl R) : normM2 (toTensor R) = normSq R := by
  have hskew : ∀ a b : Fin n, IsSkew (R (phi a b)) := fun a b => hW.1 _ (phi_isSkew a b)
  have hinner : ∀ a b : Fin n,
      (∑ c : Fin n, ∑ d : Fin n, (toTensor R a b c d) ^ 2)
        = 2 * inner2 (R (phi a b)) (R (phi a b)) := by
    intro a b
    have := sum_inner2_phi (R (phi a b)) (R (phi a b)) (hskew a b) (hskew a b)
    rw [← this]
    exact Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => sq (toTensor R a b c d)
  have hS : ∑ a : Fin n, ∑ b : Fin n, 2 * inner2 (R (phi a b)) (R (phi a b))
      = 2 * ∑ a : Fin n, ∑ b : Fin n, inner2 (R (phi a b)) (R (phi a b)) := by
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun a _ => (Finset.mul_sum _ _ _).symm
  have hfull : full4 (toTensor R) = 4 * normSq R := by
    unfold full4 normSq innerOp
    rw [Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => hinner a b, hS]
    ring
  have hq := normM2_quarter (toTensor R) (toTensor_antisym12 hW) (toTensor_antisym34)
  rw [hfull] at hq
  linarith

/-! ## Why this file does NOT restate the bridge over the bundled operators

**A version of it did, and [r1004](../../../reviews/REVIEW_r1004.md) refuted the reason.** *Five
declarations over `CurvLin`, every one the same theorem retyped, and strictly weaker as a universal
statement because `CurvLin` is a subtype of the bare functions.*

**The premise was that bundling supplies the topology local-maximality needs. It does not.**
`TopologicalSpace (CurvLin (Fin 4))` fails to synthesize, Mathlib carrying a topology on
`ContinuousLinearMap` and not on `LinearMap`, so `IsLocalMaxOn` cannot be written over the bundled
type at all and finite-dimensionality supplies nothing on its own.

**What [I36](../../../plan.md) actually owes is an ambient space**, the endomorphisms of the SKEW
subspace rather than of all matrices, *which is also what would make `innerOp` definite*. See
[WeylRadical.lean](WeylRadical.lean) for why the present one cannot serve.
-/

/-! ## The bridge from `CurvOp2`, which is the type [I36](../../../plan.md) is stated over

**`toTensor` takes a BARE function, so it does not apply to an operator whose domain is `Λ²`.**
*[r1008](../../../reviews/REVIEW_r1008.md) observed that the gap closes through a canonical
extension by the skew projection, rather than needing a second construction.*

**And the extension makes every transport hypothesis of this file non-vacuous**, since it exhibits,
for each `CurvOp2` operator, a bare function agreeing with it on `Λ²`.
-/

section FromCurvOp2

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The skew projection**, `X ↦ ½(X - Xᵀ)`. -/
noncomputable def skewProj (X : Matrix ι ι ℝ) : Matrix ι ι ℝ :=
  (2⁻¹ : ℝ) • (X - Matrix.transpose X)

theorem skewProj_mem (X : Matrix ι ι ℝ) : skewProj X ∈ skewSub ι := by
  show Matrix.transpose (skewProj X) = -skewProj X
  unfold skewProj
  rw [Matrix.transpose_smul, Matrix.transpose_sub, Matrix.transpose_transpose, ← smul_neg]
  congr 1
  abel

/-- **It is the identity on `Λ²`**, which is what makes the extension an extension. -/
theorem skewProj_eq_self {X : Matrix ι ι ℝ} (hX : IsSkew X) : skewProj X = X := by
  unfold skewProj
  rw [show Matrix.transpose X = -X from hX, sub_neg_eq_add]
  rw [show X + X = (2 : ℝ) • X from (two_smul ℝ X).symm, smul_smul]
  norm_num

/-- **A `CurvOp2` operator as a bare function**, by precomposing with the projection. -/
noncomputable def extend (R : CurvOp2 ι) : Matrix ι ι ℝ → Matrix ι ι ℝ :=
  fun X => ((R ⟨skewProj X, skewProj_mem X⟩ : skewSub ι) : Matrix ι ι ℝ)

/-- **THE EXTENSION AGREES WITH `R` ON `Λ²`**, which is the whole of what it is for. -/
theorem extend_apply (R : CurvOp2 ι) (X : skewSub ι) :
    extend R (X : Matrix ι ι ℝ) = ((R X : skewSub ι) : Matrix ι ι ℝ) := by
  unfold extend
  congr 2
  exact Subtype.ext (skewProj_eq_self X.2)

variable {n : ℕ}

/-- **The four-index tensor of a `CurvOp2` operator.** -/
noncomputable def toTensor2 (R : CurvOp2 (Fin n)) : Tensor4 n := toTensor (extend R)

/-- **And it reads the operator on the `φ` family directly**, the extension being the identity
there. -/
theorem toTensor2_apply (R : CurvOp2 (Fin n)) (a b c d : Fin n) :
    toTensor2 R a b c d = inner2 (applyPhi R a b) (phi c d) := by
  show inner2 (extend R (phi a b)) (phi c d) = _
  rw [show extend R (phi a b)
      = ((R ⟨phi a b, phi_mem_skewSub a b⟩ : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) from
    extend_apply R ⟨phi a b, phi_mem_skewSub a b⟩]

/-- **`IsWeyl2` GIVES THE RECORD'S `IsWeyl` ON THE EXTENSION**, so the native class is not a weaker
thing wearing the same name. *Clause one holds because the extension lands in `Λ²` by construction,
and the other three are the native clauses read through `extend_apply`.* -/
theorem isWeyl_extend {R : CurvOp2 ι} (h : IsWeyl2 R) :
    HamiltonsCubic.RealLayer.IsWeyl (extend R) := by
  have hphi : ∀ i j : ι, extend R (phi i j) = applyPhi R i j := fun i j =>
    extend_apply R ⟨phi i j, phi_mem_skewSub i j⟩
  refine ⟨fun X _ => (R ⟨skewProj X, skewProj_mem X⟩).2, fun X Y hX hY => ?_,
    fun i j k l => ?_, fun a b => ?_⟩
  · rw [show extend R X = ((R ⟨X, hX⟩ : skewSub ι) : Matrix ι ι ℝ) from
      extend_apply R ⟨X, hX⟩,
      show extend R Y = ((R ⟨Y, hY⟩ : skewSub ι) : Matrix ι ι ℝ) from
      extend_apply R ⟨Y, hY⟩]
    exact h.selfAdjoint ⟨X, hX⟩ ⟨Y, hY⟩
  · show inner2 (extend R (phi i j)) (phi k l) + inner2 (extend R (phi i k)) (phi l j)
        + inner2 (extend R (phi i l)) (phi j k) = 0
    rw [hphi, hphi, hphi]
    exact h.bianchi i j k l
  · show ∑ c : ι, inner2 (extend R (phi a c)) (phi b c) = 0
    rw [Finset.sum_congr rfl fun c _ => by rw [hphi a c]]
    exact h.ric a b

/-- **`normSq` of the extension IS `normSq2`**, which is the link [r1009](../../../reviews/REVIEW_r1009.md)
found absent and which turns `I36Budget`'s right-hand side into [L174](L174.lean)'s `κ² = 2`. -/
theorem normSq_extend (R : CurvOp2 ι) :
    HamiltonsCubic.RealLayer.normSq (extend R) = normSq2 R := by
  unfold HamiltonsCubic.RealLayer.normSq HamiltonsCubic.RealLayer.innerOp normSq2 innerOp2
  congr 1
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  rw [show extend R (phi i j) = applyPhi R i j from
    extend_apply R ⟨phi i j, phi_mem_skewSub i j⟩]

/-- **`restrict` UNDOES `extend`**, which is one half of a round trip. -/
theorem restrict_extend {R : CurvOp2 ι} (h : IsWeyl2 R) :
    restrict (isWeyl_extend h) = R := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  exact extend_apply R X

/-! **THE OTHER HALF FAILS, AND THAT IS THE RIGHT ANSWER**
([r1010](../../../reviews/REVIEW_r1010.md)). *`extend (restrict hW)` is `R ∘ skewProj`, which
agrees with `R` on `Λ²` and need not agree off it: at `n = 2` the operator sending every skew matrix
to `0` and everything else to `1` differs from its own re-extension at the identity.* **So the pair
is a retraction and a section rather than an isomorphism**, which is what it should be, `Λ²` being
a proper subspace and the record's operators carrying values off it that no clause reads. -/

/-! ### [I36](../../../plan.md), STATED

**The item has been unstatable in Lean for as long as it has existed**, and every piece of that is
now in place: the operators have a domain where the pairing is definite, `P` and the norm are
transported there, Fermat applies, and the tensor bridge carries coordinate-diagonality across.
-/

/-- **I36's shape claim, as a Lean proposition.** *Every unit local maximiser of `P` above the
threshold is coordinate-diagonal in some frame.*

**This is a STATEMENT and not a theorem**, and nothing here proves it. *What it settles is that the
claim can be written at a type where its hypotheses mean what the record means: the norm is
`normSq2`, definite by `normSq2_eq_zero`; local maximality is Mathlib's, and Fermat applies to it by
`isLocalMaxOn_fderivWithin_nonpos`; and coordinate-diagonality is
[L94Statement.lean](L94Statement.lean)'s, reached through `toTensor2`.*

**IT CARRIES `IsWeyl2`**, the class native to this domain, which `isWeyl_extend` above shows gives
the record's `IsWeyl` on the extension, *so the quantifier ranges over the Weyl operators and not
over every continuous-linear map*. **[r1008](../../../reviews/REVIEW_r1008.md) named that as the
gap**, and [WeylReal.lean](../Base/WeylReal.lean) records that getting the range wrong once made
`ProblemP` a false proposition. *`IsWeyl2` has three clauses where the record has four: the first,
that bivectors go to bivectors, is the type.*

**AND IT IS NEITHER WIDER NOR NARROWER THAN THE RECORD'S CLASS**
([r1009](../../../reviews/REVIEW_r1009.md)): *the record's `IsWeyl` forces `ℝ`-linearity on `Λ²`
from its first two clauses alone, by the same argument `Rphi_swap` uses, so every record-Weyl bare
operator restricts here.* **The layer carries only the forward direction**, `isWeyl_extend`, so that
assurance is one-directional as committed.

**TWO FACTS THE STATEMENT DEPENDS ON AND DID NOT SAY.** *The threshold's STRICTNESS is
load-bearing: padded `W_{ℂP²}` is a local maximum at `√(3/2)` EXACTLY, so at `t ≥ θ` the claim is
false.* **And the hypotheses are empty at `n ≤ 3`**, where `dim 𝒲ₙ = 0`, so `I36Shape n t` is
vacuously true there. *At `n ≥ 4` r1009 exhibited a witness, the restriction of
`diagOp ((√12)⁻¹ • sphereWeight {0,1})`.* -/
def I36Shape (n : ℕ) (t : ℝ) : Prop :=
  ∀ R : CurvOp2 (Fin n), IsWeyl2 R → normSq2 R = 1 →
    IsLocalMaxOn Pcubic2 {S : CurvOp2 (Fin n) | IsWeyl2 S ∧ normSq2 S = 1} R →
    t < Pcubic2 R →
    ∃ F : Fin n → Fin n → ℝ, IsFrame F ∧ CoordinateDiagonal (rotate F (toTensor2 R))

/-- **The form with the maximum taken over the FULL sphere**, which is what a first version of
`I36Shape` stated. *[r1009](../../../reviews/REVIEW_r1009.md) confirmed the sphere as the record's
and did not consider the missing clause.* -/
def I36ShapeFullSphere (n : ℕ) (t : ℝ) : Prop :=
  ∀ R : CurvOp2 (Fin n), IsWeyl2 R → normSq2 R = 1 →
    IsLocalMaxOn Pcubic2 {S : CurvOp2 (Fin n) | normSq2 S = 1} R →
    t < Pcubic2 R →
    ∃ F : Fin n → Fin n → ℝ, IsFrame F ∧ CoordinateDiagonal (rotate F (toTensor2 R))

/-- **AND `I36Shape` IMPLIES IT**, which is the direction that settles which one is the target.
*Restricting the constraint set WEAKENS the local-maximality hypothesis, since there are fewer
competitors to beat, so the Weyl-sphere form is the STRONGER statement and the full-sphere form
follows from it.* **A first version stated only the full-sphere form**, which is implied by the
record's item and does not imply it. -/
theorem I36Shape_imp_fullSphere (n : ℕ) (t : ℝ) : I36Shape n t → I36ShapeFullSphere n t := by
  intro h R hW hN hmax ht
  exact h R hW hN (hmax.on_subset (fun S hS => hS.2)) ht

/-- **The budget form**, which [L174.lean](L174.lean)'s `shape_iff_budget` pairs with the shape. -/
def I36Budget (n : ℕ) (t : ℝ) : Prop :=
  ∀ R : CurvOp2 (Fin n), IsWeyl2 R → normSq2 R = 1 →
    IsLocalMaxOn Pcubic2 {S : CurvOp2 (Fin n) | IsWeyl2 S ∧ normSq2 S = 1} R →
    t < Pcubic2 R → kappaSq (toTensor2 R) = 2 * normM2 (toTensor2 R)

end FromCurvOp2

end HamiltonsCubic.TensorBridge
